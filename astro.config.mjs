// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://nativemindai.github.io',
  // DM links must load exactly as typed: /ipo, no trailing slash, no redirect.
  // 'file' builds ipo.html, which GitHub Pages serves at /ipo with a 200.
  // The default ('directory') builds ipo/index.html, which GitHub Pages
  // answers with a 301 to /ipo/. 'never' makes the dev server match.
  trailingSlash: 'never',
  build: {
    format: 'file',
    // The CSS is small; inlining it saves a round trip in slow in-app browsers.
    inlineStylesheets: 'always',
  },
  markdown: {
    // Guides have no code to highlight. ```prompt blocks become copy boxes
    // in src/layouts/Guide.astro (see src/lib/prompt-box.ts).
    syntaxHighlight: false,
  },
  // Keeps the dev overlay off the page when previewing on a phone.
  devToolbar: { enabled: false },
});
