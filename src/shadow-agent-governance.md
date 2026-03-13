# Shadow Agent Governance

Ninety-eight percent of organizations report unsanctioned AI use.[^vectra-shadow] The average enterprise has an estimated 1,200 unofficial AI applications in use, with 86% reporting no visibility into their AI data flows.[^helpnet-agent-security] Only 21% of executives have complete visibility into agent permissions, tool usage, or data access patterns.[^helpnet-agent-security]

These are not projections. This is what is happening right now, in organizations that consider themselves well-governed.

Shadow agents are the new shadow IT, but the analogy undersells the problem. When an employee installed Dropbox without IT approval in 2012, the risk was data in the wrong place. When an employee builds an agent on a low-code platform in 2026, the risk is an autonomous system making decisions, accessing data, and acting on behalf of the organization without anyone knowing it exists.

Shane put it simply in his boardroom questions: "An HR screening agent built without a compliance assessment makes you non-compliant without knowing the system exists."[^boardroom] The liability sits with the company regardless of whether anyone approved the deployment.

This chapter is about the transition: how organizations move from "agents are already running and nobody knows" to "every agent is registered, scoped, and auditable." Not by prohibition, which does not work, but by building infrastructure that makes governed agents easier to deploy than ungoverned ones.

## Why Shadow Agents Exist

Shadow agents do not emerge from malice. They emerge from the gap between what people need to get done and what the organization's approved tools can do.

Gartner predicts 40% of enterprise applications will feature task-specific AI agents by end of 2026, up from under 5% in 2025.[^gartner-40pct] That is an eight-fold increase in one year. IT governance processes designed for quarterly vendor reviews cannot absorb that velocity. The result: 68% of employees use unauthorized AI tools at work, up from 41% in 2023.[^gartner-shadow-stats]

Microsoft's Cyber Pulse report (February 2026) found that 80% of Fortune 500 companies have active AI agents built with low-code/no-code tools, and 29% of employees have turned to unsanctioned agents for work tasks.[^ms-cyber-pulse] The gap between "the organization deploys agents" and "the organization governs agents" is where shadow agents live.

Shane's framing of this dynamic is precise: "The potential of agents is that they make decisions. The risk originates from the same."[^boardroom] The same capability that makes agents valuable (they decide what to do given a goal) is what makes ungoverned agents dangerous. An employee builds a shadow agent because it solves a real problem. The agent works. Nobody complains. The risk accumulates invisibly until it does not.

### The value-seeking pattern

Shadow agent adoption follows a predictable pattern:

1. **An employee hits a bottleneck.** A manual process takes hours. Approvals are slow. Information is scattered across systems.
2. **They discover a tool.** A low-code platform, a ChatGPT custom GPT, a Copilot Studio agent, a Salesforce Agentforce configuration. Building an agent takes minutes, not months.
3. **The agent works.** It handles the task faster than the manual process. The employee shares it with their team.
4. **The agent spreads.** Other teams adopt it. It gets connected to more data sources. Its scope expands beyond the original use case.
5. **The agent becomes infrastructure.** People depend on it. Nobody remembers who built it. Nobody knows what permissions it has.

This pattern is not new. It is exactly what happened with spreadsheets, with SaaS tools, with cloud services. What is new is the blast radius. A spreadsheet with bad formulas produces wrong numbers. A shadow agent with broad OAuth tokens produces wrong actions, at machine speed, with the organization's authority.

## Why Shadow Agents Are Different from Shadow IT

Traditional shadow IT introduced unauthorized tools. Shadow agents introduce unauthorized actors. The distinction matters for governance.

A SaaS tool that an employee signs up for without IT approval has a fixed capability set. It does what the vendor built it to do. A shadow agent has an open-ended capability set: it reasons, plans, and acts based on the goal it is given and the tools it can access. Shane's example of an office assistant told to "handle my inbox" illustrates this: it might draft an email (minimal risk), then screen a job application (high-risk under the EU AI Act).[^boardroom] The risk tier depends on the prompt, not the tool.

Three properties make shadow agents fundamentally different:

