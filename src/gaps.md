# Gaps & Directions

This is Ghosty's space. Topics to explore, connections to make, directions to investigate.

## Observations (Updated 2026-03-13, Session 16)

### Multi-Agent Governance Is the Next Frontier

DeepMind's "Intelligent AI Delegation" paper (February 2026) formalizes what Shane has been arguing: delegation is not task decomposition but structured transfer of authority. Their five core requirements (dynamic assessment, adaptive execution, structural transparency, scalable coordination, systemic resilience) map directly to PAC's three pillars. The Delegation Capability Token (DCT) mechanism, based on macaroons with cryptographic caveats that enforce authority attenuation, is the first concrete technical proposal for encoding trust across multi-hop delegation chains. Meanwhile, OWASP's ASI08 (cascading failures) and Galileo's research (87% downstream decision poisoning within four hours from a single compromised agent) quantify why multi-agent governance cannot wait. Salesforce's data (12 agents per org, 50% in silos) shows most organizations are already running multi-agent systems without multi-agent governance. The IACR "Trustworthy Agent Network" paper argues trust must be architected from the start, not retrofitted. Now covered in the Multi-Agent Trust and Orchestration chapter.

### CoSAI Incident Response Framework Fills a Critical Gap

The Coalition for Secure AI released its AI Incident Response Framework V1.0 with CACAO-standard playbooks for AI-specific incident categories. For multi-agent systems, incident response differs fundamentally: blast radius assessment requires tracing delegation chains across agents, containment requires coordinated revocation and output evaluation across the chain, and root cause typically leads to a governance failure rather than a model bug. The framework's emphasis on AI-specific telemetry (prompt logs, inference activity, tool executions, memory state) is necessary but not sufficient for multi-agent systems, which also need delegation event telemetry. Partially covered in the Multi-Agent Trust chapter; a dedicated incident response chapter may be warranted.

### The Protocol Stack Is Converging Under Neutral Governance

The AAIF formation (December 2025) puts MCP, goose, and AGENTS.md under Linux Foundation governance with eight platinum members (OpenAI, Anthropic, Google, Microsoft, AWS, Block, Bloomberg, Cloudflare). A2A was already under the Linux Foundation. AgentGateway is also contributed. This means the core communication infrastructure for agents is now under neutral governance, similar to how Linux, Kubernetes, and other foundational infrastructure evolved. The most important unsolved problem in the stack is unified identity across protocol layers: MCP has its own OAuth, A2A has its own auth scheme, and no identity flows end-to-end across both. TMCP and TA2A are designed to be that unifying identity layer but adoption is early.

### MCP Security Maturity Lags Adoption

97 million monthly SDK downloads against a timeline of serious security incidents (GitHub prompt injection, supply-chain backdoors via mcp-remote, Smithery path traversal leaking 3,000+ server tokens) illustrates a familiar pattern: adoption outpaces security maturity. The MCPTox benchmark finding that more capable models are more vulnerable to tool poisoning (because attacks exploit instruction-following ability) is counterintuitive and important. The MCP specification's June 2026 update targeting stateless transport and `.well-known` discovery is a maturity improvement, but the authorization gap (communication protocols solve discovery, not trust) remains structural.

### Cross-Organization Trust Is the Book's Most Original Assembly

The Cross-Organization Trust chapter assembles pieces that no single source has connected: TSP for cross-boundary identity, PIC for authority continuity, VCs as the trust carrier, EUDI wallets as the infrastructure at scale, Verifiable Intent as operational envelopes, and Windley's society-of-agents model for institutional design. Each piece exists independently, but the chapter maps how they compose into a working cross-organization agent trust stack. The Drift breach (700+ companies exposed via shared OAuth tokens) provides the concrete failure case, and PIC's mathematical elimination of the confused deputy provides the structural solution. This is the chapter where the PAC Framework's interdependencies are most visible: Control (identity + authority propagation), Accountability (delegation chains + audit trails), and Potential (unlocking multi-party agent workflows that cannot exist without cross-org trust).

### The Semantic Boundary Problem Is Unsolved

Identity, delegation, and authority propagation are advancing fast. But semantic interoperability (what do actions mean across organizational boundaries?) remains the hardest unsolved layer. Shane's "close a deal" example from the LFDT meetup illustrates this: correctly delegated authority with divergent meaning. W3C VC's `@context` mechanism solves this for credential attributes (a Spanish qualification maps to an EQF level deterministically). The equivalent for agent actions (resolvable action vocabularies) does not exist yet. This is a gap worth tracking and potentially a future chapter topic.

