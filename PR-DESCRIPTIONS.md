# Rand's PR Descriptions

Follow this structure when writing a pull request description on Rand's behalf.
It is Rand's established house style; a generic "what changed / decisions / testing" dump that rehashes the diff is off base.
Also apply ~/dotfiles/VOICE.md for tone and concision.

## Title

A sentence-case summary of the change.
When the issue tracker uses short issue IDs (for example Linear's `FEP-XXXX`), prefix the title with the ID: `FEP-XXXX: Sentence-case summary.`.
The issue ID prefix belongs in the PR title only, never in the commit message.
When the tracker has no short ID convention (for example GitHub Issues), use just the summary; the issue is referenced in the body instead.

## Body

1. **First line:** a reference to the tracked issue, matching the tracker in use.
   Nothing else goes on that line.
   - Linear or any tracker with a short ID and issue URL: a bare link with the ID as the link text, for example `[FEP-1682](https://linear.app/ngrok/issue/FEP-1682/neo-migrate-the-endpoint-usage-over-time-chart-to-mantle-charts-and)`.
   - GitHub Issues (same repo): a closing keyword reference so the issue auto-closes on merge, for example `Closes #123`.
   - No tracked issue: omit this line.

2. **`# Overview`** heading, then a `- [x]` checklist of what the PR does.
   Items must be concise: a short line each, not a verbose sentence or two.
   Bold the key section or feature names.

3. **Optional short paragraph** immediately after the checklist.
   Include it only when there is genuinely non-obvious context worth a reviewer's time, such as a subtle decision, what was deliberately left unchanged, or verification performed.
   Many PRs do not need it; omit it rather than padding.
   Keep it brief when present.

4. **`# Screenshots/Screencast`** heading with labeled screenshots, such as "Loading state", "Empty state", or "Flag disabled".
   Rand captures these from the browser.
   Agents usually cannot upload images, so leave this section for Rand to fill unless images are already available.

## Publishing

An edit request is still a draft, not approval to post.
Get an explicit go-ahead before creating or overwriting a live PR body, and read the current state first.
