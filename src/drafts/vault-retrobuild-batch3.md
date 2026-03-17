# Vault Retrobuild — Batch 3 (Control + Synthesis Chapters)

Staging area for vault notes. Move each section to its own file in src/vault/ once permissions are fixed.

---

## tsp.md

```yaml
---
title: Trust Spanning Protocol (TSP)
tags: [protocol, identity, cross-org]
---
```

A thin-waist cryptographic protocol for verified identity and authenticated messaging across organizational boundaries without shared infrastructure.

TSP treats identity not as a session token but as a relationship. Two parties establish a verified channel using DIDs, then exchange messages with end-to-end authentication. The protocol is composable: higher-layer protocols (agent task handoffs, credential exchange, payment flows) ride on TSP without reimplementing identity verification. The key design choice is **possession, identity, continuity (PIC)**: authority flows through provable delegation chains where each step can only narrow scope, never expand it. This makes TSP resistant to the [[confused-deputy]] problem at the protocol level. TSP enables [[cross-org-trust]] without requiring federation or shared identity providers.

---

## tool-poisoning.md

```yaml
---
title: Tool Poisoning
tags: [attack-pattern, mcp, tool-security]
---
```

An attack where malicious instructions embedded in tool descriptions manipulate the LLM, because tool descriptions are treated as behavioral instructions, not documentation.

Four forms: (1) **Rug pull** — tool description changes after initial approval to include exfiltration instructions, (2) **Shadowing** — tool description overrides behavior of other, legitimate tools, (3) **Cross-server poisoning** — tool on one MCP server manipulates tools on another, (4) **Description payload** — hidden instructions in description text that the LLM follows silently. The fundamental vulnerability: LLMs cannot distinguish between "documentation about a tool" and "instructions to follow." Defenses include pinning tool descriptions at approval time, hash-based integrity checks on descriptions, and [[agent-gateway]] mediation. See [[supply-chain-security]] for the broader threat model.

---

## ghost-token.md

```yaml
---
title: Ghost Tokens (CAAM Pattern)
tags: [authorization, cryptographic, control]
---
```

An authorization sidecar pattern where the agent never holds persistent credentials; instead it receives short-lived, single-use, action-specific tokens that cannot be replayed or exfiltrated.

CAAM (Cryptographic Agent Authorization Mediation) works like this: the agent requests permission for a specific action. A sidecar evaluates the request against [[mapl]] policy. If approved, it issues a ghost token — scoped to that exact action, with a cryptographic binding to the request context, expiring immediately after use. The agent never sees long-lived secrets. Even a fully compromised agent cannot escalate privileges because there are no stored credentials to steal. Ghost tokens are the "prove" mode of [[cryptographic-authorization]]: every action carries cryptographic proof of who authorized it and what constraints applied.

---

## containment-by-design.md

```yaml
---
title: Containment by Design
tags: [control, execution-security, architecture]
---
```

Security controls that make dangerous operations structurally impossible through OS-level isolation, rather than relying on permission prompts or policy enforcement.

