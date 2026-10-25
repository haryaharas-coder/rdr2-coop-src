#!/usr/bin/env bash
# Push a one-commit snapshot of the current tree (tracked files only) to the public
# source repo. No history goes with it: the private repo's history carries the author's
# real name and e-mail. Refuses when a private string is in the tree.
#   tools/publish-source.sh            # snapshot HEAD of this checkout
set -euo pipefail
REPO=${REPO:-BigCheeseThe3st/rdr2-coop-src}
AUTHOR="BigCheeseThe3st <133584779+BigCheeseThe3st@users.noreply.github.com>"
src=$(git rev-parse --show-toplevel)
ver=$(tr -d '[:space:]' < "$src/VERSION")
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

git -C "$src" archive HEAD | tar -x -C "$work"
# shortcut: a fixed word list, extend it when a new private name appears
if grep -rIlE --exclude=publish-source.sh "beeseland|gtrader|rtrader|piadmin|192\.168\.5\.|/home/george|sk-ant-|BEGIN [A-Z ]*PRIVATE KEY" "$work" >/dev/null; then
    echo "private strings in the tree, not publishing:" >&2
    grep -rIlE --exclude=publish-source.sh "beeseland|gtrader|rtrader|piadmin|192\.168\.5\.|/home/george|sk-ant-|BEGIN [A-Z ]*PRIVATE KEY" "$work" >&2
    exit 1
fi

cd "$work"
git init -q -b main
git add -A
git -c user.name="${AUTHOR%% <*}" -c user.email="$(echo "$AUTHOR" | sed "s/.*<//; s/>//")" \
    commit -q -m "RDR2 Co-op $ver (source snapshot)" --author="$AUTHOR"
git remote add origin "https://github.com/$REPO.git"
git push -q --force origin main
echo "published $ver to https://github.com/$REPO"
