# Building the Inferential Edge

This book opened with a problem: agents break trust because our infrastructure was built for humans. It introduced a framework: Potential, Accountability, Control. Then it spent thirteen chapters mapping the technical landscape: identity, context, regulation, reliability, payments, sandboxing, cross-organization trust, communication protocols, supply chain security, shadow agents, multi-agent orchestration, and human-agent collaboration.

Now the question is: what do you actually build first?

## The Gap

Shane calls it the inferential edge: the gap between having access to a powerful model and being able to use it safely, at scale, inside an organization.[^1] That gap is wide, and it is not about model capability. Intelligence is commodity. Any business can access frontier models through an API call. Open-weight alternatives are closing the gap on standard benchmarks. The barrier to building an agent has never been lower.

But 88% of organizations report confirmed or suspected security incidents involving AI agents.[^2] Only 14.4% have full security approval for their agent deployments.[^2] More than half of all agents operate without any security oversight or logging.[^3] Gartner projects over 1,000 legal claims for AI agent harm by the end of 2026.[^4]

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
- *Sandboxing.* Filesystem isolation, network restrictions, configuration file protection. The execution security chapter covers the full isolation spectrum from native OS sandboxing to microVMs. This is not optional for any agent that touches production systems.

**Phase 3: Governance (I3 to I4).** Enforcement contains individual agents. Governance manages the system:

- *Delegation chains.* When agents delegate to other agents, authority must only decrease. Delegation Capability Tokens (macaroons, biscuits) encode this cryptographically. PIC provides authority continuity without token-based possession.[^9] Galileo's research shows 87% downstream decision poisoning within four hours from a single compromised agent in a delegation chain.[^10] Cascading failure prevention is not an optimization: it is a requirement.
- *Supply chain verification.* Every tool, plugin, and MCP server your agents use is an attack surface. 36.7% of 7,000 scanned MCP servers are vulnerable to SSRF.[^11] 30 CVEs have been filed against MCP infrastructure in just 60 days.[^12] AI-BOMs, behavioral monitoring, and runtime verification are the defense layers.
- *Regulatory alignment.* The EU AI Act's high-risk obligations take effect August 2, 2026. NIST's AI Agent Standards Initiative is actively seeking input. Map your agents against regulatory classification requirements now. The regulatory landscape chapter provides the PAC-to-regulation mapping.

**Phase 4: Architecture (I4 to I5).** The infrastructure becomes the fabric:

- *Cross-organizational trust.* TSP for identity verification across boundaries. PIC for authority propagation that cannot expand. Verifiable Credentials as the trust carrier. This is where agents stop being internal tools and become participants in multi-party workflows.
- *Agent gateways.* Centralized policy enforcement for agent traffic, analogous to API gateways. Cedar policies, MCP federation, SSO-integrated auth. The communication protocols chapter covers the emerging patterns.
- *Infrastructure-in-the-loop.* Replace sustained human vigilance with structural enforcement. Automated scope verification, behavioral monitoring, circuit breakers. The collaboration patterns chapter provides the design.

This is not a waterfall plan. Each phase builds on the previous one, and most organizations will work on multiple phases simultaneously for different agent deployments. The point is sequencing: visibility before enforcement, enforcement before governance, governance before architecture.

## The Organizational Challenge

The hardest part of building the inferential edge is not technical. Research shows 70% of AI project failures stem from organizational resistance, not technical limitations.[^13] Only 14% of organizations have deployable agentic solutions. Only 11% have agents in production.[^14]

The organizations succeeding share three patterns:

**They redesign processes, not just automate them.** Layering agents onto existing workflows preserves the workflow's limitations. The organizations getting value are asking: if we were designing this process today, knowing agents could handle the predictable parts, what would we build? Shane's observation is precise: the work is not disappearing, it is changing shape.[^15] The human role that lasts is at the root of the intent: defining what should happen, making the calls that require judgment, owning the decisions an agent cannot.

**They treat governance as enablement, not restriction.** The shadow agent governance chapter makes this case: shadow agents prove where value exists. Discovery is simultaneously a governance exercise and a product research exercise. The amnesty model works because it starts from the premise that employees built agents because they saw value, not because they wanted to circumvent policy. Governing those agents properly is what lets them scale.

**They invest in organizational learning.** Every process automated teaches the organization something. Trust infrastructure gets sharper. Context pipelines improve. Teams learn which processes to hand over next and at what autonomy level. Each cycle raises the ceiling on what can be safely automated. This compounding only works if the exploration is structured: clear processes, clear trust levels, clear iteration paths.[^1]

## The Convergence Timeline

The book was written during a period of unusual convergence. Standards, regulations, and infrastructure are all moving on agent governance simultaneously:

- **January 2026:** Singapore's IMDA launches the world's first agentic AI governance framework at WEF Davos, with four dimensions mapping directly to the PAC pillars.
- **March 2026:** White House releases national cybersecurity strategy with Pillar 5 explicitly naming agentic AI as a strategic priority: the first national strategy globally to do so.
- **April 2, 2026:** NIST comment period closes for the AI Agent Identity and Authorization concept paper. This shapes the U.S. federal approach to agent identity standards.
- **June 2026:** MCP specification update targeting streamable HTTP transport, Tasks primitive refinements, .well-known discovery, and enterprise deployment needs.
- **August 2, 2026:** EU AI Act high-risk AI system obligations take effect. Organizations deploying agents in regulated domains need compliance infrastructure by this date.
- **Late 2026:** AAIF governance structure matures under the Linux Foundation, consolidating MCP, A2A, and related communication protocols under neutral governance.
- **2027:** NIST-EU mutual recognition mechanisms targeting agent governance alignment across jurisdictions.

The window for shaping these standards is narrow. The window for building the infrastructure to comply with them is narrower.

## PAC as Iterative Practice

The PAC Framework is not a one-time assessment. Models improve, protocols land, regulations tighten, internal policies evolve. And your own progress shifts the landscape: the right control infrastructure unlocks new autonomy levels, which open new use cases, which create new blast radius, which demands new accountability.

This is the insight that makes the framework practical: each iteration refines your position across all three pillars simultaneously. A shadow agent discovered in one cycle becomes a governed agent in the next. An agent operating at A2 (approve-before-acting) today may qualify for A4 (delegated autonomy) once the right infrastructure is in place. A cross-organizational workflow that was impossible without identity infrastructure becomes feasible after TSP and PIC are deployed.

The Agent Profiler at trustedagentic.ai provides a concrete way to track how your positions shift across iterations. But the discipline is more important than the tool: re-assess regularly, because the landscape will not hold still.

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
