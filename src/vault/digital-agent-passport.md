---
title: Digital Agent Passport (DAP)
tags: [protocol, identity, commerce, kya]
dimension: agent-identity
---

A tamper-proof credential bundle that enables merchants to assess whether an AI agent is legitimate, authorized, and acting with proper consent. Defined by Trulioo's Know Your Agent (KYA) framework.

The DAP bundles five checkpoints into a single portable credential:

1. **Verify the developer.** Standard KYB/KYC on the entity that built the agent.
2. **Lock the code.** Cryptographic attestation that the agent's code has not been tampered with since verification.
3. **Capture user consent.** Explicit, verifiable authorization from the human principal, not an OAuth scope but a recorded consent event.
4. **Issue the passport.** The DAP bundles verified developer identity, code attestation, and user consent into a credential that merchants and payment networks validate at machine speed.
5. **Continuous validation.** Ongoing monitoring of agent behavior, risk profile, and authorization status. If code changes, consent is revoked, or suspicious activity arises, the passport is invalidated in real time.

KYA is not a one-time check. It is a living system where every agent remains under continuous scrutiny.

Trulioo joined Google's [[ap2]] initiative in December 2025, integrating the DAP as a verifiable trust layer within AP2's payment authorization flow. Worldpay partnered with Trulioo in August 2025 to embed KYA into its payment infrastructure.

Prove launched a complementary approach (Verified Agent, October 2025) starting from the human rather than the developer: creating persistent digital identity anchors that bind attributes to verified humans, then issuing signed credentials to their authorized agents.

Together with [[verifiable-intent]], KYA and DAP compose a complete trust stack for agent commerce: KYA proves the agent is legitimate; [[verifiable-intent]] constrains what it can do.

Connects to: [[know-your-agent]], [[verifiable-credentials]], [[x402]], [[erc-8004]]
