# adhd-stuff

By the end of this guide, you'll have a small set of ADHD-friendly helpers running inside [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that you can trigger just by asking for help.

## What Are Agent Skills?

Agent skills are reusable instruction files that tell Claude "here is how to help in this kind of situation," like ADHD-aware day planning or project triage.

When you type a message in Claude Code, it checks whether any installed skill matches your request and activates the relevant one automatically. For example, if you have the `adhd-daily-planner` skill installed and ask Claude to "help me plan my day", it will use ADHD-specific strategies like the 3-Things System, time-blind-friendly scheduling, and transition buffers - instead of generic productivity advice.

Skills live as files on your machine. Claude Code reads them at the start of each conversation. No extra API keys or third-party services — just your existing Anthropic account.

If you've ever installed a browser extension or a VS Code extension, skills are similar - but they're just plain text files on your computer.

## Prerequisites

You'll need a few things installed before getting started. Don't worry if some of these words are new. You'll only install each tool once, and you can copy-paste every command.

**The core tools:**

- **A terminal** - where you'll type commands
- **Claude Code** - the tool that runs the skills

**Supporting tools** (installed once, then you can forget about them):

- **Node.js** - required by Claude Code
- **Git** - to download this repo
- **GitHub CLI** (`gh`) - used by the install scripts

Expand any section below for step-by-step install instructions.

<details>
<summary>New to the terminal? Start here</summary>

The terminal (also called command line or shell) is a text-based way to interact with your computer. Instead of clicking icons, you type commands.

Everything in this guide runs as a normal user. You're very unlikely to break your computer by running these commands.

**How to open it:**
- **Mac**: Press `Cmd + Space`, type "Terminal", hit Enter
- **Windows**: Open PowerShell or Command Prompt (press `Win + R`, type `wt` or `cmd`, hit Enter)
- **Linux**: Press `Ctrl + Alt + T`

**Key concepts:**
- You type a command and press Enter to run it
- When you see a code block in this guide, you can copy the whole thing, paste it into your terminal, and press Enter
- If something says `cd some-folder`, that means "change directory" (navigate into that folder)
- If a command starts with `$`, don't type the `$` - it just means "this is a terminal command"

**If something goes wrong:** read the last 1-2 lines of the error message; they usually say what happened. You can always run a command again - it won't hurt anything.

</details>

<details>
<summary>How to install Node.js</summary>

Node.js is a tool that runs JavaScript outside of a browser. Claude Code is built with it.

**Check if you already have it:**
```bash
node --version
```
If you see something like `v20.11.0` (v18 or higher), you're done. If you get "command not found", install it:

**Mac:**
```bash
brew install node
```
Don't have `brew`? Install [Homebrew](https://brew.sh) first by pasting this into your terminal:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Windows:** Download from [nodejs.org](https://nodejs.org/) (pick the LTS version). You can run commands in PowerShell or Command Prompt.

