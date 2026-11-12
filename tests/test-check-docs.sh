#!/usr/bin/env bash
# Proves scripts/check-docs.sh passes on good docs and fails on bad ones.
set -u
here=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
fails=0
expect() { # name want_rc dir
  "$here/scripts/check-docs.sh" "$3" >/dev/null 2>&1; rc=$?
  if [ "$rc" -eq "$2" ]; then echo "ok   $1"; else echo "FAIL $1 (rc=$rc, want $2)"; fails=1; fi
}
mk() { rm -rf "$tmp/r"; mkdir -p "$tmp/r/docs" "$tmp/r/scripts"; : > "$tmp/r/docs/a.md"; : > "$tmp/r/scripts/x.sh"
  printf 'check:\n\ttrue\n' > "$tmp/r/Makefile"; }

mk; printf '[a](docs/a.md)\n```sh\nmake check\n./scripts/x.sh\n```\n' > "$tmp/r/README.md"
expect "good docs pass" 0 "$tmp/r"
mk; printf '[a](docs/missing.md)\n' > "$tmp/r/README.md"
expect "missing README link fails" 1 "$tmp/r"
mk; printf '[b](nope.md)\n' > "$tmp/r/docs/a.md"; printf 'hi\n' > "$tmp/r/README.md"
expect "missing link in nested md fails" 1 "$tmp/r"
mk; printf '```sh\nmake nothere\n```\n' > "$tmp/r/README.md"
expect "missing make target fails" 1 "$tmp/r"
mk; printf '```bash\n./scripts/gone.sh\n```\n' > "$tmp/r/README.md"
expect "missing script fails" 1 "$tmp/r"
exit $fails
