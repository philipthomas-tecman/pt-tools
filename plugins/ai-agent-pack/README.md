# ai-agent-pack

Build tooling for AI features. Standalone: it composes with the `loop-harness` base (install that too), and it has no dependency on any documentation or project-kickoff process.

## What it installs

- **Agent**: `manifest-checker` verifies a declarative agent configuration (schema, governance invariants, eval gate) before it ships.
- **Skills**:
  - `build-agent`: agents as configuration (declarative manifest, tools by default and sub-agents by exception, human gates, on-behalf-of identity, grounded answers).
  - `build-connector`: tools as host-agnostic services (contract-first, few and focused, idempotent writes, agent-readable errors, least-privilege).
  - `build-mcp-server`: small, coherent MCP surfaces with deliberate transport and least-privilege auth.
  - `write-evals`: the eval discipline (reliability scale, deterministic before judge, train/holdout, different-model anchored judge, multi-metric, trajectory and red-team gates, plateau detection).

## Use with the base

Install `loop-harness` for the loop mechanics (hooks, maker/checker/explorer/verifier, `/init-harness`, `build/verify.ps1`). This pack adds the AI-domain build knowledge and the manifest-checker on top. Nothing here is tied to a specific platform; the skills are principle-driven.
