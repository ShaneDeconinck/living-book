# Building the Inferential Edge

This book opened with a problem: agents break trust because our infrastructure was built for humans. It introduced a framework: Potential, Accountability, Control. Then it spent thirteen chapters mapping the technical landscape: identity, context, regulation, reliability, payments, sandboxing, cross-organization trust, communication protocols, supply chain security, shadow agents, multi-agent orchestration, and human-agent collaboration.

Now the question is: what do you actually build first?

## The Gap

Shane calls it the inferential edge: the gap between having access to a powerful model and being able to use it safely, at scale, inside an organization.[^1] That gap is wide, and it is not about model capability. Intelligence is commodity. Any business can access frontier models through an API call. Open-weight alternatives are closing the gap on standard benchmarks. The barrier to building an agent has never been lower.

But 88% of organizations report confirmed or suspected security incidents involving AI agents.[^2] Only 14.4% have full security approval for their agent deployments.[^2] More than half of all agents operate without any security oversight or logging.[^3] Cisco's State of AI Security 2026 report quantifies the gap from the other direction: 83% of organizations plan to deploy agentic AI, but only 29% feel they can do so securely.[^cisco-edge] Gartner projects over 1,000 legal claims for AI agent harm by the end of 2026.[^4] Forrester's 2026 Predictions are more specific: an agentic AI deployment will cause a public breach leading to employee dismissals this year.[^forrester-prediction] Senior analyst Paddy Harrington identifies cascading failures as the primary mechanism: "When you tie multiple agents together and you allow them to take action based on each other, one fault somewhere is going to cascade and expose systems." The Galileo research cited in the [Multi-Agent Trust](multi-agent-trust.md) chapter quantifies this: 87% downstream decision poisoning within four hours from a single compromised agent.

The organizations closing this gap are not the ones with the best models. They are the ones building the infrastructure to let models run.

## The Trust Infrastructure Stack

The thirteen technical chapters of this book are not isolated topics. They compose into a coherent trust infrastructure stack, organized around the three PAC pillars:

**Control (the foundation):** Trust infrastructure starts with what you can enforce. Agent identity and delegation (Chapter 3) establishes who agents are and what authority they carry. Sandboxing and execution security (Chapter 8) contains what agents can do at the system level. Cross-organization trust (Chapter 9) extends enforcement across organizational boundaries. Agent communication protocols (Chapter 10) handle how agents discover and interact with tools and each other. Supply chain security (Chapter 11) verifies the components inside the agent.

**Accountability (the connective tissue):** Control without accountability is enforcement without evidence. The regulatory landscape (Chapter 5) maps the compliance requirements converging from the EU AI Act, NIST, and ISO 42001. Shadow agent governance (Chapter 12) discovers and registers the agents already running. Multi-agent trust and orchestration (Chapter 13) traces delegation chains and prevents cascading failures. Each creates the audit trail that makes control provable.

**Potential (the driver):** Infrastructure without value is overhead. Context infrastructure (Chapter 4) ensures agents have the right information at the right time. Reliability and evaluation (Chapter 6) measures whether agents actually work. Agent payments and economics (Chapter 7) enables the economic layer. Human-agent collaboration (Chapter 14) designs the oversight model that makes deployment possible.

The problem chapter (Chapter 1) and the PAC Framework chapter (Chapter 2) are the spine: they explain why this infrastructure is needed and how to reason about it.

## Where to Start

The infrastructure maturity scale (I1 through I5) that appears throughout the book is not just a measurement tool. It is a roadmap.

**Phase 1: Visibility (I1 to I2).** You cannot govern what you cannot see. Start here:

- *Agent registry.* Discover every agent running in your organization. The shadow agent governance chapter provides the methodology: network analysis, platform auditing, the amnesty model. Most organizations have 1,200+ unofficial AI applications and no visibility into their data flows.[^5] The registry captures identity, owner, authority, permissions, blast radius, and regulatory classification for each agent.
- *Audit logging.* Every agent action needs a trail: what was requested, what was decided, what was executed, what authority existed. Design these logs for compliance, not debugging. The question is not "what went wrong?" but "can you show a regulator what happened and why?"
- *Blast radius assessment.* For each agent in the registry, assess what happens when it fails. The PAC Framework's B1-B5 scale provides the classification. Contained tasks (B1-B2) can proceed with logging. Regulated or irreversible tasks (B4-B5) need control infrastructure before they run.

