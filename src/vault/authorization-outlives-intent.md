---
title: Authorization Outlives Intent
tags: [lifecycle, authorization, governance, temporal]
dimension: delegation-chains
---

The structural failure where credentials remain valid after the purpose that justified them has ended. The credential was issued for a task. The task is done. The employee is gone. The integration has changed. The credential has not.

Named by Okta's 2026 analysis of AI agent authorization failures. The framing shifts responsibility: the problem is not that attackers steal credentials. It is that valid credentials accumulate indefinitely and governance systems built for humans never reclaimed them.

## Why it happens

Agents are easy to provision, hard to decommission. Three forces sustain lingering credentials:

1. **No lifecycle event triggers revocation.** Human identities get deprovisioned when people leave. Agent credentials are not tied to the same offboarding process.
2. **Nobody owns the cleanup.** The developer who provisioned the agent moved on. No one inherited the responsibility.
3. **Nobody knows the dependencies.** Revoking the credential might break something. The safe default is inaction.

The result: CyberArk found 42% of machine identities have privileged or sensitive access. Organizations granting excessive permissions experience 4.5x more security incidents (Teleport 2026).

## Okta's four governance principles

Four design requirements for lifecycle-aware authorization that does not outlive intent:

1. **Durable delegated identity.** Every agent has its own identity, separate from users, governed and auditable. Not "authenticated as the developer," but "authenticated as this specific agent."
2. **Continuously renewable authorization.** Access adjusts as the task, user, or environment changes. Not issued once; continuously re-evaluated.
3. **Instant cross-system de-provisioning.** Revoking access in one place shuts it down everywhere. A credential that only revokes in the primary system but persists in a downstream cache outlives its intent.
4. **Real-time authorization validation.** Actions are re-checked against current policies at execution time, not at issuance time.

Principles 2 and 4 together solve the point-in-time authorization failure: the agent cannot operate on a stale grant if the infrastructure re-evaluates at every action.

## Structural vs. behavioral fix

Telling agents to "only do what they were asked" does not address authorization outliving intent. The agent is behaving correctly. The credential is the problem. The fix is infrastructure: short-lived credentials that expire, automated renewal tied to active use, decommissioning triggers that fire automatically.

SPIFFE/SPIRE addresses this at the workload layer: credentials are issued for hours, not months. Renewal is automatic. Expiry is structural. An inactive agent's credentials expire without anyone needing to remember to revoke them.

## Connects to

- [[scope-drift]] — scope drift is one way authorization expands beyond intent at runtime; this pattern is about temporal persistence after task completion
- [[orphan-agent]] — orphan agents are the extreme case: authorization outlives intent and outlives ownership
- [[agent-provisioning]] — preventing this starts at provisioning: document the agent's purpose and set credential lifetimes from day one
- [[spiffe-svid-wimse]] — SPIFFE's short-lived SVIDs are the infrastructure-layer answer to long-lived credentials
- [[coordinated-revocation]] — when an agent is compromised, revocation must propagate cross-system instantly
- [[reliability]] — stale credentials degrade reliability silently: the agent may behave correctly but act on permissions that no longer reflect current policy; reliability metrics that only track task success miss this failure mode
- [[autonomy-levels]] — higher autonomy levels require tighter credential lifecycles; an A4 agent operating on month-old permissions has structural governance debt that grows with every autonomous decision cycle

## Sources

- Okta, "AI Security: When Authorization Outlives Intent," 2026
- CyberArk, "Machine Identities Outnumber Humans by More Than 80 to 1," 2025
- Teleport, "2026 State of AI in Enterprise Infrastructure Security," 2026
- src/chapters/agent-lifecycle-management.md §Life: Runtime Governance, §Death: Decommissioning
