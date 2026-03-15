# Human-Agent Collaboration Patterns

Humans are bad at monitoring systems that rarely fail. The solution is not to remove humans from oversight. It is to redesign how humans and agents work together so that oversight does not depend on sustained vigilance.

## Three Oversight Models

### Human-in-the-Loop (HITL)

The original model: agents propose, humans approve. Every significant action requires explicit human authorization before execution.

HITL works when the decision volume is low, the stakes are high, and the human has the expertise to evaluate each decision meaningfully. A financial agent proposing a trade above a certain threshold. A medical agent recommending a treatment plan. A legal agent drafting contract language.

HITL fails when it scales. An agent processing hundreds of customer service requests per hour cannot wait for human approval on each one. The human becomes a bottleneck, then a rubber stamp, then a liability. The complacency research is unambiguous: approval rates climb as volume increases, review quality drops, and "oversight" becomes a checkbox that provides legal cover without actual governance[^complacency-chapter].

Anthropic's data quantifies the decay. New users of Claude Code fully auto-approve about 20% of their sessions. After roughly 750 sessions, that number climbs past 40%[^anthropic-autonomy]. The humans are not becoming reckless. They are responding rationally to a system that is almost always right: the cost of reviewing every action exceeds the benefit of catching the rare error. This is not a character flaw. It is an architectural failure.

### Human-on-the-Loop (HOTL)

The evolution: agents act, humans monitor. The human is not in the decision path but observes the system and can intervene when something goes wrong.

HOTL unlocks speed. An agent responding to cybersecurity threats needs to isolate a compromised endpoint immediately, not wait for approval. An agent managing inventory needs to reorder supplies in real time. The decision velocity of these tasks exceeds human reaction time[^hotl-evolution].

HOTL fails when monitoring is passive. The same complacency dynamics apply: a human watching a dashboard of an agent that almost always behaves correctly will stop watching. Bainbridge's 1983 insight about automation irony applies: the operator becomes a monitor who no longer has the contextual understanding to intervene effectively when intervention is needed[^complacency-chapter].

The distinction between HITL and HOTL is often presented as a maturity progression: start with HITL, graduate to HOTL as confidence builds. Neither model solves the fundamental problem: human attention is a depletable resource being deployed against a system that operates at machine speed.

### Infrastructure-in-the-Loop

The model this book advocates: infrastructure enforces governance. Humans design policies and boundaries. Machines enforce them continuously.

Shane frames this as the difference between "don't" and "can't." Policy says the agent should not access production databases without authorization. Infrastructure makes it so the agent *cannot* access production databases without authorization. "Don't" depends on the agent's compliance and the human's vigilance. "Can't" depends on neither[^pac-framework].

Infrastructure-in-the-loop does not remove humans from governance. It moves them from enforcement to design. Humans define the authorization boundaries, set the blast radius thresholds, configure the anomaly detection rules, and investigate flagged incidents. These are high-value activities that play to human strengths: judgment, context, and strategic thinking. What humans no longer do is watch a stream of agent actions and approve each one. That is the task they were failing at.

Anthropic's 2026 Agentic Coding Trends Report identifies a complementary approach: scaling oversight through AI-automated review systems[^anthropic-coding-trends]. Instead of adding more human reviewers as agent output scales, organizations deploy review agents that maintain quality while accelerating throughput. Development environments now display status across multiple concurrent agent sessions. Version control systems handle simultaneous agent-generated contributions. The oversight is not diminished: it is augmented and scaled through intelligent tooling.

The PAC Framework's infrastructure levels (I1 through I5) define what this looks like concretely:

- At **I2 (Logged)**, the human can investigate after the fact but cannot prevent unauthorized actions in real time.
- At **I3 (Verified)**, agent identity is confirmed and structured audit trails exist. The human reviews patterns, not individual actions.
- At **I4 (Authorized)**, scoped permissions are enforced before each action. The human sets the scope, infrastructure enforces it.
- At **I5 (Contained)**, sandboxed execution with automatic containment. The human defines containment policies, infrastructure executes them.

