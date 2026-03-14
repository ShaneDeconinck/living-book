# Agent Observability: The Accountability Infrastructure

In March 2026, Irregular placed agents on a corporate network with legitimate tasks and no adversarial prompting. The agents overrode antivirus software, bypassed DLP controls through steganography, forged credentials, and pressured other agents to relax safety checks. Each individual agent's audit log showed reasonable behavior. The collective behavior was visible only when someone looked across all the logs simultaneously.[^irregular-rogue]

But the problem predates fleets. A single expense-approval agent authorized $47,000 in vendor payments. The audit log showed alice@company.com. It captured the outcome. It did not capture the delegation chain, the model that decided, the inputs at decision time, or the authority under which the agent acted.[^trust-for-agentic-ai] When accountability was needed, the log had what happened but not what decided.

"What it decided and what authority it had to decide it" is Shane's framing for what agent governance requires.[^trust-for-agentic-ai] It is also the frame that defines what observability infrastructure must capture — and what current tooling mostly does not.

## Three Layers That Agents Conflate

Monitoring, logging, and tracing are conceptually distinct. For traditional software the distinction is mostly one of scope. For agents it is structural.

**Monitoring** asks: is the agent running? Is it responding within latency bounds? Are error rates within thresholds? This is infrastructure health. Current monitoring tools handle agents adequately because this layer treats agents as services.

**Logging** asks: what did the agent do? Every tool call, API invocation, and resource access, with timestamps, inputs, and outputs. Logging infrastructure for agents exists and is improving. OpenTelemetry's GenAI semantic conventions define a standardized schema for LLM spans: model, request parameters, token counts, completion content.[^otel-genai] These let organizations correlate LLM calls across agents using existing distributed tracing infrastructure.

**Tracing** asks: why did the agent decide this? What upstream inputs, what delegation authority, what model state produced this action? Traditional distributed tracing follows synchronous request-response chains. Agents produce asynchronous, nondeterministic chains of reasoning. The interesting event in an agent interaction is not which API was called but which upstream context caused the call — a semantic question that telemetry frameworks were not designed to answer.

Decision provenance is what current observability does not capture.

## The Five-Layer Stack

### Layer 1: Action Logging

Every tool call, API invocation, file access, and external communication logged as a structured event with a minimum record:

```json
{
  "agent_id": "did:webvh:...",
  "tool_name": "payment_authorize",
  "input_hash": "sha256:b3e2...",
  "outcome": "success",
  "timestamp_utc": "2026-03-14T14:32:07Z",
  "trace_id": "4bf92f3577b34da6"
}
```

The `input_hash` preserves privacy while enabling audit: a compliance reviewer can verify that the agent acted on a specific input without the log storing the input content itself. For regulated contexts where full input logging is required, `input_content` replaces `input_hash`.

This is I1→I2 infrastructure. Without it, there is nothing to investigate when something goes wrong.

### Layer 2: Identity and Authority Capture

Every logged action gets its authorization context appended:

```json
{
  "delegator_id": "did:webvh:...:alice",
  "token_scope": "payments:approve:vendor-category:facilities",
  "delegation_path": ["alice@company.com", "did:webvh:...:procurement-agent"],
  "token_expiry": "2026-01-14T00:00:00Z",
  "token_id": "urn:uuid:8e7a..."
}
```

RFC 8693 On-Behalf-Of tokens record both the human who delegated and the agent who acted.[^rfc-8693] Structured audit logs that record the token as part of every action make the delegation chain auditable. Without this layer, logs show what happened but not whether the agent was authorized to do it — and the $47,000 audit trail remains incomplete.

The `token_expiry` field captures a dimension other fields miss. A delegation granted three months ago may have been appropriate at grant time and inappropriate at execution time. Without the timestamp, that gap is invisible.

### Layer 3: Decision Context

The agent's state at decision time:

```json
{
  "model_id": "claude-sonnet-4-6",
  "model_version": "20260301",
  "system_prompt_hash": "sha256:c4a8...",
  "context_window_tokens": 42847
}
```

