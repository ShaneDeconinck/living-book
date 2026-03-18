---
title: User Alignment Critic
tags: [security, guardian-agents, defense, browser-agents, control]
dimension: infrastructure-as-gate
---

A separate LLM that reviews every proposed agent action and vetoes anything that does not match the user's specific intent. Google's Project Mariner is the most concrete production implementation of the [[guardian-agents]] pattern.

## Architecture

Google's 2026 Responsible AI Progress Report details a five-layer defense-in-depth architecture for browser agents:

1. **User Alignment Critic** — a separate Gemini model reviews every action. The architectural detail that matters: the Critic sees only action metadata, not the raw web content the agent is processing. This isolation means the Critic cannot be poisoned through the same channel the agent operates in. An attacker who embeds malicious instructions on a web page can influence the browsing agent but cannot reach the oversight model.

2. **Agent Origin Sets** — task-scoped browsing boundaries restricting the agent's reach to data directly related to the current task. The web equivalent of filesystem [[sandboxing]].

3. **Prompt injection classification** — every page the agent visits is scanned for manipulation attempts. Input validation at every hop, not just at the entry point.

4. **Mandatory human oversight for sensitive actions** — payments, social media posts, credential use all require explicit confirmation. The [[autonomy-dial]] in production: A3 for routine browsing, A2 for high-consequence actions.

5. **Pre-launch testing** — all five layers built before the capability shipped, not in response to incidents.

## Why the isolation matters

The Critic is [[infrastructure-in-the-loop]] with a twist: the infrastructure is itself an AI model, but one architecturally shielded from the threat surface. This is a structural defense: even if the browsing agent is fully compromised by [[prompt-injection]], the Critic operates on a separate input channel and maintains independent judgment.

## Complementary to OS-level sandboxing

OS-level [[sandboxing]] constrains system resources (files, network, syscalls). Application-level oversight constrains agent behavior (intent alignment, task scope, action classification). A fully governed agent uses both.

## Connects to

- [[guardian-agents]] — the User Alignment Critic is the most concrete production implementation of this market category
- [[infrastructure-in-the-loop]] — automated oversight that does not depend on human vigilance
- [[sandboxing]] — complementary defense at the execution layer
- [[autonomy-dial]] — mandatory oversight for sensitive actions is the autonomy dial enforced by infrastructure
- [[prompt-injection]] — the Critic defends against prompt injection by operating on a shielded input channel

## Sources

- Google, "Our 2026 Responsible AI Progress Report," blog.google, February 2026
- Google Security Blog, "Architecting Security for Agentic Capabilities in Chrome," December 8, 2025
- Chapter: [Sandboxing and Execution Security](../chapters/execution-security.md) §Google Project Mariner
