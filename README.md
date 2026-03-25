# Dual-Brain Devkit

> Run two AI coding assistants in parallel — one builds, one thinks.

A framework for running Claude Code and Gemini CLI as parallel AI coding assistants on the same project. Each AI gets its own context file with a defined role, shared conventions, and instructions to sync with the other — so they stay aligned without stepping on each other.

## The idea

Most AI coding workflows use one model. This uses two in split terminals:

- **Claude Code** (left terminal) — the builder. Writes code, runs commands, handles git, deploys.
- **Gemini CLI** (right terminal) — the thinker. Architecture, algorithms, debugging, code review.

The key is that both AIs read from shared context files that keep them in sync. When Gemini makes an architecture decision, it gets written down. When Claude ships a feature, it gets written down. Neither AI works in a vacuum.

## What it scaffolds

Run `new-project.sh` and it creates three files in your project:

```bash
./new-project.sh my-app "Next.js, Supabase, Vercel"
```

### `CLAUDE.md` — Claude Code's context file

Loaded automatically by Claude Code at session start. Contains:

- **Project overview** — what the project does, repo URL, deployment URL
- **Tech stack & structure** — so Claude knows what it's working with
- **Conventions** — TypeScript strict mode, functional components, Supabase RPC patterns, commit message format (`feat:`, `fix:`, `refactor:`, `chore:`)
- **Cross-context sync** — instructs Claude to read GEMINI.md at the start of each session and absorb any architecture decisions made while it was offline
- **Housekeeping** — after completing a feature, Claude updates both context files

### `GEMINI.md` — Gemini CLI's context file

Loaded by Gemini CLI. Contains:

- **Same project overview and stack** as CLAUDE.md (both need the same baseline)
- **Role definition** — explicitly tells Gemini it's a thinking partner, not a builder. Its strengths: logic/algorithms, data modeling, architecture decisions, code review, frontend visual debugging, library research
- **Boundary** — Claude Code handles all file creation, editing, git, and deployment. Gemini provides the thinking, Claude does the building.
- **Cross-context sync** — instructs Gemini to read CLAUDE.md at session start to see what Claude has shipped since the last session
- **Housekeeping** — after architecture discussions, Gemini updates its file and flags if CLAUDE.md needs changes too

### `ROUTING-PROTOCOL.md` — Decision framework

A reference doc (for you, the developer) that defines when to use which AI:

- **Quick decision rule** — "Am I building, or am I thinking?" Building = Claude. Thinking = Gemini.
- **Handoff pattern** — hit a wall in Claude Code -> open Gemini in a second pane -> debug/discuss -> bring the solution back to Claude for implementation -> both update their context files
- **Anti-patterns** — don't ask Gemini to edit files, don't ask both the same question, don't ignore when they disagree, default to Claude Code unless stuck

## Usage

```bash
git clone https://github.com/OSideMedia/dual-brain.git
cd dual-brain
chmod +x new-project.sh
./new-project.sh my-app "Next.js, Supabase, Vercel"
```

Then:

1. `cd ~/Projects/my-app`
2. Fill in the `<!-- comments -->` in CLAUDE.md and GEMINI.md
3. Start Claude Code in one terminal
4. When you need a second opinion, split the terminal and open Gemini CLI

The stack argument is optional — defaults to `Next.js, Supabase, TypeScript, Tailwind CSS, Vercel`. Pass whatever matches your project.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — `npm install -g @anthropic-ai/claude-code`
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) — `npm install -g @google/gemini-cli`
