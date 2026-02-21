# CLAUDE.md

## Project Overview

Setup guide and configuration repo for ADHD-focused Claude Code agent skills. Skills are installed (not vendored) from external sources into `.claude/skills/`.

## Repo Structure

- `README.md` - User-facing getting started guide (assumes reader is new to agent skills)
- `AGENTS.md` - Skill catalog, install scripts, and reference for skill structure
- `CLAUDE.md` - This file (instructions for Claude Code)
- `.claude/skills/` - Installed skills (gitignored, not committed)

## Conventions

- Skills are fetched from [curiositech/some_claude_skills](https://github.com/curiositech/some_claude_skills) at install time, not copied into the repo
- README.md targets a beginner audience - keep language plain and steps copy-pasteable
- AGENTS.md is the detailed reference - install options, skill anatomy, browsing
