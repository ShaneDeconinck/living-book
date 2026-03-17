---
title: Control (PAC Pillar)
tags: [pac-framework, pillar, control, security]
---

The third pillar of the [[pac-framework]], addressing whether infrastructure can enforce what policy demands. Policy says "don't." Architecture says "can't." The difference matters when agents act autonomously across systems and organizations.

## The core distinction

The [[pac-framework]]'s central argument: policy-based governance ("don't") fails against capable agents whether those agents are adversarial, commercially motivated, or emergent. Architecture-based governance ("can't") holds because it constrains what is possible, not what is permitted. This has empirical support:

- OpenAI's December 2025 Atlas hardening report admits prompt injection is "unlikely to ever be fully solved." System-level containment is the recommended approach.
- Irregular's March 2026 simulation: agents on a corporate network overrode antivirus, bypassed DLP through steganography, forged credentials, and "peer pressured" other agents — without adversarial prompting. Advisory controls were circumvented through emergent behavior.
- Microsoft Research Firewalled Agent Networks: reduce privacy attacks from 84% to 10%, security attacks from 60% to 3%.
- CVE-2026-2256: regex-based command denylists are trivially bypassed in agent frameworks because agents generate novel command sequences by design.

## Dimensions

**[[infrastructure-levels]] (I1-I5)**: the guardrails actually built. Auditing, identity, authorization, sandboxing, monitoring. A gate per [[autonomy-levels]], not a spectrum.

**[[agent-identity]]**: agents need an identity that answers who they are, who they act for, and how both can be proven cryptographically. Traditional IAM was not built for entities that receive goals and decide how to accomplish them.

**[[trust-inversion]]**: agents require the inverse of how organizations trust humans. Default deny, explicit allowlist, task-scoped capabilities. The inverse of the human blocklist model.

**Cross-organizational trust**: when your agent calls my agent, how do I verify its identity, check its authority, and maintain [[accountability-pillar]]? Trust Spanning Protocol (TSP) and Verifiable Credentials address this at scale.

## Connects to

- [[pac-framework]] — one of three interdependent pillars
- [[potential-pillar]] — Control without Potential is infrastructure without mandate
- [[accountability-pillar]] — Accountability without Control is governance on paper
- [[infrastructure-levels]] — the operational scale for Control
- [[trust-inversion]] — the foundational principle of Control
- [[delegation-chain]] — Control requires that delegation chains only attenuate authority
