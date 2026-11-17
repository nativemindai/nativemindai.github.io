import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const link = z.strictObject({
  label: z.string().min(1),
  url: z.url({ protocol: /^https$/, error: 'Use a full https:// URL' }),
});

// The guide schema from CLAUDE.md. Strict objects: a misspelled or extra field fails the build too.
const guides = defineCollection({
  loader: glob({ pattern: '*.md', base: './src/content/guides' }),
  schema: z.strictObject({
    keyword: z
      .string()
      .regex(/^[A-Z0-9]+(-[A-Z0-9]+)*$/, 'Uppercase letters, digits and hyphens only, e.g. IPO'),
    title: z.string().min(1).max(60),
    hook: z.string().min(1).max(140),
    payoff: z.string().min(1),
    disclaimer: z.enum(['none', 'financial']),
    reel_date: z.coerce.date(),
    updated: z.coerce.date().optional(),
    sources: z.array(link).optional(),
    links: z.array(link).optional(),
    draft: z.boolean().default(false),
  }),
});

export const collections = { guides };
