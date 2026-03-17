---
title: Authority Continuity (PIC)
tags: [principle, security, delegation]
---

The Provenance, Identity, Continuity (PIC) model where authority can only decrease through delegation chains, never expand.

PIC replaces proof-of-possession with proof-of-continuity. Three properties:
- **Provenance**: every action traces to a human principal — the chain of who authorized what is always reconstructable
- **Identity**: each agent has its own verifiable identity, not borrowed credentials from the human
- **Continuity**: authority monotonically decreases at each delegation hop; if Agent A has permissions {read, write} and delegates to Agent B, B receives at most {read, write} — and typically less

## Why it matters

The root problem PIC addresses: we treat authority as an object — something stored in tokens, held by whoever possesses them. A stolen token works. A replayed token works. A token used in an unintended context works. Possession equals authority.

PIC shifts to authority as a relationship: not "I hold this token" but "I have been authorized, by this principal, for this purpose, within these bounds, and I can prove that at each step." This eliminates the [[confused-deputy]] structurally rather than detecting it post-hoc.

Nicola Gallo's formulation: *agents aren't a new kind of security subject. They're workloads.* Short-lived, rescheduled, replicated. The authority they carry can't be unstable.

## Implementation

The intersection semantics of [[mapl]] implement authority continuity at the policy layer. [[trust-spanning-protocol]] implements it at the protocol layer. [[verifiable-credentials]] carry the cryptographic proof of authority at each hop.

## Connects to

- [[delegation-chain]] — PIC is the theoretical model; delegation chains are the artifact
- [[trust-spanning-protocol]] — TSP handles identity verification; PIC governs what authority can be carried through it
- [[confused-deputy]] — PIC eliminates the deputy problem structurally
- [[mapl]] — policy-layer implementation of authority intersection semantics
- [[obo-token-exchange]] — OBO tracks the chain; PIC constrains how authority flows through it

## Appears in

- **Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity** (`posts/lfdt-meetup-trust-ecosystems-authority-continuity`, 2026-03-11) — Nicola Gallo's full PIC presentation; authority as relationship, not object
- **Trusted AI Agents: Why Traditional IAM Breaks Down** (`posts/trust-for-agentic-ai`, 2026-01-24) — authority attenuation as the core IAM requirement
- **AI Agents Beyond POCs: IAM Emerging Patterns** (`posts/ai-agents-beyond-pocs-iam-emerging-patterns`, 2026-01-03) — proof of continuity as a key emerging pattern

## Sources

- Nicola Gallo, presentation at LFDT Belgium Meetup, March 3, 2026
- PIC protocol spec: github.com/pic-protocol/pic-spec
- Shane Deconinck, "Trusted AI Agents by Design," shanedeconinck.be, March 11, 2026
- src/chapters/cross-org-trust.md
