---
title: Causal Graphs
tags: [observability, accountability, multi-agent]
---

Causal graphs capture *why* an agent decided to act — the upstream inputs, delegations, and agent interactions that caused an action — as distinct from action logs, which capture *what* happened.

## The semantic causality gap

Traditional distributed tracing follows synchronous request-response chains: Service A calls Service B, the trace propagates via HTTP headers. Agent causality is structurally different. Agent B does not call Agent A. Agent B reads Agent A's output from a shared data store and acts on it. The causal link is semantic, not invocational.

Traditional trace context propagation misses this: the HTTP call to the shared store is logged, but not which upstream agent produced the data that drove the decision. Capturing semantic causality requires explicit trace ID injection at the point of reading shared outputs — not only at API call boundaries.

## The representation in logs

Layer 4 of the [[observability-stack]] implements causal correlation through distributed trace IDs that span agent boundaries. Every action in a multi-agent workflow carries a shared `workflow_trace_id`. When Agent B acts on Agent A's output, B's log records both the action and the upstream trace that caused it:

```json
{
  "workflow_trace_id": "7d3a9e1f2b4c8a6d",
  "caused_by": {
    "agent_id": "did:webvh:...:research-agent",
    "trace_id": "4bf92f3577b34da6",
    "shared_store_key": "vendor-analysis:2026-03-14:facilities"
  }
}
```

## Why it matters for incident response

Without causal graph data, investigation in multi-agent workflows is archaeology: piecing together what happened from fragments scattered across dozens of agent-specific logs, with no systematic way to connect upstream causes to downstream effects.

[[agent-incident-response]] depends on causal graph reconstruction for multi-agent incidents. [[fleet-behavioral-aggregation]] extends this to fleet-level behavioral patterns that no single causal chain reveals.

## Connections

- [[observability-stack]] — Layer 4; causal correlation is the prerequisite for multi-agent accountability
- [[decision-provenance]] — causal graphs are the multi-agent extension of single-agent decision provenance
- [[agent-incident-response]] — causal reconstruction is the core technique for multi-agent incident investigation
- [[fleet-behavioral-aggregation]] — fleet aggregation detects coordination patterns across causal chains
- [[opentelemetry-genai]] — standard distributed tracing handles invocation causality; semantic causality for agents is not yet specified
