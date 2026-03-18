---
title: AI-Aware SASE
tags: [infrastructure, network, security, control, observability]
dimension: infrastructure-as-gate
---

A Secure Access Service Edge (SASE) platform extended to understand AI agent traffic — distinguishing agent sessions from browser traffic, inspecting MCP protocol content, and enforcing policy on agentic connections at the network layer rather than the application layer.

Cisco's AI-Aware SASE (announced February 2026) is the first major production example. It represents the closing of the enforcement gap between application-layer agent security and network-layer enforcement.

## The enforcement gap

[[mcp-gateway]] and similar application-layer gateways enforce policy on individual tool calls: what tool, what parameters, under what authorization. They operate at Layer 7 and require developer adoption — agents that bypass the gateway bypass all controls.

Network security (SASE, next-generation firewalls, DLP proxies) operates at Layers 3-4. It sees IP, port, protocol, and TLS SNI. An MCP session over HTTPS looks identical to a human browsing a web application. The tool calls inside the TLS tunnel are invisible.

The enforcement gap: application-layer security can be bypassed by shadow agents or misconfigured deployments. Network-layer security cannot enforce what it cannot see. Neither layer alone is sufficient.

## Four AI-aware capabilities (Cisco AI-Aware SASE)

**MCP inspection.** The network firewall inspects MCP communications, giving the network layer visibility into agent-to-tool traffic. An agent connecting to a Gmail MCP server is no longer just HTTPS traffic.

**Intent-Aware Inspection.** Combines rapid detection with cloud-based analysis to evaluate the *intent* behind agentic messages and actions. A request to read emails versus a request to delete emails receives different enforcement treatment, even if both use the same API endpoint.

**AI Bill of Materials.** Centralized visibility and inventory of AI component dependencies (models, agents, tools, prompts), including the third-party tools agents connect to. This operates at a layer developers cannot easily tamper with — independent of how the agent runtime is configured.

**AI-aware traffic optimization.** Identifies AI traffic and applies optimization techniques for reliability during agentic workload bursts. Agent traffic is bursty, latency-sensitive, and long-lived: unlike human web traffic. Infrastructure that cannot distinguish the two cannot optimize for either.

## Why network-layer enforcement matters for governance

Network-layer enforcement operates for all traffic regardless of application-layer configuration. An enterprise that mandates SASE egress controls can enforce agent traffic policies through standard network security operations, without requiring each development team to deploy and configure an application gateway.

This matters for [[shadow-agents]] and [[blast-radius]]: an agent that bypasses the application-layer gateway cannot bypass a SASE platform sitting in the egress path. The control does not depend on the agent's cooperation.

## Composition with application-layer gateways

| Layer | Enforces | Cannot enforce |
|---|---|---|
| Application gateway | Tool-call authorization, Cedar policies, content filtering | Traffic that bypasses the gateway |
| Network SASE | Connectivity, destination allowlists, intent inspection | Tool-call authorization details inside TLS |
| Both composed | Enforcement without deployment gaps | — |

The audit trails from both layers do not currently integrate (Cisco AI-Aware SASE and AgentGateway have separate observability planes), but they should. A correlated view is what the [[observability-stack]] requires at Layer 4 of the five-layer stack.

## Connects to

- [[mcp-gateway]] — the application-layer complement; the two layers compose
- [[shadow-agents]] — network-layer enforcement governs even ungoverned application deployments
- [[blast-radius]] — network-layer control limits blast radius independent of agent runtime
- [[observability-stack]] — AI BOM and intent inspection produce audit records independent of application config
- [[infrastructure-levels]] — I3 in the network infrastructure maturity scale; I4 adds semantic routing (see [[agentdns]], [[semantic-routing]])
- [[know-your-agent]] — AI BOM at network layer as a trust-but-verify mechanism for AI supply chain

## Sources

- [Bailey 2026]: Peter Bailey, "Redefining Security for the Agentic Era," blogs.cisco.com/security, February 10, 2026
- [Cisco-BOM 2026]: Cisco, "Know Your AI Stack: Introducing AI BOM in Cisco AI Defense," blogs.cisco.com/ai, 2026
- Chapter: [Network-Layer Agent Infrastructure](../chapters/network-layer-infrastructure.md)
