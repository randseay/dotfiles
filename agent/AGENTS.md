# Rand's Agent Instructions

These are common instructions for Rand's agents across all scenarios.

## General Guidelines

- Never use the em dash "—". Either rewrite text to avoid dashes or use plain dash "-".
- Prefer conciseness. Avoid verbosity. Do not overexplain.
- When writing commit messages and PR descriptions, NEVER auto-add your agent name as co-author.
- Never manually modify any files that are marked as auto-generated.
- When writing or substantially editing long markdown files, put each full sentence on its own line. Preserve normal markdown structure, but avoid wrapping multiple sentences onto one physical line.
- When making technical decisions, do not give much weight to development cost. Instead, prefer quality, simplicity, robustness, scalability, conventions, and long term maintainability.
- When doing bug fixes always start with reproducing the bug in an E2E setting as closely aligned with how an end user would encounter it as possible. This makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection. If something clearly looks off, even if it is not directly related to what you were doing, try to get it fixed along the way.
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness. If you see one, even if it is not caused by what you are working on right now, still get it fixed.
- Do not guess unless specifically asked to do so. Always seek verification through official means. This could include reading code, reading official documentation, looking at library source code or examples, reviewing git commit history, etc.

## Rand's Opinions

When you are working on something that would benefit from being informed by Rand's viewpoints, read ~/dotfiles/OPINIONS.md to understand how you should approach it.

## Voice Profile

When you are talking/posting on behalf of Rand using his identity, read ~/dotfiles/VOICE.md to see how Rand talks.

## PR Descriptions

When you are writing a pull request description on Rand's behalf, read ~/dotfiles/PR-DESCRIPTIONS.md for the required structure and format.