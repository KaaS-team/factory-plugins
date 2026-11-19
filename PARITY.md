# Parity with the Go factory

factory-plugins is archived. This table lists every feature the repo ever offered and where the factory covers it.

The factory is KaaS-team/factory, branch `next` (commit `ad206c6`). It becomes KaaS-team/factory. All paths below are paths in that repo.

Verdicts: **covered** (a path that exists on `next`), **dropped** (on purpose), **missing** (a ticket is open).

| Feature in factory-plugins | Verdict | Where on `next` |
|---|---|---|
| Claude Code plugin marketplace (never shipped, no manifest) | dropped | The factory has no plugin marketplace. Extensions ship as packs and integrations: `internal/packs/manifest.go`, `integrations/` |
| Agent presets (idea only, no code) | covered | `src/agents/presets/index.ts` |
| Runtimes (idea only, no code) | covered | `src/runtimes.ts` |
| Notifiers (idea only, no code) | covered | `src/ports/notifier.ts`, `src/integrations/catalogue.ts`, `integrations/event-sinks/manifest.json` |
| `make check` gate (`Makefile`) | covered | `Makefile` (`check` target) |
| Check: every relative link in every markdown file exists (`scripts/check-docs.sh`) | covered | `src/docs-links.ts`, `tests/docs-links.test.ts` |
| Check: every `sh` or `bash` block in the README names a real script or make target (`scripts/check-docs.sh`) | missing | `tests/readme-accuracy.test.ts` checks `factory <subcommand>` names and repo paths only, not make targets or scripts in code blocks |
| Tests for the docs check, using throwaway directories (`tests/test-check-docs.sh`) | covered | `tests/docs-links.test.ts`, `tests/readme-accuracy.test.ts` |
| DCO sign-off rule in the README | covered | `CONTRIBUTING.md`, `scripts/dco.ts` |
| Apache-2.0 licence (`LICENSE`) | covered | `LICENSE` |

There are no commands, hooks, tools, config keys or workflows in this repo. It has no `.github/workflows` and no plugin manifest.
