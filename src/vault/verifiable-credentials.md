---
title: Verifiable Credentials (VCs) and Decentralized Identifiers (DIDs)
tags: [identity, protocol, w3c, cross-org-trust, delegation]
---

Two W3C standards that together enable cryptographic identity and claims without a central authority. DIDs provide the identity layer; VCs carry the attestations. Where OAuth requires a shared authorization server, DIDs and VCs work across organizational boundaries with no pre-registration.

## Decentralized Identifiers (DIDs)

A DID is a URI (`did:method:identifier`) that resolves to a DID Document containing public keys and service endpoints. The holder proves control by signing with the corresponding private key. No registration with a central server. No authority that can revoke your identifier by deleting an account.

Different DID methods represent different trust models:
- `did:web`: anchored in DNS — portable but inherits DNS trust assumptions
- `did:webvh`: web-anchored with verifiable history — tamper-evident update log
- `did:key`: ephemeral, no registry — useful for short-lived agent sessions

Shane uses `did:webvh` for his blog posts, signing content with Ed25519 signatures so agents consuming his writing can verify provenance without calling back to any authority.

## Verifiable Credentials (VCs)

A VC is a signed claim: "Entity X has property Y, attested by Issuer Z." The holder presents it to any verifier, who validates the issuer's signature against the issuer's public key. No callback to the issuer required at verification time. The credential can contain standard attributes (name, role) or agent-specific claims (delegation scope, operational constraints, organizational affiliation).

For agents, VCs enable:

**Agent identity**: an agent gets its own DID, separate from its developer and deploying organization. Each entity in the chain can have VCs attesting to their properties and relationships.

**Cross-organizational delegation**: when your agent calls my API, your agent presents a VC stating "I was deployed by Organization X with capabilities Y and Z." My API verifies against the issuer's public key — no shared identity provider needed.

**Presence as signal**: the absence of a verifiable credential is itself information. An unsigned API response or an unverifiable agent identity should trigger caution by default, not silent acceptance.

## MCP-I: DID/VC applied to MCP

MCP-I (Model Context Protocol — Identity), donated to the Decentralized Identity Foundation by Vouched in March 2026 and now developed under the DIF Trusted AI Agents Working Group, extends MCP with DID/VC-based identity. Three dimensions required at every MCP service interaction:

1. The agent's own DID-based identity
2. The human principal's identity (VC linking the request to the human)
3. The delegation credential (VC specifying authorization scope)

MCP-I defines three conformance tiers: Level 1 (OIDC/JWT, immediate adoption), Level 2 (full DID verification and credential-based delegation with revocation), Level 3 (enterprise lifecycle management and immutable auditing).

## Relationship to OAuth

OAuth and VCs address different trust contexts:

- OAuth: works within a system where parties pre-register with a shared authorization server
- VCs: work across organizational boundaries where no shared authority exists

They can compose: an OAuth token can carry embedded VC claims; a VC can authorize the issuance of an OAuth token. The Trust Spanning Protocol (TSP) handles the stranger-to-stranger case — two agents from different organizations establishing a trusted channel — using DIDs as the identity layer before any OAuth flow begins.

## Connects to

- [[delegation-chain]] — VCs implement portable, cross-org delegation chains
- [[obo-token-exchange]] — OBO handles intra-org delegation; VCs handle inter-org delegation
- [[trust-inversion]] — VCs remove the need to trust the agent's self-assertion; the issuer's signature is the trust anchor
- [[accountability-pillar]] — verifiable credentials make attribution auditable across org boundaries
- [[non-human-identity]] — VCs are the primary credential format for non-human identity in cross-boundary deployments

## Sources

- W3C Verifiable Credentials Data Model 2.0
- W3C Decentralized Identifiers (DIDs) 1.0
- DIF/Vouched: "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation, March 2026
- [Deconinck 2026]: Shane Deconinck, "Trusted AI Agents — Agent Identity and Delegation," shanedeconinck.be
- src/chapters/agent-identity.md §Beyond OAuth: Verifiable Identity
- src/chapters/cross-org-trust.md
