# factory-plugins

This repo is meant to hold Claude Code plugins for KaaS Factory: agent presets, runtimes and notifiers. Factory operators would install them from this repo as a plugin marketplace.

It holds no plugins yet. Today the repo contains the licence, this README and a docs check.

## Install

There is nothing to install. No plugin or marketplace manifest has been published here, and no command in this repo adds one to Claude Code.

To work on the repo, clone it. You need `git`, `bash` and `make`.

```sh
git clone https://github.com/KaaS-team/factory-plugins
cd factory-plugins
```

## First command

`make check` is the repo gate. It checks that every relative link in every markdown file points to an existing file, that every `sh` or `bash` block in this README names a script or make target that exists, and that the checker itself still catches broken docs.

```sh
make check
```

Output:

```
docs check: ok
ok   good docs pass
ok   missing README link fails
ok   missing link in nested md fails
ok   missing make target fails
ok   missing script fails
```

## Layout

| Path | What it is |
|---|---|
| `Makefile` | `make check` runs the docs check and its tests. |
| `scripts/check-docs.sh` | The docs check. |
| `tests/test-check-docs.sh` | Tests for the docs check, using throwaway directories. |
| `LICENSE` | Apache-2.0. |

## Where to go next

- [KaaS Factory](https://github.com/KaaS-team/KaaS-factory) is the project these plugins are for. It is being rewritten in Go as a single `factory` binary on its `next` branch; the older TypeScript factory is what this repo's plugin idea was first written against. This repo has not been checked against either, because it contains no plugin yet.
- [kaas.team](https://kaas.team) has the wider project.

## Contributing

Run `make check` before you push. Commits are signed off under the DCO (`git commit -s`). The repo is licensed Apache-2.0, see [LICENSE](LICENSE).