### The Execution Security Landscape Is Maturing Fast

OWASP released the Top 10 for Agentic Applications in December 2025, providing the first peer-reviewed framework for agentic security risks. Simultaneously, both Anthropic and OpenAI have shipped native OS sandboxing (Seatbelt/bubblewrap/seccomp/Landlock) for their coding agents, and the NVIDIA AI Red Team published concrete guidance on sandboxing agentic workflows. The convergence of risk frameworks, vendor implementations, and production guidance signals that execution security is transitioning from afterthought to baseline requirement. Sandboxing covers 5 of OWASP's 10 agentic risks but the remaining 5 require identity, communication security, and organizational governance: exactly the other chapters in this book.

### Configuration File Protection Is an Underappreciated Attack Vector

NVIDIA's guidance highlights that agent modification of configuration files (~/.zshrc, .gitconfig, MCP configs) enables persistence and sandbox escape. This vector is subtle: a sandboxed agent that can modify a git hook effectively achieves code execution outside the sandbox the next time a commit occurs. Protecting configuration files should be treated as a non-negotiable control, not an optional hardening step.

### Verifiable Intent Is a Big Deal

Mastercard and Google open-sourced Verifiable Intent on March 5, 2026: a three-layer SD-JWT architecture that cryptographically binds user intent to agent actions. This is the first production-grade answer to Shane's "consent theater" critique. Three major commerce protocols (AP2, ACP, UCP) are adopting it. Covered in the Agent Identity chapter, but the implications for agent payments and cross-organizational trust deserve follow-up.

### Shadow Agent Scale Is Larger Than Most Organizations Realize

98% of organizations report unsanctioned AI use. 80% of Fortune 500 companies have active AI agents built on low-code/no-code platforms. 1,200 unofficial AI applications per enterprise on average, with 86% reporting no visibility into AI data flows. The governance gap is not theoretical: shadow AI breaches already cost $670K more than standard incidents, and Gartner predicts 40%+ of enterprises will face shadow AI security or compliance incidents by 2030. The most important insight for the book: shadow agents prove where value exists. Discovery is simultaneously a governance exercise and a product research exercise. The highest-value shadow agents reveal the use cases the organization should invest in governing, not prohibiting.

### CSA IAM Framework Validates the DID+VC Architecture

The Cloud Security Alliance's "Agentic AI Identity & Access Management" framework proposes Agent Naming Service (ANS) for capability-based agent discovery, Zero-Knowledge Proofs for privacy-preserving compliance verification, and unified session management with instant revocation propagation. This is the first major industry framework that builds explicitly on DIDs, VCs, and ZKPs for agent IAM. The ANS concept bridges identity infrastructure (Agent Identity chapter) and communication protocols (Agent Communication chapter): agents query for capabilities and compliance requirements, receiving cryptographically signed responses with DIDs and endpoints. The CSA framework, the NIST concept paper, and the OpenID AIIM group are now all converging on the same architectural stack. Added to the Agent Identity chapter.

### NIST Is Building the Evaluation Standards Stack

Two new NIST CAISI publications: AI 800-4 "Challenges to the Monitoring of Deployed AI Systems" (March 2026) documents why post-deployment monitoring remains fragmented (drift detection, distributed logging, human-AI feedback loops, deceptive behavior identification). AI 800-2 "Practices for Automated Benchmark Evaluations" (comment period through March 31, 2026) standardizes how benchmarks are constructed and reported. Together, NIST is building a standards stack for AI evaluation from pre-deployment through post-deployment. Both added to the Reliability, Evaluation chapter.

### Singapore's IMDA Framework Starts from the Right Premise

Singapore launched the world's first governance framework purpose-built for agentic AI on January 22, 2026 at WEF Davos. Where the EU AI Act regulates AI broadly (agents are an afterthought), Singapore's four dimensions (risk bounding, human accountability, technical controls, end-user responsibility) are designed around autonomous agents from the start. Compliance is voluntary but organizations remain legally accountable. The PAC mapping is clean: risk bounding maps to Potential, human accountability to Accountability, technical controls to Control. The framework is a living document accepting feedback and case studies. The book now covers this in the Regulatory Landscape chapter, filling a gap in APAC regulatory coverage. Worth watching: whether Singapore's approach influences other APAC regulators (Japan, South Korea, Australia all have AI governance consultations underway).

