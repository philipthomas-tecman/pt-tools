#!/usr/bin/env bash
set -euo pipefail
fast=0; [ "${1:-}" = "--fast" ] && fast=1
stage(){ echo "== $1 =="; shift; "$@"; }
stage build npm run build --if-present
stage links bash -c 'echo "run a link checker here (e.g. lychee)"'
[ "$fast" = "0" ] && stage lighthouse bash -c 'echo "run Lighthouse CI here"'
[ "$fast" = "0" ] && stage a11y bash -c 'echo "run an accessibility check here (e.g. pa11y)"'
echo "verify OK"
