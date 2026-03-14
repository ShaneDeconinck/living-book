# Context Infrastructure

The previous chapters covered identity: who the agent is and what authority it carries. This chapter addresses the other half of the equation: what the agent knows.

Shane's argument is that context is the durable competitive advantage in agentic AI. Models depreciate. Scaffolding depreciates. Access to a frontier model takes a credit card. But the information infrastructure that feeds those models appreciates with every upgrade.[^1]

This is not a claim about prompt engineering or RAG pipelines. It is an argument about organizational infrastructure: the structured, governed, discoverable knowledge that makes any agent, built on any model, more valuable. And it connects directly to the PAC Framework: context is where Potential meets Control.

## Everything Else Depreciates

Every wave of applied AI brought a layer of investment that the next wave made obsolete:[^1]

**Fine-tuning (2022-2023).** Organizations curated datasets, trained custom models, built specialized pipelines. Then general-purpose models got good enough to cover most tasks out of the box. The custom model you spent months training on a narrow task? The next general-purpose release made it redundant.

**RAG (2023-2024).** Instead of baking knowledge into the model, feed it at inference time through vector databases, embeddings, and retrieval pipelines. That worked, but it added its own layer of complexity, preprocessing, and drift. As models got better at reasoning over raw sources, that layer started thinning too.[^1]

**Scaffolding (2024-2025).** Most energy in agentic AI went to framework selection and orchestration: how to work around the model's limitations. Then the model improved, and the workarounds got deleted. The scaffolding you built was now fighting the model's new capabilities.[^2]

Shane captures this precisely: "Every line of scaffolding is a bet that you know better than the model. And models keep improving."[^2]

This pattern is not slowing down. Training depreciates. Code depreciates. Access to the most capable AI on the planet went from requiring a research lab to requiring a credit card. Your competitor has the same model you do, tomorrow.

### The Scaffolding Trap

Shane identified a specific failure mode: the scaffolding trap. When the model improves, scaffolding does not just become dead weight. It actively fights the model's new capabilities. The workaround you wrote for a limitation now prevents the model from using the better approach it learned.[^2]

Claude Code's history illustrates this concretely. Boris Cherny started it as a solo side project at Anthropic in September 2024, when Claude could barely generate bash commands. With each model upgrade, the team did not need to add more code: they could remove it. By late 2025, Cherny had not written a line of code manually in months.[^2]

The architecture that resulted is instructive: a single loop, a handful of basic tools, no multi-agent orchestration. Anthropic's engineering blog puts it simply: "do the simplest thing that works."[^3]

Manus, the AI agent that gained widespread attention in early 2026, learned the same lesson independently. Their team rebuilt the agent framework four times, each time after discovering a better way to shape context rather than adding more scaffolding. They describe the process as "Stochastic Graduate Descent": an experimental science of context optimization.[^4]

In the Potential pillar, durability is a key dimension: will what you build today still compound in a year, or become dead weight when the next model drops? Scaffolding fails the durability test. Context infrastructure passes it.

## What Context Means Here

Context is not just "the prompt." Shane defines it as two things working together: well-curated information and well-managed access to it. Supplying the right information at the right time, aligned with policy.[^1]

This distinction matters. The industry conversation about "context engineering" has exploded in 2026, with Anthropic, Manus, LangChain, and others all publishing frameworks for managing what goes into the context window.[^3][^4][^5] That work is valuable but focused on the runtime question: how do you select, compress, and structure tokens at inference time?

Shane's argument is broader. The runtime optimization matters, but the lasting investment is in what sits behind the runtime: the organizational knowledge that any context engineering pipeline draws from. If that knowledge is scattered, duplicated, stale, or ungoverned, no amount of clever context window management will fix the problem. An agent reasoning over bad information reasons confidently and incorrectly.

For decades, organizations have been fighting information silos, duplicate systems, inconsistent data. Expensive, but manageable when software was rigid and humans were the consumers. Now software becomes fluid. Agents can traverse, query, and act on anything they can reach. The mess gets amplified. An agent loose in poorly managed information does not just find the wrong answer. It acts on it. At machine speed.[^1]

