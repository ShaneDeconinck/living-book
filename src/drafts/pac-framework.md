# The PAC Framework

The PAC Framework is a governance model for AI agents built around three interdependent pillars: Potential, Accountability, and Control. It was developed by Shane Deconinck and is published at trustedagentic.ai.[^1]

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

The first accountability question is not "who is responsible for this agent?" It is "do you know every agent running in your organization?"

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

The EU AI Act requires transparency, human oversight, and record-keeping for high-risk AI systems. High-risk obligations are originally set for August 2, 2026, though the Commission's Digital Omnibus proposal may push Annex III systems to December 2027 (see [The Regulatory Landscape](regulatory-landscape.md) for the full timeline). Either way, organizations deploying agents in regulated contexts need audit trails that were designed for this purpose, not repurposed server logs.[^5]

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

Two independent surveys in early 2026 quantify this failure mode precisely. Teleport's research found that over-privileged AI systems drive 4.5x higher incident rates: 76% of organizations with broadly scoped agent access reported security incidents, versus 17% of those with tightly scoped access.[^teleport] The predictor was not AI sophistication or model capability. It was access scope. Gravitee's survey of 919 executives and practitioners found that 82% of executives feel confident their policies protect against agent misuse, yet only 14.4% have full security approval for their agent deployments.[^gravitee] The confidence rests on policy documentation, not runtime enforcement. This is the exact gap between Accountability and Control: organizations believe they are governed because policies exist, while the infrastructure to enforce those policies does not.

**Control without Potential**: infrastructure without mandate. You build sophisticated identity, delegation, and sandboxing infrastructure, but the business does not see enough value to fund it. The project dies from lack of adoption.

The framework works when all three pillars inform each other iteratively. Your infrastructure level constrains your autonomy level. Your autonomy level determines your blast radius. Your blast radius sets your governance threshold. Your governance threshold drives your infrastructure requirements.

This is a cycle, not a checklist. Models improve, protocols land, regulations tighten, internal policies evolve. Your own progress shifts the landscape: the right control infrastructure unlocks new autonomy levels, which opens new use cases, which creates new blast radius, which demands new accountability. The PAC Framework is a living practice, not a one-time assessment.

## The Agent Profiler

The PAC Framework's pillars, dimensions, and scales describe the governance landscape. But how do you apply them to a specific agent deployment? Shane built the PAC Agent Profiler to answer this: a tool that maps six independent dimensions for a concrete use case, shows where the gaps are, and identifies what is blocking higher autonomy.[^profiler]

The profiler emerged from a practical frustration. Most governance conversations collapse everything into a single question: "how risky is this agent?" That bundles together what the agent does, what happens when it fails, how much freedom it has, and whether you have built the infrastructure to contain it. Too many questions crammed into one. The six dimensions separate them.

### Six Dimensions, One Assessment

Each dimension answers a question the others cannot:

1. **Business Value** (V1-V4): why you would accept any risk at all. Without it, there is nothing to discuss.
2. **Reliability**: the reality check. Better models, better evals, better guardrails. Most teams focus here, and it matters. But it is only meaningful relative to what happens when the agent fails.
3. **Blast Radius** (B1-B5): the worst-case impact of failure. This is fixed by the use case, not by engineering. You cannot engineer your way to a smaller blast radius: you can only choose which use cases to pursue.
4. **Infrastructure** (I1-I5): the guardrails you have actually built. Audit trails, identity verification, authorization, sandboxing, monitoring. This is where the model gets opinionated: infrastructure is binary per autonomy level.
5. **Governance Thresholds**: where the organization draws its lines. Regulatory requirements, internal policies, risk appetite. An agent might be technically capable of full autonomy, but if the compliance team requires human approval for anything touching customer data, that is the ceiling.
6. **Autonomy** (A1-A5): the output. Not an input you set, but a level the agent earns based on everything else.

The key insight: autonomy is the dependent variable. You do not start by deciding "this agent should be autonomous" and then figure out the requirements. You assess the other five dimensions, and the appropriate autonomy level falls out. Shane puts it directly: "Autonomy is earned, not declared."[^profiler]

### Infrastructure as Gate, Not Slider

This is where the profiler diverges from typical risk frameworks. Most frameworks treat everything as a spectrum. Infrastructure does not work that way. You either have audit trails or you do not. You either verify agent identity or you do not.

In the profiler, infrastructure requirements are cumulative per autonomy level:

- **A2 (Approve)**: basic logging and human confirmation flows.
- **A3 (Oversight)**: structured audit trails and monitoring.
- **A4 (Delegated)**: identity verification, scoped authorization, and sandboxing.
- **A5 (Autonomous)**: all of the above plus anomaly detection and automated containment.

