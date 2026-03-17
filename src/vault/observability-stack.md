---
title: Five-Layer Observability Stack
tags: [observability, infrastructure, accountability]
---

The complete observability architecture for agent governance, from action logging through fleet-level behavioral aggregation.

Five layers: (1) every tool call logged as structured event, (2) authorization context appended — OBO tokens, [[delegation]] chains, (3) decision state captured — model ID, system prompt hash, (4) causal trace IDs propagated across [[multi-agent-trust]] workflows, (5) fleet aggregation detecting emergent behavior across agent populations. Individual layers solve specific problems. The complete stack enables [[agent-incident-response]], regulatory compliance, and detection of fleet-level misbehavior that individual logs cannot surface. Tamper evidence requires logs recorded outside the agent's execution environment (gateway, sidecar, or platform layer) so the agent cannot suppress or alter its own records.