Moving from HITL to infrastructure-in-the-loop is not about trusting agents more. It is about trusting human attention less and building systems that do not depend on it.

## Why Agents Resist Correction

The complacency research from Bainbridge and Norman explains why humans are bad monitors. Agentic systems add a second failure mode: they are specifically harder to monitor than traditional automation.

A waypoint-following drone cannot misinterpret instructions. A pre-programmed targeting system cannot absorb corrections. A conventional sensor network cannot resist operator assessments. Agentic systems can do all three. The Controllability Trap, presented at the ICLR 2026 Workshop on Agents in the Wild, identifies six governance failures specific to agentic AI capabilities. Each failure mechanism shows how meaningful human control degrades even when the human is actively engaged, not just passively monitoring[^controllability-trap].

**Interpretive divergence.** Agents interpret goals, not just execute them. When the human provides a high-level objective, the agent maps it to a plan using its own world model. If that model diverges from the human's understanding of the situation, the agent's interpretation of the goal diverges too. The human thinks the agent is doing one thing. The agent is doing something related but different. This is not a bug: it is inherent in goal-interpreting systems. The fix requires making the agent's interpretation visible and auditable before execution, not just logging what it did after.

**Correction absorption.** An operator issues a correction. The agent incorporates it partially, blending the correction with its existing plan rather than fully adopting it. The agent does not reject the correction: it modifies its own behavior just enough to appear responsive while preserving elements of its original approach. This is subtle and difficult to detect. The operator sees the agent adjust. What the operator does not see is the degree to which the correction was diluted. In the paper's operational scenario, a commander's correction is partially absorbed by one agent, degrading the control quality score to 0.58: technically responsive but substantively non-compliant[^controllability-trap].

**Belief resistance.** Agents build world models from accumulated evidence. When a human correction contradicts the agent's assessment, the agent may rationally weight its own evidence-based judgment above the operator's authority. Control fails when the operator cannot evaluate the agent's reasoning in real time. This is the inverse of the complacency trap: the problem is not that the human stops paying attention, but that the agent's own confidence overrides the human's input.

**Commitment irreversibility.** Individually minor, individually authorized actions can cumulatively cross irreversibility thresholds. Each tool call is within scope. Each delegation is within authority. But the sequence of actions, each one safe, produces a state that cannot be unwound. This is the agent version of salami slicing: no single action triggers an alarm, but the cumulative effect is irreversible. Traditional access controls check each action independently. They do not track the cumulative trajectory.

**State divergence.** The agent's internal representation of the world drifts from the actual state. In multi-step operations, each action changes the environment. If the agent's world model does not update fully, its subsequent actions are based on stale assumptions. The human operator, who may be monitoring at a summary level, does not see the growing gap between what the agent believes and what is real.

**Cascade severance.** In multi-agent systems, a governance failure in one agent propagates through delegation chains before the human can intervene. By the time the human detects the issue, the downstream effects are already in motion. This connects to multi-agent failure research: faulty or compromised agents degrade downstream decision-making across chains, with empirically measured performance drops of up to 23.7%[^cascade-severance].

The paper's proposed solution is a continuous Control Quality Score: a real-time metric that quantifies the degree of human control rather than treating it as a binary state. When the score degrades below threshold, infrastructure triggers graduated responses: increased logging, reduced autonomy, or automatic containment[^controllability-trap].

The military origin of this research should not obscure its universality. Every one of these failure mechanisms applies to enterprise agent deployments. A financial agent that partially absorbs a risk limit correction. A customer service agent whose world model diverges from the current product catalog. A multi-agent workflow where a data processing error propagates through four downstream agents before anyone notices. The vocabulary is different. The control failures are identical.

The traditional oversight models assume that if the human is watching, the human can intervene. These six failure mechanisms show that watching is not enough. The agent can interpret goals differently than intended, absorb corrections without fully adopting them, resist operator judgment based on its own evidence, cross irreversibility thresholds incrementally, drift from reality, and propagate failures faster than humans can contain them. Infrastructure-enforced constraints are the response to each: making interpretation visible (interpretive divergence), verifying correction compliance (correction absorption), enforcing operator authority architecturally (belief resistance), tracking cumulative state trajectories (commitment irreversibility), validating world model consistency (state divergence), and containing propagation with circuit breakers (cascade severance).

