# Vault Retrobuild — Batch 4 (Identity Protocols + Communication + Remaining)

Staging area for vault notes. Move each section to its own file in src/vault/ once permissions are fixed.

---

## obo-token-exchange.md

```yaml
---
title: On-Behalf-Of (OBO) Token Exchange
tags: [protocol, delegation, oauth]
---
```

RFC 8693 mechanism for tracking delegation chains by differentiating user identity from agent identity via dual-identity tokens.

When Agent A needs to call Service B on behalf of User X, it exchanges its token for a new one carrying both identities: "this is Agent A, acting on behalf of User X." The receiving service sees who authorized the action (User X) and who performed it (Agent A). This is the minimum viable [[delegation-chain]] in OAuth-native systems. Limitation: OBO tokens carry scope but not constraints. They say "Agent A may read email on behalf of User X" but cannot express "only emails from this sender, only this week." For richer constraints, see [[verifiable-intent]] and [[operational-envelopes]]. The splicing attack — where a malicious agent substitutes its own OBO token into another agent's chain — requires [[dpop]] binding to prevent.

---

## dpop.md

```yaml
---
title: DPoP (Demonstration of Proof-of-Possession)
tags: [protocol, security, oauth]
---
```

RFC 9449 mechanism binding tokens to client cryptographic keys so intercepted tokens cannot be reused by a different party.

Bearer tokens are keys: whoever holds one can use it. DPoP changes this. The agent generates a key pair and proves possession of the private key on every request. A stolen DPoP-bound token is useless without the corresponding private key. For agents, this closes a critical gap: agents holding [[obo-token-exchange]] tokens in memory are high-value targets. DPoP ensures that even if the token leaks, the attacker cannot replay it. Combined with short token lifetimes, DPoP makes credential theft a low-yield attack. Essential for any system at [[pac-framework]] infrastructure level I3 or above.

---

## dids.md

```yaml
---
title: Decentralized Identifiers (DIDs)
tags: [identity, standard, w3c]
---
```

W3C standard URIs that resolve to DID Documents containing public keys, enabling cryptographic identity without dependence on a central authority.

A DID (e.g., `did:webvh:example.com:agents:booking-agent`) resolves to a document listing the entity's public keys, authentication methods, and service endpoints. Unlike OAuth client IDs (which depend on an authorization server) or X.509 certificates (which depend on a CA hierarchy), DIDs are self-sovereign: the entity controls its own identifier. For agents, this means identity persists across organizational boundaries without requiring mutual trust in a common identity provider. The `did:webvh` method adds verifiable history — you can confirm not just who an agent is now, but that its identity has been consistent over time. DIDs are the identity layer under [[trust-spanning-protocol]], [[verifiable-credentials]], and [[mcp-i]].

---

## verifiable-credentials.md

```yaml
---
title: Verifiable Credentials (VCs)
tags: [identity, standard, w3c, trust]
---
```

W3C standard signed claims ("Entity X has property Y, attested by Issuer Z") that parties can verify cryptographically without contacting the issuer.

VCs separate issuance from verification. A credential authority issues a signed claim (e.g., "this agent is authorized to book travel for Acme Corp, with spending limit $5,000"). Any receiving party verifies the signature against the issuer's [[dids]] document. No callback to the issuer needed. For [[cross-org-trust]], this is the portable proof mechanism: an agent carries credentials that prove its authority without the receiving organization needing to trust the sending organization's internal systems. Three credential formats matter: **SD-JWT VC** (web-native, selective disclosure, used by [[verifiable-intent]]), **W3C VC** (JSON-LD, semantic interoperability, BBS signatures for unlinkability), **mdoc** (proximity verification, mobile wallets). The [[three-layer-credential-chain]] (identity → delegation → transaction) structures how VCs compose for agent commerce.

---

## authority-continuity.md

```yaml
---
title: Authority Continuity (PIC)
tags: [principle, security, delegation]
---
```

The Provenance, Identity, Continuity model where authority can only decrease through delegation chains, never expand.

PIC replaces proof-of-possession with proof-of-continuity. Three properties: **Provenance** (every action traces to a human principal), **Identity** (each agent has its own verifiable identity, not borrowed credentials), **Continuity** (authority monotonically decreases at each delegation hop). This eliminates the [[confused-deputy]] structurally rather than detecting it post-hoc. If Agent A has permissions {read, write} and delegates to Agent B, B can receive at most {read, write} — and typically less. The intersection semantics of [[mapl]] implement this at the policy layer. PIC is the theoretical foundation; [[trust-spanning-protocol]] implements it at the protocol layer.

---

## mcp.md

```yaml
---
title: Model Context Protocol (MCP)
tags: [protocol, tools, infrastructure]
---
```

