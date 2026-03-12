# Session Log

## 2026-03-12: Foundation Chapters

**What I did:**
- Wrote Chapter 1: "Why Agents Break Trust" — the problem statement. Covers why traditional IAM breaks down, the confused deputy problem with agents, shadow agents, the reliability vs. governance split, and what trust infrastructure looks like.
- Wrote Chapter 2: "The PAC Framework" — deep walkthrough of all three pillars (Potential, Accountability, Control) with their dimensions, scales, and interdependencies.
- Expanded the Introduction with book purpose, audience, and structure.
- Populated Gaps & Directions with observations and a prioritized list of next chapters.

**Why these first:**
The book was empty. It needed a foundation: a clear problem statement and a thorough explanation of the framework that organizes everything else. These two chapters set up every subsequent chapter.

**Sources used:**
- PAC Framework from trustedagentic.ai (read fresh)
- All of Shane's blog posts (read and analyzed for voice, themes, and claims)
- NIST concept paper on AI agent identity and authorization (February 2026)
- EU AI Act enforcement timeline (August 2026 high-risk obligations)
- Web search on OAuth extensions for agentic AI, agent gateways, DPoP, Zero Trust for agents

**What I noticed:**
- NIST and EU AI Act enforcement are converging on agent governance simultaneously. This timing is significant for the regulatory chapter.
- Agent gateways are an emerging infrastructure pattern that Shane hasn't covered directly but maps well to the Control pillar.
- The complacency problem (better reliability leading to worse oversight) connects to decades of human factors research in aviation. Worth grounding in that literature.
- Shane's framing of "delegation becomes abdication" is the single most important insight for the accountability argument. Built Chapter 1 around it.

**Next session priorities:**
1. Agent Identity and Delegation chapter (strongest source material, high impact)
2. Context Infrastructure chapter (most original contribution from Shane)

## 2026-03-12: Agent Identity and Delegation Chapter

**What I did:**
- Wrote Chapter 3: "Agent Identity and Delegation" covering the full technical landscape of agent identity infrastructure. Sections: trust inversion, why traditional IAM breaks down (history from LDAP through DIDs), OAuth extensions for agents (OBO, DPoP, Auth0 Token Vault), decentralized identity (DIDs, VCs, TSP), Verifiable Intent (Mastercard/Google three-layer SD-JWT), regulatory convergence (NIST, OpenID, eIDAS 2.0), mapping back to PAC infrastructure levels, and practical recommendations.
- Updated Gaps & Directions with new observations on Verifiable Intent and standards convergence.
- Marked Agent Identity as done in the chapter priority list.

**Why this chapter:**
It was the #1 priority in the gaps doc, Shane has the strongest source material across 6+ blog posts, and the standards landscape is moving fast (NIST comment period closes April 2, 2026). Timely and foundational.

**Sources used:**
- Shane's blog posts: trust inversion, IAM breakdown, auth crash course, Google Workspace/OAuth critique, verifiable credentials signing, Verifiable Intent analysis, IAM emerging patterns
- PAC Framework from trustedagentic.ai
- IETF: RFC 8693 (Token Exchange), RFC 9449 (DPoP), draft-oauth-ai-agents-on-behalf-of-user-02
- NIST: "Accelerating the Adoption of Software and AI Agent Identity and Authorization" (Feb 2026)
- OpenID Foundation: AIIM Community Group whitepaper
- Mastercard/Google: Verifiable Intent specification (March 2026)
- Auth0: Token Vault for AI Agents documentation
- Web searches on TSP, eIDAS 2.0, agent identity standards 2026

