---
title: Agent Payments Protocol (AP2)
tags: [protocol, commerce, payments, agents]
dimension: business-value
---

Google's protocol for agent payment authorization, announced September 2025 with over 60 participating organizations including Mastercard, American Express, PayPal, Adyen, Etsy, and Coinbase.

## Core Abstraction: Mandates

AP2's key innovation is the **Mandate**: cryptographically signed records of user instructions and approvals.

- **Intent Mandate** — captures the user's instruction ("find running shoes under $120")
- **Cart Mandate** — captures the user's approval of a specific purchase

This two-step structure separates browsing from buying. You can trace what the user authorized versus what the agent decided. The separation matters for accountability: intent is recorded before the agent acts.

## Properties

- Payment-agnostic: supports cards, bank transfers, crypto via [[x402]]
- Integrates with [[verifiable-intent]] for cryptographic constraint enforcement
- Google's A2A x402 extension provides agent-based crypto payment support
- [[digital-agent-passport|Trulioo's Digital Agent Passport]] integrated as a verifiable trust layer (December 2025)

## Relationship to Other Commerce Protocols

AP2 handles payment authorization. [[ucp]] handles product discovery. [[acp]] handles checkout flows. [[tap]] handles agent legitimacy. The protocols are complementary:

| Protocol | What It Handles |
|---|---|
| [[tap]] | Is this agent legitimate? |
| [[ucp]] | What products are available? |
| [[acp]] | How does checkout work? |
| AP2 | How is payment authorized? |

## Connects to

- [[verifiable-intent]] — the cryptographic constraint layer AP2 references
- [[x402]] — settlement mechanism for crypto-native AP2 payments
- [[know-your-agent]] — Trulioo and Prove both support AP2 for identity verification
- [[digital-agent-passport]] — integrated into AP2 as a trust layer

## Sources

- Google Cloud Blog, "Announcing Agent Payments Protocol (AP2)," September 2025
- src/chapters/agent-payments.md
