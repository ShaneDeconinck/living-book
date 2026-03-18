---
title: Agentic UX Patterns
tags: [ux, governance, human-agent, oversight]
dimension: governance-thresholds
---

Design patterns for interfaces between humans and agents that make oversight effective rather than theatrical. From Smashing Magazine's taxonomy [Smashing-2026] and UX Magazine research [UX-Magazine-2025].

## Why interface design is governance

The interface between human and agent determines whether oversight is real or performative. Explainable rationale, scope indicators, undo capability, and escalation pathways are not polish: they are governance infrastructure. A well-designed interface with a capable model outperforms a frontier model with a poor interface.

## Pre-action patterns

**Step visibility**: show the agent's plan before execution — not just "I will do X" but the reasoning chain: what it observed, what it concluded, what it plans to do and why. Creates an auditable artifact for selective review. The direct response to interpretive divergence in the [[controllability-trap]].

**Confidence signals**: surface the agent's uncertainty as a behavioral signal — slowing down, asking questions, presenting alternatives — rather than a probability score (which humans interpret poorly). Connects to the self-aware agent pattern: agents that initiate clarification more often than humans interrupt (16.4% vs 7.1% of turns in Anthropic's autonomy research).

**Scope indicators**: show what the agent can and cannot do in the current context. Makes [[infrastructure-levels]] boundaries visible to the human, not just enforced by infrastructure. A financial agent displays its spending limit, authorized payees, and transaction types before proposing actions.

## In-action patterns

**Explainable rationale**: concise justification for each action ("Rescheduled the meeting because two attendees have conflicts at the original time"). Lets the human build a mental model without watching every step. Distinct from chain-of-thought dumps.

**Progressive disclosure**: default to minimal information with drill-down capability. "Processed 47 tickets, escalated 3" is more useful than 47 individual notifications. The 3 escalations get full detail; the 44 routine completions get a line item.

**Interruption points**: structured pauses — end-of-batch summaries, periodic status reports, threshold-triggered alerts. Pull-based (human reviews when convenient) rather than push-based (responding to each notification). Avoids the HITL bottleneck without sacrificing oversight.

## Post-action patterns

**Action audit and undo**: every action reversible where possible, reversal as easy as original action. Changes the risk calculus: knowing the undo function exists enables higher [[autonomy-levels]] grants. Safety net that enables trust.

**Escalation pathways**: clear path to human expertise when the agent encounters its limits. Not a failure — a feature. An agent that knows when to stop is more trustworthy than one that always produces an answer. Requires full context transfer so the human does not start from scratch.

**Batch review interfaces**: for high-volume agents, the audit interface matters more than the action interface. Summarize actions into a glanceable view, highlight outliers, enable spot-checking by exception. Makes review efficient enough to actually happen rather than theoretically required but practically skipped.

## Connection to oversight models

These patterns operationalize the three oversight models:
- **HITL**: pre-action patterns (step visibility, confidence signals) — shows intent before execution
- **HOTL**: in-action patterns (progressive disclosure, interruption points) — enables monitoring without overwhelm
- **[[infrastructure-in-the-loop]]**: post-action patterns (undo, batch review) — supports recovery and accountability for infrastructure-governed actions

Higher autonomy dial settings require stronger post-action patterns. Lower settings require stronger pre-action patterns.

## Connects to

- [[infrastructure-in-the-loop]] — patterns operationalize each oversight model
- [[autonomy-levels]] — pre/post/in-action balance shifts with dial setting
- [[paradox-of-supervision]] — batch review interfaces designed for substantive review, not just completion
- [[controllability-trap]] — step visibility responds to interpretive divergence; escalation pathways to belief resistance
- [[self-aware-agent]] — confidence signals surface the agent's uncertainty externally; escalation pathways are the action channel for agent-initiated oversight
- [[permission-intersection]] — scope indicators make audience-side authorization visible

## Sources

- [Smashing-2026]: Smashing Magazine, "Designing For Agentic AI: Practical UX Patterns For Control, Consent, And Accountability," smashingmagazine.com, February 2026
- [UX-Magazine-2025]: UX Magazine, "Secrets of Agentic UX: Emerging Design Patterns for Human Interaction with AI Agents," uxmag.com, April 2025
