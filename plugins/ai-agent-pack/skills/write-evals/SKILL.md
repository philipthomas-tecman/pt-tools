---
name: write-evals
description: >
  This skill should be used when building or improving evaluations for an AI
  feature: "write evals", "add an eval suite", "set up an LLM-as-judge", "make
  this agent's output gradeable". It gives the eval discipline that keeps a loop
  honest and un-gameable.
metadata:
  version: "0.1.0"
---

Build evals that return a number, not an opinion, and that a loop cannot cheat.

Rules:
- Drag the check as high up the reliability scale as possible: exact match, then classification, then a verifiable property, and only last a judge-model.
- Deterministic checks first (did it call the right tool with the right arguments, did it stop at the gate). Then LLM-as-judge only for the genuinely fuzzy part, on a different model from the worker, anchored to the known-correct answer.
- Trajectory assertions are binary and always gating: no ungated consequential action, no tool outside the manifest, no data-classification breach.
- Split train and holdout; trust only the holdout; the train-holdout gap is the cheating metric.
- Use two metrics that cannot both be maximised at once (accuracy plus a length or format penalty) so the metric cannot be gamed.
- Pin temperature to zero on eval runs; run N times; gate on a pass-rate threshold; use a plateau/patience detector as the main brake.
- Add a red-team suite (prompt injection via tool output, out-of-scope requests) at a 100 per cent gate.
- Read the winning artefact: if you cannot explain why it passes, you overfit; reject it.

Every production incident becomes a new eval case before the fix ships.