**They make decisions.** Traditional shadow IT processes data. Shadow agents interpret goals, choose actions, and execute them. A shadow agent connected to a CRM does not just read customer records: it decides which customers to contact, what to say, and when to follow up.

**They inherit authority.** When an employee connects a shadow agent to their Google Workspace or Microsoft 365 account, the agent inherits their OAuth tokens. Shane's analysis of Google's Workspace CLI makes this concrete: the user thinks "help me find one email," but the token grants "read everything forever."[^google-workspace] The agent operates with the employee's full permissions, not the narrow authority the task requires.

**They compound.** Shadow agents do not stay contained. They get shared, extended, connected to additional data sources, and integrated with other agents. Microsoft found that leading industries using agents span software (16%), manufacturing (13%), financial institutions (11%), and retail (9%).[^ms-cyber-pulse] Each connection expands the blast radius without expanding the governance.

### The numbers behind the risk

The financial exposure is concrete. Shadow AI breaches cost an average of $670,000 more than standard security incidents, driven by delayed detection and difficulty determining the scope of exposure.[^gartner-shadow-stats] Gartner predicts that by 2030, more than 40% of enterprises will experience security or compliance incidents linked to unauthorized shadow AI.[^gartner-40pct-breach] The average enterprise experiences 223 data policy violations per month related to AI usage.[^netskope] Sixty-three percent of employees who used AI tools pasted sensitive company data, including source code and customer records, into personal chatbot accounts.[^ms-cyber-pulse-data]

Gravitee's 2026 State of AI Agent Security report quantifies how deep the monitoring gap runs. In a survey of 919 executives and practitioners, on average only 47.1% of an organization's AI agents are actively monitored or secured. More than half operate without any security oversight or logging. Only 14.4% of organizations have achieved full IT and security approval for their entire agent fleet. And 88% of organizations reported confirmed or suspected AI agent security incidents in the past year, rising to 92.7% in healthcare.[^gravitee]

The identity gap is equally stark. Only 21.9% of teams treat AI agents as independent, identity-bearing entities.[^gravitee] The rest manage agents through inherited user credentials, shared service accounts, or no identity management at all. This is the architectural mismatch Shane's trust inversion describes: agents operating as autonomous actors through identity infrastructure designed for humans. The confidence gap compounds it: 82% of executives feel confident their policies protect against unauthorized agent actions, but that confidence rests on high-level policy documentation, not real-time enforcement at the API or identity layer.[^gravitee]

These statistics describe a governance vacuum: agents operating with real permissions, accessing real data, making real decisions, with no registration, no audit trail, and no accountability chain.

### When shadow agents trigger government action

The OpenClaw crisis made this governance vacuum visible at national scale. In March 2026, Chinese government agencies and state-owned enterprises, including the country's largest banks, received official notices warning staff against installing OpenClaw on office devices.[^china-openclaw] China's CERT characterized the platform as having "extremely weak default security configuration."[^china-cert] The response was reactive: some agencies banned installation outright, others required prior approval, several instructed employees to notify superiors if they had already installed it so devices could be checked and the software removed. This is the shadow agent pattern in its purest form: employees had already adopted OpenClaw because it solved real problems, and the government discovered the exposure after the fact.

The contradiction in Beijing's response reveals the governance dilemma. At the same time that central agencies were banning OpenClaw on government networks, local governments in Shenzhen and Wuxi were subsidizing companies building on top of it.[^china-contradiction] The same technology was simultaneously a security threat (when unmanaged) and an economic priority (when directed). This is not hypocrisy. It is the central tension of shadow agent governance: prohibition does not work because the tools are genuinely useful. The answer is infrastructure that makes governed use possible, not blanket bans that drive adoption underground.

These were the first major government warnings specifically targeting an AI agent platform, distinct from broader AI regulation. They signal that shadow agent governance is no longer a theoretical concern. Governments are now encountering the same discovery problem that enterprises face: agents are already running, nobody authorized them, and the security posture is unknown.

[^china-openclaw]: Bloomberg, "China Moves to Limit Use of OpenClaw AI at Banks, Government Agencies," March 11, 2026.

