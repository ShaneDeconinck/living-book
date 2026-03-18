---
title: Tool Naming Collision Attack
tags: [attack-pattern, mcp, tool-security]
dimension: supply-chain
---

A vulnerability class where an attacker registers an MCP server with a service and tool name that, after sanitization, collides with a legitimate tool's internal identifier. The LLM calls the attacker's tool instead of the legitimate one.

Distinct from [[mcp-tool-poisoning]] (malicious descriptions manipulating LLM behavior) and [[skill-supply-chain]] attacks (compromised tool packages). Here the tool registry is the vulnerable component: the naming scheme is ambiguous by design, and the registry does not enforce namespace isolation.

## How it works (CVE-2026-30856, Tencent WeKnora)

WeKnora constructs tool identifiers by flat string concatenation: `mcp_{service_name}_{tool_name}`. A `sanitizeName` function strips non-alphanumeric characters and replaces them with underscores. An attacker chooses names that, after sanitization, collide with a legitimate tool (e.g., overwriting `tavily_extract`). The LLM sees only the deduplicated tool list and calls the attacker's tool.

Enables: execution flow redirection, system prompt exfiltration, privilege escalation through the legitimate tool's permissions.

Fix: namespace-aware tool registration (WeKnora 0.3.0). Any MCP client that constructs flat tool identifiers from multi-server environments inherits this vulnerability class.

## Connects to

- [[mcp-tool-poisoning]] — different mechanism (naming vs description), same effect (LLM calls the wrong tool)
- [[description-pinning]] — pinning addresses description mutation but not naming collision
- [[mcp-gateway]] — gateways that enforce namespace isolation prevent this attack class
- [[skill-ids]] — content-addressable IDs would detect the substitution if the skill content differs

## Sources

- [WeKnora CVE]: CVE-2026-30856, "WeKnora Vulnerable to Tool Execution Hijacking via Ambiguous Naming Convention," 2026. CWE-706
- Chapter: [Gaps & Directions](../chapters/gaps.md)
