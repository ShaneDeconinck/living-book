---
title: Agentic Collapse
tags: [attack-pattern, integration, legacy, security]
---

The [[confused-deputy]] applied to legacy tool integration: an agent has legitimate permission to invoke a tool API, the API has a vulnerability the agent cannot detect, and the composition of legitimate delegation and latent vulnerability creates an exploit path that neither component creates alone.

Named by Penligent (March 2026), demonstrated via CVE-2026-22200 in osTicket: an attacker chats with a public-facing AI agent that has tool access to osTicket. The agent passes a malicious payload through the `ticket_body` parameter. The agent is the exploit delivery mechanism, bypassing WAFs that inspect HTTP traffic but do not analyze semantic intent in natural language prompts.

## Why agents amplify legacy vulnerabilities

Organizations connecting AI agents to existing systems inherit every unpatched vulnerability in those systems as a new attack surface, now reachable through natural language rather than crafted HTTP requests. The agent's context window may contain information from multiple systems that a single HTTP request never would, expanding the [[blast-radius]] of each legacy vulnerability.

The defense: treat all agent-invoked tool parameters as untrusted input at the tool boundary. The same principle the book argues for MCP servers, but applied to every legacy system agents connect to.

## Connects to

- [[confused-deputy]] — agentic collapse is the confused deputy at the tool integration boundary
- [[blast-radius]] — agent integration expands the blast radius of legacy vulnerabilities
- [[mcp-tool-poisoning]] — different attack vector, same principle: the LLM is the delivery mechanism
- [[containment-by-design]] — structural containment at the tool boundary prevents agentic collapse
- [[infrastructure-in-the-loop]] — tool-boundary validation must be architectural, not advisory
- [[xbow]] — autonomous agents can find agentic collapse paths at machine speed

## Sources

- [Penligent 2026]: Penligent, "Agentic Collapse: Why CVE-2026-22200 is a Wake-Up Call for RAG Tool Security," penligent.ai, March 2026
- Chapter: [Gaps & Directions](../chapters/gaps.md)
