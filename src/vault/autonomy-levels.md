---
title: Autonomy Levels
tags: [scale, pac-framework, governance, autonomy]
---

A five-level scale in the [[pac-framework]] measuring how much independence an agent has earned, from suggestion to fully autonomous. Part of the [[potential-pillar]]. Autonomy is the *dependent variable* — it falls out of the other five dimensions, not a starting point you declare.

## The five levels

The chapter on human-agent collaboration names the levels as they operate in practice:

- **A1 Observe and Suggest**: agent analyzes and recommends, takes no action.
- **A2 Plan and Propose**: agent creates a complete plan and waits for review before execution.
- **A3 Act with Confirmation**: agent prepares the action and presents a one-click confirmation. Human checks, doesn't deeply review.
- **A4 Act and Report**: agent acts autonomously and reports what it did. Human reviews selectively via batch summaries or exception reports.
- **A5 Full Autonomy**: agent acts within defined boundaries with no per-action reporting. Governance is infrastructure-enforced.

## How autonomy is earned

Autonomy depends on reliability, [[blast-radius]], and [[infrastructure-levels]]. The relationship is a gate, not a slider:

- A2: basic logging and human confirmation flows.
- A3: structured audit trails and monitoring.
- A4: identity verification, scoped authorization, and sandboxing.
- A5: all of the above plus anomaly detection and automated containment.

No amount of reliability compensates for guardrails you have not built. An A4 agent requires at minimum I4 infrastructure. An A5 agent requires I5. [Deconinck 2026a]

## The autonomy dial: task-specific settings

A key insight from production deployments: the right autonomy level is task-specific, not agent-specific. The same agent, operating under the same identity, requires different oversight for different actions. You trust your assistant to schedule meetings (A4) but not to send emails to clients on your behalf (A2).

Evidence: Anthropic's Coding Trends Report shows developers integrate AI into 60% of their work but fully delegate only 0-20% of tasks. The remaining 40-80% involves active supervision, validation, and human judgment — developers adjust the autonomy level per task, granting full delegation for routine implementation while maintaining close oversight for architectural decisions. [Anthropic-coding-2026]

Mapping autonomy to task properties:
- **B1 (contained) actions**: per-session authorization with containment infrastructure → A4-A5
- **B2-B3 (recoverable/exposed) actions**: per-task authorization → A3-A4
- **B4-B5 (regulated/irreversible) actions**: per-tool-call authorization → A1-A2

The dial should be set per task type and reviewed as reliability is demonstrated. An email agent might operate at A4 for internal scheduling but A2 for client-facing communications. A coding agent at A5 for test generation but A2 for production deployments.

Task horizons are expanding: Anthropic reports coding agents now complete 20 actions autonomously before requiring human input, double what was possible six months earlier. Organizations that succeed expand autonomy incrementally, matching each increase to demonstrated reliability at the current blast radius.

## The complacency trap

Higher autonomy reduces attentiveness — Bainbridge's irony from 1983. The more reliable the agent, the less attentive the human overseer. New users of Claude Code fully auto-approve about 20% of sessions; after ~750 sessions, that number climbs past 40%. This is rational behavior, not recklessness — the cost of reviewing every action exceeds the benefit of catching rare errors. This is why [[infrastructure-in-the-loop]] replaces sustained human vigilance: it does not degrade with automation experience. Covered in depth in `src/chapters/reliability-evaluation.md`.

## Connects to

- [[infrastructure-levels]] — gates each autonomy level; you cannot earn A4 without I4
- [[blast-radius]] — sets the governance ceiling for how much autonomy is acceptable
- [[pac-framework]] — autonomy is the output of the profiler assessment
- [[trust-inversion]] — autonomy without inversion produces security incidents
- [[infrastructure-in-the-loop]] — the structural complement that makes high autonomy safe
- [[self-aware-agent]] — agent uncertainty signals should factor into dial settings

## Appears in

- **Untangling Autonomy and Risk for AI Agents** (`posts/agent-profiler-reasoning`, 2026-02-26) — A1-A5 scale introduced; autonomy as the dependent variable of the profiler
- **Fitting Agentic AI Components in a Mental Model** (`posts/fitting-agentic-ai-components-in-a-mental-model`, 2026-01-06) — human-in-the-loop as autonomy A2; autonomy framing in the mental model
- **AI Agents and the EU AI Act** (`posts/ai-agents-eu-ai-act`, 2026-01-29) — autonomy level determines regulatory classification
- **Early Indicators of Agent Use Cases** (`posts/early-indicators-agent-use-cases-anthropic-data`, 2026-02-19) — Anthropic data shows autonomy distribution in practice
- **Your Coding Agent Needs a Sandbox** (`posts/docker-sandbox-coding-agents`, 2026-02-07) — sandbox requirements scale with autonomy level

## Sources

- [Deconinck 2026a]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026
- [Anthropic-coding-2026]: Anthropic, "2026 Agentic Coding Trends Report," March 2026
- [Anthropic-autonomy-2026]: Anthropic, "Measuring AI Agent Autonomy in Practice," February 2026