[^china-cert]: The Register, "China's CERT warns OpenClaw can inflict nasty wounds," March 12, 2026. CERT characterized OpenClaw's default security configuration as "extremely weak."

[^china-contradiction]: Fast Company, "China went crazy for OpenClaw. Now it's working to ban it," March 2026. Documents the simultaneous central ban and local government subsidies for OpenClaw-based development.

## The Governance Gap

The core problem is structural. Organizations have invested decades in identity and access management for humans and applications. Neither model works for agents.

**Human IAM assumes judgment.** As Shane argues in his trust inversion post: "Organizations and their technology are designed to minimize constraints on people. We don't list everything an employee shouldn't do. We give them a role, adequate boundaries, and rely on them to use judgment within those."[^trust-inversion] Agents cannot exercise judgment in the way humans do. They fail unpredictably, and they do not know when they are wrong.

**Application IAM assumes fixed behavior.** Traditional service accounts have fixed scopes: a payroll application accesses payroll data, a CRM accesses customer data. Agents are general-purpose. The same agent framework can be pointed at any task, any data source, any API. OAuth scopes designed for applications (read email, manage calendar) are too coarse for agents that need task-specific, time-bounded access.

**Neither model assumes autonomous decision-making.** Both human and application IAM assume that the entity follows instructions. Agents create intent. They decide what to do given a goal. This is the trust inversion: "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task."[^trust-inversion]

The scale of this mismatch is quantifiable. ConductorOne's 2026 Future of Identity Report found that 95% of enterprises now run AI agents that autonomously perform IT or security tasks, and 47% of organizations report more non-human identities than human users, yet only 22% have full visibility into those identities.[^conductorone] Eighty percent experienced at least one identity-related breach in the past year. Eighty-seven percent rate non-human identity risk as moderately to extremely urgent. And 91% increased IAM spending in response, signaling that identity security is becoming a foundational control as autonomous systems expand.[^conductorone]

The governance gap is not a tooling gap. It is an architectural mismatch. Organizations cannot govern shadow agents by extending the models designed for humans and applications. They need new infrastructure designed for actors that operate autonomously, inherit authority through delegation, and cross system boundaries at machine speed.

## Discovery: Seeing What Exists

You cannot govern what you cannot see. The first step in shadow agent governance is discovery: building a complete inventory of every agent operating in the organization, sanctioned or not.

### How discovery works today

Several approaches to agent discovery have emerged:

**OAuth consent event monitoring.** Okta's ISPM Agent Discovery (February 2026) uses browser plugins and OAuth consent events to identify AI agents.[^okta-ispm] When an employee authorizes an AI tool to access their data, the OAuth consent prompt creates a detectable event. ISPM maps the relationship between the AI tool and the data sources it can access, revealing the specific permissions granted. Between February and May 2026, Okta plans to extend discovery to Microsoft Copilot Studio and Salesforce Agentforce as primary detection targets.[^okta-ispm]

**Network and API traffic analysis.** Agents communicate with external services via APIs. Monitoring outbound API calls, MCP server connections, and A2A protocol traffic reveals agent activity that OAuth monitoring alone would miss. This approach catches agents that bypass OAuth entirely by using API keys or direct integrations.

**Agentic risk mapping.** Noma Security's Agentic Risk Map (2026) automatically discovers every MCP server, toolset, API connection, and agent-to-agent relationship in an enterprise.[^noma-risk-map] The platform builds visual maps of the entire agentic ecosystem, identifies shadow deployments, and monitors runtime behavior against established baselines.

**Low-code platform auditing.** Since 80% of Fortune 500 agents are built on low-code/no-code platforms,[^ms-cyber-pulse] auditing these platforms directly (Microsoft Copilot Studio, Salesforce Agentforce, ServiceNow Agent Orchestration) reveals agent deployments that network monitoring might miss.

### Discovery is necessary but not sufficient