But the inverse is also true. Well-structured, discoverable, properly governed information becomes exponentially more valuable when agents can consume it. The same cleanup you should have done for humans now pays compound interest through agents.

## Context in Practice: What Works

The most capable agents running today share a pattern: thin architecture, rich context.

### Claude Code: Files and Search

Claude Code uses no vector databases, no embeddings. Just raw files and search. Each team at Anthropic maintains a `CLAUDE.md` file checked into git. When the team sees the model make a mistake, they do not write code. They write a sentence in the context file.[^2]

This is context infrastructure in action: simple files, continuously curated, immediately valuable. Context is cheap to update and does not create maintenance burden. It degrades gracefully: if a model outgrows an instruction, the instruction just stops mattering. When you would normally write a linter rule or a validation check, they write a sentence.[^2]

Lance Martin expanded this into a comprehensive framework for context engineering, identifying four core operations: writing context (saving it outside the context window), selecting context (pulling it in), compressing context (retaining only the tokens required), and isolating context (splitting it across agents or turns).[^5]

### Manus: KV-Cache as North Star

Manus brought a production engineering lens to context management. Their key insight: the KV-cache hit rate is the single most important metric for a production-stage AI agent, directly affecting both latency and cost. Their agents have an average input-to-output token ratio of around 100:1, dramatically different from typical chatbot scenarios.[^4]

From this, they derived concrete principles:

**Do not dynamically add or remove tools.** Any change invalidates the KV-cache for all subsequent actions and observations. When previous actions reference tools that are no longer defined, the model gets confused, leading to schema violations or hallucinated actions.

**Break the rhythm.** If the context contains many similar action-observation pairs, the model falls into a pattern, repeating actions because that is what it sees, even when suboptimal.

**Use the file system as memory.** Stash raw data in files, keep only lightweight references (paths, URLs) in the prompt. Pull the full text later if needed. This treats the file system as the model's long-term memory.

**Keep errors in context.** Failed commands, error traces, and bad ideas stay in the log. These negative examples help the model learn and avoid repeating mistakes.

### Clawdbot: Context Without Control

The Clawdbot case is instructive in a different way. Its entire personality, goals, and operational rules lived in a text file: a `SOUL.md`. The architecture was: files, a powerful LLM, and an execution environment. And it worked so well that people started anthropomorphizing it. Nobody anthropomorphizes code. They anthropomorphize what emerges when rich context meets a capable model.[^1]

But what went wrong with Clawdbot was not the soul file or the model. It was the missing constraints. Context without proper access management is a liability. Rich context made Clawdbot compelling. Missing access controls made it dangerous.[^1]

Context and control are not separate concerns. They are the same infrastructure problem viewed from different angles.

## Five Dimensions of Context Infrastructure

Shane identifies five areas of investment:[^1]

### 1. Structure

Whether it lives in files, databases, or graphs: make it coherent. Consistent naming, clear relationships, machine-consumable. Information that makes sense to a human should make sense to an agent.

The principle is to model information after the domain, not after today's tool or framework. A customer relationship represented as an entity with attributes, not as rows in a CRM export. A policy captured as structured rules, not buried in a PDF. When information is modeled after what it actually represents, any tool, any agent, any future system can consume it.

The industry is learning this through experience. The evolution from basic RAG (chunk text, embed it, retrieve by similarity) to knowledge graph-augmented retrieval reflects a growing understanding that relationships between entities matter as much as the entities themselves. Vector similarity search finds passages that sound related. Structured knowledge finds passages that are related: following entity relationships, reasoning over constraints, respecting hierarchies.

For the PAC Framework, structure directly affects reliability. An agent reasoning over well-structured domain knowledge makes fewer errors than one reasoning over flat text chunks. Structure is a Potential investment that compounds.

### 2. Permissions

Fine-grained access on the information itself. Not "can the agent access the database" but "can this agent, acting for this user, see this specific piece of information for this task."

This is where context infrastructure meets the identity infrastructure from the previous chapter. OBO tokens scope who can act. But what they can see depends on the information layer. An agent with a valid delegation token but no information-level access controls will see everything the database exposes, regardless of whether the user intended it.

Shane's Google Workspace example applies here too: the user intends "help me find one email from last week," but if the information layer has no finer granularity than "all email," that is what the agent gets.

