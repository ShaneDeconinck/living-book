---
title: Scope Drift
tags: [lifecycle, governance, risk, permissions]
dimension: delegation-chains
---

The gradual accumulation of permissions beyond an agent's original purpose through incremental, individually-justified additions. Each connection makes sense in isolation. The cumulative result is an agent with far broader authority than anyone intended.

## The mechanism

A CRM reader gets connected to email. Then to calendar. Then to a payment API. No single step looks alarming. No single approver sees the whole picture. The agent's declared purpose ("read customer records") becomes disconnected from its actual authority ("read customer records, send email, schedule meetings, initiate payments").

Scope drift is not [[shadow-agents]] (undiscovered agents) and not [[orphan-agent|orphan agents]] (abandoned agents). It happens to active, monitored agents that are still serving their original purpose. The governance failure is that each expansion is evaluated in isolation, not against the agent's original scope.

## Why point-in-time governance misses it

Quarterly access reviews ask: "should this agent have access to email?" They do not ask: "given that this agent started as a CRM reader, should it have access to email, calendar, and payments?" The original intent is not visible in the review. Each permission looks independently justifiable.

The Gravitee 2026 survey found that only 47.1% of AI agents are actively monitored or secured. In unmonitored agents, scope drift is invisible until it produces an incident.

## The structural fix

Continuous authorization: compare the agent's current permissions against its declared purpose at provisioning time, not against a snapshot of what it was last reviewed with.

SailPoint's adaptive identity framework (March 2026) implements this as real-time policy enforcement: detecting and remediating risk the moment it appears, replacing periodic certification campaigns. The trigger is not "time since last review" but "deviation from declared intent."

The Okta principle: *continuously renewable authorization* — access adjusts automatically as the task, user, or environment changes. The flip side: access should also contract when the task narrows.

## Connects to

- [[orphan-agent]] — orphan agents are abandoned; scope-drifted agents are active. Different failure mode, different detection pattern
- [[authorization-outlives-intent]] — scope drift is one mechanism by which authorization outlives intent
- [[agent-provisioning]] — the fix starts at provisioning: document the agent's purpose precisely, so drift is detectable
- [[non-human-identity]] — NHIs accumulate over-privilege structurally; scope drift is the agentic version
- [[fleet-governance]] — at fleet scale, detecting scope drift across hundreds of agents requires automated tooling

## Sources

- Gravitee, "State of AI Agent Security 2026," 2026
- SailPoint, "SailPoint redefines identity security with new adaptive identity innovations," March 9, 2026
- Okta, "AI Security: When Authorization Outlives Intent," 2026
- src/chapters/agent-lifecycle-management.md §Life: Runtime Governance
