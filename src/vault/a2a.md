---
title: A2A (Agent-to-Agent Protocol)
tags: [protocol, communication, google]
---

Google's protocol standardizing agent-to-agent discovery, communication, and collaboration, distinct from tool invocation.

A2A's key insight: agents are not tools. Tools are stateless functions. Agents have agency — they negotiate, collaborate, produce artifacts over time, and may refuse requests. A2A introduces **Agent Cards** (structured metadata describing capabilities, authentication requirements, and endpoints), **task lifecycle** (immediate, long-running, or collaborative multi-turn interactions), and **artifact exchange** (structured outputs that agents produce and consume). Agent Cards are the discovery mechanism: they answer "what can this agent do and how do I talk to it?" Combined with [[trust-spanning-protocol]], A2A becomes TA2A — agent discovery with cryptographic identity verification. Governed by the [[aaif]] under the Linux Foundation.
