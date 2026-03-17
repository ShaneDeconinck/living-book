---
title: Agent Authorization Profile (AAP)
tags: [protocol, authorization, oauth, agents, delegation]
---

Agent Authorization Profile (AAP) extends OAuth 2.0 and JWT with structured claims that encode what [[obo-token-exchange]] leaves out: task context, operational constraints, delegation depth, and human oversight requirements — making the authorization token carry the governance policy.

## The Gap AAP Fills

OAuth scopes are flat strings negotiated at registration time. `write:email` tells you what a token permits; it says nothing about why, under what constraints, for how long, or which actions require human approval. Two agents with identical scopes — one summarizing emails, one exfiltrating data — are indistinguishable to the authorization server.

AAP (draft-aap-oauth-profile, February 2026) replaces flat scopes with structured capabilities that carry operational meaning.

## Key AAP Claims

**Structured capabilities.** Where a standard OAuth scope says `write:email`, an AAP capability specifies: write email, to these recipients, for this task, within this time window, in this network zone, with these rate limits.

**Context constraints.** The `context` claim binds tokens to specific operational constraints — network zones, time windows, geographic restrictions — that resource servers validate at runtime, not just at client registration.

**Mandatory privilege reduction.** For delegation chains, each hop produces a new token with a subset of the parent's capabilities, tracked through parent-token linkage. Delegation depth is explicit in the token, not implicit in a trust relationship.

**Human oversight embedding.** The `oversight.requires_human_approval_for` claim embeds human oversight requirements into the authorization token itself. Instead of the agent deciding when to ask for approval — which the human-agent collaboration chapter shows agents resist — the token declares which actions require human sign-off. The resource server enforces this, not the agent. The agent cannot bypass oversight requirements because they are in the credential, not in the agent's instructions.

## How AAP, OBO, and RAR Compose

AAP, [[obo-token-exchange]], and Rich Authorization Requests address three different layers of the same problem:

- **OBO** (RFC 8693): tracks *who* delegated to whom
- **RAR** (RFC 9396): structures how the agent *requests* fine-grained access (`authorization_details` instead of flat scopes)
- **AAP**: encodes the *constraints and context* in the issued token

An agent using all three sends a structured RAR request to the authorization server, receives a token with AAP claims encoding the granted constraints, and the resource server enforces both. The result: a token that carries delegation provenance (OBO), fine-grained scope (RAR), and operational governance (AAP).

## Related Draft: Decoupled Authorization Model

A complementary draft from China Mobile (draft-chen-agent-decoupled-authorization-model, February 2026) takes a different angle: decoupling authorization decisions from business logic through separate Authorization Decision and Execution Points, enabling just-in-time permissions based on specific agent intent rather than static role assignments. Where AAP enriches the token, the Decoupled model restructures the authorization architecture itself.

## PAC Mapping

AAP is a Control infrastructure: it makes governance policy machine-enforceable at the token layer. The `oversight.requires_human_approval_for` claim is a direct implementation of the Accountability pillar's oversight requirement — authority isn't just recorded, it's constrained.

## Connects to

- [[obo-token-exchange]] — OBO establishes who delegated; AAP encodes what constraints apply to that delegation
- [[trust-inversion]] — AAP's mandatory privilege reduction and oversight embedding are structural trust inversion at the OAuth layer
- [[delegation-chain]] — AAP tracks delegation depth explicitly; parent-token linkage makes chains auditable
- [[transaction-tokens]] — Txn-Tokens propagate identity through backend chains; AAP defines what constraints travel with it

## Sources

- IETF, draft-aap-oauth-profile, February 2026
- IETF, draft-chen-agent-decoupled-authorization-model, February 2026
- src/chapters/agent-identity.md §Agent Authorization Profile (AAP)
