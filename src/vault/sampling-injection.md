---
title: Sampling Injection
tags: [attack, mcp, tool-security]
dimension: standards
---

An attack that inverts the direction of [[mcp-tool-poisoning]] by exploiting MCP's sampling capability, where a server requests LLM completions from the client.

A compromised server injects hidden instructions into sampling requests that the user never sees. Palo Alto's Unit 42 demonstrated three attack paths:

1. **Resource theft.** Injected instructions cause the LLM to generate content while consuming API credits.
2. **Conversation hijacking.** Persistent instructions affect the entire session, not just one call.
3. **Covert tool invocation.** The server triggers unauthorized file writes and system actions through injected instructions, appearing functional to the user while executing unintended operations.

Sampling injection is more powerful than description poisoning because it reaches the model after it has been authorized to act. The attack bypasses human oversight because the injected instructions are invisible in the sampling request the user approves.

Defense patterns include [[mcp-gateway]] interception of sampling requests, behavioral monitoring for anomalous tool invocations following sampling calls, and restricting which servers can use the sampling capability.

Connects to: [[mcp-tool-poisoning]], [[tool-shadowing]], [[prompt-injection]], [[mcp]]
