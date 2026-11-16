export type Project = {
  slug: string;
  name: string;
  category: string;
  meta: string;
  href?: string;
  external?: boolean;
  visual: string;
};

export const filters = ['All', 'Internal Tools', 'Open Source', 'Public Work', 'Product'];

export const projects: Project[] = [
  {
    slug: 'hourly-rainfall-calculator',
    name: 'Hourly Rainfall Calculator',
    category: 'Internal Tools',
    meta: 'Rainfall review without re-typing the same numbers',
    visual: 'visual-rain',
  },
  {
    slug: 'sunlight-analysis',
    name: 'Sunlight Analysis',
    category: 'Internal Tools',
    meta: 'Sunlight review engineers can explain to reviewers',
    visual: 'visual-sun',
  },
  {
    slug: 'slope-calculator',
    name: 'Slope Calculator',
    category: 'Internal Tools',
    meta: 'Fewer hand calculations in slope reviews',
    visual: 'visual-cad',
  },
  {
    slug: 'newwave',
    name: 'newWave',
    category: 'Open Source',
    meta: 'A lighter fork of Wave Terminal',
    href: 'https://github.com/SupaKang/newWave',
    external: true,
    visual: 'visual-system',
  },
  {
    slug: 'corpuskit',
    name: 'corpuskit',
    category: 'Open Source',
    meta: 'Searchable memory for AI coding agents',
    href: 'https://github.com/SupaKang/corpuskit',
    external: true,
    visual: 'visual-ai',
  },
  {
    slug: 'supergravity',
    name: 'SuperGravity',
    category: 'Open Source',
    meta: 'Web browser & app launcher inside VS Code',
    href: 'https://github.com/SupaKang/SuperGravity',
    external: true,
    visual: 'visual-workflow',
  },
  {
    slug: 'supablog',
    name: 'supablog',
    category: 'Product',
    meta: 'Astro / MDX / GitHub Pages',
    href: '/',
    visual: 'visual-ai',
  },
  {
    slug: 'subwayhero',
    name: 'SubwayHero',
    category: 'Public Work',
    meta: 'Product Prototype / UX',
    href: 'https://github.com/SupaKang/SubwayHero',
    external: true,
    visual: 'visual-workflow',
  },
  {
    slug: 'qr-generator',
    name: 'QR Generator',
    category: 'Public Work',
    meta: 'Browser Tool / QR',
    href: 'https://github.com/SupaKang/qr-generator',
    external: true,
    visual: 'visual-lilac',
  },
];
