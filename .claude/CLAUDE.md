# AI Coding Rules

Respond in Japanese.

When implementing, be sure to obtain approval before proceeding with the implementation.

## Core Principles: Less is More

- Keep implementations small - Write the smallest, most obvious solution
- Let code speak - If you need multi-paragraph comments, refactor until intent is obvious
- Simple > Clever - Clear code beats clever code every time
- Delete ruthlessly - Remove anything that doesn't add clear value

## Git

- Use current working directory - All file operations must use <env>Working directory</env> as base path, never main branch directory
- Commit per task - Commit when each logical task completes; include context and reasoning in commit message
- No "why" in code comments - History lives in commits, not in code
