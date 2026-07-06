#!/usr/bin/env bash
set -euo pipefail
fast=0; [ "${1:-}" = "--fast" ] && fast=1
stage(){ echo "== $1 =="; shift; "$@"; }
stage build   npm run build --if-present
stage test    npm test --silent
stage lint    npm run lint --if-present
# stage contract  npx spectral lint contract/openapi.yaml
stage secrets bash -c 'grep -REn "AKIA|BEGIN PRIVATE KEY|password\s*=" src 2>/dev/null && { echo "possible secret"; exit 1; } || echo clean'
[ "$fast" = "0" ] && echo "== full-only stages (e2e, evals) here =="
echo "verify OK"
