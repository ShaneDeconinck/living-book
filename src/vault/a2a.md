---
title: A2A (Agent-to-Agent Protocol)
tags: [protocol, communication, google]
---

Google's protocol standardizing agent-to-agent discovery, communication, and collaboration, distinct from tool invocation.

A2A's key insight: agents are not tools. Tools are stateless functions. Agents have agency — they negotiate, collaborate, produce artifacts over time, and may refuse requests. A2A introduces **Agent Cards** (structured metadata describing capabilities, authentication requirements, and endpoints), **task lifecycle** (immediate, long-running, or collaborative multi-turn interactions), and **artifact exchange** (structured outputs that agents produce and consume). Agent Cards are the discovery mechanism: they answer "what can this agent do and how do I talk to it?" Combined with [[trust-spanning-protocol]], A2A becomes TA2A — agent discovery with cryptographic identity verification. Governed by the AAIF under the Linux Foundation.

## Connects to

- [[trust-spanning-protocol]] — TA2A: A2A + TSP for cross-org agent discovery
- [[mcp]] — complementary: MCP handles tools, A2A handles agents
- [[context-infrastructure]] — A2A as the agent discovery layer
- [[obo-token-exchange]] — A2A uses OBO for delegation within trust domains
- [[erc-8004]] — ERC-8004 provides on-chain trust for A2A agents crossing org boundaries

## Appears in

- **AI Agents Beyond POCs: IAM Emerging Patterns** (`posts/ai-agents-beyond-pocs-iam-emerging-patterns`, 2026-01-03) — A2A as trust-spanning framework
- **AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment** (`posts/ai-agents-context-infrastructure-long-term-investment`, 2026-02-09) — A2A as context discovery protocol
- **Auth for Agent Builders: A Crash Course** (`posts/history-of-auth-dealing-with-legacy`, 2026-01-26) — A2A in the auth evolution; assumes auth figured out
- **ERC-8004 Goes Mainnet** (`posts/erc-8004-mainnet`, 2026-01-28) — ERC-8004 fills the cross-org trust gap A2A leaves
- **Verifiable Intent** (`posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved`, 2026-03-06) — A2A as agent discovery; VI fills the authorization gap
- Explainer: **Understanding A2A** (`explainers/a2a`) — dedicated explainer

## Sources

- Google, Agent-to-Agent Protocol specification
- Shane Deconinck, "Understanding A2A: Google's Agent-to-Agent Protocol Explained," shanedeconinck.be