Shane's boardroom question cuts deeper than discovery: "Can your infrastructure prevent an agent from running without being registered? Knowing what's running today is one thing. Making it structurally impossible to deploy an unregistered agent is another. If anyone can spin one up without it showing up in a registry, visibility is a snapshot, not a guarantee."[^boardroom]

Discovery tools show you the current state. They do not prevent new shadow agents from appearing tomorrow. The gap between "we scanned and found everything" and "nothing can run without registration" is the difference between monitoring and governance.

This is why discovery must be the first step, not the only step. It provides the baseline: what exists, what permissions it has, what data it accesses, who deployed it. But the goal is infrastructure that makes unregistered agents structurally impossible.

## The Agent Registry

A centralized agent registry is the foundation of governed agent deployment. Every agent operating in the organization, whether built internally, deployed from a vendor, or created by an employee, must be registered before it can access organizational resources.

### What a registry contains

For each registered agent:

- **Identity**: who or what is this agent? A unique identifier, the platform it runs on, and its relationship to other agents in the organization.
- **Owner**: who deployed it, who maintains it, and who is accountable when it acts.
- **Authority**: what delegated it the right to act? The human or system that authorized its deployment, and the scope of that authorization.
- **Permissions**: what can it access? Specific data sources, APIs, tools, and the granularity of access (read/write/execute, per-resource, time-bounded).
- **Blast radius**: what is the worst-case impact of failure? This determines the governance threshold and required infrastructure level per the PAC Framework.
- **Evaluation status**: has the agent been evaluated for its intended use case? What reliability metrics exist, and what is the error margin?
- **Regulatory classification**: does this agent touch high-risk use cases under the EU AI Act, NIST guidelines, or other applicable regulation?

### Registry enforcement

A registry that depends on voluntary compliance is not a registry. It is a wish list.

Enforcement requires integration with the infrastructure layers the agent depends on:

**Identity providers.** Agent credentials should only be issuable through the registry. If an agent cannot obtain OAuth tokens, API keys, or service credentials without being registered, unregistered agents cannot authenticate to organizational resources.

**API gateways and agent gateways.** As discussed in the [Agent Communication Protocols](agent-communication.md) chapter, agent gateways (like AgentGateway with Cedar policies) can enforce that only registered agents with valid credentials can invoke tools and access resources. Every MCP server connection, every A2A task request, and every API call passes through infrastructure that checks registration status.

**Network controls.** Agents that cannot reach external services without passing through a governed proxy cannot exfiltrate data or connect to unauthorized APIs. This is the network isolation dimension from the [Sandboxing and Execution Security](execution-security.md) chapter applied at the organizational level.

**Platform controls.** Low-code platforms that support agent building (Copilot Studio, Agentforce, etc.) should be configured to require registration as a deployment prerequisite. If the platform cannot enforce this natively, the gateway layer provides the enforcement point.

### Vendor implementations are arriving

Microsoft Agent 365 (generally available May 1, 2026) is the first major vendor to ship a purpose-built agent registry and governance platform. Each agent gets its own Microsoft Entra Agent ID with lifecycle management: creation, rotation, and decommissioning governed by the same entitlement management processes used for human identities. The platform includes a centralized catalog of both sanctioned and shadow agents, bridging discovery and enforcement in a single product.[^agent-365] At $15 per user per month standalone (or bundled in Microsoft 365 E7 at $99), Microsoft is pricing agent governance as a platform feature, not an enterprise add-on.

This is significant because it validates the architectural direction described above: the identity provider is the natural enforcement point for agent registration. An agent that cannot get an Entra Agent ID cannot authenticate to Microsoft 365 resources. The registry is not advisory. It is the prerequisite for identity, and identity is the prerequisite for access.

The limitation is scope: Agent 365 governs agents within the Microsoft ecosystem. Agents that span multiple cloud providers, use non-Microsoft identity infrastructure, or operate across organizational boundaries need the cross-organizational trust infrastructure described in [Cross-Organization Trust](cross-org-trust.md). But for the 80% of Fortune 500 organizations already running agents on Microsoft platforms,[^ms-cyber-pulse] this is a significant step from I1 to I3.

