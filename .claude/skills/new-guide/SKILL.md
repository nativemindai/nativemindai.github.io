---
name: new-guide
description: Create, check and publish a nativemind guide page, the link the Instagram comment-to-DM automation sends for a reel's keyword. Use when asked to make, write, add, update or publish a guide, or for a reel's post kit.
argument-hint: "[KEYWORD]"
---

# /new-guide

Keyword requested: **$ARGUMENTS**

Read `CLAUDE.md` first. The schema, page template, writing rules and publishing rules there all apply.

## 1. Gather the inputs
- **Keyword.** Take it from the argument. If it's empty, ask for it. Uppercase it.
- **The reel.** Use the script, topic and CTA from the conversation. If they're missing, ask for the reel script (or topic) and the exact payoff the CTA promised. Don't guess the payoff: the page must deliver exactly what the reel promised.
- **Slug** = keyword lowercased, letters/digits/hyphens only.

## 2. Check the keyword is free
- If `src/content/guides/<slug>.md` exists, or any guide already has this `keyword`, stop. Say which guide uses it and suggest 2–3 alternatives. Keywords are never reused, because an automation can only hold one.
- Avoid keywords people type anyway ("YES", "WOW", "FIRE"). Suggest a better one if needed.

## 3. Research
- Check that every fact, date, price, plan limit and feature named in the guide is current today, using primary sources (official sites, docs, filings). Record each one in `sources`.
- Tools: confirm the free plan, its limits and its usage rights.
- Make sure each prompt is self-contained and works pasted cold into any chatbot. Mark the parts the reader fills in with `[BRACKETS]`.

## 4. Write the file
- Copy `${CLAUDE_SKILL_DIR}/guide-template.md` to `src/content/guides/<slug>.md` and fill it in.
- Follow the section order and writing rules in `CLAUDE.md`. Put the payoff first: keep "The short version" to two lines, and put each prompt inside the step that uses it, so the promised prompt is about one screen down.
- Leave out the disclaimer, sources list and follow block. The layout adds them.

## 5. Check it
Go through this list and fix anything that fails before moving on:
- [ ] `title` ≤ 60 chars, `hook` ≤ 140 chars, `payoff` matches the CTA word for word
- [ ] 3–7 steps, one action each, each starting with a verb, no jargon
- [ ] Every prompt is in a ```` ```prompt ```` block with `[BRACKETS]` for fill-ins
- [ ] `disclaimer: financial` on any money, investing, crypto, tax or pay topic; no hype or buy/sell language
- [ ] Every fact has a source; example numbers are labelled as examples
- [ ] Free tools state their plan limits and usage rights
- [ ] Nothing personal anywhere (see Privacy in `CLAUDE.md`); any image is made for the site, cropped and metadata-free
- [ ] `npm run build` passes

## 6. Preview
- Run `npm run dev -- --host` and open `/<slug>` at 390px wide (and 360px).
- Check: the payoff is about one screen down at most, prompt boxes wrap with no sideways scrolling, the COPY button works, nothing overflows, and the disclaimer and follow block are there.
- Tell the owner the local Network URL so they can open it on their phone.

## 7. Publish
- Publish without asking again if this guide belongs to a reel script the owner already approved, or if the owner said to publish. Otherwise show the preview and wait for an OK.
- Check the commit identity is the noreply one from `CLAUDE.md` (`git config user.email`).
- `git add src/content/guides/<slug>.md`, commit `guide: <slug>`, push to `main`. If the privacy guard blocks it, remove the private detail and try again. Never use `--no-verify`.
- Watch the deploy without the GitHub CLI, which may be signed in to another account: poll `curl -s "https://api.github.com/repos/nativemindai/nativemindai.github.io/actions/runs?per_page=1"` until the latest run's `status` is `completed` and its `conclusion` is `success`. Then confirm `https://<site>/<slug>`, exactly as it will be typed in the DM with no trailing slash, returns 200 and shows the new title.

## 8. Hand back the DM kit
Reply with this, ready to paste into Meta Business Suite → Inbox → Automated responses → Comment to message:

```
Keyword variants: KEYWORD, Keyword, keyword
DM: Here's [payoff] 👇 https://<site>/<slug>
Follow @nativemind.ai so you don't miss [the next thing].
```

## Updating a live guide
Edit the file in place. Never rename or delete it. Set `updated` to today, run checks 5–7, and commit `guide: fix <slug>`.
