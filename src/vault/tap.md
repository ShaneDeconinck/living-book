---
title: Trusted Agent Protocol (TAP)
tags: [protocol, commerce, identity, trust, agents]
---

Visa's open-source protocol (Apache 2.0) for establishing agent legitimacy in commerce interactions, using RFC 9421 HTTP Message Signatures. Announced October 2025, solves the trust bootstrapping problem the other commerce protocols assume away: how does a merchant distinguish a legitimate agent from a bot?

## How It Works

Every agent request carries two HTTP headers:
- **Signature-Input** — metadata: request URI, timestamps, key identifier, algorithm, nonce, tag (browsing vs. payment)
- **Signature** — the cryptographic signature itself (Ed25519 or PS256)

The merchant validates the signature against publicly retrievable keys at well-known JWKS endpoints. No bilateral agreement required.

## Three Architectural Properties

**Merchant-specific binding.** Each signature is cryptographically locked to a specific merchant's domain and exact page. An authorization for `audioshop.example.com/headphones` cannot be relayed to another merchant or product.

**Time-bound validity.** Signatures expire after maximum 8 minutes. Merchants track nonces to prevent replay. Captured requests become useless almost immediately.

**Existing web infrastructure.** Built on HTTP, not new credential formats. Merchants add signature verification to existing web servers, not SD-JWT or blockchain infrastructure.

## Information Carried

Three types:
1. **Agent intent** — proof the agent is Visa-trusted with a specific commerce purpose
2. **Consumer recognition** — hashed identifiers for returning customer matching without exposing raw data
3. **Payment information** — hashed credentials or encrypted payloads for checkout/API integrations

## Traction

Over 100 global partners, hundreds of controlled real-world transactions. Early adopters: Nuvei, Adyen, Stripe, Skyfire, Nekuda, PayOS, Ramp. Pilots launching in Asia Pacific and Europe in 2026.

## Distinct from [[verifiable-intent]]

TAP establishes agent legitimacy at the merchant's front door (is this agent trusted?). [[verifiable-intent]] constrains what the agent can do once authorized (what spending limits apply?). TAP uses HTTP Message Signatures; Verifiable Intent uses SD-JWT. They compose: Visa is collaborating with Coinbase to align TAP with [[x402]].

## Connects to

- [[verifiable-intent]] — complementary: TAP for identity, VI for constraints
- [[x402]] — TAP spec supports HTTP 402 payment flows
- [[know-your-agent]] — both address agent legitimacy, but TAP is protocol-level while KYA is a verification framework
- [[ap2]] — TAP provides the trust layer AP2 transactions require

## Sources

- Visa, "Visa Introduces Trusted Agent Protocol," investor.visa.com, October 2025
- Visa Developer Center, "Trusted Agent Protocol Specifications," developer.visa.com
- Visa, "Visa and Partners Complete Secure AI Transactions," usa.visa.com, 2026
- src/chapters/agent-payments.md