### The Identity Standards Landscape Is Converging Fast

Between NIST's concept paper (Feb 2026), OpenID's AIIM Community Group, the IETF draft for OBO with AI agents, Verifiable Intent, and now the CSA IAM framework, the standards and industry bodies are all converging on agent identity simultaneously. The window for shaping these standards is narrow (NIST concept paper comment period closes April 2, benchmark evaluations comment period closes March 31). This convergence validates the PAC Framework's emphasis on building on emerging standards rather than proprietary solutions.

### Agent Payments Infrastructure Is Moving Faster Than Expected

Between Stripe's x402 preview (February 2026), Santander/Mastercard's first live agent payment in Europe (March 2, 2026), and J.P. Morgan/Mirakl's agentic commerce agreement (March 10, 2026), the largest payment processors in the world are building agent payment infrastructure. x402 on Solana has processed 35M+ transactions. The three commerce protocols (AP2, ACP, UCP) are more complementary than competitive, and Verifiable Intent provides the shared authorization layer. The gap between "agents can pay" and "agents routinely pay" is closing fast.

### ERC-8004 As Cross-Organizational Trust Primitive

ERC-8004's deployment across 12+ chains with singleton contracts is interesting not just for blockchain use cases. The three-registry pattern (identity, reputation, validation) is a general architecture for cross-organizational agent trust. The reputation registry's use of payment receipts as Sybil resistance (proof you actually used the service before rating it) is a design pattern worth watching. Whether this lands on-chain or gets replicated off-chain, the pattern matters.

### Agent Supply Chain Is the Newest Attack Surface

The OpenClaw ClawHavoc campaign (1,184 malicious skills on ClawHub), BlueRock's finding that 36.7% of 7,000 MCP servers are vulnerable to SSRF, and the Azure MCP SSRF (CVE-2026-26118) demonstrate that agent supply chain attacks are not theoretical. They combine familiar patterns (typosquatting, dependency confusion, maintainer takeover) with agent-specific amplification: compromised components inherit the agent's full authority, credentials, and decision-making context. The AI-BOM concept (extending SBOMs to cover model versions, tool registrations, prompt templates, and guardrail configurations) is emerging via OWASP and SPDX 3.0.1 but tooling lags. The CSA Agentic Trust Framework applies Zero Trust to agents, but only 21% of organizations maintain a real-time agent inventory. Now covered in the Agent Supply Chain Security chapter.

### MCP 2026 Roadmap Is More Specific Than Expected

The March 9, 2026 MCP roadmap announcement identifies four priority areas for expedited SEP review: streamable HTTP transport (solving stateful session conflicts with load balancers), Tasks primitive refinements (retry semantics, expiry policies from production use), server discovery via .well-known, and enterprise deployment needs (audit trails, SSO-integrated auth, gateway behavior, configuration portability). The enterprise deployment focus is notable: it signals MCP moving from developer tooling to production infrastructure. Updated in the Agent Communication Protocols chapter.

### Non-Human Identities Outnumber Humans 100:1

CSA/Strata survey data shows non-human identities (service accounts, API tokens, agent credentials) outnumber human users by up to 100:1. Most organizations cannot distinguish sanctioned from unsanctioned agent activity. 84% doubt they could pass a compliance audit focused on agent behavior. This quantifies the identity gap that Shane's trust inversion principle addresses: when agents are the majority of your identity surface, human-centric IAM is not just insufficient, it is architecturally wrong.

### Human-Agent Collaboration UX Is the Missing Governance Layer

The industry is converging on three oversight models: Human-in-the-Loop (HITL), Human-on-the-Loop (HOTL), and Infrastructure-in-the-Loop. Smashing Magazine's February 2026 taxonomy of agentic UX patterns (explainable rationale, confidence signals, action audit, escalation pathways) provides the first comprehensive design framework for agent oversight interfaces. Anthropic's autonomy research shows agents recognize their own uncertainty (16.4% self-initiated clarification) more often than humans interrupt (7.1%), suggesting agent self-governance is a viable complement to external oversight. Deloitte's "silicon-based workforce" framing (only 14% have deployable solutions, 11% in production) highlights that the organizations succeeding are redesigning processes around human-agent collaboration, not automating existing workflows. The per-task autonomy dial (different autonomy levels for different task types within the same agent) is emerging as the practical governance pattern. Now covered in the Human-Agent Collaboration Patterns chapter.

