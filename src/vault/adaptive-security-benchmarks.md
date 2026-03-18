---
title: Adaptive Security Benchmarks
tags: [testing, non-determinism, security, gap]
dimension: reliability
---

Security evaluation methods that test properties under conditions reflecting production non-determinism, not just fixed test cases.

## Why current benchmarks fall short

Existing security benchmarks for AI systems assume reproducibility: run the same input, get the same output, verify the same property. LLM-based agents break this assumption. The same agent with the same input can produce different outputs across runs due to token sampling, context window contents, and inference conditions. A security property verified at test time may not hold at runtime.

This means standard red-teaming and evaluation methodologies produce results that are snapshots, not guarantees. An agent that passes a security benchmark in staging may fail the same property in production under different context conditions. The gap between test-time verification and runtime behavior is the [[non-determinism-gap]] applied to evaluation.

## What adaptive benchmarks would need

Perplexity's [[nist-caisi]] submission identifies adaptive security benchmarks as a standards gap. The requirements are structural:

- **Stochastic evaluation:** Run the same security test multiple times under varied conditions and report pass rates, not binary pass/fail
- **Context variation:** Test security properties under different context window states (empty, partially filled, adversarially crafted)
- **Temporal drift:** Evaluate whether security properties degrade over long-running agent sessions as context accumulates
- **Multi-agent interaction:** Test cascading security properties when agents hand off to other agents, since [[cascading-failure]] paths are non-deterministic

No framework evaluated in the Nguyen taxonomy [Nguyen 2026] has a comprehensive model for this. The organization that builds a credible approach to testing security under non-deterministic conditions is building infrastructure with no current substitute.

## Connects to

- [[non-determinism-gap]] — the fundamental problem adaptive benchmarks would address; mean framework coverage 1.231/5
- [[benchmark-landscape]] — current benchmarks assume deterministic evaluation; adaptive benchmarks would replace or supplement them
- [[nist-caisi]] — Perplexity's submission names this as a priority standards gap
- [[reliability]] — security reliability under non-determinism is a subset of the broader reliability question
- [[evaluation-as-governance]] — if evaluation becomes a governance mechanism, it must account for non-determinism to be trustworthy
- [[blast-radius]] — non-deterministic behavior means blast radius is probabilistic; benchmarks must express this

## Sources

- [Nguyen 2026]: Nguyen et al., arXiv:2603.09002, March 9, 2026. Non-determinism mean coverage: 1.231/5 across 16 frameworks.
- [Perplexity 2026]: Li et al., arXiv:2603.12230, March 12, 2026. Identifies adaptive security benchmarks as a standards gap.
