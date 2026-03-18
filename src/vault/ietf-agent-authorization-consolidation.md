---
title: IETF Agent Authorization Consolidation
tags: [standards, authorization, oauth, agents, ietf]
dimension: standards
---

The process by which four competing IETF proposals for agent authorization are converging toward a single standard within the OAuth Working Group.

## The Four Proposals

As of early 2026, the IETF OAuth WG has at least four active proposals addressing agent authorization:

- [[agent-authorization-profile]] (AAP): enriches OAuth tokens with structured capabilities and operational constraints
- The decoupled authorization model (draft-chen): separates authorization decisions from business logic
- ID-JAG and related identity-layer proposals
- Additional drafts addressing agent delegation patterns

Each addresses a different layer of the same problem. The "Overlap of AI related proposals" thread on the OAuth WG mailing list (March 2026) forced the question: consolidate or fragment.

## The Side Meeting Signal

On March 18, 2026, a formal side meeting on AI agent security was announced within the OAuth WG ("AI Agent Security Side Meeting Friendly Reminder," Liuchunchi/Peter). Multiple WG participants (Vladimir Dzhuvinov of Connect2id, Ayesha Dissanayaka, others) engaged in the preceding consolidation thread.

The IETF standards lifecycle moves: mailing list discussion, then side meeting, then working group item, then Internet Draft, then RFC. A side meeting is qualitatively different from a thread. It requires logistics: a room, an agenda, committed attendees. It is the step where a mailing list debate becomes an organized coordination event.

## Why This Matters for the Book

If the side meeting produces a consensus document or a liaison between proposals, the book's agent identity chapter needs to name which proposal survived. If it does not, the fragmentation itself becomes the story: the standards body could not pick one, so the market will.

Either outcome changes what practitioners should bet on.

## Connects to

- [[agent-authorization-profile]] (AAP): one of the four competing proposals
- [[gnap]]: the alternative-to-OAuth track running in parallel
- [[obo-token-exchange]]: the existing OAuth delegation mechanism these proposals extend
- [[delegation-chain]]: what all proposals are trying to make auditable
- [[agent-ephemerality]]: the DIF executive argument for why decentralized identity may outflank OAuth entirely

## Sources

- IETF OAuth WG mailing list, "Overlap of AI related proposals" thread, March 2026
- IETF OAuth WG, "AI Agent Security Side Meeting Friendly Reminder," March 18, 2026
- src/drafts/scout-2026-03-17.md, src/drafts/scout-2026-03-18.md
- src/drafts/gaps-new-observations-2026-03-18.md — extended treatment with four proposals' distinct philosophies and consolidation stakes
