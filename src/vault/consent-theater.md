---
title: Consent Theater
tags: [governance, authorization, identity]
dimension: agent-identity
---

The gap between a user's mental model of what they authorized and the actual scope of the token an agent holds.

A user thinks "I gave the agent access to one email." The OAuth token says "read all email, forever." The consent screen was technically accurate. The user did not read it. This is consent theater: the form of authorization without the substance.

## Why it's structural, not UX

For agents, consent theater is not a UX problem. Agents request broad scopes because they need flexibility for open-ended tasks. OAuth scopes are coarse by design — `gmail.readonly` grants full mailbox access, with no vocabulary for "emails from this sender, this week, headers only." Users grant broad scopes because saying no breaks the workflow. The result: agents hold credentials far exceeding what the user intended.

The gap between what was intended and what was granted is where risk lives. An agent misreading intent can send the wrong email, stumble into sensitive threads, or execute injected instructions — all within the granted scope.

## The fix

[[verifiable-intent]] addresses this by turning user intent into a cryptographic object: the constraints are signed, machine-enforceable, and verifiable by the recipient — not just scope names on a consent screen. [[operational-envelopes]] implement similar constraint encoding at the infrastructure level.

## Connects to

- [[verifiable-intent]] — cryptographic solution: constraints travel with the authorization
- [[trust-inversion]] — consent theater is what happens when trust inversion is not applied
- [[scoped-authorization]] — narrow scopes close the gap between intent and grant
- [[owasp-agentic-top10]] — ASI09 (Human-Agent Trust Exploitation) catalogues consent theater failures

## Appears in

- **Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.** (`posts/google-workspace-cli-agent-first-oauth-app-first`, 2026-03-05) — detailed analysis with concrete examples per scope type
- **Trusted AI Agents: Why Traditional IAM Breaks Down** (`posts/trust-for-agentic-ai`, 2026-01-24) — delegation as abdication; consent theater as why OBO matters
- Chapter: [Agent Communication Protocols](../chapters/agent-communication.md) — the authorization gap section; concrete table showing intent vs. granted scope across Gmail, Drive, Calendar

## Sources

- Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.," shanedeconinck.be, March 5, 2026
- src/chapters/agent-identity.md
- src/chapters/agent-communication.md