Permission prompts fail because humans click "allow" habitually and agents operate too fast for meaningful review. Containment by design inverts this: instead of asking "should this agent do X?", the architecture ensures the agent *cannot* do X unless explicitly permitted. The [[isolation-spectrum]] ranges from native OS sandboxing (Apple's App Sandbox, Landlock) through containers (namespaces + cgroups) to microVMs (Firecracker) — each trading performance for stronger isolation. Defense in depth means layering these: filesystem restrictions prevent data access, network policies prevent exfiltration, resource limits prevent denial of service. This is [[infrastructure-in-the-loop]] applied to execution.

---

## skill-supply-chain.md

```yaml
---
title: Agent Supply Chain
tags: [supply-chain, security, control]
---
```

The unique attack surface where compromised agent components (skills, plugins, MCP servers) inherit the agent's autonomous decision-making authority and credential access.

Traditional software supply chain attacks compromise libraries that execute deterministic code. Agent supply chain attacks are worse: a compromised skill gains access to the LLM's reasoning loop, can influence decisions about other tools, and may hold delegated credentials. The OpenClaw scenario illustrates this — a typosquatted MCP server that exfiltrates data through the agent's normal tool-calling behavior. Defenses include [[sbom-for-agents]] (inventorying model version, tools, prompt templates, MCP servers with provenance), [[skill-id-content-addressability]] (cryptographic fingerprints for skill integrity), and Sigstore-style transparency logs for agent components.

---

## cascading-failure.md

```yaml
---
title: Cascading Failures in Multi-Agent Systems
tags: [risk, multi-agent, control]
---
```

A failure mode where corrupted data produces plausible but wrong conclusions that downstream agents accept as valid input, amplifying errors through the chain.

Unlike traditional cascading failures (which propagate errors that look like errors), agent cascading failures propagate errors that look like correct results. An agent that hallucinates a fact produces structured output that the next agent consumes confidently. Three structural causes: semantic propagation (plausible-looking wrong data), authority amplification (each agent adds its own authority to the corrupted chain), and speed (the cascade completes before any monitoring can intervene). Defenses: circuit breakers at trust boundaries, independent verification of high-stakes claims, and [[firewalled-agent-networks]] that enforce data minimization between agents.

---

## prove-mode.md

```yaml
---
title: Prove Mode Authorization
tags: [governance, cryptographic, accountability]
---
```

The third governance mode beyond "don't" (policy) and "can't" (architecture), where actions carry cryptographic proof of who authorized them, what constraints apply, and when.

Policy says the agent should not exceed its scope. Architecture ensures the agent cannot exceed its scope. Prove mode adds: every action the agent takes carries a verifiable record of authorization. This closes the accountability gap — even if an action was within scope and structurally permitted, prove mode answers "who authorized this specific action?" [[ghost-token]] implements prove mode tactically. [[mapl]] implements it at the policy layer. Together they make the [[liability-chain]] reconstructible from cryptographic evidence rather than log archaeology.

---

## mapl.md

```yaml
---
title: MAPL (Machine-Actionable Policy Language)
tags: [policy, cryptographic, control]
---
```

A policy language where child policies can only restrict parent policies, never relax them; effective policy is the intersection of all layers.

MAPL uses intersection semantics: when a parent policy permits actions A, B, C and a child policy permits B, C, D, the effective permission is B, C. Authority can only decrease through delegation, never expand. This makes privilege escalation mathematically impossible within the policy framework. MAPL policies are machine-actionable (agents and infrastructure can evaluate them directly) and composable across organizational boundaries. Combined with [[ghost-token]] issuance, MAPL enables [[cryptographic-authorization]] where every action is provably within the intersection of all applicable policies.

---

## orphan-agent.md

```yaml
---
title: Orphan Agents
tags: [lifecycle, governance, risk]
---
```

An agent whose owner has departed, whose purpose has ended, or whose credentials have exceeded policy lifetime, combining broad historical permissions with zero ongoing governance.

Orphan agents are the lifecycle equivalent of [[shadow-agents]]: invisible to governance, but with real credentials and real access. They emerge when employee offboarding does not include agent decommissioning, when project agents outlive their projects, or when credential rotation policies do not cover agent identities. The risk compounds: orphan agents accumulate permissions over time (scope drift) while receiving no security updates or policy alignment. Detection requires correlating agent registries with HR systems, project lifecycle tools, and credential stores. Prevention requires treating agent decommissioning as a first-class lifecycle event.

---

## paradox-of-supervision.md

```yaml
---
title: Paradox of Supervision
tags: [human-agent, governance, synthesis]
---
```

The governance risk where skills required to review delegated work atrophy through overuse of delegation, making human oversight less rigorous even when technically present.

This extends the [[complacency-trap]]: it is not just that humans monitor less as agents succeed more, but that humans become less *capable* of meaningful monitoring. A manager who delegates all code review to an agent gradually loses the ability to evaluate code quality. The oversight checkbox is checked, but the oversight is hollow. This creates a brittle governance structure that appears robust — human review is happening, but it catches nothing. The response is not to prevent delegation but to ensure critical review skills are exercised independently of agent output, and to use [[infrastructure-in-the-loop]] for the mechanical aspects of oversight.

---

## semantic-gap.md

```yaml
---
title: Semantic Interoperability Gap
tags: [interoperability, cross-org, unsolved]
---
```

The unsolved problem that agent actions carry different meanings in different organizational contexts, and no standard vocabulary exists for cross-boundary semantic verification.

Identity is solved (DIDs, VCs). Authorization is advancing ([[tsp]], [[mapl]]). Semantics are not. When Agent A in Organization X says "approve the purchase order" and Agent B in Organization Y processes it, both sides verified identity and authorization correctly — but "approve" meant "flag for review" in X and "execute immediately" in Y. Credentials solved this for identity claims (standard schemas). Actions have not because action meanings are embedded in organizational practice, not formal schemas. Interim approaches: bilateral semantic contracts, LLM-mediated translation, and restricting cross-org agent interactions to narrow, well-defined vocabularies.

---

## agent-gateway.md

```yaml
---
title: Agent Gateways
tags: [infrastructure, control, mcp]
---
```

A centralized governance layer that mediates all agent-to-tool interactions, enforcing consistent policy across multiple MCP servers while enabling fine-grained observability.

Without gateways, each MCP server is a separate trust boundary with its own security posture. Agent gateways (like AgentGateway) consolidate this: all tool calls route through a single enforcement point that applies authorization policy, logs every interaction for [[observability-stack]], rate-limits sensitive operations, and can circuit-break compromised tools in real time. The gateway pattern also addresses [[tool-poisoning]] by maintaining a known-good registry of tool descriptions and flagging mutations. This is the MCP equivalent of an API gateway — the missing enforcement layer between agent intelligence and tool execution.
