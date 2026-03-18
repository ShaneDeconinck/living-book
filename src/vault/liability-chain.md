---
title: Liability Chains
tags: [accountability, governance, legal]
dimension: liability-chains
---

The explicit record of who deployed an agent, who authorized its scope, who maintained it, and who is legally liable for its behavior.

Each agent has a registered owner, each [[delegation]] has a documented grant event, each credential scope is recorded at issuance. This exists before incidents, not inferred after. Regulators ask "who authorized this agent to take that action?" If the chain is not documented in advance, it cannot be answered during enforcement. [[liability-chain]] is the accountability backbone that [[agent-incident-response]] depends on. Without it, incident attribution is archaeology.

## Connects to

- [[delegation]] — each link in the liability chain corresponds to a delegation event; the chain is only as clear as the delegation records
- [[agent-incident-response]] — incident response depends on pre-existing liability chains; without them, attribution becomes post-hoc archaeology
- [[blast-radius]] — liability scales with blast radius: a deployment with a broad permission surface creates a commensurately broad liability surface; limiting blast radius is also liability risk management
- [[reliability]] — an agent with unmeasured reliability creates unmeasured liability; you cannot establish that you exercised reasonable care if you did not monitor performance
- [[autonomy-levels]] — liability does not scale linearly with autonomy level; A4–A5 deployments require correspondingly richer liability chains because the human override interval is too short to catch failures before they propagate
- [[decision-provenance]] — decision provenance is the technical record that liability chains reference in enforcement; the governance concept and the infrastructure artifact are two sides of the same requirement
