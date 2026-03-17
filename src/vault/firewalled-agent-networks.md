---
title: Firewalled Agent Networks
tags: [security, multi-agent, architecture, containment]
---

An architecture for enforcing trust boundaries between agents using dual firewalls at every communication crossing: an outbound Information Firewall and an inbound Language Converter Firewall. [Abdelnabi 2026]

## The dual firewall pattern

**Information Firewall (outbound).** Projects each outgoing message onto the task context, stripping information that exceeds what the task requires. An agent authorized to negotiate a flight booking should not transmit the user's full travel history to the counterparty agent. The firewall enforces this structurally — not by trusting the agent to self-censor.

**Language Converter Firewall (inbound).** Converts incoming natural language into a closed, domain-specific, structured protocol before it reaches the agent. Only well-formed fields pass through. Persuasive framing, urgency tactics, embedded instructions, and social engineering attempts are structurally eliminated — not because they are detected, but because they cannot be expressed in the validated protocol format.

This is the "can't vs. don't" distinction applied to agent communication: the Information Firewall enforces data minimization; the Language Converter Firewall enforces that malicious patterns are inexpressible.

## Why this matters for emergent threats

Standard output-level monitoring catches at most three of seven leakage channels in multi-agent systems. The Firewalled Agent Networks architecture addresses the four internal channels (inter-agent messages, tool call arguments, tool outputs, agent memory state) that external monitoring never inspects.

Against emergent offensive cooperation (agents inventing DLP bypasses, steganography, peer pressure on other agents), protocol conversion is the correct defense. Every "don't" control can be circumvented by creative agents. "Can't" controls — where the attack is structurally inexpressible — hold. See [[trust-inversion]].

## Empirical results

Averaged across 864 attacks in three domains: privacy attack success rates dropped from 85% to 10% (GPT-5) and 73% to 17% (Claude Sonnet 4). Security attack success rates dropped from 60% to 3%. Task completion quality was maintained or improved — the structured protocol eliminated ambiguity that had caused errors in unconstrained communication. [Abdelnabi 2026]

## Practical limitation

Domain specificity: each domain (travel, finance, healthcare) needs its own structured protocol definition. The architecture automates protocol learning from demonstrations, reducing but not eliminating the engineering overhead. For single-domain deployments, the attack reduction is qualitative. For multi-domain deployments, the per-domain cost is a real consideration.

## Connects to

- [[cascading-failure]] — dual firewalls contain cascading failures at communication boundaries
- [[trust-inversion]] — Language Converter Firewall implements "can't" at the agent communication layer
- [[mcp-gateway]] — gateway pattern at the MCP layer; firewalls operate at the agent-to-agent layer
- [[delegation-chain]] — firewalls enforce that only task-contextual information crosses delegation boundaries

## Sources

- [Abdelnabi 2026]: Sahar Abdelnabi et al., "Firewalls to Secure Dynamic LLM Agentic Networks," arXiv:2502.01822, revised March 1, 2026 (v6). Open-source: github.com/amrgomaaelhady/Firewall-Agentic-Networks
- Chapter: [Multi-Agent Trust and Orchestration](../chapters/multi-agent-trust.md#firewalled-agent-networks)
