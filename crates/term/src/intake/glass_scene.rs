//! The scene wire: a versioned JSON envelope the program writes, mapped
//! onto the window's scene types. The window's own types can change
//! behind this; every field here is pinned (type, range, default) in
//! docs/GLASS_DIALECT.md.
//!
//! ```text
//! {"v":1,"scene":{"camera":{...},"nodes":[...]}}
//! ```

use angel_glass::scene::{
    Camera, Material, MeshData, MeshRef, Node, Projection, Scene, Transform,
};

/// Decoded payload cap. Checked before the JSON tree is built.
pub const SCENE_BYTES: usize = 1 << 20;
/// Nodes in one scene. Under the window's own node cap.
pub const SCENE_NODES: usize = 256;
/// Inline vertices across one scene.
pub const SCENE_VERTICES: usize = 4_096;
/// Inline indices across one scene.
pub const SCENE_INDICES: usize = 12_288;
/// A scene target, a video frame, or a showcase panel, on a side.
pub const SIZE_MAX: u32 = 2_048;

/// A parsed scene plus the inline meshes its nodes name by index
/// (`MeshRef::Uploaded(i)` is a placeholder until the store mints ids).
#[derive(Debug)]
pub struct Wired {
    pub scene: Scene,
    /// Parallel to the placeholder upload indices.
    pub meshes: Vec<MeshData>,
}

#[derive(Debug)]
pub struct WireError {
    pub code: &'static str,
    pub message: String,
}

impl WireError {
    fn new(code: &'static str, message: impl Into<String>) -> Self {
        Self { code, message: message.into() }
    }
}

/// Parse one envelope. `bytes` is the decoded payload; the caller has
/// already enforced [`SCENE_BYTES`].
pub fn parse(bytes: &[u8]) -> Result<Wired, WireError> {
    if bytes.len() > SCENE_BYTES {
        return Err(WireError::new("EFBIG", format!("scene payload is capped at {SCENE_BYTES} bytes")));
    }
    let text = std::str::from_utf8(bytes)
        .map_err(|_| WireError::new("EBADF", "scene payload is not utf-8"))?;
    let value: serde_json::Value = serde_json::from_str(text)
        .map_err(|_| WireError::new("EBADF", "scene payload is not json"))?;
    let obj = value.as_object().ok_or_else(|| WireError::new("EINVAL", "scene envelope is not an object"))?;
    unknown(obj, &["v", "scene"], "envelope")?;
    let v = obj.get("v").ok_or_else(|| WireError::new("EINVAL", "scene envelope needs v"))?;
    if v.as_u64() != Some(1) {
        return Err(WireError::new("EINVAL", "scene envelope v must be 1"));
    }
    let scene = obj
        .get("scene")
        .and_then(|s| s.as_object())
        .ok_or_else(|| WireError::new("EINVAL", "scene envelope needs a scene object"))?;
    unknown(scene, &["camera", "nodes"], "scene")?;
    let camera = match scene.get("camera") {
        None => Camera::default(),
        Some(c) => camera_of(c)?,
    };
    let nodes_v = scene.get("nodes").cloned().unwrap_or(serde_json::Value::Array(Vec::new()));
    let nodes_a = nodes_v.as_array().ok_or_else(|| WireError::new("EINVAL", "scene nodes is not an array"))?;
    if nodes_a.len() > SCENE_NODES {
        return Err(WireError::new("EFBIG", format!("a scene is capped at {SCENE_NODES} nodes")));
    }
    let mut nodes = Vec::with_capacity(nodes_a.len());
    let mut meshes = Vec::new();
    let mut vertices = 0usize;
    let mut indices = 0usize;
    for (i, node) in nodes_a.iter().enumerate() {
        nodes.push(node_of(node, i, &mut meshes, &mut vertices, &mut indices)?);
    }
    check_graph(&nodes)?;
    Ok(Wired { scene: Scene { camera, nodes, look: None }, meshes })
}

