---
title: Autonomy Levels
tags: [scale, pac-framework, governance, autonomy]
---

A five-level scale in the [[pac-framework]] measuring how much independence an agent has earned, from suggestion to fully autonomous. Part of the [[potential-pillar]]. Autonomy is the *dependent variable* — it falls out of the other five dimensions, not a starting point you declare.

## The five levels

- **A1 Suggestion**: agent recommends, human decides and acts.
- **A2 Approve**: agent proposes an action, human approves before execution.
- **A3 Oversight**: agent acts, human monitors and can intervene.
- **A4 Delegated**: agent acts independently within defined boundaries, human reviews periodically.
- **A5 Autonomous**: agent acts independently with minimal human involvement.

## How autonomy is earned

Autonomy depends on reliability, [[blast-radius]], and [[infrastructure-levels]]. The relationship is a gate, not a slider:

- A2 (Approve): basic logging and human confirmation flows.
- A3 (Oversight): structured audit trails and monitoring.
- A4 (Delegated): identity verification, scoped authorization, and sandboxing.
- A5 (Autonomous): all of the above plus anomaly detection and automated containment.

No amount of reliability compensates for guardrails you have not built. An A4 agent requires at minimum I4 infrastructure. An A5 agent requires I5. [Deconinck 2026a]

## The complacency trap

Higher autonomy reduces attentiveness — Bainbridge's irony from 1983. The more reliable the agent, the less attentive the human overseer. This is why infrastructure-in-the-loop replaces sustained human vigilance: it does not degrade with automation experience. Covered in depth in `src/chapters/reliability-evaluation.md`.

## Connects to

- [[infrastructure-levels]] — gates each autonomy level; you cannot earn A4 without I4
- [[blast-radius]] — sets the governance ceiling for how much autonomy is acceptable
- [[pac-framework]] — autonomy is the output of the profiler assessment
- [[trust-inversion]] — autonomy without inversion produces security incidents

## Appears in

- **Untangling Autonomy and Risk for AI Agents** (`posts/agent-profiler-reasoning`, 2026-02-26) — A1-A5 scale introduced; autonomy as the dependent variable of the profiler
- **Fitting Agentic AI Components in a Mental Model** (`posts/fitting-agentic-ai-components-in-a-mental-model`, 2026-01-06) — human-in-the-loop as autonomy A2; autonomy framing in the mental model
- **AI Agents and the EU AI Act** (`posts/ai-agents-eu-ai-act`, 2026-01-29) — autonomy level determines regulatory classification
- **Early Indicators of Agent Use Cases** (`posts/early-indicators-agent-use-cases-anthropic-data`, 2026-02-19) — Anthropic data shows autonomy distribution in practice
- **Your Coding Agent Needs a Sandbox** (`posts/docker-sandbox-coding-agents`, 2026-02-07) — sandbox requirements scale with autonomy level

## Sources

- [Deconinck 2026a]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026
