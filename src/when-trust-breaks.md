# When Trust Breaks Down

The previous chapters described what's being built. This chapter looks at what happens when it isn't built, or isn't built fast enough. The evidence is no longer theoretical.

## The Numbers

Two reports published in February 2026 tell the same story from different angles.

[Gravitee's State of AI Agent Security 2026](https://www.gravitee.io/state-of-ai-agent-security) surveyed 750 CIOs, CTOs, and engineering leaders across the US and UK. Their headline finding: 88% of organizations reported confirmed or suspected AI agent security or privacy incidents in the past year. In healthcare, that number hits 92.7%.

The scale matters. Gravitee estimates over 3 million AI agents are now operating within corporations, a workforce larger than Walmart's entire global headcount. Of those, 47% run without any security oversight or logging. That's approximately 1.5 million agents operating in the dark.

[Teleport's 2026 State of AI in Enterprise Infrastructure Security](https://goteleport.com/about/newsroom/press-releases/2026-state-of-ai-in-enterprise-security-report/), based on interviews with 205 CISOs and security architects, found the sharpest predictor of security outcomes. Not AI sophistication. Not organizational maturity. Access scope. Organizations with over-privileged AI systems reported a 76% incident rate. Those that enforced least-privilege: 17%. That's a 4.5x difference.

Two numbers from the Teleport report land hard:

- **67%** of organizations still rely on static credentials for AI systems. Static credentials correlated with a 20-point increase in incident rates.
- **Only 13%** feel highly prepared for agentic AI, while 79% are already evaluating or deploying it.

Gartner's [strategic predictions for 2026](https://www.gartner.com/en/articles/strategic-predictions-for-2026) project that more than 2,000 "death by AI" legal claims will be filed by the end of 2026 due to insufficient AI risk guardrails. They add that over 40% of agentic AI projects will be canceled by end of 2027 due to escalating costs or unclear business value.

This is the gap the PAC Framework describes: Potential is being captured, but Accountability and Control haven't caught up.

## The Identity Vacuum

The most consistent finding across both reports: agents aren't being treated as identities.

Gravitee found that only 21.9% of teams treat AI agents as independent, identity-bearing entities. The rest are running agents under shared credentials, inherited user sessions, or nothing at all. 45.6% of teams rely on shared API keys for agent-to-agent authentication. 27.2% have resorted to custom, hardcoded authorization logic.

This is exactly the problem [Chapter 1](./agents-create-intent.md) described: when agents create intent, they need their own identity. When they don't have one, you can't trace what happened, who authorized it, or what went wrong. Delegation becomes abdication.

NIST recognized this when they published their [concept paper on AI agent identity and authorization](https://csrc.nist.gov/pubs/other/2026/02/05/accelerating-the-adoption-of-software-and-ai-agent/ipd) in February 2026. The paper's core premise: AI agents should be treated as identifiable entities within enterprise identity systems rather than as anonymous automation running under shared credentials. They identified OAuth, OpenID Connect, SPIFFE/SPIRE, and SCIM as the building blocks, and proposed a demonstration project to show how they compose in practice.

Then, on February 17, NIST [announced the AI Agent Standards Initiative](https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure), organized through their Center for AI Standards and Innovation (CAISI). The initiative has three pillars: facilitating industry-led agent standards, fostering community-led open source protocol development, and advancing research in agent security and identity. Public input on the concept paper was open through April 2, 2026.

The timing isn't coincidental. The incident data made the case that voluntary best practices weren't enough.

## MCP: When the Plumbing Leaks

The Model Context Protocol (MCP) has become the dominant interface for connecting AI models to external tools and data. Its adoption is impressive. Its security track record is not.

In early 2026, three CVEs were published for Anthropic's own Git MCP server:

- **CVE-2025-68145**: Path validation bypass allowing access to files outside the configured repository
- **CVE-2025-68143**: Unrestricted `git_init` enabling arbitrary directory creation
- **CVE-2025-68144**: Argument injection in git commands enabling remote code execution

All three were exploitable through prompt injection: an attacker could craft input that caused the AI model to invoke MCP tools in unintended ways. The model didn't need to be compromised. It just needed to follow instructions that happened to be malicious.

The supply chain risks are real too. The popular `mcp-remote` npm package, used to add OAuth support to MCP servers, was found to contain a critical vulnerability ([CVE-2025-6514](https://nvd.nist.gov/vuln/detail/CVE-2025-6514)). This is the kind of dependency that gets installed without much scrutiny and runs with whatever permissions the MCP server has.

The broader pattern: MCP servers often accept unauthenticated calls, skip OAuth entirely, or implement it poorly. Many don't verify requests or protect user sessions. [Adversa AI's monthly MCP security roundups](https://adversa.ai/blog/top-mcp-security-resources-march-2026/) have become a running chronicle of what goes wrong when tool interfaces ship without the trust infrastructure they need.

From a PAC perspective, these aren't reliability problems. They're Control failures. The infrastructure doesn't enforce what policy demands. The wrong thing isn't impossible: it's easy.

## The Over-Privilege Pattern

Teleport's finding deserves its own section because it maps directly to the trust inversion argument.

Traditional IAM works by granting broad access and restricting specific actions. The Teleport data shows what happens when that model is applied to agents: a 76% incident rate. The organizations that inverted this, granting minimal access and requiring explicit authorization for each capability, dropped to 17%.

This is the same principle the [trust inversion chapter](./agents-create-intent.md) described: agents must be restricted to what they *can* do, not blocked from what they *can't*. The Teleport data turns that principle into empirical evidence.

The 67% static credential finding is equally telling. Static credentials mean no rotation, no scoping, no audit trail of which agent used which credential for what purpose. It's the confused deputy problem at organizational scale: the agent has credentials, but no one knows what it's doing with them.

Verifiable Intent's L2 constraints address exactly this: every agent action carries the constraint envelope that governs it. The constraint types (amount limits, merchant categories, time windows, geographic restrictions) exist precisely because "the agent has a token" isn't enough. You need to know what the token allows, and you need the infrastructure to enforce it.

## Shadow Agents

Both Gravitee and the OpenID Foundation's [AIIM whitepaper](https://openid.net/new-whitepaper-tackles-ai-agent-identity-challenges/) flag the same risk: shadow agents.

Gravitee found that only 14.4% of organizations have full security approval for their entire agent fleet. The rest have agents running that were never reviewed, never registered, never scoped. Some were built by individual developers. Some were spun up by other agents: 25.5% of deployed agents have the capability to create and task other agents.

This is the registration problem the [Gaps chapter](./gaps.md) flagged. You can't govern what you can't see. NIST's concept paper explicitly focuses on enterprise agents where organizations maintain control, because the alternative, agents operating across boundaries where no single organization controls the environment, is a harder problem that requires cross-domain trust infrastructure (TSP, DIDs, verifiable credentials) that's still being built.

The PAC Framework's Accountability pillar starts with a question: "Do you know every agent running in your organisation?" For most organizations, the honest answer is no.

## What the EU AI Act Means for Agent Incidents

The EU AI Act's [high-risk system obligations take effect on August 2, 2026](https://artificialintelligenceact.eu/). These include requirements for risk management, data governance, technical documentation, record-keeping, transparency, human oversight, accuracy, robustness, and cybersecurity. Non-compliance carries fines of up to 35 million euros or a percentage of global annual turnover.

The Act doesn't specifically address "AI agents" as a category. But agents that operate in high-risk domains, think healthcare, finance, employment, law enforcement, critical infrastructure, fall squarely within its scope. The Annex III categories map cleanly to areas where agents are already being deployed.

Three requirements are particularly relevant for the incidents described in this chapter:

1. **Transparency** (Article 50): AI systems must disclose their artificial nature. An agent operating under shared credentials with no identity of its own can't satisfy this requirement.
2. **Human oversight**: High-risk systems must be designed so humans can effectively oversee them. The Gravitee finding that 47% of agents run without monitoring suggests widespread non-compliance.
3. **Record-keeping**: Technical logs must be automatically generated and retained. Agents without audit trails can't produce them.

The PAC Framework's Accountability pillar was designed with this regulatory landscape in mind. The question "Could you explain to a regulator what your agent did and why?" is about to become urgent.

## The Pattern

Every incident in this chapter follows the same pattern:

1. An agent is deployed with more access than it needs
2. No independent identity is established for the agent
3. No constraint infrastructure bounds what the agent can do
4. Something goes wrong
5. No one can explain what happened or who authorized it

This is the gap between Potential and Control. Organizations are capturing value from agents (the PAC Framework's Potential pillar) without building the infrastructure to enforce governance (the Control pillar) or establishing clear accountability chains (the Accountability pillar).

The protocols described in [The Protocol Landscape](./protocol-landscape.md) and [Verifiable Intent](./verifiable-intent.md) are being built to close this gap. The question is whether they'll be adopted before the next wave of incidents, or because of it.

**The infrastructure problem is clear. The incident data makes the cost of delay concrete. What remains is building it.**
