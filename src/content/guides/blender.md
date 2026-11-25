---
keyword: BLENDER
title: "Let Claude do your Blender chores, no Python needed"
hook: "Connect Claude to Blender on the free plan, then hand it the chores: renaming, finding heavy meshes, explaining node setups."
payoff: "the setup + ten chore prompts"
disclaimer: none
reel_date: 2026-11-29
sources:
  - label: "Claude Academy: Using the Blender connector in Claude"
    url: "https://academy.claude.com/tutorials/using-the-blender-connector-in-claude"
  - label: "Anthropic: Claude for creative work (Apr 28, 2026)"
    url: "https://www.anthropic.com/news/claude-for-creative-work"
  - label: "Blender Lab: Blender MCP Server"
    url: "https://www.blender.org/lab/mcp-server/"
  - label: "Claude pricing: Free plan usage limits"
    url: "https://claude.com/pricing"
  - label: "Blender: License"
    url: "https://www.blender.org/about/license/"
links:
  - label: "Get the Claude desktop app"
    url: "https://claude.ai/download"
  - label: "Blender MCP Server page"
    url: "https://www.blender.org/lab/mcp-server/"
  - label: "Download Blender"
    url: "https://www.blender.org/download/"
---

## The short version
Blender has an official Claude connector, made by the Blender developers, and it works on every Claude plan, Free included.
You ask in plain words and Claude does the chores in your open scene, like renaming, cleanup and finding what slows your render, so you can keep making the art.

## Do this
1. Install the **Claude desktop app** from **claude.ai/download** on the computer where you use Blender, and sign in. You need Blender 4.2 or later. The connector doesn't work in Claude in a web browser.
2. In the Claude app, go to **Customize → Connectors**, search **Blender** and click **Add**.
3. Open **blender.org/lab/mcp-server** in your browser, next to Blender. Drag its install link into the Blender window. When Blender asks to add the **lab** extension repository, allow it.
4. Drag the same link into Blender a second time. This installs the add-on.
5. Open your project in Blender, go to **Edit → Preferences → Add-ons**, find **BlenderMCP**, turn it on and click **start MCP server**. Do this each time you work.
6. Start a new chat in the Claude app and paste a prompt from below. Claude writes and runs the code in your open scene, so you don't need to know any Python.
7. Save in Blender when you like the result. Changes show up in your scene right away, but they only reach your file when you save.

## More prompts
Ten chores to hand over. Paste one at a time with Blender open and the server started, and fill in the [BRACKETS].

**1. Clean up names**

```prompt
Rename every object, collection and material in my open Blender scene so each name says what it actually is. First show me a list of old name → new name, and flag any name that's misleading, like a collection called "rocks" that only holds pebbles. Wait for my OK before renaming anything.
```

**2. Find what slows your render**

```prompt
List the 10 heaviest meshes in my open Blender scene by polygon count. Next to each one, say how big it looks in the active camera's view. Flag any heavy mesh that looks small on screen, since that's where I can cut detail. Don't change anything.
```

**3. Explain a node setup**

```prompt
Explain the Geometry Nodes setup on the active object in my open Blender scene, node by node, in the order the data flows. Use plain words, as if I'm new to Geometry Nodes. Then add your notes as frame labels in the node editor so they're saved in my file.
```

**4. Check a material before deleting it**

```prompt
What in my Blender file uses the material [MATERIAL NAME]? List every object, node group and Geometry Nodes setup that uses it, and tell me what would break if I deleted it. Don't delete anything.
```

**5. Batch delete, safely**

```prompt
In my open Blender scene, find every object whose name starts with [PREFIX], except ones whose names start with [KEEP]. Show me the full list and how many there are. Don't delete anything until I say yes.
```

**6. Sort into collections**

```prompt
Sort everything in my open Blender scene into collections by type: [CATEGORIES, E.G. CHARACTERS, PROPS, LIGHTS, CAMERAS]. Show me what goes where before you move anything. Don't rename or delete anything.
```

**7. Clear out unused stuff**

```prompt
Find every material, mesh and image in my Blender file that nothing uses. List them by name before removing anything, and wait for my OK.
```

**8. Tune your render settings**

```prompt
Check the render settings in my open Blender scene for [GOAL, E.G. A FAST PREVIEW OR A FINAL 4K RENDER]. Tell me what each setting is now, what you'd change and why, in plain words. Don't change anything until I pick which changes to make.
```

**9. Name materials the same way**

```prompt
Rename every material in my Blender file to follow this pattern: [PATTERN, E.G. MAT_OBJECT_COLOR, LIKE MAT_CHAIR_RED]. Show me old name → new name first and wait for my OK.
```

**10. Make a reusable script**

```prompt
Write a reusable Blender Python script that [CHORE YOU REPEAT, E.G. ADDS A BEVEL MODIFIER TO EVERY SELECTED OBJECT]. Explain in plain words what it does and how I run it myself in Blender's Scripting tab. Don't run it on my scene yet.
```

## Watch out
- **Save a copy before big changes.** Use **File → Save Copy** before a batch delete or a big rename, so you still have the original if something goes wrong.
- **See the code first if you want.** Add "Show me the code before you run it" to any prompt.
- **Start the server every time.** If Claude says it can't reach Blender, check that Blender is open and click **start MCP server** again.
- **It can build things too.** It works through Blender's Python, so it can make objects as well. But the point here is the chores. The art stays yours.
- **The free plan has limits.** Claude's free plan has usage limits every 5 hours and every week, and long chats use them up faster. Blender itself is free for any use, including paid work.
