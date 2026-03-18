---
title: Decentralized Identifiers (DIDs)
tags: [identity, standard, w3c]
dimension: agent-identity
---

W3C standard URIs that resolve to DID Documents containing public keys, enabling cryptographic identity without dependence on a central authority.

A DID (e.g., `did:webvh:example.com:agents:booking-agent`) resolves to a document listing the entity's public keys, authentication methods, and service endpoints. Unlike OAuth client IDs (which depend on an authorization server) or X.509 certificates (which depend on a CA hierarchy), DIDs are self-sovereign: the entity controls its own identifier. For agents, this means identity persists across organizational boundaries without requiring mutual trust in a common identity provider. The `did:webvh` method adds verifiable history — you can confirm not just who an agent is now, but that its identity has been consistent over time. DIDs are the identity layer under [[trust-spanning-protocol]], [[verifiable-credentials]], and [[mcp-i]].

## Connects to

- [[trust-spanning-protocol]] — TSP uses DIDs for agent identity and cryptographic verification of messages
- [[verifiable-credentials]] — VCs are issued to DIDs; the DID is the stable hook for a credential that describes what an agent is authorized to do
- [[mcp-i]] — MCP-I uses DIDs to establish agent identity within tool-call authorization flows
- [[business-value-tiers]] — persistent, self-sovereign identity is what makes cross-org agent workflows viable at Tier 2 and Tier 3 value levels; federation that depends on a shared identity provider cannot scale across organizational trust boundaries
- [[blast-radius]] — DID-anchored identity enables scoped, auditable agent identities at fleet scale; without stable identity, containing a compromised agent requires network-level isolation rather than credential revocation
- [[autonomy-levels]] — advancing to A4–A5 requires verifiable, persistent identity; agents that impersonate users or inherit credentials cannot be independently governed, and independent governance is a prerequisite for high-autonomy deployment
