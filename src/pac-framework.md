# The PAC Framework

The PAC Framework is a governance model for AI agents built around three interdependent pillars: Potential, Accountability, and Control. It was developed by Shane Deconinck and is published at trustedagentic.ai. This chapter walks through the framework in depth, connecting each pillar to the technical infrastructure that makes it real.[^1]

The framework exists because organizations tend to approach agent deployment from one angle and miss the others. A team focused on business value (Potential) ships an agent without mapping the liability chain (Accountability). A security team locks down permissions (Control) so tightly that the agent cannot deliver value (Potential). A compliance team writes policies (Accountability) with no infrastructure to enforce them (Control).

PAC is a forcing function: it makes you address all three before something breaks.

## Potential: What Is Worth Building That Lasts?

The barrier to building agents has never been lower. The real question is not whether you can build one. It is whether what you build today still compounds in a year, or becomes dead weight when the next model drops.

### Business Value

Not every process benefits from an agent. The framework defines four tiers of business value:

- **V1 Incremental**: saves time on existing tasks. Useful, but easily replicated.
- **V2 Operational**: changes how work gets done. Removes bottlenecks, enables new workflows.
- **V3 Strategic**: creates competitive advantage. The agent does something your competitors cannot easily copy.
- **V4 Transformative**: enables entirely new business models. The agent is the product.

Most organizations start at V1 and stay there. The interesting question is what infrastructure investments move you toward V3 and V4.

### Reliability, Error Margins, and Blast Radius

Reliability is not a single number. It is a percentage with an error margin. Without the error margin, the percentage means nothing.

An agent that "works 95% of the time" tells you almost nothing. Is that ±2% based on thousands of runs across diverse inputs? Or ±15% based on a handful of demos? The confidence interval determines whether you can make governance decisions based on the number. A workflow's failures are enumerable: you can test every branch. An autonomous agent's failures are not: the space of possible behaviors is open-ended. This distinction determines how knowable your error margin is, which in turn constrains how much autonomy the agent can safely earn.[^7]

The framework pairs reliability with blast radius, a five-level scale:

- **B1 Contained**: failure affects only the agent's immediate task. A wrong autocomplete suggestion.
- **B2 Recoverable**: failure requires human intervention to fix. A miscategorized support ticket.
- **B3 Exposed**: failure is visible to external parties. A wrong email sent to a customer.
- **B4 Regulated**: failure triggers compliance obligations. Incorrect financial reporting.
- **B5 Irreversible**: failure cannot be undone. Funds transferred, contracts signed, data deleted.

The governance threshold depends on both. A B1 task can tolerate 90% reliability. A B5 task might need 99.9% and still require human approval. The framework makes this tradeoff explicit rather than leaving it to individual judgment.[^2]

### Autonomy Levels

How much independence an agent earns depends on its reliability, blast radius, and the infrastructure supporting it. The framework defines five levels:

- **A1 Suggestion**: agent recommends, human decides and acts.
- **A2 Approve**: agent proposes an action, human approves before execution.
- **A3 Oversight**: agent acts, human monitors and can intervene.
- **A4 Delegated**: agent acts independently within defined boundaries, human reviews periodically.
- **A5 Autonomous**: agent acts independently with minimal human involvement.

The key insight: autonomy is earned, not declared. An agent does not start at A5 because the product team wants it to. It starts at A1 and progresses as the infrastructure, reliability data, and governance thresholds justify it.

### Implementation Architecture: Composability, Not Categories

A common mistake is treating workflows, agent loops, and autonomous agents as exclusive choices: pick one architecture and build around it. The framework rejects this. They compose.

A workflow can contain an agent loop step that delegates to an autonomous sub-agent. The outer layer sets the reliability floor and tightens the error margin. The inner layer raises the quality ceiling. A customer service system might use a deterministic workflow for routing and compliance checks, an agent loop for understanding the customer's problem, and an autonomous sub-agent for searching knowledge bases and drafting responses. Each layer has a different reliability profile, and the composition determines the overall system's governance requirements.

This matters because the implementation architecture determines how knowable your error margin is. A pure workflow has enumerable failure modes: you can test every branch. A pure autonomous agent has an open-ended failure space. A composed system inherits the reliability floor of its outer layer while gaining the capability ceiling of its inner layer. The architecture choice is not about capability. It is about how confidently you can govern the result.[^7]

### Durability: Build on What Stays Stable

Models improve. Scaffolding becomes obsolete. What lasts?

Shane identifies three durable investments:

1. **Workflow logic**: the business rules that govern what should happen, regardless of which model executes them.
2. **Context infrastructure**: how information reaches agents at the right time, with the right permissions. Well-structured context appreciates with every model upgrade.
3. **Evaluation pipelines**: the ability to measure whether agents are actually working, across tasks, over time.

And one liability: **harness debt**. Scaffolding built to compensate for weaker models (retry logic, output parsers, chain-of-thought templates) becomes dead weight when models improve. The Claude Code team demonstrated this: as the underlying model got better, they deleted scaffolding rather than optimizing it.[^3]

