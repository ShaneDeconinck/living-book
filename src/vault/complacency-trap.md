---
title: Complacency Trap
tags: [reliability, governance, human-oversight, risk]
---

When agents succeed reliably, humans stop watching. Oversight becomes a formality. The rare failure — when it comes — happens unmonitored and causes disproportionate damage.

## The mechanism

Better models make reliability easier. Tasks requiring elaborate scaffolding a year ago now work with a single prompt. As success rates climb toward 99%, the human oversight that caught the 10% failures gets reduced or eliminated. The 1% failure, when it occurs, happens without anyone paying attention — and in an environment optimized for the 99%, structural containment may have also been relaxed.

This is grounded in 40 years of human factors research (see [[ironies-of-automation]]): as automation reliability increases, human vigilance decreases, and when the automation fails the human is less prepared to catch it. Bainbridge named this in 1983. It is structural, not personal.

## The agent version: four specific patterns

**Review fatigue**: human reviewers approve agent outputs faster as confidence builds. The approval becomes a checkbox, not a review. After twenty correct outputs, nobody reviews the twenty-first carefully.

**Accountability diffusion**: code committed under a developer's account looks the same whether a human or an agent wrote it. Three months later, when something breaks, no one knows who understood the decision at the time it was made — and the answer may be: no one.

**Scope creep through success**: reliable agents get handed more responsibility. The [[blast-radius]] increases incrementally. An agent that started at B1 (contained, internal tool) gradually becomes B3 (exposed, customer-facing) without anyone making a deliberate decision to accept that increased risk.

**The 99% problem**: an agent that is right 99% of the time is more dangerous than one that is right 80% of the time. At 80%, humans stay engaged because errors are frequent enough to maintain vigilance. At 99%, errors are rare enough to seem like anomalies. But 1% of a million actions is ten thousand failures.

## Empirical evidence

A Lancet multicentre study (2025) found that clinicians' adenoma detection rate during colonoscopy dropped by 6 percentage points (a 20% relative decrease) after months of routine AI-assisted colonoscopy. The AI made clinicians better on average but degraded their independent capability. This is not a metaphor. It is what happens to any skilled practitioner who delegates the cognitive work of a task to a more reliable system.

Cisco's 2026 State of AI Security: 83% of organizations plan agentic AI deployment; only 29% feel ready to do so securely. A 54-point ambition-readiness gap. The agents are becoming more reliable. The humans governing them are not keeping up.

## Why better governance doesn't follow automatically from better models

Reliability and governance are different problems:
- **Reliability**: does the agent get the right answer?
- **Governance**: when it gets the wrong answer, can you explain what happened, who authorized it, and what the [[blast-radius]] was?

Better models make governance *harder*: the social and organizational pressure to reduce oversight increases with reliability. The infrastructure argument for maintaining oversight gets harder to make as the agent keeps getting things right.

## Connection to autonomy

The [[autonomy-levels]] scale (A1–A5) is partly a function of demonstrated reliability under supervision. The complacency trap is the failure mode of advancing autonomy without maintaining governance infrastructure at the same level. Autonomy is the dependent variable — the level the agent earns, not the level it's declared to have.

An agent should not advance from A2 to A3 because it has been reliable. It should advance because the infrastructure beneath it has matured: structured audit trails, anomaly detection, automatic containment. Reliability is necessary but not sufficient.

## The governance response

The [[pac-framework]] response: oversight that does not depend on sustained human vigilance. [[infrastructure-in-the-loop]] replaces human attention with architectural constraint:
- Authorization checks that run regardless of reliability history
- Anomaly detection that flags statistical deviations (not continuous monitoring)
- Audit trails that record everything whether or not anyone reviews in real time

## Connections

- [[ironies-of-automation]] — the foundational research; complacency trap is the agent manifestation
- [[infrastructure-in-the-loop]] — the architectural response that does not depend on vigilance
- [[autonomy-levels]] — the trap is advancing autonomy faster than infrastructure matures
- [[blast-radius]] — scope creep through success is how blast radius grows without a decision
- [[evaluation-as-governance]] — post-deployment evaluation is what catches the 1% failures; underinvestment is how complacency propagates into governance

## Appears in

- **AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting.** (`posts/ai-agent-scaffolding-trap`, 2026-02-02) — scaffolding deletion as the inflection point; less harness means less oversight
- **AI Agents Need the Inverse of Human Trust** (`posts/agent-trust-inversion`, 2026-02-03) — reliability doesn't solve governance; complacency as the reliability-governance gap
- **OpenClaw and Moltbook** (`posts/openclaw-moltbook-trust-fear-ai`, 2026-02-17) — users who trusted blindly despite creator warnings; AI literacy failure
- **Untangling Autonomy and Risk for AI Agents** (`posts/agent-profiler-reasoning`, 2026-02-26) — complacency as the reason autonomy must be earned through infrastructure, not declared

## Sources

- Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," shanedeconinck.be, February 2026
- Lisanne Bainbridge, "Ironies of Automation," *Automatica* 19(6), 775–779 (1983)
- Budzyń et al., "Endoscopist deskilling risk after exposure to artificial intelligence in colonoscopy," *The Lancet Gastroenterology & Hepatology* (August 2025 / October 2025 print). 6 percentage point drop, 20% relative decrease in independent adenoma detection.
- Cisco, "State of AI Security 2026." 83% plan / 29% ready.
- Anthropic, "Measuring AI Agent Autonomy in Practice," February 2026. 73% of agent tool calls involve human oversight of some form.
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#reliability-is-getting-easier-governance-is-not)
- Chapter: [Reliability, Evaluation, and the Complacency Trap](../chapters/reliability-evaluation.md)
