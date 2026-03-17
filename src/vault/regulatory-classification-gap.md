---
title: Regulatory Classification Gap
tags: [regulation, eu-ai-act, governance]
---

The structural problem that agent risk classification cannot be fixed at deployment time because agents are general-purpose and their actual use cases emerge at runtime.

An office assistant told to "handle my inbox" might draft emails (minimal risk), screen job applications (high-risk under [[eu-ai-act]]), and assess customer complaints (potentially high-risk). The risk tier depends on the prompt, not the tool. The EU AI Act requires risk classification, but agents make this impossible without architectural constraints. Organizations must either constrain agents to prevent high-risk use cases or classify them as high-risk by default. This connects to [[shadow-agents]]: ungoverned agents are unclassified agents, which are regulatory exposure.