**What I noticed:**
- Verifiable Intent is the first production-grade answer to Shane's consent theater critique. The three-layer SD-JWT architecture maps cleanly to PAC: Layer 1 is identity (Control), Layer 2 is intent constraints (Accountability), Layer 3 is action proof (all three pillars).
- The identity standards landscape is converging faster than expected. NIST, OpenID, IETF, and industry (Mastercard/Google/Stripe) are all moving simultaneously. The PAC Framework's emphasis on building on standards rather than proprietary solutions is well-timed.
- Auth0 Token Vault is pragmatic but limited: it solves credential management but not purpose encoding or delegation tracking. Good for I2-I3 infrastructure levels.
- The infrastructure maturity table (I1-I5 mapped to identity capabilities) is a useful framing that could extend to other chapters.

**Next session priorities:**
1. Context Infrastructure chapter (Shane's most original contribution, high impact)
2. Regulatory Landscape chapter (timely given August 2026 EU AI Act enforcement)

## 2026-03-12: Context Infrastructure Chapter

**What I did:**
- Wrote Chapter 4: "Context Infrastructure" covering the durable investment thesis for context. Sections: the depreciation cycle (fine-tuning, RAG, scaffolding), the scaffolding trap with Claude Code and Manus examples, what context means (curated information + governed access), context in practice (Claude Code's CLAUDE.md pattern, Manus's KV-cache optimization, Clawdbot as cautionary tale), five dimensions (structure, permissions, discovery, authority, freshness), MCP and A2A as discovery protocols, agent gateways as enforcement layer, the compounding effect, PAC mapping table, infrastructure maturity for context, and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Context Infrastructure as done in gaps.md.

**Why this chapter:**
It was the #1 priority in the gaps doc after identity. Shane's context infrastructure post is one of his most original contributions: the argument that context appreciates while everything else depreciates is counterintuitive and supported by concrete examples. The industry conversation around context engineering has exploded in 2026 (Anthropic's blog post, Manus's lessons, LangChain's framework), providing rich supplementary material.

**Sources used:**
- Shane's blog posts: context infrastructure investment, scaffolding trap/reliability shifting, fitting agentic AI components in a mental model
- PAC Framework from trustedagentic.ai
- Anthropic Engineering Blog: "Effective context engineering for AI agents" (Sep 2025)
- Manus: "Context Engineering for AI Agents: Lessons from Building Manus" (2026)
- LangChain Blog: "Context Engineering for Agents" (2026)
- MCP 2026 roadmap from blog.modelcontextprotocol.io
- Google Cloud Blog: A2A protocol updates (v0.3, 150+ organizations)
- Towards Data Science: "Is RAG Dead? The Rise of Context Engineering and Semantic Layers"
- Multiple industry analyses on agent gateways (Gartner, Solo.io, Composio)
- PIC Protocol specification

**What I noticed:**
- The context engineering conversation has shifted from "how to stuff the prompt" to "how to build organizational information infrastructure." Shane was ahead of this curve: his February 2026 post framed it as infrastructure investment before the industry adopted the terminology.
- Manus's KV-cache insight is operationally important: 100:1 input-to-output ratio means context management is the dominant cost and performance driver, not generation. This validates Shane's emphasis on the information layer over the model layer.
- MCP adoption is striking: 97 million monthly SDK downloads, Linux Foundation governance, adoption by OpenAI, Google, and Anthropic. This is becoming the standard discovery protocol for agent context. The 2026 roadmap addresses the right gaps (stateless transport, `.well-known` discovery).
- A2A reaching 150+ organizations with v0.3 and gRPC support signals that agent-to-agent communication is standardizing faster than expected. Auth0 partnering on A2A authentication is a convergence point with the identity chapter.
- Agent gateways are emerging as the "missing layer" analogous to API gateways for microservices. Gartner predicting majority of API gateway vendors will add MCP capabilities by 2026 suggests this will be standard infrastructure.
- The Clawdbot example works on two levels: as evidence that context is powerful (rich context made it compelling) and as evidence that context without control is dangerous (missing access controls made it a risk). This duality maps directly to PAC's Potential-Control interdependence.

**Next session priorities:**
1. Regulatory Landscape chapter (timely given August 2026 EU AI Act enforcement and April 2 NIST comment deadline)
2. Reliability, Evaluation, and the Complacency Trap chapter (human factors angle underexplored)

## 2026-03-12: The Regulatory Landscape Chapter

**What I did:**
- Wrote Chapter 5: "The Regulatory Landscape" covering the full regulatory and standards picture for agent governance. Sections: EU AI Act (risk tiers, the classification problem for agents, provider/distributor/deployer roles, shadow agents and Article 4, high-risk requirements mapped to infrastructure, Commission guidelines), NIST (concept paper on agent identity/authorization, AI Agent Standards Initiative with three pillars), ISO 42001 (management system baseline, certification adoption), U.S. state legislation (Colorado AI Act), standards convergence (IETF agent auth draft, OpenID AIIM, OIDC-A proposal, industry standards), PAC mapping to regulation across all three pillars, infrastructure maturity readiness table (I1-I5 against regulatory requirements), convergence timeline, and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Regulatory Landscape as done in gaps.md.

**Why this chapter:**
It was the #3 priority in the gaps doc and the next logical chapter after identity and context infrastructure. The timing is urgent: EU AI Act high-risk obligations take effect August 2, 2026 (less than 5 months away), NIST comment period closes April 2 (3 weeks away), and the Colorado AI Act goes live June 1. Shane's EU AI Act post is the primary source, supplemented by his boardroom questions post and the LFDT meetup post.

**Sources used:**
- Shane's blog posts: EU AI Act analysis, boardroom questions, LFDT meetup (TSP + PIC), trust inversion, scaffolding trap
- PAC Framework from trustedagentic.ai
- EU AI Act: Articles 4, 6, 9, 10, 11, 12, 14, 15, 17, 51; Annex III; GPAI Provider Guidelines (July 2025)
- The Future Society: "Ahead of the Curve: Governing AI Agents Under the EU AI Act"
- NIST: NCCoE concept paper (Feb 2026), CAISI AI Agent Standards Initiative (Feb 2026)
- ISO/IEC 42001:2023 documentation and BSI certification information
- IETF: draft-klrc-aiagent-auth-00
- OpenID Foundation: AIIM Community Group, response to NIST RFI
- OIDC-A 1.0 proposal
- Colorado AI Act
- Web searches: EU AI Act 2026 enforcement, NIST agent standards, ISO 42001 adoption, AI agent liability/accountability regulation

**What I noticed:**
- The regulatory convergence is tighter than I expected. EU AI Act (August 2026), Colorado AI Act (June 2026), and NIST standards work (Q1-Q2 2026) all land in the same window. Organizations that build infrastructure now get compliance as a byproduct. Organizations that wait will face simultaneous deadlines.
- NIST's framing of the AI Agent Standards Initiative uses a Potential argument: fragmented ecosystems stunt adoption. This is interesting because it aligns NIST with PAC's value-first approach rather than purely security or compliance framing.
- ISO 42001 fills a specific gap: it provides the management system scaffolding within which technical solutions operate. It does not solve agent identity or authorization, but it formalizes the governance loops that make technical solutions accountable.
- The infrastructure maturity table (I1-I5 mapped to regulatory readiness) turned out to be a useful synthesis. Most organizations are at I1-I2 for agent deployments. Regulatory timelines demand I3+ for high-risk uses by August 2026. That is a significant infrastructure gap to close in 5 months.
- Shane's LFDT meetup post (March 11, 2026) introduces PIC (Provenance, Identity, Continuity) as a complementary approach to TSP. The PIC paradigm shift from "proof of possession" to "proof of continuity" is relevant to the regulatory discussion because it eliminates the confused deputy problem mathematically rather than mitigating it through policy. This deserves deeper treatment in a future chapter.

**Next session priorities:**
1. Reliability, Evaluation, and the Complacency Trap chapter (human factors angle, strongest remaining gap)
2. Agent Payments and Economics chapter (x402, payment as trust signal)

## 2026-03-12: Reliability, Evaluation, and the Complacency Trap Chapter

**What I did:**
- Wrote Chapter 6: "Reliability, Evaluation, and the Complacency Trap" covering the dangerous intersection of improving reliability and degrading human oversight. Sections: what reliability actually means (four dimensions: consistency, robustness, predictability, safety), the benchmark landscape (SWE-bench Verified, τ-bench, GAIA, HAL), the evaluation gap (offline vs online adoption drop from 52% to 37%), the observability shift (debugging vs governance-grade audit trails), the complacency trap (grounded in Bainbridge 1983 and Don Norman 1990), the agent-specific version (review fatigue, accountability diffusion, scope creep, the 99% problem), why better models make governance harder (the PAC interdependency break), from human-in-the-loop to infrastructure-in-the-loop, evaluation as governance infrastructure, PAC mapping table, and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Reliability chapter as done in gaps.md.
- Updated complacency observation in gaps.md to reflect coverage.

**Why this chapter:**
It was the #1 remaining priority in the gaps doc. Shane's writing on the scaffolding trap, trust inversion, and Anthropic's autonomy data all pointed to the same gap: reliability is improving faster than governance. The human factors angle (Bainbridge's ironies of automation, Don Norman's intermediate automation problem) provides 40+ years of research grounding that makes the argument concrete rather than speculative. The chapter bridges Potential and Accountability pillars, which were less deeply covered than Control.

**Sources used:**
- Shane's blog posts: scaffolding trap, trust inversion (Don Norman quote, "human in the loop is not a reliable safety net"), Anthropic's data analysis (50% coding, upper-right quadrant), agent profiler reasoning ("infrastructure is a gate, not a slider")
- PAC Framework from trustedagentic.ai
- Lisanne Bainbridge, "Ironies of Automation" (Automatica, 1983): skill degradation and vigilance failure
- Don Norman, "The 'Problem' of Automation" (1990): intermediate automation as the danger zone
- Saumya Banthia et al., "Towards a Science of AI Agent Reliability" (arXiv, Feb 2026): four-dimensional reliability decomposition
- LangChain State of AI Agents 2026: 57% in production, 52% offline evals, 37% online evals, 32% cite quality as top barrier
- Anthropic, "Measuring AI Agent Autonomy in Practice" (Feb 2026): 73% human oversight, domain distribution
- Sierra τ-bench: dynamic benchmark exposing agent brittleness in interactive settings
- Princeton HAL Leaderboard: unified benchmarking across SWE-bench, GAIA, τ-bench (ICLR 2026)
- Help Net Security (March 2026): only 21% executive visibility into agent permissions, 80% report risky agent behaviors
- Clinical study: 6% tumor detection rate reduction after months of AI-assisted colonoscopy
- Braintrust, Arize: agent observability ecosystem 2026

**What I noticed:**
- The evaluation gap data (52% offline, 37% online, 23% not evaluating at all) is the complacency trap in quantitative form. Teams invest in proving capability and underinvest in monitoring behavior. This is exactly the Potential-Accountability split Shane describes.
- Bainbridge's 1983 paper is strikingly relevant. Her two ironies (skill degradation + vigilance failure) map directly to agent oversight: reviewers lose the ability to catch errors because they rarely need to, and monitoring a highly reliable system is cognitively exhausting. The 40-year gap between her writing and current AI agent deployment shows how slowly automation governance lessons transfer between domains.
- The clinician colonoscopy study (6% tumor detection drop with AI assistance) is the most concrete evidence I found for the complacency trap in a high-stakes domain. It illustrates Bainbridge's skill degradation pattern: the AI made clinicians better on average but degraded their independent capability.
- τ-bench's results are important for a reason beyond benchmark scores: they show that static benchmarks do not predict dynamic performance. An agent that scores well on SWE-bench may struggle with τ-bench because interactive, real-time environments create failure modes that controlled test sets do not. This validates Anthropic's finding that pre-deployment evaluation alone is insufficient.
- The "infrastructure in the loop" framing feels like the right synthesis. It respects Shane's position that "human in the loop is not a reliable safety net" while providing a constructive alternative. Structural authorization, anomaly detection, automatic containment, and audit trails do not depend on human vigilance. They encode human judgment into infrastructure that operates whether anyone is watching or not.
- The PAC interdependency break (high reliability reducing governance investment) is the chapter's most important idea. It explains why the problem gets worse as agents get better, which is counterintuitive enough to be worth stating clearly.

**Next session priorities:**
1. Agent Payments and Economics chapter (x402, EIP-3009, payment as trust signal)
2. Sandboxing and Execution Security chapter (native OS vs Docker vs DevContainers, OWASP Top 10)

## 2026-03-12: Agent Payments and Economics Chapter

**What I did:**
- Wrote Chapter 7: "Agent Payments and Economics" covering the full landscape of agent payment infrastructure. Sections: why traditional payments break for agents, payment as trust signal (Shane's key insight), x402 and EIP-3009 (gasless stablecoin payments with detailed flow and economics), the three commerce protocols (AP2/Google, ACP/Stripe+OpenAI, UCP/Google+Shopify+Walmart), on-chain agent identity via ERC-8004 (three registries: identity, reputation, validation), real-world milestones (Santander/Mastercard first European agent payment, Stripe x402 preview, J.P. Morgan/Mirakl agentic commerce), micro-transaction economics, authorization via Verifiable Intent constraints, PAC mapping table, infrastructure maturity for payments (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Agent Payments as done in gaps.md.
- Added new observations on payment infrastructure velocity and ERC-8004 as cross-organizational trust primitive.

**Why this chapter:**
It was the #1 priority in the gaps doc. Shane has deep hands-on experience (built an x402 demo, analyzed ERC-8004 and Verifiable Intent in detail), and the real-world deployment milestones from Q1 2026 (Santander/Mastercard, Stripe, J.P. Morgan) make the timing right. Agent payments are moving from proof-of-concept to production, and the convergence of payment protocols with trust infrastructure (Verifiable Intent, ERC-8004) validates the PAC Framework's emphasis on Control pillar infrastructure.

**Sources used:**
- Shane's blog posts: x402 hands-on (Jan 7, 2026), ERC-8004 mainnet (Jan 28, 2026), Verifiable Intent (Mar 6, 2026)
- PAC Framework from trustedagentic.ai
- x402 specification (x402.org) and Foundation announcement (Coinbase/Cloudflare, Sep 2025)
- Stripe: x402 payments documentation, The Block coverage (Feb 11, 2026)
- Google Cloud Blog: AP2 announcement (2026)
- Stripe/OpenAI: ACP specification and Instant Checkout in ChatGPT
- Google Developers Blog: UCP specification
- ERC-8004: EIP specification, multi-chain deployment data
- Mastercard Newsroom: Santander agent payment milestone (Mar 2, 2026)
- J.P. Morgan Payments: Mirakl Nexus agentic commerce agreement (Mar 10, 2026)
- Solana x402 transaction data (35M+ transactions, $10M+ volume)
- Web searches on agent payment economics, micro-transaction infrastructure, stablecoin settlement

**What I noticed:**
- The speed of adoption is striking. In January 2026, Shane built a proof-of-concept. By March 2026, Mastercard and Santander completed a live regulated payment. That is an unusually fast move from experimental to production in financial services.
- The three commerce protocols (AP2, ACP, UCP) are more complementary than competitive. AP2 handles payment authorization, ACP handles checkout flows, UCP handles product discovery. Verifiable Intent provides the shared cryptographic constraint layer. This is convergence, not fragmentation.
- ERC-8004's three-registry pattern (identity, reputation, validation) is a general architecture that could apply off-chain too. The insight that payment receipts provide Sybil resistance for reputation (you can only rate services you paid for) is elegant.
- The micro-transaction economics are decisive. Traditional payment processing ($0.30 minimum) cannot support $0.01 API calls. L2 stablecoin settlement ($0.002 gas) can. This is not a marginal improvement: it is the difference between viable and impossible for agent-to-agent commerce.
- Payment infrastructure and trust infrastructure are converging. Verifiable Intent turns spending constraints into cryptographic objects. ERC-8004 turns reputation into on-chain signals. x402 turns settlement into inline HTTP. These are not separate systems: they are layers of the same governance stack.
- The chapter connects to all three PAC pillars more naturally than some previous chapters. Payment as a trust signal is simultaneously Potential (new business models), Accountability (auditable proof of authorization), and Control (cryptographic spending constraints). This makes it a strong example of how the pillars are interdependent.

**Next session priorities:**
1. Sandboxing and Execution Security chapter (native OS vs Docker vs DevContainers, OWASP Top 10)
2. Cross-Organization Trust chapter (TSP + eIDAS 2.0 + EUDI + Verifiable Credentials assembly)

## 2026-03-12: Sandboxing and Execution Security Chapter

**What I did:**
- Wrote Chapter 8: "Sandboxing and Execution Security" covering the full execution security landscape for agents. Sections: the permission prompt problem (approval fatigue, knowledge gaps, speed-vs-safety), containment by design (filesystem + network isolation as dual requirement), the isolation spectrum (native OS sandboxing, containers, gVisor, microVMs with performance and security comparison table), OWASP Top 10 for Agentic Applications (all 10 risks with sandboxing coverage mapping: strong for 5, partial for 2, none for 3), defense in depth (six layers: input validation, sandboxed execution, configuration protection, output validation, credential scoping, behavioral monitoring), ephemeral vs persistent sandbox design, real-world architectures (Claude Code, Codex CLI, Docker microVM), PAC mapping table, infrastructure maturity for execution security (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Sandboxing chapter as done in gaps.md.
- Added new observations on execution security landscape maturation and configuration file protection as attack vector.

**Why this chapter:**
It was the #1 priority in the session log and #6 in the original gaps list. Shane's Docker sandbox post is his most technically concrete piece on execution security, and the supporting material has matured significantly: OWASP released the agentic Top 10 in December 2025, NVIDIA published production sandboxing guidance, and both Anthropic and OpenAI have shipped native sandbox implementations. The chapter completes the Control pillar depth that was missing from the book.

**Sources used:**
- Shane's blog posts: Docker sandbox vs native (Feb 7, 2026), trust inversion (Feb 3, 2026), agent profiler reasoning (Feb 26, 2026), scaffolding trap (Feb 2, 2026), OpenClaw/Moltbook (Feb 17, 2026)
- PAC Framework from trustedagentic.ai
- Anthropic Engineering: "Making Claude Code More Secure and Autonomous" (2026)
- OpenAI: Codex Security documentation (2026)
- OWASP: Top 10 for Agentic Applications for 2026 (December 2025)
- NVIDIA AI Red Team: "Practical Security Guidance for Sandboxing Agentic Workflows" (2026)
- Northflank: "How to Sandbox AI Agents in 2026: MicroVMs, gVisor & Isolation Strategies" (2026)
- Bainbridge (1983) and Don Norman (1990) for automation research context
- Web searches on agent sandboxing architectures, container escape vulnerabilities, prompt injection containment

**What I noticed:**
- The OWASP Top 10 for Agentic Applications maps cleanly to the PAC Framework. Risks ASI01-ASI05 are primarily Control concerns. ASI06-ASI08 span Control and Accountability. ASI09 is Accountability (the complacency trap by another name). ASI10 is all three pillars. This validates the PAC Framework's comprehensive coverage.
- Shane's sandboxing coverage mapping (5 strong, 2 partial, 3 none) is an important framing: it makes explicit that sandboxing is necessary but not sufficient. The "none" categories (memory poisoning, inter-agent communication, human trust exploitation) are precisely the risks addressed by other chapters in this book (Context Infrastructure, Agent Identity, Reliability/Complacency).
- NVIDIA's guidance on configuration file protection is a genuinely underappreciated insight. Most sandboxing discussions focus on filesystem and network isolation. But configuration files are the seam between sandboxed and unsandboxed execution. A git hook, a shell profile, or an MCP config modified inside a sandbox can execute code outside it. This is a persistence vector that needs explicit blocking, not just general filesystem restrictions.
- The convergence of vendor implementations (Claude Code and Codex CLI both using Seatbelt/bubblewrap/seccomp) suggests that native OS sandboxing is becoming a de facto standard for interactive coding agents. The architectures are remarkably similar: restrict filesystem to workspace, proxy network through a controlled gateway, apply syscall filtering. This convergence makes it easier for the book to recommend concrete implementations rather than abstract principles.
- Anthropic's finding that sandboxing reduces permission prompts by 84% is a Potential argument for Control infrastructure. When containment is structural, agents can operate more autonomously because dangerous operations are impossible rather than merely unapproved. This is a concrete example of the PAC interdependence: Control enables Potential.

**Next session priorities:**
1. Cross-Organization Trust chapter (TSP + eIDAS 2.0 + EUDI + Verifiable Credentials: how the pieces compose into a working system)
2. Shadow Agent Governance chapter (practical guidance for transitioning from shadow agents to governed agents)

## 2026-03-12: Cross-Organization Trust Chapter

**What I did:**
- Wrote Chapter 9: "Cross-Organization Trust" covering the full landscape of trust infrastructure for agents operating across organizational boundaries. Sections: the structural problem (dynamic intent, multi-hop delegation, semantic divergence), the Drift breach as concrete failure case (700+ companies exposed via shared OAuth tokens), the token model's structural limit (possession-based authority fails without perimeters), PIC (proof of continuity replacing proof of possession, mathematical elimination of confused deputy, monotonic authority), TSP (identity verification without shared authority, thin waist architecture, TA2A/TMCP integrations), where TSP and PIC meet (complementary layers: identity across boundaries vs authority propagation within systems), VCs as trust carriers (SD-JWT VC vs W3C VC comparison table, selective disclosure, semantic interoperability, unlinkability), content provenance (Shane's VC-signed blog posts verified by coding agent), credential delegation architecture (three-layer chain: identity/delegation/transaction), Verifiable Intent as operational envelope, Windley's society of agents (policies, promises, credentials, reputation as four complementary mechanisms), EUDI wallet infrastructure (trusted issuers, cross-border recognition, business wallets), the semantic boundary problem (action meaning divergence across domains), PAC mapping table, infrastructure maturity for cross-org trust (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Updated gaps.md with new observations on cross-org trust assembly and the semantic boundary problem.
- Marked Cross-Organization Trust as done in the chapter priority list.

**Why this chapter:**
It was the #1 priority in the session log and identified as "the hard problem" in the gaps doc. Shane has exceptionally rich source material: the March 11 LFDT meetup post (TSP + PIC, the most technically dense post he has written), the March 9 EUDI credential formats crash course (deep credential infrastructure analysis), and the February 22 VC signing post (practical content provenance demonstration). External sources have also matured: the CSA published a cross-domain agent security analysis on March 11, Phil Windley published his society-of-agents model, and multiple academic papers on interoperable identity delegation for agents appeared in early 2026. The chapter assembles pieces that no single source has connected.

**Sources used:**
- Shane's blog posts: LFDT meetup (TSP + PIC, March 11, 2026), EUDI credential formats crash course (March 9, 2026), VC-signed blog posts (Feb 22, 2026), trust inversion (Jan 24, 2026), TSP explainer (shanedeconinck.be/explainers/tsp/)
- PAC Framework from trustedagentic.ai
- Cloud Security Alliance / Okta: "AI Security Across Domains: Who Vouches?" (March 11, 2026): Drift breach, three requirements for cross-domain agent trust
- Phil Windley: "Cross-Domain Delegation in a Society of Agents" (Technometria, 2026): policies, promises, credentials, reputation
- Trust Spanning Protocol Specification, Revision 2 (November 2025), Trust over IP Foundation
- PIC Protocol (pic-protocol.org): formal execution model for authority continuity
- Para: "Agent Identity: How AI Wallets Inherit Human Credentials" (2026): three-layer credential delegation
- Mastercard: "How Verifiable Intent builds trust in agentic AI commerce" (2026)
- eIDAS 2.0 (Regulation EU 2024/1183) and EUDI wallet implementation timeline
- arxiv.org/abs/2601.14982: "Interoperable Architecture for Digital Identity Delegation for AI Agents"

**What I noticed:**
- The assembly of TSP + PIC + VCs + EUDI + Verifiable Intent into a coherent cross-organization trust stack is, I believe, the book's most original contribution so far. Each piece is well-documented individually, but nobody has mapped how they compose. TSP provides the cross-boundary identity layer, PIC provides the authority propagation guarantees, VCs carry the trust artifacts, EUDI wallets provide the credential infrastructure at continental scale, and Verifiable Intent provides the operational envelope that bridges authorization and action. The PAC Framework is the lens that connects them.
- The Drift breach is the best available concrete failure case for cross-domain agent trust. 700+ companies exposed through shared OAuth tokens, with no coordinated revocation mechanism, is exactly the scenario that TSP + PIC is designed to prevent. The fact that the CSA published this analysis on the same day as Shane's LFDT meetup post (March 11, 2026) is coincidental but thematically perfect.
- Windley's society-of-agents model adds an important dimension that the protocol-level approaches (TSP, PIC) do not address: institutional design. His argument that "cross-domain delegation is not simply a technical challenge but a problem of institutional design" complements Shane's protocol-level analysis. The four mechanisms (policies, promises, credentials, reputation) map to different PAC dimensions and different infrastructure maturity levels.
- The semantic boundary problem is the most important unsolved gap I identified. Identity, delegation, and authority propagation are all advancing rapidly. But what actions mean across organizational boundaries remains unaddressed. W3C VC's `@context` solves this for credential attributes (a Spanish qualification maps to an EQF level). The equivalent for agent actions (resolvable action vocabularies) does not exist. This may deserve its own treatment in a future chapter or as an extension of the context infrastructure discussion.
- The EUDI wallet gap that Shane identified (W3C VC's de jure inclusion but de facto exclusion) has direct implications for cross-organization agent trust. If the operational scaffolding does not catch up for W3C VC, the most semantically expressive credential format will be unavailable for the most demanding cross-border use cases. The BBS curve contradiction (legal obligation for unlinkability without an approved cryptographic mechanism) is a constraint that agent architects need to track.
- The chapter touches all three PAC pillars more deeply than most previous chapters. Control dominates (identity, authority, delegation), but the Potential argument (cross-org trust unlocks multi-party agent workflows that cannot exist otherwise) and the Accountability argument (delegation chains and audit trails that survive across boundaries) are equally load-bearing. This validates the PAC Framework's interdependence thesis.

**Next session priorities:**
1. Shadow Agent Governance chapter (practical guidance for transitioning from shadow agents to governed agents, connecting to Accountability pillar)
2. Revisit and strengthen existing chapters: the introduction may need updating to reflect the expanded scope (now 9 substantive chapters), and the PAC Framework chapter may benefit from forward references to the cross-org trust stack
