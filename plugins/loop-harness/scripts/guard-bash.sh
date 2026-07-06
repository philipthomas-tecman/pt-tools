#!/usr/bin/env bash
# PreToolUse(Bash): block deploy/destroy from the laptop. Deployment is a
# pipeline concern with a human approval gate; the loop never deploys.
set -euo pipefail
cmd="$(cat - 2>/dev/null | python3 -c 'import json,sys
try:
    d=json.load(sys.stdin); print(d.get("tool_input",{}).get("command",""))
except Exception:
    print("")' 2>/dev/null || true)"
deny='az +deployment|az group (create|delete)|func azure .*publish|git push .*--force|git push .*-f( |$)|rm -rf /|terraform apply|kubectl (apply|delete)|helm (install|upgrade)'
if printf "%s" "$cmd" | grep -Eiq "$deny"; then
  printf '{"decision":"block","reason":"Deployment or destructive command blocked by loop-harness. Deployment is pipeline-only with a human approval gate; author the change and stop. If this is a false positive, run it yourself."}\n'
  exit 0
fi
printf '{"decision":"approve"}\n'