This phase maps directly to Shane's first question: "Do you know every agent running in your organisation?"[^6]

**Phase 2: Enforcement (I2 to I3).** Logging tells you what happened. Enforcement prevents what should not:

- *Identity infrastructure.* Agents get their own identities, distinct from their human principals. OAuth extensions (OBO, DPoP) handle single-domain delegation. The NIST concept paper on AI agent identity and authorization, with its comment period closing April 2, 2026, signals where standards are heading.[^7] If your agents are using shared service accounts with broad static permissions, this is where that changes.
- *Permission scoping.* Move from blocklists ("don't do this") to allowlists ("can only do this"). Shane's trust inversion: humans are restricted in what they cannot do; agents must be restricted to what they can, for each task.[^8] Match permission granularity to blast radius: per-tool-call for B4-B5, per-task for B2-B3, per-session for B1.
- *Sandboxing.* Filesystem isolation, network restrictions, configuration file protection. The [Sandboxing and Execution Security](execution-security.md) chapter covers the full isolation spectrum from native OS sandboxing to microVMs. This is not optional for any agent that touches production systems.

**Phase 3: Governance (I3 to I4).** Enforcement contains individual agents. Governance manages the system:

- *Delegation chains.* When agents delegate to other agents, authority must only decrease. Delegation Capability Tokens (macaroons, biscuits) encode this cryptographically. PIC provides authority continuity without token-based possession.[^9] Galileo's research shows 87% downstream decision poisoning within four hours from a single compromised agent in a delegation chain.[^10] Cascading failure prevention is not an optimization: it is a requirement.
- *Supply chain verification.* Every tool, plugin, and MCP server your agents use is an attack surface. 36.7% of 7,000 scanned MCP servers are vulnerable to SSRF.[^11] 30 CVEs have been filed against MCP infrastructure in just 60 days.[^12] AI-BOMs, behavioral monitoring, and runtime verification are the defense layers.
- *Regulatory alignment.* The EU AI Act's high-risk obligations take effect August 2, 2026. NIST's AI Agent Standards Initiative is actively seeking input. Map your agents against regulatory classification requirements now. The regulatory landscape chapter provides the PAC-to-regulation mapping.

**Phase 4: Architecture (I4 to I5).** The infrastructure becomes the fabric:

- *Cross-organizational trust.* TSP for identity verification across boundaries. PIC for authority propagation that cannot expand. Verifiable Credentials as the trust carrier. This is where agents stop being internal tools and become participants in multi-party workflows.
- *Agent gateways.* Centralized policy enforcement for agent traffic, analogous to API gateways. Cedar policies, MCP federation, SSO-integrated auth. The communication protocols chapter covers the emerging patterns.
- *Infrastructure-in-the-loop.* Replace sustained human vigilance with structural enforcement. Automated scope verification, behavioral monitoring, circuit breakers. The collaboration patterns chapter provides the design.

This is not a waterfall plan. Each phase builds on the previous one, and most organizations will work on multiple phases simultaneously for different agent deployments. The point is sequencing: visibility before enforcement, enforcement before governance, governance before architecture.

## What Does Not Work

The roadmap above is grounded in patterns that succeed. Equally important is recognizing the patterns that fail. Across the book's thirteen technical chapters, certain anti-patterns appear repeatedly. Organizations that hit walls usually hit one of these.

**Policy without architecture.** Writing an "AI agent acceptable use policy" and calling it governance. Policies describe intent. They do not constrain behavior. When an agent runs at machine speed across multiple systems, the only governance that works is infrastructure that enforces constraints at runtime: sandboxes, scoped credentials, delegation chains with authority that can only decrease. Shane's framing is precise: policy says "don't." Architecture says "can't." The difference matters.[^policy-arch] Amazon's Kiro incident illustrates this exactly: the two-person approval for production changes was a policy. Kiro bypassed it by inheriting the deploying engineer's elevated permissions. The post-incident fix (mandatory senior approval for AI-assisted production code) was another policy. The structural fix would have been containment: agents cannot delete production environments regardless of who deployed them.[^kiro-edge]

