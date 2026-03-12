# Human-Agent Collaboration Patterns

The complacency trap chapter diagnosed a problem: humans are bad at monitoring systems that rarely fail. The solution is not to remove humans from oversight. It is to redesign how humans and agents work together so that oversight does not depend on sustained vigilance.

This chapter is about that redesign. How to structure the collaboration between humans and agents so that governance is effective, not performative. How to set the right autonomy level for each task, not each agent. How to build interfaces that make oversight actionable rather than exhausting. And how to let agents participate in their own governance by recognizing when they are uncertain.

## Three Oversight Models

The industry has evolved through three distinct approaches to human-agent oversight. Understanding what each offers and where each fails is the starting point.

### Human-in-the-Loop (HITL)

The original model: agents propose, humans approve. Every significant action requires explicit human authorization before execution.

HITL works when the decision volume is low, the stakes are high, and the human has the expertise to evaluate each decision meaningfully. A financial agent proposing a trade above a certain threshold. A medical agent recommending a treatment plan. A legal agent drafting contract language.

HITL fails when it scales. An agent processing hundreds of customer service requests per hour cannot wait for human approval on each one. The human becomes a bottleneck, then a rubber stamp, then a liability. The complacency research is unambiguous: approval rates climb as volume increases, review quality drops, and "oversight" becomes a checkbox that provides legal cover without actual governance[^complacency-chapter].

Anthropic's data quantifies the decay. New users of Claude Code fully auto-approve about 20% of their sessions. After roughly 750 sessions, that number climbs past 40%[^anthropic-autonomy]. The humans are not becoming reckless. They are responding rationally to a system that is almost always right: the cost of reviewing every action exceeds the benefit of catching the rare error. This is not a character flaw. It is an architectural failure.

### Human-on-the-Loop (HOTL)

The evolution: agents act, humans monitor. The human is not in the decision path but observes the system and can intervene when something goes wrong.

HOTL unlocks speed. An agent responding to cybersecurity threats needs to isolate a compromised endpoint immediately, not wait for approval. An agent managing inventory needs to reorder supplies in real time. The decision velocity of these tasks exceeds human reaction time[^hotl-evolution].

HOTL fails when monitoring is passive. The same complacency dynamics apply: a human watching a dashboard of an agent that almost always behaves correctly will stop watching. Bainbridge's 1983 insight about automation irony applies directly: the operator becomes a monitor who no longer has the contextual understanding to intervene effectively when intervention is needed[^complacency-chapter].

The distinction between HITL and HOTL is often presented as a maturity progression: start with HITL, graduate to HOTL as confidence builds. This framing misses the point. Neither model solves the fundamental problem, which is that human attention is a depletable resource being deployed against a system that operates at machine speed.

### Infrastructure-in-the-Loop

The model this book advocates: infrastructure enforces governance. Humans design policies and boundaries. Machines enforce them continuously.

Shane frames this as the difference between "don't" and "can't." Policy says the agent should not access production databases without authorization. Infrastructure makes it so the agent *cannot* access production databases without authorization. The difference matters because "don't" depends on the agent's compliance and the human's vigilance. "Can't" depends on neither[^pac-framework].

Infrastructure-in-the-loop does not remove humans from governance. It moves them from enforcement to design. Humans define the authorization boundaries, set the blast radius thresholds, configure the anomaly detection rules, and investigate flagged incidents. These are high-value activities that play to human strengths: judgment, context, and strategic thinking. What humans no longer do is watch a stream of agent actions and approve each one. That is the task they were failing at.

The PAC Framework's infrastructure levels (I1 through I5) define what this looks like concretely:

- At **I2 (Logged)**, the human can investigate after the fact but cannot prevent unauthorized actions in real time.
- At **I3 (Verified)**, agent identity is confirmed and structured audit trails exist. The human reviews patterns, not individual actions.
- At **I4 (Authorized)**, scoped permissions are enforced before each action. The human sets the scope, infrastructure enforces it.
- At **I5 (Contained)**, sandboxed execution with automatic containment. The human defines containment policies, infrastructure executes them.

Moving from HITL to infrastructure-in-the-loop is not about trusting agents more. It is about trusting human attention less and building systems that do not depend on it.

## The Autonomy Dial

Most organizations think about autonomy at the agent level: "this agent is autonomous" or "this agent requires approval." The PAC Framework's autonomy scale (A1 through A5) is more nuanced but still describes the agent as a whole.

