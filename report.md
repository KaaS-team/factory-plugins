BRANCH: cluster/docs
HEAD: c9fedabe460859b3abc5f37ac0d8004c9d247272
## Summary
The repo had only LICENSE and a README, so I rewrote the README to say plainly that it holds no plugins yet, and added a docs check wired into a new `make check` gate. Inventory: README links (kaas.team, KaaS-factory, LICENSE) and the old "Part of KaaS" and "will be" text; the `brew`/`install.sh` v9 commands are not stated since nothing here uses them. The removed "starts after the plugin interface lands" claim was unverifiable and is gone; the removed DCO line is now under Contributing.
## Acceptance
- Inventory of markdown, commands, links -> manual (2 files, 0 commands before; now `make check`, 3 links, all work) -> done
- README: purpose and users in two sentences, install, first command with real output, next steps, under 150 lines, no em dashes -> make check docs check -> done
- Stale content removed (future-tense plugin promises, unverified "Part of KaaS" section merged into next steps) -> README diff -> done
- Docs check fails on missing relative links and missing README script or make targets; bite proven by changing LICENSE to LICENCE (failed, rc=2, then restored) -> tests/test-check-docs.sh (5 cases) -> done
- No gate existed, so added `make check` and said so in README -> make check -> done
- Gate passes from clean tree -> make check -> done
## Files outside my area
none
## Goldens changed
none
## Gate evidence
ok   missing README link fails
ok   missing link in nested md fails
ok   missing make target fails
ok   missing script fails
## Learnings
- The brief's push of the report needs a report file first; write it before the final push step.
- Only the `next` branch of KaaS-factory was cloned; its README still mostly describes the Bun/TS loop, so I made no v9 behaviour claims.
- I did not run the checker's tests with the revert-the-fix step on the script itself; the bite was shown on a real README link.
