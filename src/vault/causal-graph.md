---
title: Causal Graphs
tags: [observability, accountability, multi-agent, forensics]
dimension: audit-trails
---

A causal graph is the structured provenance record that captures *why* an agent acted — tracing upstream inputs, delegations, and agent interactions across a multi-agent workflow.

## What it captures

Unlike event logs, which record *what happened*, a causal graph records the semantic dependencies between events. The distinction:

- Event log: Agent C called API X at 14:32:07
- Causal graph: Agent C called API X because Agent B's vendor-analysis output indicated facility costs exceeded budget, based on data Agent A retrieved from the procurement database under authorization granted by alice@company.com

A causal graph answers three questions event logs cannot:
1. Which upstream agent's output caused this action?
2. Was the upstream agent authorized to produce that output?
3. What was the full chain of delegation from human principal to final action?

## Structure

At its simplest, a causal graph is a directed acyclic graph where nodes are agent actions and edges are causal dependencies. The practical representation in agent logging is distributed trace IDs that span agent boundaries:

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

Every action in the workflow carries the `workflow_trace_id`. The `caused_by` field records the upstream action and agent. Over a complete workflow, the records compose into the full graph.

## Why it requires explicit instrumentation

Standard distributed tracing reconstructs invocation chains — direct function call sequences. Causal graphs in multi-agent systems require capturing [[semantic-causality]]: the cases where one agent reads another's output from a shared store and acts on it, without any direct API call to instrument.

The graph only exists if:
- Writers inject trace context when producing shared outputs
- Readers record which trace ID they consumed as a `caused_by` reference
- The orchestration layer enforces both conventions across all agents

Without explicit instrumentation, causal reconstruction at incident time requires forensic inference: matching timestamps, correlating context, piecing together a chain that was never recorded as a chain.

## When it matters

Causal graphs are most useful when things go wrong. In incident response, "which upstream decision caused this downstream failure?" is the first question. In regulatory reporting, "was the full chain of actions within granted authority?" requires tracing from the final action back to the human authorization. For accountability at scale, individual audit trails do not compose into organizational accountability — the graph is the composition.

Irregular's March 2026 simulation: each agent's individual log showed reasonable behavior. Fleet-level aggregation surfaced coordination patterns. A causal graph would have shown which agent's output first triggered the anomalous behavior, and whether that agent had been operating within its authorized scope.

## Connections

- [[semantic-causality]] — the core challenge of building causal graphs across shared stores
- [[observability-stack]] — Layer 4 (Causal Correlation) is where causal graphs are built
- [[decision-provenance]] — decision provenance at the multi-agent level is a causal graph problem
- [[agent-incident-response]] — root cause analysis depends on having causal graphs available at incident time
- [[fleet-governance]] — fleet accountability requires causal graphs as substrate
- [[delegation-chain]] — the authorization dimension of the causal graph
