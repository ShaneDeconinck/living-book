---
title: Decision Provenance
tags: [observability, accountability, audit, delegation]
dimension: audit-trails
---

Decision provenance is the record of *what decided* an agent action and *under what authority* — as distinct from the record of *what happened*.

## The gap

Current logging infrastructure captures outcomes: which tool was called, what the result was, when it happened, under whose user account the agent ran. This is action logging. It is necessary but insufficient for accountability.

Decision provenance answers the questions action logging leaves open:

- Which model ran, under which system prompt, at the moment of the decision?
- What delegation chain authorized the action — who delegated to whom, with what scope, expiring when?
- In a multi-agent workflow, which upstream agent's output caused this action, and was that agent authorized to produce that output?

The $47,000 vendor payment example from `src/chapters/agent-observability.md`: the audit log showed `alice@company.com` and a successful authorization. It captured the outcome. It did not capture the [[delegation-chain]], the model that decided, the inputs at decision time, or the authority under which the agent acted. When accountability was needed, the log had what happened but not what decided.

## What captures it

The five-layer observability stack (see `src/chapters/agent-observability.md`) assigns provenance capture to specific layers:

- **Layer 2 (Identity and Authority)**: OBO tokens record the [[delegation-chain]] from human principal to acting agent. Token scope and expiry are logged per action. Without this, logs show what happened but not whether the agent was authorized to do it.
- **Layer 3 (Decision Context)**: model ID, model version, system prompt hash, context window token count at decision time. When a model version update changes behavior, Layer 3 is the difference between "the agent misbehaved" and "version 20260301 handles this edge case differently from 20260115."
- **Layer 4 (Causal Correlation)**: distributed trace IDs spanning agent boundaries, capturing which upstream agent's output caused a downstream action. See [[semantic-causality]].

## Why it matters for [[accountability-pillar]]

An agent that is right 99.9% of the time without Layers 2-3 in place is less accountable than one that is right 95% with them. When the 0.1% failure occurs, you cannot prove what authority existed, which model decided, or whether the system prompt was as intended.

Decision provenance is also what distinguishes a compliance artifact from a debugging log. Regulators need to know who authorized the action, what information the agent had when it decided, and whether the decision was within granted authority. Standard application logs do not answer those questions.

## Connections

- [[delegation-chain]] — the authorization record decision provenance captures
- [[obo-token-exchange]] — the credential format that makes delegation auditable
- [[accountability-pillar]] — provenance is the infrastructure that makes accountability possible
- [[chain-of-thought-logging]] — the reasoning complement to provenance (incomplete evidence, different evidentiary value)
- [[infrastructure-levels]] — I3 is the threshold at which decision provenance begins; I4 covers multi-agent causal correlation
- [[reliability]] — decision provenance is the mechanism that converts reliability from a performance metric into a governance artifact; without it, you can measure outcomes but cannot distinguish model drift from scope drift from authorization failure
- [[autonomy-levels]] — advancing an agent from A3 to A4 without decision provenance infrastructure is ungoverned autonomy expansion; provenance is the pre-condition for responsible autonomy advancement
- [[blast-radius]] — post-incident blast-radius scoping depends on decision provenance; without knowing what the agent decided and under what authority, containment is guesswork
- [[inference-time-monitoring]] — produces provenance signals closer to the actual computation than logged reasoning traces