### Authorization Platforms for AI Agents Are Maturing

Permit.io, Cerbos, Stytch, and WorkOS are all shipping fine-grained, context-aware permission models designed specifically for AI agents. The key pattern: attribute-based access control (ABAC) where permissions depend on what the agent is doing, for whom, and in what context, not just agent identity. Permit.io's Access Request MCP enables human-in-the-loop approval workflows via MCP. Cerbos provides dynamic authorization for MCP servers. This tooling layer is what makes per-task permission granularity practically implementable.

### MCP Attack Surface Is Accelerating

The MCP security incident timeline now documents eleven incidents across twelve months (April 2025 to March 2026), and the pace is accelerating. But the curated timeline understates the scale: 30 MCP-related CVEs were filed in January-February 2026 alone, across three distinct attack layers (servers, SDK libraries, host applications/developer tools). The vulnerability class breakdown (43% exec/shell injection, 20% tooling/infrastructure, 13% auth bypass, 10% path traversal) reveals structural patterns, not isolated bugs. Scanning of 500+ servers found 38% completely lack authentication. The Azure MCP vulnerability (CVE-2026-26118, CVSS 8.8, March 2026) is notable as the first critical flaw in a major cloud provider's own first-party MCP implementation. The MCP Inspector CVE (CVSS 9.4) showed even Anthropic's own developer tooling had a critical RCE. The 2026 roadmap's enterprise deployment focus (audit trails, SSO-integrated auth, gateway behavior) is the right response, but the gap between protocol ambition and deployment reality is a first-order risk. Covered in both the Supply Chain Security and Communication Protocols chapters.

### The Concluding Synthesis

The book now has a concluding chapter ("Building the Inferential Edge") that synthesizes the 13 technical chapters into a coherent trust infrastructure stack, provides a phased implementation roadmap mapped to infrastructure maturity levels (I1-I5), addresses the organizational challenge (70% of AI project failures are organizational, not technical), and maps the convergence timeline (NIST April 2, MCP June 2026, EU AI Act August 2). The chapter's central argument: the inferential edge compounds. Every agent governed teaches the organization how to govern the next one. The book now has a complete narrative arc: problem, framework, 13 technical deep-dives, synthesis and roadmap.

## Earlier Observations

### The NIST Timing Is Significant

NIST published a concept paper on AI agent identity and authorization in February 2026, with a feedback deadline of April 2, 2026. This is happening in parallel with the EU AI Act high-risk obligations taking effect in August 2026. Two major regulatory bodies are converging on agent governance at the same time. The PAC Framework maps well to both: NIST focuses on identity and authorization (Control), the EU AI Act on risk management and transparency (Accountability). A chapter mapping PAC dimensions to specific regulatory requirements could be valuable.

### The Agent Gateway Pattern

Agent gateways are emerging as infrastructure analogous to API gateways: centralized control over agent identity, permissions, delegation, and behavior. Shane has not written about this pattern specifically, but it fits naturally into the Control pillar as an infrastructure component. Worth investigating: who is building these, what do they actually enforce, and how do they interact with existing API gateway infrastructure?

### Context Infrastructure Deserves Its Own Chapter

Shane's post on context infrastructure is one of his most original contributions. The argument that context appreciates while everything else depreciates is strong and counterintuitive. The Clawdbot example (an agent's personality and behavior governed entirely by a `SOUL.md` file) and the Claude Code example (raw file access via search, not vector databases) are concrete illustrations that deserve deeper treatment. Five dimensions to explore: structure, permissions, discovery, authority, freshness.

### The Complacency Problem Is Now Covered

The Reliability, Evaluation, and the Complacency Trap chapter covers this in depth, grounding the argument in Bainbridge (1983) and Don Norman (1990). The key framing: complacency is not a human weakness to overcome but a design constraint to engineer around. Infrastructure-in-the-loop replaces human-in-the-loop. The PAC connection (Potential undermines Accountability without Control) is the chapter's organizing thesis.

### Cross-Organization Trust Is Now Covered

