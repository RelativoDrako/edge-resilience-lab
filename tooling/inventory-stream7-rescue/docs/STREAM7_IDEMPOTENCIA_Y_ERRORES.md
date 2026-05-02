# Stream 7 — Idempotence and Error Strategy

## Idempotence principles
- the toolkit should be safe to rerun
- logs and reports should be deterministic by path
- actions that change state should be explicit
- passive probe/report stages should remain non-destructive

## Error policy
If a command or package is missing:
- record it in the report
- continue when safe
- avoid silent failure

## Recovery policy
Before applying firmware or optimization actions:
- preserve the baseline report
- keep a record of OS and kernel state
- record architecture and device identifiers
