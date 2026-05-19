# migrate-devlog.ps1 - OVERMIND blog-automation output -> Astro content collection
# Usage: ./scripts/migrate-devlog.ps1 -Slug my-post -ProjectKey HRC -Date 20260520
# ASCII only (PowerShell 5.1 safety per OVERMIND/specs/HRC feedback_postgis_compose_migration_runner)

param(
  [Parameter(Mandatory=$true)][string]$Slug,
  [Parameter(Mandatory=$true)][ValidateSet('HRC','NM','OC','SL','WDD','CRW','DS')][string]$ProjectKey,
  [Parameter(Mandatory=$true)][ValidatePattern('^\d{8}$')][string]$Date
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$overmindRoot = 'D:\Projects\infra\OVERMIND'
$sourceArticle = Join-Path $overmindRoot "blog-automation\outputs\$Slug\article.md"
$sourceMeta = Join-Path $overmindRoot "blog-automation\outputs\$Slug\meta.json"
$sourceDevlog = "devlogs/$ProjectKey/$Date.md"
$targetMdx = Join-Path $repoRoot "src\content\blog\$Slug.mdx"

if (-not (Test-Path $sourceArticle)) {
  Write-Host "[error] source article not found: $sourceArticle"
  exit 1
}
if (Test-Path $targetMdx) {
  Write-Host "[error] target already exists: $targetMdx (use -Force to overwrite)"
  exit 1
}

$articleBody = Get-Content $sourceArticle -Raw -Encoding UTF8
$charCount = $articleBody.Length
$readMin = [math]::Ceiling($charCount / 500.0)

$meta = $null
if (Test-Path $sourceMeta) {
  $meta = Get-Content $sourceMeta -Raw -Encoding UTF8 | ConvertFrom-Json
}

$title = if ($meta -and $meta.title) { $meta.title } else { '(title TBD)' }
$desc = if ($meta -and $meta.description) { $meta.description } else { '(description TBD)' }
$keyword = if ($meta -and $meta.keyword) { $meta.keyword } else { '' }
$tags = if ($meta -and $meta.tags) { ($meta.tags | ForEach-Object { "`"$_`"" }) -join ', ' } else { '' }

$pubDate = "{0}-{1}-{2}" -f $Date.Substring(0,4), $Date.Substring(4,2), $Date.Substring(6,2)

# Strip first H1 (BlogLayout shows frontmatter title separately, avoid duplication)
$body = $articleBody -replace '^# .+\r?\n\r?\n', ''

$frontmatter = @"
---
title: "$title"
description: "$desc"
pubDate: $pubDate
project: "$ProjectKey"
tags: [$tags]
keyword: "$keyword"
charCount: $charCount
readMin: $readMin
sourceDevlog: "$sourceDevlog"
---

"@

[System.IO.File]::WriteAllText($targetMdx, $frontmatter + $body, [System.Text.UTF8Encoding]::new($false))

Write-Host "[ok] migrated: $sourceArticle -> $targetMdx"
Write-Host "[info] charCount=$charCount readMin=$readMin"
Write-Host ""
Write-Host "next steps:"
Write-Host "  1. review $targetMdx"
Write-Host "  2. pnpm build"
Write-Host "  3. git add src/content/blog/$Slug.mdx; git commit -m 'post: $Slug'; git push"
