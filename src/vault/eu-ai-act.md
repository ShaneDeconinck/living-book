---
title: EU AI Act
tags: [regulation, governance, compliance, eu]
---

The world's first comprehensive AI regulation, classifying AI systems by risk tier and imposing obligations that scale with that risk — entered into force August 2024, with key provisions rolling out through 2027.

## Risk Tiers

Four tiers, each with different obligations:

- **Prohibited** (in effect February 2025): social scoring, subliminal manipulation, real-time biometric surveillance, emotion recognition in workplaces/schools. Banned outright.
- **High-risk** (obligations from August 2, 2026): AI systems impacting safety or fundamental rights. Annex III lists the categories: employment, education, credit scoring, law enforcement, critical infrastructure, biometrics, migration.
- **Limited risk**: chatbots, deepfakes, emotion recognition systems. Transparency obligations — users must know they are interacting with AI.
- **Minimal risk**: everything else. No obligations.

The Act is extraterritorial. If your AI system's output is used in the EU, you are in scope, regardless of where you are based.

## Key Articles

**Article 4 (AI Literacy)** — in effect since February 2025. Organizations must ensure adequate AI literacy among staff and contractors who operate AI systems. This creates organizational liability for [[shadow-agents]]: if an employee deploys an unregistered high-risk agent, the company is non-compliant today.

**Article 9 (Risk Management)** — not a one-time assessment. Continuous risk identification and mitigation throughout the system lifecycle.

**Article 12 (Record-Keeping and Traceability)** — automatic logging of events relevant to identifying risks. For agents: logging which instance acted, under whose delegation, with what constraints applied.

**Article 14 (Human Oversight by Design)** — the system must allow deployers to implement meaningful oversight, not just monitoring. Override mechanisms must be part of the agent's runtime architecture. A human reviewing a dashboard is not meaningful oversight if they cannot intervene.

**Article 73 (Incident Reporting)** — tiered by severity:
- Widespread or critical infrastructure disruptions: report within 2 days
- Incidents resulting in death: report within 10 days
- Other serious incidents: report within 15 days

Article 73 has a structural gap: it assumes single-agent, single-occurrence failures. When incidents arise from multi-agent interaction, there is no mechanism to attribute accountability across the chain. [See [[cascading-failure]] and agent-incident-response chapter.]

**Article 99 (Penalties)**: prohibited practices → €35M or 7% global turnover; high-risk non-compliance → €15M or 3%; incorrect information to authorities → €7.5M or 1%. SMEs and startups: "whichever is lower" applies.

## Provider, Distributor, Deployer

The Act distinguishes three roles:
- **Provider**: builds or substantially modifies an AI system
- **Distributor**: makes it available without substantial modification
- **Deployer**: uses it under their own authority

For most agent builders using commercial LLMs, the GPAI (General Purpose AI) provider obligations sit with the model provider. RAG, prompt engineering, orchestration, and tool-calling do not trigger provider obligations — they make you a deployer, not a provider.

## The Classification Problem for Agents

The Act regulates use cases, not technology. It does not mention agents specifically. This creates the [[regulatory-classification-gap]]: agents are general-purpose, and their risk tier depends on the prompt, not the tool. An office assistant told to "handle my inbox" might draft emails (minimal risk) or screen job applications (high-risk, Annex III). You cannot classify an agent whose use case emerges at runtime.

The Future Society's "multi-purpose problem": generic agents default to high-risk classification unless high-risk use cases are architecturally excluded.

## Timeline Uncertainty

The Digital Omnibus proposal (European Commission, November 2025) would defer high-risk obligations for Annex III systems until compliance support measures are confirmed available — backstop date December 2, 2027, sixteen months later than the original August 2026 date. The Omnibus is a legislative proposal, not yet adopted. Organizations face a planning dilemma between the two dates.

The infrastructure requirements (risk management, traceability, human oversight) do not change with the timeline. Only the enforcement date moves.

## PAC Mapping

The PAC Framework's infrastructure levels map directly to regulatory readiness:
- I1 (Open): non-compliant for any high-risk use
- I2 (Logged): partial Article 12 compliance; agent identity unverified
- I3 (Verified): satisfies Articles 12 and 14; the minimum for high-risk agents
- I4 (Authorized): fine-grained authorization; satisfies ISO 42001
- I5 (Contained): cross-organizational trust; full compliance across jurisdictions

## Connects To

- [[regulatory-classification-gap]] — the multi-purpose problem: agents cannot be classified at deployment time
- [[shadow-agents]] — Article 4 compliance requires knowing what agents exist
- [[infrastructure-levels]] — I1-I5 map to regulatory readiness
- [[cascading-failure]] — Article 73's multi-agent incident gap
- [[blast-radius]] — B4 (Regulated) and B5 (Irreversible) systems almost certainly trigger high-risk classification
- [[delegation-chain]] — Article 12 traceability requires capturing delegation chains
- [[singapore-agentic-framework]] — Singapore's agent-native alternative, voluntary but instructive

## Appears In

- **The Regulatory Landscape** (`chapters/regulatory-landscape.md`) — EU AI Act section, compliance example, PAC mapping table
- **Shadow Agent Governance** (`chapters/shadow-agent-governance.md`) — Article 4 connection
- **Agent Incident Response** (`chapters/agent-incident-response.md`) — Article 73 timelines

## Sources

- EU AI Act: artificialintelligenceact.eu
- Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," shanedeconinck.be, January 29, 2026
- The Future Society, "Ahead of the Curve: Governing AI Agents Under the EU AI Act"
- Digital Omnibus: Sidley Austin, "EU Digital Omnibus," December 2025
