---
title: Ghost Tokens (CAAM Pattern)
tags: [authorization, cryptographic, control]
dimension: delegation-chains
---

An authorization sidecar pattern where the agent never holds persistent credentials; instead it receives short-lived, single-use, action-specific tokens that cannot be replayed or exfiltrated.

CAAM (Cryptographic Agent Authorization Mediation) works like this: the agent requests permission for a specific action. A sidecar evaluates the request against [[mapl]] policy. If approved, it issues a ghost token — scoped to that exact action, with a cryptographic binding to the request context, expiring immediately after use. The agent never sees long-lived secrets. Even a fully compromised agent cannot escalate privileges because there are no stored credentials to steal. Ghost tokens are the "prove" mode of [[cryptographic-authorization]]: every action carries cryptographic proof of who authorized it and what constraints applied.

## Connects to

- [[mapl]] — MAPL defines the intersection policy; ghost tokens are how that policy is enforced at action time
- [[cryptographic-authorization]] — ghost tokens are the per-action credential in the cryptographic authorization model
- [[reliability]] — because every action carries its own authorization proof, ghost tokens make authorization failures detectable at action granularity rather than audit-time discovery; this is a reliability property, not just a security one
- [[autonomy-levels]] — ghost tokens are what make A4–A5 autonomy operationally safe; without per-action authorization, high autonomy means high trust in a model that has no revocability mid-task
- [[blast-radius]] — because tokens are single-use and action-scoped, a compromised agent cannot accumulate capabilities; the blast radius ceiling is the scope of the current token, not the scope of stored credentials
- [[decision-provenance]] — ghost tokens are a natural provenance artifact: the cryptographic binding records what authority existed at the moment of the decision, making post-hoc attribution tractable
