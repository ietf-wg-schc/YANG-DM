#!/bin/bash


git pull
# generate test sid allocation
pyang --sid-generate-file=2550:400 --sid-list ietf-schc@2025-11-24.yang 
uv run python3 csv2sid.py SID-mapping-bis.csv ietf-schc@2025-11-24.sid ietf-schc@2025-11-24-test.sid


pyang --sid-generate-file=2550:400 --sid-list --sid-extension ietf-schc@2025-11-24.yang 
uv run python3 csv2sid.py SID-mapping-bis.csv ietf-schc@2025-11-24.sid ietf-schc@2025-11-24-ext.sid

git add ietf-schc@2025-11-24-test.sid
git add ietf-schc@2025-11-24-ext.sid
git commit -m "update sid"
git push
