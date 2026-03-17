---
title: Regulatory Classification Gap
tags: [regulation, eu-ai-act, governance]
---

The structural problem that agent risk classification cannot be fixed at deployment time because agents are general-purpose and their actual use cases emerge at runtime.

An office assistant told to "handle my inbox" might draft emails (minimal risk), screen job applications (high-risk under the EU AI Act), and assess customer complaints (potentially high-risk). The risk tier depends on the prompt, not the tool. The EU AI Act requires risk classification, but agents make this impossible without architectural constraints. Organizations must either constrain agents to prevent high-risk use cases or classify them as high-risk by default. This connects to [[shadow-agents]]: ungoverned agents are unclassified agents, which are regulatory exposure.

## Connects to

- [[shadow-agents]] — ungoverned agents are also unclassified agents
- [[blast-radius]] — blast radius is the practical proxy for regulatory risk tier
- [[operational-envelopes]] — constraining agents to specific use cases solves the classification problem
- [[pac-framework]] — the Accountability pillar addresses classification at deployment
- [[singapore-agentic-governance]] — Singapore bypasses the problem by bounding capability rather than classifying use case
- [[csa-agentic-trust-framework]] — ATF's behavioral gates are an answer to the classification problem: classify by demonstrated behavior
- [[article-73-multi-agent-gap]] — the accountability version of the same problem: emergent multi-agent incidents that no single party owns

## Appears in

- **AI Agents and the EU AI Act: Risk That Won't Sit Still** (`posts/ai-agents-eu-ai-act`, 2026-01-29) — central thesis; full analysis of how agent dynamism breaks EU AI Act risk classification

## Sources

- Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," shanedeconinck.be, January 29, 2026
- EU AI Act: artificialintelligenceact.eu
