# The PAC Framework

Every protocol and standard in this book addresses a piece of the problem. OAuth scopes handle authorization within a trust domain. DIDs handle identity across domains. Verifiable Intent handles proof of user authorization for commerce. But none of them answers the question an organisation actually needs to start with: where do we begin, and how do we think about this?

That's what PAC does. Shane developed the [PAC Framework](https://trustedagentic.ai/framework/) (Potential, Accountability, Control) as the governance structure for agentic transformation. It's the spine of this book: every protocol, every gap, every design decision maps to one of the three pillars.

The premise is simple. AI engineering, security, and compliance each see part of the picture. PAC brings them into three pillars you can act on and align stakeholders around.

## The Three Pillars

**Potential**: what's worth building that lasts? The barrier to building agents has never been lower. What's possible changes monthly. The question isn't whether you can build it. It's whether what you build today still compounds in a year, or becomes dead weight when the next model drops.

**Accountability**: who's responsible, and can you prove it? Agents are already making decisions in organisations. Some nobody knows about. When something goes wrong, someone has to explain what happened. If the liability chain isn't mapped before the incident, it's too late to draw one after.

**Control**: can your infrastructure enforce what policy demands? Policy says "don't." Architecture says "can't." The difference matters when agents act autonomously across systems and organisations. Identity, delegation, sandboxing: the infrastructure to enforce what governance promises.

Drop any one pillar and the others fall short.

- **Potential without Accountability**: reckless adoption. You build fast and hit a wall when the first incident happens and nobody can explain what went wrong.
- **Accountability without Control**: governance on paper. Policies mean nothing if the infrastructure can't enforce them.
- **Control without Potential**: infrastructure without a mandate. If the business doesn't see value, funding stops.

## Potential: Finding Where Agents Create Real Value

This pillar forces a structured look at what an agent deployment actually involves. Not "can we build it?" but "should we, and will it last?"

