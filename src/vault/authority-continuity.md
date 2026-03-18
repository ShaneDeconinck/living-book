---
title: Authority Continuity (PIC)
tags: [principle, security, delegation, cross-org-trust]
dimension: cross-org-trust
---

The Provenance, Identity, Continuity model where authority can only decrease through delegation chains, never expand — replacing proof-of-possession with proof-of-continuity.

## The Three Properties

**Provenance**: every action traces to a human principal. No action is attributable only to a workload or service account — the chain always reaches a person who expressed intent.

**Identity**: each agent has its own verifiable identity. It does not borrow credentials from the human it serves or from other agents. Identity and authority are distinct concepts in PIC.

**Continuity**: authority monotonically decreases at each delegation hop. If Agent A has authority {read, write} and delegates to Agent B, B can receive at most {read, write} — and typically a strict subset. The monotonic property is a structural guarantee, not a policy aspiration.

## The Structural Model (Nicola Gallo)

Gallo (DIF co-chair, Trusted AI Agents Working Group) reframes authorization around five elements:

- **Identity**: represents a subject
- **Intent**: the desired action of that subject
- **Authority**: identity + intent (created when an identity expresses a will)
- **Workload**: the executor that continues or creates authority
- **Governance**: can stop, restrict, or leave authority unchanged — but never expand it

This distinction matters: a workload does not need its own identity to **continue** authority. It only needs to prove it can operate within the received authority's constraints. But to **create** new authority, you need an identity and an expressed intent. That distinction prevents accidental privilege escalation at the service-account layer.

## The Virtual Chain

Each execution step forms a virtual chain. The workload proves it can continue under received authority, satisfying the guardrails (department membership, spending limit, time bound). The trust plane validates this at each step and creates the next link.

The confused deputy is not detected or mitigated — it is eliminated. If Alice asks an agent to summarize a file she cannot access, the agent cannot execute under its own authority: the continuity chain carries Alice's permissions. Accessing the file would require creating new authority, which is a deliberate act with explicit accountability.

PIC proves this mathematically: authority can only decrease through a delegation chain.

## Performance

Executing a continuity chain takes microseconds, comparable to a token exchange call. The overhead is a deployment concern, not an architectural one.

## What PIC Does Not Solve Alone

PIC enforces authority containment within a system. It does not solve how two organizations that have never met verify each other. That is [[trust-spanning-protocol|TSP]]'s role. PIC and TSP compose: TSP establishes the cross-boundary channel; PIC ensures authority cannot inflate through it.

## Connects to

- [[trust-spanning-protocol]] — TSP provides the cross-boundary channel; PIC enforces authority continuity through it
- [[confused-deputy]] — PIC eliminates the confused deputy structurally, not by detection
- [[delegation-chain]] — delegation chains are the cryptographic implementation of PIC's continuity requirement
- [[mapl]] — intersection semantics implement PIC's attenuation requirement at the policy layer
- [[ghost-token]] — CAAM's ghost token pattern operationalizes PIC at the infrastructure layer (tokens never held by the agent)
- [[eudi-wallet-agents]] — continuity chains can be anchored in EUDI-issued credentials
- [[cross-domain-delegation-model]] — PIC provides the structural enforcement that Windley's credential-based model requires

## Sources

- Nicola Gallo, DIF / LFDT Belgium meetup, March 2026; reported in Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," March 11, 2026
- PIC Protocol, pic-protocol.org
- src/chapters/cross-org-trust.md §From Possession to Continuity: PIC
