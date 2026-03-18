---
title: Context Poisoning
tags: [threat, supply-chain, governance]
dimension: supply-chain
---

Adversarial or commercial manipulation of agent context at scale to corrupt future decision-making.

Microsoft discovered AI Recommendation Poisoning: legitimate companies embedding hidden instructions in "Summarize with AI" buttons to bias agent memory toward their products. The context the agent consumed was fresh, came through normal interaction channels, and was designed to corrupt future decision-making for commercial advantage. This is distinct from traditional adversarial attack (aggressive and detectable) and harder to defend because it operates through normal information channels. [[context-poisoning]] requires treating [[context-infrastructure]] freshness not just as data currency but as data provenance and integrity. See [[supply-chain-security]] for the broader threat model.

Related but distinct from [[agent-data-leakage]]: poisoning corrupts the context; leakage exposes it. Both exploit the same aggregation surface.
