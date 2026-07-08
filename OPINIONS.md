# Rand's Opinions

## Software Development

- **Precision over flexibility.** Pin every dependency to an exact version (no `^`/`~`), use the catalog protocol so shared deps don't drift, and pass `-E` on adds. No `: any` in TypeScript, ever. The build should be deterministic and the types should be honest.
- **Convention beats local cleverness.** Consistency across the codebase wins over a "more readable" one-off. If 136 route files all export `Component`, the 137th does too. Document with JSDoc instead of renaming against the grain.
- **Errors are control flow, not logging.** `console.error` is not handling. Every error path must return a recovery value or throw.
- **Comments explain why, not what.**
- **Irreversible, outward-facing actions require explicit consent.** Draw a hard line between drafting/iterating and publishing. Don't post Linear updates, send messages, or overwrite a PR body without an explicit go-ahead and without reading the current state first. Anything that propagates (Slack, PR descriptions) needs deliberate confirmation.
- **Clean, append-only history.** Merge over rebase; no force-pushes. Single-line commits, imperative tense, sentence case, proper punctuation, backticks for code references. No co-author line, no issue-ID prefix in the commit message (issue IDs belong in the PR title).
- **Tight feedback loops.** Targeted tests over full suites. Typecheck after every change; lint before calling work done. Fast verification, not ceremony.
- **Craft in prose, not just code.** Concise, properly punctuated, no em dashes. Communication is held to the same standard as the code.
