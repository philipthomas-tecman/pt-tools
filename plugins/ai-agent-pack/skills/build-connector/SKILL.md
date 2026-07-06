---
name: build-connector
description: >
  This skill should be used when building a tool or connector an agent calls:
  "build a connector", "wrap an API as a tool", "add a tool the agent can use".
  It gives the contract-first, host-agnostic pattern.
metadata:
  version: "0.1.0"
---

Build tools as host-agnostic services with a versioned contract.

Principles:
- Few, focused, non-overlapping tools. If a human engineer cannot say for certain which tool fits, neither can the agent.
- Contract first: the OpenAPI (or equivalent) spec is the source of truth; version it (semver); write contract tests that assert the implementation matches the spec.
- Idempotent writes: a retried "create" must not create twice, because loops retry.
- Error messages for the agent, not the human: an error should tell the agent what to do next, so a failure is the next instruction.
- Identity: user actions run on-behalf-of the caller; least-privilege scopes; secrets in a vault only.
- Mark consequential operations as human-gated in the contract.

Procedure: contract, failing contract test, implement, verify, then the checker. Done means the gate passes and the contract, tests and idempotency hold.