The practical implication: invest in context and evaluation. Be cautious about investing heavily in model-specific workarounds. And when you do build scaffolding, design it as composable layers rather than monolithic pipelines, so you can strip away the outer constraints as the model earns more autonomy.

## Accountability: Who Is Accountable, and Can You Prove It?

Agents are already making decisions in your organization. Some you deployed deliberately. Others you do not know about. When something goes wrong, someone has to explain what happened. If the liability chain is not mapped before the incident, it is too late to draw one after.

### Shadow Agents

The framework confronts a reality most governance models ignore: shadow agents exist. Employees are building agents using low-code tools, browser extensions, and LLM APIs without going through compliance review. These agents use the employee's credentials, operate without audit trails, and the organization does not know they exist.

You cannot govern what you cannot see. The first accountability question is not "who is responsible for this agent?" It is "do you know every agent running in your organization?"

### Delegation Becomes Abdication

When a human delegates to an agent, the agent interprets and expands that intent. The gap between what was delegated and what was acted on is where accountability dissolves. Shane frames this sharply: delegation without traceability is abdication.

The infrastructure requirement is a delegation chain that captures:

- What authority was granted (scope, duration, constraints)
- How the agent interpreted that authority (decisions made, tools called)
- What the agent actually did (actions taken, resources accessed)
- Whether authority decreased at each hop (no privilege escalation through delegation)

OAuth 2.0 Token Exchange (RFC 8693) provides a mechanism for the first part: passing scoped tokens through a delegation chain with on-behalf-of semantics. But token exchange alone does not capture agent decisions or enforce monotonically decreasing authority. That requires additional infrastructure.[^4]

### Audit Trails for Compliance

Audit trails for agents are not application logs. They are compliance artifacts. The difference matters.

Application logs tell you what happened technically: which API was called, what the response code was, how long it took. Compliance audit trails need to answer different questions: who authorized this action, what information did the agent have when it decided, was the decision within the agent's granted authority, and can you demonstrate this to a regulator?

The EU AI Act requires transparency, human oversight, and record-keeping for high-risk AI systems. As enforcement begins in August 2026, organizations deploying agents in regulated contexts need audit trails that were designed for this purpose, not repurposed server logs.[^5]

### Liability Chains

The framework insists that liability chains be mapped before deployment, not after an incident. This means answering:

- Who owns this agent? (developer, deploying organization, operating team)
- Who authorized its deployment? (governance approval, risk assessment)
- Who is responsible when it fails? (not "the AI," but a named person or team)
- What is the escalation path? (how does a failure get from detection to resolution)

These are organizational questions, not technical ones. But they need technical infrastructure to be answerable: identity systems that tie agents to owners, delegation systems that trace authority, and audit systems that capture decisions.

## Control: Can Your Infrastructure Enforce What Policy Demands?

Policy says "don't." Architecture says "can't." The difference matters when agents act autonomously across systems and organizations.

### Infrastructure as Gate

The framework uses a five-level infrastructure scale:

- **I1 Open**: no controls. Agent operates with whatever access it has.
- **I2 Logged**: actions are recorded, but not constrained.
- **I3 Verified**: agent identity is verified before access is granted.
- **I4 Authorized**: access is scoped by role, task, and delegation chain.
- **I5 Contained**: agent operates in a sandboxed environment with strict boundaries.

Most organizations are at I1 or I2. The framework argues that the infrastructure level is a gate, not a slider: you either have audit trails or you do not. You either verify agent identity or you do not. There is no "partial" containment.

The infrastructure level constrains the autonomy level. An A4 (Delegated) agent requires at minimum I4 (Authorized) infrastructure. An A5 (Autonomous) agent requires I5 (Contained). You cannot earn higher autonomy without building the infrastructure to support it.[^2]

### Agent Identity

Traditional identity systems were built for humans and services. Agents need something different: an identity that answers who this agent is, who it acts for, and how you prove both.

The emerging stack includes:

- **Decentralized Identifiers (DIDs)**: self-sovereign identifiers that do not depend on a central authority.
- **Verifiable Credentials (VCs)**: cryptographic proofs of attributes (this agent was built by X, deployed by Y, authorized for Z).
- **OAuth On-Behalf-Of**: tokens that carry delegation semantics, showing the chain from human to agent.
- **DPoP (Demonstration of Proof-of-Possession)**: binds tokens to specific keys, so stolen tokens are useless.

Within a single organization, OAuth OBO may be sufficient. Across organizations, you need portable, cryptographic proof: VCs, DIDs, and protocols like the Trust Spanning Protocol (TSP) that enable trust without a shared authority.[^4]

### The Inverse of Human Trust

Shane makes a distinction that reframes how organizations should think about agent permissions: humans are trusted within broad boundaries, and we design organizations to minimize constraints on people. Agents require the opposite.

For humans, we start with trust and add restrictions where needed (blocklist approach). For agents, we should start with zero authority and grant specific capabilities (allowlist approach). The reason is practical: the set of things an agent should not do is infinite and unknowable in advance. The set of things it should do is finite and specifiable.

This maps to capability-based security: instead of giving an agent a role with broad permissions and blocking specific actions, give it explicit capabilities scoped to its current task. When the task is done, the capabilities expire.[^6]

