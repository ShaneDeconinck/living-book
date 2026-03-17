---
title: Semantic Causality
tags: [observability, multi-agent, tracing, accountability]
---

Semantic causality is the relationship between an upstream agent's output and a downstream agent's action, where the causal link runs through meaning rather than through a direct function call.

## Why it is different from invocation causality

Standard distributed tracing (OpenTelemetry, W3C Trace Context) works by propagating `traceparent` headers through synchronous request-response chains. Service A calls Service B, which calls Service C. The trace context flows with the call. Every downstream span records its parent.

Agent architectures break this assumption. Agent B often does not *call* Agent A. Agent B reads Agent A's output from a shared data store and acts on it. The causal link is semantic: Agent B interpreted Agent A's output as meaning something, and that interpretation drove the action. There is no HTTP call boundary to instrument. The W3C Trace Context header was never propagated.

The result: standard distributed tracing reconstructs *invocation chains*. It cannot reconstruct *reasoning chains* unless trace context is explicitly injected at every point where one agent reads another agent's output.

## The challenge at shared stores

Shared memory and shared data stores are the primary site of the gap. When Agent A writes a vendor analysis to a shared store, and Agent B later reads that record and authorizes a payment, the causal connection is real but invisible to standard tooling. The read event — and the semantic interpretation that drove it — must carry explicit trace context for the causal link to be reconstructable.

This requires:
1. Writers inject a trace ID alongside the content they produce
2. Readers record which trace ID was in the content they consumed as a `caused_by` field
3. The orchestration layer (or the agent framework) enforces both conventions

Without both, the causal chain is reconstructable only through forensic inference at incident time — if then.

## Why this matters

The Irregular simulation (March 2026) showed this failure concretely: each agent's individual audit log was clean. Fleet-level aggregation surfaced the coordination. But even fleet aggregation does not tell you *why* Agent B acted as it did if the semantic link to Agent A's output was never recorded.

In incident response, the questions that matter — "which upstream decision caused this downstream failure?" and "was the upstream agent authorized to produce that output?" — are only answerable if semantic causality was captured at runtime.

## In the observability stack

Semantic causality is the core challenge of Layer 4 (Causal Correlation) in the [[observability-stack]]. Layer 4 requires propagating trace context through every inter-agent communication, including shared data store reads, A2A messages, and MCP tool results — not only at direct API call boundaries.

## Connections

- [[causal-graph]] — the data structure that semantic causality analysis produces
- [[observability-stack]] — semantic causality is Layer 4's core challenge
- [[decision-provenance]] — provenance at the multi-agent level requires capturing semantic causality
- [[agent-incident-response]] — root cause analysis without semantic causality records is archaeological reconstruction
- [[fleet-governance]] — fleet-level accountability requires knowing which agents influenced which other agents
