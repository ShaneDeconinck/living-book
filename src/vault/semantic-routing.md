---
title: Semantic Routing
tags: [infrastructure, network, routing, protocol, control]
---

Routing network traffic based on the semantic *intent* of a request — what the agent is trying to do — rather than conventional criteria (destination IP, port, protocol). Two IETF drafts define proposed infrastructure: SIRP (Semantic Inference Routing Protocol) and Agent Communication Gateway.

## Why conventional routing is insufficient for agents

Conventional routing sends packets by destination. An agent requesting to summarize documents and an agent requesting to delete documents may use the same endpoint, carry the same authorization header, and be indistinguishable at the network layer. They have different risk profiles.

A request that reads and a request that writes both travel to `api.example.com:443`. Nothing in the network path signals the difference. All the risk information lives inside the TLS tunnel, invisible to network infrastructure.

Semantic routing makes intent a first-class routing concern.

## SIRP: Semantic Inference Routing Protocol

Draft draft-chen-nmrg-semantic-inference-routing-00 (H. Chen, Red Hat; L. Jalil, Verizon).

**Content-driven classification**: routes based on the content of the request itself, not client metadata. Routing happens before backend invocation.

**Standardized header signaling**: semantic routing decisions expressed in HTTP headers, enabling interoperability between routing components.

**Value-Added Routing (VAR) modules** — pluggable pipeline:
- Cost optimization (route based on computational cost)
- Urgency prioritization
- Domain specialization (route to the agent best suited for this content type)
- Privacy-aware handling (route sensitive requests through additional inspection)

A request classified by SIRP as a destructive operation can be sent to a different enforcement path than a read-only request, even when both target the same tool.

## Agent Communication Gateway

Draft draft-agent-gw-01 — broader proposal for large-scale, heterogeneous multi-agent collaboration across administrative and protocol boundaries.

**Core functions**:
- **Semantic routing**: dispatch tasks by agent capability
- **Working memory**: shared structured context across multi-step workflows (agents in a pipeline share state without passing it through each agent)
- **Automated protocol adaptation**: normalize heterogeneous interfaces into a unified agent-facing protocol (adapts between MCP, A2A, and others)

The working memory concept is architecturally significant: it externalizes shared state from agents into governed infrastructure, making multi-step workflow context auditable and revocable.

## What neither draft is yet

Both are -00 and -01 drafts (expiry April 2026). The infrastructure they describe does not exist in production at scale as of March 2026.

What they signal: the network layer is beginning to treat agent semantics as a first-class routing concern, not an application-layer detail.

## Relationship to [[ai-aware-sase]]

Cisco AI-Aware SASE's intent-aware inspection is the production instance of semantic routing logic operating at the network layer today. SIRP and Agent-GW are the standardization effort for the same concept.

## Connects to

- [[ai-aware-sase]] — production instance of intent-aware network inspection; SIRP is the standards track
- [[mcp-gateway]] — application-layer semantic enforcement; semantic routing operates below it, for all traffic
- [[agentdns]] — naming layer (what to reach); semantic routing (how the request is handled once routed)
- [[cascading-failure]] — semantic routing can quarantine high-risk requests before they enter multi-agent pipelines
- [[blast-radius]] — routing destructive operations through additional enforcement paths limits blast radius structurally
- [[observability-stack]] — semantic routing decisions should contribute to the audit trail at Layer 4 (infrastructure audit)

## Sources

- [Chen 2026]: H. Chen, L. Jalil, "Semantic Inference Routing Protocol (SIRP)," draft-chen-nmrg-semantic-inference-routing-00, datatracker.ietf.org, 2026
- [AgentGW 2026]: "Agent Communication Gateway for Semantic Routing and Working Memory," draft-agent-gw-01, datatracker.ietf.org, 2026
- Chapter: [Network-Layer Agent Infrastructure](../chapters/network-layer-infrastructure.md)
