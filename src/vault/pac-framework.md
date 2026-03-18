---
title: PAC Framework
tags: [framework, governance, core]
dimension: policy-vs-architecture
---

A governance model for AI agents built around three interdependent pillars: [[potential-pillar]], [[accountability-pillar]], and [[control-pillar]]. Developed by Shane Deconinck, published at trustedagentic.ai.

## How it works

PAC is a forcing function. Organizations tend to approach agent deployment from one angle and miss the others: a team focused on business value ships an agent without mapping the liability chain; a security team locks down permissions so tightly the agent cannot deliver value; a compliance team writes policies with no infrastructure to enforce them.

The framework makes you address all three before something breaks. Each pillar maps specific dimensions and scales:

- [[potential-pillar]]: [[business-value-tiers]] (V1-V4), reliability + [[blast-radius]] (B1-B5), [[autonomy-levels]] (A1-A5), durability
- [[accountability-pillar]]: [[shadow-agents]], [[delegation-chain]], audit trails, liability chains
- [[control-pillar]]: [[infrastructure-levels]] (I1-I5), [[agent-identity]], [[trust-inversion]], cross-org trust

## The interdependencies

The three pillars are not independent. The failure modes of addressing them in isolation:

- **Potential without Accountability**: reckless adoption. You build fast, ship agents, and hit a wall at the first incident when nobody can explain what happened.
- **Accountability without Control**: governance on paper. Policies exist but no infrastructure to enforce them. Agents have admin tokens when policy says scoped credentials.
- **Control without Potential**: infrastructure without mandate. You build sophisticated identity and sandboxing, but the business does not see enough value to fund it.

## The cycle

The PAC Framework is a living practice, not a one-time assessment. [[infrastructure-levels]] constrain [[autonomy-levels]], which determine [[blast-radius]], which sets governance thresholds, which drive infrastructure requirements. Models improve, protocols land, regulations tighten. Progress shifts the landscape.

## Tools

The PAC Agent Profiler (trustedagentic.ai/profiler) applies the framework to specific deployments across six dimensions: [[business-value-tiers]], reliability, [[blast-radius]], [[infrastructure-levels]], governance thresholds, and [[autonomy-levels]]. Autonomy is the dependent variable — the level the agent earns, not the starting point you declare. [Deconinck 2026a]

## Appears in

- **Untangling Autonomy and Risk for AI Agents** (`posts/agent-profiler-reasoning`, 2026-02-26) — full PAC treatment; introduces the six-dimension profiler and the PAC Agent Profiler tool
- **Trusted AI Agents: Why Traditional IAM Breaks Down** (`posts/trust-for-agentic-ai`, 2026-01-24) — PAC framing introduced as governance infrastructure
- **AI Agents and the EU AI Act** (`posts/ai-agents-eu-ai-act`, 2026-01-29) — PAC as a lens for regulatory risk classification
- **AI Agents Need the Inverse of Human Trust** (`posts/agent-trust-inversion`, 2026-02-03) — governance vs reliability distinction, the PAC separation
- **Early Indicators of Agent Use Cases** (`posts/early-indicators-agent-use-cases-anthropic-data`, 2026-02-19) — blast radius and autonomy applied to domain data

## Sources

- [Deconinck 2026a]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026
- PAC Framework documentation: trustedagentic.ai
