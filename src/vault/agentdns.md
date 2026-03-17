---
title: AgentDNS
tags: [infrastructure, discovery, naming, governance, protocol]
---

A proposed root-domain naming system for LLM agents and their tools, extending the DNS model to create a unified namespace and centralized discovery layer for the agent ecosystem. IETF Internet-Draft draft-liang-agentdns-00 (filed 2026, expires April 2026).

## The problem it solves

MCP and A2A discovery today relies on known endpoints, hardcoded URLs, environment variables, or per-vendor registries — each maintained independently. There is no generalized naming system for agent tools. An agent that wants to discover a tool for searching academic papers has no standard place to look.

This means: no centralized governance layer for discovery. A malicious MCP server becomes discoverable just by being installable through a package registry. The SANDWORM_MODE campaign's 19 typosquatting npm packages achieved reach through exactly this gap. [[skill-supply-chain]] attacks require discoverability to spread.

## What AgentDNS proposes

A unified namespace with format:
```
agentdns://{organization}/{category}/{name}
```

**Natural-language service discovery**: an agent queries "find a tool that can search recent academic papers" and receives a resolved endpoint. The root server processes queries using retrieval-augmented generation.

**Single authentication**: one AgentDNS registration replaces per-vendor registration.

**Protocol-agnostic**: designed to be compatible with both [[mcp]] and [[a2a]].

## Governance implication

A root-domain naming system centralizes discovery — which also centralizes the ability to revoke access for a compromised or deregistered server. If discovering a server requires a verifiable identity claim, the bar for typosquatting and supply chain attacks rises substantially.

This is governance through the naming layer rather than the enforcement layer: you control what agents can find, not just what they can do.

## What it does not yet specify

AgentDNS is an early-stage -00 draft. The following governance questions are open:
- Governance of the root server itself (who controls it, what process resolves disputes)
- Namespace conflict resolution
- Key rotation for registered entries
- Security of the RAG-based query resolution process

The solution has not been stress-tested. These gaps matter before building production systems on it.

## Connects to

- [[mcp]] — one of the protocols AgentDNS aims to provide naming for
- [[a2a]] — the other
- [[skill-supply-chain]] — AgentDNS raises the bar for typosquatting attacks via naming-layer identity requirements
- [[shadow-agents]] — ungoverned agents may not register; AgentDNS governance requires complete registration to be effective
- [[ai-aware-sase]] — I4 in the network infrastructure maturity scale requires naming-layer governance; AgentDNS is the proposed mechanism
- [[semantic-routing]] — AgentDNS resolves which agent/tool to reach; SIRP governs how the request is routed once discovered

## Sources

- [Liang 2026]: Liang et al., "AgentDNS: A Root Domain Naming System for LLM Agents," draft-liang-agentdns-00, datatracker.ietf.org, 2026
- Chapter: [Network-Layer Agent Infrastructure](../chapters/network-layer-infrastructure.md)
