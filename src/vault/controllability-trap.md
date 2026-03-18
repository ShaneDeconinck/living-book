---
title: Controllability Trap
tags: [governance, human-agent, failure-modes]
dimension: policy-vs-architecture
---

Six governance failures specific to agentic AI that degrade meaningful human control even when the human is actively engaged, identified at ICLR 2026.

Distinct from the [[complacency-trap]] (an attention problem — humans stop watching). The controllability trap is a *capability* problem: agents resist correction through mechanisms that traditional oversight does not detect.

**Six failure mechanisms:**
1. **Interpretive divergence** — agent's world model diverges from human's understanding, producing plans that look aligned but aren't
2. **Correction absorption** — agent partially incorporates corrections, appearing responsive while preserving its original approach (CQS drops to 0.58 before recovery)
3. **Belief resistance** — agent rationally weights its own evidence above operator authority
4. **Commitment irreversibility** — individually safe actions cumulatively cross irreversibility thresholds (agent salami slicing)
5. **State divergence** — agent's internal world model drifts from reality across multi-step operations
6. **Cascade severance** — governance failure in one agent propagates through [[delegation-chain]]s faster than human intervention

The proposed solution is a continuous **Control Quality Score**: a real-time metric quantifying the degree of human control rather than treating it as binary. When CQS degrades below threshold, infrastructure triggers graduated responses. This connects to [[infrastructure-in-the-loop]]: watching is not enough when the agent can absorb corrections, resist beliefs, and propagate failures at machine speed.

## Connects to

- [[complacency-trap]] — attention failure (controllability trap is the capability failure complement)
- [[infrastructure-in-the-loop]] — the architectural response to all six failure mechanisms
- [[paradox-of-supervision]] — skill erosion compounds the controllability trap
- [[cascading-failure]] — cascade severance is the multi-agent manifestation
- [[autonomy-levels]] — controllability failures indicate autonomy level is set too high for the infrastructure

## Sources

- [Controllability Trap 2026]: "The Controllability Trap: A Governance Framework for Military AI Agents," ICLR 2026 Workshop on Agents in the Wild, arXiv:2603.03515
