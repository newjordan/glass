# site

glass's landing page: one static page, no build step, no JavaScript
framework. The only thing it loads from elsewhere is the JetBrains Mono
font from Google Fonts (it falls back to the system's monospace font).

| File | What it is |
| --- | --- |
| `index.html` | The page, with its CSS and a few lines of script (the copy buttons, and pausing the hero loop for people who ask for less motion). |
| `assets/hero-loop.mp4` | The hero loop: 6 s of the film, 1280×720 at 60 fps, H.264, 4.7 MB. |
| `assets/hero-poster.jpg` | A still from the loop, shown until the video plays. |
| `assets/glass-card.jpg` | The Open Graph card, 1280×640. |
| `assets/glass.svg`, `assets/favicon.svg` | The mark, from `packaging/icons/`. |

The page links to the full film as a `v0.1.0` release asset
(`glass-mindseye.mp4`; see [docs/media/README.md](../docs/media/README.md)),
and to the docs on GitHub. Every number on it comes from
[docs/PERFORMANCE.md](../docs/PERFORMANCE.md); change both together.

## Look at it locally

```sh
python3 -m http.server -d site 8000     # then open http://localhost:8000
```

## Deploy with GitHub Pages

GitHub Pages serves a private repository only on a paid plan (GitHub Pro,
Team or Enterprise); on the free plan, the repository has to be public
first.

The page assumes it is served at `https://newjordan.github.io/glass/`: the
`og:url` and `og:image` tags in `index.html` say so. With a custom
domain, change those two tags.

### Either: from a workflow (recommended)

Add `.github/workflows/pages.yml`:

```yaml
name: pages
on:
  push:
    branches: [main]
    paths: [site/**]
  workflow_dispatch:
permissions:
  contents: read
  pages: write
  id-token: write
concurrency:
  group: pages
  cancel-in-progress: true
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/configure-pages@v5
      - uses: actions/upload-pages-artifact@v3
        with:
          path: site
      - id: deployment
        uses: actions/deploy-pages@v4
```

Then, in the repository's Settings → Pages, set the source to **GitHub
Actions**. Each push to `main` that changes `site/` publishes it.

### Or: from a branch

```sh
git subtree split --prefix site -b gh-pages
git push origin gh-pages
```

Then, in Settings → Pages, deploy from the `gh-pages` branch, folder
`/ (root)`. Repeat both commands (with `git push -f` if the history
changed) to publish again.