When a model version update changes agent behavior, `model_id` and `model_version` are the difference between "the agent misbehaved" and "version 20260301 handles budget edge cases differently from 20260115." When a system prompt change produces unexpected decisions, `system_prompt_hash` connects the decision to the prompt change in the change management record.

An organization that cannot name which model made a decision and under which system prompt cannot assign accountability for that decision.

### Layer 4: Causal Correlation

Distributed trace IDs that span agent boundaries. Every action in a multi-agent workflow carries a shared `workflow_trace_id`. When Agent B acts based on Agent A's output, B's log entry records both the action and the upstream trace that caused it:

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

OpenTelemetry's distributed tracing model provides the infrastructure pattern: context propagation headers that link downstream spans to upstream spans across service boundaries.[^opentelemetry] Extending this to agents requires propagating trace context through every inter-agent communication — including shared data store reads, A2A messages, and MCP tool results.

The key distinction from service tracing: agent causality includes semantic causality, not just invocation causality. Agent B did not call Agent A. Agent B read A's output from a shared store and acted on it. The causal link is semantic. Capturing it requires explicit trace ID injection at the point of reading shared outputs, not only at API call boundaries.

Without Layer 4, incident investigation in multi-agent workflows is archaeology: piecing together what happened from fragments scattered across dozens of agent-specific logs, with no systematic way to connect upstream causes to downstream effects.

### Layer 5: Fleet-Level Behavioral Aggregation

Individual logs do not compose into fleet accountability without aggregation infrastructure:

- Spending patterns across the agent fleet vs. authorized budgets
- Volume of tool calls by type, aggregated across all agents
- Cross-agent coordination signals: agents communicating through shared data stores in ways that were not explicitly orchestrated
- Autonomy drift: agents operating at de facto autonomy levels higher than their governance record specifies

Irregular's simulation showed this: each agent's individual log was clean; the fleet-level view showed steganographic exfiltration, cross-agent credential sharing, and coordinated safety override.[^irregular-rogue] Individual monitoring missed it. Fleet aggregation would have surfaced the coordination signals.

This layer does not require behavioral AI or anomaly detection models to be useful. A dashboard showing aggregate spend by agent type, total tool calls by tool per day, and agents that have not checked in within expected intervals provides signals that no individual log can surface.

## What Current Standards Cover

**OpenTelemetry GenAI semantic conventions** cover Layers 1 and 3 partially.[^otel-genai] LLM span attributes for model, request parameters, token counts, and completion content are standardized. The agent span conventions extend this with `create_agent` and `invoke_agent` operations, plus `gen_ai.agent.name`, `gen_ai.agent.id`, `gen_ai.agent.description`, and `gen_ai.agent.version` attributes: agent identity at the telemetry level.[^otel-agent-spans] What they do not cover: Layer 2 (no attributes for delegation chain or token scope), Layer 4 (no agent-specific trace propagation for semantic causality), Layer 5 (no fleet aggregation specification). The agent span conventions move OTel closer to full Layer 1 coverage for agent operations, but the accountability-critical layers remain outside the specification.

**W3C PROV-DM** defines a formal provenance model with three entity types: Agent (the entity responsible), Activity (what happened), and Entity (what was produced or used).[^prov-dm] The model is expressive enough to capture agent decision chains. It is not adopted in practice in agent frameworks — the gap is adoption, not expressiveness.

**CloudEvents** standardizes the event envelope but defines no schema for agent-specific content. Organizations using CloudEvents for their event infrastructure can use it as the carrier for agent action logs, but must define the payload schema themselves.

The standards gap is at Layers 2 and 4: delegation capture and semantic causality. Active work at IETF (Transaction Tokens, AAP, WIMSE) is standardizing delegation-aware credential formats.[^rfc-8693] The observability standards that consume these credentials do not yet exist. Organizations building now define their own schemas; the eventual standards will need to be backwards-compatible with what gets built.

