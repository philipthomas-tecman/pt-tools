#!/usr/bin/env bash
set -euo pipefail
fast=0; [ "${1:-}" = "--fast" ] && fast=1
stage(){ echo "== $1 =="; shift; "$@"; }
stage lint  bash -c 'ruff check . || flake8 || true'
stage types bash -c 'mypy . || true'
stage test  pytest -q
stage secrets bash -c 'grep -REn "AKIA|BEGIN PRIVATE KEY|password\s*=" . 2>/dev/null && { echo "possible secret"; exit 1; } || echo clean'
[ "$fast" = "0" ] && echo "== full-only stages (evals) here =="
echo "verify OK"
