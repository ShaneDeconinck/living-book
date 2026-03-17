---
title: Model Provider Trust Instability
tags: [supply-chain, trust, policy, risk]
---

The risk that a model provider's safety commitments change over time, making those commitments a policy dependency rather than an infrastructure guarantee.

Two events in early 2026 illustrate the instability from opposite directions:

1. **Anthropic RSP 3.0** (February 2026): Anthropic updated its Responsible Scaling Policy, introducing a non-binding Frontier Safety Roadmap alongside the existing ASL thresholds. The company many enterprise buyers trusted for holding the line on safety redefined what holding the line means.

2. **DoD pivot** (February-March 2026): The U.S. Department of Defense moved away from Anthropic over restrictions on military applications (mass surveillance, fully autonomous weapons), contracting with OpenAI instead. Anthropic sued; 875+ employees from OpenAI and Google signed an open letter in support.

Model providers face competitive pressure to relax safety commitments and political pressure to tighten or loosen them depending on the customer. The architectural answer: enforce constraints at the infrastructure layer ([[sandboxing]], [[scoped-authorization]], [[delegation-chain]]) rather than depending on vendor promises. Policy says "don't." Architecture says "can't." The difference matters when the policy can change.

This connects to the broader supply chain argument in the [[skill-supply-chain]] note: every external dependency, including the model itself, is an attack surface.

Related: [[ai-bom]], [[containment-by-design]], [[trust-inversion]]