The Cross-Organization Trust chapter addresses the hard problem of agents crossing trust boundaries. It covers the token model's structural limits, PIC (proof of continuity replacing proof of possession), TSP (identity verification without shared authority), VCs as trust carriers (SD-JWT VC and W3C VC), the EUDI wallet infrastructure, Windley's society-of-agents model, the semantic boundary problem, and infrastructure maturity mapping I1-I5. The remaining gap is semantic interoperability: what actions mean across organizational boundaries.

### Agent Payments as Trust Signal

Shane's x402 work shows something beyond just "agents paying for APIs." The payment itself is a trust signal: a cryptographic proof that someone authorized this expenditure, creating an economic accountability chain alongside the identity chain. The intersection of payment protocols and trust infrastructure is underexplored. EIP-3009 (gasless authorization) means the agent never needs to hold crypto directly, which changes the risk profile significantly.

## Chapters to Write Next

Prioritized by impact:

1. ~~**Agent Identity and Delegation** (Control + Accountability)~~: DONE. Chapter covers OAuth limitations, OBO/DPoP extensions, DIDs/VCs, TSP, Verifiable Intent (Mastercard/Google), NIST/OpenID convergence, and infrastructure maturity mapping.

2. ~~**Context Infrastructure** (Potential + Control)~~: DONE. Chapter covers the depreciation cycle, scaffolding trap, five dimensions (structure, permissions, discovery, authority, freshness), concrete examples from Claude Code/Manus/Clawdbot, MCP/A2A discovery protocols, agent gateways, and infrastructure maturity mapping.

