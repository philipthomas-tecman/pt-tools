---
name: build-agent
description: >
  This skill should be used when building or changing an AI agent or assistant:
  "add a role assistant", "build an agent", "compose capabilities", "wire up an
  agent's tools and gates". It gives the declarative, config-first pattern and the
  guardrails.
metadata:
  version: "0.1.0"
---

Build agents as configuration, not bespoke code per agent.

Principles:
- An agent is a declarative manifest: the capabilities it composes, the tools and operations it may use, its human gates, its identity, and its eval suite. Validate it against a schema in CI.
- Tools by default, sub-agents by exception. Add a sub-agent only when a sub-task needs its own reasoning loop, would flood context, or benefits from genuine parallelism.
- Reserve the model for judgement; make everything deterministic a tool.
- Every consequential action is human-gated. User actions run on-behalf-of the user so the audit trail names the person, not the agent. Least-privilege throughout.
- Ground answers in retrieval over an approved corpus; cite sources; never invent.

Procedure: define the manifest, bind permitted tools, declare gates and identity, write the eval suite (see the write-evals skill), then hand to the manifest-checker agent. Done means schema-valid, governance-clean, and evals passing, not that the agent "seems to work".
