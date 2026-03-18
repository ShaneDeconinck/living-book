---
title: Article 73 Multi-Agent Incident Gap
tags: [regulation, eu-ai-act, multi-agent, governance, accountability]
dimension: regulatory-landscape
---

Article 73 of the EU AI Act requires providers of high-risk AI systems to report serious incidents to market surveillance authorities. The timelines are tight: 15 calendar days for serious incidents, 2 days for widespread or critical infrastructure disruptions, 10 days for incidents resulting in death.

But Article 73 has a structural blind spot: it assumes single-agent, single-occurrence failures. When an incident results from the interaction of multiple AI systems, the framework provides no mechanism to attribute accountability across the chain.

## The structural problem

Multi-agent incidents often involve emergent behavior that no single provider caused or could have predicted. The algorithmic collusion pattern illustrates this: fuel prices rose in coordinated patterns without explicit coordination — the harm emerged from interaction, not from any individual system acting incorrectly. Cascading failures compound across agent chains, with performance drops of up to 23.7% in multi-agent systems, depending on architecture.

Three specific gaps in the current framework:
1. **No multi-party attribution mechanism**: when agent A's output becomes agent B's input becomes a harmful outcome, who reports? Under what timeline?
2. **No cumulative/systemic harm coverage**: the framework addresses single incidents, not patterns that only become visible across a fleet or over time.
3. **No third-party reporting channel**: users, civil society, and researchers who detect multi-agent harms have no formal reporting mechanism.

## Practical implication for builders

The regulatory gap will close. The Commission's guidelines (required by February 2, 2026) do not yet address multi-agent attribution, but the incidents that will force the issue are already happening. For organizations building multi-agent systems, the practical requirement is clear: build multi-agent traceability infrastructure now, before reporting obligations require it.

Concretely: an incident response workflow must be able to identify which agent acted, under whose authority, and through which delegation chain, within Article 73's tight reporting windows. That requires [[delegation-chain-forensics]] to be operational before the incident, not assembled after.

## Connects to

- [[agent-incident-response]] — the IR framework that must work within these reporting windows
- [[delegation-chain-forensics]] — the technical capability needed to produce multi-agent attribution
- [[cascading-failure]] — the failure mode that Article 73 does not yet cover
- [[fleet-behavioral-aggregation]] — fleet-level patterns that represent cumulative harm invisible to per-agent reporting
- [[liability-chain]] — cross-organization attribution for multi-agent incidents
- [[regulatory-classification-gap]] — Article 73's gap is the accountability version of the classification gap: emergent behavior that no single party owns

## Appears in

- **The Regulatory Landscape** (`chapters/regulatory-landscape.md`) — The Multi-Agent Incident Gap section
- **Multi-Agent Trust and Orchestration** (`chapters/multi-agent-trust.md`) — regulatory implications of cascading failures

## Sources

- EU AI Act, Article 73: Reporting of Serious Incidents
- Natàlia Fernández Ashman, Usman Anwar, and Marta Bieńkiewicz, "EU Regulations Are Not Ready for Multi-Agent AI Incidents," TechPolicy.Press, January 13, 2026
