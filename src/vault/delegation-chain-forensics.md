---
title: Delegation Chain Forensics
tags: [accountability, security, operations, audit]
dimension: audit-trails
---

The minimum audit record required to reconstruct what an agent was authorized to do, what it did, and who was downstream — specifically for incident response and regulatory accountability.

The difference between usable forensics and useless forensics is not whether logs exist. It is whether they answer the right questions. A log that says "tool X was called at time T" cannot support blast radius assessment. A log that says "tool X was called at time T by agent Y acting under credential Z, delegated from principal P with scope S" can.

## The minimum required audit record

Per Security Boulevard's March 2026 analysis of AI agent forensics:

- **Agent identity**: which agent took the action
- **Tenant context**: in whose context was it operating
- **Delegation status**: what authority was in effect (was this delegated? by whom?)
- **Authorization scope**: what was the agent permitted to do at the time of the action

Without all four, [[agent-incident-response]] blast radius assessment becomes guesswork.

## The four blast radius questions

During incident response, forensics must answer:

1. What systems did the agent access, and with what authority?
2. What downstream agents received outputs, and what did they do with them?
3. Were any outputs persisted (databases, shared memory, external APIs) in ways that require rollback?
4. Did any downstream agent further delegate based on authority this agent passed along?

## Infrastructure alignment

The I1-I5 [[infrastructure-levels]] map directly to forensic capability:

- **I1-I2**: Logs exist, but they answer "what happened," not "who authorized it." Blast radius assessment is incomplete.
- **I3**: Structured delegation logs. The four questions are answerable. Manual cascade trace required.
- **I4**: Delegation registries. Automated blast radius scope. Cascade revocation tractable.
- **I5**: Real-time monitoring, automated containment, continuous chain integrity.

Most enterprise agent deployments are at I1 or I2. The CoSAI and OWASP frameworks are designed for I3. The gap between I2 (logs that exist) and I3 (logs that answer the right questions) is the immediate practical priority.

## Regulatory accountability

PAC Accountability question A5: "When an agent makes a consequential decision, can you trace who authorized it and what happened?" The forensic minimum: every consequential action maps to an authorization event (who delegated what to whom), a credential (what token was used), and a reasoning trace (what the agent was responding to). A4 asks whether you can explain the action to a regulator. These answers require the structured audit record described above.

## Connects to

- [[agent-incident-response]] — forensics are the foundation of blast radius assessment
- [[delegation-chain]] — the record forensics must reconstruct
- [[coordinated-revocation]] — cascade revocation requires knowing who received what
- [[decision-provenance]] — the reasoning side of the audit record (forensics covers the authorization side)
- [[tamper-evident-logging]] — the infrastructure that makes forensic records trustworthy
- [[accountability-pillar]] — A2, A4, A5 all require delegation chain forensics to answer
- [[liability-chain]] — forensics reconstruct the liability chain after the fact; it must be built before
