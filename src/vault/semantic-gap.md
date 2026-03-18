---
title: Semantic Interoperability Gap
tags: [interoperability, cross-org, unsolved]
dimension: cross-org-trust
---

The unsolved problem that agent actions carry different meanings in different organizational contexts, and no standard vocabulary exists for cross-boundary semantic verification.

Identity is solved (DIDs, VCs). Authorization is advancing ([[tsp]], [[mapl]]). Semantics are not. When Agent A in Organization X says "approve the purchase order" and Agent B in Organization Y processes it, both sides verified identity and authorization correctly — but "approve" meant "flag for review" in X and "execute immediately" in Y. Credentials solved this for identity claims (standard schemas). Actions have not because action meanings are embedded in organizational practice, not formal schemas. Interim approaches: bilateral semantic contracts, LLM-mediated translation, and restricting cross-org agent interactions to narrow, well-defined vocabularies.