### Cross-Organization Trust

When agents operate within a single trust domain, existing infrastructure (OAuth, API gateways, service mesh) can be extended to handle them. The hard problem is cross-organizational: when your agent calls my agent, how do I verify its identity, check its authority, and maintain accountability?

The Trust Spanning Protocol (TSP) addresses this by enabling verifiable interactions across trust boundaries without requiring a shared identity provider. eIDAS 2.0 and European Digital Identity (EUDI) wallets provide a regulatory framework for cross-border digital identity. These are converging toward an infrastructure layer where agents can present verifiable credentials across organizational boundaries.[^4]

This is not deployed at scale yet. But the architectural direction is clear, and organizations building agent infrastructure today should design for cross-organizational trust, not just internal deployment.

## The Interdependencies

The three pillars are not independent. The framework explicitly maps the failure modes of addressing them in isolation:

**Potential without Accountability**: reckless adoption. You build fast, ship agents that deliver value, and hit a wall at the first incident when nobody can explain what happened or who is responsible.

**Accountability without Control**: governance on paper. You have policies, risk assessments, and liability chains documented, but no infrastructure to enforce them. The policies say agents need scoped credentials. The agents have admin tokens.

**Control without Potential**: infrastructure without mandate. You build sophisticated identity, delegation, and sandboxing infrastructure, but the business does not see enough value to fund it. The project dies from lack of adoption.

The framework works when all three pillars inform each other iteratively. Your infrastructure level constrains your autonomy level. Your autonomy level determines your blast radius. Your blast radius sets your governance threshold. Your governance threshold drives your infrastructure requirements.

This is a cycle, not a checklist. Models improve, protocols land, regulations tighten, internal policies evolve. Your own progress shifts the landscape: the right control infrastructure unlocks new autonomy levels, which opens new use cases, which creates new blast radius, which demands new accountability. The PAC Framework is a living practice, not a one-time assessment.

## Applying the Framework

The subsequent chapters apply PAC to specific technical domains:

- **Agent Identity and Delegation**: how identity, credentials, and authority flow through agent systems (Control + Accountability)
- **Context Infrastructure**: what information reaches agents and how to govern it (Potential + Control)
- **The Regulatory Landscape**: how the EU AI Act, NIST guidance, and emerging standards map to PAC (Accountability)
- **Reliability, Evaluation, and the Complacency Trap**: measuring whether agents work, the dangerous intersection of improving reliability and degrading oversight, and why infrastructure must replace human vigilance (Potential + Accountability)
- **Agent Payments and Economics**: how agents transact, payment as a trust signal, and the infrastructure that enables agent commerce (Potential + Control)
- **Sandboxing and Execution Security**: containment by architecture rather than policy, from OS-level sandboxing to defense in depth (Control)
- **Cross-Organization Trust**: the hard problem of agents operating across trust boundaries, from protocol-level solutions (TSP, PIC) to credential infrastructure (VCs, EUDI wallets) (Control + Accountability)
- **Agent Communication Protocols**: how agents discover tools and each other, the security gap between adoption and maturity, and why communication protocols solve discovery but not trust (Potential + Control)
- **Agent Supply Chain Security**: trust beyond the agent itself, from tool poisoning to dependency confusion, and the emerging AI-BOM standard (Control + Accountability)
- **Shadow Agent Governance**: the transition from ungoverned to governed agents, discovery, registration, and infrastructure enforcement (Accountability + Control)
- **Multi-Agent Trust and Orchestration**: how trust properties compose across delegation chains, Delegation Capability Tokens, cascading failures, and governance that scales with depth (Control + Accountability + Potential)
- **Human-Agent Collaboration Patterns**: designing oversight that works, the autonomy dial, permission granularity matched to blast radius, and agent self-governance as complement to human oversight (Accountability + Potential)
- **Building the Inferential Edge**: synthesis chapter. How the technical chapters compose into a trust infrastructure stack, a phased implementation roadmap, and why the edge compounds (Potential + Accountability + Control)

Each chapter connects back to this framework. The goal is not to memorize the levels and scales. It is to internalize the relationships between them, so that when you make a decision about agent deployment, you naturally ask: what is the blast radius, do I have the infrastructure, and can I prove accountability?

---

[^1]: Shane Deconinck, PAC Framework, trustedagentic.ai. The framework and its dimensions are the source for this entire chapter.
[^2]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," trustedagentic.ai, February 2026.
[^3]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," trustedagentic.ai, February 2026. The Claude Code scaffolding deletion example is cited directly.
[^4]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," trustedagentic.ai, January 2026. Also: "Auth for Agent Builders: A Crash Course," January 2026.
[^5]: Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," trustedagentic.ai, January-March 2026. EU AI Act enforcement timeline per European Commission.
[^6]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," trustedagentic.ai, February 2026.
[^7]: Shane Deconinck, PAC Framework, trustedagentic.ai, updated March 2026. The implementation architecture composability model, error margin emphasis, and the distinction between enumerable and open-ended failure modes are from the March 2026 framework revision.
