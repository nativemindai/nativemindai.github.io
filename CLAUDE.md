# nativemind site

Static site for the Instagram account **@nativemind.ai**, hosted on GitHub Pages.

- **Site URL:** https://nativemindai.github.io. The GitHub account `nativemindai` is the brand (no organization), and this repo is `nativemindai/nativemindai.github.io`.
- **Home (`/`)**: the link hub that goes in the Instagram bio.
- **Guides (`/<keyword>`)**: one page per reel. Each reel ends with "Comment KEYWORD and I'll send you [the payoff]". An Instagram automation then DMs the link, for example `https://nativemindai.github.io/ipo`.

**Who reads it:** someone who just watched a 30-second reel, on a phone, inside Instagram's in-app browser, with no AI background. They should get the payoff in under a minute.

**This repo is public and the brand is anonymous.** The pixel robot is the only face. Read the Privacy section before every commit.

## Privacy (every file, commit and push)
Nothing in this repo, its history or the live site may point to a real person.
- **Commit identity:** name `nativemind`, email `357609887+nativemindai@users.noreply.github.com` (the account's GitHub noreply address). Set both per clone with `git config user.name` / `git config user.email` (never `--global`) before the first commit, in every environment, cloud sessions included. Never commit under any other name or email.
- **Push identity:** only the `nativemindai` account pushes. On the owner's computer, origin is `git@github-nativemind:nativemindai/nativemindai.github.io.git`: an SSH host alias in `~/.ssh/config` that uses the brand key `~/.ssh/nativemind_ed25519` with `IdentitiesOnly yes`. Another GitHub account is signed in on that computer (VS Code, GitHub CLI, Git Credential Manager). Never use it for this repo: no `gh` commands that write anything, no VS Code "Publish to GitHub", pull request or issue features, no stars or forks, and never add another account as a collaborator. The repo's public activity shows which account pushed. The pre-push hook checks that the pushing account is the repo owner. In a cloud session without brand credentials, don't push; hand the finished files to the owner instead.
- **Privacy guard:** `scripts/privacy-guard.sh` runs as git hooks (pre-commit, commit-msg, pre-push). Install with `sh scripts/privacy-guard.sh install`. It checks the commit identity, the pushing account, staged files, commit messages and pushes against `.private-terms`, a git-ignored local list of private words. Never bypass it (`--no-verify`), never weaken it, never commit `.private-terms` and never copy its contents anywhere. If it blocks something, remove the private detail; don't work around the check. Where the hooks can't run (e.g. a cloud clone without `.private-terms`), confirm `git config user.email` ends in `@users.noreply.github.com` and re-read every staged line before committing.
- **Nothing personal, anywhere:** no real names, personal emails, phone numbers, addresses, school, employer, city, other accounts or handles, and no links to personal sites. That covers files, code comments, commit messages, image file names and alt text.
- **Images:** only images made for the site and saved without metadata (no GPS, camera, device, author or software fields; re-save with Pillow without EXIF before committing). Crop screenshots to remove status bars, notifications, profile pictures, account names, other tabs and anything that identifies an account other than @nativemind.ai.
- **Links:** outbound links go to tools and sources only.
- **No third-party widgets** (analytics, forms, comments, embeds) tied to a personal account.

## Stack
- Astro (current major version), static output only, npm. TypeScript strict.
- No UI framework, no Tailwind, no client-side framework. Plain CSS in `src/styles/global.css` using the variables below.
- JavaScript on the page is limited to one small inline script for the copy buttons.
- Deploy: `.github/workflows/deploy.yml` uses the official `withastro/action` plus `actions/deploy-pages`. Pages source = GitHub Actions. A push to `main` deploys in about 1–2 minutes.
- No third-party scripts, trackers, cookies or external font requests unless the owner adds one.

## Layout of the repo
```
src/content/guides/<slug>.md   one file per guide: the only thing that changes per reel
src/content.config.ts          guide schema (the build fails if a guide breaks it)
src/layouts/Base.astro         <head>, meta, OG tags, favicons, fonts
src/layouts/Guide.astro        guide page shell: title, payoff, body, disclaimer, follow block
src/pages/index.astro          link hub
src/pages/[slug].astro         renders every guide at /<slug>
src/data/site.ts               site name, tagline, Instagram handle, hub links
src/styles/global.css          design system
public/                        robot.svg, favicon.svg, favicon-48.png, apple-touch-icon.png, og-default.png, fonts/
.claude/skills/new-guide/      the /new-guide workflow and the guide template
scripts/privacy-guard.sh       git hooks that block personal details (see Privacy)
.private-terms                 local only, git-ignored: the guard's list of private words
```

## Guide schema (frontmatter)
| field | rule |
|---|---|
| `keyword` | Exactly as shown in the reel's CTA, uppercase (e.g. `IPO`). Unique across all guides. Never reused. |
| `title` | ≤ 60 characters, plain words, says what the reader can now do. |
| `hook` | ≤ 140 characters. Used for the meta description and the link preview. |
| `payoff` | What the CTA promised, word for word (e.g. `the step-by-step + the exact prompt`). |
| `disclaimer` | `none` or `financial`. Money, investing, crypto, taxes, jobs-and-pay topics → `financial`. |
| `reel_date` | Date the reel posts. |
| `updated` | Optional date, set whenever a live guide is edited. |
| `sources` | Optional list of `{ label, url }`. Required whenever the guide states a fact, number or date. |
| `links` | Optional list of `{ label, url }`: tools or pages the steps send the reader to. |
| `draft` | Optional boolean, default `false`. Drafts are not built. |

- File name = slug = keyword in lowercase (letters, digits, hyphens): `IPO` → `src/content/guides/ipo.md` → `/ipo`.
- **The DM link must load exactly as typed**, e.g. `https://nativemindai.github.io/ipo` with no trailing slash and no 404. Pick the Astro build/trailing-slash settings that make that true on GitHub Pages, and check it after every deploy.
- Slugs are permanent. DMs already sent keep pointing at them. Never rename or delete a published guide. Fix it in place and set `updated`.

## Guide page template
The layout renders, in order:
1. Small pixel label: `COMMENTED "KEYWORD"?` (grey) then the title (white, pixel font).
2. The Markdown body. Sections, in this order, skipping any that don't apply:
   - `## The short version`: two lines, what happened and why it matters to the reader
   - `## Do this`: numbered steps, 3–7, one action each, each starting with a verb. **A prompt goes inside the step that uses it** (an indented ```` ```prompt ```` block under that step), not in a separate section further down.
   - `## More prompts`: optional extras, if the payoff promised several
   - `## Watch out`: risks, limits, the other side of a statistic
3. Links, rendered from the `links` frontmatter as tappable buttons, not written in the body.
4. Disclaimer, added by the layout when `disclaimer: financial`: "Not financial advice. Facts as of [updated or reel_date]."
5. Sources, from frontmatter, small and grey.
6. Follow block, added by the layout: robot + "Follow @nativemind.ai for the next one" linking to the Instagram profile.

**The payoff comes first.** Whatever the reel promised (usually the prompt) must be reachable within about one screen of scrolling on a phone. Nobody wades through an intro to find what they commented for.

Guide authors never write the disclaimer, sources or follow block by hand. The layout adds them, so they are never forgotten.

**Prompt boxes:** every ```` ```prompt ```` block renders as a box with a `COPY` button. Text wraps; there is never horizontal scrolling. Parts the reader fills in are written in `[BRACKETS]`. The copy button must work inside Instagram's in-app browser on iOS and Android. If clipboard access is blocked, it selects the text and shows "Press and hold to copy". After copying, the button reads `COPIED` for 2 seconds.

## Writing rules
- Very high level. No jargon. Understandable with zero AI knowledge. Short sentences, second person ("you").
- One action per step. Name the exact button or menu the reader taps.
- Prompts are copy-paste ready and self-contained: they work pasted cold into any chatbot.
- Verify every fact is current when writing, and list it in `sources`. Never invent numbers. Label example numbers as examples.
- Free tools: say what the free plan's limits and usage rights are.
- Money topics: facts only (dates, how access works, risks). No hype, no buy/sell language, no price predictions. On crypto, no price talk at all.
- Brand names as plain text. No company logos.
- Never mention the person behind the account.

## Design system
Matches the reels: pure black, white pixel type, one red accent, the pixel robot.
```css
--bg: #000000;      /* page */
--fg: #FFFFFF;      /* text */
--muted: #969696;   /* secondary text, labels, sources */
--accent: #FF2E2E;  /* the ONLY accent: keyword label, COPY button, key warnings. Use sparingly. */
--line: #464646;    /* faint outlines and dividers only */
```
- **Type:** headings, labels and buttons use **Departure Mono**, a pixel monospace font under the SIL OFL. Self-host the woff2 from its official release (github.com/rektdeckard/departure-mono) in `public/fonts/` and include its OFL license file. Use font sizes in multiples of 11px (22, 33, 44) so the pixels stay crisp. Body text uses the system sans stack at 17–18px with line-height 1.55. Prompt text uses the system monospace stack. Readability beats style: people follow these steps on a phone.
- **Shapes:** square corners everywhere (`border-radius: 0`), flat colour, 2px solid lines. No gradients, shadows, blur or rounded cards. No frame border around the page.
- **Robot:** `public/robot.svg` is the brand's only logo. It's an exact copy of the reel host, so never redraw, recolour, rotate or restyle it. Show it on the home page and in the follow block. Size it in whole multiples of 16px (it's a 13×16 grid).
- **Not video-game themed:** no arcade fonts, no "PRESS START", no health bars, no 8-bit sound or music.
- **Layout:** single column, max-width 640px, 20px side padding, tap targets ≥ 44px tall. Mobile-first: design at 390px wide, then check 360px and desktop.
- **Weight:** each page under about 150 KB total including the font. Load the font with `font-display: swap`.

## Head tags (every page)
- `<title>`, meta description = `hook`, canonical URL.
- Open Graph + Twitter card: title, description, `og:image` = `/og-default.png` (absolute URL), `og:type`, `og:url`. These make the DM link preview look right.
- Favicons: `favicon.svg`, `favicon-48.png`, `apple-touch-icon.png`. `theme-color` #000000.
- **Guide pages get `<meta name="robots" content="noindex">`** so the comment stays the way in. The home page is indexable. Guides are not listed on the home page.
- `public/robots.txt` allows everything and points to nothing else. noindex does the work.

## Home page (link hub)
Robot (large) → `nativemind.ai` in pixel type → tagline from `src/data/site.ts` (keep it the same as the Instagram bio) → a stack of full-width link buttons from `src/data/site.ts` (the first is Instagram: https://www.instagram.com/nativemind.ai/). Nothing else.

## Commands
- `npm install`
- `npm run dev -- --host`: then open the "Network" URL on a phone on the same Wi-Fi
- `npm run build`: must pass before any push
- `npm run preview`
- `/new-guide KEYWORD`: creates, checks and publishes a guide (see `.claude/skills/new-guide/SKILL.md`)

## Publishing rules
- **Guides:** publish (commit + push to `main`) without asking again when the guide belongs to a reel whose script the owner already approved, or when the owner says to publish. Otherwise show the preview and ask.
- **Anything else** (layout, styles, home page, config, dependencies): show the change running locally and get the owner's OK before pushing.
- Commit messages: `guide: <slug>`, `guide: fix <slug>`, `site: <what changed>`.
- The privacy guard must pass on every commit and push. Never use `--no-verify`.
- After a push, confirm the GitHub Actions run succeeded and that the live URL returns 200.
