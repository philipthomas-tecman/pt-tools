---
name: build-mcp-server
description: >
  This skill should be used when building an MCP server to expose tools or
  knowledge to agents: "build an MCP server", "expose these tools over MCP",
  "add an MCP endpoint".
metadata:
  version: "0.1.0"
---

Build MCP servers that agents can actually use.

Principles:
- Expose a tight, coherent set of tools, not a hundred. Each tool has one clear job and a precise, typed input schema.
- Choose the transport deliberately: stdio for a local process, streamable HTTP for a remote service, SSE where required. Document the choice.
- Auth and least-privilege: authenticate the caller; scope tokens to the minimum; secrets via environment or vault, never inline; HTTPS for remote transports.
- Idempotent writes and agent-readable errors, as for any tool.
- Version the tool surface; a breaking change to a tool's schema is a major version with a deprecation window.

Procedure: define the tool schemas and transport, implement with least-privilege auth, write tests that call each tool, register in `.mcp.json`, and verify. Keep the surface small enough that an agent never has to guess which tool to reach for.
