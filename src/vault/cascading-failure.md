---
title: Cascading Failure
tags: [security, multi-agent, failure-modes, observability]
---

A single fault in a multi-agent system — hallucination, prompt injection, corrupted data — that propagates through agent-to-agent communication and amplifies into system-wide harm. OWASP ASI08.

## Three properties that make it worse than distributed systems

**Semantic propagation.** In traditional systems, corrupted data typically causes crashes or type errors: visible failures. In agent systems, corrupted data produces plausible but wrong conclusions. Downstream agents treat them as valid inputs. The failure mode is confidence in incorrect output, not system breakdown.

**Feedback amplification.** Agents with shared memory or iterative loops can reinforce errors. Agent A writes a flawed conclusion to shared state. Agent B reads it, incorporates it, writes its own corrupted conclusion. Agent A reads Agent B's output on the next iteration, confirming its original error. The system converges on a wrong answer with increasing confidence.

**Opacity.** Traditional distributed systems have deterministic control flow: you can trace a request through a service mesh and identify where it went wrong. Multi-agent systems have non-deterministic control flow because agents decide what to do next. Debugging requires reconstructing decisions, not tracing function calls.

## The numbers

Empirical measurements across seven multi-agent frameworks found failure rates of 41% to 86.7% without proper orchestration. Hierarchical structures are more resilient than flat ones: performance drops of up to 23.7% depending on architecture when faulty agents are introduced. [Huang 2025] [Cemri 2025]

## The internal leakage problem

Cascading failure is visible when decisions degrade. A less visible variant: multi-agent systems leak data through internal channels (inter-agent messages, tool call arguments, shared memory) that output-level monitoring never inspects. [[AgentLeak]] found that OR-aggregated total exposure rises to 68.9% in multi-agent systems even when per-channel output leakage is lower than single-agent systems. Standard observability catches at most three of seven leakage channels. [AgentLeak 2026]

## Defenses (OWASP ASI08 mitigation stack)

1. **Architectural isolation**: [[trust-inversion|trust boundaries]] between agent groups, limiting [[blast-radius]]
2. **Runtime verification**: multi-agent consensus checks and ground truth validation before acting on delegated outputs
3. **Observability**: automated cascade pattern detection with kill switches

The [[firewalled-agent-networks]] architecture (dual firewalls at agent trust boundaries) provides structural enforcement rather than advisory controls.

## Connects to

- [[blast-radius]] — cascading failures multiply blast radius with delegation depth, not just agent count
- [[firewalled-agent-networks]] — structural architecture for containing cascading failures at communication boundaries
- [[delegation-chain]] — authority attenuation at each hop limits the scope of cascading damage
- [[owasp-agentic-top10]] — ASI08: Cascading Failures; ASI03: Identity and Privilege Abuse (compounded in chains)

## Sources

- [Huang 2025]: Yuxin Huang et al., "On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents," arXiv:2408.00989, August 2024, revised May 2025
- [Cemri 2025]: Mert Cemri et al., "Why Do Multi-Agent LLM Systems Fail?" arXiv:2503.13657, March 2025. MAST-Data: 1,600+ annotated failure traces across 7 frameworks
- [AgentLeak 2026]: AgentLeak: A Full-Stack Benchmark for Privacy Leakage in Multi-Agent LLM Systems, arXiv:2602.11510, February 2026
- OWASP Top 10 for Agentic Applications, ASI08, December 2025
- Chapter: [Multi-Agent Trust and Orchestration](../chapters/multi-agent-trust.md#cascading-failures)
