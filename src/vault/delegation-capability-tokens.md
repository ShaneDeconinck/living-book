---
title: Delegation Capability Tokens (DCTs)
tags: [authorization, multi-agent, cryptography, delegation]
dimension: delegation-chains
---

Bearer credentials built on macaroons that encode authority attenuation for multi-hop agent delegation chains: anyone holding a DCT can add restrictions but cannot remove them or expand scope.

## Why macaroons

Macaroons [Birgisson 2014] have a distinctive property: adding caveats (restrictions) requires no interaction with the issuer, but removing caveats or expanding authority is cryptographically impossible. This maps exactly to agent delegation, where authority must only decrease — never increase — at each hop. The structure makes privilege escalation through delegation mathematically impossible, not just policy-prohibited.

## How a DCT encodes a delegation chain

A root DCT carries the full authorized scope. Each delegation hop adds caveats narrowing the scope further:

- Budget: $5,000 root → $2,000 at hop 1
- Actions: `["book_travel", "search_flights"]` → `["search_flights"]`
- Additional constraints: carrier restrictions, delegation depth limit

The resulting token at each hop is self-verifying: any party in the chain can confirm the caveats without contacting the original issuer. This offline verification is critical for multi-agent systems where round-trips to an authentication server at every hop would be prohibitively slow.

## Relationship to other mechanisms

DCTs encode **what authority an agent has**. [[delegation-chain#Delegation chain splicing|PIC (Provenance, Identity, Continuity)]] verifies **that the chain producing that authority is unbroken**. In practice, both are needed: DCTs for scope enforcement, PIC for structural integrity.

For single-hop delegation, OAuth OBO, DPoP, and Verifiable Credentials address the same problem. DCTs become necessary when delegation depth exceeds one and offline verification matters.

## Limitation

Macaroon-based DCTs assume a tree delegation structure. Real multi-agent systems form graphs: Agent A delegates to Agent B, which calls back to Agent A with different authority. Cycles break the clean hierarchy. DCTs are a starting point, not the destination for graph-structured orchestration.

## Connects to

- [[delegation-chain]] — DCTs are the cryptographic implementation of authority attenuation in delegation chains
- [[trust-inversion]] — DCTs make "can't expand authority" structural rather than advisory
- [[confused-deputy]] — DCTs address the fourth dimension: chaining authority amplification
- [[cascading-failure]] — authority attenuation limits the scope of what a compromised agent can delegate further

## Sources

- [Birgisson 2014]: Arnar Birgisson et al., "Macaroons: Cookies with Contextual Caveats for Decentralized Authorization in the Cloud," Google Research, NDSS 2014
- [Deconinck PAC 2026]: Shane Deconinck, "The PAC Framework," trustedagentic.ai. Control pillar: "When agents delegate, does authority only decrease, never expand?"
- Chapter: [Multi-Agent Trust and Orchestration](../chapters/multi-agent-trust.md#delegation-capability-tokens)