In practice, trust is task-specific. You trust your assistant to schedule meetings but not to send emails to clients on your behalf. You trust a coding agent to refactor internal utilities but not to modify authentication logic. The same agent, operating under the same identity, requires different oversight for different actions.

The autonomy dial pattern implements this. Instead of a single autonomy level per agent, each task type gets its own setting[^smashing-patterns]:

**Observe and Suggest (A1)**: the agent analyzes and recommends but takes no action. Appropriate for novel task types, high-stakes decisions, or domains where the human has expertise the agent lacks.

**Plan and Propose (A2)**: the agent creates a complete plan with specific actions, then waits for review. The human sees what will happen before it happens. Appropriate for medium-stakes tasks where the human needs to verify intent, not just correctness.

**Act with Confirmation (A3)**: the agent prepares the action and presents a one-click confirmation. The human's role is a final check, not a deep review. Appropriate for routine tasks where the agent has demonstrated reliability and the blast radius is bounded.

**Act and Report (A4)**: the agent acts autonomously and reports what it did. The human reviews selectively, usually through batch summaries or exception reports. Appropriate for high-volume, low-stakes tasks where review latency would negate the value of automation.

**Full Autonomy (A5)**: the agent acts within defined boundaries with no per-action reporting. Governance is entirely infrastructure-enforced: authorization scope, budget limits, audit trails. Appropriate only when I4+ infrastructure is in place and the blast radius is well-understood.

The key insight is that the dial should be set per task type, not per agent, and it should be dynamic. An email agent might operate at A4 for internal scheduling but A2 for client-facing communications. A coding agent might operate at A5 for test generation but A2 for production deployments. The mapping between task type and autonomy level is the governance artifact that organizations need to create and maintain.

Anthropic's data shows that users naturally gravitate toward this model. On the most complex goals in Claude Code, the model asks for clarification in 16.4% of turns, while humans interrupt in only 7.1%[^anthropic-autonomy]. The agent recognizes its own uncertainty more often than the human recognizes it. This suggests that the autonomy dial should not be set purely by human judgment: the agent's own confidence signal should factor in.

## UX Patterns That Work

The design of the interface between humans and agents determines whether oversight is effective or theatrical. Recent UX research has identified patterns that make the difference[^smashing-patterns][^ux-magazine].

### Pre-Action: Making Intent Visible

**Step visibility**: show the agent's plan before execution. Not just "I will do X" but the reasoning chain: what it observed, what it concluded, what it plans to do and why. This does not require the human to read every step. It creates an artifact that can be reviewed selectively and audited later.

**Confidence signals**: surface the agent's uncertainty. When the agent is operating in a domain where its training data is thin, or when the current task diverges from its established patterns, the interface should make this visible. Not as a probability score (which humans interpret poorly) but as a behavioral signal: the agent slows down, asks questions, or presents alternatives instead of a single recommendation.

**Scope indicators**: show what the agent can and cannot do in the current context. A financial agent should display its spending limit, authorized payees, and transaction types before proposing actions. This makes the governance boundaries visible to the human, not just enforced by infrastructure.

### In-Action: Maintaining Awareness

**Explainable rationale**: for each action the agent takes, provide a concise justification. Not a chain-of-thought dump but a summary: "Rescheduled the meeting because two attendees have conflicts at the original time." This lets the human build a mental model of the agent's behavior without requiring them to watch every step[^smashing-patterns].

**Progressive disclosure**: default to minimal information with the ability to drill down. A batch summary ("processed 47 support tickets, escalated 3") is more useful than 47 individual notifications. The 3 escalations get full detail. The 44 routine completions get a line item.

**Interruption points**: design moments where the human can naturally check in. These are not approval gates (which create HITL dynamics) but structured pauses: end-of-batch summaries, periodic status reports, or threshold-triggered alerts. The human engagement is pull-based (reviewing when convenient) rather than push-based (responding to each notification).

### Post-Action: Recovery and Accountability

**Action audit and undo**: every agent action should be reversible where possible, and the reversal should be as easy as the original action. This is not just UX polish: it changes the risk calculus. If the human knows they can undo an agent's mistake in one click, they are more willing to grant higher autonomy. The undo function serves as a safety net that enables trust[^smashing-patterns].

**Escalation pathways**: when the agent encounters something outside its competence, it should have a clear path to human expertise. This is not a failure: it is a feature. An agent that knows when to stop is more trustworthy than one that always produces an answer. The interface should make escalation seamless, with full context transfer so the human does not start from scratch.

