---
title: Verifiable Intent
tags: [protocol, authorization, identity, commerce, delegation]
dimension: delegation-chains
---

Verifiable Intent is a three-layer SD-JWT protocol that cryptographically proves what a user authorized an agent to do, not just who has access — solving the consent theater problem at the authorization layer.

## The Problem It Solves

OAuth proves who has access. [[obo-token-exchange]] proves who delegated. Neither proves what the user actually intended the agent to do. Shane's example: a user asks an agent to "help me find one email from last week" while the OAuth scope grants `gmail.readonly` — full access to every email since account creation. The user's mental model of what they authorized and what the agent can actually do diverge wildly. This is consent theater: a permission system that looks like authorization but carries no semantic constraint.

Verifiable Intent, open-sourced by Mastercard and Google on March 5, 2026, closes this gap through signed, layered constraints that travel with every authorization.

## The Three-Layer Architecture

Each layer is signed by the appropriate party and is independently verifiable:

**Layer 1: Issuer Identity.** The credential issuer (payment network, identity provider) proves the identity of the user. The credential is bound to the user's public key.

**Layer 2: User Intent.** The user defines constraints on what the agent may do. Signed by the user; cannot be modified by the agent:
- Merchant restrictions (only these merchants)
- Amount bounds (maximum per transaction, total budget)
- Line item constraints (only these product categories)
- Recurrence rules (one-time, weekly up to N times)
- Time bounds (valid for 24 hours)

**Layer 3: Agent Action.** The agent signs what it intends to do within the user's constraints. Splits into L3a (sent to the payment network) and L3b (sent to the merchant) — each containing only what that party needs.

## Key Properties

**Selective disclosure.** Each party sees only what it needs. The merchant sees checkout details but not the payment instrument. The payment network sees the authorization but not the line items. Privacy is architectural, not bolted on.

**No sub-delegation.** Layer 3 is terminal. The agent cannot delegate further. Authority can only decrease through the chain, never increase.

**Monotonic attenuation.** The user's Layer 2 constraints are cryptographic. The agent cannot exceed them. The merchant verifies them. The payment network enforces them.

## Standards and Adoption

Built on SD-JWT, JWT, JWS, and ES256 from IETF, FIDO Alliance, EMVCo, and W3C. Three major commerce protocols adopted Verifiable Intent: AP2 (Google), ACP (Stripe/OpenAI), and UCP (Google/Shopify/Walmart).

## Where This Fits

Verifiable Intent is the middle layer in a pre-interaction trust stack:
1. Verify agent identity (KYA — [[non-human-identity]])
2. Understand agent capabilities and constraints (transparency label)
3. Authorize specific actions with cryptographic constraint (Verifiable Intent)

It maps to the PAC Accountability pillar: the audit trail is not "what did the agent do?" but "what was the agent authorized to do, signed by the user, before it acted?"

## Connects to

- [[obo-token-exchange]] — OBO tracks who delegated; Verifiable Intent proves what was authorized
- [[verifiable-credentials]] — both use SD-JWT and selective disclosure; VCs prove identity attributes, Verifiable Intent proves authorization constraints
- [[delegation-chain]] — Layer 2 → Layer 3 is a delegation step with cryptographic attenuation
- [[trust-inversion]] — the user's constraints are enforced structurally, not by asking the agent to behave correctly
- [[three-layer-credential-chain]] — Verifiable Intent is one of three independent implementations that converged on the same User Identity → Delegation → Transaction architecture

## Appears in

- **Verifiable Intent: Mastercard and Google Open-Source Agent Authorization** (`posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved`, 2026-03-06) — full dedicated post; three-layer SD-JWT architecture, constraint types, selective disclosure, protocol interoperability
- **Trusted AI Agents: Why Traditional IAM Breaks Down** (`posts/trust-for-agentic-ai`, 2026-01-24) — the problem VI solves: what did the user actually authorize?

## Sources

- Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," shanedeconinck.be, March 6, 2026
- Mastercard, "How Verifiable Intent Builds Trust in Agentic AI Commerce," March 5, 2026
- src/chapters/agent-identity.md §Verifiable Intent: Proving What Was Authorized
- src/drafts/verifiable-intent.md — standalone chapter draft: full L1/L2/L3 architecture, eight constraint types, sd_hash selective disclosure, infrastructure maturity table (I1–I5)