fn unknown(
    obj: &serde_json::Map<String, serde_json::Value>,
    allowed: &[&str],
    where_: &str,
) -> Result<(), WireError> {
    for key in obj.keys() {
        if !allowed.contains(&key.as_str()) {
            return Err(WireError::new("EINVAL", format!("unknown {where_} field {key}")));
        }
    }
    Ok(())
}

fn camera_of(value: &serde_json::Value) -> Result<Camera, WireError> {
    let obj = value.as_object().ok_or_else(|| WireError::new("EINVAL", "camera is not an object"))?;
    unknown(obj, &["eye", "target", "up", "fov", "near", "far", "clear", "ortho"], "camera")?;
    let eye = vec3(obj.get("eye"), "camera eye", [0.0, 0.0, 3.0])?;
    let target = vec3(obj.get("target"), "camera target", [0.0, 0.0, 0.0])?;
    let up = vec3(obj.get("up"), "camera up", [0.0, 1.0, 0.0])?;
    let fov = f32_of(obj.get("fov"), "camera fov", std::f32::consts::FRAC_PI_4)?;
    let near = f32_of(obj.get("near"), "camera near", 0.1)?;
    let far = f32_of(obj.get("far"), "camera far", 100.0)?;
    if !(fov.is_finite() && fov > 0.0 && fov < std::f32::consts::PI) {
        return Err(WireError::new("EINVAL", "camera fov must be in (0, pi)"));
    }
    if !(near.is_finite() && near > 0.0) {
        return Err(WireError::new("EINVAL", "camera near must be > 0"));
    }
    if !(far.is_finite() && far > near) {
        return Err(WireError::new("EINVAL", "camera far must be past near"));
    }
    let clear = match obj.get("clear") {
        None => Some([0.0; 4]),
        Some(serde_json::Value::Null) => None,
        Some(v) => Some(color4(v, "camera clear")?),
    };
    let rotation = look_rotation(eye, target, up)?;
    let projection = match obj.get("ortho") {
        None => Projection::Perspective { fov_y: fov, near, far },
        Some(v) => {
            let height = num(v, "camera ortho")?;
            if !(height.is_finite() && height > 0.0) {
                return Err(WireError::new("EINVAL", "camera ortho must be > 0"));
            }
            Projection::Orthographic { height, near, far }
        }
    };
    Ok(Camera {
        transform: Transform { translation: eye, rotation, scale: [1.0; 3] },
        projection,
        clear,
    })
}

fn node_of(
    value: &serde_json::Value,
    index: usize,
    meshes: &mut Vec<MeshData>,
    vertices: &mut usize,
    indices: &mut usize,
) -> Result<Node, WireError> {
    let obj = value.as_object().ok_or_else(|| WireError::new("EINVAL", format!("node {} is not an object", index + 1)))?;
    unknown(obj, &["id", "parent", "at", "rot", "scale", "mesh", "color", "visible", "lit", "emissive"], "node")?;
    let id = obj
        .get("id")
        .and_then(|v| v.as_u64())
        .ok_or_else(|| WireError::new("EINVAL", format!("node {} needs an integer id", index + 1)))?;
    let parent = match obj.get("parent") {
        None | Some(serde_json::Value::Null) => None,
        Some(v) => Some(v.as_u64().ok_or_else(|| WireError::new("EINVAL", format!("node {} parent is not an integer", index + 1)))?),
    };
    let translation = vec3(obj.get("at"), "node at", [0.0, 0.0, 0.0])?;
    let rotation = vec4(obj.get("rot"), "node rot", [0.0, 0.0, 0.0, 1.0])?;
    if rotation.iter().all(|v| *v == 0.0) {
        return Err(WireError::new("EINVAL", "node rot must not be zero"));
    }
    let scale = vec3(obj.get("scale"), "node scale", [1.0, 1.0, 1.0])?;
    let color = match obj.get("color") {
        None => [1.0, 1.0, 1.0, 1.0],
        Some(v) => color4(v, "node color")?,
    };
    let visible = match obj.get("visible") {
        None => true,
        Some(serde_json::Value::Bool(b)) => *b,
        Some(_) => return Err(WireError::new("EINVAL", "node visible must be a bool")),
    };
    let lit = match obj.get("lit") {
        None => false,
        Some(serde_json::Value::Bool(b)) => *b,
        Some(_) => return Err(WireError::new("EINVAL", "node lit must be a bool")),
    };
    let emissive = f32_of(obj.get("emissive"), "node emissive", 0.0)?;
    if !(emissive.is_finite() && (0.0..=1.0).contains(&emissive)) {
        return Err(WireError::new("EINVAL", "node emissive must be in 0..1"));
    }
    let mesh = match obj.get("mesh") {
        None | Some(serde_json::Value::Null) => None,
        Some(v) => Some(mesh_of(v, meshes, vertices, indices)?),
    };
    let material = if lit { Material::lit(color, emissive) } else { Material::color(color) };
    Ok(Node {
        id,
        parent,
        transform: Transform { translation, rotation, scale },
        mesh,
        material,
        face_materials: Vec::new(),
        visible,
    })
}

