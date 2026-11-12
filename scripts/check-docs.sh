#!/usr/bin/env bash
# Docs check. Fails when:
#  1. a relative link in any tracked markdown file points to a missing file;
#  2. a fenced sh/bash block in README.md names a script or make target that does not exist.
# Usage: scripts/check-docs.sh [repo-root]   (default: current directory)
set -u
root=${1:-.}
cd "$root" || exit 2
fail=0
err() { echo "docs check: $*" >&2; fail=1; }

if git rev-parse --git-dir >/dev/null 2>&1; then
  files=$(git ls-files --cached --others --exclude-standard '*.md')
else
  files=$(find . -name '*.md' -not -path './.git/*' | sed 's|^\./||')
fi

# 1. relative links
while IFS= read -r f; do
  [ -n "$f" ] || continue
  dir=$(dirname "$f")
  # skip fenced code blocks, then pull out ](target) pieces
  awk '/^```/{c=!c; next} !c' "$f" | grep -o ']([^)]*)' | sed 's/^](//; s/)$//' |
  while IFS= read -r link; do
    target=${link%% *}
    case "$target" in
      ''|'#'*|http://*|https://*|mailto:*) continue ;;
    esac
    target=${target%%#*}
    target=${target%%\?*}
    [ -n "$target" ] || continue
    case "$target" in
      /*) path=".$target" ;;
      *) path="$dir/$target" ;;
    esac
    [ -e "$path" ] || echo "$f: broken link: $link"
  done
done <<<"$files" > /tmp/.docs-check.$$
if [ -s /tmp/.docs-check.$$ ]; then cat /tmp/.docs-check.$$ >&2; fail=1; fi
rm -f /tmp/.docs-check.$$

# 2. README shell blocks
if [ -f README.md ]; then
  awk '/^```(sh|bash)[[:space:]]*$/{b=1; next} /^```/{b=0} b' README.md |
  while IFS= read -r line; do
    line=${line#"${line%%[![:space:]]*}"}
    case "$line" in ''|'#'*) continue ;; esac
    set -- $line
    case "$1" in
      make)
        shift
        for t in "$@"; do
          case "$t" in -*|*=*) continue ;; esac
          grep -Eq "^${t}[[:space:]]*:" Makefile 2>/dev/null || echo "README.md: make target not found: $t"
        done ;;
      ./*|scripts/*|tests/*)
        [ -e "$1" ] || echo "README.md: script not found: $1" ;;
      bash|sh)
        shift
        case "${1:-}" in -*|'') ;; *) [ -e "$1" ] || echo "README.md: script not found: $1" ;; esac ;;
    esac
  done > /tmp/.docs-check2.$$
  if [ -s /tmp/.docs-check2.$$ ]; then cat /tmp/.docs-check2.$$ >&2; fail=1; fi
  rm -f /tmp/.docs-check2.$$
fi

[ $fail -eq 0 ] && echo "docs check: ok"
exit $fail
