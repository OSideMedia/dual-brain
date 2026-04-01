# Changelog

## v2.0.0 — 2026-04-01

### Breaking Changes

- CLAUDE.md and GEMINI.md templates completely restructured. Existing projects should run `/audit-claude-md` to migrate.

### Changed

- **CLAUDE.md template**: Rewritten to follow short, opinionated, operational principles. Removed Project Structure, Key Features, Supabase, and Conventions sections. Replaced with Rules (directives only), Shared Context (minimal baseline for cross-AI sync), Decisions Log (append-only), and Housekeeping (with explicit update rules to prevent file bloat).
- **GEMINI.md template**: Same restructure. Role section condensed from detailed bullet list to four directive lines. Added Decisions Log. Added Housekeeping with update rules.
- **new-project.sh**: Stack passed as single-line string instead of bullet list. Removed scaffolded Project Structure tree (Claude Code can navigate the codebase itself).

### Removed

- Project Structure tree from both templates (navigable from codebase)
- Key Features placeholder (belongs in README)
- Supabase placeholder (belongs in README or docs/)
- Detailed Gemini Role bullet list (condensed to directives)
- Prose-style Conventions section (replaced with directive-style Rules)

## v1.0.0 — 2026-03-25

Initial release.

### Features

- `new-project.sh` scaffolder for bootstrapping dual-brain projects
- `CLAUDE.md` template with role definition, conventions, and cross-context sync
- `GEMINI.md` template with thinking-partner role and cross-context sync
- `ROUTING-PROTOCOL.md` decision framework for routing tasks between Claude Code and Gemini CLI