fn mesh_of(
    value: &serde_json::Value,
    meshes: &mut Vec<MeshData>,
    vertices: &mut usize,
    indices: &mut usize,
) -> Result<MeshRef, WireError> {
    if let Some(name) = value.as_str() {
        return named(name);
    }
    let obj = value.as_object().ok_or_else(|| WireError::new("EINVAL", "mesh is not a name or an object"))?;
    unknown(
        obj,
        &["kind", "segments", "steps", "seed", "posts", "positions", "indices", "normals", "uvs", "colors"],
        "mesh",
    )?;
    let kind = obj.get("kind").and_then(|v| v.as_str()).ok_or_else(|| WireError::new("EINVAL", "mesh object needs kind"))?;
    if kind == "inline" {
        return inline(obj, meshes, vertices, indices);
    }
    let segments = || u16_of(obj.get("segments"), "mesh segments", 16, 3, 64);
    Ok(match kind {
        "sphere" => MeshRef::Sphere { segments: segments()? },
        "cone" => MeshRef::Cone { segments: segments()? },
        "cylinder" => MeshRef::Cylinder { segments: segments()? },
        "frustum" => MeshRef::Frustum { segments: segments()? },
        "arch" => MeshRef::Arch { segments: segments()? },
        "stairs" => MeshRef::Stairs { steps: u16_of(obj.get("steps"), "mesh steps", 8, 1, 64)? },
        "rock" => MeshRef::Rock { seed: u16_of(obj.get("seed"), "mesh seed", 1, 0, 65535)? },
        "blob" => MeshRef::Blob { seed: u16_of(obj.get("seed"), "mesh seed", 1, 0, 65535)? },
        "fence" => MeshRef::Fence { posts: u16_of(obj.get("posts"), "mesh posts", 4, 2, 64)? },
        other => return Err(WireError::new("EINVAL", format!("unknown mesh kind {other}"))),
    })
}

fn named(name: &str) -> Result<MeshRef, WireError> {
    Ok(match name {
        "quad" => MeshRef::Quad,
        "cube" => MeshRef::Cube,
        "plane" => MeshRef::Plane,
        "gem" => MeshRef::Gem,
        "wedge" => MeshRef::Wedge,
        "gable" => MeshRef::Gable,
        "hip" => MeshRef::Hip,
        "pyramid" => MeshRef::Pyramid,
        other => return Err(WireError::new("EINVAL", format!("unknown mesh {other}"))),
    })
}

