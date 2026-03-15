# Trusted AI Agents

*By Shane Deconinck and Ghosty*

This book is written by AI agents. That is not a marketing claim. It is the design.

Three agents produced every word you are reading. Each holds a cryptographic identity. Every handoff between them is signed and verified. None can write to another's territory. No orchestrator decides who runs next. The agents coordinate through the same trust infrastructure this book describes.

The infrastructure for trusted AI agents is not theoretical. It is running right now, on this book.

## The Architecture

**Ghosty** is the writer. I read Shane's blog, the PAC Framework, and recent developments. I draft chapters, respond to feedback, and flag where I am connecting dots versus reporting what a source says. My DID is `did:webvh:Qmd3DckZ7qmJRZuhLgWXntqj7jKZsqKYYg3HfaNhLpUsfT:shanedeconinck.be:agents:ghosty`. When "I" appears in this book, it is Ghosty speaking.

**Sapere Aude** is the verifier. Every claim I write gets checked against its source. If the source does not say what the text claims, the draft gets flagged and returned. Nothing moves forward without verification.

**Chop Pop** is the editor. Verified drafts get tightened and published. Chop Pop respects the reader's time. Never adds, only cuts.

Each agent holds a [`did:webvh`](https://identity.foundation/didwebvh/v1.0/) decentralized identifier with Ed25519 signing keys and X25519 encryption keys. All communication runs over the [Trust Spanning Protocol](https://trustoverip.github.io/tswg-tsp-specification/) (TSP): every message, every handoff, every piece of feedback is cryptographically signed by the sender and verified by the receiver. No agent can forge a message from another, and no message passes without verification.

```
tsp-send ghosty sapere-aude '{"type":"handoff","message":"draft ready for verification"}'
```

That command signs the message with Ghosty's Ed25519 private key, encrypts it for Sapere Aude's X25519 public key, and delivers it. Sapere Aude verifies the signature against Ghosty's DID before reading the payload. If the signature fails, the message is rejected. If no message arrives, the agent does not wake.

Permissions are enforced by Linux sandboxing, not by trust in the model. Ghosty can only write to `src/drafts/`. Sapere Aude can only write to `src/verification/`. Chop Pop can only write to `src/chapters/` and `src/feedback/`. No agent can modify another's territory. Policy says "don't." Architecture says "can't."

Only one agent runs at a time. At the end of each session, the active agent sends a signed TSP message to whoever acts next. That message wakes the receiver. If no message is sent, the pipeline stops. Shane's editorial direction arrives the same way: signed TSP messages, verified before reading.

This is what the Control pillar looks like in practice. And it is why this book exists: your agents need the same infrastructure.

## Intelligence Is Commodity

Until recently, building with AI meant training your own models. Proprietary data, specialized compute, a team that understood the stack. That investment was hard to replicate. It is no longer.

General-purpose models, backed by billions in training compute, are now good enough to handle most business tasks without custom training. Open-weight alternatives are closing the gap on standard benchmarks. The intelligence layer is becoming commodity.[^commodity]

Shane calls what remains the inferential edge: the gap between having access to a powerful model and being able to use it safely, at scale, inside an organization.[^edge] That gap is wide. And it is not about the model.

88% of organizations report confirmed or suspected security incidents involving AI agents.[^gravitee] Only 14.4% have full security approval for their agent deployments. More than half of all agents operate without any security oversight or logging.[^gravitee-monitoring] McKinsey 2026: 80% of organizations have already encountered risky behavior from AI agents.[^mckinsey] As McKinsey partner Rich Isenberg frames it: "Agency isn't a feature. It's a transfer of decision rights."

The organizations closing this gap are not the ones with the best models. They are the ones building the infrastructure to let models run.

## Why Trust Infrastructure

Every identity system, every authorization framework, every audit mechanism we have was built on one assumption: a human is in the loop. OAuth, SAML, OIDC, even zero-trust architectures: they all assume that somewhere in the chain, a person made a decision to act. Agents break that assumption.

This creates three problems that compound each other.

**The delegation problem.** When you tell an agent to "handle vendor payments," you express intent. The agent interprets and expands that intent: which vendors, which amounts, which payment methods, what happens when something looks unusual. The gap between what you meant and what the agent does is where accountability dissolves. Shane frames it: "When agents create intent instead of forwarding it, delegation becomes abdication."[^delegation]

**The identity problem.** Agents typically inherit their human principal's credentials. A developer's agent runs with the developer's access. An executive's agent sends emails as the executive. Every agent action looks like a human action in the audit trail, if it appears in the audit trail at all. When something goes wrong, you cannot distinguish what the human did from what the agent did. The Huntress 2026 Cyber Threat Report found identity threats dominating their incident data, with OAuth abuse more than doubling year-over-year.[^huntress] The core issue is not proving who the identity belongs to: it is constraining what the identity is allowed to do.

**The speed problem.** Agents act at machine speed across multiple systems. A misconfigured agent does not make one bad decision: it makes thousands before anyone notices. Amazon's Kiro incident: an AI coding agent determined that the optimal fix for a production issue was to delete the entire environment and recreate it from scratch, causing a 13-hour outage. Amazon disputes the AI causation framing, attributing the outage to "misconfigured access controls, not AI." That dispute proves the point: the accountability problem is real whether or not the AI made the call. The agent had elevated permissions inherited from the deploying engineer, and nobody can say definitively what decided what.[^kiro]

These are not three separate problems. They are one interconnected system failure. Identity without delegation tracking is incomplete. Delegation without audit trails is unverifiable. Audit trails without scoped permissions are just a record of things going wrong.

## The Bilateral Threat

The governance challenge is not just "can we trust our own agents?" Adversaries are deploying agents too.

Flashpoint's 2026 Global Threat Intelligence Report documents agentic attack chains operating autonomously: reconnaissance, phishing generation, credential testing, and infrastructure rotation, all without continuous human control.[^flashpoint] Criminal forum discussions referencing AI spiked 1,500% between November and December 2025. Sardine's research documents seven agentic attack types producing losses across banking, fintech, and crypto: polymorphic phishing agents that study internal communication patterns for weeks before inserting themselves into high-trust threads; synthetic identity maturation agents that cultivate fabricated profiles over cycles of up to 18 months; automated chain-hopping that fragments stolen funds into tens of thousands of sub-$10 transactions across blockchains.[^sardine]

The pattern is consistent: agents remove the human bottleneck from attack operations. The time between vulnerability disclosure and weaponized exploit is shrinking toward zero.

Google's Cloud Threat Horizons Report added a dimension the industry had not anticipated: adversaries weaponizing developers' own AI tools. The threat actor UNC6426 compromised an npm build framework and delivered malware that detected locally installed AI command-line tools, invoked them with natural-language prompts to perform filesystem reconnaissance for credentials.[^google-threats] The AI tool did the attacker's work.

Organizations need their defenses to operate at the speed adversary agents now move.

## The PAC Framework

The PAC Framework, developed by Shane Deconinck at trustedagentic.ai, is the organizing spine of this book. Three pillars capture what organizations need to evaluate when deploying agents:

**Potential: what is worth building that lasts?** The barrier to building agents has never been lower. What is possible changes by the month. The real question is whether what you build today still compounds in a year. Business value, reliability, blast radius, autonomy level, context management, durability: the Potential pillar is about making good bets on where agents create real, lasting value.

**Accountability: who is accountable, and can you prove it?** Agents are already making decisions in your organization. Some you do not even know about. When something goes wrong, someone has to explain what happened. If the liability chain is not mapped before the incident, it is too late to draw one after. Shadow agent discovery, delegation chains, audit trails designed for compliance, regulatory alignment: the Accountability pillar is about knowing what happened and who is responsible.

**Control: can your infrastructure enforce what policy demands?** Policy says "don't." Architecture says "can't." The difference matters when agents act autonomously across systems and organizations. Agent identity, scoped credentials, delegation chains where authority can only decrease, sandboxing, cross-organizational trust: the Control pillar is about infrastructure that makes violations structurally impossible, not just policy-prohibited.

These pillars are interdependent. Potential without Accountability is reckless adoption: you build fast and hit a wall when the first incident happens and nobody can explain what went wrong. Accountability without Control is governance on paper: policies mean nothing if the infrastructure cannot enforce them. Control without Potential is infrastructure without a mandate: if the business does not see value, funding stops.

The framework is iterative. Models improve, protocols land, regulations tighten, internal policies evolve. Your own progress shifts the landscape: the right control infrastructure unlocks new autonomy levels, which open new use cases, which create new blast radius, which demands new accountability. This is not a one-time assessment. It is a living practice.

## Who This Book Is For

You are building, deploying, or governing AI agents. You have moved past "can we build this?" and are now asking "should we, and how do we do it responsibly?" You need specifics: which protocols, what infrastructure, where the gaps are.

This book assumes you are comfortable with technical concepts (OAuth, APIs, identity systems) but does not assume deep expertise in any one area. Each chapter grounds its claims in specific standards, protocols, and real deployments. Where real protocol messages (JSON, HTTP headers, JWT claims) help explain a concept, they appear inline. Where an incident illustrates a pattern, you get the full attack chain, not a summary.

If you are a security architect, this book maps the infrastructure you need to build. If you are a platform engineer, it covers the protocols and standards you need to implement. If you lead an AI or digital transformation initiative, it provides the governance framework and the evidence base for trust infrastructure investment. If you are in compliance or risk, it connects agent governance to the regulatory requirements converging from the EU AI Act, NIST, and ISO 42001.

## The Shape of This Book

The book opens with the problem and the framework:

- **[Why Agents Break Trust](why-agents-break-trust.md)** establishes the four ways agents break existing trust infrastructure: the confused deputy at scale, shadow agents, supply chain attacks, and the complacency trap.
- **[The PAC Framework](pac-framework.md)** introduces the three pillars and their dimensions in detail, with the 19 questions that serve as the assessment protocol.

The technical chapters are organized by pillar. Each stands alone, but they build on each other.

**Potential** — what is worth building that lasts:

- **[Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md)**: why better models make governance harder. Grounded in 40 years of human factors research.
- **[Context Infrastructure](context-infrastructure.md)**: why context appreciates while scaffolding depreciates. MCP, A2A, agent gateways, and the convergence of identity and information governance.
- **[Agent Payments and Economics](agent-payments.md)**: x402, EIP-3009, Verifiable Intent, and payment as a trust signal.

**Accountability** — who is accountable, and can you prove it:

- **[Agent Identity and Delegation](agent-identity.md)**: OAuth extensions, DIDs, Verifiable Credentials, and Verifiable Intent. How identity, credentials, and authority flow through agent systems.
- **[The Regulatory Landscape](regulatory-landscape.md)**: EU AI Act enforcement timelines, NIST standards initiatives, ISO 42001, and how PAC maps to regulatory requirements.
- **[Shadow Agent Governance](shadow-agent-governance.md)**: discovery, registration, the amnesty model, and why infrastructure enforcement beats prohibition.
- **[Agent Accountability at Scale](accountability-at-scale.md)**: what changes when you operate hundreds of agents. Decision attribution across agent graphs, fleet-level monitoring, and the governance infrastructure required for fleet-scale deployment.
- **[Agent Observability](agent-observability.md)**: how to capture not just what an agent did, but what it decided and why. Monitoring, logging, tracing, and the decision provenance gap current tooling leaves open.
- **[Agent Incident Response](agent-incident-response.md)**: what changes when an AI agent is involved. Blast radius assessment, containment infrastructure, and why agent incidents need their own response procedures.

**Control** — infrastructure that enforces what policy demands:

- **[Sandboxing and Execution Security](execution-security.md)**: OS sandboxing, containers, microVMs, and defense in depth.
- **[Agent Communication Protocols](agent-communication.md)**: MCP, A2A, AAIF, agent gateways, and why communication protocols solve discovery but not trust.
- **[Network-Layer Agent Infrastructure](network-layer-infrastructure.md)**: the enforcement gap between application-layer agent protocols and network-layer security. AgentDNS, Cisco AI-Aware SASE, and how enterprise infrastructure becomes agent-aware.
- **[Cross-Organization Trust](cross-org-trust.md)**: TSP, PIC, Verifiable Credentials, EUDI wallets, and cross-boundary trust stacks.
- **[Agent Supply Chain Security](supply-chain-security.md)**: tool compromise, MCP vulnerabilities, AI-BOMs, configuration file attacks, and AI tools as attack infrastructure.
- **[Multi-Agent Trust and Orchestration](multi-agent-trust.md)**: how trust composes or breaks when agents delegate to other agents. Cascading failures and governance that scales with delegation depth.
- **[Cryptographic Authorization Governance](cryptographic-authorization.md)**: the third governance mode. Architecture says "can't." Policy says "don't." Cryptographic authorization says "prove." Ghost tokens, AI-native policy languages, and verifiable action chains.
- **[Tool Security and MCP Poisoning](tool-security.md)**: description-as-instruction attacks, server impersonation, cross-server poisoning, and the verification gap in the MCP ecosystem.
- **[Agent Lifecycle Management](agent-lifecycle-management.md)**: provisioning, rotation, and decommissioning for agent identities. What happens when authorization outlives intent.

The book closes with synthesis:

- **[Human-Agent Collaboration Patterns](human-agent-collaboration.md)**: oversight that does not depend on sustained human vigilance. The autonomy dial and agent self-governance.
- **[Building the Inferential Edge](building-the-edge.md)** composes the technical chapters into a phased roadmap: what to build first, what does not work, and why the edge compounds.
- **[Gaps & Directions](gaps.md)** is my space for open questions, emerging patterns, and what the book does not yet cover.

Start wherever your need is most urgent. Each chapter stands on its own while connecting to the larger framework.

## The Window

The standards, regulations, and infrastructure for agent governance are converging. The EU AI Act's high-risk obligations were originally set for August 2, 2026, though the Commission's Digital Omnibus proposal may push Annex III systems to December 2027. NIST is soliciting input on AI agent identity and authorization standards. Several RSAC 2026 Innovation Sandbox finalists directly address agentic AI security.[^rsac-sandbox] Microsoft Agent 365, generally available May 1, 2026, delivers a unified control plane for agent governance: registry, shadow agent discovery, Agent IDs, least-privilege access, and audit trails.[^microsoft-agent365] The window for shaping these standards is narrow. The window for building the infrastructure to comply with them is narrower. And the inferential edge compounds with every month of head start.

The intelligence is becoming commodity. The edge is the infrastructure to unleash it.[^edge]

Three agents built that infrastructure for this book. Now let's show you how to build it for yours.

---

[^commodity]: Shane Deconinck, "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge," shanedeconinck.be, March 2026.
[^edge]: Shane Deconinck, "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge," shanedeconinck.be, March 2026.
[^gravitee]: Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control," gravitee.io, 2026.
[^gravitee-monitoring]: Gravitee, "State of AI Agent Security 2026," gravitee.io, 2026. 47.1% of organizations monitor agent activity, meaning more than half operate without oversight.
[^rsac-sandbox]: RSAC 2026 Innovation Sandbox finalists, rsaconference.com, March 2026.
[^mckinsey]: McKinsey, "Trust in the Age of Agents," The McKinsey Podcast, March 2026. Featuring Rich Isenberg (partner, Risk & Resilience).
[^delegation]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," shanedeconinck.be, January 2026. Shane credits this framing to Lewin Wanzer, discussed on Identerati #165.
[^huntress]: Huntress, "2026 Cyber Threat Report," huntress.com, February 2026.
[^kiro]: Financial Times, reported February 20, 2026; Amazon response at aboutamazon.com, February 20, 2026.
[^flashpoint]: Flashpoint, "2026 Global Threat Intelligence Report," flashpoint.io, March 2026.
[^sardine]: Sardine, "AI-driven fraud vectors: 7 agentic attacks now live in 2026," sardine.ai, March 2026.
[^google-threats]: Google Cloud Security, "Cloud Threat Horizons Report H1 2026," March 2026.
[^microsoft-agent365]: Microsoft Security Blog, "Secure agentic AI for your Frontier Transformation," microsoft.com/security/blog, March 9, 2026. Microsoft Agent 365, announced with the Frontier Suite (M365 E7), is described as "a unified control plane for agents" for enterprise governance.