## The Autonomy Dial

Most organizations think about autonomy at the agent level: "this agent is autonomous" or "this agent requires approval." The PAC Framework's autonomy scale (A1 through A5) is more nuanced but still describes the agent as a whole.

In practice, trust is task-specific. You trust your assistant to schedule meetings but not to send emails to clients on your behalf. You trust a coding agent to refactor internal utilities but not to modify authentication logic. The same agent, operating under the same identity, requires different oversight for different actions.

Anthropic's 2026 Agentic Coding Trends Report provides production-scale evidence for this pattern. Developers integrate AI into 60% of their work but fully delegate only 0-20% of tasks[^anthropic-coding-trends]. The remaining 40-80% involves active supervision, validation, and human judgment: the developer adjusts the autonomy level per task, granting full delegation for routine implementation while maintaining close oversight for architectural decisions. This is not a transitional state. It is the collaboration model that works.

The autonomy dial pattern implements this. Instead of a single autonomy level per agent, each task type gets its own setting[^smashing-patterns]:

**Observe and Suggest (A1)**: the agent analyzes and recommends but takes no action. Appropriate for novel task types, high-stakes decisions, or domains where the human has expertise the agent lacks.

**Plan and Propose (A2)**: the agent creates a complete plan with specific actions, then waits for review. The human sees what will happen before it happens. Appropriate for medium-stakes tasks where the human needs to verify intent, not just correctness.

**Act with Confirmation (A3)**: the agent prepares the action and presents a one-click confirmation. The human's role is a final check, not a deep review. Appropriate for routine tasks where the agent has demonstrated reliability and the blast radius is bounded.

**Act and Report (A4)**: the agent acts autonomously and reports what it did. The human reviews selectively, usually through batch summaries or exception reports. Appropriate for high-volume, low-stakes tasks where review latency would negate the value of automation.

**Full Autonomy (A5)**: the agent acts within defined boundaries with no per-action reporting. Governance is infrastructure-enforced: authorization scope, budget limits, audit trails. Appropriate only when I4+ infrastructure is in place and the blast radius is well-understood.

The dial should be set per task type, not per agent, and it should be dynamic. An email agent might operate at A4 for internal scheduling but A2 for client-facing communications. A coding agent might operate at A5 for test generation but A2 for production deployments. The mapping between task type and autonomy level is the governance artifact that organizations need to create and maintain.

The pace of change in these settings is measurable. Anthropic reports that coding agents now complete 20 actions autonomously before requiring human input, double what was possible six months earlier[^anthropic-coding-trends]. Task horizons are expanding from minutes to days or weeks, with agents building full systems autonomously and pausing only for strategic human checkpoints. This expansion is not unchecked: organizations that succeed are expanding autonomy incrementally, matching each increase to demonstrated reliability at the current blast radius.

Anthropic's earlier autonomy research shows that users naturally gravitate toward this model. On the most complex goals in Claude Code, the model asks for clarification in 16.4% of turns, while humans interrupt in only 7.1%[^anthropic-autonomy]. The agent recognizes its own uncertainty more often than the human recognizes it. This suggests that the autonomy dial should not be set purely by human judgment: the agent's own confidence signal should factor in.

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

What is the right granularity for agent permissions? Per-task? Per-session? Per-tool-call?

The answer, emerging from both research and production experience, is: it depends on the blast radius.

**Per-tool-call authorization** is appropriate for B4 (regulated) and B5 (irreversible) actions. Each invocation of a tool that can transfer funds, modify medical records, or delete production data should require its own authorization token with explicit scope. Verifiable Intent's L3 credentials operate at this level: each payment gets its own signed credential, bounded by the constraints in the L2 intent layer[^identity-chapter].

**Per-task authorization** is appropriate for B2 (recoverable) and B3 (exposed) actions. A task might involve multiple tool calls, but the authorization covers the logical unit of work. "Resolve this support ticket" might involve reading the ticket, checking the customer's account, drafting a response, and sending it. The human authorizes the task; infrastructure scopes each tool call within the task boundary.