The market is rapidly crystallizing beyond Microsoft. At RSAC 2026's Innovation Sandbox (March 23), two of ten finalists are purpose-built for agent governance: Token Security provides continuous discovery, lifecycle governance, and intent-based access controls specifically for AI agents that "think, learn, and act autonomously," and Geordie AI offers a security and governance platform that gives enterprises real-time visibility into their agentic footprint with posture and behavior monitoring.[^rsac-sandbox] That agent identity and governance attracted two Innovation Sandbox finalists in the same year signals that the market has moved from "interesting problem" to "fundable product category."

The funding signals reinforce the market thesis. Onyx Security emerged from stealth on March 12, 2026, with $40 million to build what it calls the "Secure AI Control Plane": continuous agent discovery, reasoning-step monitoring, and real-time policy enforcement.[^onyx] Combined with Kai's $125 million round the day before,[^kai-funding-ref] $165 million flowed into agent governance infrastructure in 48 hours. Venture capital is pricing agent trust as a category.

Sector-specific implementations are emerging alongside platform-wide solutions. Imprivata launched Agentic Identity Management at HIMSS 2026 (March 10), purpose-built for healthcare environments where AI agents must access EHRs, clinical systems, and legacy infrastructure while maintaining strict compliance requirements.[^imprivata] The platform treats AI agents as managed identities within the organization's security framework: agents never store static credentials, instead receiving short-lived tokens brokered by Imprivata with continuous identity verification and least-privilege enforcement. This is significant because healthcare is the sector where the gap between agent capability and governance infrastructure is widest: clinical AI agents need access to the most sensitive data categories (PHI, PII) while operating under the strictest regulatory constraints (HIPAA, state privacy laws).

The goal is Shane's architectural principle: "Policy says 'don't.' Architecture says 'can't.'"[^boardroom] An unregistered agent should not be prohibited by policy. It should be unable to function because the infrastructure it depends on requires registration.

## The Transition: From Shadow to Governed

Discovery reveals the shadow agents. The registry defines the target state. The transition is the hard part: moving from one to the other without killing productivity.

### Why prohibition fails

The instinct to ban shadow agents is understandable and counterproductive. Organizations that respond to shadow agent discovery with blanket prohibitions consistently find that employees route around the ban. They use personal devices, personal accounts, and external services that the organization cannot monitor at all. The shadow gets deeper, not shallower.

Shane's framing in "The Work That's Leaving" explains why: "The work that was only human because nothing else could do it" is being automated.[^work-leaving] Employees building shadow agents are responding to real productivity pressure. If the organization does not provide a governed path to agent-assisted work, employees will find an ungoverned one.

### The amnesty model

The most effective transition follows an amnesty pattern:

1. **Discover and inventory.** Use the discovery tools described above to build a complete picture of shadow agents in the organization.

2. **Classify by risk.** Not all shadow agents are equally dangerous. An agent that summarizes meeting notes from a single user's calendar is a different risk category from an agent that screens job applications across the entire HR system. Use the PAC Framework's blast radius scale (B1-B5) and infrastructure requirements (I1-I5) to classify each discovered agent.

3. **Amnesty period.** Give agent creators a defined window (30-90 days) to register their agents. During this period, provide clear guidance: what information is needed, how to assess blast radius, what permissions adjustments are required. Make registration easy. If it takes longer to register an agent than to build one, registration will not happen.

4. **Triage registered agents.** For each registered agent, determine the governance path:
   - **B1-B2 (Contained/Recoverable)**: fast-track approval with standard permissions scoping and basic audit logging.
   - **B3 (Exposed)**: require evaluation metrics, structured audit trails, and monitoring.
   - **B4-B5 (Regulated/Irreversible)**: full compliance assessment, identity verification, scoped authorization, sandboxing, and anomaly detection.

5. **Enforce after amnesty.** After the amnesty period, enable registry enforcement through the infrastructure controls described above. Unregistered agents lose access to organizational resources.

6. **Maintain the path.** Keep the registration process frictionless. If employees need agents, they should be able to deploy governed agents faster than they could build shadow ones. The governed path should be the path of least resistance.

