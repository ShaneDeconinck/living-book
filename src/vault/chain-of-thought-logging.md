---
title: Chain-of-Thought Logging
tags: [observability, accountability, reasoning, compliance]
dimension: audit-trails
---

Chain-of-thought (CoT) logging captures the intermediate reasoning steps a model produces before acting — the internal monologue visible in extended-thinking architectures. It is forensically valuable but not cryptographic evidence of what determined the output.

## What it captures

Models with extended thinking produce visible reasoning traces: the sequence of intermediate conclusions the model formed before arriving at a final response or action. CoT logging records this trace alongside the final completion, revealing what the model attended to and how it framed the problem.

This is useful for incident investigation: when an agent takes an unexpected action, a CoT log can surface what framing the model was operating under, which inputs it weighted, and what intermediate conclusions it drew. It answers "what was the model saying it was thinking?" — which is often enough to identify the failure mode.

## The evidentiary limit

CoT logs are not cryptographic evidence that the trace drove the computation. Models can produce coherent reasoning traces without those traces determining the output: the reasoning looks like the cause, but the weights-level computation may have reached the same output independently.

The distinction matters for compliance. A CoT log is evidence that a reasoning trace existed at decision time. It is not proof that the trace controlled the decision.

The EU AI Act requires high-risk AI systems to implement measures to facilitate interpretation of model outputs (Article 13(3)(d)) and documentation of capabilities and limitations. No published guidance as of March 2026 addresses whether CoT logs satisfy these requirements. Treat them as forensic context, not as a substitute for [[decision-provenance]] layers 2 and 3, which are cryptographically bound to outcomes.

## Inference-time monitoring: a different approach

Realm Labs' Prism tool (RSAC 2026 Innovation Sandbox finalist) takes a structurally different approach: monitoring attention patterns and internal chain-of-thought *during* inference, enabling intervention before misbehavior propagates rather than logging it afterward. This is not CoT logging — it is real-time reasoning inspection with enforcement capability. The architectural distinction: logging captures what happened; inference-time monitoring can block what would have happened.

OpenAI Atlas hardening uses RL-powered automated red teaming (an automated attacker reasons through candidate injections and tests them in simulation) rather than either CoT logging or inference-time monitoring. Defense is adversarial training of the defense model, not reasoning observation.

## What to do with it

- Log reasoning traces for extended-thinking models with the same rigor as action logs. Incomplete evidence is better than none.
- Use inference-time monitoring (not only post-hoc logging) for agents where intervention before action is feasible — especially high blast-radius decisions.
- Communicate the gap to compliance teams: CoT evidence shows a reasoning trace existed at decision time; it does not prove the trace determined the output.
- [[decision-provenance]] Layer 3 (model ID, system prompt hash, context window state) plus CoT logging together provide more accountability signal than either alone.

## Connections

- [[decision-provenance]] — CoT logging supplements but does not replace cryptographically-bound provenance
- [[blast-radius]] — inference-time monitoring is most warranted at high blast-radius thresholds
- [[accountability-pillar]] — reasoning transparency is the forensic layer above the structural accountability layers
- [[tamper-evident-logging]] — CoT logs have the same tamper concerns as action logs; same infrastructure principles apply
- [[inference-time-monitoring]] — the real-time complement to post-hoc CoT logging; operates during inference rather than after
