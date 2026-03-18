---
title: Pre-Execution Accountability
tags: [accountability, governance, sovereignty]
dimension: governance-thresholds
---

An accountability model where commitments are frontloaded before deployment rather than maintained concurrently during execution.

In traditional agent governance, accountability is concurrent: someone watches, someone can intervene, someone can revoke. [[agentic-sovereignty]] makes concurrent accountability structurally impossible. Pre-execution accountability relocates the accountability moment: the code *is* the commitment. Four mechanisms: **pre-deployment specification** (document what the agent will do, under what conditions, in binding detail), **attestation infrastructure** (record execution-time evidence that deployed code ran as specified via [[tee-attestation]]), **governance mechanisms** (for adjustable-parameter agents, the governance process is the accountability layer), **liability assignment** (identify who carries regulatory and legal liability before deployment, not after incidents).

This is not weaker than concurrent accountability. When a DeFi liquidation engine processes liquidations at machine speed through a market crisis, the accountable parties are those who designed, coded, and deployed the protocol. The question shifts from "who authorized this action?" to "who designed a system that would execute this action under these conditions?"

## Connects to

- [[agentic-sovereignty]] — the execution model that requires this accountability form
- [[tee-attestation]] — execution-time evidence supporting pre-execution commitments
- [[pac-framework]] — reinterprets PAC's accountability pillar for sovereign contexts
- [[evaluation-as-governance]] — pre-deployment audit as governance mechanism
