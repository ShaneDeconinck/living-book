---
title: MAPL (Machine-Actionable Policy Language)
tags: [policy, cryptographic, control]
dimension: policy-vs-architecture
---

A policy language where child policies can only restrict parent policies, never relax them; effective policy is the intersection of all layers.

MAPL uses intersection semantics: when a parent policy permits actions A, B, C and a child policy permits B, C, D, the effective permission is B, C. Authority can only decrease through delegation, never expand. This makes privilege escalation mathematically impossible within the policy framework. MAPL policies are machine-actionable (agents and infrastructure can evaluate them directly) and composable across organizational boundaries. Combined with [[ghost-token]] issuance, MAPL enables [[cryptographic-authorization]] where every action is provably within the intersection of all applicable policies.

## Connects to

- [[ghost-token]] — tokens issued against MAPL intersection carry cryptographic proof of the effective policy scope
- [[cryptographic-authorization]] — MAPL is the policy substrate; ghost tokens are the enforcement mechanism
- [[autonomy-levels]] — MAPL is what makes higher autonomy levels safe to grant: the policy intersection prevents privilege escalation regardless of what the agent decides, so organizations can extend autonomy without expanding blast radius
- [[complacency-trap]] — without machine-actionable policy, governance relies on human reviewers keeping pace with agent volume; MAPL moves the enforcement gate to infrastructure speed, so the complacency risk is structural rather than behavioral
- [[blast-radius]] — the intersection constraint is a hard ceiling on the damage any single agent can cause; even a fully compromised agent cannot act outside the MAPL intersection
