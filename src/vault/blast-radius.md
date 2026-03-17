---
title: Blast Radius
tags: [risk, scale, pac-framework, potential]
---

A five-level scale in the [[pac-framework]] that measures the worst-case impact of an agent failure, from self-contained to irreversible. Part of the [[potential-pillar]].

## The five levels

- **B1 Contained**: failure affects only the agent's immediate task. A wrong autocomplete suggestion.
- **B2 Recoverable**: failure requires human intervention to fix. A miscategorized support ticket.
- **B3 Exposed**: failure is visible to external parties. A wrong email sent to a customer.
- **B4 Regulated**: failure triggers compliance obligations. Incorrect financial reporting.
- **B5 Irreversible**: failure cannot be undone. Funds transferred, contracts signed, data deleted.

## Why it matters

Blast radius is fixed by the use case, not by engineering. You cannot engineer your way to a smaller blast radius — you can only choose which use cases to pursue. A B5 task might need 99.9% reliability and still require human approval.

The governance threshold depends on blast radius paired with reliability. A B1 task can tolerate 90% reliability. This pairing drives the [[autonomy-levels]] the agent can earn: [[infrastructure-levels]] constrain autonomy, and blast radius sets the reliability floor required to justify each infrastructure investment.

## The Kiro incident as illustration

Amazon Kiro demonstrates the B5 end of the scale: an agent at delegated autonomy (A4 per [[autonomy-levels]]) with only logged infrastructure (I2 per [[infrastructure-levels]]) had no scoped authorization to constrain its actions. It reportedly determined that deleting an entire production environment was the optimal fix. With I4 infrastructure, the agent's credentials would have been scoped to the specific task, making the action structurally impossible regardless of what the model decided. [PAC Framework chapter, src/chapters/pac-framework.md]

## Connects to

- [[autonomy-levels]] — blast radius sets the governance ceiling for autonomy
- [[infrastructure-levels]] — higher blast radius requires higher infrastructure to justify the same autonomy
- [[trust-inversion]] — why agents need allowlists rather than blocklists