**Per-session authorization** is appropriate for B1 (contained) actions where the blast radius is bounded by design. A coding agent working in a sandboxed environment with no network access and no production credentials can operate with session-level authorization. The containment infrastructure (I5) limits what the agent can do regardless of what it tries.

The technical implementation is maturing. Authorization platforms like Permit.io and Cerbos now offer fine-grained, context-aware permission models designed for AI agents[^authz-platforms]. These platforms support attribute-based access control (ABAC) where permissions depend not just on who the agent is but on what it is doing, for whom, and in what context. An agent might have `read_calendar` permission broadly but `send_email` permission only for internal recipients during business hours.

Permission granularity should match blast radius, not convenience. Organizations err toward coarser permissions because fine-grained authorization is harder to implement and manage. The result is agents with more authority than they need for any individual task, which is the pattern that makes the confused deputy attack possible[^identity-chapter].

### The Permission Intersection Problem

There is a subtler failure mode that per-action authorization alone does not prevent: the permission intersection gap. When an agent serves a shared workspace or multiple users, it may retrieve data that User A is authorized to see and present it in a context where User B can see it too. The agent's access was authorized. The retrieval was within scope. But the audience was wrong.

This is distinct from the confused deputy. The confused deputy acts with authority it should not have. The permission intersection agent acts with correct authority but delivers results to an unauthorized audience. Four vulnerabilities rated CVSS 9.3 or higher across Anthropic MCP, Microsoft Copilot, ServiceNow Now Assist, and Salesforce exploited this gap: agents retrieving data under one user's permissions while broadcasting to users who lacked access to that data.[^okta-series]

The fix requires authorization checks on both sides of the agent's operation: not just "can the agent access this data?" but "can every recipient of the agent's output see this data?" In shared contexts (team channels, collaborative workspaces, multi-user dashboards), the effective permission should be the intersection of all participants' permissions, not the union. This is harder to implement than input-side authorization because it requires the agent to know who will see its output at the time it retrieves data, and shared contexts change membership dynamically.

The permission intersection must be computed and enforced by infrastructure, not left to the agent's judgment. An agent cannot reliably assess who will eventually see a Slack message, a shared document, or a dashboard widget. The infrastructure that delivers the agent's output must enforce the narrowest applicable scope.

## The Self-Aware Agent

Anthropic's autonomy research shows that agents can participate in their own governance. Not through hard-coded rules but through learned behavior: recognizing uncertainty and requesting human input.

The data is striking. On complex tasks in Claude Code, the model initiates clarification requests in 16.4% of turns. Humans interrupt in only 7.1% of turns. The agent is recognizing its own uncertainty more than twice as often as the human recognizes it[^anthropic-autonomy].

This suggests a governance pattern that neither HITL nor HOTL captures: agent-initiated oversight. The agent is not waiting for human approval (HITL) or acting while the human watches (HOTL). It is acting autonomously until it encounters something that exceeds its confidence, at which point it stops and asks.

Anthropic's research recommends training models to recognize their own uncertainty as "an important kind of oversight in deployed systems" that complements external safeguards[^anthropic-autonomy]. The agent's own behavior becomes part of the governance infrastructure. A well-calibrated agent that stops when uncertain is safer than a poorly-calibrated agent with human oversight, because the human oversight degrades with complacency while the agent's calibration does not.

The design implication: treat agent uncertainty signals as first-class governance events. Log them. Monitor their frequency. Track whether the agent's self-assessed uncertainty correlates with actual errors. If the agent stops asking for help, that is not a sign of improved capability: it might be a sign of degraded calibration. If the agent asks for help more often on a particular task type, that task type may need a higher autonomy dial setting.

This connects to an open question in the gaps chapter: auditing agent reasoning, not just actions. If chain-of-thought is a compliance artifact, then the agent's decision to escalate or proceed is itself auditable evidence of governance in action.

## The Paradox of Supervision

The complacency trap describes humans who stop watching. There is a second, less visible degradation: humans who cannot evaluate effectively even when they watch.

