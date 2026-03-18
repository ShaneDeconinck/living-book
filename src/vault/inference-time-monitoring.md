---
title: Inference-Time Monitoring
tags: [observability, control, reasoning, security]
dimension: audit-trails
---

Real-time inspection of a model's internal state during inference, enabling intervention before an action propagates rather than logging it afterward.

## How it differs from logging

[[chain-of-thought-logging]] captures reasoning traces after the fact. Inference-time monitoring operates during computation: reading attention patterns, internal activations, or chain-of-thought as the model processes inputs. The architectural distinction is temporal. Logging answers "what did the model say it was thinking?" Inference-time monitoring can answer "what is the model attending to right now?" and block an action before it executes.

## The faithfulness problem

Logged reasoning traces may not be faithful to the computation that produced the output. A model can generate a coherent explanation that does not reflect the weights-level process that determined the answer. This is the evidentiary limit of [[chain-of-thought-logging]].

Inference-time monitoring at the attention layer is an attempt to close this gap. Instead of reading what the model says about its reasoning, it reads what the model is actually attending to. Whether attention patterns are interpretable and reliable signals of intent is an open research question being forced into production by tools like Realm Labs' Prism (RSAC 2026 Innovation Sandbox finalist).

## Production state

Realm Labs' Prism is the first production deployment of inference-layer monitoring. It monitors attention patterns and internal chain-of-thought during inference, paired with OmniGuard (an AI firewall) for runtime enforcement. This places the enforcement point at the decision layer rather than the action layer.

The open question: does attention-pattern monitoring scale across model architectures, and does it remain interpretable as models grow? If attention is not a reliable proxy for decision causality, inference-time monitoring becomes a more sophisticated form of heuristic detection rather than verified reasoning inspection.

## Connects to

- [[chain-of-thought-logging]] — the post-hoc complement; inference-time monitoring is the real-time version
- [[decision-provenance]] — inference-time monitoring can produce provenance signals closer to the actual computation than logged traces
- [[blast-radius]] — most warranted for high blast-radius decisions where intervention before action matters
- [[accountability-pillar]] — shifts accountability from "we can explain what happened" to "we can intervene before it happens"
- [[autonomy-levels]] — higher autonomy levels (A4-A5) benefit most from pre-action monitoring since human review is not in the loop
