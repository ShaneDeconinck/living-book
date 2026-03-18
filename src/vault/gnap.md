---
title: GNAP (Grant Negotiation and Authorization Protocol)
tags: [protocol, authorization, oauth, agents, identity]
dimension: emerging-trust-infra
---

GNAP (RFC 9635) is a next-generation authorization protocol that replaces OAuth's pre-registration model with key-based identity, making it a better fit for dynamic, ephemeral agents than patched OAuth.

## The Problem It Solves

OAuth requires clients to pre-register with every authorization server. For agents that spin up dynamically, connect to services they have never seen, and may be ephemeral, pre-registration drives organizations toward the anti-patterns the [[non-human-identity]] gap makes dangerous: shared credentials, static API keys, and service accounts shared across agents. 44% of organizations still rely on these patterns (CSA/Strata survey, 2026).

GNAP removes the pre-registration requirement entirely.

## How It Works

A GNAP client presents a cryptographic key in its first interaction with the authorization server. That key becomes the client's identity for the duration of the grant. No client ID, no client secret, no out-of-band setup. The authorization server evaluates the request against policy based on the key, the requested access, and context.

Three design decisions matter for agents:

**Key-bound by default.** Every GNAP access token is bound to the client's key. There are no bearer tokens to steal. This is what [[dpop]] retrofits onto OAuth; GNAP builds it in. A stolen token without the corresponding key is useless.

**Interaction modes are separate from access requests.** A traditional OAuth flow bundles the authorization request with the user interaction. GNAP decouples them: the access request specifies what is needed; how the interaction happens (redirect, device code, out-of-band) is a separate negotiation. Agents that act without a user present don't need to work around a human-centric interaction model.

**Dynamic scope negotiation.** The authorization server can grant less than what was requested. The client can request modifications to an ongoing grant without restarting the flow. An agent can begin with narrow access, discover mid-task that it needs additional capabilities, and request them without re-authenticating the user. This matches how agents actually work: they discover what they need during execution.

## GNAP vs. OAuth Extensions

The [[obo-token-exchange]], [[agent-authorization-profile]], and [[dpop]] notes all describe OAuth being extended to handle agent patterns. GNAP's premise is different: these are patches on a protocol designed for human-initiated interactions. GNAP starts from agent-compatible assumptions.

In practice, both tracks are active. OAuth extensions have production deployments (Keycloak ID-JAG, Okta XAA). GNAP has early-stage implementations. The market will likely decide through adoption.

## TwigBush

TwigBush is an early-stage open-source GNAP authorization server written in Go, targeting AI agent delegation. It implements RFC 9635 and RFC 9767 (GNAP Resource Server Connections), providing key-bound tokens, real-time grant updates, and policy hooks for multi-cloud and agent-driven workloads. Early-stage, but signals practitioner interest in protocols designed for agents rather than patched for them.

## Open Problems

GNAP has no widespread production implementations. The OAuth ecosystem (libraries, developer tooling, tutorials, vendor support) has 17 years of momentum. Migration paths from OAuth to GNAP are undefined. Organizations adopting GNAP today are building on unstable toolchain foundations.

## Connects to

- [[obo-token-exchange]] — OAuth delegation; GNAP takes a different approach to the same problem
- [[dpop]] — DPoP retrofits key-binding onto OAuth; GNAP builds it in
- [[agent-authorization-profile]] — AAP enriches OAuth tokens; GNAP replaces the OAuth model
- [[non-human-identity]] — GNAP addresses the pre-registration gap that drives static credential anti-patterns
- [[delegation-chain]] — GNAP supports delegation with key-bound grants

- [[ietf-agent-authorization-consolidation]] — GNAP runs as the alternative-to-OAuth track while the OAuth WG consolidates its own agent proposals

## Sources

- IETF RFC 9635, "Grant Negotiation and Authorization Protocol (GNAP)," October 2024. Authors: Justin Richer, Fabien Imbault.
- IETF RFC 9767, "GNAP Resource Server Connections," 2025.
- TwigBush, github.com/TwigBush/TwigBush. Open-source Go implementation targeting AI agent delegation.
- src/chapters/agent-identity.md §GNAP: Authorization Without OAuth's Assumptions
