---
description: Refresh the LLM-maintained codebase wiki (Karpathy/OpenWiki pattern)
allowed-tools: Bash, Read, Edit
---

Refresh the codebase documentation wiki so agents read current context instead of re-deriving the code each run. This implements the Karpathy LLM Wiki pattern: sources (the repo) to wiki (openwiki/) to schema (the CLAUDE.md pointer).

Steps:
1. If OpenWiki is installed (`openwiki` on PATH), run `openwiki --update` (or `openwiki --init` if no `openwiki/` exists yet). Do not rely on the OpenWiki GitHub Action; this project uses Azure DevOps, so the refresh runs here or from a pipeline task.
2. If OpenWiki is not installed, maintain `openwiki/` directly: for each significant module, write or update a short, agent-native page (headings, cross-references, a one-paragraph summary, key files) under `openwiki/`, plus `openwiki/index.md` and `openwiki/architecture.md`.
3. Ensure the repo `CLAUDE.md` (or `AGENTS.md`) contains a pointer: "When you need codebase context, check openwiki/ first."
4. Present the changes as a diff for the user to review. Do not auto-merge; generated docs carry the same review duty as generated code.

Keep pages concise and current. Prefer accuracy over volume.
