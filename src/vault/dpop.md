---
title: DPoP (Demonstration of Proof-of-Possession)
tags: [protocol, security, oauth, identity, mcp]
dimension: agent-identity
---

A cryptographic token binding mechanism (RFC 9449) that ties access tokens to the private key held by the requester. A DPoP token cannot be used by anyone who doesn't hold the matching private key — making stolen tokens useless.

## How it works

Instead of a bearer token (valid for anyone who holds it), DPoP requires the agent to prove possession of the private key at each request. The agent signs each HTTP request with a DPoP proof — a short-lived JWT containing the request method, URL, and timestamp, signed with the agent's private key. The authorization server issues tokens bound to that specific public key. Resource servers verify the DPoP proof on every call.

If an attacker intercepts the token, they cannot use it: they lack the private key.

## Why it matters for agents

Agents are high-value exfiltration targets. Prompt injection attacks, compromised tool responses, misconfigured logging pipelines — all are paths to token theft. A stolen bearer token gives an attacker whatever access the agent had. DPoP removes that payoff.

MCP deployments are particularly vulnerable: scanning of MCP servers found a high rate of authentication weaknesses, and token exfiltration is one of the primary documented attack vectors (the GitHub MCP breach involved a stolen personal access token). DPoP is the direct mitigation.

MCP's own security roadmap is implementing DPoP: SEP-1932 brings DPoP to the MCP specification, binding MCP tokens to cryptographic keys. When shipped, stolen MCP tokens are useless without the agent's private key.

## Relationship to OBO

DPoP and [[obo-token-exchange|OBO]] are complementary:

- OBO tracks the **delegation chain** — who authorized whom
- DPoP protects the **token in transit** — stolen tokens don't work

Use OBO to make delegation auditable; use DPoP to prevent the tokens produced by that delegation from being weaponized. They address distinct attack surfaces.

## Relationship to WIMSE

At the infrastructure layer, WIMSE (Workload Identity in Multi-System Environments) gives agents cryptographic identities based on their runtime environment rather than static secrets. DPoP operates at the OAuth layer, binding tokens issued to those identities. MCP's SEP-1933 (Workload Identity Federation) and SEP-1932 (DPoP) are the two mechanisms converging on this from different directions: WIF handles how agents get their identities; DPoP handles how the tokens issued to those identities are protected.

## Connects to

- [[delegation-chain]] — DPoP protects the tokens that implement delegation chains
- [[obo-token-exchange]] — complementary: OBO for chain tracking, DPoP for token protection
- [[trust-inversion]] — stolen token attacks violate trust inversion by allowing impersonation; DPoP closes this
- [[control-pillar]] — token binding is a control enforcement mechanism

## Sources

- RFC 9449: OAuth 2.0 Demonstrating Proof of Possession (DPoP)
- MCP SEP-1932: DPoP for MCP token binding (in progress, 2026 roadmap)
- src/chapters/agent-identity.md §DPoP
- src/chapters/agent-communication.md §The 2026 Roadmap
