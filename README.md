[![Version](https://img.shields.io/badge/version-2.0.0-blue)](https://github.com/OSideMedia/dual-brain/releases/tag/v2.0.0) [![License](https://img.shields.io/badge/license-MIT-green)](LICENSE) [![Platform](https://img.shields.io/badge/platform-Claude%20Code%20%2B%20Gemini%20CLI-purple)](https://github.com/OSideMedia/dual-brain)

# Dual-Brain Devkit

> Run two AI coding assistants in parallel — one builds, one thinks.

A framework for running Claude Code and Gemini CLI as parallel AI coding assistants on the same project. Each AI gets its own context file with a defined role, shared conventions, and instructions to sync with the other — so they stay aligned without stepping on each other.

## The idea

Most AI coding workflows use one model. This uses two in split terminals:

- **Claude Code** (left terminal) — the builder. Writes code, runs commands, handles git, deploys.
- **Gemini CLI** (right terminal) — the thinker. Architecture, algorithms, debugging, code review.

The key is that both AIs read from shared context files that keep them in sync. When Gemini makes an architecture decision, it gets written down. When Claude ships a feature, it gets written down. Neither AI works in a vacuum.

## Design philosophy (v2)

Context files follow three rules: **short, opinionated, operational.**

- Every line in CLAUDE.md and GEMINI.md should be a directive Claude Code or Gemini can act on immediately
- No prose paragraphs, no explanations of "why", no file trees (the AI can navigate the codebase)
- Project structure, feature lists, and schemas belong in README or docs/ — not in context files
- A Decisions Log tracks what changed over time without bloating the rules
- Housekeeping rules teach both AIs *how* to update the files so they stay lean

## What it scaffolds

Run `new-project.sh` and it creates three files in your project:

```bash
./new-project.sh my-app "Next.js, Supabase, Vercel"
```

### `CLAUDE.md` — Claude Code's context file

Loaded automatically by Claude Code at session start. Contains:

- **Shared Context** — repo URL, deploy URL, stack (minimal baseline both AIs need)
- **Rules** — short directives only, one per line, no prose
- **Cross-Context Sync** — read GEMINI.md at session start, absorb decisions
- **Decisions Log** — append-only record of architecture and implementation decisions
- **Housekeeping** — explicit rules for how to update the file without bloating it

### `GEMINI.md` — Gemini CLI's context file

Loaded by Gemini CLI. Contains:

- **Shared Context** — same baseline as CLAUDE.md
- **Role** — four directive lines defining Gemini as thinker, not builder
- **Rules** — same shared conventions as CLAUDE.md
- **Cross-Context Sync** — read CLAUDE.md at session start, absorb recent changes
- **Decisions Log** — mirrors CLAUDE.md's log
- **Housekeeping** — same update discipline as CLAUDE.md

### `ROUTING-PROTOCOL.md` — Decision framework

A reference doc (for you, the developer) that defines when to use which AI:

- **Quick decision rule** — "Am I building, or am I thinking?" Building = Claude. Thinking = Gemini.
- **Handoff pattern** — hit a wall in Claude Code → open Gemini in a second pane → debug/discuss → bring the solution back to Claude for implementation → both update their context files
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

## Migrating from v1

If you have existing projects using v1 templates, you can either re-scaffold or audit manually:

1. **Re-scaffold:** Back up your current CLAUDE.md and GEMINI.md, delete them, run `new-project.sh` again, then copy your project-specific rules and decisions into the new structure.
2. **Audit:** Use the `/audit-claude-md` slash command in Claude Code to automatically identify what stays and what moves to README/docs.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — `npm install -g @anthropic-ai/claude-code`
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) — `npm install -g @google/gemini-cli`
