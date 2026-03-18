---
title: Agent Ephemerality
tags: [identity, dids, agents, architecture]
dimension: agent-identity
---

The property that agents are spun up and torn down frequently, making centralized identity databases impractical for tracking them. Unlike humans, who persist across sessions and have legacy identity systems (passports, SSNs), agents have no pre-existing centralized identity to compete with.

Grace Rachmany (DIF Executive Director, March 2026 newsletter) argued that "agentic AI has an even stronger use case for decentralized AI than human identification" precisely because of ephemerality. Centralized identity assumes persistent entities that can be looked up in a database. Agents do not persist that way. [[dids]] fit agents more naturally than they fit humans because there is no legacy identity system competing with them.

This inverts the usual framing. The standard objection to decentralized identity for agents is "just use OAuth tokens." The ephemerality argument responds: OAuth assumes a persistent authorization server that knows about the agent. An agent that exists for one task and then vanishes does not fit that model cleanly. A DID that the agent generates, uses, and then the controller revokes fits the lifecycle.

Connects to [[trust-inversion]], [[delegation-chain]], [[orphan-agent]] (the failure mode when ephemeral agents are not properly decommissioned), and [[agent-provisioning]].

[Rachmany, DIF Newsletter #59, March 17 2026]
