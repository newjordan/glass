# Media

What the README, the site and the social posts use. Every number in the
charts comes from [`bench/scoreboard-20261028.json`](../../bench/scoreboard-20261028.json);
the method is in [docs/PERFORMANCE.md](../PERFORMANCE.md).

| File | What it is |
| --- | --- |
| `hero-loop.gif` | 5 s of the mind's eye film, 640×360 at 12 fps (6.5 MB). The top of the README; links to the full film. |
| `glass-advantage.png` | How many times better glass measured than kitty 0.49.2, measure by measure (3200×2324). |
| `glass-throughput.png` | MB/s per workload, glass and kitty 0.49.2 (3200×1800). |
| `glass-startup.png` | Prompt on screen, window on screen and program running, glass and kitty 0.49.2 (3200×1360). |
| `glass-card.png` | The social preview / Open Graph card, 2560×1280 (2× of 1280×640). Upload it under the repo's Settings → Social preview. |

The site keeps its own copy of the loop as a video
([`site/assets/hero-loop.mp4`](../../site/assets/hero-loop.mp4), H.264,
1280×720 at 60 fps, 4.7 MB) so it can be deployed on its own.

Chart colours: glass `#14a3c7`, kitty `#c98500`, on a near-black ground.

## Release assets

The videos are too big for git. Upload these to the `v0.1.0` release under
exactly these names. The README and the site link to the film there; the
30-second cut is for the launch posts.

| Upload as | Source | Size |
| --- | --- | --- |
| `glass-mindseye.mp4` | `glass-mindseye-final-h264.mp4`: the full film, 95 s, 1920×1080 at 60 fps, H.264 | 361 MB |
| `glass-30s.mp4` | `glass-30s-16x9.mp4`: the 30-second cut, 1920×1080 at 60 fps, H.264 | 43 MB |

Links once they are up:

- `https://github.com/newjordan/glass/releases/download/v0.1.0/glass-mindseye.mp4`
- `https://github.com/newjordan/glass/releases/download/v0.1.0/glass-30s.mp4`

## The film's assets

The dancing figures in the film are Mixamo characters (Michelle, Soldier
and Xbot, from three.js's examples) and the author's own model, dancing CMU
motion-capture data retargeted in Blender. They appear in the film only and
are not in this repository; `glass_mindseye --surreal` reads them from
`MINDSEYE_ASSETS`.
