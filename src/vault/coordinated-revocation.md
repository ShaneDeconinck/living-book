---
title: Coordinated Revocation
tags: [security, operations, multi-agent, accountability]
dimension: agent-identity
---

Revoking a compromised agent's credentials stops that agent. It does not stop downstream agents that have already acted on its outputs, persisted its decisions, or further delegated based on authority it passed along.

This is the hardest containment problem in multi-agent systems: revocation is point-to-point, but impact is distributed. The Salesloft Drift AI breach illustrates it at scale — stolen OAuth tokens exposed over 700 companies in 10 days because when one organization revoked credentials, connected domains had no standard mechanism to receive that signal.

## What coordinated revocation requires

Multi-agent containment is closer to distributed transaction rollback than account suspension:

1. **Revoke at source.** Suspend the compromised agent's credentials.
2. **Trace the delegation chain forward.** Identify every agent and system that received instructions from the compromised agent before revocation.
3. **Notify downstream agents.** Flag outputs from the compromised agent as suspect; downstream agents need to know they may have acted on corrupted instructions.
4. **Assess rollback.** Determine what was persisted (databases, shared memory, external APIs) and whether it requires unwinding.
5. **Rotate derived credentials.** Any credential the compromised agent issued or caused to be issued must be treated as potentially contaminated.

The FINOS AIR-PREV-023 (Agentic System Credential Protection Framework) specifies automated revocation with cascade rotation for derived credentials as a required response capability.

## The registry gap

In systems with [[delegation-chain]] registries, cascade revocation is mechanical: find everything the agent instructed, flag the chain. In systems without registries, downstream notification requires manual log tracing — slow and error-prone at the scale of autonomous agents operating across dozens of tools and APIs simultaneously.

This is the capability most multi-agent deployments lack. The frameworks ([[agent-incident-response]]) identify the problem; production tooling for cascade revocation does not yet exist at I4 maturity.

## The architectural defense

The best containment is architectural. Agents operating with [[ghost-token|ephemeral credentials]] (scoped to specific tasks, short-lived) have a narrow window of exploitability. By the time an incident is detected, many credentials have already expired. Organizations running agents with long-lived service account tokens face a harder containment problem.

## Connects to

- [[agent-incident-response]] — coordinated revocation is one of three structural differences from traditional IR
- [[delegation-chain]] — revocation must trace the chain, not just the source
- [[delegation-chain-forensics]] — the audit infrastructure that makes cascade tracing possible
- [[ghost-token]] — ephemeral credentials reduce revocation scope by design
- [[cascading-failure]] — downstream propagation before revocation is detected
- [[shadow-agents]] — agents without registered delegation chains cannot be reached for revocation
