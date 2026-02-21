# TODO

## Done

- [x] Project scaffolding (README, AGENTS.md, CLAUDE.md, .gitignore)
- [x] Skill install scripts (project-local, global, single-skill)
- [x] Beginner-friendly prerequisites section in README
- [x] Dopamenu / personal settings template (`templates/my-settings.md`)
- [x] README "Make it yours" step linking to templates

## Up Next

- [ ] Add more templates (e.g. weekly review, project triage checklist)
- [ ] Add a `templates/weekly-review.md` — guided end-of-week reflection for ADHD brains
- [ ] Add a `templates/project-triage.md` — quick "should I keep working on this?" decision helper
- [ ] Reference file install gap — the install scripts pull reference files, but `adhd-daily-planner` references (`dopamine-menu.md`, `executive-function-toolkit.md`) aren't in the upstream repo yet; track and update when available
- [ ] Consider a `/dopamenu` slash command skill that reads the user's filled-in template and suggests an activity based on current energy level

## Ideas (not committed to)

- Interactive setup — a skill or script that walks users through filling in `my-settings.md` conversationally instead of editing markdown by hand
- Skill update mechanism — a way to check for upstream changes to installed skills and pull updates
- Community templates — a place for users to share their filled-in dopamenus (anonymized) as inspiration
