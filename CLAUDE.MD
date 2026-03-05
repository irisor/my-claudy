# Agent Rules & Safety Policy

## Security
- Default to **Plan Mode** for all email and shopping tasks.
- Never execute checkout or send email without explicit "Proceed" confirmation in the terminal.

## Philosophy
- Replace code rather than deprecating; keep the codebase clean.
- When fixing bugs, always run `npm test` before and after changes.

## Tooling
- Use local MCP servers for Outlook and Shopping tasks.
- Always check the `shopping-db` before initiating new search queries.