---
title: Agent Reliability
tags: [reliability, evaluation, governance, potential]
dimension: reliability
---

Reliability is not a single number. It is four dimensions with separate failure modes, each requiring different governance responses.

## The four dimensions

From Rabanser, Kapoor et al., "Towards a Science of AI Agent Reliability" (arXiv:2602.16666, February 2026):

**Consistency**: does the agent produce repeatable behavior across runs? An inconsistent agent produces different outputs for the same input — unpredictable to developers and users, and difficult to evaluate meaningfully.

**Robustness**: does the agent stay stable under input and environmental perturbation? A robust agent handles unexpected inputs, edge cases, and adversarial conditions without degrading significantly. Static benchmarks that present clean inputs do not measure robustness.

**Predictability**: can the agent calibrate its own confidence and distinguish when it is likely wrong? A predictable agent signals uncertainty appropriately — it does not present a wrong answer with the same confidence as a correct one. Opacity here is the mechanism behind the [[complacency-trap]]: the agent's errors look like competence.

**Safety**: when the agent fails, is the severity bounded? A safe agent fails in contained, recoverable ways. An unsafe agent, when it fails, can cause irreversible damage. This is the [[blast-radius]] dimension of reliability.

## The error margin requirement

A single accuracy metric is insufficient for governance. "95% accuracy" means nothing without a margin: 95% ± 2% and 95% ± 8% describe very different agents. The [[pac-framework]] insists on error margins for reliability claims used to justify autonomy levels. Without the margin, the number is not a governance input — it is a marketing figure.

## Infrastructure level and reliability requirements

Different blast-radius levels require different reliability profiles:

- **B1 (contained)**: can tolerate lower reliability because errors are caught before impact. Consistency and robustness matter more than predictability.
- **B3 (exposed, customer-facing)**: all four dimensions matter. An unpredictable agent in a customer-facing role creates trust damage and regulatory exposure.
- **B4 (regulated)**: reliability across all four dimensions is required for compliance. Each failure mode creates a different compliance exposure: consistency failures produce inconsistent records; robustness failures create adversarial attack surfaces; predictability failures undermine audit trail integrity; safety failures create incident liability.

The infrastructure level gates which blast-radius levels are safe: an agent operating at B4 without I3+ infrastructure (structured audit trails, anomaly detection) cannot reliably demonstrate the reliability required by its blast radius.

## Why reliability and governance are different problems

Reliability asks: does the agent get the right answer?
Governance asks: when it gets the wrong answer, can you explain what happened, who authorized it, and what the blast radius was?

Better models improve reliability. They do not automatically improve governance. The [[complacency-trap]] is the failure mode where improving reliability reduces perceived need for governance, when the correct response is the opposite: higher reliability requires stronger governance because the rare failures are harder to detect and cause more damage when unmonitored.

An agent that is right 99% of the time without audit trails is less trustworthy than one that is right 95% with full observability. The 0.1% failure of the first agent is undetectable, unexplainable, and unpreventable. The 5% failure of the second is traceable.

## Connects to

- [[complacency-trap]] — why reliability improvements paradoxically reduce effective oversight
- [[benchmark-landscape]] — benchmarks measure some reliability dimensions but not all; none covers all four simultaneously
- [[evaluation-as-governance]] — reliability must be measured post-deployment, not just pre-deployment, to be a governance input
- [[blast-radius]] — the safety dimension of reliability; failure severity determines governance requirements
- [[infrastructure-levels]] — infrastructure maturity level determines which blast-radius levels an agent can safely operate at
- [[pac-framework]] — reliability percentage with error margin is required for PAC autonomy level justification
- [[infrastructure-in-the-loop]] — the architectural response to the predictability gap: structural enforcement does not depend on the agent correctly signaling its own uncertainty

## Sources

- [Rabanser-2026]: Stephan Rabanser, Sayash Kapoor et al., "Towards a Science of AI Agent Reliability," arXiv:2602.16666, February 2026. Four-dimension framework: consistency, robustness, predictability, safety.
- [Deconinck-pac]: Shane Deconinck, PAC Framework, trustedagentic.ai/framework, 2026. Error margin requirement for reliability claims.
- Chapter: [Reliability, Evaluation, and the Complacency Trap](../chapters/reliability-evaluation.md)
