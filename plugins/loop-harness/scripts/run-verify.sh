#!/usr/bin/env bash
# Stop: run the project's single definition of done in fast mode. If it fails,
# block the stop and feed the failure back. The completion token ends the turn;
# the verifier ends the task. If no verify script exists yet, allow (a project
# that has not run /init-harness is not gated).
set -uo pipefail
run() { "$@"; }
if [ -f build/verify.sh ]; then
  out="$(bash build/verify.sh --fast 2>&1)"; rc=$?
elif [ -f build/verify.ps1 ] && command -v pwsh >/dev/null 2>&1; then
  out="$(pwsh -NoProfile -File build/verify.ps1 -Fast 2>&1)"; rc=$?
else
  printf '{"decision":"approve"}\n'; exit 0
fi
if [ "$rc" -ne 0 ]; then
  reason="$(printf 'verify gate FAILED (exit %s). Do not finish. Fix and re-run build/verify. Tail:\n%s' "$rc" "$(printf "%s" "$out" | tail -c 1500)")"
  printf '%s' "$reason" | python3 -c 'import json,sys;print(json.dumps({"decision":"block","reason":sys.stdin.read()}))'
  exit 0
fi
printf '{"decision":"approve","reason":"verify gate passed."}\n'