Permissions on context connect directly to the Control pillar: infrastructure-level enforcement (I4 and above) requires not just identity controls but information controls.

#### The convergence of identity and information governance

Gartner's Market Guide for Guardian Agents (February 2026) identifies a trend that maps directly to this intersection: the traditional separation between agent identity, credential, and access management (ICAM) and information governance is narrowing. Organizations that manage these as separate disciplines create a structural gap: the identity system says the agent is authorized, but the information system has no corresponding policy for what the agent should see. Or the information system restricts access, but the identity system issued a token broad enough to bypass those restrictions.[^gartner-convergence]

The practical implication: organizations building context infrastructure should not treat permissions as a separate layer bolted onto identity. The permission model for information should be native to the identity model for agents. When the identity system issues a scoped token, the information system should enforce corresponding data access policies automatically. When the information system flags a sensitive data interaction, the identity system should be able to revoke or restrict the agent's session. This bidirectional integration is what Gartner means by convergence, and it is what the PAC Framework requires at I4 and above.

Microsoft Agent 365 (generally available May 1, 2026) represents this pattern in production, integrating Entra (identity), Purview (data governance), and Defender (risk assessment) into a unified agent control plane where identity, information access, and behavioral risk are evaluated together rather than in separate silos.[^agent-365-convergence]

The limitation is scope. Agent 365 governs agents within the Microsoft ecosystem. Agents that span multiple cloud providers, use non-Microsoft identity infrastructure, or operate across organizational boundaries need the cross-environment governance that no single vendor provides today.[^entro-critique] This is the same cross-organizational trust problem the [Cross-Organization Trust](cross-org-trust.md) chapter addresses for identity, now extended to information governance. The agent that queries your Azure SQL database through one identity and your AWS S3 bucket through another has two sets of information policies that do not talk to each other. Solving this requires not just federated identity (which standards like TSP and EUDI address) but federated information governance: portable, verifiable policies that travel with the agent's context across trust boundaries.

### 3. Discovery

Agents need to find what they need. Two protocols are emerging as the standard discovery layer:

**MCP (Model Context Protocol)** handles tool and resource discovery for agents. Originally released by Anthropic in November 2024, MCP has evolved rapidly. By December 2025, Anthropic donated MCP to the Linux Foundation's Agentic AI Foundation. OpenAI adopted it across the Agents SDK, Responses API, and ChatGPT desktop. Google DeepMind confirmed support in Gemini models. The protocol now sees 98.6 million monthly SDK downloads across Python and TypeScript.[^7]

MCP's 2026 roadmap addresses the gaps that production use surfaced: stateful sessions that fight with load balancers, horizontal scaling that requires workarounds, and no standard way for a registry or crawler to learn what a server does without connecting to it. The planned solution includes evolving the transport model so servers can scale without holding state, and a standard metadata format served via `.well-known` for discoverable server capabilities.[^7]

**A2A (Agent-to-Agent Protocol)** handles agent-to-agent discovery and communication. Google's protocol reached v1.0 in early 2026 with JWS-based Agent Card signing (RFC 7515), OAuth 2.0 modernization (PKCE, removed deprecated flows), mutual TLS support, and SDKs across Python, Go, JavaScript, Java, and .NET. Over 150 organizations support A2A, including Atlassian, Salesforce, SAP, PayPal, Microsoft, Amazon, and ServiceNow. Auth0 is partnering with Google Cloud to define A2A authentication specifications.[^8]

The relationship between MCP and A2A maps to different context discovery needs. MCP is how an agent finds and uses tools and data sources. A2A is how agents find and communicate with each other. Together, they form the discovery infrastructure for context: what information exists, where it lives, and how to get it.

For the PAC Framework, discovery is a Potential dimension: agents cannot leverage information they cannot find. But it is also a Control dimension: discoverable information needs discoverable permissions.

### 4. Authority

Access scoped to the delegating user's authority. This connects directly to the delegation chains covered in the [Agent Identity and Delegation](agent-identity.md) chapter: OBO, DPoP, and the principle that authority must decrease through chains, never escalate.

