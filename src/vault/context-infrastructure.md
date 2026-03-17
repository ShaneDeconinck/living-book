---
title: Context Infrastructure
tags: [framework, potential, architecture]
---

The organizational knowledge management layer that agents consume: structured information, access permissions, discovery protocols, authority scoping, and freshness guarantees.

Every wave of AI infrastructure (fine-tuning, RAG, scaffolding) deprecated as models improved, but context infrastructure compounds. When a better model arrives, an organization with mature context infrastructure captures more value; one without it gets a more capable model running on the same mess.

## Five dimensions

- **Structure**: coherent, domain-modeled information — entities with attributes, policies as structured rules, not PDFs
- **Permissions**: fine-grained access controls matching the delegating user's authority for this specific task
- **Discovery**: protocols like [[mcp]] and [[a2a]] for finding tools and agents; standardized, not custom pipelines
- **Authority**: access scoped to what the user is allowed to see, for this task — [[obo-token-exchange]] and PIC implement this
- **Freshness**: up-to-date or versioned with staleness signals; stale context produces wrong decisions at machine speed

## Why it endures

The [[scaffolding-trap]] explains why scaffolding depreciates while context appreciates. Every model upgrade that makes scaffolding redundant also makes richer context more valuable. The ROI compounds because every model, every agent, every future use case benefits from the same infrastructure.

Clawdbot illustrates both sides: rich context (SOUL.md, structured goals) made it compelling; missing access controls made it dangerous. Context without permissions is a liability.

## Connects to

- [[mcp]] — the discovery protocol layer of context infrastructure
- [[a2a]] — agent-to-agent discovery within context infrastructure
- [[obo-token-exchange]] — the authority scoping mechanism
- [[scoped-authorization]] — permission boundaries aligned with delegating user's authority

## Appears in

- **AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment** (`posts/ai-agents-context-infrastructure-long-term-investment`, 2026-02-09) — central thesis; five investment dimensions detailed
- **AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting.** (`posts/ai-agent-scaffolding-trap`, 2026-02-02) — context as the durable layer when scaffolding is stripped away
- **Fitting Agentic AI Components in a Mental Model** (`posts/fitting-agentic-ai-components-in-a-mental-model`, 2026-01-06) — context as framework + runtime + harness

## Sources

- Shane Deconinck, "AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment," shanedeconinck.be, February 9, 2026
- src/chapters/context-infrastructure.md
