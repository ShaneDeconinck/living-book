---
title: OpenTelemetry GenAI Semantic Conventions
tags: [observability, standards, opentelemetry, telemetry]
---

The OpenTelemetry GenAI semantic conventions are the primary open standard for structured telemetry of LLM and agent operations, enabling correlation of AI calls across agent systems using standard distributed tracing infrastructure.

## What they standardize

Two layers of conventions:

**LLM span attributes** — model, request parameters (temperature, max tokens), token counts (input, output), and completion content. Structured attributes include `gen_ai.provider.name`, `gen_ai.request.model`, `gen_ai.usage.input_tokens`, `gen_ai.usage.output_tokens`. These cover Layer 1 (action logging) and Layer 3 (decision context) of the [[observability-stack]] partially.

**Agent span operations** — `create_agent` and `invoke_agent` operations with `gen_ai.agent.name`, `gen_ai.agent.id`, `gen_ai.agent.description`, and `gen_ai.agent.version` attributes. Extends LLM spans with agent-specific identity and lifecycle telemetry, moving toward complete Layer 1 coverage for agent operations.

## What they do not cover

The standards gap is at Layers 2 and 4 of the [[observability-stack]]:

- **Layer 2 (delegation chain)**: no attributes for OBO token scope, delegator identity, or token expiry. Who authorized the agent to act is outside the spec.
- **Layer 4 (semantic causality)**: no agent-specific trace propagation for inter-agent semantic dependencies. Standard W3C Trace Context headers handle synchronous call chains; agents reading shared data stores require explicit trace ID injection at the read point, which the conventions do not specify.
- **Layer 5 (fleet aggregation)**: no fleet-level aggregation specification.

## Where it fits

OTel GenAI conventions are the right starting point for organizations already using OpenTelemetry. They handle what the agent *did* (tool calls, latency, token consumption) and which agent did it, which is what debugging and performance monitoring require. They do not handle what *authorized* the action, which is what compliance and [[decision-provenance]] require.

The eventual accountability standards at Layers 2 and 4 will need to be OTel-compatible to reach production: any layer that cannot integrate with distributed tracing infrastructure will be adopted in isolation rather than as part of a unified observability pipeline.

## Connections

- [[observability-stack]] — covers Layers 1 and 3 partially; Layers 2, 4, 5 remain outside the spec
- [[decision-provenance]] — Layer 3 attributes (model ID, model version) overlap with OTel `gen_ai.request.model`; delegation chain (Layer 2) is outside OTel scope
- [[causal-graph]] — Layer 4 semantic causality requires trace context propagation beyond what OTel currently specifies for agents
- [[obo-token-exchange]] — the credential format that Layer 2 logging would capture; not yet in OTel attributes
