---
title: CSA Agentic Trust Framework (ATF)
tags: [governance, standard, zero-trust, agents]
---

An open governance specification from the Cloud Security Alliance applying Zero Trust principles to AI agents: "No AI agent should be trusted by default, regardless of purpose or claimed capability."

Published February 2026 under Creative Commons. Organized around five governance elements, each answering a question:

1. **Identity** ("Who are you?"): authentication, authorization, session management
2. **Behavior** ("What are you doing?"): [[observability-stack]], anomaly detection, intent analysis
3. **Data Governance** ("What are you consuming/producing?"): input validation, PII protection, output governance
4. **Segmentation** ("Where can you go?"): access controls, resource boundaries, policy enforcement
5. **Incident Response** ("What if you go rogue?"): circuit breakers, kill switches, [[coordinated-revocation]]

The **progressive autonomy model** requires agents to pass five gates (accuracy, security audits, measurable impact, clean operational history, explicit stakeholder approval) before advancing to the next [[autonomy-levels]] tier. This mirrors the infrastructure-as-gate principle from the [[pac-framework]]: you either have the infrastructure to support a given autonomy level, or you do not.

ATF aligns with the [[owasp-agentic-top10]] and CoSAI recommendations. Designed for implementation with existing open-source tools.

## Connects to

- [[pac-framework]] — ATF's five elements map to PAC's three pillars (Identity → Accountability, Behavior → Control, Segmentation → Control, IR → Control)
- [[autonomy-levels]] — progressive autonomy model gates advancement on demonstrated trustworthiness
- [[observability-stack]] — ATF's Behavior element requires the observability infrastructure the five-layer stack describes
- [[agent-incident-response]] — ATF's IR element specifies circuit breakers and kill switches
- [[infrastructure-levels]] — ATF's progressive gates are another expression of infrastructure-as-prerequisite

## Sources

- [CSA 2026]: Cloud Security Alliance, "The Agentic Trust Framework: Zero Trust Governance for AI Agents," February 2, 2026. github.com/CSA-AI/ATF
- Chapter: [The Regulatory Landscape](../chapters/regulatory-landscape.md)
