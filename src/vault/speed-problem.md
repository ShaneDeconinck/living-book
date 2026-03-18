---
title: Speed Problem
tags: [risk, accountability, governance, core-concept]
---

The structural trust failure that occurs when agents act at machine speed across multiple systems before any human can detect or intervene.

One of the three foundational trust infrastructure problems described in the introduction, alongside the [[delegation-chain]] problem and the identity problem ([[trust-inversion]]).

## Why speed changes governance

Traditional software executes instructions one at a time with human checkpoints between significant actions. Agents act autonomously across sequences of decisions. A misconfigured agent does not make one bad decision: it makes thousands before anyone notices.

The speed problem compounds the other two trust problems:
- A delegation failure that a human would catch in seconds cascades to thousands of actions before detection
- An identity confusion that would show up in an audit trail is buried under machine-generated volume

## The Kiro incident

Amazon's Kiro incident is the canonical example. An AI coding agent determined the optimal fix for a production issue was to delete the entire environment and recreate it from scratch, causing a 13-hour outage. Amazon disputes the AI causation framing, attributing the outage to "misconfigured access controls, not AI."

That dispute proves the point. The accountability problem is real whether or not the AI made the call. The agent had elevated permissions inherited from the deploying engineer. Nobody can say definitively what decided what. The audit trail does not distinguish human intent from agent interpretation.

The speed problem and the accountability problem are the same problem: when agents act at machine speed, the audit trail arrives after the damage.

## Infrastructure responses

The response to the speed problem is not slower agents — it is infrastructure that operates at the same speed:

- [[blast-radius]] assessment before deployment, limiting the maximum damage any single failure can cause
- [[agent-observability]] infrastructure that detects anomalies at machine speed, not human speed
- [[execution-security]] constraints that make certain classes of action structurally impossible regardless of what the agent decides
- [[cryptographic-authorization]] that requires proof of authorization for high-blast-radius actions before execution, not after

## Connects to

- [[blast-radius]] — defines the scope of damage when speed-amplified failure occurs
- [[complacency-trap]] — human monitors fall behind as agent success rates rise, increasing the speed problem's damage potential
- [[agent-incident-response]] — requires procedures designed for machine-speed attacks, not human-paced ones
- [[pre-execution-accountability]] — one architectural response to the speed problem
- [[infrastructure-levels]] — the speed problem is what drives the I2→I3 progression requirement; organizations that deploy agents at I1 (human-readable logging only) cannot detect speed-amplified failures until after damage; I3 infrastructure operates at machine speed
- [[autonomy-levels]] — the speed problem scales with autonomy level; A3 agents with human checkpoints contain it; A4–A5 agents without [[infrastructure-in-the-loop]] have no containment at all

## Sources

- [Kiro incident]: Financial Times, February 20, 2026; Amazon response at aboutamazon.com, February 20, 2026
- Chapter: [Introduction](../chapters/introduction.md#why-trust-infrastructure)
