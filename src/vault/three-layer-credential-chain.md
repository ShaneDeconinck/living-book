---
title: Three-Layer Credential Chain
tags: [delegation, authorization, identity, convergence]
---

A delegation architecture converging independently across three implementations: User Identity → Delegation → Transaction, where each layer is cryptographically chained and the lower layers enforce constraints on the upper.

## The Pattern

Three organizations built agent authorization systems independently and arrived at the same three-layer structure:

**Layer 1 — User Identity**: the human completes identity verification once, receiving a cryptographic attestation tied to their identifier (DID, wallet address, or organizational credential).

**Layer 2 — Delegation**: the user cryptographically authorizes the agent with scoped permissions — spending limits, approved services, time bounds, purpose constraints. This delegation is a signed credential, not just a token.

**Layer 3 — Transaction**: the agent executes within delegated constraints, with every action traceable to the verified human through the credential chain.

The chain is self-contained: a verifier can validate all three layers without contacting the delegating party. The chain survives across organizational boundaries.

## Three Independent Implementations

- **Para (AI Wallet)**: user identity → delegation credential → agent presentation. The wallet holds the human's verified identity and issues delegation credentials to agents.
- **Mastercard/Google Verifiable Intent**: SD-JWT credential chain with Layer 1 (who authorized this?), Layer 2 (what constraints apply?), Layer 3 (what was done?). Each layer cryptographically chained; the agent cannot present Layer 3 without valid Layer 2 and Layer 1.
- **Trulioo Digital Agent Passport**: developer/user verification → Digital Agent Passport → merchant validation. Know-Your-Agent for commerce.

Three organizations, same architecture. The convergence is the signal.

## Why the Chain Cannot Be Skipped

The cryptographic structure prevents layer bypassing. In Verifiable Intent, a valid action credential (Layer 3) requires a valid intent credential (Layer 2), which requires a valid identity credential (Layer 1). An agent cannot fabricate Layer 3 without the preceding chain. This is operational envelope enforcement: the constraints travel with the authorization, verifiable at every hop.

## What the Chain Provides

- **Verifiable**: who authorized the agent, provable without contacting the delegating party
- **Scoped**: what the agent was authorized to do, encoded in the credential structure
- **Traceable**: what happened, attributable to the verified human through the chain

These are the three properties the Cloud Security Alliance identified as absent in the Drift breach: delegation proof, operational envelopes, and traceability.

## Connects to

- [[verifiable-intent]] — Mastercard/Google's SD-JWT implementation of this pattern for agent commerce
- [[verifiable-credentials]] — VCs are the format that makes the chain portable across organizational boundaries
- [[delegation-chain]] — the three-layer pattern is the credential-level implementation of delegation chain requirements
- [[operational-envelopes]] — the delegation layer in this pattern is the operational envelope, traveling with the credential
- [[know-your-agent]] — Trulioo's Digital Agent Passport instantiates this pattern for commerce KYA requirements
- [[authority-continuity]] — PIC provides the structural guarantee that Layer 2 constraints are not expanded at Layer 3

## Sources

- Para, "Agent Identity: How AI Wallets Inherit Human Credentials," 2026
- Mastercard / Google, Verifiable Intent specification, 2026
- Trulioo, Digital Agent Passport / Know-Your-Agent framework, 2026
- arxiv.org/abs/2601.14982 — academic treatment of interoperable identity delegation
- src/chapters/cross-org-trust.md §The Three-Layer Chain