The [PAC Framework](https://trustedagentic.ai/framework/) defines several dimensions within Potential:

**Business value** is classified on a four-level scale: V1 Incremental, V2 Operational, V3 Strategic, V4 Transformative. Not every process benefits from an agent. The question is where it actually matters.

**Reliability** is measured as a percentage with its error margin. Without the margin, the number means nothing. A workflow's failures are enumerable; an autonomous agent's aren't. This is the core distinction from [the chapter on reliability vs governance](./agents-create-intent.md): context engineering improves reliability, but governance manages risk regardless of how reliable the agent becomes.

**Blast radius** measures what happens when the agent is wrong. Same quality, very different consequences depending on where output lands. The framework scores this across five levels: B1 Contained, B2 Recoverable, B3 Exposed, B4 Regulated, B5 Irreversible. A customer-facing agent generating incorrect medical information (B4/B5) needs fundamentally different infrastructure than an internal agent summarising meeting notes (B1).

**Autonomy** is not a choice you make upfront. It's what the agent earns, determined by all dimensions together. Five levels: A1 Suggestion, A2 Approve, A3 Oversight, A4 Delegated, A5 Autonomous. The governance threshold for each level depends on blast radius: contained tasks can tolerate more uncertainty; irreversible ones can't.

**Durability** is Shane's recurring point: build on what stays stable. Workflow logic, context infrastructure, evaluation pipelines. Not on what changes every quarter. Better models will make current scaffolding obsolete. Shane calls this [harness debt](https://shanedeconinck.be/posts/ai-agent-scaffolding-trap/): scaffolding built to compensate for a weaker model becomes a liability when the model improves. Most teams don't see it until a new model drops and their pipeline fights it.

**Context management** is where lasting advantage lives. Shane [argues](https://shanedeconinck.be/posts/ai-agents-context-infrastructure-long-term-investment/) that while training, code, and model access all depreciate, context infrastructure appreciates. Well-curated information combined with well-managed access becomes exponentially more valuable as models improve. Two organisations with the same model and the same budget but different context infrastructure will see diverging results. The five areas to invest in: structure (coherent, machine-consumable information), permissions (fine-grained access on information itself), discovery (agents need to find what they need), authority (access scoped to the delegating user's authority), and freshness (up-to-date, versioned information).

**Implementation architecture** matters because workflows, agent loops, and autonomous agents aren't exclusive choices. They compose. A workflow can contain an agent loop step that delegates to an autonomous sub-agent. The outer layer sets the reliability floor and tightens the error margin; the inner layer raises the quality ceiling.

## Accountability: Mapping Who's Responsible Before It Matters

This is where trust infrastructure meets organisational reality. The technical protocols covered in the [Protocol Landscape](./protocol-landscape.md) chapter provide the building blocks. The Accountability pillar asks whether you've actually wired them into governance.

**Delegation becomes abdication.** This is the central insight from the [opening chapter](./agents-create-intent.md). Agents interpret and expand intent. If you can't trace what was given and what was acted on, accountability dissolves. Verifiable Intent addresses this for the commerce use case by making user authorisation a cryptographic object. But the general case, where a planning agent delegates to specialist sub-agents across organisational boundaries, remains largely unaddressed.

**Shadow agents.** The OpenID Foundation's [AIIM whitepaper (October 2025)](https://openid.net/new-whitepaper-tackles-ai-agent-identity-challenges/) and the [NIST concept paper (February 2026)](https://www.nccoe.nist.gov/projects/software-and-ai-agent-identity-and-authorization) both identify unregistered agents in enterprise environments as a key risk. Shane poses the question directly in the framework: "Do you know every agent running in your organisation?" The [OpenClaw incident](https://shanedeconinck.be/posts/openclaw-moltbook-trust-fear-ai/) showed what happens when users install system-level agents without understanding what they're granting. Documentation is not a security model.

**Liability chains.** When an agent makes a consequential decision, you need to trace who authorised it and what happened. The chain includes the user who delegated, the agent that acted, the model provider, the integrator, the prompt author. As noted in the [Gaps](./gaps.md) chapter, no protocol comprehensively captures this full provenance. Software supply chains have SBOMs. Agent supply chains need something equivalent.

**Audit trails designed for compliance.** Not just debugging logs, but evidence that could satisfy a regulator. Can you explain to an auditor what your agent did and why? The [CSA/Strata Identity survey (February 2026)](https://cloudsecurityalliance.org/press-releases/2026/02/05/cloud-security-alliance-strata-survey-finds-that-enterprises-are-in-time-to-trust-phase-as-they-build-ai-autonomy-foundations) found that 84% of organisations doubt they could pass a compliance audit focused on agent behaviour or access controls. That number should concern anyone deploying agents at scale.

**Regulatory convergence.** The EU AI Act, NIST frameworks, and ISO 42001 are converging. Better to shape governance around them than react. The OpenID Foundation's [response to NIST's RFI (March 2026)](https://openid.net/oidf-responds-to-nist-on-ai-agent-security/) framed the urgency: the autonomy inflection point is approaching faster than most realise.

## Control: Architecture That Enforces What Policy Can't

This is where the protocols from the [Protocol Landscape](./protocol-landscape.md) chapter live. Control isn't about having policies. It's about having infrastructure that makes violation structurally impossible.

The framework defines an infrastructure maturity scale: I1 Open, I2 Logged, I3 Verified, I4 Authorized, I5 Contained. Either you have audit trails or you don't. Either credentials are scoped or they aren't. No reliability score compensates for guardrails you haven't built.

**Policy vs. architecture.** The [trust inversion](./agents-create-intent.md) chapter established the principle: agents must be restricted to what they can do, not from what they can't. This is the Control pillar in practice. OAuth scopes, capability-based security, and explicit tool registration define the positive space of allowed behaviour. The Cloud Security Alliance's [Agentic Trust Framework (February 2026)](https://cloudsecurityalliance.org/blog/2026/02/02/the-agentic-trust-framework-zero-trust-governance-for-ai-agents) applies Zero Trust principles specifically to AI agents: all actions logged, inputs validated, circuit breakers preventing runaway failures.

**Agent identity.** Who is this agent, who does it act for, and how do you prove it? Within a single trust domain, OAuth OBO ([RFC 8693](https://datatracker.ietf.org/doc/html/rfc8693)) handles this. Across domains, DIDs and Verifiable Credentials provide the cryptographic foundation. The building blocks exist. They weren't built for agents, but they apply directly.

**Delegation chains.** What an agent can access, for how long, and what happens when it hands off to another agent. Authority can only decrease through the chain, never expand. This is PIC's core property, and Verifiable Intent enforces it by making L3 terminal. The new [OAuth scope aggregation draft (draft-jia-oauth-scope-aggregation)](https://datatracker.ietf.org/doc/draft-jia-oauth-scope-aggregation/) addresses the practical question of how an agent aggregates scopes across a multi-step workflow into a single authorization procedure.

**The confused deputy.** An agent with credentials but no scoped limits on what it can do with them. Every delegation without explicit boundaries is a potential confused deputy. This is why positive-space authorisation matters: not "block these actions" but "permit only these actions."

**Cross-organisation trust.** When agents cross organisational boundaries, how do you authenticate, pass authority, and keep someone accountable? TSP provides the bridge when no shared identity provider exists. The [Agent Authorization Profile (draft-aap-oauth-profile)](https://datatracker.ietf.org/doc/html/draft-aap-oauth-profile-00.html) defines an authorization profile specifically for autonomous agents, extending OAuth 2.0 and JWT without introducing a new protocol.

## How the Protocols Map to PAC

The protocols from the [Protocol Landscape](./protocol-landscape.md) chapter aren't random pieces. They map to specific pillars:

| Protocol | Primary PAC Pillar | What It Addresses |
|----------|-------------------|-------------------|
| OAuth 2.0 + OBO | Control | Identity and delegation within a trust domain |
| IETF agent auth drafts | Control | Extending existing standards for agent-specific auth |
| OAuth Scope Aggregation | Control | Multi-step workflow authorization |
| Agent Authorization Profile | Control | Autonomous agent authorization |
| DIDs + VCs | Control | Cross-domain identity and authority |
| TSP | Control | Cross-domain trust establishment |
| Verifiable Intent | Accountability + Control | Cryptographic proof of user authorization |
| PIC | Accountability + Control | Traceable delegation chains |
| MCP | Potential | Connectivity and tool integration |
| A2A | Potential + Control | Agent-to-agent communication |
| NIST demonstration project | Accountability | Standards-based reference implementations |
| OWASP Agentic Top 10 | Accountability | Risk identification and classification |
| CSA Agentic Trust Framework | Control | Zero Trust governance for agents |
| AgentGateway | Control | Policy enforcement at the network layer |

Control is the most protocol-heavy pillar because it requires the most infrastructure. Potential is the least, because what's possible changes with every model release. Accountability sits between: it needs both organisational process and technical evidence.

## The Iterative Nature

Models improve. Protocols land. Regulations tighten. Internal policies evolve. And your own progress shifts the landscape: the right control infrastructure unlocks new autonomy levels, which open new use cases, which create new blast radius, which demands new accountability.

This isn't a one-time assessment. PAC is built to be re-run. The [Agent Profiler](https://trustedagentic.ai/profiler/) at trustedagentic.ai gives a concrete way to track how positions shift across iterations, mapping agents across six governance dimensions.

The 19 questions in the framework are conversation starters, not a checklist. The right question at the right table surfaces gaps that dashboards and audits miss.

**Potential** (7 questions):

1. What decisions are you not yet delegating to agents, and what's that costing you?
2. Will better models make your current setup more valuable, or obsolete?
3. How much value are you leaving on the table by over-constraining?
4. Are your agents actually making decisions, or just automating steps humans already defined?
5. Does the right context reach your agents at the right time?
6. Are you building on established and emerging standards, or on an island?
7. Do you know the error margin on your agent's reliability, or just the headline number?

**Accountability** (5 questions):

1. Do you know every agent running in your organisation?
2. If an agent causes harm, is the liability chain clear?
3. Can your infrastructure prevent an agent from running without being registered?
4. Could you explain to a regulator what your agent did and why?
5. When an agent makes a consequential decision, can you trace who authorised it and what happened?

**Control** (7 questions):

1. Are your agents contained by architecture, or only by policy?
2. When agents delegate to other agents, can authority only decrease?
3. What happens when human oversight breaks down in practice?
4. How do you balance agent quality with data privacy?
5. Are agents restricted to what they can do, or only blocked from what they can't?
6. Does your agent setup work when agents need to cross trust boundaries?
7. What happens when an agent wanders into a use case you didn't anticipate?

Three that tend to surface the most gaps: "Are your agents contained by architecture, or only by policy?" reveals whether an organisation has invested in infrastructure or just written guidelines. "If an agent causes harm, is the liability chain clear?" most teams discover the answer is no. "Will better models make your current setup more valuable, or obsolete?" forces honest evaluation of harness debt and durability.

## Where This Book Fits

This book is the technical companion to the PAC Framework. The [opening chapter](./agents-create-intent.md) establishes why the problem exists: agents create intent, and that breaks existing trust assumptions. The [Protocol Landscape](./protocol-landscape.md) maps what's being built. The [Gaps](./gaps.md) chapter identifies what's missing.

PAC provides the lens. When evaluating a protocol, an architecture decision, or a deployment plan, the questions are: does this increase Potential in a way that's durable? Does this close an Accountability gap? Does this move Control from policy to architecture?

If the answer to all three is unclear, the decision isn't ready.
