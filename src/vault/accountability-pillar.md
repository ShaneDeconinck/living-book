---
title: Accountability (PAC Pillar)
tags: [pac-framework, pillar, accountability, governance]
---

The second pillar of the [[pac-framework]], addressing who is accountable and whether that can be proven. Accountability without [[control-pillar]] is governance on paper; Accountability without [[potential-pillar]] generates compliance overhead with no business mandate.

## Dimensions

**[[shadow-agents]]**: the first question is whether you know every agent running in your organization. Agents that governance never approved are agents governance cannot govern.

**[[delegation-chain]]**: authority flows from a human principal through agents to actions. Without traceability, delegation is abdication. The chain must capture what was granted, how it was interpreted, what was done, and whether authority decreased at every hop.

**Audit trails**: not application logs but compliance artifacts. They must answer who authorized the action, what information the agent had when it decided, and whether the decision was within granted authority — for regulators, not just for debugging. See `src/chapters/agent-observability.md`.

**Liability chains**: must be mapped before deployment. Who owns this agent? Who authorized it? Who is responsible when it fails? What is the escalation path? These are organizational questions that require technical infrastructure to be answerable.

## The policy-enforcement gap

Two independent surveys in early 2026 quantify the failure mode of Accountability without Control:

- 82% of executives feel confident their policies protect against agent misuse
- Only 14.4% of deployed agents went live with full security and IT approval [Gravitee 2026]

The confidence rests on policy documentation, not runtime enforcement. Organizations believe they are governed because policies exist, while [[infrastructure-levels]] to enforce those policies do not.

## Connects to

- [[pac-framework]] — one of three interdependent pillars
- [[potential-pillar]] — Potential without Accountability is reckless adoption
- [[control-pillar]] — Accountability without Control is governance on paper
- [[delegation-chain]] — the core infrastructure requirement for accountability
- [[shadow-agents]] — agents that bypass accountability make Accountability pillar unenforceable

## Sources

- [Gravitee 2026]: Gravitee, "State of AI Agent Security 2026," February 2026
