---
title: Platform Governance and the Interoperability Bet
tags: [governance, platforms, interoperability, accountability, microsoft]
dimension: governance-thresholds
---

The choice organizations face when deploying agent governance infrastructure: platform-native governance (fast to deploy, bounded by ecosystem) versus open-standard governance (cross-platform, slower to reach production maturity). The resolution is composition, not competition — both layers serve different needs.

## The Platform-Native Layer

Microsoft's Agent 365 and Entra Agent ID Governance (preview, March 2026) represent what platform-native agent governance looks like at production maturity. The primitives are real:

- **Agent identities as first-class principals**: same identity infrastructure as human employees and service accounts, but structured for agent lifecycle patterns
- **Human sponsor model**: each agent has an accountable person responsible for reviewing permissions, attesting to access, triggering decommissioning
- **Lifecycle Workflows**: sponsor updates, access reviews, deactivation on policy rather than manual process
- **Access Packages**: time-bound, auditable permission assignments that expire without renewal
- **Agent Registry**: inventory including third-party agents registered via API; agent risk signals aggregated across the security stack

The platform governance argument is deployment velocity: organizations that have been debating governance architecture can configure Agent 365 in weeks against an existing Entra tenant. Primitives familiar to enterprise identity teams. Procurement already done.

## The Boundary Problem

Platform governance deploys. Its limit is architectural, not incidental.

Agents that cross platform boundaries — which describes most agents doing meaningful work — encounter the interoperability gap: the Entra identity is real inside Azure. Outside Azure (Salesforce, AWS, third-party APIs, Jira), it is not verifiable. Each external integration falls back to API keys, static credentials, or the platform's own identity model.

An agent with an Entra identity operating in AWS is a shadow agent from AWS's perspective. Single-platform governance solves the [[shadow-agents]] discovery gap within its ecosystem but not across organizational and platform boundaries.

## Sector-Specific Fragmentation

Platform governance is also fragmenting by vertical before cross-industry standards converge.

Imprivata's Agentic Identity Management (HIMSS 2026, March 10, 2026): the first healthcare-specific agent identity product. Architecture mirrors PAC arguments — agents as managed identities, short-lived scoped tokens, agent registry, unmanaged agent discovery — but shaped specifically for HIPAA attribution requirements: every access to protected health information must trace to a responsible party.

Imprivata will not be the last sector-specific product. Financial services (MiFID II, SOX), legal (privilege considerations), defense contractors (CMMC) will each produce products calibrated to their compliance surface. If agent identity fragments by vertical before converging on cross-industry standards, interoperability becomes harder. If it converges too early, sector-specific requirements may be underserved.

## The Interoperability Bet

The "composition, not competition" resolution frames the strategic question precisely.

Platform governance addresses **I2→I3** on the governance maturity scale: it moves organizations from "no mandate structure, agents logged post-hoc" to "agent identity confirmed, scoped authorization declared." This is real progress.

Open-standard governance (ID-JAG, MCP-I at DIF, IETF-backed approaches) addresses **I3→I4**: cross-platform authorization where the governance perimeter extends to every surface the agent touches, not just those within one vendor's ecosystem.

An organization that bets only on platform governance is taking a position that most of its consequential agents will stay inside one ecosystem. An organization that bets only on open standards is taking a position that deployment velocity doesn't matter. The composition answer: deploy platform governance for immediate coverage, invest in standards compatibility to avoid lock-in as cross-platform requirements emerge.

The open question from March 2026: does platformization help or hurt the open-standards trajectory? CyberArk (SPIFFE-based, open standard) is now under Palo Alto Network's platform incentives. If agent identity becomes a proprietary capability embedded in security platforms, the IETF drafts and DIF work may become specifications without implementations. Keycloak's ID-JAG implementation pushes against this: open-source implementations make standards durable regardless of platform vendor behavior.

## The Maturity Scale

| Level | What exists | Governance posture |
|---|---|---|
| **I2** | Actions logged after the fact | Audit possible; no constraint enforcement at provisioning time |
| **I3** | Agent identity confirmed, scoped OAuth tokens | Authorization scope declared; platform-native lifecycle management |
| **I4** | Open-standard identity with cross-platform delegation chains | Authorization enforced at every boundary the agent touches |
| **I5** | Full lifecycle management with automated dispute resolution, revocation | Intent-to-action chain cryptographically verifiable end-to-end |

Most agentic deployments today read as I2. Platform governance moves organizations to I3 within one ecosystem. The move from I3 to I4 requires the open-standards track.

## Connects to

- [[shadow-agents]] — platform governance solves discovery within its ecosystem; cross-platform shadow agents remain
- [[agent-registry]] — Agent 365's registry is the platform-native implementation of the governance primitive
- [[ietf-agent-authorization-consolidation]] — the open-standards track competing with platform-native approaches
- [[mcp-i]] — DIF-governed identity standard for MCP-connected agents; platform-agnostic alternative to Entra
- [[non-human-identity]] — agents as first-class principals, not service accounts
- [[trust-inversion]] — platform governance implements the human-sponsor model, a structural accountability mechanism
- [[inferential-edge]] — organizations that invest in governance infrastructure that appreciates as capability grows; platform governance is a faster path to that investment

## Sources

- Microsoft, "Secure agentic AI for your Frontier Transformation," March 9, 2026. E7 at $99/user/month includes Agent 365, Copilot, Entra/Defender/Purview.
- Microsoft, "Governing Agent Identities (Preview)," Entra ID Governance, learn.microsoft.com, March 2026.
- Entro Security, "Microsoft Agent 365 Boosts AI Identity, Yet Governance Gaps Remain," March 2026. "Agent 365 gives each agent an Entra identity, but agents span Azure, AWS, GCP, SaaS, CI/CD, and internal frameworks. Single-platform governance creates silos."
- Imprivata, "Imprivata Introduces Agentic Identity Management," HIMSS 2026, March 10, 2026.
- Draft: src/drafts/platform-governance.md
