---
title: Ghost Tokens (CAAM Pattern)
tags: [authorization, cryptographic, control]
---

An authorization sidecar pattern where the agent never holds persistent credentials; instead it receives short-lived, single-use, action-specific tokens that cannot be replayed or exfiltrated.

CAAM (Cryptographic Agent Authorization Mediation) works like this: the agent requests permission for a specific action. A sidecar evaluates the request against [[mapl]] policy. If approved, it issues a ghost token — scoped to that exact action, with a cryptographic binding to the request context, expiring immediately after use. The agent never sees long-lived secrets. Even a fully compromised agent cannot escalate privileges because there are no stored credentials to steal. Ghost tokens are the "prove" mode of [[cryptographic-authorization]]: every action carries cryptographic proof of who authorized it and what constraints applied.