For context infrastructure specifically, authority means the agent sees what the user is allowed to see, for this task. The PIC Protocol (Proof of Invocation Chain) extends this concept: authority travels with the request, and each hop in the chain reduces the scope of what is accessible.[^9]

The emerging agent gateway pattern sits at this intersection. Agent gateways, analogous to API gateways for microservices, provide a centralized control plane over agent identity, permissions, delegation, and behavior. Gartner predicts that 75% of API gateway vendors and 50% of iPaaS vendors will incorporate MCP capabilities by the end of 2026, positioning agent gateways as a missing layer for secure AI integration.[^10]

But agent gateways introduce new questions. How do they interact with service mesh architectures? Are they a separate layer or an extension of existing API infrastructure? These questions remain open, but the underlying requirement is settled: context delivery needs an enforcement layer between the agent and the information.

### 5. Freshness

Up to date, or at least versioned. Stale information fed to an agent is worse than no information: it acts on it with full confidence. Wrong context produces wrong decisions at machine speed.[^1]

This dimension is often underestimated. Organizations focus on getting information into the agent's context but not on keeping it current. A policy document updated last quarter that the agent treats as current. A customer record that was modified yesterday by another system. A price list that changed overnight.

Freshness is not just about updating data. It is about the agent knowing what it does not know: metadata that says "this was last verified on date X" or "this source may have changed since retrieval." Without freshness signals, the agent has no way to calibrate its confidence.

There is a related dimension that freshness alone does not cover: context integrity. Microsoft's discovery of AI Recommendation Poisoning showed that 31 legitimate companies across 14 industries were embedding hidden instructions in "Summarize with AI" buttons to bias AI assistant memory toward their products.[^rec-poison] This is not adversarial attack in the traditional sense: it is commercial manipulation of agent context at scale. The context the agent consumed was fresh and came through a normal interaction channel. It was simply designed to corrupt the agent's future decision-making for commercial advantage. Defending against this requires treating context provenance and integrity as governed properties, not just freshness. The [Agent Supply Chain Security](supply-chain-security.md) chapter covers this as part of the broader memory poisoning threat.

## The Compounding Effect

Context infrastructure compounds. When a better model arrives, an organization with mature context infrastructure captures more value instantly. Less code needed, more capability unlocked. Permission boundaries are already enforced. The upgrade is frictionless.[^1]

An organization without that infrastructure gets a more capable model running on the same mess. Same silos, same ungoverned data, same unclear authority chains. Faster, more autonomous, and with the wrong context or goals: more dangerous.

"When the next model drops, you're not rewriting orchestration. You're plugging it into infrastructure that's already there."[^1]

The agentic component model from Shane's earlier post maps the layers:[^11]

- **Framework** (what the agent is): model selection, context engineering, skills, tools, abstraction
- **Runtime** (how the agent runs): state and memory, control flow, human-in-the-loop
- **Harness** (where the agent lives): interface, IAM, evals

Context infrastructure sits primarily in the Framework layer but reaches into all three. The structured knowledge is Framework. The permissions enforcement is Harness (IAM). The freshness and state management is Runtime. This is why it compounds: it strengthens every layer simultaneously.

## Context Infrastructure and the PAC Framework

Each of the five dimensions maps to PAC:

| Dimension | Potential | Accountability | Control |
|---|---|---|---|
| Structure | Higher reliability from better-modeled information | Auditable reasoning over traceable sources | Structured permissions boundaries |
| Permissions | Enables higher-value use cases that require sensitive data | Proves what was accessed and why | Infrastructure-enforced access scoping |
| Discovery | Agents find and leverage more organizational knowledge | Discoverable audit trails | Discoverable permission requirements |
| Authority | Cross-organizational use cases become possible | Delegation chains create accountability | Authority decreases through chains |
| Freshness | Decisions based on current information | Versioned records for audit | Prevents action on stale authorizations |

The infrastructure maturity scale applies here as well:

**I1 (Open):** Agent has uncontrolled access to whatever information it can reach. No structure or permission requirements. This is the Clawdbot scenario.

**I2 (Logged):** Agent access to information is logged, but not scoped. You can see what the agent accessed after the fact, but you cannot prevent inappropriate access.

