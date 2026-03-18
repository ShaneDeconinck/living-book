---
title: AgentShield Benchmark
tags: [evaluation, security, benchmarks, tools]
---

The first open, reproducible evaluation of commercial AI agent security products [AgentShield March 2026].

## What it measures

7 commercial products, 537 test cases, 8 categories. Composite scores range from approximately 39 to 98 — a spread that reflects genuine capability differences between products. Scores above 90 and below 50 exist in the same market.

## The tool abuse blind spot

The most important finding cuts across all products: tool abuse detection is weak even when prompt injection detection is strong. Several products scoring above 95% on prompt injection miss most unauthorized tool calls.

The [[confused-deputy]] operating through legitimate tool calls with legitimate credentials is the under-defended vector. The industry built increasingly sophisticated defenses against [[prompt-injection]] because it dominated the threat taxonomy. But agents do not just process prompts — they invoke tools. An agent fully protected against prompt injection but not against unauthorized tool use is protected against one attack vector while leaving the more operationally dangerous one open.

This validates a structural claim: governance evaluation must be multi-dimensional. An agent security product scoring 98% on prompt injection and 40% on tool abuse provides a false sense of security.

## Evaluation integrity

AgentShield includes a commit-reveal protocol that allows vendors to run the benchmark locally on proprietary models while cryptographically proving result legitimacy. This addresses the "evaluate the evaluator" problem: when the entity being evaluated controls the evaluation environment, independent verification matters.

Related: when model providers acquire evaluation tooling (OpenAI's acquisition of Promptfoo, March 2026), the structural independence of evaluation erodes. The commit-reveal approach is one answer to this — embedding cryptographic proof into the benchmark itself so results can be trusted without trusting the runner.

## Governance implication

The governance question is not "is this agent protected?" but "protected against which threat categories, at what coverage level?" At I4 (Authorized), evaluation must cover the full attack surface. See [[infrastructure-levels]].

## Connects to

- [[benchmark-landscape]] — AgentShield is the security-specific benchmark in the landscape
- [[confused-deputy]] — the under-defended vector AgentShield exposes
- [[prompt-injection]] — the over-defended vector that distorts security product investment
- [[evaluation-as-governance]] — why multi-dimensional evaluation is a governance requirement, not just engineering

## Sources

- [AgentShield 2026]: AgentShield, "AgentShield Benchmark: AI Agent Security Product Comparison," github.com/doronp/agentshield-benchmark, March 2026. Open-source, 7 products, 537 test cases, 8 categories.
