---
title: Orphan Agents
tags: [lifecycle, governance, risk]
dimension: ownership
---

An agent whose owner has departed, whose purpose has ended, or whose credentials have exceeded policy lifetime, combining broad historical permissions with zero ongoing governance.

Orphan agents are the lifecycle equivalent of [[shadow-agents]]: invisible to governance, but with real credentials and real access. They emerge when employee offboarding does not include agent decommissioning, when project agents outlive their projects, or when credential rotation policies do not cover agent identities. The risk compounds: orphan agents accumulate permissions over time ([[scope-drift]]) while receiving no security updates or policy alignment. Detection requires correlating agent registries with HR systems, project lifecycle tools, and credential stores. Prevention requires treating agent decommissioning as a first-class lifecycle event.

## The four decommissioning phases

When an agent is a candidate for retirement, Token Security's lifecycle framework requires four phases:

1. **Identification.** Confirm the agent is ready to retire: task complete, owner approved, or credentials past maximum lifetime.
2. **Dependency analysis.** Map which workflows call it, which data sources it accesses, which other agents interact with it. Without this, shutting down an active agent breaks unknown dependencies.
3. **Credential revocation.** Revoke all active sessions, rotate and delete API keys, propagate revocation across every system the agent had access to. [[coordinated-revocation]] handles the cross-system propagation.
4. **Audit preservation.** Activity logs, credential history, and authorization decisions must survive the agent. Compliance and incident response require reconstructing what a decommissioned agent did, potentially years later.

Saviynt adds a governance gate: retirement requires an approved request validated by the accountable owner and business sponsor.

Microsoft Entra Agent ID (March 2026) creates a dedicated identity type for agents within the identity provider. Agent decommissioning uses the same entitlement management process as human offboarding: when a human identity is deactivated, every agent identity they own is flagged for review.

## Connects to

- [[shadow-agents]] — shadow agents were never registered; orphan agents were registered but abandoned
- [[scope-drift]] — orphan agents compound scope drift: no owner to notice, no governance to correct
- [[authorization-outlives-intent]] — orphan agents are the extreme case of this pattern
- [[agent-provisioning]] — proper provisioning (named owner, defined scope, documented purpose) makes orphan detection tractable
- [[blast-radius]] — orphan agents typically hold permissions accumulated over time with no cleanup; their blast radius is unconstrained and often unknown until an incident forces examination
- [[reliability]] — an unmonitored orphan degrades in reliability with no one to notice; no owner means no alerting, no model updates, and no behavioral drift correction
