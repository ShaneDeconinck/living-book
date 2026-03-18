---
title: Transaction Tokens for Agents
tags: [protocol, authorization, oauth, delegation, identity, security]
dimension: standards
---

Transaction Tokens for Agents (Txn-Tokens) propagate agent identity and delegation context through backend service chains without forwarding the original access token — solving both credential exposure and delegation chain splicing.

## The Problem

[[obo-token-exchange]] tracks who delegated. [[agent-authorization-profile]] encodes what constraints apply. But neither solves a practical problem in distributed architectures: when Agent A calls Service A which calls Service B which calls Service C, how does delegation context travel through the entire chain without the access token being forwarded at every hop?

Forwarding access tokens through a call chain exposes the token at every service boundary. Lose it at any hop, and the attacker has full authorization power.

A second, subtler problem: delegation chain splicing. When agents chain multiple RFC 8693 exchanges (User → Agent A → Agent B → service), each exchange is an independent HTTP transaction. Without cryptographic binding between hops, an attacker at an exchange point can substitute a different `actor_token`, redirecting the chain to act under a different principal's authority. Each individual exchange looks valid; the fraud is in the substitution between exchanges.

## How Txn-Tokens Work

Transaction Tokens for Agents (draft-oauth-transaction-tokens-for-agents, January 2026, version 03) extends the OAuth Transaction Tokens framework with two new claims:

- **`actor`**: the agent performing the action
- **`principal`**: the human or system that initiated the agent's action

When Agent A calls Service A, Service A exchanges the agent's access token for a Txn-Token at a dedicated Txn-Token Service. The Txn-Token is a short-lived, signed JWT carrying immutable actor and principal context. Service A passes the Txn-Token (not the access token) to Service B, which passes it to Service C.

**The immutability guarantee**: if the Txn-Token needs replacement (scope changes at a boundary), the Txn-Token Service issues a new one, but actor and principal claims cannot change. The chain cannot be spliced because the Txn-Token Service will not issue a replacement token that contradicts established provenance.

## Two Effects

**Credential containment.** The access token never travels beyond the first service. Every downstream service holds only a verifiable identity assertion — no authorization power, just identity. A compromised service cannot extract and reuse the original credentials.

**End-to-end auditability.** Every service in the chain logs actor and principal from the Txn-Token, producing a complete trace of which agent acted on behalf of which principal at each service boundary. No inference, no reconstruction — the trace is in every log.

## Companion: A2A Profile

A companion draft (draft-liu-oauth-a2a-profile) applies this pattern specifically to agent-to-agent scenarios where agents propagate delegation context across A2A protocol interactions.

## The Composition

OBO establishes the delegation. AAP encodes the constraints. Transaction Tokens ensure delegation context flows through the entire execution chain without credential leakage or identity loss.

| Layer | Standard | What it does |
|---|---|---|
| Who delegated | OBO (RFC 8693) | Delegation chain from user to agent |
| What constraints | AAP (draft-aap) | Scoped capabilities and oversight requirements |
| How identity propagates | Txn-Tokens | Immutable actor/principal across backend hops |

## Connects to

- [[obo-token-exchange]] — Txn-Tokens carry OBO delegation context through backend chains
- [[agent-authorization-profile]] — AAP defines the constraints; Txn-Tokens ensure they propagate
- [[delegation-chain]] — Txn-Tokens are the runtime enforcement of delegation chain integrity
- [[confused-deputy]] — delegation chain splicing is a confused deputy variant; Txn-Tokens close it structurally
- [[tamper-evident-logging]] — Txn-Token actor/principal claims in every log entry are a form of tamper-evident delegation record

## Sources

- IETF, draft-oauth-transaction-tokens-for-agents-03, January 2026
- IETF, draft-liu-oauth-a2a-profile (A2A Profile for OAuth Transaction Tokens)
- src/chapters/agent-identity.md §Transaction Tokens for Agents