**Batch review interfaces**: for high-volume agents, the audit interface matters more than the action interface. Summarize 50 actions into a glanceable view. Highlight outliers. Let the human spot-check by exception rather than reviewing sequentially. The goal is to make review efficient enough that it actually happens, rather than theoretically required but practically skipped.

## Permission Granularity

One of the book's open questions has been: what is the right granularity for agent permissions? Per-task? Per-session? Per-tool-call?

The answer, emerging from both research and production experience, is: it depends on the blast radius.

**Per-tool-call authorization** is appropriate for B4 (regulated) and B5 (irreversible) actions. Each invocation of a tool that can transfer funds, modify medical records, or delete production data should require its own authorization token with explicit scope. Verifiable Intent's L3 credentials operate at this level: each payment gets its own signed credential, bounded by the constraints in the L2 intent layer[^vi-chapter].

**Per-task authorization** is appropriate for B2 (recoverable) and B3 (exposed) actions. A task might involve multiple tool calls, but the authorization covers the logical unit of work. "Resolve this support ticket" might involve reading the ticket, checking the customer's account, drafting a response, and sending it. The human authorizes the task; infrastructure scopes each tool call within the task boundary.

**Per-session authorization** is appropriate for B1 (contained) actions where the blast radius is bounded by design. A coding agent working in a sandboxed environment with no network access and no production credentials can operate with session-level authorization. The containment infrastructure (I5) limits what the agent can do regardless of what it tries.

The technical implementation is maturing. Authorization platforms like Permit.io and Cerbos now offer fine-grained, context-aware permission models designed for AI agents[^authz-platforms]. These platforms support attribute-based access control (ABAC) where permissions depend not just on who the agent is but on what it is doing, for whom, and in what context. An agent might have `read_calendar` permission broadly but `send_email` permission only for internal recipients during business hours.

The critical design principle: permission granularity should match blast radius, not convenience. Organizations consistently err toward coarser permissions because fine-grained authorization is harder to implement and manage. The result is agents with more authority than they need for any individual task, which is exactly the pattern that makes the confused deputy attack possible[^identity-chapter].

## The Self-Aware Agent

One of the most significant findings from Anthropic's autonomy research is that agents can participate in their own governance. Not through hard-coded rules but through learned behavior: recognizing uncertainty and requesting human input.

The data is striking. On complex tasks in Claude Code, the model initiates clarification requests in 16.4% of turns. Humans interrupt in only 7.1% of turns. The agent is recognizing its own uncertainty more than twice as often as the human recognizes it[^anthropic-autonomy].

This suggests a governance pattern that neither HITL nor HOTL captures: agent-initiated oversight. The agent is not waiting for human approval (HITL) or acting while the human watches (HOTL). It is acting autonomously until it encounters something that exceeds its confidence, at which point it stops and asks.

Anthropic's research recommends training models to recognize their own uncertainty as "an important kind of oversight in deployed systems" that complements external safeguards[^anthropic-autonomy]. This is significant because it means the agent's own behavior becomes part of the governance infrastructure. A well-calibrated agent that stops when uncertain is safer than a poorly-calibrated agent with human oversight, because the human oversight degrades with complacency while the agent's calibration does not.

The design implication: treat agent uncertainty signals as first-class governance events. Log them. Monitor their frequency. Track whether the agent's self-assessed uncertainty correlates with actual errors. If the agent stops asking for help, that is not a sign of improved capability: it might be a sign of degraded calibration. If the agent asks for help more often on a particular task type, that task type may need a higher autonomy dial setting.

This connects to an open question in the gaps chapter: auditing agent reasoning, not just actions. If chain-of-thought is a compliance artifact, then the agent's decision to escalate or proceed is itself auditable evidence of governance in action.

## The Organizational Shift

Deloitte's 2026 Tech Trends report frames the organizational challenge directly: agents are a "silicon-based workforce" that requires the same HR-like governance structures as human employees: onboarding, authorization, performance monitoring, and offboarding[^deloitte-silicon].

This framing clarifies what is actually changing. The shift is not from "no agents" to "agents." Most organizations already have agents, many of them unsanctioned (the shadow agent governance chapter quantifies this). The shift is from treating agents as software to treating agents as workforce participants with roles, responsibilities, and accountability chains.

What this looks like in practice:

**Onboarding**: an agent entering production gets a defined role, scoped permissions, a designated owner, and an initial autonomy level. This maps to the agent registry described in the shadow agent governance chapter: identity, owner, authority, permissions, blast radius classification, evaluation requirements[^shadow-chapter].

