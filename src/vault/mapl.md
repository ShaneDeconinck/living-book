---
title: MAPL (Machine-Actionable Policy Language)
tags: [policy, cryptographic, control]
---

A policy language where child policies can only restrict parent policies, never relax them; effective policy is the intersection of all layers.

MAPL uses intersection semantics: when a parent policy permits actions A, B, C and a child policy permits B, C, D, the effective permission is B, C. Authority can only decrease through delegation, never expand. This makes privilege escalation mathematically impossible within the policy framework. MAPL policies are machine-actionable (agents and infrastructure can evaluate them directly) and composable across organizational boundaries. Combined with [[ghost-token]] issuance, MAPL enables [[cryptographic-authorization]] where every action is provably within the intersection of all applicable policies.
