---
keyword: FOLIO
title: "Build a free portfolio website without touching code"
hook: "Pick your six best pieces, paste one prompt into Claude, and host the page free on GitHub Pages. No template, no monthly bill."
payoff: "the prompt + the five-minute upload steps"
disclaimer: none
reel_date: 2026-11-28
sources:
  - label: "GitHub Docs: GitHub Pages limits"
    url: "https://docs.github.com/en/pages/getting-started-with-github-pages/github-pages-limits"
  - label: "GitHub Docs: Creating a GitHub Pages site"
    url: "https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site"
  - label: "GitHub Docs: Configuring a publishing source for your GitHub Pages site"
    url: "https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site"
  - label: "GitHub Docs: Adding a file to a repository"
    url: "https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository"
  - label: "Claude Help Center: What are artifacts and how do I use them?"
    url: "https://support.claude.com/en/articles/9487310-what-are-artifacts-and-how-do-i-use-them"
  - label: "Claude Help Center: Create and edit files with Claude"
    url: "https://support.claude.com/en/articles/12111783-create-and-edit-files-with-claude"
links:
  - label: "Open Claude"
    url: "https://claude.ai"
  - label: "Open GitHub"
    url: "https://github.com"
  - label: "GitHub Pages help"
    url: "https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site"
---

## The short version
Claude can write a whole portfolio website from one prompt, and GitHub Pages puts it online free at yourname.github.io.
You bring the part that matters, your six best pieces and a line about each, and you never pay a monthly bill or touch code.

## Do this
1. Pick your six best pieces and write one line about each. This part is yours, so write it the way you'd say it. Save the photos as JPGs named **piece1.jpg** to **piece6.jpg**, all lowercase, in the same order as your lines.
2. Open Claude at **claude.ai** (the free plan works), start a new chat and paste this with your details filled in:

   ```prompt
   Build me a one-page portfolio website as one self-contained file named index.html, and give it to me as a file I can download. Put everything in that one file: no outside libraries, frameworks, fonts or trackers.

   About me:
   - Name or brand: [NAME]
   - What I make: [WHAT YOU MAKE, E.G. ILLUSTRATION, PHOTOGRAPHY, CERAMICS]
   - The vibe: [3–5 WORDS, E.G. CALM, BOLD, A BIT STRANGE]
   - Colors: [COLORS YOU WANT, OR "YOU PICK"]
   - Contact: [YOUR EMAIL OR INSTAGRAM LINK]
   - About me, in my own words: [1–3 SENTENCES]

   My 6 pieces. The images will sit next to index.html, named exactly piece1.jpg, piece2.jpg, piece3.jpg, piece4.jpg, piece5.jpg and piece6.jpg. Use my lines as the captions, word for word:
   1. [ONE LINE ABOUT PIECE 1]
   2. [ONE LINE ABOUT PIECE 2]
   3. [ONE LINE ABOUT PIECE 3]
   4. [ONE LINE ABOUT PIECE 4]
   5. [ONE LINE ABOUT PIECE 5]
   6. [ONE LINE ABOUT PIECE 6]

   The page:
   - My name and what I make at the top.
   - A gallery of the 6 pieces with their captions.
   - A short about section, using only what I wrote above.
   - A contact section with my contact link.

   Rules:
   - Mobile-first: it must look great on a phone, then on a computer.
   - Fast: keep the code small and lazy-load the images.
   - Give every image alt text based on its caption.
   - Don't invent anything about me or my work: no made-up clients, awards, quotes, prices or bio details. If something is missing, leave it out.
   - My images won't show in your preview yet. That's fine. Don't swap in stock photos or images from the web.

   Show me the page, then ask me what I'd like to change.
   ```

3. Ask for changes in plain words until you like it, like "make the photos bigger" or "more space between the pieces". Your photos won't show in Claude's preview yet. That's normal. When it's right, tap **Download** on the **index.html** file Claude made. If it saves with another name, rename it **index.html**.
4. Make a free account at **github.com**, then tap **+** and **New repository**. Name it **yourname.github.io**, using your GitHub username in place of yourname, all lowercase. Choose **Public**, switch **Add README** to **On** and tap **Create repository**.
5. Upload your site. In the new repository, tap **Add file → Upload files**, drop in **index.html** and your six photos, then tap the green **Commit changes** button at the bottom. GitHub's help page calls it **Propose changes**.
6. Turn the site on. Tap **Settings**, then **Pages** in the side menu. Under **Source**, pick **Deploy from a branch**. Under **Branch**, pick **main** and **/ (root)**, then tap **Save**.
7. Open **https://yourname.github.io** in a few minutes (it can take up to 10). That's your live site, ready for your bio.

## More prompts
Keep going in the same Claude chat. After every change, download the new index.html and upload it again the same way as step 5. It replaces the old one.

```prompt
Make my portfolio page feel more like [REFERENCE SITE] without copying it. What I like about it: [WHAT YOU LIKE, E.G. THE BIG TYPE, THE CALM SPACING]. Borrow the feel only, not its layout, words or images. Keep my photos, captions and contact the same. My page is above in this chat (if not, I've attached my index.html). Give me the updated index.html file.
```

```prompt
Add a section to my portfolio page for [NEW PROJECT]. In my words: [ONE OR TWO LINES ABOUT IT]. Its images will sit next to index.html, named exactly [FILE NAMES, E.G. project1.jpg, project2.jpg]. Match the style of the rest of the page and don't invent any details. My page is above in this chat (if not, I've attached my index.html). Give me the updated index.html file.
```

## Watch out
- **Everything you upload is public.** Free GitHub Pages sites need a public repository, so anyone can see every file in it, not just the page. Don't upload anything private.
- **Photos can carry hidden location data.** A photo straight off your phone can record where it was taken. Turn the location off before you upload (most phones let you when you share or export a photo).
- **File names must match exactly.** piece1.jpg and Piece1.JPG aren't the same file to a website. If a photo doesn't show, check its name first.
- **Shrink big photos.** About 2000 pixels wide is plenty, and the page loads faster. GitHub's website takes files up to 25 MB each, and a site can be up to 1 GB, with a soft limit of 100 GB of traffic a month.
- **Your address is your username.** The free address is yourname.github.io, and each account gets one. A custom address like yourname.com means buying a domain, which costs extra.
- **Not for an online store.** GitHub says Pages isn't free hosting for an online business, an e-commerce site or anything built around selling.
- **Claude only shows code?** Go to **Settings → Capabilities** and turn on **Code execution and file creation** (called **Create and edit files** in the newer layout). It's on by default on the free plan.
