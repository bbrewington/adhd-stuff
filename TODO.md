# TODO

## Done

- [x] Project scaffolding (README, AGENTS.md, CLAUDE.md, .gitignore)
- [x] Skill install scripts (project-local, global, single-skill)
- [x] Beginner-friendly prerequisites section in README
- [x] Dopamenu / personal settings template (`templates/my-settings.md`)
- [x] README "Make it yours" step linking to templates
- [x] SessionStart hook for automatic skill installation (`scripts/install-skills.sh`)
- [x] Web (claude.ai/code) Quick Start path in README
- [x] Remove `gh` CLI dependency from install flow (uses curl + GitHub API)

## Up Next

- [ ] Add a `templates/weekly-review.md` — guided end-of-week reflection for ADHD brains
- [ ] Add a `templates/project-triage.md` — quick "should I keep working on this?" decision helper
- [ ] Reference file install gap — `adhd-daily-planner` references (`dopamine-menu.md`, `executive-function-toolkit.md`) aren't in the upstream repo yet; track and update when available
- [ ] Consider a `/dopamenu` slash command skill that reads the user's filled-in template and suggests an activity based on current energy level

## Ideas (not committed to)

- Interactive setup — a skill or script that walks users through filling in `my-settings.md` conversationally instead of editing markdown by hand (the web path already suggests this via a prompt, but a dedicated skill would be more robust)
- Skill update mechanism — a way to check for upstream changes to installed skills and pull updates
- Community templates — a place for users to share their filled-in dopamenus (anonymized) as inspiration
