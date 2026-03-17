---
title: Verifiable Content Provenance
tags: [cross-org-trust, credentials, identity, content]
---

Binding content to a DID so that agents consuming that content can verify its authenticity and origin without contacting any authority. Cross-organizational trust at the content layer.

## The Pattern

A content creator publishes alongside each item:
- A cryptographic hash of the content (SHA-256 over JCS-canonicalized fields)
- A W3C Verifiable Credential binding that hash to their DID
- An Ed25519 Data Integrity proof signed with the DID's private key
- Machine-discoverable placement (e.g., `<link rel="verifiable-credential">`)

A consuming agent:
1. Resolves the author's DID to obtain their DID Document and public key
2. Recomputes the content hash and checks it against the VC's hash claim
3. Verifies the Ed25519 signature using the `eddsa-jcs-2022` cryptosuite
4. Cross-references the DID against other identity anchors (GitHub profile, etc.)

No shared infrastructure between the content publisher and the agent. No pre-established relationship. The trust comes entirely from the cryptographic proof: DID resolves to public key, signature is valid, hash matches.

## Why It Matters for Agents

Agents consuming external content have no reliable signal for authenticity without infrastructure like this. Without it, an agent that "reads" a blog post or a technical spec has no way to distinguish the original from a modified version served by a compromised CDN, a MITM, or a malicious tool.

Verifiable content provenance provides that signal cryptographically. The absence of a verifiable credential is itself information: content without a VC should trigger caution, not silent acceptance.

This extends beyond blog posts. Technical specs, API documentation, source attribution for AI training — anywhere agents need to verify that content came from who it claims to come from.

## Demonstrated Implementation

Shane's blog implements this: every post carries a `vc.json` alongside it. Given only "verify" as a prompt, a coding agent (Claude Code) autonomously:
1. Resolved the DID
2. Checked the content hash
3. Verified the Ed25519 signature
4. Cross-referenced the DID against his GitHub profile

The agent debugged two real problems encountered (a trailing newline breaking the content hash, a `@context` ambiguity in the proof options) by reasoning through the relevant standards. This demonstrates that the building blocks are functional.

## Why It Remains Fragile

The pattern depends on voluntary adoption. There is no standardized convention for where authors publish their DIDs, how agents discover VCs for arbitrary content, or what DID methods agents should resolve. Without these conventions, the pattern remains opt-in and manual. An agent that knows to look for Shane's VC does not automatically know to look for anyone else's.

This is the bootstrapping problem for verifiable content at the web layer. The technical components (DIDs, VCs, Data Integrity proofs) work. The discovery and convention layer does not yet exist at web scale.

## Relationship to Cross-Org Trust

Content provenance is one implementation of the broader cross-org trust problem: how do you trust a stranger's artifacts without shared infrastructure? The same DID/VC mechanism that enables cross-org agent delegation applies to content. The difference is the subject: instead of "this agent is authorized to act on behalf of Organization X," the claim is "this content was produced by Author Y at time Z and has not been modified."

## Connects to

- [[verifiable-credentials]] — VCs are the trust carrier; DIDs provide the identity anchor
- [[trust-spanning-protocol]] — TSP handles stranger-to-stranger channel establishment; this pattern handles stranger-to-stranger content verification
- [[trust-inversion]] — absence of a VC is information; default to caution, not default to trust

## Sources

- Shane Deconinck, "My Content Comes with Verifiable Credentials. Your Agent Can Verify," February 22, 2026
- W3C Data Integrity specification, `eddsa-jcs-2022` cryptosuite
- src/chapters/cross-org-trust.md §Content Provenance: VCs in Practice
