# Add these to your existing pt-tools marketplace

No new marketplace. Two steps.

## 1. Drop the plugin folders in
Copy `loop-harness/` and `ai-agent-pack/` into your `pt-tools` marketplace repo, wherever it keeps its plugin folders (for example a `plugins/` directory, or the repo root).

## 2. Add two entries to pt-tools marketplace.json
In `pt-tools/.claude-plugin/marketplace.json`, add these to the `plugins` array. Set each `source` to where you placed the folder in step 1 (the example assumes a `plugins/` directory):

```json
{
  "name": "loop-harness",
  "source": "./plugins/loop-harness",
  "description": "Stack-agnostic loop-engineering harness: pwsh hooks (session context, deny-list guard, Stop gate on build/verify.ps1), maker/checker/explorer/verifier sub-agents, /init-harness bootstrap, per-stack verify templates."
},
{
  "name": "ai-agent-pack",
  "source": "./plugins/ai-agent-pack",
  "description": "Build tooling for AI features: build-agent, build-connector, build-mcp-server and write-evals skills, plus a manifest-checker agent. Composes with loop-harness."
}
```

## 3. Commit, push, then in Claude Code
- `/plugin marketplace update`
- `/plugin install loop-harness@pt-tools`
- `/plugin install ai-agent-pack@pt-tools`

One marketplace, two more entries. Nothing else to maintain.
