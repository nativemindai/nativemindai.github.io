// Turns every ```prompt block in a guide into a prompt box with a COPY button.
// Markdown renders the block as <pre><code class="language-prompt">…</code></pre>,
// with the text already HTML-escaped. The click handler is the inline script in
// src/layouts/Guide.astro.

const PROMPT_BLOCK = /<pre[^>]*>\s*<code[^>]*\bclass="language-prompt"[^>]*>([\s\S]*?)<\/code>\s*<\/pre>/g;

// [BRACKETS] are the parts the reader fills in; mark them so they stand out.
const markFillIns = (text: string) => text.replace(/\[[^\]\n<]+\]/g, '<span class="fill">$&</span>');

const promptBox = (text: string) =>
  '<div class="prompt">' +
  '<div class="prompt-bar"><span class="prompt-label">PROMPT</span>' +
  '<button type="button" class="copy" data-copy>COPY</button></div>' +
  `<pre class="prompt-text">${markFillIns(text.replace(/\n+$/, ''))}</pre>` +
  '<p class="copy-hint" role="status" hidden>Press and hold to copy</p>' +
  '</div>';

export function promptBoxes(html: string): string {
  return html.replace(PROMPT_BLOCK, (_, text: string) => promptBox(text));
}
