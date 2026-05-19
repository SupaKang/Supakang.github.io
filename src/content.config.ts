import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    project: z.enum(['HRC', 'NM', 'OC', 'SL', 'WDD', 'CRW', 'DS']).optional(),
    tags: z.array(z.string()).default([]),
    keyword: z.string().optional(),
    charCount: z.number().optional(),
    readMin: z.number().optional(),
    sourceDevlog: z.string().optional(),
    notionUrl: z.string().url().optional(),
  }),
});

export const collections = { blog };
