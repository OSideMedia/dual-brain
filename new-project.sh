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

# Build stack list
STACK_LIST=""
IFS=',' read -ra ITEMS <<< "$STACK"
for item in "${ITEMS[@]}"; do
    trimmed=$(echo "$item" | xargs)
    STACK_LIST="${STACK_LIST}- ${trimmed}
"
done

# --- CLAUDE.md ---
if [ ! -f "CLAUDE.md" ]; then
cat > CLAUDE.md << EOF
# ${PROJECT_NAME} – CLAUDE.md

## Project Overview
<!-- Describe what this project does in 2-3 sentences -->

**Live:** <!-- deployment URL -->
**Repo:** https://github.com/OSideMedia/${PROJECT_NAME}
**Branch:** main

## Tech Stack
${STACK_LIST}
## Project Structure
\`\`\`
src/
├── app/            # Pages & layouts
├── components/     # React components
├── lib/            # Utilities, queries, mutations
\`\`\`

## Key Features
<!-- Update this as features ship -->

## Supabase
<!-- Tables, RPC functions, policies -->

## Conventions
- TypeScript strict mode
- Functional components with hooks
- Supabase RPC for complex queries (not client-side joins)
- Commit messages: \`feat:\`, \`fix:\`, \`refactor:\`, \`chore:\`

## Cross-Context
Read GEMINI.md at the start of each session to stay aligned with architecture decisions made in Gemini CLI. If GEMINI.md reflects decisions you weren't part of, update your understanding before proceeding.

## Housekeeping
After completing any feature, update CLAUDE.md and GEMINI.md to reflect new features, RPC functions, or architecture changes.
EOF

echo -e "${GREEN}✓ Created CLAUDE.md${NC}"
else
    echo -e "${YELLOW}⚠ CLAUDE.md already exists, skipping${NC}"
fi

# --- GEMINI.md ---
if [ ! -f "GEMINI.md" ]; then
cat > GEMINI.md << EOF
# ${PROJECT_NAME} – GEMINI.md

## Project Overview
<!-- Describe what this project does in 2-3 sentences -->

**Live:** <!-- deployment URL -->
**Repo:** https://github.com/OSideMedia/${PROJECT_NAME}
**Branch:** main

## Tech Stack
${STACK_LIST}
## Project Structure
\`\`\`
src/
├── app/            # Pages & layouts
├── components/     # React components
├── lib/            # Utilities, queries, mutations
\`\`\`

## Key Features
<!-- Update this as features ship -->

## Supabase
<!-- Tables, RPC functions, policies -->

## Role for Gemini CLI
You are a **thinking partner and architecture advisor** for this project. Your strengths:
- **Logic & algorithms:** Complex business logic, data transformations, graph traversal
- **Data modeling:** Schema design, RPC optimization, query performance
- **Architecture decisions:** Component structure, state management, caching strategies
- **Code review:** Ghost dependencies, dead code, race conditions
- **Frontend debugging:** D3, canvas, complex CSS, animation timing, visual math
- **Research:** Library evaluation, approach comparison, solving problems Claude Code hasn't cracked

**Important:** Claude Code handles all file creation, editing, git operations, and deployment.
You provide the thinking — Claude Code does the building.

## Conventions
- TypeScript strict mode
- Functional components with hooks
- Supabase RPC for complex queries (not client-side joins)
- Commit messages: \`feat:\`, \`fix:\`, \`refactor:\`, \`chore:\`

## Cross-Context
Read CLAUDE.md at the start of each session to stay aligned with implementation details and recent changes made in Claude Code. If CLAUDE.md reflects features or patterns you weren't part of, update your understanding before advising.

## Housekeeping
After any architecture discussion that results in decisions, update this file to reflect new patterns, conventions, or planned features. Also flag if CLAUDE.md needs updating so the developer can tell Claude Code to sync.
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
echo -e "  ${GREEN}✓${NC} CLAUDE.md    — Claude Code context"
echo -e "  ${GREEN}✓${NC} GEMINI.md    — Gemini CLI context"
echo -e "  ${GREEN}✓${NC} ROUTING-PROTOCOL.md — Dual-terminal decision framework"
echo ""
echo -e "Next steps:"
echo -e "  1. cd ${PROJECT_DIR}"
echo -e "  2. Fill in the <!-- comments --> in CLAUDE.md and GEMINI.md"
echo -e "  3. Open VS Code: code ."
echo -e "  4. Start Claude Code in one terminal"
echo -e "  5. For deep problems, split terminal: Claude (left) + gemini (right)"
echo ""
