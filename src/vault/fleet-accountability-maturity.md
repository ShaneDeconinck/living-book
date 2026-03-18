---
title: Fleet Accountability Maturity
tags: [governance, accountability, scale, fleet, maturity-model]
---

A five-level maturity model for fleet-scale accountability infrastructure — distinct from the general [[infrastructure-levels]] (I1–I5 for individual agent control). This model describes the organizational capability to attribute decisions, monitor aggregate behavior, and triage incidents across a fleet of agents.

## The five levels

| Level | What exists | What it enables |
|-------|-------------|-----------------|
| **I1: Ad hoc** | Individual agent logs. No fleet registry. Manual incident review. | Accountability for individual agents only. No cross-agent attribution. |
| **I2: Basic** | Fleet registry with agent-to-sponsor mapping. Centralized log aggregation. Manual triage. | Agent inventory and ownership tracking. Post-incident forensics possible but slow. |
| **I3: Structured** | Correlation identifiers across agent interactions. Automated behavioral baselines. Defined triage criteria. | Cross-agent decision attribution. Anomaly detection. Consistent incident classification. |
| **I4: Integrated** | Cryptographic delegation chains (OBO/PIC/CAAM). Automated causal graph reconstruction. Fleet-level impact dashboards. | On-demand regulatory reporting. Automated forensics. Aggregate risk visibility. |
| **I5: Adaptive** | Continuous aggregate monitoring with distributional drift detection. Self-auditing triage classification. Cross-organizational accountability spanning partner agent networks. | Proactive risk management. Regulatory readiness as steady state. Fleet-level governance as competitive advantage. |

## Why this is distinct from infrastructure-levels

[[infrastructure-levels]] measures individual agent control infrastructure (open access → full containment). Fleet accountability maturity measures organizational capability to govern a population of agents. An organization can have I4 containment on each individual agent (authorized, sandboxed) but still be at I1 fleet accountability maturity (no registry, no causal graphs, no cross-agent attribution). The two scales are orthogonal.

## The gap most organizations face

Most organizations building agent fleets start at I1 and stall between I2 and I3. The jump from I2 to I3 requires two capabilities most teams have not built: correlation identifiers that propagate across agent boundaries (not just within a single agent's spans), and behavioral baselines defined for agent classes rather than individual instances. Without I3, incident investigation at fleet scale is forensic archaeology.

The jump from I3 to I4 requires the cryptographic delegation infrastructure — OBO tokens, PIC authority chains, CAAM ghost tokens — that lets the organization reconstruct authorization provenance automatically. Building this after fleet scale is reached means retrofitting every agent's instrumentation in production.

## Regulatory forcing function

EU AI Act Article 73 reporting requirements assume I3 minimum: awareness of incidents within reporting windows requires automated detection. Incident attribution for multi-agent topologies requires I4 causal graph infrastructure. Organizations at I1-I2 cannot meet Article 73 requirements at fleet scale — the detection window alone may exceed the two-day reporting deadline for serious incidents.

## Connects to

- [[fleet-governance]] — this maturity model describes the progression through which fleet governance infrastructure develops
- [[infrastructure-levels]] — orthogonal scale; individual agent control vs. fleet accountability capability
- [[incident-triage-at-scale]] — triage infrastructure is the I3→I4 transition: moving from defined criteria to automated classification
- [[causal-graph]] — automated causal graph reconstruction is the signature I4 capability
- [[delegation-chain-forensics]] — the I4 forensic integration layer; building blocks exist but integration layer must be built
- [[fleet-behavioral-aggregation]] — the monitoring component that enables I3 anomaly detection and I5 drift detection
- [[regulatory-classification-gap]] — organizations at I1-I2 face compounding compliance gaps as fleet scale increases