No amount of reliability compensates for guardrails you have not built. A brilliant agent without audit trails cannot be trusted with delegated authority, because when something goes wrong you have no way to understand what happened. This makes the profiler actionable: instead of "improve your governance posture," it says specifically: "you need identity verification and authorization scopes before this agent can move from human-approval to oversight mode."[^profiler]

Eighty percent of tool calls come from agents with at least one safeguard in place, and 73% appear to have a human in the loop.[^anthropic-autonomy-profiler] The infrastructure exists or it does not. Organizations build it before granting autonomy, not after.

### Using the Profiler

The profiler is available at trustedagentic.ai/profiler (open source, v0.1). Map the six dimensions for a specific use case: see where the gaps are, understand what is blocking higher autonomy, and get a concrete path forward.

The profiler also changes over time. As you build infrastructure, improve reliability, or as the organization adjusts its governance thresholds, the same agent can earn higher autonomy. It is a progression, not a one-time decision. This connects to the iterative practice described in the [Building the Inferential Edge](building-the-edge.md) chapter: each PAC cycle refines your position across all six dimensions simultaneously.

## The 19 Questions

The framework distills each pillar into concrete questions designed for stakeholders at every level: engineering, security, compliance, and leadership. These are conversation starters, not a checklist. The right question at the right table surfaces gaps that dashboards and audits miss.[^1]

### Potential

1. **What decisions are you not yet delegating to agents, and what's that costing you?** The answer reveals where value is being left on the table. [Context Infrastructure](context-infrastructure.md) and [Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md) determine which decisions agents can handle.

2. **Will better models make your current setup more valuable, or obsolete?** This is the durability question. If your architecture is tightly coupled to a specific model's weaknesses (harness debt), the next model drop makes it a liability. Context infrastructure appreciates. Scaffolding depreciates.

3. **How much value are you leaving on the table by over-constraining?** Governance that is too tight kills adoption. Shadow agents (the [Shadow Agent Governance](shadow-agent-governance.md) chapter) are the evidence: employees route around constraints when governance moves too slowly. The solution is governance at agent speed, not tighter prohibition.

4. **Are your agents actually making decisions, or just automating steps humans already defined?** The difference between workflow automation and agentic AI. True agent value comes from handling judgment-heavy tasks: interpretation, adaptation, exception handling. If the agent is only following a deterministic script, you have an expensive workflow, not an agent.

5. **Does the right context reach your agents at the right time?** [Context Infrastructure](context-infrastructure.md) is the durable investment. Shane's argument: context appreciates with every model upgrade. The question is whether your context pipelines are structured, permissioned, and fresh enough to enable agent decision-making.

6. **Are you building on established and emerging standards, or on an island?** [Communication protocols](agent-communication.md), [identity standards](agent-identity.md), and [regulatory frameworks](regulatory-landscape.md) are converging fast. Building on standards reduces lock-in risk and positions for cross-organizational interoperability.

7. **Do you know the error margin on your agent's reliability, or just the headline number?** The [Reliability, Evaluation](reliability-evaluation.md) chapter makes this case in depth. A percentage without a confidence interval is meaningless. The implementation architecture (workflow, agent loop, autonomous) determines how knowable your error margin is.

### Accountability

8. **Do you know every agent running in your organization?** The [Shadow Agent Governance](shadow-agent-governance.md) chapter is built around this question. 98% of organizations report employees using unsanctioned apps, and 78% of employees bring their own AI tools to work regardless of company policy.[^shadow-ai]

9. **If an agent causes harm, is the liability chain clear?** Liability chains must be mapped before the incident (this chapter, above). Who owns the agent, who authorized it, who is responsible when it fails, and what is the escalation path?

10. **Can your infrastructure prevent an agent from running without being registered?** This is Shane's sharpest boardroom question. It separates discovery (knowing what agents exist) from governance (preventing unregistered agents from operating). Only infrastructure enforcement (the [Shadow Agent Governance](shadow-agent-governance.md) chapter covers how) provides the structural guarantee.

11. **Could you explain to a regulator what your agent did and why?** [The Regulatory Landscape](regulatory-landscape.md) maps the compliance requirements. The EU AI Act requires transparency and record-keeping for high-risk systems. Audit trails designed for compliance, not debugging, are the infrastructure requirement.

12. **When an agent makes a consequential decision, can you trace who authorized it and what happened?** [Delegation chains](agent-identity.md), audit trails (this chapter), and [multi-agent orchestration](multi-agent-trust.md) compose into the answer. The trace must go from the human principal through every delegation hop to the final action.