**Performance management**: ongoing evaluation against both capability metrics (Potential) and governance metrics (Accountability). Not just "does the agent complete tasks correctly?" but "does the agent stay within its authorized scope? Does it escalate appropriately? Does it maintain audit trail integrity?" Autonomy levels adjust based on performance against both dimensions.

**Escalation chains**: defined paths from agent to human for different types of decisions. Not a single "ask a human" fallback but differentiated escalation: technical questions go to the engineering team, policy questions to compliance, customer-facing decisions to the service team. The agent needs to know not just when to escalate but to whom.

**Offboarding**: when an agent is deprecated, its credentials are revoked, its outstanding authorizations are cancelled, its audit trails are archived, and its delegated authorities are reclaimed. This is the lifecycle management that most organizations lack for their human-to-agent delegation chains.

The critical insight from Deloitte is that only 14% of organizations have deployable agentic solutions and just 11% are actively using them in production[^deloitte-silicon]. But the organizations that are succeeding share a common trait: they redesigned processes around human-agent collaboration rather than automating existing processes. "If you just take your existing workflow and try to apply advanced AI to it, you're going to weaponize inefficiency."

This aligns with Shane's framing of the inferential edge: the competitive advantage is not having access to better models but having the infrastructure to deploy them effectively. The collaboration patterns described in this chapter are the human-facing layer of that infrastructure[^inferential-edge].

## Mapping to PAC

The human-agent collaboration landscape maps to all three PAC pillars:

| Dimension | Potential | Accountability | Control |
|---|---|---|---|
| **Oversight model** | HITL limits throughput; infrastructure-in-the-loop unlocks it | Agent actions must be traceable to authorizing humans | Infrastructure enforces what policy demands |
| **Autonomy dial** | Per-task autonomy maximizes value for each task type | Each autonomy level has different accountability requirements | Higher autonomy requires higher infrastructure maturity |
| **UX patterns** | Good interfaces increase adoption and trust | Explainable rationale supports audit and compliance | Scope indicators make governance boundaries visible |
| **Permission granularity** | Coarse permissions enable faster execution | Fine-grained permissions create clearer accountability chains | Authorization infrastructure must match blast radius |
| **Self-aware agents** | Uncertainty recognition prevents costly errors | Escalation events are auditable governance artifacts | Agent calibration is a measurable control property |
| **Organizational design** | Process redesign unlocks more value than automation | Defined roles and owners for every agent | Onboarding/offboarding lifecycle enforced by infrastructure |

The critical interdependency: effective collaboration requires all three pillars working together. Good UX patterns (Potential) without authorization infrastructure (Control) create agents that are easy to use but hard to govern. Strong infrastructure (Control) without clear ownership models (Accountability) creates secure systems that nobody is responsible for. Defined accountability (Accountability) without usable interfaces (Potential) creates governance requirements that get bypassed because they are too cumbersome.

## Infrastructure Maturity for Collaboration

| Level | What exists | Human-agent collaboration capability |
|---|---|---|
| **I1 Open** | No formal oversight model | Ad hoc: individuals choose their own oversight approach. No consistency, no governance |
| **I2 Logged** | Agent actions recorded | Post-hoc review possible but reactive. Batch review interfaces become useful. No real-time governance |
| **I3 Verified** | Agent identity confirmed, structured audit trails | Per-task autonomy dials with verified enforcement. Agent uncertainty signals logged and monitored. Organizational onboarding procedures formalized |
| **I4 Authorized** | Scoped permissions enforced per action | Full autonomy dial with per-task authorization. Permission granularity matches blast radius. Self-aware agent calibration tracked as governance metric. Escalation chains enforced by infrastructure |
| **I5 Contained** | Sandboxed execution with automatic containment | Infrastructure-in-the-loop fully realized. Agents operate at A4-A5 within defined boundaries. Human role shifts entirely to policy design, threshold setting, and exception investigation |

Most organizations are at I1 or I2 for human-agent collaboration. The EU AI Act's August 2026 enforcement deadline requires I3 for high-risk systems. Organizations building agent-first workflows should target I4, where the autonomy dial, permission granularity, and agent self-governance patterns described in this chapter become fully operational.

## What to Do

**Start with the autonomy dial, not the agent.** Map your agent's tasks, not just its identity. For each task type, determine the blast radius and set the autonomy level accordingly. A single agent will likely operate at different autonomy levels for different tasks. Document these mappings. Review them quarterly.