### What makes this work

The amnesty model works because it respects the value that drove shadow agent creation while establishing the governance infrastructure the organization needs. It treats shadow agent creators as early adopters, not policy violators. It channels their energy into the governed system rather than fighting it.

This connects directly to the PAC Framework's Potential pillar. Shane asks: "How much value are you leaving on the table by over-constraining? Agents that need human approval for every action aren't agents: they're suggestion engines."[^boardroom] The governance system must enable agent autonomy within safe boundaries, not prevent it.

## Who Owns Agent Governance?

The PAC Framework's Accountability pillar asks: "Who owns AI governance? If no one owns it, everyone assumes someone else does."

Shadow agents thrive in organizational gaps. When IT, security, compliance, and business units each assume someone else is handling agent governance, nobody is.

### The ownership problem

Microsoft's Cyber Pulse report identifies the challenge: organizations are deploying agents faster than they can establish controls.[^ms-cyber-pulse] The speed of agent creation (minutes on a low-code platform) vastly exceeds the speed of governance review (weeks for a typical vendor assessment). This asymmetry guarantees shadow agents unless governance is redesigned for agent-speed deployment.

Three organizational models have emerged:

**Centralized AI governance office.** A dedicated team owns agent registration, risk classification, and compliance review for all agents across the organization. This provides consistency but creates a bottleneck. Works for organizations with fewer than 50 agents. Breaks down at scale.

**Federated governance with central standards.** Business units own their agents and their risk assessments. A central team sets the standards, provides the tooling, and audits compliance. Registration is self-service with automated classification. Risk tiers determine whether central review is required. This scales better but requires mature teams.

**Infrastructure-enforced governance.** The governance is in the infrastructure, not in the org chart. Agent gateways enforce permissions. The registry enforces registration. Audit logging enforces traceability. Anomaly detection enforces behavioral boundaries. Humans set the policies; infrastructure enforces them. This is Shane's vision: "Are your agents contained by architecture, or only by policy?"[^boardroom]

The third model is the target state. The first two are transition steps toward it.

Gartner forecasts that AI governance spending will reach $492 million in 2026 and surpass $1 billion by 2030.[^gartner-governance-spend] This investment reflects the urgency, but money alone does not solve the problem. Infrastructure does.

## Audit Trails for Accountability

Shane's boardroom question is direct: "When an agent makes a consequential decision, can you trace who authorized it and what happened?"[^boardroom] For shadow agents, the answer is definitively no. For governed agents, it must be yes.

The audit trail requirements for agents differ from both human and application audit trails:

**Delegation chain.** Who authorized this agent to act? The human who delegated, the system that issued credentials, and every intermediate delegation. As the [Agent Identity and Delegation](agent-identity.md) chapter discusses, audit logs that show "alice@company.com" are insufficient when Alice delegated to an agent three months ago.

**Intent capture.** What was the agent asked to do? Not just the final action, but the goal that triggered the action chain. This connects to the Verifiable Intent architecture from the Cross-Organization Trust chapter: if the user's intent is cryptographically captured at delegation time, the audit trail can prove what was authorized versus what was executed.

**Action trace.** What did the agent actually do? Every tool call, every data access, every decision point. The Reliability chapter's discussion of observability applies here: governance-grade audit trails need structured, queryable records, not debug logs.

**Scope verification.** Did the agent stay within its authorized scope? This requires comparing the agent's actions against its registered permissions. Infrastructure-level enforcement (agent gateways, sandboxing) can prevent scope violations in real time; audit trails provide the post-hoc verification.

The PAC Framework's infrastructure maturity levels define what audit infrastructure is required at each autonomy level. At I2 (Logged), basic activity records exist. At I3 (Verified), structured audit trails with identity verification exist. At I4 (Authorized), delegation chains and scope enforcement are auditable. At I5 (Contained), the complete chain from human intent through agent action to outcome is cryptographically verifiable.

## The Organizational Shift

Shadow agent governance is not a security project. It is an organizational transformation.

