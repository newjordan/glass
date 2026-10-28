//! glass's settings in the environment, read by name in one place.
//!
//! Every setting is `GLASS_<NAME>` (`GLASS_RECORD`, `GLASS_OPACITY`, ...).
//! The `ANGEL_GLASS_<NAME>` spelling earlier builds read keeps working;
//! when both are set, the `GLASS_` one wins.

use std::ffi::OsString;

/// The setting `name` (a `GLASS_` name), or its earlier spelling.
pub fn var_os(name: &str) -> Option<OsString> {
    pick(name, |key| std::env::var_os(key))
}

/// The setting as text; `None` when it is unset or not Unicode.
pub fn var(name: &str) -> Option<String> {
    var_os(name).and_then(|value| value.into_string().ok())
}

/// Whether the setting is `value`.
pub fn is(name: &str, value: &str) -> bool {
    var(name).is_some_and(|v| v == value)
}

/// The setting as `lookup` finds it: the `GLASS_` name first, then the
/// earlier spelling.
fn pick(name: &str, lookup: impl Fn(&str) -> Option<OsString>) -> Option<OsString> {
    debug_assert!(name.starts_with("GLASS_"), "{name} is not a GLASS_ setting");
    lookup(name).or_else(|| lookup(&format!("ANGEL_{name}")))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn lookup<'a>(set: &'a [(&'a str, &'a str)]) -> impl Fn(&str) -> Option<OsString> + 'a {
        move |key| set.iter().find(|(k, _)| *k == key).map(|(_, v)| OsString::from(v))
    }

    #[test]
    fn the_new_name_wins_and_the_old_one_still_works() {
        let both = [("GLASS_OPACITY", "0.5"), ("ANGEL_GLASS_OPACITY", "0.9")];
        assert_eq!(pick("GLASS_OPACITY", lookup(&both)), Some("0.5".into()));
        let old = [("ANGEL_GLASS_OPACITY", "0.9")];
        assert_eq!(pick("GLASS_OPACITY", lookup(&old)), Some("0.9".into()));
        let new = [("GLASS_OPACITY", "0.5")];
        assert_eq!(pick("GLASS_OPACITY", lookup(&new)), Some("0.5".into()));
        assert_eq!(pick("GLASS_OPACITY", lookup(&[])), None);
        // Set but empty is set: the new name still wins.
        let empty = [("GLASS_RECORD", ""), ("ANGEL_GLASS_RECORD", "old.mp4")];
        assert_eq!(pick("GLASS_RECORD", lookup(&empty)), Some("".into()));
    }
}
