---
title: PAC Agent Profiler
tags: [tool, pac-framework, governance, deployment, autonomy]
dimension: autonomy
---

A deployment decision model built from the [[pac-framework]] and Anthropic's empirical data on agent autonomy. Structures the deployment decision across six dimensions: five independent inputs (business value, reliability, [[blast-radius]], [[infrastructure-levels|infrastructure]], governance thresholds) and one dependent output ([[autonomy-levels|autonomy]]).

## The key insight

Autonomy is not a starting assumption. It is the level the agent earns based on everything else. You do not decide an agent should be autonomous and then figure out the guardrails. You assess the other five dimensions and the appropriate autonomy level follows.

## Infrastructure as a gate

Infrastructure requirements are binary per autonomy level. Each level requires specific capabilities. If you have not built them, that level is locked regardless of how reliable the agent is. No amount of reliability compensates for guardrails you have not built.

The requirements are cumulative: A2 needs basic logging. A3 needs structured audit trails. A4 needs identity verification, scoped authorization, sandboxing. A5 needs all of the above plus anomaly detection and automated containment.

## Autonomy changes over time

The profiler is not a one-time classification. As infrastructure is built, reliability improves, or governance thresholds shift, the same agent can earn a higher (or lower) autonomy level. Anthropic's data shows this in practice: new Claude Code users auto-approve ~20% of sessions; after ~750 sessions, that climbs past 40%.

## Connects to

- [[pac-framework]] — the profiler operationalizes PAC for deployment decisions
- [[autonomy-levels]] — the dependent variable the profiler produces
- [[blast-radius]] — fixed by use case, not engineering; a deployment filter
- [[infrastructure-levels]] — gates each autonomy level
- [[infrastructure-in-the-loop]] — the structural mechanism that makes higher autonomy safe

## Sources

- Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026
- Anthropic, "Measuring AI Agent Autonomy in Practice," February 2026
- src/drafts/agent-deployment-decisions.md
