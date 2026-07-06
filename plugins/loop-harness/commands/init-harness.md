---
description: Scaffold the loop-engineering harness into this project
argument-hint: [stack: dotnet|node|python|al|static]
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
---

Set up the per-project layer of the loop-engineering harness in the current repository. The portable machinery (hooks, sub-agents, this command) comes from the loop-harness plugin; this command generates the project-specific files.

Target stack: $1 (if empty, detect from the repo: a .csproj/.sln means dotnet, package.json means node, pyproject.toml/requirements.txt means python, app.json or *.al means al, a static-site setup means static).

## Step 0: seed from existing design docs, or interview

Search `docs/` and the repo root for design and requirements markdown: for example a charter, BRD, requirements specification, solution design, LLD, ADRs, or any design or plan document. Do not assume a particular tool produced them; read whatever design markdown is present.

- If design docs exist, distil the harness inputs from them:
  - The mission in five sentences, the hard constraints, and the acceptance criteria for the first increment (for VISION.md).
  - The ordered first tasks (for the STATE.md Next queue), taken from the design's scope or plan.
  Present the distilled VISION and the proposed STATE queue to the user and confirm before writing. Do not invent: where the design docs are silent or thin, ask rather than guess.
- If no design docs exist, interview the user for the mission, constraints and first-increment acceptance criteria, and the initial queue.

This keeps the harness decoupled: it reads whatever design docs are in the repo (from any discovery/design process), and depends on no other plugin.

## Step 1: VISION
Create `docs/VISION.md` from `${CLAUDE_PLUGIN_ROOT}/templates/VISION.md`, filled from Step 0. Keep the full design in `docs/`; VISION.md is the one-page version reread every session.

## Step 2: STATE
Create `STATE.md` from `${CLAUDE_PLUGIN_ROOT}/templates/STATE.md` at the root (or the relevant work-stream folder), seeded with the queue from Step 0.

## Step 3: verify gate
Create `build/verify.ps1` from the matching template in `${CLAUDE_PLUGIN_ROOT}/templates/verify/` (all templates are PowerShell). Wire each stage to this project's real commands. Ensure it supports `-Fast` and exits non-zero on any failure. Run it once (`pwsh -File build/verify.ps1`) to confirm a green baseline.

## Step 4: repo CLAUDE.md
Add a repo-level `CLAUDE.md` "Project law" section if one does not exist: the hard constraints, "done means build/verify.ps1 exits 0", the local gate commands, and the model-routing block (default Sonnet 5 medium; escalate the genuinely hard reasoning to the strongest model; anything cyber to Opus). Do not duplicate the user's global CLAUDE.md.

## Step 5: ledger
Create `docs/harness/LEDGER.csv` from the template.

## Step 6: confirm hooks
Tell the user the plugin's hooks (SessionStart context, Bash deny-list, Stop gate) are already active because the plugin is installed; nothing to wire into settings.

## Step 7: summarise
Summarise what was created, whether VISION and STATE were distilled from design docs or gathered by interview, and what the user still needs to fill in.

Keep prose UK English with no em-dashes.
