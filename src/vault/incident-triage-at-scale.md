---
title: Incident Triage at Scale
tags: [governance, accountability, scale, regulation]
dimension: regulatory-landscape
---

Infrastructure that classifies fleet-level anomalies into operational noise, governance review, and regulatory incidents — before the organization needs to respond.

With a fleet of agents operating in high-risk domains, the organization generates a continuous stream of anomalies. Not all are EU AI Act Article 73 reportable. Not all are even problematic. But all need classification. At single-agent scale, a human can read logs and judge. At fleet scale, that is not possible.

## The Article 73 problem

EU AI Act Article 73 requires incident reporting to national authorities: 2 days for widespread infringement or irreversible disruption, 10 days for death, 15 days for other serious incidents. The clock starts when the provider "becomes aware." Three assumptions break at fleet scale:

- **Detection becomes statistical.** With hundreds of agents, anomalous behavior is noise unless automated detection exists. If awareness requires a human to review one log among hundreds, the effective detection window may exceed the reporting window.
- **Attribution becomes forensic.** Article 73 requires naming the "type of AI system involved." In a multi-agent incident, the type is a topology. The non-compliance may not be in any individual agent but in an interaction pattern. Regulators are not equipped to evaluate multi-agent incident reports, and organizations are not equipped to produce them.
- **Frequency becomes continuous.** Three hundred agents across high-risk domains produce a steady stream of edge cases and near-misses. Incident reporting was designed to be exceptional. At fleet scale, it becomes operational.

## What triage infrastructure requires

Triage sits between [[fleet-governance]] monitoring and [[agent-incident-response]]. It classifies events into three buckets:

1. **Operational noise** — log and learn. Expected variance, no governance action needed.
2. **Governance review** — human assessment required. Anomaly may indicate policy drift, scope creep, or systemic issue.
3. **Reportable incident** — regulatory notification required under Article 73 or equivalent.

Classification criteria must be defined before incidents occur, documented in the governance record, and themselves auditable — because a regulator may ask not just "what did you report?" but "what did you classify as non-reportable, and on what basis?"

## Connects to

- [[fleet-governance]] — triage is the output layer of fleet-level monitoring
- [[agent-incident-response]] — triage feeds the incident response pipeline
- [[regulatory-classification-gap]] — the EU AI Act's risk classification problem is compounded at fleet scale
- [[liability-chain]] — triage decisions become part of the liability record
- [[causal-graph]] — causal graphs across agent interactions are required for multi-agent incident attribution
- [[coordinated-revocation]] — once triage identifies an incident, revocation must cascade through the delegation chain
