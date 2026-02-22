#!/usr/bin/env bash
# Installs ADHD-focused Claude Code skills from the upstream repo.
# Designed to run as a SessionStart hook — idempotent and fast on re-runs.

set -euo pipefail

REPO="curiositech/some_claude_skills"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/.claude/skills"
API_URL="https://api.github.com/repos/${REPO}/contents/.claude/skills"

SKILLS=(
  adhd-daily-planner
  adhd-design-expert
  project-management-guru-adhd
  tech-entrepreneur-coach-adhd
  wisdom-accountability-coach
  diagramming-expert
  orchestrator
)

# Resolve target directory relative to the repo root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="${REPO_ROOT}/.claude/skills"

installed=0
skipped=0

for skill in "${SKILLS[@]}"; do
  skill_file="${TARGET_DIR}/${skill}/SKILL.md"

  # Skip if already installed (file exists and is non-empty)
  if [ -s "$skill_file" ]; then
    skipped=$((skipped + 1))
    continue
  fi

  mkdir -p "${TARGET_DIR}/${skill}"

  # Download SKILL.md
  if curl -sfL "${BASE_URL}/${skill}/SKILL.md" -o "$skill_file"; then
    # Download reference files (if any) using GitHub API via curl
    refs=$(curl -sf "${API_URL}/${skill}/references" 2>/dev/null \
      | grep -o '"name":"[^"]*"' \
      | sed 's/"name":"//;s/"//' || true)

    if [ -n "$refs" ]; then
      mkdir -p "${TARGET_DIR}/${skill}/references"
      while IFS= read -r ref; do
        curl -sfL "${BASE_URL}/${skill}/references/${ref}" \
          -o "${TARGET_DIR}/${skill}/references/${ref}" || true
      done <<< "$refs"
    fi

    installed=$((installed + 1))
  else
    echo "Warning: failed to download ${skill}" >&2
  fi
done

if [ "$installed" -gt 0 ]; then
  echo "Installed ${installed} skill(s), ${skipped} already present."
elif [ "$skipped" -gt 0 ]; then
  echo "All ${skipped} skill(s) already installed."
fi