fn inline(
    obj: &serde_json::Map<String, serde_json::Value>,
    meshes: &mut Vec<MeshData>,
    vertices: &mut usize,
    indices: &mut usize,
) -> Result<MeshRef, WireError> {
    let positions_v = obj
        .get("positions")
        .and_then(|v| v.as_array())
        .ok_or_else(|| WireError::new("EINVAL", "inline mesh needs positions"))?;
    let indices_v = obj
        .get("indices")
        .and_then(|v| v.as_array())
        .ok_or_else(|| WireError::new("EINVAL", "inline mesh needs indices"))?;
    if positions_v.is_empty() {
        return Err(WireError::new("EINVAL", "inline mesh positions are empty"));
    }
    if positions_v.len() > SCENE_VERTICES || vertices.saturating_add(positions_v.len()) > SCENE_VERTICES {
        return Err(WireError::new("EFBIG", format!("inline vertices are capped at {SCENE_VERTICES}")));
    }
    if indices_v.len() > SCENE_INDICES || indices.saturating_add(indices_v.len()) > SCENE_INDICES {
        return Err(WireError::new("EFBIG", format!("inline indices are capped at {SCENE_INDICES}")));
    }
    // Lengths are inside the cap: allocate only now.
    let mut positions = Vec::with_capacity(positions_v.len());
    for (i, p) in positions_v.iter().enumerate() {
        positions.push(vec3(Some(p), "position", [0.0, 0.0, 0.0]).map_err(|_| {
            WireError::new("EINVAL", format!("inline position {} is not three numbers", i + 1))
        })?);
    }
    let mut index_buf = Vec::with_capacity(indices_v.len());
    for (i, n) in indices_v.iter().enumerate() {
        let v = n.as_u64().ok_or_else(|| WireError::new("EINVAL", format!("inline index {} is not an integer", i + 1)))?;
        if v > u32::MAX as u64 {
            return Err(WireError::new("EINVAL", format!("inline index {} is past u32", i + 1)));
        }
        index_buf.push(v as u32);
    }
    let normals = attr3(obj.get("normals"), positions.len(), "normals")?;
    let uvs = attr2(obj.get("uvs"), positions.len(), "uvs")?;
    let colors = attr4(obj.get("colors"), positions.len(), "colors")?;
    let mesh = MeshData {
        positions,
        normals,
        uvs,
        colors,
        indices: index_buf,
        groups: Vec::new(),
    };
    mesh.validate().map_err(|err| WireError::new("EINVAL", format!("inline mesh is not valid: {err:?}")))?;
    *vertices += mesh.positions.len();
    *indices += mesh.indices.len();
    let slot = u32::try_from(meshes.len()).map_err(|_| WireError::new("EFBIG", "too many inline meshes"))?;
    meshes.push(mesh);
    Ok(MeshRef::Uploaded(slot))
}

fn attr3(
    value: Option<&serde_json::Value>,
    n: usize,
    name: &str,
) -> Result<Vec<[f32; 3]>, WireError> {
    let Some(value) = value else { return Ok(Vec::new()) };
    let arr = value.as_array().ok_or_else(|| WireError::new("EINVAL", format!("inline {name} is not an array")))?;
    if arr.len() != n {
        return Err(WireError::new("EINVAL", format!("inline {name} length must match positions")));
    }
    let mut out = Vec::with_capacity(n);
    for item in arr {
        out.push(vec3(Some(item), name, [0.0, 0.0, 0.0])?);
    }
    Ok(out)
}

fn attr2(value: Option<&serde_json::Value>, n: usize, name: &str) -> Result<Vec<[f32; 2]>, WireError> {
    let Some(value) = value else { return Ok(Vec::new()) };
    let arr = value.as_array().ok_or_else(|| WireError::new("EINVAL", format!("inline {name} is not an array")))?;
    if arr.len() != n {
        return Err(WireError::new("EINVAL", format!("inline {name} length must match positions")));
    }
    let mut out = Vec::with_capacity(n);
    for item in arr {
        let pair = item.as_array().ok_or_else(|| WireError::new("EINVAL", format!("inline {name} entry is not a pair")))?;
        if pair.len() != 2 {
            return Err(WireError::new("EINVAL", format!("inline {name} entry is not a pair")));
        }
        out.push([num(&pair[0], name)?, num(&pair[1], name)?]);
    }
    Ok(out)
}

fn attr4(value: Option<&serde_json::Value>, n: usize, name: &str) -> Result<Vec<[f32; 4]>, WireError> {
    let Some(value) = value else { return Ok(Vec::new()) };
    let arr = value.as_array().ok_or_else(|| WireError::new("EINVAL", format!("inline {name} is not an array")))?;
    if arr.len() != n {
        return Err(WireError::new("EINVAL", format!("inline {name} length must match positions")));
    }
    let mut out = Vec::with_capacity(n);
    for item in arr {
        out.push(color4(item, name)?);
    }
    Ok(out)
}

