# Claude Code Configuration

Global configuration for Claude Code sessions. This file provides preferences and conventions that apply across all projects.

## Code Style & Conventions

- **Modern JavaScript**: Use ES modules (`import`/`export`) instead of CommonJS (`require`)
- **Destructuring**: Prefer destructured imports (e.g., `import { foo } from 'bar'`)
- **TypeScript**: Use TypeScript for type safety when available
- **Formatting**: Follow project-specific prettier/eslint configurations

## Workflow Preferences

- **Testing**: Run targeted tests instead of full test suites for faster feedback
- **Type Checking**: Always run type checking after making code changes
- **Linting**: Check and fix linting issues before completing work
- **Verification**: Test changes thoroughly before marking work complete

## Skills

Skills are automatically discovered from `~/.claude/skills/`. The dotfiles setup links agent skills to this directory.

See available skills in `~/dotfiles/agent/skills/` or check the [Agent Skills README](file://~/dotfiles/agent/README.md).

## Additional Context

- **Dotfiles**: See `~/dotfiles/README.md` for environment and tool configuration
- **Project-specific instructions**: Use `CLAUDE.md` or `CLAUDE.local.md` in project roots for per-project overrides
- **Tool management**: This environment uses [mise-en-place](https://mise.jdx.dev/dev-tools/) for version management
