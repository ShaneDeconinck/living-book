---
title: Complacency Trap
tags: [reliability, governance, human-oversight, risk]
---

When agents succeed reliably, humans stop watching. Oversight becomes a formality. The rare failure — when it comes — happens unmonitored and causes disproportionate damage.

## The mechanism

Better models make reliability easier. Tasks requiring elaborate scaffolding a year ago now work with a single prompt. As success rates climb toward 99%, the human oversight that caught the 10% failures gets reduced or eliminated. The 1% failure, when it occurs, happens without anyone paying attention — and in an environment optimized for the 99%, structural containment may have also been relaxed.

Shane names this pattern directly. It is grounded in 40 years of human factors research: as automation reliability increases, human vigilance decreases, and when the automation fails the human is less prepared to catch it.

## Why better governance doesn't follow automatically from better models

Reliability and governance are different problems:
- **Reliability:** does the agent get the right answer?
- **Governance:** when it gets the wrong answer, can you explain what happened, who authorized it, and what the [[blast-radius]] was?

Better models actually make governance *harder*: the social and organizational pressure to reduce oversight increases with reliability. The infrastructure argument for maintaining oversight gets harder to make.

## Connection to autonomy

The [[autonomy-levels]] scale (A1-A5) is partly a function of demonstrated reliability under supervision. The complacency trap is the failure mode of advancing autonomy without maintaining governance infrastructure at the same level. Autonomy is the dependent variable — the level the agent earns, not the level it's declared to have.

## Human-agent collaboration design

The [[pac-framework]] response: oversight that does not depend on sustained human vigilance. The [Human-Agent Collaboration Patterns](../chapters/human-agent-collaboration.md) chapter covers the three oversight models and why the autonomy dial must be managed structurally, not through attention.

## Appears in

- **AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting.** (`posts/ai-agent-scaffolding-trap`, 2026-02-02) — scaffolding deletion as the inflection point; less harness means less oversight
- **AI Agents Need the Inverse of Human Trust** (`posts/agent-trust-inversion`, 2026-02-03) — reliability doesn't solve governance; complacency as the reliability-governance gap
- **OpenClaw and Moltbook** (`posts/openclaw-moltbook-trust-fear-ai`, 2026-02-17) — users who trusted blindly despite creator warnings; AI literacy failure
- **Untangling Autonomy and Risk for AI Agents** (`posts/agent-profiler-reasoning`, 2026-02-26) — complacency as the reason autonomy must be earned through infrastructure, not declared

## Sources

- Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," shanedeconinck.be, February 2026
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#reliability-is-getting-easier-governance-is-not)
- Chapter: [Reliability, Evaluation, and the Complacency Trap](../chapters/reliability-evaluation.md)