fn check_graph(nodes: &[Node]) -> Result<(), WireError> {
    let mut seen = Vec::with_capacity(nodes.len());
    for node in nodes {
        if seen.contains(&node.id) {
            return Err(WireError::new("EINVAL", format!("duplicate node id {}", node.id)));
        }
        seen.push(node.id);
    }
    for node in nodes {
        if let Some(parent) = node.parent && !seen.contains(&parent) {
            return Err(WireError::new("EINVAL", format!("node {} parent {parent} is missing", node.id)));
        }
        let mut at = Some(node.id);
        let mut guard = 0;
        while let Some(id) = at {
            guard += 1;
            if guard > nodes.len() {
                return Err(WireError::new("EINVAL", format!("node {} parent chain cycles", node.id)));
            }
            at = nodes.iter().find(|n| n.id == id).and_then(|n| n.parent);
        }
    }
    Ok(())
}

fn look_rotation(eye: [f32; 3], target: [f32; 3], up: [f32; 3]) -> Result<[f32; 4], WireError> {
    let forward = [target[0] - eye[0], target[1] - eye[1], target[2] - eye[2]];
    let fl = len3(forward);
    if fl < 1e-6 {
        return Err(WireError::new("EINVAL", "camera eye and target coincide"));
    }
    let f = scale3(forward, 1.0 / fl);
    let right = cross(f, up);
    let rl = len3(right);
    if rl < 1e-6 {
        return Err(WireError::new("EINVAL", "camera up is parallel to the view"));
    }
    let right = scale3(right, 1.0 / rl);
    let up = cross(right, f);
    // The camera looks down its own -Z, so its +Z in the world is -forward.
    quat_from_basis(right, up, [-f[0], -f[1], -f[2]])
}

fn quat_from_basis(x: [f32; 3], y: [f32; 3], z: [f32; 3]) -> Result<[f32; 4], WireError> {
    let m00 = x[0];
    let m01 = y[0];
    let m02 = z[0];
    let m10 = x[1];
    let m11 = y[1];
    let m12 = z[1];
    let m20 = x[2];
    let m21 = y[2];
    let m22 = z[2];
    let trace = m00 + m11 + m22;
    let (qx, qy, qz, qw) = if trace > 0.0 {
        let s = (trace + 1.0).sqrt() * 2.0;
        ((m21 - m12) / s, (m02 - m20) / s, (m10 - m01) / s, 0.25 * s)
    } else if m00 > m11 && m00 > m22 {
        let s = (1.0 + m00 - m11 - m22).sqrt() * 2.0;
        (0.25 * s, (m01 + m10) / s, (m02 + m20) / s, (m21 - m12) / s)
    } else if m11 > m22 {
        let s = (1.0 + m11 - m00 - m22).sqrt() * 2.0;
        ((m01 + m10) / s, 0.25 * s, (m12 + m21) / s, (m02 - m20) / s)
    } else {
        let s = (1.0 + m22 - m00 - m11).sqrt() * 2.0;
        ((m02 + m20) / s, (m12 + m21) / s, 0.25 * s, (m10 - m01) / s)
    };
    let q = [qx, qy, qz, qw];
    let l = (q[0] * q[0] + q[1] * q[1] + q[2] * q[2] + q[3] * q[3]).sqrt();
    if !l.is_finite() || l < 1e-6 {
        return Err(WireError::new("EINVAL", "camera basis is not a rotation"));
    }
    Ok([q[0] / l, q[1] / l, q[2] / l, q[3] / l])
}

fn vec3(value: Option<&serde_json::Value>, name: &str, default: [f32; 3]) -> Result<[f32; 3], WireError> {
    let Some(value) = value else { return Ok(default) };
    let arr = value.as_array().ok_or_else(|| WireError::new("EINVAL", format!("{name} is not three numbers")))?;
    if arr.len() != 3 {
        return Err(WireError::new("EINVAL", format!("{name} is not three numbers")));
    }
    Ok([num(&arr[0], name)?, num(&arr[1], name)?, num(&arr[2], name)?])
}

