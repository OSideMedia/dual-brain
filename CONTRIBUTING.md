# Contributing

Contributions are welcome!

## Getting started

1. **Open an issue first** for major changes so we can discuss the approach before you invest time.
2. Fork the repo and create your branch from `main`.
3. Make your changes and submit a pull request.

## Testing

There are no automated tests — the way to verify your changes is to actually run the scaffolded files:

1. Run `new-project.sh` to generate a test project.
2. Open the project in **Claude Code** and confirm `CLAUDE.md` loads correctly and the cross-context sync instructions work.
3. Open the project in **Gemini CLI** and confirm `GEMINI.md` loads correctly and the cross-context sync instructions work.
4. Verify both assistants can read each other's context files and stay aligned.

## Guidelines

- Keep changes focused — one feature or fix per PR.
- Follow the existing style and conventions in the repo.
- Update documentation if your change affects usage.
