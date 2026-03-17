---
title: Potential (PAC Pillar)
tags: [pac-framework, pillar, value, potential]
---

The first pillar of the [[pac-framework]], addressing what is worth building that lasts. Potential without [[accountability-pillar]] is reckless adoption; Potential without [[control-pillar]] is ungoverned capability.

## Dimensions

**[[business-value-tiers]] (V1-V4)**: why you would accept any risk at all. Without business value, there is nothing to discuss.

**Reliability**: not a single number but a percentage with an error margin. An agent's failure space is open-ended (unlike a deterministic workflow), so confidence intervals matter more for agents than for any other software. Reliability determines how much autonomy an agent can safely earn.

**[[blast-radius]] (B1-B5)**: worst-case impact of failure. Fixed by use case, not engineering. Sets the governance threshold.

**[[autonomy-levels]] (A1-A5)**: how much independence the agent has earned. The dependent variable — falls out of reliability, blast radius, and [[infrastructure-levels]].

**Durability**: build on what stays stable. Three durable investments: workflow logic (business rules that persist regardless of model), context infrastructure (appreciates with every model upgrade), and evaluation pipelines. One liability: harness debt (scaffolding built for a weaker model that becomes dead weight as the model improves).

## Composability

Workflows, agent loops, and autonomous agents are not exclusive choices — they compose. A customer service system might use a deterministic workflow for routing and compliance checks, an agent loop for understanding the problem, and an autonomous sub-agent for searching knowledge bases and drafting responses. Each layer has a different reliability profile; the composition determines the overall system's governance requirements.

## Connects to

- [[pac-framework]] — one of three interdependent pillars
- [[accountability-pillar]] — Potential without Accountability is reckless adoption
- [[control-pillar]] — Potential without Control produces ungoverned capability
- [[blast-radius]] — sets the governance ceiling within Potential
- [[autonomy-levels]] — the output of the Potential assessment
