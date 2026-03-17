---
title: Delegation Chain
tags: [accountability, authorization, identity, pac-framework]
---

The traceable record of authority flowing from a human principal through one or more agents to a final action, with mandatory attenuation at each hop. Core to the [[accountability-pillar]] of the [[pac-framework]].

## What it captures

A complete delegation chain records:

1. What authority was granted (scope, duration, constraints)
2. How the agent interpreted that authority (decisions made, tools called)
3. What the agent actually did (actions taken, resources accessed)
4. Whether authority decreased at each hop (no privilege escalation through delegation)

The fourth requirement is non-negotiable: authority can only decrease through a delegation chain, never increase. An agent cannot delegate more authority than it received.

## Delegation without traceability is abdication

Shane's framing: when a human delegates to an agent, the agent interprets and expands that intent. The gap between what was delegated and what was acted on is where accountability dissolves. Without traceability, delegation is abdication. [Deconinck 2026d]

## Protocol implementations

- **[[obo-token-exchange|OAuth On-Behalf-Of (RFC 8693)]]**: enables token exchange that explicitly tracks delegation with `actor` and `subject` claims. Provides the who-delegated-what layer.
- **Transaction Tokens for Agents**: extends OAuth Transaction Tokens with immutable `actor` and `principal` claims that propagate through service chains without forwarding the original access token. Closes the delegation chain splicing attack window.
- **CAAM (Contextual Agent Authorization Mesh)**: implements the [[ghost-token-pattern]] — raw tokens stay in a vault, ephemeral per-request credentials are issued. The agent never possesses the real delegation token.
- **[[verifiable-credentials|DIDs + Verifiable Credentials]]**: portable, cryptographic delegation chains that work across organizational boundaries without a shared authority.

## Delegation chain splicing

A structural attack on chained token exchanges: when agents chain multiple RFC 8693 exchanges (User → Agent A → Agent B → service), each exchange is an independent HTTP transaction. Without cryptographic binding between hops, an attacker can substitute a different `actor_token` at an exchange point, redirecting the chain to act under a different principal's authority. Each individual token exchange looks valid; the fraud is in the substitution between exchanges. Transaction Tokens address this by making actor and principal claims immutable across the chain.

## Authority attenuation

In multi-agent systems, each delegation hop must produce a child credential that cannot exceed the parent's scope. This is enforced by:
- OAuth mandatory privilege reduction in AAP (Agent Authorization Profile)
- ZCAP-LD object capability delegation (child capabilities cannot exceed parent)
- UCAN hierarchical JWT capabilities with automatic attenuation

See `src/chapters/multi-agent-trust.md` and `src/chapters/cryptographic-authorization.md`.

## Connects to

- [[accountability-pillar]] — delegation chain is the core infrastructure requirement for accountability
- [[decision-provenance]] — captures the delegation chain as a compliance artifact at action time
- [[delegation-capability-tokens]] — cryptographic implementation of authority attenuation for multi-hop chains
- [[infrastructure-levels]] — I4 infrastructure requires scoped authorization; without it, delegation is untracked
- [[shadow-agents]] — agents without delegation chains cannot be governed; accountability requires traceability
- [[trust-inversion]] — trust inversion requires that delegation chains only attenuate authority

## Sources

- [Deconinck 2026d]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," shanedeconinck.be, January 2026
- RFC 8693: OAuth 2.0 Token Exchange (on-behalf-of semantics)
- Transaction Tokens for Agents: draft-oauth-transaction-tokens-for-agents-03
