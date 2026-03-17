---
title: Non-Human Identity (NHI)
tags: [identity, credentials, security, agents]
---

Service accounts, API keys, agent credentials, and similar identities that act on behalf of systems rather than humans. The fastest-growing attack surface in enterprise security.

## Why NHIs are the problem

NHIs typically suffer from four compounding deficiencies:

1. **Long-lived credentials.** Never rotated. Active months or years after the use case expired.
2. **Over-privileged.** Scoped to the system's broadest needs, not any specific task.
3. **Unowned.** No person responsible for their lifecycle. The engineer who created them may have left.
4. **No runtime constraints.** No behavioral guardrails on what the credential can do once issued.

These are not new problems. OAuth abuse more than doubled year-over-year in Huntress's 2026 incident data. Campaigns like GTG-1002 exploited valid NHIs to produce high-impact breaches. The issue was not proving identity — it was constraining what the identity was allowed to do. [Huntress 2026]

## Agents amplify the problem

Agents inherit NHI problems and multiply them:
- A compromised agent acting as a [[confused-deputy]] operates at machine speed and scale
- Agents create new NHIs implicitly when connecting to tools and services
- [[shadow-agents]] use the employee's full credentials — the most privileged NHI in the environment by definition

## Structural response

[[trust-inversion]]: agents need allowlists, not blocklists. Credentials scoped to the task, not the system.

The [[delegation-chain]] model: authority that can only decrease at each hop means a compromised downstream agent cannot exceed the permissions explicitly granted for that task.

NIST February 2026 concept paper on AI agent identity and authorization addresses NHI lifecycle management specifically. [NIST 2026]

## Appears in

- **Auth for Agent Builders: A Crash Course** (`posts/history-of-auth-dealing-with-legacy`, 2026-01-26) — NHI in the auth evolution; service accounts as the legacy problem agents inherit
- **ERC-8004 Goes Mainnet** (`posts/erc-8004-mainnet`, 2026-01-28) — ERC-8004 as a public identity layer for NHIs crossing org boundaries
- **Trusted AI Agents by Design** (`posts/lfdt-meetup-trust-ecosystems-authority-continuity`, 2026-03-11) — agents need their own identifiers, not borrowed human credentials
- **Trusted AI Agents: Why Traditional IAM Breaks Down** (`posts/trust-for-agentic-ai`, 2026-01-24) — agents create intent and need to carry their own identity

## Sources

- [Huntress 2026]: "2026 Cyber Threat Report," huntress.com, February 2026
- [NIST 2026]: "Accelerating the Adoption of Software and AI Agent Identity and Authorization," NCCoE Concept Paper, February 2026
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#the-confused-deputy-revisited)
