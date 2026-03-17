---
title: Agent Provisioning
tags: [lifecycle, identity, governance, provisioning]
---

The set of requirements that must be satisfied before an agent is permitted to run. Three things need to happen at provisioning time: the agent gets an identity, an owner, and a scope. Any agent running without all three is ungoverned from its first action.

## The three provisioning requirements

**1. Identity**

A globally unique ID bound to the agent and its accountable owner, registered in a system of record. Without a registered identity, credential rotation is impossible (you do not know which credentials belong to the agent), audit is impossible (you cannot link actions to a specific agent), and decommissioning is impossible (you do not know the agent exists). This is the root of trust for every subsequent governance action.

The IETF draft-klrc-aiagent-auth (March 2026) consolidates the identity layer: mTLS with short-lived workload identities from [[spiffe-svid-wimse|SPIFFE or WIMSE]] as the primary authentication mechanism for agent-to-service communication. The draft does not invent new protocols — it maps existing standards to agent scenarios and identifies where gaps remain.

**2. Owner**

A named, accountable human being. Not a team. Not a department. A person.

Ownership is not permanent. It must transfer when the person changes roles, leaves the organization, or when the agent's purpose shifts. Saviynt's framework captures the accountable owner alongside the agent's model version, hosting environment, and declared purpose. Okta enforces ownership as part of identity creation, before any credentials are issued.

The operational consequence: owner departure triggers decommissioning review. If the owner is gone and no transfer has happened, the agent becomes an [[orphan-agent]].

**3. Scope**

Initial permissions that reflect only the declared purpose. Agents start from zero authority and receive explicit grants. Teleport found that 70% of organizations grant AI systems higher access than humans would receive for the same task — not from malice, but because existing IAM roles are sized for human job functions, not agent tasks. An agent that needs to read one database table gets a "data analyst" role with access to every table in the schema.

The structural fix: derive permissions from declared intent, not from the nearest pre-existing role. Token Security calls this intent-aware least-privilege.

## IETF standardization landscape

The IETF draft-klrc-aiagent-auth consolidation table maps existing standards to lifecycle phases:

| Phase | Standard |
|-------|----------|
| Identity | WIMSE/SPIFFE (workload), OAuth/OIDC (application) |
| Authentication | mTLS + short-lived workload identities |
| Authorization | OAuth RFC 8693 token exchange + [[agent-authorization-profile|AAP]] |
| Lifecycle | SCIM for cross-application provisioning and deprovisioning |

The draft identifies credential lifecycle management as the least mature area: identity issuance and authentication have clear standards, but credential rotation coordination across trust domains, automated decommissioning triggers, and orphan detection remain implementation-specific.

## The provisioning anti-pattern

Most current provisioning happens through existing IAM tools built for human identities. This produces three characteristic failures:
- Over-scoped permissions (human roles mapped to agent tasks)
- Undefined credential lifetimes (API keys set to "never expire")
- Undocumented purpose (agent description is the developer's first instinct, not a governance artifact)

All three failures are visible only retrospectively, when auditing an incident or decommissioning an orphan.

## Connects to

- [[orphan-agent]] — orphan agents are what happens when provisioning skips ownership or when ownership is never transferred
- [[authorization-outlives-intent]] — credentials without defined lifetimes are the source of this failure pattern
- [[scope-drift]] — under-specified purpose at provisioning makes drift invisible; there is no baseline to drift from
- [[spiffe-svid-wimse]] — the infrastructure layer that makes identity + short-lived credentials operational
- [[agent-authorization-profile]] — structured capability representation that makes scope machine-enforceable
- [[non-human-identity]] — NHI governance failures are what provisioning must prevent at the source

## Sources

- IETF, "AI Agent Authentication and Authorization," draft-klrc-aiagent-auth-00, March 2, 2026
- Saviynt, "Managing AI Agent Lifecycles: Birth to Retirement," 2026
- Okta, "AI Agent Lifecycle Management: Identity-first Security," 2026
- Teleport, "2026 State of AI in Enterprise Infrastructure Security," 2026
- Token Security, "AI Agent Identity Lifecycle Management," 2026
- src/chapters/agent-lifecycle-management.md §Birth: How Agents Get Provisioned
