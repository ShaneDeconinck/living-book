---
title: Authority Continuity (PIC)
tags: [principle, security, delegation]
---

The Provenance, Identity, Continuity model where authority can only decrease through delegation chains, never expand.

PIC replaces proof-of-possession with proof-of-continuity. Three properties: **Provenance** (every action traces to a human principal), **Identity** (each agent has its own verifiable identity, not borrowed credentials), **Continuity** (authority monotonically decreases at each delegation hop). This eliminates the [[confused-deputy]] structurally rather than detecting it post-hoc. If Agent A has permissions {read, write} and delegates to Agent B, B can receive at most {read, write} — and typically less. The intersection semantics of [[mapl]] implement this at the policy layer. PIC is the theoretical foundation; [[trust-spanning-protocol]] implements it at the protocol layer.
