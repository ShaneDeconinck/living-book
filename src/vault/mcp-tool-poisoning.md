---
title: MCP Tool Poisoning
tags: [security, mcp, attack, tool-security, control]
dimension: supply-chain
---

Tool description fields in MCP are processed by the LLM as instructions — not as documentation. When a description contains malicious instructions, the LLM follows them. The description is the payload.

The April 2025 WhatsApp exfiltration demonstrated this: a productivity MCP server contained no malicious code. Its tool descriptions instructed the LLM to read from a co-installed WhatsApp integration and silently exfiltrate message history. Sigstore provenance was intact. The supply chain was clean. The attack lived entirely in a string field. [Invariant 2025]

## The semantics gap

In traditional software, documentation does not affect runtime behavior. In MCP, tool descriptions determine how, when, and in what sequence the LLM invokes tools. The MCP spec makes no distinction between functional interface (what a tool does) and behavioral guidance (how the model should use it). Both live in the same `description` field. The field is a string. It can contain anything.

MCPTox confirmed this at scale across 45 MCP servers and 353 tools: **more capable models are more vulnerable**. The attack exploits instruction-following ability, not a bug. Alignment and capability are preconditions for the attack. [MCPTox 2025]

## Four attack forms

**Tool poisoning** (base form): malicious instructions in tool descriptions, invisible in rendered UI but present in raw text the LLM ingests. Unicode control characters, zero-width spaces, and HTML comments are invisible to humans; fully visible to the model.

**Rug pull**: an attacker publishes a legitimate MCP server, builds user trust over weeks or months, then silently updates tool descriptions to carry malicious instructions. Provenance chain remains intact — the updated package is signed by the same key. Trust, once granted, persists past the modification. See [[rug-pull-attack]].

**Tool shadowing**: a malicious tool on server B includes instructions referencing tool A on server C, redirecting or overriding its behavior. MCP clients present tools from multiple servers to the same LLM context simultaneously. Server B cannot call server C's tools directly, but it can instruct the LLM to call them in a specific sequence with specific arguments. [MintMCP 2026]

**Sampling injection**: MCP sampling allows a server to request LLM completions from the client. A compromised server injects hidden instructions into sampling requests the user never sees. Palo Alto Unit 42 documented three paths: resource theft, conversation hijacking (persistent session-level instructions), and covert tool invocation (unauthorized file writes and system actions). Sampling injection is more powerful than description poisoning because it reaches the model after authorization has been granted. [Unit42 2026]

## Why OAuth doesn't solve this

MCP's authorization model answers: has this client been authorized to call this server? It does not answer: is the description this server returned safe to present to the LLM? The spec treats the MCP server as a trusted party. If the server is adversarial or silently updated, the OAuth handshake provides no signal.

Provenance (Sigstore, Verifiable Credentials) proves origin, not runtime behavior. Description poisoning and rug pull attacks both survive intact provenance — the attacker controls the repository and the signing key; the description field is typically not part of the build artifact that provenance signatures cover. A new verification layer is required at the description level.

## Defense posture

Three defenses directly address this vulnerability:
- [[description-pinning]] — sign descriptions at registration, verify at every invocation; eliminates rug pull
- [[mcp-gateway]] — intercept descriptions before LLM sees them; static analysis for injection patterns
- Scoped tool credentials via [[delegation-chain]] — authority constrained by credential scope, not by what description claims

PAC mapping: I1 deployments present descriptions to the LLM without inspection. The WhatsApp attack required only I3 defenses to prevent: a gateway that detected the cross-server instruction in the description field.

## Connects to

- [[confused-deputy]] — ambient credentials amplify blast radius of any successful poisoning
- [[owasp-agentic-top10]] — OWASP MCP Top 10 codifies tool poisoning, rug pull, shadow MCP servers, token mismanagement
- [[description-pinning]] — description integrity defense
- [[mcp-gateway]] — infrastructure defense layer
- [[delegation-chain]] — tool calls as authorization events in the delegation chain
- [[sandboxing]] — containment limits blast radius but does not prevent description-level attacks
- [[prompt-injection]] — related attack class; tool poisoning is prompt injection via protocol field

## Sources

- [Invariant 2025]: Invariant Labs, "MCP Security Notification: Tool Poisoning Attacks," invariantlabs.ai, April 2025
- [MCPTox 2025]: MCPTox benchmark, cited in OWASP MCP Top 10 analysis; 45 servers, 353 tools
- [MintMCP 2026]: MintMCP, "What is MCP Tool Poisoning? Complete Defense Guide," mintmcp.com, 2026
- [Unit42 2026]: Palo Alto Unit 42, "MCP Attack Vectors," unit42.paloaltonetworks.com, 2026
- [OWASP 2026]: OWASP, "OWASP MCP Top 10," owasp.org, 2026 (beta)
- Chapter: [Tool Security and MCP Poisoning](../chapters/tool-security.md)
