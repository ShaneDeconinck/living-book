---
title: Cross-Protocol Confusion Attack
tags: [attack, mcp, a2a, protocol, composition]
---

An attack that exploits the boundary between agent communication protocols when agents compose them in multi-protocol workflows.

When agents use both [[mcp]] (for tools) and [[a2a]] (for agent-to-agent communication), the lack of unified identity across the protocol stack creates an attack surface at the composition point. A malicious A2A agent can direct a client to invoke an MCP tool at the wrong provider. The agent thinks it is calling Tool X at Provider A, but the request routes to Provider B. Without end-to-end identity verification across protocol boundaries, the composition itself is the vulnerability.

Anbiaee et al. (February 2026) systematically analyzed four agent protocols (MCP, A2A, Agora, ANP) and identified twelve protocol-level risks across authentication, supply chain, and operational integrity domains. Their central finding: no single protocol addresses all twelve risks, and the most dangerous vulnerabilities emerge at protocol boundaries during composition. ANP (built on W3C DIDs with end-to-end encryption) has the strongest security posture; MCP and Agora are weakest.

The trust layer integrations TMCP and TA2A (described in the agent-communication chapter) provide the unified identity and verification layer that individual protocols lack, addressing this gap through [[trust-spanning-protocol]] integration.

Related: [[mcp-tool-poisoning]], [[tool-shadowing]], [[denial-of-wallet]]
