---
title: Singapore IMDA Agentic AI Governance Framework
tags: [regulation, governance, agents, singapore]
---

The world's first government-sponsored governance framework designed specifically for AI agents capable of autonomous planning, reasoning, and action. Launched January 22, 2026, by Singapore's Infocomm Media Development Authority (IMDA) at the World Economic Forum.

Unlike the EU AI Act (which regulates AI broadly and mentions agents only by implication), Singapore built its framework around agents from the start. Four governance dimensions:

1. **Assessing and bounding risks upfront**: limit what agents can do by controlling tool access, permissions, operational environments, and action scope. Primary defense against unintended actions.
2. **Making humans meaningfully accountable**: clear organizational responsibilities across the AI lifecycle (developers, deployers, operators, end users). Human oversight must effectively override, intercept, or review agent actions with real-world material impact.
3. **Implementing technical controls and processes**: baseline testing, access control to whitelisted services, monitoring throughout the agent lifecycle.
4. **Enabling end-user responsibility**: users deploying agents bear responsibility for configuration and use.

Compliance is voluntary, but organizations remain legally accountable for their agents' behaviors and actions. IMDA describes it as a living document.

## Why it matters

Singapore starts from the right premise: agents are different from traditional AI systems. The EU AI Act's risk classification was designed for fixed-purpose systems. Singapore's framework assumes agents are autonomous, multi-step, and capable of reaching use cases not anticipated at deployment — the [[regulatory-classification-gap]] that the EU is still working through.

## Connects to

- [[regulatory-classification-gap]] — Singapore acknowledges agents defy static classification; the EU is still catching up
- [[pac-framework]] — Singapore's four dimensions map to PAC: bounding risks (Control), human accountability (Accountability), technical controls (Control), end-user responsibility (Accountability)
- [[shadow-agents]] — Singapore's framework implies agent registration and discovery as prerequisites for governance
- [[operational-envelopes]] — "bounding risks upfront" through tool access and scope constraints is the same principle

## Sources

- [IMDA 2026]: Singapore IMDA, "Model AI Governance Framework for Agentic AI," January 22, 2026
- Chapter: [The Regulatory Landscape](../chapters/regulatory-landscape.md)
