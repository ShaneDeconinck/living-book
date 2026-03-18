---
title: Non-Determinism Gap
tags: [security, reliability, frameworks, gap]
dimension: reliability
---

The systematic failure of existing security frameworks to address the non-deterministic nature of LLM-based agents. Nguyen et al.'s cross-framework analysis found a mean coverage score of 1.231 out of 5 across sixteen evaluated frameworks, making non-determinism the most under-addressed threat domain in agent security.

## Why it is fundamental

Agentic systems are not deterministic. The same input, the same agent, the same tools can produce different outputs across runs. Security properties verified at test time may not hold at runtime. An agent behaving correctly in staging may behave incorrectly in production under different context.

The frameworks assume a more predictable adversary. The threat models are built for systems where you can reproduce a failure path. Agent failures may not be reproducible because the underlying model's behavior varies with context window contents, token sampling, and inference conditions.

## How PAC addresses it indirectly

The Control pillar scopes agents to minimum necessary actions and audits every action taken. This bounds non-deterministic behavior even if it cannot be eliminated: if the agent can only do three things, non-determinism affects which of the three it chooses and how, not whether it reaches systems it should not touch.

But no framework addresses non-determinism directly. A standard built on current frameworks inherits this gap.

## The testing problem

Adaptive security benchmarks (identified in Perplexity's [[nist-caisi]] submission) would test security properties under conditions that reflect production non-determinism, not just fixed test cases. This does not exist yet. The organization that builds a credible approach to testing security under non-deterministic conditions is building infrastructure with no current substitute.

## Connects to

- [[cascading-failure]] — non-determinism makes cascade paths unpredictable; the same agent chain can fail differently each run
- [[nist-caisi]] — the gap Nguyen et al. surfaced will enter the CAISI standards process
- [[owasp-agentic-top10]] — OWASP leads at 65.3% but does not cover non-determinism well
- [[benchmark-landscape]] — current benchmarks assume reproducibility; non-determinism breaks that assumption
- [[adaptive-security-benchmarks]] — the testing methodology needed to evaluate security under non-deterministic conditions
- [[blast-radius]] — non-deterministic behavior means blast radius is probabilistic, not deterministic

## Sources

- [Nguyen 2026]: Nguyen et al., "A Taxonomy of Agentic AI Security Threats and Multi-Agent Framework Security Analysis," arXiv:2603.09002, March 9, 2026. Non-determinism mean coverage: 1.231/5 across 16 frameworks.
- [Perplexity 2026]: Li et al., arXiv:2603.12230, March 12, 2026. Identifies adaptive security benchmarks as a standards gap.
