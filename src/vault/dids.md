---
title: Decentralized Identifiers (DIDs)
tags: [identity, standard, w3c]
---

W3C standard URIs that resolve to DID Documents containing public keys, enabling cryptographic identity without dependence on a central authority.

A DID (e.g., `did:webvh:example.com:agents:booking-agent`) resolves to a document listing the entity's public keys, authentication methods, and service endpoints. Unlike OAuth client IDs (which depend on an authorization server) or X.509 certificates (which depend on a CA hierarchy), DIDs are self-sovereign: the entity controls its own identifier. For agents, this means identity persists across organizational boundaries without requiring mutual trust in a common identity provider. The `did:webvh` method adds verifiable history — you can confirm not just who an agent is now, but that its identity has been consistent over time. DIDs are the identity layer under [[trust-spanning-protocol]], [[verifiable-credentials]], and [[mcp-i]].
