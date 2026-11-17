# Kickoff prompt for Claude Code (paste in Plan mode)

Read CLAUDE.md and .claude/skills/new-guide/ first. This folder is the nativemind site described there. The GitHub repo is nativemindai/nativemindai.github.io (public, empty). The public/ folder already has the robot and icon assets; use them exactly as they are.

## Step 0: privacy setup, before anything else
Follow the Privacy section of CLAUDE.md. Another GitHub account is signed in on this computer, so this repo gets its own SSH key and never uses that account. Use Git Bash for shell commands.

a. **Git.** If this folder isn't a git repo yet, run `git init -b main`. Set, for this repo only (never `--global`): `git config user.name "nativemind"` and `git config user.email "357609887+nativemindai@users.noreply.github.com"`. Ask me to confirm that email matches the one shown at github.com → Settings → Emails (signed in as nativemindai).
b. **Brand SSH key.** Create `~/.ssh/nativemind_ed25519` with `ssh-keygen -t ed25519 -C "nativemind" -f ~/.ssh/nativemind_ed25519 -N ""`, unless it already exists. Add this block to `~/.ssh/config` without changing anything else in that file:
   ```
   Host github-nativemind
     HostName github.com
     User git
     IdentityFile ~/.ssh/nativemind_ed25519
     IdentitiesOnly yes
   ```
c. **Add the key to the brand account.** Show me the contents of `~/.ssh/nativemind_ed25519.pub`. I'll add it at github.com → Settings → SSH and GPG keys → New SSH key, signed in as nativemindai. Wait for me to say it's done.
d. **Verify.** Run `ssh -T -o StrictHostKeyChecking=accept-new git@github-nativemind`. It must say "Hi nativemindai!". If it names any other account, stop and tell me.
e. **Remote.** `git remote add origin git@github-nativemind:nativemindai/nativemindai.github.io.git`, or `git remote set-url` if origin exists.
f. **Guard.** Run `sh scripts/privacy-guard.sh install`. Then tell me to open `.private-terms` and add my private words myself. Don't ask me to type them into the chat, and never read that file back to me.
g. **Confirm.** `.private-terms` is git-ignored, and the pre-commit, commit-msg and pre-push hooks exist in .git/hooks.

## Then plan the first version
Show me the plan before writing any files. Scope:

1. Scaffold Astro (current version, minimal template, TypeScript strict, npm) in this folder without overwriting CLAUDE.md, KICKOFF.md, .claude/, public/ or scripts/. Merge Astro's ignore entries into the existing .gitignore rather than replacing it. Ask me before adding any dependency beyond Astro itself.
2. A guide content collection with the schema from CLAUDE.md, so a guide with a missing or invalid field fails the build.
3. Layouts and pages: Base, Guide, the link hub at /, guides at /<slug> with noindex, and a 404 page in the same style with a link home.
4. COPY buttons on prompt blocks, as CLAUDE.md describes, including the fallback for Instagram's in-app browser.
5. The design system from CLAUDE.md, with Departure Mono self-hosted plus its license file.
6. A URL check: https://nativemindai.github.io/<slug> must load with no trailing slash, no 404 and no redirect loop on GitHub Pages. Tell me which setting you chose and why.
7. One example guide, src/content/guides/example.md (keyword EXAMPLE), that uses every feature: the two-line short version, steps with a prompt inside a step, a second prompt under "More prompts", links, a Watch out section, disclaimer: financial and sources. We'll use it to review the design and to test the DM automation.
8. .github/workflows/deploy.yml using withastro/action and actions/deploy-pages, with `site` set in astro.config.mjs.
9. A short README: what the site is, how to run it, and how to add a guide with /new-guide. No personal details.

When it's built, run `npm run build`, start `npm run dev -- --host`, and give me the Network URL so I can check it on my phone. Don't commit or push until I say so. For the first push, use `git push -u origin main` and let the pre-push hook run.
