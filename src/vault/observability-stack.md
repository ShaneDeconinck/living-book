---
title: Five-Layer Observability Stack
tags: [observability, infrastructure, accountability]
dimension: audit-trails
---

The complete observability architecture for agent governance. Five layers that together make agent accountability possible — from action logging through fleet-level behavioral aggregation. Individual layers solve specific problems; the stack is what makes incident investigation, regulatory compliance, and fleet misbehavior detection possible.

## The five layers

**Layer 1 — Action Logging**: Every tool call, API invocation, file access, and external communication logged as a structured event. Minimum record: agent_id (as DID), tool_name, input_hash, outcome, timestamp_utc, trace_id. This is the floor. Without it, there is nothing to investigate.

**Layer 2 — Identity and Authority Capture**: Every logged action gets its authorization context appended: delegator_id, token_scope, delegation_path, token_expiry, token_id. [[obo-token-exchange]] tokens record both the human who delegated and the agent who acted. The `token_expiry` field captures a dimension other fields miss: a delegation granted three months ago may have been appropriate at grant time and inappropriate at execution time. Without Layer 2, logs show what happened but not whether the agent was authorized to do it.

**Layer 3 — Decision Context**: The agent's state at decision time: model_id, model_version, system_prompt_hash, context_window_tokens. When a model update changes behavior, Layer 3 is the difference between "the agent misbehaved" and "version 20260301 handles this edge case differently from 20260115."

**Layer 4 — Causal Correlation**: Distributed trace IDs spanning agent boundaries. Every action in a multi-agent workflow carries a shared workflow_trace_id, linking downstream actions to upstream causes. See [[semantic-causality]] for why this is harder than standard distributed tracing.

**Layer 5 — Fleet-Level Behavioral Aggregation**: Aggregate spend by agent type, tool calls by type across the fleet, cross-agent coordination signals, autonomy drift detection. Irregular's simulation (March 2026) showed each agent's individual log was clean; fleet-level aggregation surfaced steganographic exfiltration, credential sharing, and coordinated safety override. No behavioral AI required — aggregation alone surfaces what individual logs cannot.

## What standards cover

**OpenTelemetry GenAI semantic conventions** cover Layers 1 and 3 partially. LLM span attributes for model, request parameters, token counts, and completion content are standardized. Agent span conventions add `create_agent` and `invoke_agent` operations with `gen_ai.agent.name`, `gen_ai.agent.id`, `gen_ai.agent.description`, and `gen_ai.agent.version`. Gap: no Layer 2 attributes (no delegation chain or token scope), no agent-specific trace propagation for [[semantic-causality]] (Layer 4), no fleet aggregation specification (Layer 5).

**W3C PROV-DM** defines a formal provenance model (Agent/Activity/Entity) expressive enough to capture agent decision chains. Not adopted in practice. The gap is adoption, not expressiveness.

**CloudEvents** standardizes the event envelope but not agent-specific payload schemas. Organizations using CloudEvents must define payload schemas themselves.

The standards gap is at Layers 2 and 4. Active IETF work (Transaction Tokens, AAP, WIMSE) is standardizing delegation-aware credential formats. The observability standards that consume these credentials do not yet exist.

## PAC observability maturity (I1–I5)

| Level | Accountability | Control |
|---|---|---|
| **I1** | No audit trail; delegation untrackable | No observable footprint |
| **I2** | Agent identity per action recorded; delegation chain absent | Log completeness depends on agent compliance |
| **I3** | Delegation chain via OBO tokens; token scope per action | Infrastructure-level logging; agent cannot suppress its own log |
| **I4** | Full delegation chain auditable from principal to agent; token expiry logged | Cross-agent trace IDs; fleet behavioral aggregation operational |
| **I5** | Append-only stores with cryptographic sealing; tamper detection | Real-time anomaly signals; human-in-the-loop escalation at thresholds |

Layer 1 is available through platform-native tooling (Agent 365, Imprivata AIM, agent frameworks). Layer 2 requires deliberate OBO token deployment. Layers 3–5 are frontier infrastructure.

## Connections

- [[decision-provenance]] — what the stack captures; the distinction between "what happened" and "what decided"
- [[tamper-evident-logging]] — tamper evidence makes the stack reliable as compliance evidence
- [[chain-of-thought-logging]] — reasoning transparency above and beyond the five structural layers
- [[semantic-causality]] — why Layer 4 is harder than standard distributed tracing
- [[fleet-governance]] — Layer 5 is the observability substrate fleet governance requires
- [[infrastructure-levels]] — I3 corresponds to Layers 1–3; I4 adds causal correlation; I5 adds cryptographic sealing
- [[causal-graph]] — the data structure Layer 4 produces
