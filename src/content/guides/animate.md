---
keyword: ANIMATE
title: "Make your own AI animated show with Claude and Higgsfield"
hook: "Connect Higgsfield to Claude, then use 5 prompts to build your own character, story and shots without making AI slop."
payoff: "the setup + my anti-slop prompts"
disclaimer: financial
reel_date: 2026-11-18
sources:
  - label: "Higgsfield Help Center: How do I connect Higgsfield to an AI agent?"
    url: "https://higgsfield.ai/creator-hub/help-center/integrations/how-do-i-connect-higgsfield-to-ai-agent"
  - label: "Higgsfield: MCP"
    url: "https://higgsfield.ai/mcp"
  - label: "Higgsfield: Pricing"
    url: "https://higgsfield.ai/pricing"
  - label: "Claude Help Center: Getting started with custom connectors"
    url: "https://support.claude.com/en/articles/11175166-getting-started-with-custom-connectors-using-remote-mcp"
  - label: "Higgsfield Earn"
    url: "https://higgsfield.ai/earn"
  - label: "Tubefilter: YouTube clarifies its inauthentic content monetization rules (Jul 13, 2026)"
    url: "https://www.tubefilter.com/2026/07/13/youtube-inauthentic-content-monetization-policy-update/"
  - label: "The Next Web: YouTube's AI slop purge (Jun 15, 2026)"
    url: "https://thenextweb.com/news/youtube-ai-slop-crackdown-faceless-creators-collateral-damage"
  - label: "Cartoon Brew: AI account rips off 2008 short El Empleo (Nov 9, 2026)"
    url: "https://www.cartoonbrew.com/artificial-intelligence/el-empleo-unauthorized-ai-remake-269233.html"
links:
  - label: "Higgsfield pricing"
    url: "https://higgsfield.ai/pricing"
  - label: "Add Higgsfield to Claude"
    url: "https://claude.ai/customize/connectors?modal=add-custom-connector&connectorName=Higgsfield&connectorUrl=https%3A%2F%2Fmcp.higgsfield.ai%2Fmcp"
  - label: "Higgsfield help"
    url: "https://higgsfield.ai/creator-hub/help-center/integrations/how-do-i-connect-higgsfield-to-ai-agent"
---

## The short version
Higgsfield is an AI tool that turns a written scene into an animated clip, and you can now run it from inside Claude.
YouTube won't pay for mass-produced, templated AI video, so this setup keeps the character, the story and every shot yours.

## Do this
1. Get a paid Higgsfield plan: tap **Higgsfield pricing** below. The free plan won't connect to Claude. Every clip you make through Claude uses credits. Higgsfield's rough guide is about 14 credits per video and 2 per image, depending on the model, length and quality.
2. Connect it to Claude. On claude.ai, go to **Customize → Connectors**, tap **+ Add → Add custom connector**, name it **Higgsfield** and paste `https://mcp.higgsfield.ai/mcp`. Tap **Continue**, keep the default settings, tap **Add**, then sign in to Higgsfield and approve. The **Add Higgsfield to Claude** button below fills in the name and link for you. Claude's free plan allows one custom connector.
3. Create your character. Start a new chat in Claude and paste this:

   ```prompt
   Help me create an original cartoon character for a short animated show. Not based on any existing character, show, celebrity or real person.

   First, ask me 3 questions, one at a time, about things I know well or care about. Then build the character from my answers:

   1. Name, and what they want more than anything.
   2. One flaw that keeps getting them in trouble.
   3. How they look: shape, colors, clothes and one detail nobody would guess. Be specific.
   4. How they move and talk.
   5. A one-line character sheet I can reuse in every shot so they always look the same.

   Skip the stock ideas AI usually reaches for. If something feels like the first thing anyone would think of, replace it. Don't make any images yet.
   ```

4. Write the story. In the same chat, paste this and fill in your idea:

   ```prompt
   Write a 30 to 60 second first episode for my character. My character sheet is above in this chat (if not, here it is: [CHARACTER SHEET]).

   Build it on a real idea of mine: [A REAL MOMENT, OPINION OR JOKE FROM YOUR LIFE]

   Rules:
   - A clear beginning, a turn, and an ending that changes something.
   - 6 to 10 short scenes, one line each.
   - Any spoken lines in plain, everyday words.
   - No clichés: no "little did they know", no "it was all a dream", no moral spelled out at the end.

   If my idea is too thin, ask me one question before you write.
   ```

5. Plan the shots. Tap **+ → Connectors**, make sure **Higgsfield** is on, then paste this:

   ```prompt
   Turn my episode into a shot list for Higgsfield. My character sheet and story are above (if not, here they are: [CHARACTER SHEET AND STORY]). Don't generate anything yet.

   1. Pick ONE visual style for the whole episode. Write it as one line to use in every shot.
   2. For each shot: number, length in seconds, what happens, the camera (how close, and whether it moves) and how the character moves.
   3. Recommend one video model and say why in one line.
   4. Check my Higgsfield credit balance. Give the credit cost of each shot, one character reference image, and the total.

   My budget for this episode is [NUMBER] credits. Show me the plan as a short table, then stop and wait for my OK.
   ```

6. Generate one shot at a time. When the plan looks right, paste this:

   ```prompt
   Make the shots from the plan above, one at a time.

   - Start with the character reference image. Use it, the character sheet and the style line in every shot so everything matches.
   - Before each generation, tell me what it will cost.
   - After each one, show me the result and stop. I'll reply "next", "redo" with my notes, or "cut".
   - Always ask for my approval before generating. Never make more than one thing at a time.
   - Do not spend more than [NUMBER] credits in total. Keep a running count.
   ```

7. Finish it by hand. Put the shots together in any video editor, cut every shot that looks generic, and add your own voice or music you have the rights to.

## More prompts
Before you post, run a slop check. Paste this into a new chat in any chatbot, so it judges the work and not your conversation:

```prompt
Be a tough critic. No flattery, no compliments, no softening. I made a short AI-animated episode and I need to know if it's AI slop.

Here's what I made: [PASTE YOUR STORY AND SHOT LIST, OR ATTACH A SCREENSHOT OF EACH SHOT]

Tell me:
1. The 3 most generic moments, and why.
2. Anything that looks obviously AI-made: faces, hands, motion, random camera moves.
3. Does the story have a real beginning, turn and ending?
4. Could someone make the same thing with one prompt? What here is only mine?
5. Anything borrowed from an existing character, show, film or real person.
6. An originality score from 1 to 10, with one sentence why.

End with the 3 changes that would make it most mine.
```

## Watch out
- **There's no spending cap.** Higgsfield has no built-in credit limit for Claude. Every generation through Claude uses credits, even on plans with "unlimited" models, because unlimited and free generations only work on higgsfield.ai. Keep the budget line in your prompts. Unused plan credits don't roll over.
- **YouTube won't pay for slop.** It doesn't monetize generic or repetitive content: videos that look made from a template, or characters stuck in the same situation with the same outcome. Using AI is allowed. What counts is your own story and input, and YouTube looks at your channel as a whole.
- **Never remake someone else's work.** In November 2026, an AI remake of the award-winning 2008 short film *El Empleo* got more than 5 million views in under 24 hours, then came down after the film's co-creator objected. The same goes for existing characters and celebrities.
- **Earnings aren't guaranteed.** Higgsfield Earn pays for approved videos posted to Instagram as they hit view milestones. It's capped at $1,000 on the first day and $2,500 per video in total.