Shane's "The Work That's Leaving" makes the strategic case: "The companies that start their agentic transformation now get to redesign around it. The ones that wait will be explaining to their people why the work disappeared and there's no plan."[^work-leaving] Shadow agents are evidence that the transformation is already happening, ungoverned.

The shift has three dimensions:

**From prohibition to enablement.** The governance function moves from "stop unauthorized AI use" to "make authorized AI use easy." Every hour spent fighting shadow agents is an hour not spent building governed agent infrastructure. The organizations that capture the most value will be those that channel shadow agent energy into governed systems.

**From human-speed to agent-speed governance.** Traditional governance processes (vendor assessments, security reviews, compliance approvals) operate on human timescales: weeks to months. Agent deployment operates on minutes. Governance must be automated, infrastructure-enforced, and self-service for low-risk use cases. Human review should be reserved for B4-B5 blast radius deployments where the stakes justify the delay.

**From perimeter to identity.** Shadow agents cross organizational boundaries by default. They use external APIs, external model providers, and external data sources. Perimeter-based security cannot govern agents that operate outside the perimeter. The shift to identity-based governance (agent identity, delegation chains, scoped credentials) is not optional. It is the only model that works when agents cross trust boundaries, as the Cross-Organization Trust chapter discusses in depth.

## Mapping to PAC

Shadow agent governance touches all three pillars:

| PAC Dimension | Shadow Agent Governance Contribution |
|---|---|
| **Potential: Business Value** | Shadow agents prove where value exists. Discovery reveals which processes employees are automating, providing a map of the highest-value agent use cases. |
| **Potential: Durability** | The governed path (registry + infrastructure enforcement) is the durable investment. Shadow agents are fragile: they break when tokens expire, APIs change, or employees leave. |
| **Accountability: Shadow Agents** | This chapter directly addresses the dimension. The goal is zero: every agent registered, every delegation traceable. |
| **Accountability: Liability Chains** | Registration establishes ownership. Audit trails establish causation. Together they answer "who is responsible when this agent acts?" |
| **Accountability: Regulatory Landscape** | The EU AI Act requires documentation of AI systems. Shadow agents are undocumented by definition. The registry is the compliance artifact. |
| **Control: Infrastructure as Gate** | Registry enforcement through identity providers, gateways, and network controls makes governance structural, not advisory. |
| **Control: Agent Identity** | Registered agents get verified identities. Unregistered agents cannot authenticate. Identity is the enforcement mechanism. |
| **Control: Delegation Chains** | The registry captures who authorized each agent. Combined with infrastructure from the [Agent Identity and Delegation](agent-identity.md) chapter, delegation is traceable and revocable. |

## Infrastructure Maturity for Shadow Agent Governance

The PAC Framework's infrastructure levels (I1-I5) map to specific shadow agent governance capabilities:

| Level | Shadow Agent Governance Capability |
|---|---|
| **I1: Open** | No agent inventory. No registration requirement. Shadow agents operate freely. This is where most organizations are today. |
| **I2: Logged** | Discovery tools deployed. Agent inventory exists but is periodically updated, not continuously enforced. Basic audit logging for known agents. |
| **I3: Verified** | Agent registry operational. Registration required for access to organizational resources. Identity verification for agents. Structured audit trails. |
| **I4: Authorized** | Registry enforcement through infrastructure (identity providers, gateways, network controls). Delegation chains captured and auditable. Automated risk classification based on PAC dimensions. |
| **I5: Contained** | Unregistered agents structurally unable to operate. Full delegation chains from human intent through agent action. Anomaly detection for behavioral drift. Automated containment for scope violations. Cryptographic proof of authorization at every step. |

Most organizations are at I1-I2. The EU AI Act's August 2026 enforcement deadline and the NIST standards work both require I3+ for high-risk agent deployments. The gap between "where organizations are" and "where regulation requires them to be" is five months.

## Practical Recommendations

**If you are at I1 (no visibility):**
Deploy discovery tools now. Okta ISPM, Noma's Agentic Risk Map, or network-level API monitoring. The goal is a baseline inventory within 30 days. You cannot make governance decisions without knowing what exists.

