#!/usr/bin/env bash
# SessionStart: surface the standing spec and current state so the agent
# starts every session pointed at the goal (the anti-drift brake).
set -euo pipefail
emit=""
for f in docs/VISION.md VISION.md; do
  [ -f "$f" ] && emit="$emit\n\n===== $f (standing spec, reread every session) =====\n$(cat "$f")" && break
done
# nearest STATE.md (root or one level down)
state="$(ls STATE.md */STATE.md tools/*/STATE.md agents/*/STATE.md 2>/dev/null | head -1 || true)"
[ -n "${state:-}" ] && emit="$emit\n\n===== $state (where we are) =====\n$(cat "$state")"
# point the agent at the codebase wiki if present
[ -d openwiki ] && emit="$emit\n\nWhen you need codebase context, read openwiki/ first (index.md, architecture.md) before searching the tree."
if [ -n "$emit" ]; then
  printf '{"decision":"approve","reason":"%s"}\n' "$(printf "%b" "$emit" | python3 -c 'import json,sys;print(json.dumps(sys.stdin.read())[1:-1])' 2>/dev/null || printf "%b" "$emit")"
fi
