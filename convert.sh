#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <module> <date>"
  echo "  Example: $0 ietf-schc 2026-04-05"
  exit 1
fi

MODULE=$1
DATE=$2
BASE="${MODULE}@${DATE}"

git pull

uvx --from git+https://github.com/ltn22/pyang@sid-extension pyang --sid-generate-file=2550:400 --sid-list --sid-extension ${BASE}.yang
uv run python3 csv2sid.py SID-mapping-${DATE}.csv ${BASE}.sid ${BASE}-mapped.sid

git add SID-mapping-${DATE}.xlsx
git add SID-mapping-${DATE}.csv
git add ${BASE}.yang
git add ${BASE}-mapped.sid
git commit -m "update sid"
git push