An open standard protocol for connecting AI agents to tools and data sources via a JSON-RPC interface.

MCP defines three primitives: **tools** (callable functions with typed inputs/outputs), **resources** (data the agent can read), and **prompts** (reusable interaction templates). It standardizes what was previously a mess of custom integrations. Every AI platform now supports MCP. The authorization gap: MCP authenticates users but not servers. A client connecting to an MCP server cannot verify the server's identity or confirm it actually has claimed capabilities. This gap is addressed by [[mcp-i]] (identity layer), [[agent-gateway]] (enforcement layer), and [[tmcp]] (TSP transport). The [[tool-poisoning]] threat exploits MCP's trust model: tool descriptions are behavioral instructions to the LLM, not documentation.

---

## a2a.md

```yaml
---
title: A2A (Agent-to-Agent Protocol)
tags: [protocol, communication, google]
---
```

Google's protocol standardizing agent-to-agent discovery, communication, and collaboration, distinct from tool invocation.

A2A's key insight: agents are not tools. Tools are stateless functions. Agents have agency — they negotiate, collaborate, produce artifacts over time, and may refuse requests. A2A introduces **Agent Cards** (structured metadata describing capabilities, authentication requirements, and endpoints), **task lifecycle** (immediate, long-running, or collaborative multi-turn interactions), and **artifact exchange** (structured outputs that agents produce and consume). Agent Cards are the discovery mechanism: they answer "what can this agent do and how do I talk to it?" Combined with [[trust-spanning-protocol]], A2A becomes TA2A — agent discovery with cryptographic identity verification. Governed by the [[aaif]] under the Linux Foundation.

---

## agent-gateway.md (extended)

```yaml
---
title: Agent Gateways
tags: [infrastructure, control, enforcement]
---
```

Note: This concept already exists in batch 3. This adds communication-chapter context.

Additional connections from agent-communication chapter: AgentGateway (Solo.io) provides MCP federation (single endpoint federating multiple backend MCP servers), Cedar policy enforcement (Amazon's fine-grained authorization language for RBAC at tool level), and tool-poisoning detection. The gateway pattern solves the "who enforces policy" problem in MCP's architecture — MCP itself has no enforcement layer. Without a gateway, policy is advisory. With a gateway, policy is structural. The agent gateway is to MCP what an API gateway is to REST: the missing enforcement layer.

---

## consent-theater.md

```yaml
---
title: Consent Theater
tags: [governance, authorization, identity]
---
```

The gap between a user's mental model of what they authorized and the actual scope of the token an agent holds.

A user thinks "I gave the agent access to one email." The OAuth token says "read all email, forever." The consent screen was technically accurate. The user did not read it. This is consent theater: the form of authorization without the substance. For agents, consent theater is structural, not just a UX problem. Agents request broad scopes because they need flexibility for open-ended tasks. Users grant them because saying no breaks the workflow. The result: agents hold credentials far exceeding what the user intended. [[verifiable-intent]] and [[operational-envelopes]] address this by encoding actual constraints (not just scope names) in machine-enforceable credentials.

---

## operational-envelopes.md

```yaml
---
title: Operational Envelopes
tags: [authorization, control, delegation]
---
```

Cryptographic constraints that travel with an authorization, defining what an agent can do in machine-enforceable terms.

An operational envelope encodes: spending limits, approved services, time bounds, purpose constraints, geographic restrictions. Unlike OAuth scopes (coarse, string-based), operational envelopes carry structured, verifiable constraints. They answer: "this agent is authorized to book flights under $500, only on approved airlines, only for the next 48 hours." The constraints are enforced by infrastructure, not by the agent. Even a compromised agent cannot exceed the envelope. [[verifiable-intent]] implements envelopes using SD-JWT selective disclosure. [[mapl]] composes envelopes across delegation chains using intersection semantics. Operational envelopes are the mechanism that makes [[trust-inversion]] practical: you grant broad capability categories but constrain the operational parameters.

---

## scoped-authorization.md

```yaml
---
title: Scoped Authorization
tags: [authorization, control, principle]
---
```

The principle that agents receive time-bounded, task-specific permissions rather than broad ambient authority.

Scoped authorization is [[trust-inversion]] applied to permissions. Instead of "this agent can access the CRM" (ambient), scoped authorization says "this agent can read contact records matching this query, for the next 30 minutes, for the purpose of preparing this specific report." The scope expires when the task completes. Three mechanisms implement this: [[obo-token-exchange]] (delegation-aware tokens), [[rich-authorization-requests]] (structured scope beyond flat strings), and [[operational-envelopes]] (cryptographic constraints). At [[pac-framework]] infrastructure level I2+, scoped authorization is a requirement, not a best practice.
