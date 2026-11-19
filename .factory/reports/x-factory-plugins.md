# x-factory-plugins report

## Demo commands
```
cat PARITY.md
make check
```
`make check` output: `docs check: ok` then five `ok` test lines.

## Acceptance
- PARITY.md lists every feature with a verdict and a path on `next`: done (10 rows; paths checked in a clone of `next` at ad206c6).
- README.md is the pointer; no other file changed: done. Only this report was added, as the brief requires.

## Missing rows (tickets for the factory)
- Problem: the README check on `next` does not verify that `sh`/`bash` blocks name real make targets or scripts. Acceptance: `tests/readme-accuracy.test.ts` fails when a README code block runs a make target or script path that does not exist.

## Upstreams copied
None.

## Files outside my area
`.factory/reports/x-factory-plugins.md` (required by the brief).

## Workflow changes needed
None.
