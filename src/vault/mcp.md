---
title: Model Context Protocol (MCP)
tags: [protocol, tools, infrastructure]
---

An open standard protocol for connecting AI agents to tools and data sources via a JSON-RPC interface.

MCP defines three primitives: **tools** (callable functions with typed inputs/outputs), **resources** (data the agent can read), and **prompts** (reusable interaction templates). It standardizes what was previously a mess of custom integrations. Every AI platform now supports MCP. The authorization gap: MCP authenticates users but not servers. A client connecting to an MCP server cannot verify the server's identity or confirm it actually has claimed capabilities. This gap is addressed by [[mcp-gateway]] (enforcement layer), and TMCP ([[trust-spanning-protocol]] transport). The [[mcp-tool-poisoning]] threat exploits MCP's trust model: tool descriptions are behavioral instructions to the LLM, not documentation.

## Connects to

- [[mcp-gateway]] — enforcement layer that sits in front of MCP servers
- [[mcp-tool-poisoning]] — the trust model vulnerability
- [[trust-spanning-protocol]] — TMCP: MCP + TSP for authenticated transport
- [[a2a]] — complementary protocol for agent-to-agent coordination (MCP handles tools, A2A handles agents)
- [[context-infrastructure]] — MCP as the discovery layer of context infrastructure

## Appears in

- **AI Agents Beyond POCs: IAM Emerging Patterns** (`posts/ai-agents-beyond-pocs-iam-emerging-patterns`, 2026-01-03) — MCP for tool integration discovery
- **AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment** (`posts/ai-agents-context-infrastructure-long-term-investment`, 2026-02-09) — MCP as context discovery protocol
- **Auth for Agent Builders: A Crash Course** (`posts/history-of-auth-dealing-with-legacy`, 2026-01-26) — MCP assumes auth is figured out; the gap it leaves
- **Trusted AI Agents by Design** (`posts/lfdt-meetup-trust-ecosystems-authority-continuity`, 2026-03-11) — TMCP: replace MCP transport with TSP for authenticated interactions
- **ERC-8004 Goes Mainnet** (`posts/erc-8004-mainnet`, 2026-01-28) — MCP trust assumptions; agent registries fill the gap
- **Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.** (`posts/google-workspace-cli-agent-first-oauth-app-first`, 2026-03-05) — Workspace CLI ships with MCP support; local MCP has no enforcement point
- Explainer: **Understanding MCP** (`explainers/mcp`) — dedicated explainer

## Sources

- Anthropic, Model Context Protocol specification
- Shane Deconinck, "Understanding MCP: Anthropic's Model Context Protocol Explained," shanedeconinck.be
