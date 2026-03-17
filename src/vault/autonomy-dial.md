---
title: Autonomy Dial
tags: [human-agent, governance, ux, autonomy]
---

A per-task autonomy setting that replaces the per-agent autonomy classification, recognizing that the same agent requires different oversight for different actions.

Distinct from [[autonomy-levels]] (which classifies the agent as a whole). The autonomy dial maps each task type to its own oversight level based on [[blast-radius]]:

- **Observe and Suggest (A1)**: agent recommends, takes no action. Novel tasks, high stakes.
- **Plan and Propose (A2)**: agent creates complete plan, waits for review. Medium stakes.
- **Act with Confirmation (A3)**: one-click confirmation. Routine tasks, bounded blast radius.
- **Act and Report (A4)**: autonomous action, batch summaries. High-volume, low stakes.
- **Full Autonomy (A5)**: infrastructure-enforced boundaries, no per-action reporting. Requires I4+ infrastructure.

Anthropic data (2026): developers integrate AI into 60% of work but fully delegate only 0-20% of tasks. This is not a transitional state — it is the collaboration model that works. Task horizons expanding from minutes to days, with agents completing 20 autonomous actions before human input (doubled in six months).

The dial should be dynamic. An email agent at A4 for internal scheduling, A2 for client-facing communications. A coding agent at A5 for test generation, A2 for production deploys. The mapping between task type and autonomy level is the governance artifact organizations need to maintain.

## Connects to

- [[autonomy-levels]] — the agent-level scale; the dial applies it per-task
- [[blast-radius]] — determines the appropriate dial setting per task
- [[infrastructure-in-the-loop]] — enables A4-A5 settings without depending on human vigilance
- [[complacency-trap]] — the dial is designed to prevent complacency by not over-trusting across all tasks

## Sources

- [Anthropic 2026a]: "Measuring AI Agent Autonomy in Practice," anthropic.com, February 2026
- [Anthropic 2026b]: "2026 Agentic Coding Trends Report," resources.anthropic.com, March 2026