**If you are at I2 (discovery done):**
Build the agent registry. Define registration requirements: identity, owner, permissions, blast radius, evaluation status. Start the amnesty process. Classify discovered agents by PAC blast radius. Fast-track B1-B2 agents through registration.

**If you are at I3 (registry operational):**
Enable infrastructure enforcement. Integrate the registry with identity providers so unregistered agents cannot obtain credentials. Deploy agent gateways that check registration status. Move from "registered agents are tracked" to "unregistered agents cannot function."

**If you are at I4 (infrastructure-enforced):**
Invest in the governance automation that makes I5 possible. Automated risk classification based on agent behavior, not just registration data. Delegation chain verification that catches privilege escalation. Anomaly detection that identifies when agents drift beyond their registered scope.

**Regardless of level:**
Make the governed path easier than the shadow path. If building a compliant agent takes weeks and building a shadow agent takes minutes, shadow agents will win every time. The highest-leverage investment is reducing friction in the governed deployment path.

---

[^vectra-shadow]: Vectra AI, "Shadow AI explained: risks, costs, and enterprise governance" (2026).
[^helpnet-agent-security]: Help Net Security, "AI went from assistant to autonomous actor and security never caught up" (March 3, 2026).
[^boardroom]: Shane Deconinck, "Agentic AI: Curated Questions for the Boardroom" (February 8, 2026).
[^gartner-40pct]: Gartner, "Gartner Predicts 40% of Enterprise Apps Will Feature Task-Specific AI Agents by 2026" (August 2025).
[^gartner-shadow-stats]: Gartner, research across 500 companies on shadow AI adoption and breach costs (2025-2026).
[^ms-cyber-pulse]: Microsoft Security Blog, "80% of Fortune 500 use active AI Agents: Observability, governance, and security shape the new frontier" (February 10, 2026).
[^google-workspace]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First." (March 5, 2026).
[^trust-inversion]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust" (February 3, 2026).
[^work-leaving]: Shane Deconinck, "The Work That's Leaving" (February 27, 2026).
[^okta-ispm]: Okta, "Okta secures the agentic enterprise with new tools for discovering and mitigating shadow AI risks" (February 12, 2026).
[^noma-risk-map]: Noma Security, "Agentic Risk Map" (2026).
[^gartner-40pct-breach]: Gartner, "40% of Firms to Be Hit By Shadow AI Security Incidents" by 2030 (November 2025).
[^netskope]: Netskope, AI data policy violation statistics (2026).
[^ms-cyber-pulse-data]: Microsoft, Cyber Pulse: An AI Security Report (2026).
[^gartner-governance-spend]: Gartner, AI governance spending forecast: $492M in 2026, surpassing $1B by 2030.
[^conductorone]: ConductorOne, "Future of Identity Report 2026," March 10, 2026. Survey of 508 IT and security leaders at U.S. organizations with 1,000+ employees.
[^agent-365]: Microsoft, "Microsoft Agent 365: The Control Plane for Agents," microsoft.com, March 9, 2026. Generally available May 1, 2026.
[^rsac-sandbox]: RSAC, "Finalists Announced for RSAC Innovation Sandbox Contest 2026," rsaconference.com, March 2026. Token Security and Geordie AI among ten finalists.
[^imprivata]: Imprivata, "Imprivata Introduces Agentic Identity Management to Secure and Govern AI Agents in Healthcare," imprivata.com, March 10, 2026. Announced at HIMSS 2026.
[^onyx]: Onyx Security, "Onyx Security Launches with $40M in Funding to Build the Secure AI Control Plane for the Agentic Era," businesswire.com, March 12, 2026. Backed by Conviction and Cyberstarts. 70+ employees, already engaged with Fortune 500 customers.
[^kai-funding-ref]: Kai, "Kai Emerges from Stealth with $125M," prnewswire.com, March 10, 2026.
[^gravitee]: Gravitee, "State of AI Agent Security 2026," gravitee.io, February 2026. Survey of 919 executives and practitioners across industries.
