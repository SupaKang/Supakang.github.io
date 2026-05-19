#!/usr/bin/env bash
# migrate-devlog.sh - OVERMIND blog-automation output -> Astro content collection
# Usage: ./scripts/migrate-devlog.sh <slug> <project_key> <YYYYMMDD>
# ASCII only

set -euo pipefail

if [ $# -ne 3 ]; then
  echo "usage: $0 <slug> <project_key:HRC|NM|OC|SL|WDD|CRW|DS> <YYYYMMDD>"
  exit 1
fi

slug="$1"
project_key="$2"
date_str="$3"

# Validate project_key
case "$project_key" in
  HRC|NM|OC|SL|WDD|CRW|DS) ;;
  *) echo "[error] invalid project_key: $project_key"; exit 1;;
esac

# Validate date_str (8 digits)
if ! [[ "$date_str" =~ ^[0-9]{8}$ ]]; then
  echo "[error] date_str must be YYYYMMDD (8 digits): $date_str"
  exit 1
fi

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
overmind_root="D:/Projects/infra/OVERMIND"
source_article="$overmind_root/blog-automation/outputs/$slug/article.md"
source_meta="$overmind_root/blog-automation/outputs/$slug/meta.json"
source_devlog="devlogs/$project_key/$date_str.md"
target_mdx="$repo_root/src/content/blog/$slug.mdx"

if [ ! -f "$source_article" ]; then
  echo "[error] source article not found: $source_article"
  exit 1
fi

if [ -f "$target_mdx" ]; then
  echo "[error] target already exists: $target_mdx"
  exit 1
fi

char_count=$(wc -m < "$source_article" | tr -d ' ')
read_min=$(( (char_count + 499) / 500 ))

# Extract from meta.json (if exists, via jq or basic grep fallback)
title='(title TBD)'
desc='(description TBD)'
keyword=''
tags=''

if [ -f "$source_meta" ] && command -v jq >/dev/null 2>&1; then
  title=$(jq -r '.title // "(title TBD)"' "$source_meta")
  desc=$(jq -r '.description // "(description TBD)"' "$source_meta")
  keyword=$(jq -r '.keyword // ""' "$source_meta")
  tags=$(jq -r '.tags | map("\"" + . + "\"") | join(", ")' "$source_meta")
fi

pub_date="${date_str:0:4}-${date_str:4:2}-${date_str:6:2}"

# Strip first H1 (BlogLayout shows frontmatter title separately)
body=$(sed -e '1{/^# /d;}' -e '2{/^$/d;}' "$source_article")

cat > "$target_mdx" <<EOF
---
title: "$title"
description: "$desc"
pubDate: $pub_date
project: "$project_key"
tags: [$tags]
keyword: "$keyword"
charCount: $char_count
readMin: $read_min
sourceDevlog: "$source_devlog"
---

$body
EOF

echo "[ok] migrated: $source_article -> $target_mdx"
echo "[info] charCount=$char_count readMin=$read_min"
echo ""
echo "next steps:"
echo "  1. review $target_mdx"
echo "  2. pnpm build"
echo "  3. git add src/content/blog/$slug.mdx && git commit -m 'post: $slug' && git push"
