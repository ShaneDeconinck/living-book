---
title: AgenticCyOps
tags: [paper, security, architecture, mcp, enterprise]
dimension: infrastructure-as-gate
---

Enterprise cyber operations framework deploying phase-scoped MCP agents that reduce exploitable trust boundaries from 200 to 56 (72% reduction) through structural scope constraints [Bai et al., arXiv:2603.09134, March 2026].

Agents are authorized only for their workflow phase: reconnaissance, triage, remediation. A reconnaissance agent has no access to remediation functions. A triage agent cannot perform network scans. The trust boundary reduction is a structural consequence of scope reduction, not detection or policy.

The remaining 56 trust boundaries are ones where agents genuinely need the authority their role requires. Those are the only remaining attack surface. This is [[scoped-authorization]] applied at enterprise scale and measured rather than theorized.

The finding supports the [[cant-vs-dont]] thesis: capability constraints (what the agent structurally cannot do) outperform policy constraints (what the agent is told not to do). It also demonstrates [[blast-radius]] management at the deployment architecture level, not the individual agent level.

## Connects to

- [[cant-vs-dont]] — one of seven independent sources confirming the architectural control thesis
- [[scoped-authorization]] — the mechanism by which boundaries are reduced
- [[blast-radius]] — scoping limits blast radius by construction
- [[mcp]] — agents deployed as MCP agents with phase-specific tool access
- [[containment-by-design]] — the design principle this validates at enterprise scale

## Source

Bai et al., "AgenticCyOps: Agentic AI for Autonomous Cyber Operations," arXiv:2603.09134, March 2026.
