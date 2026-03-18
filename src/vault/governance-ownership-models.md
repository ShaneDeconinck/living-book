---
title: Governance Ownership Models
tags: [governance, accountability, organizational-design, shadow-agents]
---

Three organizational models for owning agent governance, each with different applicability conditions. The models form a progression: centralized works at low agent counts, breaks at scale; federated scales better but requires mature teams; infrastructure-enforced is the target state where governance lives in the architecture, not the org chart.

The ownership question itself is part of the [[accountability-pillar]]: "Who owns AI governance? If no one owns it, everyone assumes someone else does."

## The three models

**Centralized AI governance office.** A dedicated team owns agent registration, risk classification, and compliance review for all agents across the organization. Provides consistency. Creates a bottleneck. Works for organizations with fewer than ~50 agents. Breaks down when agent deployment velocity exceeds the team's review capacity — which, given that low-code platforms let employees build agents in minutes, happens quickly.

**Federated governance with central standards.** Business units own their agents and their risk assessments. A central team sets standards, provides tooling, and audits compliance. Registration is self-service with automated classification; risk tiers determine whether central review is required. Scales better than centralized but requires mature teams who understand how to apply the standards correctly. Fails when teams lack the expertise to classify blast radius accurately.

**Infrastructure-enforced governance.** Governance is in the infrastructure, not the org chart. [[agent-registry]] enforces registration. [[mcp-gateway|Agent gateways]] enforce permissions. Audit logging enforces traceability. Anomaly detection enforces behavioral boundaries. Humans set policies; infrastructure enforces them. This is Shane's framing: "Are your agents contained by architecture, or only by policy?" [Deconinck 2026 Boardroom]

The first two models are transition steps toward the third.

## Why the progression matters

The centralized model's failure mode is predictable: as agent deployment velocity increases (Gartner predicts 40% of enterprise applications will feature task-specific agents by end of 2026, up from under 5% in 2025), governance reviews become a bottleneck. Shadow agents emerge not from malice but from the gap between what employees need to get done and what the approved process can deliver in time.

The federated model's failure mode is classification error: teams without deep PAC Framework knowledge will consistently underestimate blast radius, and the shadow agent governance chapter's audit data confirms this — 82% of executives feel confident their policies protect against unauthorized agent actions, while only 28% can trace agent actions to a human sponsor. [Gravitee 2026, CSA/Strata 2026] Confidence and capability diverge when classification responsibility is distributed.

The infrastructure-enforced model's advantage is that it removes the human-speed bottleneck entirely for low-risk agents (B1-B2 on the [[blast-radius]] scale). An agent gateway that checks registration status automatically does not have calendar constraints. This is not automation for its own sake — it is the only governance architecture that can match agent deployment velocity.

## The asymmetry problem

Traditional governance processes (vendor assessments, security reviews, compliance approvals) operate on human timescales: weeks to months. Agent deployment operates on minutes. Any governance model that requires human review for every deployment will generate shadow agents as a structural byproduct.

The resolution: human review reserved for B4-B5 blast radius deployments where the stakes justify the delay. Automated infrastructure-enforced governance for everything below that threshold.

This is also the argument for the [[amnesty-model]] transition pattern — amnesty works only if the governed path after amnesty is genuinely faster than the shadow path. If registration requires a three-week security review, amnesty registration will be minimal and enforcement will drive agents underground rather than into governance.

## Connects to

- [[agent-registry]] — the central infrastructure piece; the registration mechanism that each model depends on at different levels of enforcement
- [[guardian-agents]] — the runtime enforcement category that makes infrastructure-enforced governance possible
- [[amnesty-model]] — the transition pattern into infrastructure-enforced governance; the amnesty model requires the governed path to be faster than the shadow path, which only holds at the infrastructure-enforced model
- [[blast-radius]] — the classification tool that determines which agents require human review vs. automated registration
- [[infrastructure-levels]] — the maturity mapping (I1 = no registry, I5 = unregistered agents structurally unable to operate) corresponds to the progression through governance ownership models
- [[shadow-agents]] — the governance gap these models exist to close
- [[fleet-governance]] — at scale, infrastructure-enforced governance is the prerequisite for fleet oversight

## Sources

- [Deconinck 2026 Boardroom]: Shane Deconinck, "Agentic AI: Curated Questions for the Boardroom," February 8, 2026
- [Gravitee 2026]: Gravitee, "State of AI Agent Security 2026," February 2026
- [CSA/Strata 2026]: Cloud Security Alliance and Strata Identity, "Securing Autonomous AI Agents," February 5, 2026
- Chapter: [Shadow Agent Governance](../chapters/shadow-agent-governance.md#who-owns-agent-governance)
