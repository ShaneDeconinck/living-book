---
title: Five-Layer Observability Stack
tags: [observability, infrastructure, accountability]
---

The complete observability architecture for agent governance, from action logging through fleet-level behavioral aggregation.

## The five layers

- **Layer 1: Action Logging** — every tool call, API invocation, file access, and external communication logged as a structured event with agent ID, tool name, input hash, outcome, and timestamp. This is the minimum that makes investigation possible. [[opentelemetry-genai]] semantic conventions cover this layer.
- **Layer 2: Identity and Authority Capture** — authorization context appended to every logged action: delegator identity, token scope, [[delegation-chain]], token expiry. [[obo-token-exchange]] tokens record both the human who delegated and the agent who acted. Without this layer, logs show what happened but not whether the agent was authorized to do it.
- **Layer 3: Decision Context** — model ID, model version, system prompt hash, context window token count at decision time. When a model version update changes behavior, Layer 3 is the difference between "the agent misbehaved" and "version X handles this edge case differently from version Y." [[opentelemetry-genai]] covers this layer partially.
- **Layer 4: Causal Correlation** — distributed trace IDs propagating across agent boundaries, capturing which upstream agent's output caused a downstream action. This is the [[causal-graph]] layer. Standard distributed tracing handles synchronous call chains; agent semantic causality (reading shared data store outputs) requires explicit trace ID injection at the read point.
- **Layer 5: Fleet Aggregation** — [[fleet-behavioral-aggregation]] detecting emergent and coordinated behavior across agent populations that individual logs cannot surface.

## The accountability problem each layer addresses

Individual layers solve specific problems: Layer 1 enables investigation, Layer 2 enables authorization auditing, Layer 3 enables model accountability, Layer 4 enables multi-agent incident reconstruction, Layer 5 enables fleet governance. The complete stack enables [[agent-incident-response]], regulatory compliance, and detection of collective behavior that violates policy even when no individual action does.

## Standards coverage

[[opentelemetry-genai]] semantic conventions cover Layers 1 and 3 partially. Layers 2 and 4 are the gap: no standard exists yet for delegation chain attributes in telemetry data or for agent-specific semantic causality trace propagation. IETF work on Transaction Tokens, AAP, and WIMSE is standardizing delegation-aware credential formats; observability standards that consume these credentials do not yet exist.

## Tamper evidence

Logs are only useful if the mechanism that produced them is outside the agent's reach. [[tamper-evident-logging]] is a prerequisite for using logs as compliance evidence rather than debugging context. Cryptographic sealing (Merkle tree append-only logs, Certificate Transparency model) provides provable tamper detection for regulated deployments.

## Connections

- [[decision-provenance]] — Layers 2 and 3 are the provenance capture layers
- [[causal-graph]] — Layer 4
- [[fleet-behavioral-aggregation]] — Layer 5
- [[tamper-evident-logging]] — prerequisite for compliance evidence
- [[chain-of-thought-logging]] — reasoning transparency; supplements but does not replace Layers 2-3
- [[opentelemetry-genai]] — the standard that covers Layers 1 and 3
- [[infrastructure-levels]] — the I1-I5 scale maps to observability maturity levels
- [[agent-incident-response]] — the consumer of the complete stack