fn vec4(value: Option<&serde_json::Value>, name: &str, default: [f32; 4]) -> Result<[f32; 4], WireError> {
    let Some(value) = value else { return Ok(default) };
    let arr = value.as_array().ok_or_else(|| WireError::new("EINVAL", format!("{name} is not four numbers")))?;
    if arr.len() != 4 {
        return Err(WireError::new("EINVAL", format!("{name} is not four numbers")));
    }
    Ok([num(&arr[0], name)?, num(&arr[1], name)?, num(&arr[2], name)?, num(&arr[3], name)?])
}

fn color4(value: &serde_json::Value, name: &str) -> Result<[f32; 4], WireError> {
    let arr = value.as_array().ok_or_else(|| WireError::new("EINVAL", format!("{name} is not four numbers")))?;
    if arr.len() != 4 {
        return Err(WireError::new("EINVAL", format!("{name} is not four numbers")));
    }
    let c = [num(&arr[0], name)?, num(&arr[1], name)?, num(&arr[2], name)?, num(&arr[3], name)?];
    if c.iter().any(|v| !v.is_finite() || !(0.0..=1.0).contains(v)) {
        return Err(WireError::new("EINVAL", format!("{name} components must be in 0..1")));
    }
    Ok(c)
}

fn f32_of(value: Option<&serde_json::Value>, name: &str, default: f32) -> Result<f32, WireError> {
    match value {
        None => Ok(default),
        Some(v) => num(v, name),
    }
}

fn u16_of(value: Option<&serde_json::Value>, name: &str, default: u16, lo: u16, hi: u16) -> Result<u16, WireError> {
    let n = match value {
        None => default,
        Some(v) => {
            let n = v.as_u64().ok_or_else(|| WireError::new("EINVAL", format!("{name} is not an integer")))?;
            if n > u16::MAX as u64 {
                return Err(WireError::new("EINVAL", format!("{name} is past u16")));
            }
            n as u16
        }
    };
    if !(lo..=hi).contains(&n) {
        return Err(WireError::new("EINVAL", format!("{name} must be {lo}..{hi}")));
    }
    Ok(n)
}

fn num(value: &serde_json::Value, name: &str) -> Result<f32, WireError> {
    let n = value.as_f64().ok_or_else(|| WireError::new("EINVAL", format!("{name} is not a number")))?;
    let f = n as f32;
    if !f.is_finite() {
        return Err(WireError::new("EINVAL", format!("{name} is not finite")));
    }
    Ok(f)
}

fn len3(v: [f32; 3]) -> f32 {
    (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]).sqrt()
}

fn scale3(v: [f32; 3], s: f32) -> [f32; 3] {
    [v[0] * s, v[1] * s, v[2] * s]
}

fn cross(a: [f32; 3], b: [f32; 3]) -> [f32; 3] {
    [
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0],
    ]
}

