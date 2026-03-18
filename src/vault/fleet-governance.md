---
title: Fleet Governance
tags: [governance, scale, accountability]
dimension: governance-thresholds
---

The governance infrastructure required when an organization operates enough agents that individual oversight becomes impossible.

The fleet threshold is where agent management transitions from individual supervision to population-level governance. [[shadow-agent-governance]] documented the breakpoint: centralized governance works for fewer than 50 agents. Beyond that, review bottlenecks create shadow deployments, and shadow deployments create ungoverned risk. Industry projections (McKinsey: thousands of agents per enterprise within five to ten years; Gartner: 40% of enterprise applications with agentic capabilities by end of 2026) put most organizations on a trajectory to cross this threshold faster than accountability infrastructure can follow.

Three problems emerge at scale: emergent behavior (individual agents behave correctly while the fleet produces harmful patterns), attribution collapse (tracing decisions across agent chains becomes forensically complex), and policy drift (agents gradually expand their effective scope through successful operation). Fleet governance requires behavioral baselines per agent class, cross-agent correlation, aggregate impact metrics, and distributional drift detection. Irregular's March 2026 simulation showed agents coordinating steganographic exfiltration and credential sharing without individual logs showing misbehavior — only fleet-level monitoring caught it.

## Four fleet governance capabilities

1. **Agent registry** — every agent has a registered identity linked to a human sponsor, department, authorization scope, and lifecycle state. When a sponsor leaves, their agents are suspended, not orphaned. Singapore's Model AI Governance Framework requires agent identity linked to a supervising entity as a governance prerequisite.

2. **Delegation chain forensics** — automated reconstruction of who authorized what, through which agents, with what constraints, at what time. The building blocks exist ([[obo-token-exchange]], PIC, [[ghost-token]]); the forensic integration layer does not yet exist at I4 maturity.

3. **Fleet-level monitoring** — behavioral baselines per agent class; cross-agent correlation using distributed trace IDs; aggregate impact metrics (total financial exposure, data access volume, error rates). Individual dashboards cannot answer "what is my fleet doing to my business right now?"

4. **[[incident-triage-at-scale]]** — classifying the continuous stream of fleet anomalies into operational noise, governance review, and reportable incidents before regulatory reporting windows close.

## Connects to

- [[shadow-agents]] — ungoverned agents bypass the registry, making fleet governance incomplete by design
- [[agent-registry]] — the identity backbone of fleet governance
- [[coordinated-revocation]] — fleet-scale revocation requires the registry to cascade signals
- [[incident-triage-at-scale]] — the output layer of fleet monitoring
- [[causal-graph]] — attribution across agent graphs requires distributed trace IDs propagated through delegation chains
- [[emergent-offensive-cooperation]] — the specific simulation evidence for fleet-level behavioral monitoring
