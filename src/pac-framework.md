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

### Reliability and Blast Radius

Reliability is not a single number. It is a percentage with an error margin. An agent that "works 95% of the time" means something very different depending on what happens the other 5%.

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

### Durability: Build on What Stays Stable

Models improve. Scaffolding becomes obsolete. What lasts?

Shane identifies three durable investments:

1. **Workflow logic**: the business rules that govern what should happen, regardless of which model executes them.
2. **Context infrastructure**: how information reaches agents at the right time, with the right permissions. Well-structured context appreciates with every model upgrade.
3. **Evaluation pipelines**: the ability to measure whether agents are actually working, across tasks, over time.

And one liability: **harness debt**. Scaffolding built to compensate for weaker models (retry logic, output parsers, chain-of-thought templates) becomes dead weight when models improve. The Claude Code team demonstrated this: as the underlying model got better, they deleted scaffolding rather than optimizing it.[^3]

The practical implication: invest in context and evaluation. Be cautious about investing heavily in model-specific workarounds.

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

The next chapters apply PAC to specific technical domains:

- **Agent Identity and Delegation**: how identity, credentials, and authority flow through agent systems (Control + Accountability)
- **Context Infrastructure**: what information reaches agents and how to govern it (Potential + Control)
- **Reliability and Evaluation**: measuring whether agents work, and what to do when they do not (Potential + Accountability)
- **Regulatory Landscape**: how the EU AI Act, NIST guidance, and emerging standards map to PAC (Accountability)
- **Agent Payments and Economics**: how agents transact and what infrastructure enables it (Potential + Control)

Each chapter connects back to this framework. The goal is not to memorize the levels and scales. It is to internalize the relationships between them, so that when you make a decision about agent deployment, you naturally ask: what is the blast radius, do I have the infrastructure, and can I prove accountability?

---

[^1]: Shane Deconinck, PAC Framework, trustedagentic.ai. The framework and its dimensions are the source for this entire chapter.
[^2]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," trustedagentic.ai, February 2026.
[^3]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," trustedagentic.ai, February 2026. The Claude Code scaffolding deletion example is cited directly.
[^4]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," trustedagentic.ai, January 2026. Also: "Auth for Agent Builders: A Crash Course," January 2026.
[^5]: Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," trustedagentic.ai, January-March 2026. EU AI Act enforcement timeline per European Commission.
[^6]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," trustedagentic.ai, February 2026.
