export type Project = {
  slug: string;
  name: string;
  category: string;
  meta: string;
  href?: string;
  external?: boolean;
  visual: string;
};

export const filters = ['All', 'Internal Tools', 'GIS / CAD', 'Public Work', 'Product'];

export const projects: Project[] = [
  {
    slug: 'hourly-rainfall-calculator',
    name: 'Hourly Rainfall Calculator',
    category: 'Internal Tools',
    meta: 'HRC | React / TypeScript / FastAPI / Python',
    visual: 'visual-rain',
  },
  {
    slug: 'sunlight-analysis',
    name: 'Sunlight Analysis',
    category: 'GIS / CAD',
    meta: 'SL | GIS / CAD-DXF / React / Firebase',
    visual: 'visual-sun',
  },
  {
    slug: 'slope-calculator',
    name: 'Slope Calculator',
    category: 'Internal Tools',
    meta: 'Slope | FastAPI / Python / Domain Logic',
    visual: 'visual-cad',
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
    slug: 'flixkookoo',
    name: 'FlixKooKoo',
    category: 'Public Work',
    meta: 'Movie Search · Watchlist',
    href: 'https://github.com/SupaKang/flixkookoo',
    external: true,
    visual: 'visual-system',
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
