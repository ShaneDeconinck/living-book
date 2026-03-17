---
title: Scoped Authorization
tags: [authorization, control, principle]
---

The principle that agents receive time-bounded, task-specific permissions rather than broad ambient authority.

Scoped authorization is [[trust-inversion]] applied to permissions. Instead of "this agent can access the CRM" (ambient), scoped authorization says "this agent can read contact records matching this query, for the next 30 minutes, for the purpose of preparing this specific report." The scope expires when the task completes. Three mechanisms implement this: [[obo-token-exchange]] (delegation-aware tokens), [[operational-envelopes]] (cryptographic constraints), and rich authorization requests (structured scope beyond flat strings). At [[pac-framework]] infrastructure level I2+, scoped authorization is a requirement, not a best practice.

## Why scope ceilings fail

OAuth scopes are coarse by design. `gmail.readonly` grants access to every email in the mailbox since account creation. There is no scope for "emails from this sender, last five days." The granularity does not exist. When an agent requests a coarse scope, it holds credentials far exceeding what the user intended. [[verifiable-intent]] solves this by encoding the actual constraints as a cryptographic object rather than relying on scope vocabulary.

## Connects to

- [[trust-inversion]] — scoped authorization is the credential-layer implementation
- [[obo-token-exchange]] — OBO is the primary token mechanism for delegation-aware scoping
- [[verifiable-intent]] — extends scoped authorization with user-signed constraints, not just scope names
- [[consent-theater]] — coarse scopes cause consent theater; scoped authorization is the fix
- [[operational-envelopes]] — operational envelopes add behavioral constraints above the permission layer

## Appears in

- **Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.** (`posts/google-workspace-cli-agent-first-oauth-app-first`, 2026-03-05) — coarse OAuth scopes as the scoped authorization failure; concrete per-scope examples
- **AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment** (`posts/ai-agents-context-infrastructure-long-term-investment`, 2026-02-09) — permissions as a pillar of context infrastructure
- **AI Agents Need the Inverse of Human Trust** (`posts/agent-trust-inversion`, 2026-02-03) — scoped authorization as the structural implementation of trust inversion

## Sources

- Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.," shanedeconinck.be, March 5, 2026
- src/chapters/cryptographic-authorization.md
