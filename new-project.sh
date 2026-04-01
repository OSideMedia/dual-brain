#!/bin/bash

# new-project.sh — Scaffolds a new project with dual-brain context files
# Usage: new-project.sh <project-name> [stack]
# Example: new-project.sh my-app "Next.js, Supabase, Vercel"

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

PROJECT_NAME="${1:?Usage: new-project.sh <project-name> [stack]}"
STACK="${2:-Next.js, Supabase, TypeScript, Tailwind CSS, Vercel}"
PROJECT_DIR="$HOME/Projects/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
    echo -e "${YELLOW}⚠ Directory $PROJECT_DIR already exists.${NC}"
    read -p "Add context files to existing project? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    mkdir -p "$PROJECT_DIR"
    echo -e "${GREEN}✓ Created $PROJECT_DIR${NC}"
fi

cd "$PROJECT_DIR"

# --- CLAUDE.md ---
if [ ! -f "CLAUDE.md" ]; then
cat > CLAUDE.md << EOF
# ${PROJECT_NAME} – CLAUDE.md

## Shared Context
<!-- Both AIs read this section. Keep it factual and concise. -->

**Repo:** https://github.com/OSideMedia/${PROJECT_NAME}
**Live:** <!-- deployment URL -->
**Stack:** ${STACK}

## Rules
<!-- One directive per line. No prose. No explanations of "why." -->
<!-- Test: "If Claude broke this, would the damage be immediate and hard to undo?" -->

> TypeScript strict mode, always.
> Functional components with hooks, no class components.
> Commit messages: \`feat:\`, \`fix:\`, \`refactor:\`, \`chore:\`.
<!-- Add project-specific guardrails below -->

## Cross-Context Sync

> Read GEMINI.md at the start of every session. Absorb any architecture decisions before proceeding.

## Decisions Log
<!-- Append-only. One line per decision. Date + what changed. Never delete entries. -->
<!-- Example: 2026-04-01 — Switched from Drizzle to raw SQL for Supabase queries -->

## Housekeeping

> After completing a feature, update this file AND GEMINI.md.
> Shared Context: keep factual, concise. No prose paragraphs.
> Rules: short directives only. No explanations of "why."
> Decisions Log: one line per entry. Date + what changed.
> If any section grows past 10 lines, move the overflow to README or docs/.
EOF

echo -e "${GREEN}✓ Created CLAUDE.md${NC}"
else
    echo -e "${YELLOW}⚠ CLAUDE.md already exists, skipping${NC}"
fi

# --- GEMINI.md ---
if [ ! -f "GEMINI.md" ]; then
cat > GEMINI.md << EOF
# ${PROJECT_NAME} – GEMINI.md

## Shared Context
<!-- Both AIs read this section. Keep it factual and concise. -->

**Repo:** https://github.com/OSideMedia/${PROJECT_NAME}
**Live:** <!-- deployment URL -->
**Stack:** ${STACK}

## Role

> You are a thinking partner and architecture advisor. Not a builder.
> Your strengths: logic, data modeling, architecture, code review, research, frontend visual debugging.
> Claude Code handles all file creation, editing, git, and deployment.
> Format solutions so the developer can paste them into Claude Code as instructions.

## Rules
<!-- Same shared conventions as CLAUDE.md -->

> TypeScript strict mode, always.
> Functional components with hooks, no class components.
> Commit messages: \`feat:\`, \`fix:\`, \`refactor:\`, \`chore:\`.
<!-- Add project-specific guardrails below -->

## Cross-Context Sync

> Read CLAUDE.md at the start of every session. Absorb any recent features or changes before advising.

## Decisions Log
<!-- Append-only. One line per decision. Date + what changed. Never delete entries. -->
<!-- Example: 2026-04-01 — Switched from Drizzle to raw SQL for Supabase queries -->

## Housekeeping

> After any architecture discussion that produces a decision, update this file AND flag CLAUDE.md for sync.
> Shared Context: keep factual, concise. No prose paragraphs.
> Rules: short directives only. No explanations of "why."
> Decisions Log: one line per entry. Date + what changed.
> If any section grows past 10 lines, move the overflow to README or docs/.
EOF

echo -e "${GREEN}✓ Created GEMINI.md${NC}"
else
    echo -e "${YELLOW}⚠ GEMINI.md already exists, skipping${NC}"
fi

# --- ROUTING-PROTOCOL.md ---
if [ ! -f "ROUTING-PROTOCOL.md" ]; then
cat > ROUTING-PROTOCOL.md << 'EOF'
# Dual-Brain Routing Protocol
## Claude Code (Primary) ↔ Gemini CLI (Consultant)

---

## Quick Decision Rule

**"Am I building, or am I thinking?"**

- **Building** → Claude Code
- **Thinking** → Gemini CLI

---

## Dual Terminal Workflow

Run both AIs in split terminals for seamless collaboration:

```
Terminal 1 (left): Claude Code — writing code, running commands
Terminal 2 (right): Gemini CLI — architecture, debugging, review
```

### When to open Gemini CLI
1. Hit a wall in Claude Code (2-3 failed attempts)
2. Open Gemini CLI in second terminal pane
3. Multi-turn debugging / architecture session with Gemini
4. Bring solution back to Claude Code for implementation
5. Both update their context files

---

## Claude Code – The Builder
Use for: writing/editing code, creating components, migrations, git operations, installing packages, fixing build errors, refactoring, tests, deployment.

## Gemini CLI – The Thinker
Use for: architecture decisions, algorithm design, data modeling, math/geometry, debugging logic, code review, library evaluation, second opinions, schema design, frontend visual debugging.

## Anti-Patterns
- Don't ask Gemini to edit files — that's Claude's job
- Don't ask both the same question — pick the right tool
- Don't ignore disagreements — understand why they differ
- Default to Claude Code — only escalate when stuck
EOF

echo -e "${GREEN}✓ Created ROUTING-PROTOCOL.md${NC}"
else
    echo -e "${YELLOW}⚠ ROUTING-PROTOCOL.md already exists, skipping${NC}"
fi

# --- Summary ---
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  Project: ${PROJECT_NAME}${NC}"
echo -e "${CYAN}  Location: ${PROJECT_DIR}${NC}"
echo -e "${CYAN}  Stack: ${STACK}${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}✓${NC} CLAUDE.md    — Claude Code context (short, opinionated, operational)"
echo -e "  ${GREEN}✓${NC} GEMINI.md    — Gemini CLI context (short, opinionated, operational)"
echo -e "  ${GREEN}✓${NC} ROUTING-PROTOCOL.md — Dual-terminal decision framework"
echo ""
echo -e "Next steps:"
echo -e "  1. cd ${PROJECT_DIR}"
echo -e "  2. Fill in the <!-- comments --> in CLAUDE.md and GEMINI.md"
echo -e "  3. Open VS Code: code ."
echo -e "  4. Start Claude Code in one terminal"
echo -e "  5. For deep problems, split terminal: Claude (left) + gemini (right)"
echo ""