**Design interfaces for batch review, not real-time approval.** If your oversight model requires a human to approve each action, your oversight model will fail. Design for exception-based review: the human sees summaries, outliers, and flagged anomalies. Individual action review is reserved for escalations and audits.

**Treat agent uncertainty as a governance signal.** Monitor how often your agents escalate. Track whether escalation frequency correlates with error rates. If an agent stops escalating on a task type, investigate: it may have improved, or it may have become miscalibrated. Build dashboards that surface escalation patterns alongside accuracy metrics.

**Match permission granularity to blast radius.** B4-B5 actions get per-tool-call authorization. B2-B3 actions get per-task authorization. B1 actions get per-session authorization with containment infrastructure. Do not default to coarse permissions because they are easier to implement: the authorization surface is your last line of defense.

**Onboard agents like employees.** Defined role, scoped permissions, designated owner, documented escalation paths, initial autonomy level, evaluation criteria, and offboarding plan. If you cannot answer "who is responsible for this agent?" the agent should not be in production.

**Invest in the interface, not just the model.** A well-designed collaboration interface with a capable model will outperform a frontier model with a poor interface. The interface determines whether governance is effective or performative. Explainable rationale, scope indicators, undo capability, and escalation pathways are not UX polish: they are governance infrastructure[^smashing-patterns].

[^complacency-chapter]: See Chapter 6 of this book, "Reliability, Evaluation, and the Complacency Trap," for the full treatment of automation complacency research from Bainbridge (1983) and Don Norman (1990).

[^anthropic-autonomy]: Anthropic, ["Measuring AI Agent Autonomy in Practice"](https://www.anthropic.com/research/measuring-agent-autonomy) (February 2026). Also covered in Shane Deconinck, ["Early Indicators of Agent Use Cases: What Anthropic's Data Shows"](https://shanedeconinck.be/posts/early-indicators-agent-use-cases-anthropic-data/) (February 2026).

[^hotl-evolution]: The evolution from HITL to HOTL is discussed in multiple sources including ByteBridge, ["From Human-in-the-Loop to Human-on-the-Loop: Evolving AI Agent Autonomy"](https://bytebridge.medium.com/from-human-in-the-loop-to-human-on-the-loop-evolving-ai-agent-autonomy-c0ae62c3bf91) (January 2026).

[^pac-framework]: Shane Deconinck, [PAC Framework](https://trustedagentic.ai/framework/) (2026).

[^smashing-patterns]: Smashing Magazine, ["Designing For Agentic AI: Practical UX Patterns For Control, Consent, And Accountability"](https://www.smashingmagazine.com/2026/02/designing-agentic-ai-practical-ux-patterns/) (February 2026). A comprehensive taxonomy of UX patterns for agentic systems.

[^ux-magazine]: UX Magazine, ["Secrets of Agentic UX: Emerging Design Patterns for Human Interaction with AI Agents"](https://uxmag.com/articles/secrets-of-agentic-ux-emerging-design-patterns-for-human-interaction-with-ai-agents) (2026).

[^vi-chapter]: See Chapter 3 of this book, "Agent Identity and Delegation," for the full treatment of Verifiable Intent's three-layer SD-JWT architecture.

[^identity-chapter]: See Chapter 3 of this book, "Agent Identity and Delegation," for coverage of the confused deputy problem and how identity infrastructure addresses it.

[^authz-platforms]: Authorization platforms for AI agents are maturing rapidly. See [Permit.io](https://www.permit.io/ai-access-control), [Cerbos](https://www.cerbos.dev/blog/dynamic-authorization-for-ai-agents-guide-to-fine-grained-permissions-mcp-servers), and [Stytch](https://stytch.com/blog/handling-ai-agent-permissions/) for current approaches. WorkOS provides a [comparison of authorization platforms for AI agents](https://workos.com/blog/best-authorization-platforms-ai-agent-permissions-2026) (2026).

[^deloitte-silicon]: Deloitte, ["The agentic reality check: Preparing for a silicon-based workforce"](https://www.deloitte.com/us/en/insights/topics/technology-management/tech-trends/2026/agentic-ai-strategy.html), Tech Trends 2026.

[^shadow-chapter]: See Chapter 12 of this book, "Shadow Agent Governance," for the agent registry model and amnesty-based transition approach.

[^inferential-edge]: Shane Deconinck, ["When Intelligence Becomes Commodity, Infrastructure Becomes the Edge"](https://shanedeconinck.be/posts/inferential-edge/) (March 2026).