**I3 (Verified):** Information access is scoped to the agent's delegation. OBO tokens determine not just what services the agent calls but what information those services return. Structure is sufficient for agents to reason correctly.

**I4 (Authorized):** Fine-grained, purpose-scoped information access. Discovery protocols (MCP, A2A) are in place. Agent gateways enforce access at the infrastructure level.

**I5 (Contained):** Full context governance: structured, permissioned, discoverable, authority-scoped, and fresh. The agent operates in a complete information environment where it can access exactly what it needs and nothing more.

## What to Do Now

Context infrastructure is a long-term investment, but there are immediate steps:

**Audit your information landscape.** What do your agents actually access? Not what they are supposed to access, but what their credentials allow them to reach. The gap is usually larger than expected.

**Start with CLAUDE.md.** Seriously. The pattern of maintaining a living document of institutional knowledge, checked into version control, continuously curated, is the simplest form of context infrastructure. It works for any model, any framework, any future system.

**Model information after the domain.** Resist the temptation to structure data around today's tooling. CRM exports, PDF policy documents, and tool-specific formats lock knowledge into today's systems. Domain-modeled information survives tool changes.

**Invest in discovery.** MCP adoption is accelerating. If your organization exposes APIs or data sources that agents should consume, making them discoverable through standard protocols is a durable investment.

**Treat freshness as a feature.** Add timestamps, version numbers, and staleness signals to information that agents consume. An agent that knows "this was last verified three months ago" can make better decisions than one that treats everything as current.

The organizations that invest in context infrastructure now will not just be ready for today's agents. They will be ready for every generation that follows. Models keep getting more capable. The context infrastructure you build today benefits from every improvement that follows.[^1]

---

[^1]: Shane Deconinck, "AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment," February 9, 2026.
[^2]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," February 2, 2026.
[^3]: Anthropic Engineering Blog, "Effective context engineering for AI agents," September 29, 2025.
[^4]: Manus, "Context Engineering for AI Agents: Lessons from Building Manus," 2026.
[^5]: Lance Martin, "Context Engineering for Agents," rlancemartin.github.io, June 23, 2025.
[^7]: Model Context Protocol, "The 2026 MCP Roadmap," blog.modelcontextprotocol.io, 2026.
[^8]: Google Cloud Blog, "Agent2Agent protocol (A2A) is getting an upgrade," 2026.
[^9]: PIC Protocol, github.com/pic-protocol/pic-spec.
[^10]: Gartner, "Innovation Insight: MCP Gateways," gartner.com, 2026. Predicts 75% of API gateway vendors and 50% of iPaaS vendors will incorporate MCP capabilities by end of 2026. The "missing layer" framing appears in this Innovation Insight, not in the API Management research note.
[^rec-poison]: Microsoft Security Blog, "Manipulating AI memory for profit: The rise of AI Recommendation Poisoning," microsoft.com, February 10, 2026. over 50 unique prompts from 31 companies across 14 industries identified over 60 days.

[^11]: Shane Deconinck, "Fitting Agentic AI Components in a Mental Model," January 6, 2026.

[^gartner-convergence]: Gartner, "Market Guide for Guardian Agents," Avivah Litan and Daryl Plummer, February 25, 2026. The guide identifies the convergence of agent ICAM with information governance as a key trend, arguing that organizations managing these as integrated capabilities are better positioned to govern agents that simultaneously need identity, access control, and data governance.

[^agent-365-convergence]: Microsoft, "Secure agentic AI for your Frontier Transformation," Microsoft Security Blog, March 9, 2026. Microsoft, "Microsoft Agent 365: The Control Plane for Agents," microsoft.com, 2026. Agent 365 integrates Entra (identity), Purview (data governance), and Defender (security) into a unified agent control plane. Generally available May 1, 2026.

[^entro-critique]: Entro Security, "Microsoft Agent 365 Boosts AI Identity, Yet Governance Gaps Remain," entro.security, March 2026. Argues that Agent 365 governs Microsoft environments but leaves gaps for organizations using multiple cloud providers. See also Oasis Security, "Agent 365, Entra Agent ID, and Oasis: Completing the Picture for AI Agent Governance," oasis.security, originally published November 24, 2025 (updated March 2026).
