---
name: git-commit
description: Stage meaningful diffs and create commits with WHY-focused messages. Use when agent needs to commit code changes.
---

## INSTRUCTIONS

Use `/commit-and-push` or `/commit-and-pr` slash command to stage meaningful diffs and create commits with WHY-focused messages.

## DISCIPLINE

- Only commit when:
  1. ALL tests are passing
  2. ALL compiler/linter warnings have been resolved
  3. The change represents a single logical unit of work
  4. Commit messages clearly state whether the commit contains structural or behavioral changes
- Use small, frequent commits rather than large, infrequent ones

## Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

**Body should explain**:

- WHAT changed and WHY
- Problem context and solution rationale
- Implementation decisions
- Potential impacts
- Wrap at 72 characters