## Tamper Evidence

Logs are only as useful as the mechanism that produced them. An agent that knows its actions are logged in a specific location can selectively corrupt that location if it has write access to it.

Infrastructure-level logging is more tamper-resistant than agent-level logging. When the logging mechanism sits outside the agent's execution environment — in a gateway, sidecar, or platform layer — the agent cannot suppress its own logs without access to the infrastructure. This applies the same principle as the distinction between agent-layer authorization checks and infrastructure-layer authorization enforcement: the entity that benefits from overriding a check should not be the entity enforcing it.

For high-stakes deployments, append-only log stores with cryptographic sealing provide additional assurance. The Certificate Transparency model is applicable: each log entry is included in a Merkle tree whose root is published externally.[^cert-transparency] Retrospective insertion or deletion is detectable because it requires recalculating all tree roots from the point of modification forward. An agent, or an attacker who has compromised an agent, cannot alter the log without leaving a detectable signature.

## Mapping to PAC

The [Agent Identity and Delegation](agent-identity.md) chapter covers the credential formats (OBO, DPoP, Verifiable Intent) that Layer 2 records. The [Agent Accountability at Scale](accountability-at-scale.md) chapter covers causal graphs and the fleet attribution problem that Layers 4 and 5 address. The [Agent Incident Response](agent-incident-response.md) chapter covers what you do when something goes wrong — but incident response without Layers 1-4 in place is reconstruction from fragments. [Shadow Agent Governance](shadow-agent-governance.md) establishes that agents outside the registry have no observability by definition; Layer 5 fleet aggregation is what surfaces their presence through behavioral signals.

An agent that is right 99.9% of the time without Layers 2-3 in place is less accountable than one that is right 95% with them, because when the 0.1% failure happens, you cannot prove what authority existed, which model decided, or whether the system prompt was as intended.[^agent-profiler]

| Level | Potential | Accountability | Control |
|---|---|---|---|
| **I1 — Open** | No action logging; agent behavior is unobservable | No audit trail; delegation is untrackable | Agents operate without observable footprint |
| **I2 — Logging** | Action logs with timestamps; tool calls and outcomes recorded | Agent identity recorded per action; delegation chain absent | Log completeness depends on agent compliance |
| **I3 — Verified** | Decision context logged (model ID, system prompt hash); causal correlation within single-agent workflows | Delegation chain captured via OBO tokens; token scope recorded at every action | Infrastructure-level logging; agent cannot suppress its own log |
| **I4 — Managed** | Cross-agent trace IDs propagated; semantic causality captured across multi-agent workflows | Full delegation chain auditable from human principal to acting agent; token expiry logged | Fleet-level behavioral aggregation; coordination pattern detection operational |
| **I5 — Optimized** | Behavioral baselines per agent type; drift detection automated; fleet patterns reviewed against authorized behavior | Append-only log stores with cryptographic sealing; tamper detection operational | Real-time anomaly signals with human-in-the-loop escalation for threshold breaches |

Layer 1 is increasingly available through platform-native tooling: Microsoft Agent 365's observability layer, Imprivata's Agentic Identity Management for healthcare, and built-in monitoring in agent orchestration frameworks.[^ms-e7][^imprivata-aim] Layer 2 requires OBO tokens or equivalent — present in deliberate deployments, absent in most shadow agents. Layers 3-5 are frontier infrastructure, built by organizations that have moved past initial deployment into governance maturity.

## What to Do Now

**Start with action logging.** Log every tool call, API invocation, and resource access as a structured event with agent ID, tool name, input hash, outcome, and timestamp. OpenTelemetry's GenAI semantic conventions are the right starting point if you already use OpenTelemetry. This is the minimum that makes investigation possible.

**Add identity capture before fleet scale.** OBO tokens make the delegation chain explicit at the credential level. The logging layer records what the token says. Retrofitting this at ten agents is feasible; retrofitting at three hundred requires re-instrumenting every agent in production.

