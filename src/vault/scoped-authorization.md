---
title: Scoped Authorization
tags: [authorization, control, principle]
---

The principle that agents receive time-bounded, task-specific permissions rather than broad ambient authority.

Scoped authorization is [[trust-inversion]] applied to permissions. Instead of "this agent can access the CRM" (ambient), scoped authorization says "this agent can read contact records matching this query, for the next 30 minutes, for the purpose of preparing this specific report." The scope expires when the task completes. Three mechanisms implement this: [[obo-token-exchange]] (delegation-aware tokens), [[rich-authorization-requests]] (structured scope beyond flat strings), and [[operational-envelopes]] (cryptographic constraints). At [[pac-framework]] infrastructure level I2+, scoped authorization is a requirement, not a best practice.
