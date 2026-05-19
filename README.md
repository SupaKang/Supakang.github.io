# supablog

Personal tech blog + portfolio. Astro SSG + Tailwind v4 + 099 design.

Public URL: https://supakang.github.io/

## Stack

- **SSG**: [Astro 6.x](https://astro.build) + content collections (.mdx)
- **CSS**: [Tailwind v4](https://tailwindcss.com) (`@theme` + `@tailwindcss/vite`)
- **Design**: [099 Style Reference](https://099.supply) — achromatic / monospace / dark
- **Deploy**: GitHub Actions (`withastro/action@v3` + `actions/deploy-pages@v4`) → GitHub Pages
- **Notion sync**: Tech Blog DB (`HTML URL` field auto-backfill on publish)

## Local dev

```bash
pnpm install
pnpm dev          # http://localhost:4321/
pnpm build        # dist/ static output
pnpm preview      # preview built site
pnpm check        # astro check (type + collection schema)
```

## Auto deploy (git push → public URL)

`main` branch push → GitHub Actions trigger → `withastro/action@v3` build → `actions/deploy-pages@v4` publish → https://supakang.github.io/ 갱신.

Lead time 예상: < 5분 (build ~2분 + deploy ~1분).

```bash
git add .
git commit -m "..."
git push origin main
# → Actions tab 에서 진행 상황 확인
# → 완료 시 https://supakang.github.io/ 갱신
```

수동 trigger: GitHub Actions tab → `Deploy supablog to GitHub Pages` → `Run workflow`.

## 내용 수정 프로세스

### 1. 신규 blog post (devlog → mdx 마이그레이션)

devlog 가 OVERMIND 에 있으면 자동 변환:

```bash
# Windows (PowerShell)
./scripts/migrate-devlog.ps1 -Slug "my-post" -ProjectKey HRC -Date 20260520

# Linux/macOS (bash)
./scripts/migrate-devlog.sh my-post HRC 20260520
```

수동:
1. `src/content/blog/{slug}.mdx` 신규 생성
2. frontmatter 작성 (title / description / pubDate / project / tags / readMin)
3. 본문 작성 (markdown + MDX)
4. `pnpm build` 로컬 검증
5. `git add src/content/blog/{slug}.mdx && git commit -m "post: {slug}" && git push`
6. Actions 자동 build/deploy → 외부 URL: `https://supakang.github.io/blog/{slug}/`

### 2. 기존 blog post 수정

```bash
vim src/content/blog/{slug}.mdx   # 본문 수정
pnpm build                        # 로컬 검증
git add src/content/blog/{slug}.mdx
git commit -m "edit: {slug}"
git push
```

### 3. About / Projects / Contact 페이지 수정

```bash
vim src/pages/about.astro      # bio / career / stack
vim src/pages/projects.astro   # 7 프로젝트 description
vim src/pages/contact.astro    # GitHub / Email / Twitter
```

### 4. 디자인 토큰 수정 (099 색·spacing·radius)

```bash
vim src/styles/global.css      # @theme 블록 안 토큰
# 또는 component 별 <style>
```

## frontmatter schema (src/content.config.ts)

| 필드 | 타입 | 필수 | 비고 |
|---|---|---|---|
| `title` | string | ✓ | post 제목 |
| `description` | string | ✓ | meta description (120-160자) |
| `pubDate` | date | ✓ | YYYY-MM-DD |
| `project` | enum | - | HRC/NM/OC/SL/WDD/CRW/DS |
| `tags` | string[] | - | 기본 `[]` |
| `keyword` | string | - | 핵심 SEO 키워드 |
| `charCount` | number | - | 본문 글자 수 |
| `readMin` | number | - | char_count / 500 |
| `sourceDevlog` | string | - | `devlogs/{PROJECT_KEY}/{YYYYMMDD}.md` |
| `notionUrl` | string (url) | - | Notion Tech Blog row URL |

## 디렉토리 구조

```
src/
├── pages/                  # Astro pages (라우팅)
│   ├── index.astro         # /
│   ├── about.astro         # /about/
│   ├── projects.astro      # /projects/
│   ├── contact.astro       # /contact/
│   └── blog/
│       ├── index.astro     # /blog/
│       └── [...slug].astro # /blog/{slug}/
├── content/blog/           # blog post .mdx 파일
├── layouts/                # BaseLayout
├── components/             # Header, Footer
├── styles/                 # global.css (099 토큰)
└── content.config.ts       # content collection schema

scripts/
├── migrate-devlog.ps1      # Windows: devlog → mdx
└── migrate-devlog.sh       # Linux/macOS

.github/workflows/
└── deploy.yml              # Astro build → Pages deploy
```

## 관련 spec

`D:\Projects\infra\OVERMIND\specs\HRC\20260519_github_pages_publish_automation_v4.md`

## License

MIT
