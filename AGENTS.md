# AGENTS.md

Setup guide for installing Claude Code agent skills into this project.

## Skills

These skills come from [curiositech/some_claude_skills](https://github.com/curiositech/some_claude_skills) and are designed for ADHD-friendly workflows.

### ADHD-Focused Skills

| Skill | Description |
|-------|-------------|
| `adhd-daily-planner` | Time-blind friendly planning, executive function support, daily structure. Includes dopamine menu and executive function toolkit references. |
| `adhd-design-expert` | Designs digital experiences for ADHD brains - cognitive load reduction, time blindness solutions, dopamine-driven engagement. |
| `project-management-guru-adhd` | Project management for ADHD engineers - hyperfocus management, context-switching minimization, task chunking. |
| `tech-entrepreneur-coach-adhd` | Big tech to indie founder transition coaching with ADHD context - idea validation, MVP dev, sustainable growth. |
| `wisdom-accountability-coach` | Longitudinal memory tracking, philosophy teaching, personal accountability with compassion. |

### Complementary Skills

These pair well with the ADHD skills above:

| Skill | Why |
|-------|-----|
| `diagramming-expert` | Visual task mapping |
| `orchestrator` | Coordinate multiple project streams |

## Installation

### Automatic (SessionStart hook)

Skills install automatically when you start a Claude Code session — both on the web (claude.ai/code) and in the CLI. A [SessionStart hook](https://docs.anthropic.com/en/docs/claude-code/hooks) in `.claude/settings.json` runs `scripts/install-skills.sh`, which downloads skills from the upstream repo. The script is idempotent: it skips any skill that's already present.

You can also run it manually at any time:

```bash
bash scripts/install-skills.sh
```

The manual install options below are still available if you want to customize which skills are installed or install them globally.

### Option A: Project-Local Install

Installs skills into this repo's `.claude/skills/` directory. They'll be available whenever you open this project in Claude Code.

```bash
# From this repo's root directory:

# Pick the skills you want (example: all ADHD-focused skills)
SKILLS=(
  adhd-daily-planner
  adhd-design-expert
  project-management-guru-adhd
  tech-entrepreneur-coach-adhd
  wisdom-accountability-coach
)

REPO="curiositech/some_claude_skills"
BRANCH="main"

for skill in "${SKILLS[@]}"; do
  # Create skill directory
  mkdir -p ".claude/skills/${skill}"

  # Download SKILL.md (-s: silent, -f: fail on HTTP errors, -L: follow redirects)
  curl -sfL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/.claude/skills/${skill}/SKILL.md" \
    -o ".claude/skills/${skill}/SKILL.md"

  # Download reference files (if any)
  refs=$(gh api "repos/${REPO}/contents/.claude/skills/${skill}/references" --jq '.[].name' 2>/dev/null)
  if [ -n "$refs" ]; then
    mkdir -p ".claude/skills/${skill}/references"
    while IFS= read -r ref; do
      curl -sfL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/.claude/skills/${skill}/references/${ref}" \
        -o ".claude/skills/${skill}/references/${ref}"
    done <<< "$refs"
  fi

  echo "Installed: ${skill}"
done
```

### Option B: Global Install

Installs skills into `~/.claude/skills/` so they're available across all projects.

```bash
# Same script as above, but target the global directory:
TARGET_DIR="${HOME}/.claude/skills"

SKILLS=(
  adhd-daily-planner
  # ... add others as needed
)

REPO="curiositech/some_claude_skills"
BRANCH="main"

for skill in "${SKILLS[@]}"; do
  mkdir -p "${TARGET_DIR}/${skill}"

  # -s: silent, -f: fail on HTTP errors, -L: follow redirects
  curl -sfL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/.claude/skills/${skill}/SKILL.md" \
    -o "${TARGET_DIR}/${skill}/SKILL.md"

  refs=$(gh api "repos/${REPO}/contents/.claude/skills/${skill}/references" --jq '.[].name' 2>/dev/null)
  if [ -n "$refs" ]; then
    mkdir -p "${TARGET_DIR}/${skill}/references"
    while IFS= read -r ref; do
      curl -sfL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/.claude/skills/${skill}/references/${ref}" \
        -o "${TARGET_DIR}/${skill}/references/${ref}"
    done <<< "$refs"
  fi

  echo "Installed: ${skill}"
done
```

### Install a Single Skill

> **Note:** This one-liner only downloads `SKILL.md`. Skills with a `references/` directory (e.g. `adhd-daily-planner`) will be missing those files. Use Option A or B above for a complete install.

```bash
# Quick one-liner for a single skill (project-local):
SKILL="adhd-daily-planner"
REPO="curiositech/some_claude_skills"
mkdir -p ".claude/skills/${SKILL}" && \
# -s: silent, -f: fail on HTTP errors, -L: follow redirects
curl -sfL "https://raw.githubusercontent.com/${REPO}/main/.claude/skills/${SKILL}/SKILL.md" \
  -o ".claude/skills/${SKILL}/SKILL.md"
```

## Verification

After installing, confirm the skill files are in place:

```bash
# Project-local
find .claude/skills -name "SKILL.md" | sort

# Global
find ~/.claude/skills -name "SKILL.md" | sort
```

Skills are automatically picked up by Claude Code when present in `.claude/skills/` - no restart needed (just start a new conversation).

## Skill Anatomy

Each skill follows this structure:

```
.claude/skills/<skill-name>/
  SKILL.md          # Skill definition (YAML frontmatter + instructions)
  references/       # Optional supporting documents
    *.md
```

The `SKILL.md` frontmatter includes:
- `name` / `description` - identity and trigger phrases
- `allowed-tools` - which Claude Code tools the skill can use
- `category` / `tags` - classification
- `pairs-with` - recommended companion skills

## Browsing Available Skills

The source repo has 150+ skills. To browse all of them:

```bash
gh api repos/curiositech/some_claude_skills/contents/.claude/skills --jq '.[].name' | sort
```

Or visit: https://github.com/curiositech/some_claude_skills/tree/main/.claude/skills

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- [GitHub CLI](https://cli.github.com/) (`gh`) - used by the install script to list reference files
- `curl` - for downloading skill files