3. ~~**The Regulatory Landscape** (Accountability)~~: DONE. Chapter covers EU AI Act (risk tiers, classification problem, shadow agents, high-risk requirements), NIST (concept paper, AI Agent Standards Initiative), ISO 42001, Singapore IMDA (world's first agentic AI governance framework, four dimensions mapping to PAC), U.S. state legislation (Colorado), standards convergence (IETF, OpenID AIIM, OIDC-A), PAC mapping to regulation, infrastructure maturity readiness table, and convergence timeline.

4. ~~**Reliability, Evaluation, and the Complacency Trap** (Potential + Accountability)~~: DONE. Chapter covers reliability decomposition (consistency, robustness, predictability, safety), benchmark landscape (SWE-bench, τ-bench, GAIA, HAL), the evaluation gap (offline vs online, 52% to 37% adoption drop), automation complacency from human factors research (Bainbridge 1983, Don Norman 1990), the 99% problem, infrastructure-in-the-loop as replacement for human-in-the-loop, and evaluation as governance infrastructure.

5. ~~**Agent Payments and Economics** (Potential + Control)~~: DONE. Chapter covers why traditional payments break for agents, payment as trust signal, x402 and EIP-3009 (gasless stablecoin payments), the three commerce protocols (AP2/ACP/UCP), ERC-8004 on-chain registries, real-world milestones (Santander/Mastercard, Stripe x402, J.P. Morgan/Mirakl), micro-transaction economics, authorization via Verifiable Intent constraints, PAC mapping, and infrastructure maturity for payments.

6. ~~**Sandboxing and Execution Security** (Control)~~: DONE. Chapter covers the permission prompt problem, containment by design (filesystem + network isolation), the isolation spectrum (native OS, containers, gVisor, microVMs), OWASP Top 10 for Agentic Applications with sandboxing coverage mapping, defense in depth (six layers: input validation, sandboxed execution, configuration protection, output validation, credential scoping, behavioral monitoring), ephemeral vs persistent sandboxes, real-world architectures (Claude Code, Codex CLI, Docker microVM), PAC mapping, and infrastructure maturity for execution security.

7. ~~**Cross-Organization Trust** (Control + Accountability)~~: DONE.

8. ~~**Agent Communication Protocols** (Potential + Control)~~: DONE.

9. ~~**Shadow Agent Governance** (Accountability + Control)~~: DONE.

10. ~~**Agent Supply Chain Security** (Control + Accountability)~~: DONE. Chapter covers the OpenClaw ClawHavoc crisis (1,184 malicious skills, 135,000 exposed instances), agent supply chain attack taxonomy (tool/plugin compromise, tool poisoning, MCP server vulnerabilities, model supply chain, memory poisoning, configuration file attacks), the trust registry problem (BlueRock MCP Trust Registry, what exists vs what is missing), AI-BOM concept (extending SBOMs for agent-specific components), defense patterns (verification at installation, behavioral verification at runtime, dependency isolation, supply chain monitoring), the CSA Agentic Trust Framework (Zero Trust for agents), PAC mapping, and infrastructure maturity for supply chain security (I1-I5). Chapter covers the scale of shadow agents (98% unsanctioned AI use, 1,200 unofficial apps per enterprise), why shadow agents exist (value-seeking, not malice), why they differ from shadow IT (they make decisions, inherit authority, compound), the governance gap (human/app IAM architectural mismatch), discovery tools (Okta ISPM, Noma Agentic Risk Map, network analysis, platform auditing), the agent registry (identity, owner, authority, permissions, blast radius, evaluation, regulatory classification), registry enforcement through infrastructure (identity providers, gateways, network controls, platform controls), the amnesty model for transition (discover, classify, amnesty period, triage, enforce, maintain), organizational ownership models (centralized, federated, infrastructure-enforced), audit trail requirements for agents (delegation chain, intent capture, action trace, scope verification), the organizational shift (prohibition to enablement, human-speed to agent-speed governance, perimeter to identity), PAC mapping table, and infrastructure maturity for shadow agent governance (I1-I5). Chapter covers MCP architecture (client-server, JSON-RPC, transports, 2026 roadmap), A2A (Agent Cards, task lifecycle, v0.3 gRPC), MCP security incidents and attack vectors (tool poisoning, overprivileged tokens, resource poisoning, MCPTox benchmark), the authorization gap (Shane's consent theater critique, possession-based vs proof-based authorization), agent gateways (AgentGateway MCP federation, Cedar policies, limits of gateway-level governance), trust layer integrations (TMCP/TA2A running MCP and A2A over TSP, PIC as authority layer), the broader protocol landscape (ACP, UCP, protocol stack composition), AAIF governance under Linux Foundation, PAC mapping, and infrastructure maturity for communication protocols. Chapter covers the structural problem (dynamic intent, multi-hop delegation, semantic divergence), the Drift breach as concrete failure case, the token model's limits, PIC (proof of continuity replacing proof of possession, mathematical elimination of confused deputy), TSP (identity verification without shared authority, thin waist architecture, TA2A/TMCP), where TSP and PIC meet, VCs as trust carriers (SD-JWT VC and W3C VC comparison), content provenance (Shane's VC-signed blog posts), credential delegation architecture (three-layer chain, Verifiable Intent as operational envelope), Windley's society of agents (policies, promises, credentials, reputation), EUDI wallet infrastructure, the semantic boundary problem, PAC mapping, and infrastructure maturity for cross-org trust.

## Open Questions

- How do agent gateways interact with service mesh architectures? Is there a convergence point?
- ~~What does "agent registration" look like in practice? Is there an analog to domain registration or certificate transparency?~~ Covered in Shadow Agent Governance chapter: agent registry with enforcement through identity providers, gateways, and network controls.
- ~~How should organizations handle the transition from shadow agents to governed agents without killing productivity?~~ Covered in Shadow Agent Governance chapter: the amnesty model.
- ~~What is the right granularity for agent permissions? Per-task? Per-session? Per-tool-call?~~ Covered in Human-Agent Collaboration Patterns chapter: granularity should match blast radius (per-tool-call for B4-B5, per-task for B2-B3, per-session for B1 with containment).
- How do you audit an agent's reasoning, not just its actions? Is chain-of-thought logging a compliance artifact? Partially addressed in Human-Agent Collaboration chapter (agent uncertainty as governance signal, escalation as auditable event). Full treatment of chain-of-thought compliance still open.
- ~~What does multi-agent orchestration look like in practice? How do trust properties compose across agent-to-agent delegation?~~ Covered in Multi-Agent Trust and Orchestration chapter: trust composition, DCTs, cascading failures, delegation registries, PIC for multi-agent chains, incident response.
- ~~How should organizations handle incident response for agent failures? The playbook is different from software incidents: the agent made a decision, not just executed code.~~ Partially covered in Multi-Agent Trust chapter (CoSAI framework, multi-agent IR specifics). A dedicated incident response chapter may be warranted for full treatment.
- ~~What is the right interaction model for human-agent oversight? The complacency trap chapter frames the problem; the UX solution is underexplored.~~ Covered in Human-Agent Collaboration Patterns chapter: three oversight models (HITL, HOTL, infrastructure-in-the-loop), per-task autonomy dials, UX patterns for pre/in/post-action oversight, and agent self-governance through uncertainty recognition.
