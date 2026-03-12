# Context Infrastructure: The Lasting Investment

There's a pattern in how organisations adopt AI agents. They start with the model. They build scaffolding around it: prompt chains, output parsers, routing logic, retry mechanisms. They invest months in orchestration. Then a better model drops and half the scaffolding becomes dead weight.

Shane calls this [harness debt](https://shanedeconinck.be/posts/ai-agent-scaffolding-trap/): scaffolding built to compensate for a weaker model becomes a liability when the model improves. Most teams don't see it until the next model drops and their pipeline fights it instead of leveraging it.

The question is: what do you invest in that gets more valuable over time, not less?

## What Depreciates, What Appreciates

Fine-tuning was the first casualty. Organisations invested heavily in custom-trained models. Then general-purpose models got strong enough that fine-tuning became a niche optimisation, not a core strategy. RAG pipelines followed: the retrieval-augmented generation infrastructure that compensated for limited context windows. As context windows grew from thousands to millions of tokens and models got better at reasoning over long contexts, the retrieval plumbing became less critical.

Shane [identifies the pattern](https://shanedeconinck.be/posts/ai-agents-context-infrastructure-long-term-investment/):

- **Training depreciates.** Every model upgrade makes the last fine-tuning run less relevant.
- **Code depreciates.** Orchestration scaffolding compensates for model weaknesses that disappear.
- **Access to frontier models depreciates.** It requires a credit card, not a competitive advantage.
- **Context infrastructure appreciates.** Well-curated information combined with well-managed access becomes exponentially more valuable as models improve.

Two organisations with the same model and the same budget but different context infrastructure will see diverging results. The one with structured, governed, current knowledge available to its agents will compound returns with every model improvement. The one running a better model on the same mess will wonder why it's not seeing the gains.

## The Evidence

Consider [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview), Anthropic's coding agent. The architecture is deliberately minimal: a single loop, a handful of tools, a text file checked into the repository (`CLAUDE.md`). When the model makes mistakes, Anthropic's teams don't write more code. They write better context. Every team maintains their own `CLAUDE.md` with project-specific patterns, conventions, and constraints. The context is the product.

Or look at Clawdbot, the AI personality that [went viral on X](https://shanedeconinck.be/posts/openclaw-moltbook-trust-fear-ai/) in early 2026. Its entire personality, goals, and rules lived in a `SOUL.md` file. The architecture: files, a powerful LLM, an execution environment. People anthropomorphised it. They trusted it. They installed it on their machines without understanding what system-level access means.

And that's the lesson. Clawdbot's failure wasn't the soul file or the model. It was missing access controls. Rich context without governance is a liability, not an asset. Context infrastructure requires both halves: well-curated information **and** well-managed access to it.

## Five Areas to Invest

Shane breaks context infrastructure into five areas that compound in value:

**1. Structure**: Coherent, consistent, machine-consumable information. Structure knowledge after the domain, not today's tool. A customer is an entity with attributes and relationships, not rows in a CRM. Policies are structured rules with conditions and exceptions, not PDFs. When you structure information around what it represents rather than what system holds it, every new tool (model, agent, workflow) can consume it immediately.

**2. Permissions**: Fine-grained access on the information itself. Not "can this agent reach this database?" but "can this agent see this customer's financial data for the purpose of processing this specific request?" Permissions need to travel with the data, not live only in the system that holds it. This is where [OAuth On-Behalf-Of](./protocol-landscape.md), [Verifiable Intent constraints](./verifiable-intent.md), and capability-based security patterns become essential infrastructure, not nice-to-have features.

**3. Discovery**: Agents need to find what they need. Standards like [MCP](./protocol-landscape.md) (Model Context Protocol) and [A2A](./protocol-landscape.md) (Agent-to-Agent) are building the plumbing for context discovery: how agents locate tools, data sources, and other agents. Custom pipelines and hard-coded integrations don't scale. Open discovery protocols do.

**4. Authority**: Access scoped to the delegating user's authority. When an agent acts on behalf of a user, it should only access what that user can access, for the purpose the user specified. This is the [On-Behalf-Of pattern](./protocol-landscape.md) and the [PIC delegation chain model](./protocol-landscape.md): authority that flows with the delegation and only decreases. Without this, every agent deployment risks becoming a [confused deputy](./agents-create-intent.md): an agent with credentials but no understanding of scope.

**5. Freshness**: Current information, not stale. Stale context fed to agents produces wrong decisions at machine speed. Information needs to be versioned, timestamped, and actively maintained. A policy document from six months ago that's been superseded could lead an agent to make decisions based on rules that no longer apply. This is worse than having no context at all, because the agent will act confidently on outdated information.

## The Inferential Edge

Shane takes the context argument further in ["When Intelligence Becomes Commodity, Infrastructure Becomes the Edge"](https://shanedeconinck.be/posts/when-intelligence-becomes-commodity/). The premise: general-purpose models are now good enough for most business tasks without custom training. The intelligence layer is becoming a commodity. A credit card buys frontier reasoning.

But the ability to unleash that intelligence into your organisation at volume with compounding returns: that's rare. He calls it the **inferential edge**.

Most organisations aren't there. They have trust structures, oversight, processes, compliance requirements all built for human workers. The infrastructure to adapt these for agents doesn't exist yet in most enterprises. The organisations that build it first create a gap that competitors can't close by simply buying a better model.

The inferential edge compounds: each process you automate teaches the organisation something. Trust infrastructure sharpens. Context pipelines improve. Evaluation gets tighter. Six months of infrastructure ahead of a competitor is a gap you can't buy off the shelf.

The evidence is everywhere. Andrej Karpathy went from 80% manual coding to 80% agent coding in weeks. DHH called it "the biggest and fastest change in 40 years." But both are leveraging well-structured codebases with clear context. The model is necessary but not sufficient. The context is what makes it productive.

## The Scaffolding Is Dissolving

The pipeline that AI engineers built over 2023-2025 is disappearing. Custom orchestration, multi-step routing, output parsers, chunking strategies: these compensated for weaker models. Frontier models figure out better paths themselves. Someone starting fresh today might outperform a legacy system with no scaffolding burden at all.

Shane points to [Claude Code as the inflection point](https://shanedeconinck.be/posts/when-intelligence-becomes-commodity/). Even Claude Code itself has gone through this: structured to-do systems became flexible task management the model controls. The tool didn't add scaffolding; it removed it as the model improved.

"AI Engineer" was coined in 2023. Chip Huyen's reference text published December 2024. But the real shift hit after: frontier inference costs dropped an order of magnitude, and tools like Claude Code and MCP weren't even a thing yet. The orchestration and routing layers are now dead weight for many use cases.

What survives the scaffolding collapse? Three things:

1. **Evaluation infrastructure**: how you know what's working and what isn't
2. **Context infrastructure**: the information and access patterns that make agents effective
3. **Trust infrastructure**: the identity, delegation, and audit capabilities covered throughout this book

Everything else is a bet on today's model weaknesses persisting.

## How This Maps to PAC

Context infrastructure is primarily a [Potential pillar](./pac-framework.md) concern: it determines whether what you build today still compounds when the next model drops. But it touches all three pillars:

**Potential**: Context management and durability are explicit dimensions. Build on what stays stable: domain knowledge, information architecture, evaluation pipelines. The PAC Framework's question "Will better models make your current setup more valuable, or obsolete?" is directly about whether you've invested in context or scaffolding.

**Accountability**: Context infrastructure determines what audit trails are possible. If you don't know what information reached the agent, you can't assess whether its decision was reasonable. Shane's framework asks: "When an agent makes a consequential decision, can you trace who authorised it and what happened?" Tracing what happened requires knowing what the agent saw.

**Control**: Context governance is control infrastructure. Fine-grained permissions on information, scoped authority, discovery through standards: these are the mechanisms that make agents safe to deploy. The [Google Workspace CLI case](https://shanedeconinck.be/posts/google-workspace-cli-agent-first-oauth-app-first/) illustrates this perfectly: Google's capability layer (MCP, skill files) is well-designed, but OAuth underneath was built for apps. Token scopes like `gmail.readonly` mean "all emails, all time," not "the one email relevant to this task." Users think they're granting narrow context access; they're actually granting everything.

## The Investment Thesis

The argument is straightforward: if intelligence is becoming commodity and scaffolding is becoming debt, the lasting competitive advantage is the infrastructure that makes intelligence useful. Context infrastructure: structured, governed, current, discoverable information with fine-grained access control.

Organisations that invest in this now will capture disproportionate value from every future model improvement. Those that invest in scaffolding will rebuild every time a new model drops.

The [PAC Framework](./pac-framework.md) provides the structure to assess which investments last. The protocols covered in this book provide the building blocks. The context infrastructure is what ties them together into something an agent can actually use.

---

**Sources:**
- [Shane Deconinck, "AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment" (2026-02-09)](https://shanedeconinck.be/posts/ai-agents-context-infrastructure-long-term-investment/)
- [Shane Deconinck, "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge" (2026-03-02)](https://shanedeconinck.be/posts/when-intelligence-becomes-commodity/)
- [Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting." (2026-02-02)](https://shanedeconinck.be/posts/ai-agent-scaffolding-trap/)
- [Shane Deconinck, "OpenClaw and Moltbook: What Happens When We Trust and Fear AI for the Wrong Reasons" (2026-02-17)](https://shanedeconinck.be/posts/openclaw-moltbook-trust-fear-ai/)
- [Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First." (2026-03-05)](https://shanedeconinck.be/posts/google-workspace-cli-agent-first-oauth-app-first/)
- [MIT Technology Review, "Building a strong data infrastructure for AI agent success" (2026-03-10)](https://www.technologyreview.com/2026/03/10/1134083/building-a-strong-data-infrastructure-for-ai-agent-success/)
