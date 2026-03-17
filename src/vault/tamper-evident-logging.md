---
title: Tamper-Evident Logging
tags: [observability, security, audit, cryptography]
---

Tamper-evident logging is the infrastructure pattern that prevents an agent (or an attacker who has compromised an agent) from suppressing or altering its own audit record.

## The problem

Logs are only as useful as the mechanism that produced them. An agent that knows its actions are logged in a specific location can selectively corrupt that location if it has write access to it. This is not hypothetical: it is the same failure mode as an agent that bypasses advisory safety controls — the entity that benefits from overriding a check should not be the entity enforcing it.

This applies the same structural principle as [[semantic-policy-enforcement]] and [[sandboxing]]: enforcement must sit outside the agent's reach to be reliable.

## Infrastructure-level logging

The first defense: place the logging mechanism outside the agent's execution environment. A gateway, sidecar, or platform layer that intercepts and records all agent actions cannot be suppressed by the agent itself, because the agent has no write access to it. This is the distinction between agent-level logging (the agent logs its own actions) and infrastructure-level logging (the infrastructure records what the agent does).

Infrastructure-level logging is a prerequisite for using logs as compliance evidence rather than just debugging context. Any agent with high blast radius (B4+: regulated consequences, financial authority, customer-facing decisions) should log through infrastructure the agent cannot reach.

## Cryptographic sealing: the Certificate Transparency model

For high-stakes deployments where log integrity must be provable to external parties, append-only log stores with Merkle tree sealing provide stronger assurance.

The Certificate Transparency model (RFC 9162): each log entry is included in a Merkle tree whose root is published externally. Retrospective insertion or deletion is detectable because it requires recalculating all tree roots from the point of modification forward. An agent — or an attacker with agent access — cannot alter the log without leaving a detectable signature.

This is the same infrastructure pattern used to make TLS certificate issuance auditable by any observer. Applied to agent logs, it means a compliance auditor can verify that the log they receive matches the one that was sealed at the time of the action.

## When to apply each

- **Agent-level logging**: sufficient for development and low-stakes deployments where logs are debugging tools, not evidence.
- **Infrastructure-level logging**: required for any agent where the log might be used as a compliance artifact or incident evidence. Implement before fleet scale; retrofitting is expensive.
- **Cryptographic sealing**: warranted for regulated contexts (financial authority, healthcare, legal), long-running agents with persistent state, or any deployment where external auditability is a requirement.

## Connections

- [[sandboxing]] — the same "enforcement outside the agent's reach" principle applied to execution
- [[semantic-policy-enforcement]] — architecture-over-policy principle; same logic applies to logging
- [[decision-provenance]] — tamper-evidence makes provenance records reliable, not just present
- [[accountability-pillar]] — audit trails are only compliance artifacts if they cannot be altered
- [[infrastructure-levels]] — I3 introduces infrastructure-level logging; I5 adds cryptographic sealing
