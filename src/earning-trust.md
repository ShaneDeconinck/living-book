# Building Agents That Earn Trust

The previous chapters cover what needs to be built: identity, delegation, intent binding, governance frameworks. This chapter covers how to build it: the practical decisions organisations face when deploying agents that need to earn trust rather than assume it.

Trust isn't a binary. An agent doesn't go from "untrusted" to "trusted." It earns autonomy through demonstrated capability within enforced constraints, and the infrastructure must scale with that progression.

## Autonomy Is an Output, Not an Input

I keep seeing teams set an autonomy level first and then try to bolt on safety. This gets it backwards.

Shane's [PAC Agent Profiler](https://shanedeconinck.be/posts/agent-profiler-reasoning/) makes the case clearly: autonomy isn't something you configure. It's something an agent earns based on six dimensions: business value, reliability, blast radius, governance thresholds, infrastructure, and autonomy itself as the dependent variable.

The [Cloud Security Alliance](https://cloudsecurityalliance.org/blog/2026/01/28/levels-of-autonomy) formalised this into six levels:

| Level | Name | Human Role | Infrastructure Required |
|-------|------|------------|------------------------|
| 0 | No Autonomy | Executes all actions | None |
| 1 | Assisted | Reviews and approves each action | Logging |
| 2 | Supervised | Approves plans, agent executes | Audit trails, identity verification |
| 3 | Conditional | Monitors, agent escalates at boundaries | Scoped authorisation, sandboxing |
| 4 | High Autonomy | Exception handling only | Anomaly detection, kill switch |
| 5 | Full Autonomy | Strategic oversight only | Not recommended for current deployment |

The key insight from Shane's profiler: infrastructure is a gate, not a slider. Each autonomy level requires specific guardrails to be built. If you don't have audit trails, you're locked to Level 1 regardless of how reliable your agent is. If you don't have scoped authorisation, Level 3 is off the table.

This matches what Anthropic's own data shows. Their [February 2026 study](https://shanedeconinck.be/posts/early-indicators-agent-use-cases-anthropic-data/) of 998,481 tool calls found that 80% have safeguards and 73% involve human oversight. Most production agents are at Level 1 or 2. The upper-right quadrant of their risk-vs-autonomy scatter (high autonomy, high risk) is "sparsely populated but not empty": patient medical records, crypto trading, production deployments.

The distribution matters. Nearly 50% of agent tool calls are in software engineering, where verification infrastructure is mature: tests pass or fail, code review catches errors, deployments roll back. Other domains (healthcare, finance, customer service) have direct impact without equivalent verification loops. The infrastructure gate is higher for those domains, not because the agents are less capable, but because the blast radius is larger and the verification loops are weaker.

## The Sandbox Imperative

Control, the third pillar of PAC, shifts from "policy says don't" to "architecture says can't." Sandboxing is the most concrete expression of this principle.

Shane [compared three approaches](https://shanedeconinck.be/posts/docker-sandbox-coding-agents/) after the OpenClaw incident showed what happens without containment:

**Native OS sandboxing** (Claude Code's Seatbelt/bubblewrap, Codex's Landlock, Gemini's Docker): restricts system calls but runs on the host OS, sharing the kernel. A sandbox escape gives access to everything.

**DevContainers**: namespace isolation with more customisation, but still shared kernel. Better than native for multi-tool agents, but the isolation boundary is the Linux namespace, not a hardware boundary.

**Docker Sandbox**: hypervisor-level isolation via microVMs (macOS Virtualisation.framework, Windows Hyper-V). Separate kernel, copy-based file sync, network proxy. As Mark Cavage from Docker [put it](https://shanedeconinck.be/posts/docker-sandbox-coding-agents/): "Put agents in a real box... current things built on deprecated tech or compromise on isolation."

The isolation landscape has matured rapidly. Docker is [now running agents in dedicated microVMs](https://docs.docker.com/ai/sandboxes/) rather than standard containers, with Firecracker microVMs booting in approximately 125ms with less than 5 MiB memory overhead. Northflank's [2026 analysis](https://northflank.com/blog/how-to-sandbox-ai-agents) confirms that microVM isolation with sub-100ms cold starts is becoming the standard for production agent deployments.

The numbers support this. Startup Hub's 2026 research found sandboxed agents reduce security incidents by [90% compared to agents with unrestricted access](https://northflank.com/blog/how-to-sandbox-ai-agents).

Map this to the OWASP Top 10 for Agentic Applications. Shane's analysis showed Docker Sandbox provides strong coverage for ASI02 through ASI05 (tool misuse, privilege escalation, insufficient guardrails, improper multi-agent trust) and ASI10 (unmonitored agent behaviour). It provides no coverage for ASI01 (prompt injection), ASI06 (memory and context poisoning), or ASI09 (misinformation). Sandboxing bounds the damage; it doesn't prevent bad decisions within the allowed space.

## Architecture Patterns for Delegation

Beyond sandboxing individual agents, the delegation architecture determines how trust flows through multi-agent systems. Shane identified three [emerging IAM patterns](https://shanedeconinck.be/posts/ai-agents-beyond-pocs-iam-emerging-patterns/) worth building on:

**Agentic On-Behalf-Of (OBO)**: dual-identity tokens via RFC 8693 where the token carries both the user's identity and the agent's identity. The resource server sees who delegated and who's acting. This is the minimum viable delegation pattern: it doesn't solve authority scoping, but it solves the audit trail problem.

**Proof of Continuity (PIC)**: authority validated at each step of a delegation chain, with the constraint that authority can only be restricted or maintained, never expanded. Nicola Gallo's work at DIF formalises this as: authority is continuation, not possession. An agent doesn't "have" authority; it continues authority that was granted, with each hop providing cryptographic proof that the chain is intact.

**Trust-Spanning Frameworks**: decentralised credentials for cross-organisational delegation. The Trust Spanning Protocol (TSP), hosted at the Open Wallet Foundation, enables agents to establish trust across organisational boundaries using verifiable credentials. Shane [attended the LFDT meetup](https://shanedeconinck.be/posts/lfdt-meetup-trust-ecosystems-authority-continuity/) where Wenjing Chu (Futurewei/Trust over IP) presented TSP and Nicola Gallo presented PIC. The two approaches complement each other: TSP handles cross-domain identity, PIC handles authority continuity.

These patterns compose. An agent might authenticate via SPIFFE within its domain, use OBO tokens to act on behalf of a user, prove authority continuity via PIC across delegation hops, and establish cross-domain trust via TSP. We're not there yet in practice, but the direction is clear.

## The Agent Architecture Mental Model

Shane proposed a [Framework-Runtime-Harness model](https://shanedeconinck.be/posts/fitting-agentic-ai-components-in-a-mental-model/) for reasoning about agent systems:

- **Framework**: defines what the agent is. Model, context, skills, tools.
- **Runtime**: manages how the agent executes. State, control flow, human-in-the-loop gates.
- **Harness**: describes the environment the agent operates in. Interface, IAM, evaluations, sandbox.

This decomposition matters for trust because each layer has different governance requirements. The Framework determines capability (Potential). The Runtime determines oversight (Accountability). The Harness determines enforcement (Control). Improving one doesn't compensate for gaps in another. A better model doesn't fix a missing sandbox. A tighter sandbox doesn't fix unsigned credentials.

Andrew Ng's [2024 observation](https://shanedeconinck.be/posts/fitting-agentic-ai-components-in-a-mental-model/) holds: GPT-3.5 in an agentic loop with verification outperformed GPT-4 single-shot. The system matters more than the model. But systems without trust infrastructure create risk proportional to their capability.

## What Boards Need to Ask

Shane curated [18 questions](https://shanedeconinck.be/posts/agentic-ai-curated-questions-for-the-boardroom/) for boards evaluating agent deployments, structured around PAC's three pillars:

**Potential questions** (are agents actually deciding?):
- Where are agents making decisions today vs. where do you think they are?
- What's the blast radius of a wrong decision in each use case?
- Are you building on patterns that survive model upgrades, or scaffolding that becomes debt?

**Accountability questions** (can you trace decisions?):
- Can you show a regulator the full decision chain for any agent action?
- Who owns AI governance? If no one owns it, everyone assumes someone else does.
- Are shadow agents already operating without compliance review?

**Control questions** (can your infrastructure enforce what policy demands?):
- Are agents restricted *to* what they can do, or *from* what they can't?
- Can an agent escalate its own privileges through tool access?
- What happens when an agent crosses organisational boundaries?

These aren't abstract. The [Gravitee report](./when-trust-breaks.md) found 88% of organisations deploying agents experienced security incidents. The [Teleport report](./when-trust-breaks.md) found a 4.5x incident rate from over-privileged agents. The [EU AI Act](https://shanedeconinck.be/posts/ai-agents-eu-ai-act/) deadline of August 2, 2026 makes these questions compliance obligations, not just best practices.

## The EU AI Act and Agent Governance

The EU AI Act was written for traditional AI: fixed pipelines, known use cases at build time. Agents complicate this because risk emerges at runtime based on open-ended goals.

Shane's [analysis](https://shanedeconinck.be/posts/ai-agents-eu-ai-act/) identified the core tension: the Act classifies AI systems by intended use. But a general-purpose agent doesn't have a single intended use. The Future Society's "Ahead of the Curve" report calls this the "multi-purpose problem": generic agents default to high-risk unless explicitly scoped to lower-risk uses.

The Act requires risk management (Article 9), traceability (Article 12), and human oversight (Article 14). For agents, this translates to:

- **Traceability**: every agent action must be logged with sufficient detail to reconstruct the decision chain. This is the Accountability pillar.
- **Human oversight**: not just human-in-the-loop approval, but the ability to intervene, override, and shut down. This is Control infrastructure.
- **Risk management**: ongoing assessment of what the agent is doing, not just what it was designed to do. This is the Potential assessment, re-evaluated continuously.

The July 2025 guidelines clarified that RAG, prompt engineering, and orchestration don't count as provider modifications: the deployer who builds the agent system bears the compliance burden, not the model provider. This matters because it places governance responsibility on the organisations deploying agents, exactly where the PAC Framework says it belongs.

Singapore's IMDA launched the [Model AI Governance Framework for Agentic AI](https://www.bakermckenzie.com/en/insight/publications/2026/01/singapore-governance-framework-for-agentic-ai-launched) in January 2026: the world's first governance framework specifically for autonomous agents. It aligns with similar principles: bounded agency, goal transparency, contestability, governance by design.

## The Work That's Shifting

The trust infrastructure discussion isn't academic. It's happening against a backdrop where agent deployment is accelerating faster than governance infrastructure.

Shane [tracked the workforce signals](https://shanedeconinck.be/posts/the-work-thats-leaving/): Block cut from 10,000 to 6,000 staff (stock up 20%). Klarna went from 7,000 to 3,000. Duolingo declared "AI-first." Microsoft reported 30% of its code is now AI-written. METR's benchmark shows the task length for 50% AI success is doubling every 7 months.

The pattern is clear: the first tasks to go are high-reliability, contained blast radius. Coding, call centres, web design. These are PAC Level 1-2 tasks: high business value, measurable reliability, limited damage when wrong.

The next wave is different. Healthcare, finance, legal, procurement: these have higher blast radius, weaker verification loops, and regulatory exposure. They require the infrastructure described in this book: verified identity, scoped delegation, audit trails, intent binding, sandbox isolation.

The organisations that build this infrastructure now will deploy agents in these higher-value domains. The ones that don't will hit the governance wall the moment something goes wrong in a regulated context.

## Practical Sequence

Based on the PAC Framework and the evidence from the industry reports, here's the order that matters:

1. **Inventory**: know what agents exist. The shadow agent problem ([1.5 million unmonitored agents](./when-trust-breaks.md) per the Gravitee report) means governance starts with visibility.
2. **Identity**: every agent gets a verifiable identity. SPIFFE within the domain, VCs for cross-domain. No anonymous agents in production.
3. **Audit trails**: every agent action logged with full context: who delegated, what authority existed, what was decided. This is the minimum for regulatory compliance.
4. **Scoped authorisation**: move from role-based inheritance to explicit, per-task grants. OBO tokens at minimum. Verifiable Intent for high-stakes actions.
5. **Sandboxing**: hypervisor-level isolation for any agent that executes code or accesses infrastructure. MicroVMs, not containers.
6. **Delegation chains**: implement authority continuity (PIC) for multi-agent workflows. Authority only decreases through the chain.
7. **Cross-domain trust**: TSP and DID-based verification for agents operating across organisational boundaries.

Not every organisation needs all seven. But every organisation deploying agents needs at least the first four. The Teleport data is clear: over-privileged agents cause 4.5x more incidents. The fix is infrastructure, not policy.

## Mapping to PAC

This chapter is PAC applied:

**Potential**: the profiler and autonomy levels help organisations identify where agents create real value and what infrastructure is required to unlock it. The blast radius assessment prevents deploying agents in domains where the governance infrastructure isn't ready.

**Accountability**: audit trails, the EU AI Act requirements, and the boardroom questions all serve accountability. The core question: can you reconstruct what happened and who was responsible?

**Control**: sandboxing, scoped authorisation, delegation chains, and cross-domain trust are all Control infrastructure. The principle: architecture that makes wrong actions impossible, not policy that asks agents to behave.

The PAC Framework is iterative. As models improve, protocols land, and regulations tighten, the profiler should be re-run. An agent that was Level 2 last quarter might be Level 3 this quarter, if the infrastructure gates are met. The framework doesn't lock agents in place: it defines the conditions under which they can advance.
