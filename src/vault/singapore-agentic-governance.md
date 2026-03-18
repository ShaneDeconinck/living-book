---
title: Singapore IMDA Agentic AI Governance Framework
tags: [regulation, governance, singapore, agents]
dimension: regulatory-landscape
---

The world's first government-sponsored governance framework designed specifically for AI agents capable of autonomous planning, reasoning, and action. Launched January 22, 2026 by Singapore's Infocomm Media Development Authority (IMDA) at the World Economic Forum.

The EU AI Act classifies and restricts AI systems by risk tier — a framework designed for fixed-purpose systems. Singapore built its framework around agents from the start: it assumes agents are autonomous, multi-step, and capable of reaching use cases not anticipated at deployment.

## Four dimensions

1. **Assess and bound risks upfront**: limit what agents can do by controlling tool access, permissions, operational environments, and action scope. These serve as the primary defense against unintended or harmful actions. This is the [[operational-envelopes]] principle formalized in governance terms.

2. **Make humans meaningfully accountable**: organizational structures must allocate clear responsibilities across the AI lifecycle — developers, deployers, operators, end users. Human oversight mechanisms must effectively override, intercept, or review agentic AI actions, especially for actions with real-world material impact.

3. **Implement technical controls and processes**: baseline testing, access control to whitelisted services, monitoring throughout the agent lifecycle.

4. **Enable end-user responsibility**: users deploying agents bear responsibility for how they configure and use them.

Compliance is voluntary, but organizations remain legally accountable for their agents' behaviors and actions.

## Why this matters

Where the EU AI Act's classification was designed for systems with a fixed use case, Singapore's framework treats the runtime-use-case problem as the starting assumption. This is closer to the actual engineering problem: you do not always know at deployment time what an agent will do, but you can constrain what it is allowed to do.

IMDA describes the framework as a living document, inviting feedback and case studies demonstrating responsible agentic AI deployment.

## Connects to

- [[regulatory-classification-gap]] — Singapore bypasses the EU's classification problem by focusing on bounding agent capability rather than classifying agent risk
- [[operational-envelopes]] — Dimension 1 is operational envelope enforcement formalized in regulation
- [[blast-radius]] — Dimension 1's risk bounding reduces blast radius structurally
- [[autonomy-levels]] — Dimension 2 maps to meaningful oversight at appropriate autonomy levels
- [[shadow-agents]] — Dimension 3's registry of whitelisted services addresses shadow agent discovery
- [[pac-framework]] — Singapore's four dimensions map roughly to PAC: risk bounding (Control), accountability (Accountability), technical controls (Control), user responsibility (Accountability)

## Appears in

- **The Regulatory Landscape** (`chapters/regulatory-landscape.md`) — Singapore section

## Sources

- Singapore IMDA, "Model AI Governance Framework for Agentic AI," January 22, 2026