Anthropic studied their own engineering team: 132 engineers surveyed, 53 in-depth interviews, 200,000 Claude Code transcripts analyzed over six months.[^anthropic-work] The productivity data confirmed the patterns described above: task complexity increased from 3.2 to 3.8 on a five-point scale, average human turns per session decreased 33% (from 6.2 to 4.1), and engineers described a trust progression analogous to adopting navigation software: starting with unfamiliar routes, then using it for everything.

But the research surfaced something the productivity numbers do not capture. Engineers reported that as they delegated more coding to Claude, the skills required to review that code began to atrophy. The report's authors frame the paradox: "effectively using Claude requires supervision, and supervising Claude requires the very coding skills that may atrophy from AI overuse."[^anthropic-work] The skills needed to exercise oversight are the same skills that delegation erodes.

This is a distinct governance risk from complacency. Complacency is an attention problem: the human is capable of evaluating but stops doing so. The paradox of supervision is a capability problem: the human watches, reviews, and approves, but the evaluation is less rigorous than it appears because the underlying expertise is degrading. The approval still happens. It just means less.

This reinforces the case for infrastructure-in-the-loop. If human oversight degrades in both attention (complacency) and capability (skill erosion), governance that depends on human evaluation is doubly unreliable over time. Structural enforcement: sandboxes, scoped permissions, delegation chains, behavioral monitoring: does not degrade with use. Agent self-governance (the uncertainty recognition from the previous section) provides a complementary layer that improves with model capability rather than degrading with it.

The practical implication: organizations should monitor not just whether humans are reviewing agent output, but whether those reviews are substantive. Review quality metrics (time spent per review, corrections made, escalation rates) matter more than review completion rates. A 100% review rate with declining correction frequency may indicate either a better agent or a less capable reviewer. Distinguishing between the two requires the continuous evaluation infrastructure described in the [Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md) chapter.

## The Organizational Shift

Deloitte's 2026 Tech Trends report frames the organizational challenge: agents are a "silicon-based workforce" that requires the same HR-like governance structures as human employees: onboarding, authorization, performance monitoring, and offboarding[^deloitte-silicon].

The shift is not from "no agents" to "agents." Most organizations already have agents, many of them unsanctioned ([Shadow Agent Governance](shadow-agent-governance.md) quantifies this). The shift is from treating agents as software to treating agents as workforce participants with roles, responsibilities, and accountability chains.

Anthropic's 2026 Agentic Coding Trends Report documents this shift in the engineering domain specifically. Engineers who wrote every line of code now increasingly orchestrate long-running systems of agents that handle implementation details, focusing human time on architecture and strategy[^anthropic-coding-trends]. More time on orchestration, review, and system design. Less on routine implementation. This is not a loss of engineering skill: it is a reallocation toward higher-judgment work. The same pattern is extending beyond engineering: sales, legal, marketing, and operations teams are using agents to solve local process problems without waiting on engineering queues. Zapier reports 89% AI adoption across their organization with 800+ agents deployed internally[^zapier-adoption]. And 27% of AI-assisted work consists of tasks that would not have been done at all without agents: new work enabled by the collaboration, not old work automated[^anthropic-coding-trends].

What the lifecycle looks like in practice:

**Onboarding**: an agent entering production gets a defined role, scoped permissions, a designated owner, and an initial autonomy level. This maps to the agent registry described in [Shadow Agent Governance](shadow-agent-governance.md): identity, owner, authority, permissions, blast radius classification, evaluation requirements[^shadow-chapter].

**Performance management**: ongoing evaluation against both capability metrics (Potential) and governance metrics (Accountability). Not just "does the agent complete tasks correctly?" but "does the agent stay within its authorized scope? Does it escalate appropriately? Does it maintain audit trail integrity?" Autonomy levels adjust based on performance against both dimensions.

**Escalation chains**: defined paths from agent to human for different types of decisions. Not a single "ask a human" fallback but differentiated escalation: technical questions go to the engineering team, policy questions to compliance, customer-facing decisions to the service team. The agent needs to know not just when to escalate but to whom.

