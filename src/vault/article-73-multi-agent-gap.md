---
title: Article 73 Multi-Agent Incident Gap
tags: [regulation, eu-ai-act, incident-response, multi-agent]
---

The EU AI Act's Article 73 incident reporting framework assumes single-agent, single-occurrence failures. It has no mechanism to attribute accountability when an incident results from the interaction of multiple AI systems.

Three structural blind spots:

1. **Emergent multi-agent harms.** Algorithmic collusion in fuel markets, where prices rose without explicit coordination, illustrates the pattern: harm emerged from interaction, not from any individual system. No single provider caused it.

2. **Cascading failures across chains.** Faulty or compromised agents degrade downstream decision-making (up to 23.7% performance drops depending on system structure). The incident is distributed across the chain, but Article 73 requires a single provider to report.

3. **No third-party reporting pathway.** Users, civil society, and researchers who detect multi-agent harms have no formal reporting mechanism under the current framework.

Recommended fixes: recognize incidents arising from AI-to-AI interactions, include cumulative and systemic harms across networks, establish third-party and whistleblower reporting channels.

**Practical implication:** even if regulation does not yet require multi-agent incident tracing, infrastructure should support it. The regulatory gap will close.

## Reporting timelines (Article 73)

- **2 days**: widespread or critical infrastructure disruptions
- **10 days**: incidents resulting in death
- **15 days**: other serious incidents

## Connects to

- [[agent-incident-response]] — the chapter that details agent-specific IR, where Article 73's gaps become operational problems
- [[cascading-failure]] — the technical mechanism behind multi-agent incidents
- [[delegation-chain-forensics]] — the capability needed to attribute multi-agent incidents
- [[coordinated-revocation]] — containment in multi-agent incidents requires cross-chain revocation
- [[regulatory-classification-gap]] — another place where the EU AI Act's single-system assumptions break down

## Sources

- [Ashman 2026]: Fernández Ashman et al., "EU Regulations Are Not Ready for Multi-Agent AI Incidents," TechPolicy.Press, January 13, 2026
- [Huang 2025]: Huang et al., "On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents," ICML 2025
- Chapter: [The Regulatory Landscape](../chapters/regulatory-landscape.md)
