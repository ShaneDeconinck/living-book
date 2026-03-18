---
title: Agent Data Leakage
tags: [security, privacy, context, gap]
dimension: data-governance
---

Data leakage through agent context aggregation: agents collect information from multiple sources into a single working context, creating a unified exfiltration surface that does not exist in traditional systems.

## Why agents make this worse

Traditional data leakage happens when a system exposes one data source through one pathway. Agent data leakage is different because agents hold context from conversation history, tool results, retrieved documents, and prior session state simultaneously. A single leak can expose multiple data sources at once.

The pathways are numerous and mostly undocumented: through tool calls that send context to external services, through generated outputs that include retrieved data, through reasoning traces stored for [[chain-of-thought-logging]], through context windows shared across multi-agent handoffs.

## The framework gap

Nguyen et al.'s cross-framework analysis [Nguyen 2026] found data leakage at a mean coverage score of 1.340/5 across sixteen evaluated frameworks, the second most under-addressed threat domain after [[non-determinism-gap]] (1.231/5). No framework the study evaluated has a comprehensive model for agent context aggregation as a data leakage vector.

The gap exists because the threat model is new. Prior data governance assumed the system that processes data is the system that stores it. Agents break that assumption: they retrieve from one system, reason across multiple sources, and act on another. The data never "moves" in the way traditional DLP systems monitor.

## How PAC addresses it

The [[observability-stack]] chapter addresses the audit side: agent action logs and context logs record what data entered the context and what left it. [[containment-by-design]] limits which systems an agent can reach, bounding the aggregation surface. But neither constitutes a formal threat model for context aggregation leakage.

## Connects to

- [[non-determinism-gap]] — the other critically under-addressed domain; together they define what makes agent security structurally different from prior AI security
- [[context-infrastructure]] — the same aggregation that makes agents useful creates the leakage surface
- [[context-poisoning]] — related but distinct: poisoning corrupts the context; leakage exposes it
- [[nist-caisi]] — the gap will enter the CAISI standards process via the Nguyen taxonomy
- [[observability-stack]] — the current best defense: log what enters and exits context
- [[mcp]] — tool calls are a primary leakage pathway; MCP-mediated tools send context to external services

## Sources

- [Nguyen 2026]: Nguyen et al., arXiv:2603.09002, March 9, 2026. Data leakage mean coverage: 1.340/5 across 16 frameworks.
- [Perplexity 2026]: Li et al., arXiv:2603.12230, March 12, 2026. Identifies context aggregation as production attack surface.