**Offboarding**: when an agent is deprecated, its credentials are revoked, its outstanding authorizations are cancelled, its audit trails are archived, and its delegated authorities are reclaimed. This is the lifecycle management that most organizations lack for their human-to-agent delegation chains.

Deloitte reports that only 14% of organizations have deployable agentic solutions and just 11% are using them in production[^deloitte-silicon]. But the organizations that are succeeding share a common trait: they redesigned processes around human-agent collaboration rather than automating existing processes. "If you just take your existing workflow and try to apply advanced AI to it, you're going to weaponize inefficiency."

The competitive advantage is not having access to better models but having the infrastructure to deploy them effectively[^inferential-edge].

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

Most organizations are at I1 or I2 for human-agent collaboration. The EU AI Act's high-risk obligations (originally August 2026, potentially December 2027 under the Digital Omnibus proposal) require I3 for high-risk systems. Organizations building agent-first workflows should target I4, where the autonomy dial, permission granularity, and agent self-governance patterns become fully operational.

## What to Do

**Start with the autonomy dial, not the agent.** Map your agent's tasks, not just its identity. For each task type, determine the blast radius and set the autonomy level accordingly. A single agent will likely operate at different autonomy levels for different tasks. Document these mappings. Review them quarterly.

**Design interfaces for batch review, not real-time approval.** If your oversight model requires a human to approve each action, your oversight model will fail. Design for exception-based review: the human sees summaries, outliers, and flagged anomalies. Individual action review is reserved for escalations and audits.

**Treat agent uncertainty as a governance signal.** Monitor how often your agents escalate. Track whether escalation frequency correlates with error rates. If an agent stops escalating on a task type, investigate: it may have improved, or it may have become miscalibrated. Build dashboards that surface escalation patterns alongside accuracy metrics.

**Match permission granularity to blast radius.** B4-B5 actions get per-tool-call authorization. B2-B3 actions get per-task authorization. B1 actions get per-session authorization with containment infrastructure. Do not default to coarse permissions because they are easier to implement: the authorization surface is your last line of defense.

**Onboard agents like employees.** Defined role, scoped permissions, designated owner, documented escalation paths, initial autonomy level, evaluation criteria, and offboarding plan. If you cannot answer "who is responsible for this agent?" the agent should not be in production.

**Invest in the interface, not just the model.** A well-designed collaboration interface with a capable model will outperform a frontier model with a poor interface. The interface determines whether governance is effective or performative. Explainable rationale, scope indicators, undo capability, and escalation pathways are not UX polish: they are governance infrastructure[^smashing-patterns]. The protocol layer for building these interfaces is maturing: AG-UI standardizes how agent backends stream events (tool calls, state changes, lifecycle signals) to frontends, and A2UI enables agents to generate interactive UIs natively across platforms. Both are covered in the [Agent Communication Protocols](agent-communication.md) chapter.

[^complacency-chapter]: See [Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md) for the full treatment of automation complacency research from Bainbridge (1983) and Don Norman (1990).