**Linux:** Download from [nodejs.org](https://nodejs.org/) (pick the LTS version), or use your package manager.

</details>

<details>
<summary>How to install Git</summary>

Git is version control software - it tracks changes to code and lets you download repositories like this one.

**Check if you already have it:**
```bash
git --version
```
If you see something like `git version 2.43.0`, you're set. If not:

**Mac:**
```bash
brew install git
```
Or just try running `git` - macOS will prompt you to install developer tools, which includes Git.

**Windows:** Download from [git-scm.com](https://git-scm.com/downloads)

**Linux:**
```bash
sudo apt install git        # Ubuntu/Debian
sudo dnf install git        # Fedora
```

</details>

<details>
<summary>How to install the GitHub CLI</summary>

The GitHub CLI lets you interact with GitHub from your terminal. The skill install scripts use it to discover which files each skill includes.

**Install:**
```bash
brew install gh              # Mac
winget install GitHub.cli    # Windows
sudo apt install gh          # Ubuntu/Debian
```
See [cli.github.com](https://cli.github.com/) for other options.

**Then authenticate (one-time setup):**
```bash
gh auth login
```
Follow the prompts - it will open a browser to log in to your GitHub account. When it's done, you should see a line like `Logged in as your_username`.

</details>

<details>
<summary>How to install Claude Code</summary>

Claude Code is Anthropic's command-line tool for working with Claude. It's what reads and runs the skills.

**Install:**
```bash
npm install -g @anthropic-ai/claude-code
```

**Verify it worked:**
```bash
claude --version
```
If you see a version number, you're good.

The first time you run `claude`, it will ask you to sign in with your Anthropic account.

If you prefer not to install Node.js, there are also standalone install options in the [Claude Code quickstart docs](https://docs.anthropic.com/en/docs/claude-code/overview).

</details>

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/bbrewington/adhd-stuff.git
cd adhd-stuff
```

### 2. Install skills

Open Claude Code in this directory:

```bash
claude
```

When Claude opens, paste this as your first message:

```text
Install the ADHD skills listed in AGENTS.md
```

Then press Enter and wait while it runs through the install steps. This may take up to a minute - that's normal. Claude may ask permission to run commands — click **Allow**.

### 3. Use it

Start a new conversation (skills load at conversation start) and try prompts like:
- "Help me plan my day" (activates `adhd-daily-planner`)
- "I'm overwhelmed and can't start anything" (activates `adhd-daily-planner` crisis protocol)
- "Help me manage my three projects" (activates `project-management-guru-adhd`)
- "I want to build an MVP for my side project" (activates `tech-entrepreneur-coach-adhd`)

Skills activate automatically based on what you ask. You can also invoke a skill by mentioning its name directly in your message (e.g. "use adhd-daily-planner").

### 4. Make it yours (optional)

The skills work out of the box, but they get better when they know your patterns. There's a template you can fill in with your own dopamenu, energy patterns, and startup tricks:

```bash
# Copy the template into your CLAUDE.md (or create a new one)
cat templates/my-settings.md >> CLAUDE.md
```

Then open `CLAUDE.md` and fill in your own items. The skills will pick up your preferences automatically in the next conversation.

## How It Works

```
your-project/
  .claude/
    skills/
      adhd-daily-planner/
        SKILL.md              <-- Claude reads this
        references/
          dopamine-menu.md    <-- Supporting material
          executive-function-toolkit.md
      another-skill/
        SKILL.md
```

In plain language: each skill is a folder with a `SKILL.md` file that tells Claude "who this skill is for and how to behave," plus any extra reference notes it can draw from.

Skills are loaded when a new conversation starts. If you install or edit a skill, start a new chat in Claude Code so it picks up the changes.

## Available Skills

See [AGENTS.md](AGENTS.md) for the full list of curated skills, descriptions, install options (project-local vs global), and how to browse the 150+ skills in the source repo.

## FAQ

**Do I need to restart Claude Code after installing skills?**
No, but you do need to start a new conversation. Skills are loaded at conversation start.

**Can I edit the skills after installing?**
Yes. They're just markdown files on your machine. Edit them however you like.

**Can I uninstall a skill?**
Yes. Delete its folder from `.claude/skills/` (or rename it), and it will stop loading.

**What's the difference between project-local and global install?**
Project-local (`.claude/skills/` in a repo) means skills are only active when Claude Code is opened in that directory. Global (`~/.claude/skills/`) means they're active everywhere. See [AGENTS.md](AGENTS.md) for global install instructions.

**Where do the skills come from?**
[curiositech/some_claude_skills](https://github.com/curiositech/some_claude_skills) - an open-source collection of 150+ Claude Code skills.

**Do skills use extra API credits?**
Skills add context to your conversations, so they increase token usage slightly. The ADHD skills are moderate in size. You're not charged anything beyond normal Claude Code usage.

**Can I use skills without this repo?**
Absolutely. This repo is just a setup guide. You can install skills into any project's `.claude/skills/` directory or globally into `~/.claude/skills/`.

**What if this all feels like too much?**
Start with just one thing: get Claude Code installed and working. Once you can run `claude` and have a chat, come back and do the repo clone and skill install. You can do this in small chunks.
