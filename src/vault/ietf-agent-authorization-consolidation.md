---
title: IETF Agent Authorization Consolidation
tags: [standards, authorization, oauth, agents, ietf]
dimension: standards
---

The process by which four competing IETF proposals for agent authorization are converging toward a single standard within the OAuth Working Group.

## The Four Proposals (as of March 2026)

Four competing drafts appeared in the IETF OAuth WG within a three-week span:

- **draft-klrc-aiagent-auth-00** (Kasselman et al., March 2, 2026): a general AI agent authentication and authorization framework. Authors from Defakto, AWS, Zscaler, Ping Identity. Introduces the Agent Identity Management System (AIMS) conceptual model consolidating how SPIFFE, WIMSE, OAuth, and OpenID SSF apply to agents.
- **draft-barney-caam-00** (Jonathan Barney, February 24, 2026): Contextual Agent Authorization Mesh. Token isolation: raw delegation tokens held in authorization sidecar, synthesized into short-lived request-scoped credentials at action time. This is the [[ghost-token]] pattern.
- **AgentID** (Warren Parad et al., March 15, 2026): an explicit identity layer for autonomous AI agents within OAuth — about *who* the agent is, not only what it can do.
- **A2A OAuth Transaction Token Profile** (March 16, 2026): OAuth profile specialized for the A2A communication protocol, raising the per-protocol proliferation question.

Each addresses a different failure mode. The "Overlap of AI related proposals" thread (March 16, 2026) forced the question: consolidate or fragment.

## The Side Meeting Signal

On March 18, 2026, a formal side meeting on AI agent security was announced within the OAuth WG ("AI Agent Security Side Meeting Friendly Reminder," Liuchunchi/Peter). Multiple WG participants (Vladimir Dzhuvinov of Connect2id, Ayesha Dissanayaka, others) engaged in the preceding consolidation thread.

The IETF standards lifecycle moves: mailing list discussion, then side meeting, then working group item, then Internet Draft, then RFC. A side meeting is qualitatively different from a thread. It requires logistics: a room, an agenda, committed attendees. It is the step where a mailing list debate becomes an organized coordination event.

## The First Winner: ID-JAG

Before the four proposals above appeared, one draft was already on a different trajectory. **draft-ietf-oauth-identity-assertion-authz-grant-02** (ID-JAG) was formally adopted by the IETF OAuth Working Group in September 2025 — now a WG document with institutional momentum, not an individual submission.

ID-JAG builds on JWT assertions and interoperates with existing OAuth infrastructure. No new token formats or authorization servers required. Keycloak v26.5 implemented it in early 2026 — the first widely-deployed production implementation. Production deployments exist.

WG adoption does not mean best technical approach. It means most compatible with the WG's existing work, strongest co-author coalition (Aaron Parecki, Karl McGuinness, Brian Campbell), and reached adoption threshold first.

## The DIF Track

In parallel, DIF Executive Director Grace Rachmany (Newsletter #59, March 2026): "Agentic AI has an even stronger use case for decentralized AI than human identification." Her reasoning: agents are ephemeral; centralized identity databases assume persistent entities. DIDs assign identity at creation time without central registration — exactly the property ephemeral agents need.

The OAuth track (ID-JAG, CAAM, AgentID) and the DID track ([[dids]]) are not mutually exclusive. They address different levels of the stack. [[agent-ephemerality]] is the structural reason the DID argument may eventually prevail at scale.

## Why This Matters for the Book

The side meeting (announced March 18) is the consolidation inflection point. If it produces a summary document identifying overlap and proposed resolution, that document is more valuable than any individual draft. If it doesn't, fragmentation compounds at the installed-base layer — each draft gains production deployments before harmonization, creating path dependence.

CAAM (requires new sidecar infrastructure) and ID-JAG (extends existing OAuth incrementally) have the sharpest trade-off for practitioners who cannot wait.

## Connects to

- [[ghost-token]] — CAAM's core architectural pattern; holds regardless of which standard wins
- [[gnap]]: the alternative-to-OAuth track running in parallel
- [[obo-token-exchange]]: the existing OAuth delegation mechanism these proposals extend
- [[delegation-chain]]: what all proposals are trying to make auditable
- [[agent-ephemerality]]: the DIF executive argument for why decentralized identity may outflank OAuth entirely
- [[dids]]: the decentralized identity infrastructure the DIF track relies on

## Sources

- IETF OAuth WG mailing list, "Overlap of AI related proposals" thread, March 16, 2026 (Dick Hardt, Bjorn Hjelm, Alex Babeanu among participants)
- IETF OAuth WG, "AI Agent Security Side Meeting Friendly Reminder," March 18, 2026
- DIF Newsletter #59, Grace Rachmany (Executive Director), March 2026
- draft-ietf-oauth-identity-assertion-authz-grant-02, adopted by IETF OAuth WG, September 2025
- src/drafts/authorization-standards-race.md — full practitioner treatment with "What to Do Now" guidance
- src/drafts/gaps-new-observations-2026-03-18.md — extended treatment with four proposals' distinct philosophies