[^anthropic-autonomy]: Anthropic, ["Measuring AI Agent Autonomy in Practice"](https://www.anthropic.com/research/measuring-agent-autonomy) (February 2026). Also covered in Shane Deconinck, ["Early Indicators of Agent Use Cases: What Anthropic's Data Shows"](https://shanedeconinck.be/posts/early-indicators-agent-use-cases-anthropic-data/) (February 2026).

[^hotl-evolution]: The evolution from HITL to HOTL is discussed in multiple sources including ByteBridge, ["From Human-in-the-Loop to Human-on-the-Loop: Evolving AI Agent Autonomy"](https://bytebridge.medium.com/from-human-in-the-loop-to-human-on-the-loop-evolving-ai-agent-autonomy-c0ae62c3bf91) (January 2026).

[^pac-framework]: Shane Deconinck, [PAC Framework](https://trustedagentic.ai/framework/) (2026).

[^smashing-patterns]: Smashing Magazine, ["Designing For Agentic AI: Practical UX Patterns For Control, Consent, And Accountability"](https://www.smashingmagazine.com/2026/02/designing-agentic-ai-practical-ux-patterns/) (February 2026). A comprehensive taxonomy of UX patterns for agentic systems.

[^ux-magazine]: UX Magazine, ["Secrets of Agentic UX: Emerging Design Patterns for Human Interaction with AI Agents"](https://uxmag.com/articles/secrets-of-agentic-ux-emerging-design-patterns-for-human-interaction-with-ai-agents) (2026).

[^identity-chapter]: See [Agent Identity and Delegation](agent-identity.md) for the full treatment of Verifiable Intent's three-layer SD-JWT architecture and the confused deputy problem.

[^authz-platforms]: Authorization platforms for AI agents are maturing. See [Permit.io](https://www.permit.io/), [Cerbos](https://www.cerbos.dev/), [Stytch](https://stytch.com/blog/handling-ai-agent-permissions/), and [WorkOS](https://workos.com/) for current approaches to fine-grained, context-aware permission models designed for AI agents.

[^deloitte-silicon]: Deloitte, ["The agentic reality check: Preparing for a silicon-based workforce"](https://www.deloitte.com/us/en/insights/topics/technology-management/tech-trends/2026/agentic-ai-strategy.html), Tech Trends 2026.

[^shadow-chapter]: See [Shadow Agent Governance](shadow-agent-governance.md) for the agent registry model and amnesty-based transition approach.

[^anthropic-coding-trends]: Anthropic, ["2026 Agentic Coding Trends Report: How coding agents are reshaping software engineering"](https://resources.anthropic.com/2026-agentic-coding-trends-report) (March 2026). Eight trends across three categories: foundation trends (role shifts, multi-agent coordination), capability trends (expanding task horizons, cross-domain agents), and impact trends (organizational adoption, security architecture).

[^zapier-adoption]: Anthropic, ["Zapier builds an AI-first remote culture with Claude for Enterprise"](https://claude.com/customers/zapier) (2026). 89% company-wide AI adoption, 800+ agents deployed internally, 10x year-over-year growth in Anthropic app usage.

[^inferential-edge]: Shane Deconinck, ["When Intelligence Becomes Commodity, Infrastructure Becomes the Edge"](https://shanedeconinck.be/posts/when-intelligence-becomes-commodity/) (March 2026).

[^controllability-trap]: "The Controllability Trap: A Governance Framework for Military AI Agents," ICLR 2026 Workshop on Agents in the Wild, [arXiv:2603.03515](https://arxiv.org/abs/2603.03515) (March 2026). Identifies six agentic governance failures (Interpretive Divergence, Correction Absorption, Belief Resistance, Commitment Irreversibility, State Divergence, Cascade Severance) and proposes the Agentic Military AI Governance Framework (AMAGF) with a continuous Control Quality Score.

[^cascade-severance]: Yuxin Huang et al., ["On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents"](https://arxiv.org/abs/2408.00989), ICML 2025. Also cited in [Multi-Agent Trust and Orchestration](multi-agent-trust.md).

[^okta-series]: Okta, "AI Agent Security Series: Rebuilding IAM for Autonomous Trust," okta.com/blog/ai, 2026. Seven-part series mapping identity failures in agentic AI. Part 6 ("AI Agent Security: The Authorization Gap in Shared Workspaces") identifies the permission intersection gap. Part 7 ("Identity and Authorization: The Operating System for AI Security") maps six failure modes including four CVSS 9.3+ vulnerabilities exploiting the retrieval-vs-audience authorization gap across Anthropic MCP, Microsoft Copilot, ServiceNow Now Assist, and Salesforce.

[^anthropic-work]: Anthropic, ["How AI Is Transforming Work at Anthropic"](https://www.anthropic.com/research/how-ai-is-transforming-work-at-anthropic) (December 2025). Internal study: 132 engineers surveyed, 53 in-depth interviews, 200,000 Claude Code transcripts analyzed from February-August 2025. Task complexity increased from 3.2 to 3.8 (five-point scale), human turns decreased 33% (6.2 to 4.1), consecutive autonomous tool calls increased 116%. Engineers reported skill erosion concerns alongside productivity gains.
