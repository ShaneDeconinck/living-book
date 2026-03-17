---
title: Context Engineering
tags: [practice, potential, architecture, agents]
---

The emerging discipline of managing what information enters an agent's context window: writing it, selecting it, compressing it, and isolating it across agents or turns.

## The Four Operations

Lance Martin's framework identifies the core operations:

1. **Writing context** — saving information outside the context window for later retrieval
2. **Selecting context** — pulling the right information in at the right time
3. **Compressing context** — retaining only the tokens required for the task
4. **Isolating context** — splitting context across agents or turns to avoid interference

## Production Patterns

**Claude Code** uses no vector databases or embeddings. Teams maintain `CLAUDE.md` files in git. When the model makes a mistake, they write a sentence in the context file, not code. Simple files, continuously curated, degrading gracefully as models improve.

**Manus** treats KV-cache hit rate as the single most important metric. Their agents have ~100:1 input-to-output token ratios. Derived principles: do not dynamically add or remove tools (invalidates cache), break repetitive patterns, use the filesystem as memory, keep errors in context. They rebuilt their framework four times, each time shaping context better rather than adding more [[scaffolding-trap|scaffolding]].

## Why It Matters

Context engineering is what sits between [[context-infrastructure]] (the organizational knowledge layer) and the model. Infrastructure provides the durable knowledge; context engineering manages how that knowledge reaches the model at inference time.

The discipline emerged because the context window is the primary interface between an organization's knowledge and an agent's capabilities. Getting the right information in, at the right granularity, with the right permissions, is the runtime complement to the structural investment in context infrastructure.

## Connects to

- [[context-infrastructure]] — the organizational layer that context engineering draws from
- [[scaffolding-trap]] — context engineering replaces scaffolding as the primary lever for agent performance
- [[mcp]] — the discovery protocol that enables systematic context selection

## Sources

- Lance Martin, "Context Engineering for Agents," rlancemartin.github.io, June 23, 2025
- Manus, "Context Engineering for AI Agents: Lessons from Building Manus," 2026
- Anthropic Engineering Blog, "Effective context engineering for AI agents," September 29, 2025
- src/chapters/context-infrastructure.md