**Identity by inheritance.** Letting agents authenticate as their human principal or through shared service accounts. This is the confused deputy pattern from Chapter 1 at organizational scale: every agent action looks like a human action in the audit trail, permissions are impossibly broad because the human's access was designed for human workflows, and when something goes wrong you cannot distinguish what the human did from what the agent did. The Kiro incident is identity-by-inheritance in its purest form: the agent inherited elevated permissions and acted as though it were the engineer, but without the engineer's judgment about what actions were appropriate. The agent identity chapter covers why agents need their own identities. The practical test: if an agent causes an incident, can your audit system show which agent acted, under what authority, separate from the human who delegated?

**Evaluation as a gate, not a practice.** Running a benchmark before deployment and treating the result as permanent. Agent reliability is not static: it varies with context, input distribution, tool availability, and model updates. The reliability chapter documents the gap: 52% of organizations evaluate offline, but only 37% monitor post-deployment.[^eval-gap] The organizations that treat evaluation as a continuous practice catch drift before it becomes an incident. The ones that treat it as a one-time gate are surprised when production behavior diverges from benchmark results.

**Governance at human speed.** Requiring manual review for every agent deployment while agents get built in minutes on low-code platforms. This is the structural cause of shadow agents: when governance takes weeks and deployment takes minutes, employees route around governance. The shadow agent governance chapter's amnesty model addresses this directly. The fix is not faster humans. It is governance infrastructure that operates at agent speed: automated classification by blast radius, self-service registration, infrastructure-enforced controls that apply automatically.

**The capability showcase.** Deploying agents to demonstrate what AI can do rather than to solve a specific business problem. The PAC Framework's Potential pillar starts with business value for a reason: an agent that impresses in a demo but does not address a real workflow creates no lasting advantage. When the next model drops, the impressive demo resets to zero. The business value it delivered compounds. Shane's durability test: will better models make this setup more valuable, or obsolete?[^durability]

**Flat multi-agent deployment.** Running multiple agents without considering how they interact. The multi-agent trust chapter documents the consequences: in a flat topology without scoped trust boundaries, a single compromised agent can poison 87% of downstream decisions within four hours. The AgenticCyOps research shows that scoped trust boundaries reduce exploitable surfaces by 72%. The difference between a flat deployment and a governed one is not incremental: it is structural.

These are not theoretical risks. Each maps to documented failures, breach data, or empirical research cited in the relevant chapters. The roadmap's phased approach is designed to eliminate them in sequence: visibility prevents identity-by-inheritance from going undetected, enforcement eliminates policy-without-architecture, governance catches evaluation drift and multi-agent interaction risks, and architecture-level infrastructure makes governance operate at the speed the environment demands.

## The Organizational Challenge

The hardest part of building the inferential edge is not technical. Research shows 70% of AI project failures stem from organizational resistance, not technical limitations.[^13] Only 14% of organizations have deployable agentic solutions. Only 11% have agents in production.[^14]

The organizations succeeding share three patterns:

**They redesign processes, not just automate them.** Layering agents onto existing workflows preserves the workflow's limitations. The organizations getting value are asking: if we were designing this process today, knowing agents could handle the predictable parts, what would we build? Shane's observation is precise: the work is not disappearing, it is changing shape.[^15] The human role that lasts is at the root of the intent: defining what should happen, making the calls that require judgment, owning the decisions an agent cannot.

**They treat governance as enablement, not restriction.** The shadow agent governance chapter makes this case: shadow agents prove where value exists. Discovery is simultaneously a governance exercise and a product research exercise. The amnesty model works because it starts from the premise that employees built agents because they saw value, not because they wanted to circumvent policy. Governing those agents properly is what lets them scale.

**They invest in organizational learning.** Every process automated teaches the organization something. Trust infrastructure gets sharper. Context pipelines improve. Teams learn which processes to hand over next and at what autonomy level. Each cycle raises the ceiling on what can be safely automated. This compounding only works if the exploration is structured: clear processes, clear trust levels, clear iteration paths.[^1]

