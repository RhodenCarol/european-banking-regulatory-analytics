<#
    European Banking Regulatory Analytics
    Tool: Repository Setup

    Creates the repository directories and initial documentation files.
    Existing files are preserved.
#>

$ErrorActionPreference = "Stop"

$directories = @(
    "knowledge-base/concepts",
    "knowledge-base/datasets",
    "knowledge-base/organizations",
    "knowledge-base/regulatory-framework",
    "docs/adr",
    "docs/chapters/part_1_foundations",
    "data/raw",
    "data/processed",
    "data/sample",
    "analytics/notebooks",
    "analytics/src",
    "analytics/sql",
    "analytics/tests",
    "dashboard",
    "reports",
    "tools"
)

$files = @{
    "knowledge-base/concepts/README.md" = @"
# Concepts

This section contains reusable definitions of banking, regulatory and data analytics concepts referenced throughout the project.

Examples include:

- Capital adequacy
- Liquidity
- Solvency
- Risk appetite
- Prudential supervision
- Data quality
"@

    "knowledge-base/datasets/README.md" = @"
# Datasets

This section documents the official public datasets evaluated or used throughout the project.

Each dataset document should include:

- Purpose
- Data owner
- Official source
- Download URL
- Publication date
- Download date
- Version
- File format
- Variables
- License
- Known limitations
"@

    "knowledge-base/organizations/README.md" = @"
# Organizations

This section documents the institutions involved in European banking regulation and supervision.

Examples include:

- European Banking Authority (EBA)
- European Central Bank (ECB)
- Bank for International Settlements (BIS)
- Basel Committee on Banking Supervision (BCBS)
- European Systemic Risk Board (ESRB)
"@

    "knowledge-base/regulatory-framework/README.md" = @"
# Regulatory Framework

This section contains independent summaries of regulatory standards, frameworks and European legal instruments referenced throughout the project.

Each document should include:

- Purpose
- Historical context
- Regulatory nature
- Scope
- Main components
- Related organizations
- Official sources
- Related concepts
"@

    "docs/README.md" = @"
# Documentation

This directory contains the project methodology, architectural decisions, conventions and analytical chapters.

The chapters may reference the Knowledge Base. Knowledge Base documents must remain independent from the chapters.
"@

    "docs/adr/README.md" = @"
# Architecture Decision Records

This directory records important architectural and methodological decisions that affect the long-term structure of the repository.

New records should be created only for decisions that are significant and difficult to reverse.
"@

    "docs/chapters/README.md" = @"
# Chapters

The chapters provide the structured narrative of the project.

They connect regulatory context, official sources, public data, analytical methods and interpretation while linking to reusable Knowledge Base documents.
"@

    "docs/chapters/part_1_foundations/README.md" = @"
# Part I — Foundations

This part establishes the business, historical and regulatory foundations required for the analytical modules of the project.
"@

    "docs/project_methodology.md" = @"
# Project Methodology

The detailed project methodology will be developed during the Foundation Edition.
"@

    "docs/project_conventions.md" = @"
# Project Conventions

The naming, documentation, citation, data versioning and contribution conventions will be defined during the Foundation Edition.
"@

    "docs/references.bib" = ""

    "data/README.md" = @"
# Data

This directory contains metadata, samples and local working directories for project datasets.

Large raw and processed datasets should not be committed to Git unless explicitly justified.

Every dataset used in a published analysis must be documented with its source, version, publication date, download date and known limitations.
"@

    "data/manifest.csv" = "dataset_id,name,source_url,publication_date,download_date,version,local_filename,sha256,license,status"

    "analytics/README.md" = @"
# Analytics

This directory contains notebooks, reusable source code, SQL queries and tests used in the analytical implementation.
"@

    "dashboard/README.md" = @"
# Dashboard

This directory will contain the public interactive presentation layer for the analytical results.
"@

    "reports/README.md" = @"
# Reports

This directory will contain generated figures, tables and analytical outputs intended for publication or presentation.
"@

    "tools/README.md" = @"
# Tools

This directory contains utilities that automate repository setup, data acquisition, validation, documentation and publication tasks.
"@
}

foreach ($directory in $directories) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}

foreach ($path in $files.Keys) {
    if (Test-Path $path) {
        Write-Host "Skipped existing file: $path"
        continue
    }

    $parent = Split-Path -Parent $path

    if ($parent) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    Set-Content -Path $path -Value $files[$path] -Encoding UTF8
    Write-Host "Created: $path"
}

Write-Host ""
Write-Host "Repository documentation structure created successfully."