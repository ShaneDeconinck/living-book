---
title: Trust Spanning Protocol (TSP)
tags: [protocol, identity, decentralized, cross-org, agents]
---

The Trust Spanning Protocol (TSP), developed under Linux Foundation Decentralized Trust, is the thin-waist layer for agent trust: it connects many things above (apps, agents, wallets) to many things below (identifier types, key systems), the same way IP connects networks.

## The Problem It Solves

OAuth handles authorization within systems where the authorization server has authority. But agents operate across organizational boundaries, where no single authorization server governs all parties. When your agent calls my API, who handles trust establishment if we share no identity provider?

This is the stranger-to-stranger case: two agents from different organizations that need to verify each other without any prior relationship or shared authority. Pre-registration with the authorization server is not possible. Pre-shared secrets are not appropriate.

TSP handles it.

## How TSP Works

When an agent connects to a service or agent it has never seen:

1. Both sides resolve each other's [[verifiable-credentials|DIDs]] to get public keys
2. They check relevant trust registries
3. An encrypted, authenticated channel is established
4. The application protocol (MCP, A2A, or whatever) operates on top

TSP is not a competitor to OAuth. OAuth assumes you pre-registered. TSP handles the trust establishment that precedes OAuth — or replaces it when a shared authorization server does not exist.

## Relationship to DIDs

TSP operates on DID infrastructure: each party has a DID that resolves to a DID Document containing public keys and service endpoints. TSP is the protocol for the handshake; DIDs are the identifiers. Neither is meaningful without the other.

This book implements TSP in its own pipeline: agent-to-agent messages between Ghosty, Sapere Aude, and Chop Pop are TSP-signed, with each agent holding a `did:webvh` DID with real Ed25519 signing keys. The architecture demonstrates that TSP works at small scale without enterprise tooling.

## Reach

TSP's thin-waist design lets it work across:
- Different DID methods (did:web, did:webvh, did:key, etc.)
- Different key types
- Different application protocols (MCP, A2A, REST)
- Cross-organizational and cross-jurisdictional contexts

The spec reached Revision 2 in November 2025; development continues.

## TSP + PIC

TSP handles identity verification across boundaries. But identity verification alone does not constrain what happens after authentication. An agent that proves who it is can still accumulate authority beyond what was delegated. PIC (Provenance, Identity, Continuity — covered in [[delegation-chain]]) complements TSP by enforcing authority continuity after the channel is established: the trust plane validates at each execution step that authority is only restricted or maintained, never expanded.

TSP and PIC together compose into a full stack for cross-boundary agent governance: TSP establishes who you are talking to; PIC ensures what authority they carry cannot be inflated.

## Infrastructure Maturity

TSP becomes relevant at I3 (Verified) and above, where agents operate across organizational boundaries and a shared authorization server is not available. It is foundational infrastructure for I4 (Authorized) deployments involving external agents or third-party services.

## TMCP and TA2A

TSP composes with existing communication protocols as a transport layer:
- **TMCP** (Trust-enabled MCP): replace MCP's transport with TSP, add verifiable identifiers and a wallet. Same JSON-RPC calls, but every interaction is authenticated, signed, and traceable. Addresses MCP's three trust gaps: server identity, capability proof, and delegation chains.
- **TA2A** (Trust-enabled A2A): A2A over TSP gives Agent Cards cryptographic verification, task messages authentication and privacy, and cross-organizational agent discovery with verifiable identity guarantees.

Both were presented by Wenjing Chu at the LFDT meetup as near-term deliverables. Designed for incremental adoption: start with standard MCP/A2A and layer TSP when cross-organizational trust is needed.

## Connects to

- [[verifiable-credentials]] — TSP operates on DID/VC infrastructure for identity resolution
- [[delegation-chain]] — TSP establishes the channel; delegation chains carry authority through it
- [[non-human-identity]] — TSP's stranger-to-stranger design handles the NHI case that pre-registration cannot
- [[obo-token-exchange]] — OBO operates within a known authorization server; TSP handles the case where no shared server exists
- [[cross-domain-delegation-model]] — TSP provides the channel; Windley's model describes the institutional protocol above it
- [[eudi-wallet-agents]] — TSP designed to interoperate with EUDI Wallets
- [[verifiable-content-provenance]] — TSP handles agent-to-agent trust; content provenance handles agent-to-content trust using the same DID infrastructure
- [[mcp]] — TMCP adds trust properties to MCP's communication layer
- [[a2a]] — TA2A adds trust properties to A2A's agent discovery layer
- [[webmcp]] — browser-side tool discovery; needs trust layer integration when crossing origins

## Appears in

- **Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity** (`posts/lfdt-meetup-trust-ecosystems-authority-continuity`, 2026-03-11) — Wenjing Chu's full TSP presentation; TMCP = MCP + TSP as the foundation layer
- **Trusted AI Agents: Why Traditional IAM Breaks Down** (`posts/trust-for-agentic-ai`, 2026-01-24) — TSP enables strangers to verify each other without a shared identity provider
- **Auth for Agent Builders: A Crash Course** (`posts/history-of-auth-dealing-with-legacy`, 2026-01-26) — TSP in the auth evolution; the decentralized track
- **Verifiable Intent: Mastercard and Google Open-Source Agent Authorization** (`posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved`, 2026-03-06) — TSP fills the agent discovery gap VI leaves open
- Explainer: **Understanding TSP** (`explainers/tsp`) — dedicated explainer

## Sources

- Linux Foundation Decentralized Trust, Trust Spanning Protocol specification, Revision 2, November 2025
- Shane Deconinck, "Understanding TSP: The Trust Spanning Protocol Explained," shanedeconinck.be
- src/chapters/agent-identity.md §Trust Spanning Protocol
- src/chapters/cross-org-trust.md (full TSP coverage in cross-organizational context)
