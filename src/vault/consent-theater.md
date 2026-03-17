---
title: Consent Theater
tags: [governance, authorization, identity]
---

The gap between a user's mental model of what they authorized and the actual scope of the token an agent holds.

A user thinks "I gave the agent access to one email." The OAuth token says "read all email, forever." The consent screen was technically accurate. The user did not read it. This is consent theater: the form of authorization without the substance. For agents, consent theater is structural, not just a UX problem. Agents request broad scopes because they need flexibility for open-ended tasks. Users grant them because saying no breaks the workflow. The result: agents hold credentials far exceeding what the user intended. [[verifiable-intent]] and [[operational-envelopes]] address this by encoding actual constraints (not just scope names) in machine-enforceable credentials.
