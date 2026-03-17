---
title: Agent Benchmark Landscape
tags: [evaluation, reliability, benchmarks]
---

The ecosystem of agent reliability benchmarks, each measuring different capability dimensions with different blind spots.

Four benchmarks dominate the current landscape:

**[[swe-bench]] Verified** (500 human-validated GitHub issues) — the most cited coding agent benchmark. Measures task completion in controlled conditions: clear specification, defined codebase, existing test suite. Top scores have climbed steadily. Limitation: static conditions do not predict performance in interactive, unpredictable environments.

**τ-bench (Tau-bench)** (Sierra) — tests agents in dynamic settings with real-time user interaction and tool use. Exposed a critical gap: agents built with standard constructs (function calling, ReAct) performed poorly on relatively simple tasks when the environment was interactive. Static benchmarks did not predict this.

**GAIA** — tests general AI assistants on multi-step reasoning, web browsing, and tool use across domains. As of mid-2025, top Level 3 score: 61%. Level 3 tasks are ones a competent human assistant would handle routinely.

**HAL (Holistic Agent Leaderboard)** (Princeton) — aggregates results across SWE-bench Verified Mini, GAIA, and others into a unified view. Accepted to ICLR 2026. No single benchmark captures reliability across all dimensions.

**[[agentshield]]** (March 2026) — the first open, reproducible evaluation of commercial AI agent security products. 7 products, 537 test cases, 8 categories. Key finding: tool abuse detection is weak across the board even when prompt injection detection scores above 95%. The [[confused-deputy]] operating through legitimate tool calls is the under-defended vector.

## The benchmark gap

Benchmarks measure capability. Governance requires post-deployment monitoring. Agents perform well on structured, repeatable tasks (coding with clear specs) and struggle on open-ended interactive ones. The LangChain 2026 survey found 52% of organizations run offline evaluations before deployment, but only 37% monitor agents in production. That 15-point drop is where governance breaks down.

NIST AI 800-2 (draft, March 2026 public comment) aims to standardize benchmark construction and reporting. For organizations using benchmark scores to gate autonomy levels (as [[pac-framework]] recommends), standardized methodology is a governance input, not just a technical concern.

## Connects to

- [[evaluation-as-governance]] — benchmarks are pre-deployment; governance requires post-deployment monitoring
- [[complacency-trap]] — high benchmark scores increase complacency in production
- [[reliability]] — consistency, robustness, predictability, safety are four dimensions no single benchmark covers
- [[agentshield]] — security-specific benchmark revealing the tool abuse blind spot
- [[observability-stack]] — what post-deployment monitoring looks like at I3+