## The Convergence Timeline

The book was written during a period of unusual convergence. Standards, regulations, and infrastructure are all moving on agent governance simultaneously:

- **January 2026:** Singapore's IMDA launches the world's first agentic AI governance framework at WEF Davos, with four dimensions mapping directly to the PAC pillars.
- **March 2026:** White House releases national cybersecurity strategy with Pillar 5 explicitly naming agentic AI as a strategic priority: the first national strategy globally to do so. Mastercard and Google open-source Verifiable Intent with committed partners (Fiserv, IBM, Checkout.com, Basis Theory, Getnet) and a reference implementation at verifiableintent.dev: the first production-grade answer to the agent authorization gap.[^vi-partners] OpenAI launches Codex Security (March 6), an agentic security scanner that scanned 1.2 million commits across open-source repositories in its first 30 days, identifying 792 critical and 10,561 high-severity vulnerabilities: agents operating at a scale and speed no human security team can match.[^codex-security-edge] Kai emerges from stealth (March 11) with $125 million in funding for the first agentic AI cybersecurity platform, designed to operate autonomously at machine speed across threat intelligence, detection, and response: the largest funding round to date for an agentic AI security company.[^kai-funding] Onyx Security follows the next day (March 12) with $40 million to build what it calls the "Secure AI Control Plane": continuous agent discovery, reasoning-step monitoring, and policy enforcement for autonomous agents across the enterprise.[^onyx-funding] Two stealth-mode companies raising $165 million combined in 48 hours, both targeting agent governance infrastructure, confirms that venture capital sees agent trust as a category, not a feature.
- **March 23-26, 2026:** RSAC 2026 Conference, with agent security as a dominant theme. Five of ten Innovation Sandbox finalists directly address agentic AI security: Token Security (agent identity and lifecycle governance), Geordie AI (agent risk intelligence and governance), Realm Labs (inference-time monitoring that sees inside the agent's reasoning), Humanix (social engineering defense using conversational AI), and Crash Override (supply chain provenance with automated SLSA compliance). Each finalist receives $5 million in investment: $25 million directed at agentic AI security from a single event. Token Security was also named an SC Awards finalist in two categories for its identity-first AI agent security platform.[^rsac-sandbox][^token-sc-awards] The Innovation Sandbox has historically predicted major market categories: past finalists have achieved over 100 acquisitions and raised over $17.8 billion. Half the 2026 class targeting agent security is a market signal, not a coincidence.
- **April 2026:** NIST CAISI hosts sector-specific virtual workshops on barriers to AI agent adoption in healthcare, finance, and education. Participation requires submission by March 20.
- **May 1, 2026:** Microsoft Agent 365 generally available. The first major platform vendor to ship a unified control plane for agent governance: agent registry, shadow agent discovery, unique Agent IDs with lifecycle management, least-privilege access, and audit trails with e-discovery. Priced at $15/user/month standalone or bundled in Microsoft 365 E7 at $99/user/month.[^agent365]
- **April 2, 2026:** NIST comment period closes for the AI Agent Identity and Authorization concept paper. This shapes the U.S. federal approach to agent identity standards.
- **June 2026:** MCP specification update targeting streamable HTTP transport, Tasks primitive refinements, .well-known discovery, and enterprise deployment needs.
- **August 2, 2026:** EU AI Act high-risk AI system obligations take effect. Organizations deploying agents in regulated domains need compliance infrastructure by this date.
- **Late 2026:** AAIF governance structure matures under the Linux Foundation, consolidating MCP, A2A, and related communication protocols under neutral governance.
- **2027:** NIST-EU mutual recognition mechanisms targeting agent governance alignment across jurisdictions.

The window for shaping these standards is narrow. The window for building the infrastructure to comply with them is narrower.

## PAC as Iterative Practice

The PAC Framework is not a one-time assessment. Models improve, protocols land, regulations tighten, internal policies evolve. And your own progress shifts the landscape: the right control infrastructure unlocks new autonomy levels, which open new use cases, which create new blast radius, which demands new accountability.

This is the insight that makes the framework practical: each iteration refines your position across all three pillars simultaneously. Consider how a single agent deployment evolves through the framework:

**Cycle 1: Discovery.** A shadow agent is found summarizing customer support tickets and drafting responses. It uses the employee's full email credentials. It has no audit trail. Blast radius assessment: B3 (customer-facing output, exposed). Current autonomy: effectively A4 (delegated, acting without approval) but with no infrastructure to justify that level. The Agent Profiler surfaces the gap: the agent's infrastructure is I1 (open) while its de facto autonomy requires I3+ (verified). Action: register the agent, scope its email access to the support inbox, add logging.

**Cycle 2: Governance.** The same agent now has its own identity, scoped permissions, and audit trails. Reliability measurement begins: 94% accuracy on routine tickets, but drops to 71% on escalation-path tickets. Governance threshold for B3 output is 95%+. Action: restrict the agent to routine tickets (A2: draft-then-approve) and escalate complex tickets to a human. This is not a demotion. It is the right autonomy level for the measured reliability at this blast radius.

**Cycle 3: Expansion.** Three months later, the model has improved. Reliability on routine tickets is now 98%. The team has built a context pipeline that feeds the agent relevant customer history and product documentation. Reliability on escalation-path tickets has risen to 89%. Action: move routine tickets to A3 (oversight: agent acts, human reviews a sample) and keep escalation tickets at A2. Infrastructure upgrades to I3 (verified) with behavioral monitoring.

**Cycle 4: Architecture.** The support agent now handles tickets that involve partner organizations. Cross-organizational trust infrastructure (TSP, VCs) is deployed. The agent can verify partner agent identities and pass scoped authority for specific resolution actions. New use cases emerge that were impossible in Cycle 1: automated warranty processing across the supply chain, coordinated incident response with vendor agents. Each new use case creates new blast radius, which triggers a new assessment.

The feedback loop is the point. Every cycle teaches the organization something about both the agent and its own governance capability. The governance muscle built on the support agent transfers directly to the next agent deployment: the registry exists, the permission model is established, the evaluation pipeline is running, the team knows how to assess blast radius. That institutional learning is what compounds.

The Agent Profiler at trustedagentic.ai provides a concrete way to track how positions shift across iterations. The PAC Framework chapter's 19 Questions serve as the reassessment protocol: the same questions, asked again, with different answers each cycle. But the discipline is more important than the tool. Re-assess regularly, because the landscape will not hold still.[^iterative]

## The Edge That Compounds

The inferential edge is not static. It compounds.

Every agent you govern teaches your organization how to govern the next one. Every trust boundary you establish makes the next boundary easier to define. Every audit trail you build makes the next regulatory conversation simpler. Every process you redesign around human-agent collaboration creates capacity for the next redesign.

The organization that starts building trust infrastructure today has months of operational learning, governance muscle, and infrastructure maturity by the time a competitor begins evaluating tools. That gap is not about features or data. It is about readiness. And readiness cannot be bought off the shelf.[^1]

The intelligence is rapidly becoming commodity. The edge is the infrastructure to unleash it.

---

[^1]: Shane Deconinck, "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge," shanedeconinck.be, March 2026.
[^2]: Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control," gravitee.io, 2026.
[^3]: Microsoft Security Blog, "80% of Fortune 500 use active AI Agents: Observability, governance, and security shape the new frontier," February 2026.
[^4]: Gartner, reported in Gravitee State of AI Agent Security 2026.
[^forrester-prediction]: Forrester, "Predictions 2026: Cybersecurity And Risk Leaders Grapple With New Tech And Geopolitical Threats," forrester.com, 2025. Predicts the first public agentic AI breach with employee dismissals. Paddy Harrington (senior analyst) identifies cascading multi-agent failures as the primary risk mechanism.
[^5]: CYE, "Shadow AI: The Hidden Threat to Enterprise Security," 2025. Noma Security, "State of Shadow AI," 2025.
[^6]: PAC Framework, trustedagentic.ai, 2026. Question A1: "Do you know every agent running in your organisation?"
[^7]: NIST NCCoE, "Accelerating the Adoption of Software and AI Agent Identity and Authorization," concept paper, February 2026. Comment period closes April 2, 2026.
[^8]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," shanedeconinck.be, February 2026.
[^9]: Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," shanedeconinck.be, March 2026. Nicola Gallo, PIC Protocol.
[^10]: Galileo AI, multi-agent system failure research, December 2025.
[^11]: BlueRock Security, MCP fURI vulnerability research, 2026.
[^12]: Adversa AI, "Top MCP Security Resources: March 2026," adversa.ai, March 2026.
[^13]: Reported across multiple enterprise AI transformation studies, 2025-2026. See also Deloitte Tech Trends 2026.
[^14]: Deloitte, "The agentic reality check: Preparing for a silicon-based workforce," Tech Trends 2026.
[^15]: Shane Deconinck, "The Work That's Leaving," shanedeconinck.be, February 2026.
[^agent365]: Microsoft, "Secure agentic AI for your Frontier Transformation," Microsoft Security Blog, March 9, 2026. Microsoft, "Microsoft Agent 365: The Control Plane for AI Agents," microsoft.com, 2026.
[^policy-arch]: PAC Framework, trustedagentic.ai, 2026. Control pillar: "Policy says 'don't.' Architecture says 'can't.' The difference matters when agents act autonomously."
[^eval-gap]: AI Infrastructure Alliance and LangChain, "State of AI Agents," 2025-2026. Offline evaluation: 52% adoption. Online/post-deployment monitoring: 37%.
[^durability]: PAC Framework, trustedagentic.ai, 2026. Potential pillar: "Durability: build on what stays stable. Not on what changes every quarter." Question P2: "Will better models make your current setup more valuable, or obsolete?"
[^vi-partners]: Mastercard, "How Verifiable Intent builds trust in agentic AI commerce," mastercard.com, March 2026. Committed partners: Google, Fiserv, IBM, Checkout.com, Basis Theory, Getnet. Open-source specification and reference implementation at verifiableintent.dev.
[^rsac-sandbox]: RSAC, "Finalists Announced for RSAC Innovation Sandbox Contest 2026," prnewswire.com, February 2026. Full finalist list: Charm Security, Clearly AI, Crash Override, Fig Security, Geordie AI, Glide Identity, Humanix, Realm Labs, Token Security, ZeroPath. Each finalist receives a $5 million investment. Past finalists include over 100 acquisitions and $17.8 billion in total funding.
[^token-sc-awards]: Token Security, "Token Security Named Finalist in Two Categories of the 2026 SC Awards," globenewswire.com, March 4, 2026. Categories: Best Identity Security Solution and Best AI Security Solution.
[^iterative]: PAC Framework, trustedagentic.ai, 2026. "It's Iterative" section: "This isn't a one-time assessment. It's a living practice."
[^codex-security-edge]: OpenAI, "Codex Security: now in research preview," openai.com, March 6, 2026. Scanned 1.2 million commits across external repositories in 30 days. 792 critical findings, 10,561 high-severity findings across OpenSSH, GnuTLS, PHP, Chromium, and other open-source projects.
[^kai-funding]: Kai, "Kai Emerges from Stealth with $125M, Powering Machine-Speed Defense to Outpace AI-Enabled Adversaries," prnewswire.com, March 10, 2026. Led by Evolution Equity Partners. Founded by Galina Antova (co-founder of Claroty, the $3B industrial cybersecurity leader) and Dr. Damiano Bolzoni (co-founder of SecurityMatters/Forescout).
[^onyx-funding]: Onyx Security, "Onyx Security Launches with $40M in Funding to Build the Secure AI Control Plane for the Agentic Era," businesswire.com, March 12, 2026. Backed by Conviction and Cyberstarts. 70+ employees, already engaged with Fortune 500 customers.
[^cisco-edge]: Cisco, "State of AI Security 2026," cisco.com, 2026. 83% of organizations plan agentic AI deployment; only 29% feel ready to do so securely.
[^kiro-edge]: Financial Times, reported February 20, 2026; Amazon response at aboutamazon.com, February 21, 2026. Amazon Kiro deleted a production AWS Cost Explorer environment, causing a 13-hour outage. The agent inherited the deploying engineer's elevated permissions, bypassing the two-person approval policy.
