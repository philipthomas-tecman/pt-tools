---
name: add-change
description: >
  This skill should be used when implementing a scoped change in a harnessed
  repository, for example "add an endpoint", "implement the next STATE item",
  "fix this and verify". It gives the contract-first / test-first procedure and
  the definition of done.
metadata:
  version: "0.1.0"
---

Implement one scoped change, gated.

Procedure:
1. Read `VISION.md` and the nearest `STATE.md`. Take the single In-progress item or the top of Next. If none, ask.
2. If the project defines a contract (an OpenAPI spec, a schema, a public interface), change the contract first and bump its version. Write the failing test that encodes the new behaviour before implementing.
3. Implement in the repo's existing style. Do not reformat or rename unrelated code.
4. Run `build/verify`. Iterate until it exits 0. Done means the gate is green.
5. Commit one concern with a clear message. Update `STATE.md`: move the item to Done with the commit SHA and gate evidence.
6. Hand the change to the checker (or open a PR) for the independent verdict. Do not self-approve the substance.

Definition of done: the gate passes, the contract and tests are updated, secrets are absent, any consequential write carries a human gate, and `STATE.md` reflects reality.