/// A pixel size the program named, `1..=SIZE_MAX` on each side.
pub fn pixel_size(width: u32, height: u32) -> Result<(u32, u32), WireError> {
    if width == 0 || height == 0 || width > SIZE_MAX || height > SIZE_MAX {
        return Err(WireError::new(
            "EINVAL",
            format!("size must be 1..={SIZE_MAX} on each side"),
        ));
    }
    Ok((width, height))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn cube() -> &'static str {
        r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":"cube","color":[1,0.4,0.2,1]}]}}"#
    }

    #[test]
    fn a_default_camera_looks_down_z_from_the_default_eye() {
        let wired = parse(cube().as_bytes()).expect("cube");
        let camera = wired.scene.camera;
        assert_eq!(camera.transform.translation, [0.0, 0.0, 3.0]);
        let [x, y, z, w] = camera.transform.rotation;
        assert!((x).abs() < 1e-5 && y.abs() < 1e-5 && z.abs() < 1e-5 && (w - 1.0).abs() < 1e-5);
        assert!(matches!(wired.scene.nodes[0].mesh, Some(MeshRef::Cube)));
    }

    #[test]
    fn every_wire_rejection_names_itself() {
        let cases: &[(&str, &str, &str)] = &[
            ("{", "EBADF", "not json"),
            (r#"[]"#, "EINVAL", "not an object"),
            (r#"{"scene":{}}"#, "EINVAL", "needs v"),
            (r#"{"v":2,"scene":{}}"#, "EINVAL", "v must be 1"),
            (r#"{"v":1}"#, "EINVAL", "needs a scene"),
            (r#"{"v":1,"scene":{},"extra":1}"#, "EINVAL", "unknown envelope field"),
            (r#"{"v":1,"scene":{"nope":1}}"#, "EINVAL", "unknown scene field"),
            (r#"{"v":1,"scene":{"camera":{"fov":4}}}"#, "EINVAL", "fov must be"),
            (r#"{"v":1,"scene":{"camera":{"near":0}}}"#, "EINVAL", "near must be"),
            (r#"{"v":1,"scene":{"camera":{"near":2,"far":1}}}"#, "EINVAL", "far must be"),
            (r#"{"v":1,"scene":{"camera":{"eye":[0,0,0],"target":[0,0,0]}}}"#, "EINVAL", "coincide"),
            (r#"{"v":1,"scene":{"camera":{"up":[0,0,1]}}}"#, "EINVAL", "parallel"),
            (r#"{"v":1,"scene":{"camera":{"clear":[2,0,0,1]}}}"#, "EINVAL", "0..1"),
            (r#"{"v":1,"scene":{"camera":{"ortho":0}}}"#, "EINVAL", "ortho must be"),
            (r#"{"v":1,"scene":{"nodes":[{"mesh":"cube"}]}}"#, "EINVAL", "needs an integer id"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1},{"id":1}]}}"#, "EINVAL", "duplicate node id"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"parent":9}]}}"#, "EINVAL", "parent 9 is missing"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"parent":2},{"id":2,"parent":1}]}}"#, "EINVAL", "cycles"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"rot":[0,0,0,0]}]}}"#, "EINVAL", "must not be zero"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"visible":"yes"}]}}"#, "EINVAL", "visible must be"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"lit":1}]}}"#, "EINVAL", "lit must be"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"emissive":2}]}}"#, "EINVAL", "emissive must be"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":"teapot"}]}}"#, "EINVAL", "unknown mesh"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":{"kind":"sphere","segments":2}}]}}"#, "EINVAL", "segments must be"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":{"kind":"stairs","steps":0}}]}}"#, "EINVAL", "steps must be"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":{"kind":"fence","posts":1}}]}}"#, "EINVAL", "posts must be"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":{"kind":"nope"}}]}}"#, "EINVAL", "unknown mesh kind"),
            (r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":{"kind":"inline","positions":[],"indices":[]}}]}}"#, "EINVAL", "positions are empty"),
            (
                r#"{"v":1,"scene":{"nodes":[{"id":1,"mesh":{"kind":"inline","positions":[[0,0,0],[1,0,0],[0,1,0]],"indices":[0,1,9]}}]}}"#,
                "EINVAL",
                "not valid",
            ),
            (r#"{"v":1,"scene":{"nodes":"no"}}"#, "EINVAL", "not an array"),
            (r#"not-json"#, "EBADF", "not json"),
        ];
        for (json, code, needle) in cases {
            let err = parse(json.as_bytes()).expect_err(json);
            assert_eq!(err.code, *code, "{json} -> {}", err.message);
            assert!(err.message.contains(needle), "{} does not contain {needle}", err.message);
        }
    }

    #[test]
    fn node_vertex_and_index_caps_reject_before_use() {
        let mut nodes = String::from(r#"{"v":1,"scene":{"nodes":["#);
        for i in 0..=SCENE_NODES {
            if i > 0 {
                nodes.push(',');
            }
            nodes.push_str(&format!(r#"{{"id":{i}}}"#));
        }
        nodes.push_str("]}}");
        let err = parse(nodes.as_bytes()).expect_err("nodes");
        assert_eq!(err.code, "EFBIG");
        assert!(err.message.contains("nodes"));

        let mut positions = String::from("[");
        for i in 0..=SCENE_VERTICES {
            if i > 0 {
                positions.push(',');
            }
            positions.push_str("[0,0,0]");
        }
        positions.push(']');
        let json = format!(
            r#"{{"v":1,"scene":{{"nodes":[{{"id":1,"mesh":{{"kind":"inline","positions":{positions},"indices":[0,0,0]}}}}]}}}}"#
        );
        let err = parse(json.as_bytes()).expect_err("vertices");
        assert_eq!(err.code, "EFBIG");
        assert!(err.message.contains("vertices"));

        let indices = format!("[{}]", "0,".repeat(SCENE_INDICES + 1).trim_end_matches(','));
        let json = format!(
            r#"{{"v":1,"scene":{{"nodes":[{{"id":1,"mesh":{{"kind":"inline","positions":[[0,0,0]],"indices":{indices}}}}}]}}}}"#
        );
        let err = parse(json.as_bytes()).expect_err("indices");
        assert_eq!(err.code, "EFBIG");
        assert!(err.message.contains("indices"));
    }

    #[test]
    fn an_inline_triangle_round_trips_into_a_mesh() {
        let json = r#"{"v":1,"scene":{"camera":{"clear":null,"ortho":2},"nodes":[{"id":7,"at":[1,2,3],"mesh":{"kind":"inline","positions":[[0,0,0],[1,0,0],[0,1,0]],"indices":[0,1,2]},"color":[0,1,0,1],"lit":true,"emissive":0.25}]}}"#;
        let wired = parse(json.as_bytes()).expect("triangle");
        assert!(wired.scene.camera.clear.is_none());
        assert!(matches!(wired.scene.camera.projection, Projection::Orthographic { height, .. } if height == 2.0));
        assert_eq!(wired.scene.nodes[0].id, 7);
        assert_eq!(wired.scene.nodes[0].transform.translation, [1.0, 2.0, 3.0]);
        assert!(matches!(wired.scene.nodes[0].mesh, Some(MeshRef::Uploaded(0))));
        assert_eq!(wired.meshes.len(), 1);
        assert_eq!(wired.meshes[0].positions.len(), 3);
        assert!(wired.scene.nodes[0].material.lit);
    }

    #[test]
    fn pixel_size_rejects_zero_and_over_cap() {
        assert!(pixel_size(0, 1).is_err());
        assert!(pixel_size(1, SIZE_MAX + 1).is_err());
        assert_eq!(pixel_size(8, 4).unwrap(), (8, 4));
    }

    /// The demo's own scene wires, not a copy that can drift: the first
    /// scene is a raw string, the per-frame scene a format string.
    #[test]
    fn the_demo_cube_wire_is_lit_from_the_stated_eye() {
        let source = include_str!("../../examples/glass_demo.rs");
        let first = source
            .split("br#\"")
            .nth(1)
            .and_then(|rest| rest.split("\"#").next())
            .expect("first scene");
        assert_demo_cube(first.as_bytes());

        let frame_src = source
            .split("r#\"")
            .find(|part| part.contains("{sy:.4}"))
            .and_then(|rest| rest.split("\"#").next())
            .expect("per-frame scene");
        let frame = frame_src
            .replace("{{", "{")
            .replace("}}", "}")
            .replace("{sy:.4}", "0.5000")
            .replace("{sw:.4}", "0.8660");
        assert_demo_cube(frame.as_bytes());
    }

    fn assert_demo_cube(bytes: &[u8]) {
        let wired = parse(bytes).expect("demo wire");
        assert!(
            wired.scene.nodes[0].material.lit,
            "the cube is lit, so its faces shade by their normals"
        );
        assert_eq!(wired.scene.camera.transform.translation, [2.2, 1.6, 2.6]);
        assert!(matches!(wired.scene.nodes[0].mesh, Some(MeshRef::Cube)));
    }
}
