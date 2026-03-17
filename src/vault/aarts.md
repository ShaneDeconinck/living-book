---
title: AARTS (AI Agent Runtime Safety Standard)
tags: [standard, runtime, security, control, containment]
---

A structured interface standard for agent runtime safety, introduced by Gen Digital in March 2026. The first attempt to standardize not just what containment does but how it plugs in across agent frameworks.

## How it works

AARTS defines three component types and the interfaces between them:

- **Agent hosts** — environments where agents run (IDEs, orchestrators, frameworks). The host intercepts agent actions at defined hook points and passes them to a security engine.
- **Security engines** — receive intercepted actions, evaluate against policy, return verdicts. The engine does not need to know how the host executes; the host does not need to know how the engine decides.
- **Adapters** — translate host-native events into the common schema the security engine expects. A host can ship an adapter without modifying itself.

The separation creates a market for security engines independent of agent hosting — the architectural equivalent of how OS-level syscall interception (seccomp BPF, eBPF) works.

## 19 Hook Points

AARTS v0.1 defines 19 hook points across the agent lifecycle. Four high-priority categories:

- **PreToolUse** — before a tool executes (shell commands, file writes, web requests, package installs). Primary injection attack surface.
- **PreLLMRequest** — before a prompt reaches the model. Protects prompt integrity against injected instructions.
- **PreSkillLoad / PrePluginLoad** — before a skill or plugin enters the agent environment. Supply chain hooks.
- **PreFileRead / PreFileWrite** — protect credential paths and sensitive files.

## Why it matters

Without a common interface, organizations deploying three agent frameworks write three separate security policies, audit three separate enforcement points. AARTS makes security engines independently deployable: write the policy once, apply it to any compliant host.

The external enforcement model also has [[accountability-pillar]] implications: a security engine logging verdicts outside the agent's context produces an audit trail the agent cannot disable.

## Status

AARTS v0.1 is a draft (as of March 2026), not a ratified standard. Not yet submitted to a standards body. Adoption outside Gen's own ecosystem not yet established.

## Connections

- [[sandboxing]] — structural containment AARTS builds on
- [[skill-ids]] — content-addressable integrity introduced alongside AARTS
- [[mcp-tool-poisoning]] — PreToolUse hook is the direct countermeasure
- [[prompt-injection]] — PreLLMRequest hook targets this attack class
- [[skill-supply-chain]] — PreSkillLoad hooks address this surface
- [[control-pillar]] — AARTS is Control infrastructure: bridges authorized scope and enforced runtime behavior
