---
title: Permission Intersection Problem
tags: [authorization, security, human-agent]
dimension: delegation-chains
---

The vulnerability where an agent retrieves data under one user's permissions but delivers it to an audience that lacks access, producing authorized retrieval with unauthorized disclosure.

Distinct from the [[confused-deputy]] (which acts with authority it should not have). The permission intersection agent acts with correct authority but delivers results to the wrong audience. Four vulnerabilities rated CVSS 9.3+ across Anthropic MCP, Microsoft Copilot, ServiceNow, and Salesforce exploited this gap.

In shared contexts (team channels, collaborative workspaces, multi-user dashboards), the effective permission must be the **intersection** of all participants' permissions, not the union. This is harder than input-side authorization because: the agent must know who will see its output at retrieval time, shared contexts change membership dynamically, and no single agent can reliably assess the downstream audience of a Slack message or shared document.

The fix requires infrastructure-enforced authorization on both sides of the agent's operation: not just "can the agent access this data?" but "can every recipient see this data?" The permission intersection must be computed and enforced by infrastructure, not left to the agent's judgment.

## Connects to

- [[confused-deputy]] — related but distinct: confused deputy has wrong authority; permission intersection has right authority, wrong audience
- [[scoped-authorization]] — must extend to output scope, not just input scope
- [[operational-envelopes]] — envelopes must include audience constraints
- [[infrastructure-in-the-loop]] — enforcement cannot depend on agent judgment

## Sources

- [Okta 2026]: "AI Agent Security Series: Rebuilding IAM for Autonomous Trust," okta.com/blog/ai, 2026 (Part 6)
