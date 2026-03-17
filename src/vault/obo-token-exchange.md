---
title: On-Behalf-Of (OBO) / Token Exchange
tags: [protocol, delegation, oauth, identity]
---

The OAuth mechanism for making delegation explicit in token chains. An entity exchanges a subject token (the human principal's identity) plus an actor token (the agent's identity) for a new token that encodes both — creating a verifiable record of who authorized whom. Defined in RFC 8693 (OAuth 2.0 Token Exchange), with an AI-agent-specific extension in the IETF draft `draft-oauth-ai-agents-on-behalf-of-user`.

## How it works

A token request includes three components:

- `subject_token` — represents the human user who is delegating
- `actor_token` — authenticates the agent acting on their behalf
- `scope` — the specific permissions requested for the downstream operation

The resulting token states: "User Alice authorized Agent A to act on her behalf, with these scopes." If Agent A delegates to Agent B, a second exchange captures that hop. Each exchange is an independent HTTP transaction.

## Why it matters for agents

Without OBO, agents present their own credentials to downstream services and the human principal disappears from the authorization picture. The service sees a powerful agent; it cannot tell whether the human intended that action or was bypassed. OBO restores the human into the authorization chain at every hop.

OBO is the **who-delegated-what** layer. It tracks identity across delegation hops. It does not, on its own, encode purpose or enforce constraints (that is [[agent-authorization-profile|Agent Authorization Profile]]'s job) or prevent token theft (that is [[dpop|DPoP]]'s job).

## Delegation chain splicing attack

Chained token exchanges create a structural vulnerability. When agents chain multiple RFC 8693 exchanges (User → Agent A → Agent B → service), each exchange is an independent HTTP transaction. Without cryptographic binding between hops, an attacker at an exchange point can substitute a different `actor_token`, redirecting the chain to act under a different principal's authority. Each individual exchange looks valid; the fraud is in the substitution between steps.

Transaction Tokens for Agents address this by making `actor` and `principal` claims immutable across the chain: the Txn-Token Service will not issue a replacement token that contradicts the chain's established provenance.

## Combining OBO with complementary protocols

OBO + [[dpop]]: OBO tracks the delegation chain; DPoP binds tokens to cryptographic keys. Both together protect against two distinct attacks: impersonation (OBO makes the chain auditable) and token theft (DPoP makes stolen tokens useless without the private key).

OBO + [[transaction-tokens|Transaction Tokens]]: closes the splicing window OBO leaves open.

OBO + [[verifiable-credentials]]: for cross-organizational delegation, VCs can carry the delegation claim portably without relying on a shared authorization server.

## Connects to

- [[delegation-chain]] — OBO is the primary OAuth implementation of delegation chain tracking
- [[dpop]] — complementary: OBO tracks who delegated; DPoP prevents token theft
- [[trust-inversion]] — OBO enforces that the human principal cannot be removed from the authorization record
- [[accountability-pillar]] — delegation traceability is a core accountability requirement

## Sources

- RFC 8693: OAuth 2.0 Token Exchange
- IETF draft: `draft-oauth-ai-agents-on-behalf-of-user` (AI-agent OBO extension)
- [Deconinck 2026d]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," shanedeconinck.be, January 2026
- src/chapters/agent-identity.md §OAuth Extensions for Agents