### Control

13. **Are your agents contained by architecture, or only by policy?** Policy says "don't." Architecture says "can't." [Sandboxing](execution-security.md) and [identity infrastructure](agent-identity.md) are what make the difference when agents act autonomously.

14. **When agents delegate to other agents, can authority only decrease?** The [Multi-Agent Trust and Orchestration](multi-agent-trust.md) chapter covers Delegation Capability Tokens and PIC. Authority attenuation at every hop is a non-negotiable property for multi-agent systems.

15. **What happens when human oversight breaks down in practice?** The [Human-Agent Collaboration](human-agent-collaboration.md) chapter and the [Reliability, Evaluation](reliability-evaluation.md) chapter address this directly. Bainbridge's irony: the more reliable the agent, the less attentive the human overseer. Infrastructure-in-the-loop replaces sustained human vigilance.

16. **How do you balance agent quality with data privacy?** Agents need context to perform well, but data governance constrains what they can access. [Context Infrastructure](context-infrastructure.md) addresses the permissioning layer. [The Regulatory Landscape](regulatory-landscape.md) sets the legal constraints.

17. **Are agents restricted to what they can do, or only blocked from what they can't?** Shane's trust inversion. Humans operate on blocklists (default allow, block specifics). Agents should operate on allowlists (default deny, grant specifics). Capability-based security scoped to the current task.

18. **Does your agent setup work when agents need to cross trust boundaries?** [Cross-Organization Trust](cross-org-trust.md) is the hard problem. TSP, PIC, Verifiable Credentials, and EUDI wallets compose into the infrastructure for agents operating across organizational boundaries.

19. **What happens when an agent wanders into a use case you didn't anticipate?** [Sandboxing](execution-security.md) and [supply chain security](supply-chain-security.md) contain the blast radius. But the deeper answer is the autonomy-infrastructure gate: agents operating at higher autonomy levels (A4-A5) require higher infrastructure levels (I4-I5), which structurally constrain the space of possible actions.

The goal is not to memorize the levels and scales. It is to internalize the relationships between them, so that when you make a decision about agent deployment, you naturally ask: what is the blast radius, do I have the infrastructure, and can I prove accountability?

---

[^1]: Shane Deconinck, PAC Framework, trustedagentic.ai. The framework and its dimensions are the source for this entire chapter.
[^2]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 2026.
[^3]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," shanedeconinck.be, February 2026. The Claude Code scaffolding deletion example is cited directly.
[^4]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," shanedeconinck.be, January 2026. Also: "Auth for Agent Builders: A Crash Course," January 2026.
[^5]: Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," shanedeconinck.be, January-March 2026. EU AI Act enforcement timeline per European Commission. The Digital Omnibus proposal (November 2025) may defer Annex III high-risk obligations to December 2027; see the Regulatory Landscape chapter for details.
[^6]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," shanedeconinck.be, February 2026.
[^7]: Shane Deconinck, PAC Framework, trustedagentic.ai, updated March 2026. The implementation architecture composability model, error margin emphasis, and the distinction between enumerable and open-ended failure modes are from the March 2026 framework revision.
[^teleport]: Teleport, "State of AI in Enterprise Infrastructure Security" (February 2026). Survey finding: over-privileged AI systems drive 4.5x higher incident rates. Access scope, not AI sophistication, is the strongest predictor of security outcomes.
[^gravitee]: Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control" (February 2026). Survey of 919 executives and practitioners. 82% executive confidence vs. 14.4% full security approval.
[^profiler]: Shane Deconinck, ["Untangling Autonomy and Risk for AI Agents"](https://shanedeconinck.be/posts/agent-profiler-reasoning/), shanedeconinck.be, February 26, 2026. Introduces the PAC Agent Profiler and six-dimension model. The profiler is available at [trustedagentic.ai/profiler](https://trustedagentic.ai/profiler/) (open source).
[^shadow-ai]: The 98% figure (organizations with employees using unsanctioned apps) is from Varonis, ["Shadow AI: The Growing Risk of Unsanctioned AI in the Enterprise,"](https://www.varonis.com/blog/shadow-ai) 2026. The 78% BYOAI figure is from Microsoft WorkLab, 2026 Work Trend Index. One in five organizations has experienced a breach tied to shadow AI (IBM, Cost of a Data Breach Report 2024).
[^anthropic-autonomy-profiler]: Anthropic, ["Measuring AI Agent Autonomy in Practice"](https://www.anthropic.com/research/measuring-agent-autonomy), February 2026. 80% of tool calls come from agents with at least one safeguard; 73% appear to have a human in the loop.
