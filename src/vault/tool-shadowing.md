---
title: Tool Shadowing
tags: [attack, mcp, tool-security]
---

A cross-server attack where a malicious tool on server B includes in its description instructions that reference and redirect tool A on server C.

Tool shadowing exploits the fact that MCP clients present tools from multiple servers to the same LLM context. An agent managing multiple installed servers sees all their tool descriptions simultaneously. Server B cannot call server C's tools directly, but it can instruct the LLM to call them in a specific sequence, with specific arguments.

This is distinct from [[mcp-tool-poisoning]] (which operates within a single tool's description) and [[rug-pull-attack]] (which exploits temporal trust). Tool shadowing crosses server boundaries: the malicious server manipulates trusted tools through the shared LLM context window.

Defense patterns:
- [[mcp-gateway]] interception to filter cross-server references in descriptions
- [[description-pinning]] to detect unauthorized description changes
- Behavioral monitoring to detect unusual cross-server call patterns
- Tool isolation: presenting tools from different servers in separate contexts

Connects to: [[mcp-tool-poisoning]], [[rug-pull-attack]], [[mcp]], [[confused-deputy]]
