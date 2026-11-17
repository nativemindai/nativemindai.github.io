# nativemind

The site for the Instagram account [@nativemind.ai](https://www.instagram.com/nativemind.ai/): https://nativemindai.github.io

- `/` is the link hub from the Instagram bio.
- `/<keyword>` is one guide per reel. Comment the reel's keyword and the DM links you to its guide, e.g. `/ipo`.

Built with [Astro](https://astro.build) as a static site and deployed to GitHub Pages by `.github/workflows/deploy.yml` on every push to `main`.

## Run it

Needs Node 22.23.4 or newer.

```sh
npm install
npm run dev -- --host   # open the "Network" URL on a phone on the same Wi-Fi
npm run build           # must pass before any push
npm run preview         # serve the built site
```

## Add a guide

In Claude Code, run `/new-guide KEYWORD`. It writes `src/content/guides/<keyword>.md` from the template in `.claude/skills/new-guide/`, checks it and publishes it.

By hand: copy `.claude/skills/new-guide/guide-template.md` to `src/content/guides/<keyword in lowercase>.md` and fill it in. The build fails if the frontmatter breaks the schema in `src/content.config.ts`. Put prompts in ```` ```prompt ```` blocks to get a COPY button. The page adds the disclaimer, sources and follow block itself.

Published guides are never renamed or deleted, because sent DMs keep pointing at them.

See `CLAUDE.md` for the full rules: schema, page template, writing rules, design system and privacy.

## License

Departure Mono is by Helena Zhang, under the SIL Open Font License (`public/fonts/OFL.txt`).
