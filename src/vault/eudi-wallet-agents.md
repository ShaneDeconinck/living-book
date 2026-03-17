---
title: EUDI Wallet as Agent Governance Substrate
tags: [identity, regulation, cross-org-trust, eidas, credentials]
---

The European Digital Identity Wallet (eIDAS 2.0 mandate) provides the trusted issuer, cross-border verification, and selective disclosure infrastructure that cross-organization agent governance requires — as a byproduct of its primary purpose as a citizen credential wallet.

## Three Properties That Matter for Agents

**Trusted issuer infrastructure.** Governments, universities, professional bodies, and enterprises issue credentials into wallets. Issuers are registered in EU Member State trusted lists. An agent presenting a credential from a trusted issuer carries verifiable proof of its principal's identity and qualifications. The trust anchor is the issuer's place on the trusted list, not a bilateral relationship between the verifying party and the issuer.

**Cross-border credential recognition.** A credential issued in Spain is verifiable in Germany. W3C VC format with resolvable vocabularies enables semantic interoperability: a machine determines that a Spanish qualification maps to a specific EQF level without human interpretation. This is the cross-border agent commerce case: an agent with a business wallet credential can prove its principal's organizational identity and authority to a counterparty in another EU jurisdiction.

**Business wallets.** Companies authenticate themselves, sign contracts, and prove attributes. Combined with agent delegation credentials, business wallets become the infrastructure for "this agent acts on behalf of Company X, authorized to negotiate contracts up to EUR 50,000." The business wallet is the issuance point for the delegation credential the agent carries.

## WE BUILD: Wallets for AI Agents

The WE BUILD consortium (one of the EU's Large Scale Pilots for EUDI implementation) issued three recommendations in March 2026: develop a safe AI agent strategy built on the EUDI framework and Business Wallet infrastructure, establish standards working groups for EUDI/agent interoperability, and prioritize testing before regulation.

The framing matters: not "AI in wallets" (using AI to improve wallet UX) but "wallets for AI agents" (using wallet infrastructure to govern autonomous systems). Four capabilities identified as requirements: mutual authentication between agents and merchants, verification of the human-to-agent relationship, confirmation of counterparty legitimacy, and digital signatures distinguishing authentic from AI-generated content. These map directly to the cross-org trust stack.

## The W3C VC Gap

The EUDI implementing regulations include W3C VC as a supported format (de jure inclusion) but lack the operational scaffolding that makes it production-deployable (PID encoding tables, presentation profiles, issuance protocol specifications). That scaffolding exists only for mdoc and SD-JWT VC. A significant share of responses to the public consultation on implementing regulations diagnosed this gap.

W3C VC is the format best suited for cross-border semantic interoperability and privacy-preserving presentations. Its exclusion from the operational specifications creates a tension: the legal framework anticipates cross-border semantic interoperability, but the deployable format (SD-JWT VC) uses a type identifier (`vct`) that is not resolvable the way W3C VC's `@context` is. Machines can validate that two parties used the same `vct` string; they cannot deterministically resolve what that string means without out-of-band coordination.

## The Unlinkability Contradiction

Article 5a(16)(b) of the eIDAS regulation requires unlinkability where identification is not needed. The only format that delivers cryptographic unlinkability is W3C VC with BBS signatures. BBS uses the BLS12-381 curve, which is not on the SOG-IS/ECCG Agreed Cryptographic Mechanisms list. A legal obligation without a deployable cryptographic mechanism.

For agents operating cross-border with privacy requirements, this is a constraint worth tracking: the legal requirement exists, the technical mechanism does not yet have regulatory approval, and the deployable formats (mdoc, SD-JWT VC) do not provide unlinkability.

## Relationship to TSP and PIC

[[trust-spanning-protocol|TSP]] is designed to interoperate with EUDI wallets. [[authority-continuity|PIC]] can validate continuity chains anchored in EUDI-issued credentials. The EUDI infrastructure does not replace TSP or PIC; it provides the issuer and verification layer that makes their credentials trustworthy at scale.

## Connects to

- [[verifiable-credentials]] — EUDI supports W3C VC, mdoc, SD-JWT VC, and X.509; each format has different cross-org properties
- [[trust-spanning-protocol]] — TSP designed to interoperate with EUDI wallets
- [[authority-continuity]] — continuity chains can be anchored in EUDI-issued credentials
- [[cross-domain-delegation-model]] — EUDI business wallets are the credential issuance infrastructure for cross-domain delegation

## Sources

- European Commission, eIDAS 2.0, Regulation (EU) 2024/1183, December 2026 EUDI Wallet mandate
- WE BUILD Consortium, reported in BiometricUpdate.com, "EU can rein in AI agents with EUDI Wallets," March 9, 2026
- Shane Deconinck, "EUDI Credential Formats Crash Course: X.509, mDL, SD-JWT VC, and W3C VC," March 9, 2026
- src/chapters/cross-org-trust.md §The EUDI Wallet Infrastructure