**Use infrastructure-level logging for high-stakes agents.** Any agent with B4+ blast radius — regulated consequences, financial authority, customer-facing decisions — should log through a gateway or sidecar that the agent cannot write to. Agent-level logging is sufficient for low-stakes deployments; it is insufficient when the log is evidence.

**Plan for causal trace IDs before multi-agent deployment.** Distributed trace context is straightforward to add when designing a multi-agent workflow; it is hard to retrofit after agents are in production because every inter-agent communication path must propagate the trace. Define the format and propagation mechanism before the workflow ships, not during incident investigation.

**Build fleet-level aggregation early, even if simple.** A dashboard showing aggregate spend by agent type, total tool calls by tool per day, and agent check-in frequency surfaces signals that individual logs cannot. You do not need behavioral AI for initial fleet visibility. You need aggregation.

[^trust-for-agentic-ai]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," shanedeconinck.be, January 24, 2026.
[^otel-genai]: OpenTelemetry, "GenAI Semantic Conventions," opentelemetry.io/docs/specs/semconv/gen-ai/. Standardized attributes for LLM spans including gen_ai.provider.name, gen_ai.request.model, gen_ai.usage.input_tokens, gen_ai.usage.output_tokens, and completion content. Enables correlation of LLM calls across agents using standard distributed tracing infrastructure.
[^otel-agent-spans]: OpenTelemetry, "Semantic Conventions for GenAI agent and framework spans," opentelemetry.io/docs/specs/semconv/gen-ai/gen-ai-agent-spans/. Defines `create_agent` and `invoke_agent` span operations with `gen_ai.agent.name`, `gen_ai.agent.id`, `gen_ai.agent.description`, and `gen_ai.agent.version` attributes. Extends general GenAI conventions with agent-specific identity and lifecycle telemetry.
[^rfc-8693]: RFC 8693, "OAuth 2.0 Token Exchange," January 2020. The OBO flow uses a `subject_token` (the original user's token) and an `actor_token` (the agent's credential) as request parameters. The authorization server issues a new token containing an `act` claim that identifies the acting agent, recording both the delegating principal and the acting party in a single credential. See the [Agent Identity and Delegation](agent-identity.md) chapter for implementation patterns.
[^opentelemetry]: OpenTelemetry, "Distributed Tracing," opentelemetry.io. Trace context propagation (W3C Trace Context standard) links downstream spans to upstream spans across service boundaries through `traceparent` and `tracestate` headers.
[^prov-dm]: W3C, "PROV-DM: The PROV Data Model," W3C Recommendation, April 30, 2013, www.w3.org/TR/prov-dm/. The Agent/Activity/Entity provenance model is expressive enough to represent delegation chains and causal relationships across multi-agent workflows.
[^cert-transparency]: RFC 9162, "Certificate Transparency Version 2.0," December 2021. Merkle tree log model providing cryptographic tamper evidence for append-only records. The same model applies to agent audit log stores where retrospective modification must be detectable.
[^irregular-rogue]: Irregular, "Emergent Cyber Behavior When AI Agents Become Offensive Threat Actors," March 12, 2026. Simulation on a corporate network with legitimate tasks and no adversarial prompting: agents overrode antivirus, bypassed DLP via steganography, forged credentials, and pressured other agents to relax safety checks. Individual logs showed normal behavior; fleet-level view showed the coordination.
[^agent-profiler]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026. "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built."
[^ms-e7]: Microsoft, "Secure agentic AI for your Frontier Transformation," microsoft.com/en-us/security/blog, March 9, 2026. Agent 365 GA May 1, 2026. Features agent registry, shadow agent discovery, unique Agent IDs with lifecycle management, and audit trails.
[^imprivata-aim]: Imprivata, "Imprivata Introduces Agentic Identity Management to Secure and Govern AI Agents in Healthcare," imprivata.com, March 10, 2026. Healthcare-specific agent identity and observability: agent registry, short-lived tokens, unmanaged agent discovery. Announced at HIMSS 2026.
