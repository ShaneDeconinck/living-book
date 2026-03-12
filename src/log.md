# Session Log

## 2026-03-12: Initial book structure and first two chapters

**What I did:**
- Restructured the book from a single intro page into four sections: The Problem, What's Being Built, Open Questions, and the session log
- Wrote "When Agents Create Intent": the core thesis chapter covering delegation vs abdication, the trust inversion, and why reliability isn't governance
- Wrote "The Protocol Landscape": mapping OAuth extensions (OBO, IETF drafts, AAuth, OIDC-A), cross-domain trust (DIDs, VCs, TSP), MCP security concerns, Verifiable Intent, PIC, and institutional efforts (NIST, OpenID AIIM)
- Created the Gaps chapter with observations on agent provenance, multi-hop delegation, mid-execution compromise, the verification gap outside software engineering, shadow AI, and standards fragmentation
- Expanded the introduction to explain the book's purpose and how it works

**Why these choices:**
The book was essentially empty: just a placeholder intro. The highest-impact work was establishing the core thesis and mapping the protocol landscape, because everything else builds on those two foundations. The field has moved significantly in early 2026: NIST launched a demonstration project and an AI Agent Standards Initiative (February 2026), the OpenID Foundation responded to NIST's RFI (March 2026), Verifiable Intent was open-sourced by Mastercard/Google, OWASP published their Top 10 for Agentic Applications, and multiple IETF drafts are active. All of this needed to be captured while it's current.

**What I'd do next session:**
1. Deep dive chapter on Verifiable Intent with actual JWT structures and transaction flow
2. The context infrastructure argument (training depreciates, context appreciates)
3. Case studies chapter: Clawdbot, GitHub MCP vulnerability, other real incidents
4. The PAC framework chapter

**Sources used:**
- Shane's blog posts: "Trusted AI Agents: Why Traditional IAM Breaks Down" (2026-01-24), "AI Agents Need the Inverse of Human Trust" (2026-02-03)
- Shane's trustedagentic framework (PAC)
- IETF draft-klrc-aiagent-auth-00
- IETF AAuth draft (draft-rosenberg-oauth-aauth-00)
- OpenID OIDC-A paper (arxiv.org/html/2509.25974v1)
- OpenID Foundation AIIM whitepaper and NIST RFI response
- NIST NCCoE concept paper on AI agent identity and authorization (2026-02-05)
- NIST AI Agent Standards Initiative (2026-02)
- OWASP Top 10 for Agentic Applications (2026)
- Mastercard Verifiable Intent announcement and spec
- Unit 42 MCP attack vector research
- Pillar Security, Red Hat, marmelab MCP security analyses

---

## 2026-03-12 (Session 2): PAC Framework chapter and protocol landscape updates

**What I did:**
- Wrote the PAC Framework chapter (src/pac-framework.md): the organizing spine of the book. Covers all three pillars (Potential, Accountability, Control), their interdependence, how existing protocols map to each pillar, and the iterative nature of governance. Connects back to every other chapter.
- Updated the Protocol Landscape chapter with new developments found via web search:
  - Added Agent Authorization Profile (draft-aap-oauth-profile): OAuth 2.0 authorization profile for autonomous agents
  - Added OAuth Scope Aggregation (draft-jia-oauth-scope-aggregation): single authorization for multi-step workflows
  - Added new section on Zero Trust for agents: CSA's Agentic Trust Framework, the CSA/Strata survey (84% can't pass agent compliance audit), Red Hat's zero trust analysis
  - Added AgentGateway to open-source implementations (OPA/Kyverno/OpenFGA integration)
  - Updated the "How the Pieces Fit" table with new entries
- Updated SUMMARY.md and introduction to reference the new chapter

**Why these choices:**
The PAC Framework is defined as the organizing spine of the book in CLAUDE.md, but had no dedicated chapter. Every chapter should connect back to it, so writing it was the highest-impact single piece of work. The protocol landscape updates capture new IETF drafts and the CSA Agentic Trust Framework that emerged in February 2026.

**What I'd do next session:**
1. Deep dive chapter on Verifiable Intent with actual JWT structures and transaction flow walkthrough
2. Case studies chapter: OpenClaw/Clawdbot, MCP vulnerabilities, real-world agent failures
3. The context infrastructure argument: training depreciates, context appreciates
4. Add PAC framework references to existing chapters (agents-create-intent, gaps)

**Sources used (this session):**
- Shane's trustedagentic.ai PAC Framework (i18n/en.json, framework layout, profiler)
- Shane's blog posts: "Verifiable Intent" (2026-03-06), "AI Agents Need the Inverse of Human Trust" (2026-02-03), "OpenClaw and Moltbook" (2026-02-17)
- IETF draft-aap-oauth-profile-00 (Agent Authorization Profile)
- IETF draft-jia-oauth-scope-aggregation (OAuth Scope Aggregation for Multi-Step AI Agent Workflows)
- CSA Agentic Trust Framework (2026-02-02)
- CSA/Strata Identity survey on agent compliance readiness (2026-02-05)
- Red Hat zero trust for autonomous agentic AI systems (2026-02-26)
- AgentGateway (agentgateway/agentgateway on GitHub)

---

## 2026-03-12 (Session 3): Verifiable Intent deep dive and Context Infrastructure chapters

**What I did:**
- Wrote "Verifiable Intent: A Deep Dive" (src/verifiable-intent.md): a full walkthrough of the three-layer SD-JWT architecture with actual credential structures from the spec. Covers L1 identity, L2 intent with checkout and payment mandates, L3a/L3b split for payment network and merchant. Explains selective disclosure, the eight constraint types, protocol interoperability (AP2, ACP, UCP), and the convergence on SD-JWT VC as a credential format. Also covers the complementary Agentic JWT IETF draft (draft-goswami-agentic-jwt-00) which extends OAuth 2.0 with agent checksums and workflow-aware token binding. Maps everything to PAC pillars. Clear section on what VI doesn't solve (multi-hop delegation, agent compromise, trust bootstrapping, liability).
- Wrote "Context Infrastructure: The Lasting Investment" (src/context-infrastructure.md): the argument that training depreciates, code depreciates, but context infrastructure appreciates. Draws on two of Shane's posts and the MIT Technology Review. Covers the five investment areas (structure, permissions, discovery, authority, freshness), the inferential edge concept, scaffolding dissolution, and what survives the scaffolding collapse. Uses Claude Code and Clawdbot as evidence. Maps to PAC across all three pillars.
- Updated SUMMARY.md to include both new chapters under "What's Being Built"
- Updated introduction.md to reference both new chapters

**Why these choices:**
Verifiable Intent deep dive has been the #1 priority for two sessions. It's the most concrete, technically rich protocol in the book's landscape, and walking through the actual JWT structures grounds the theoretical discussion in practice. The Context Infrastructure chapter captures Shane's core investment thesis: the argument that shapes how readers should think about what to build. Together, these two chapters fill the biggest gaps in the book: one goes deep on the most important protocol, the other provides the strategic framing for where to invest.

**What I'd do next session:**
1. Case studies chapter: Clawdbot/OpenClaw incident, 8000+ exposed MCP servers (Feb 2026), CVE-2025-6514, Google Workspace CLI auth mismatch
2. Regulatory landscape chapter: EU AI Act for agents, NIST initiatives, OpenID AIIM, standards fragmentation
3. Agent identity chapter: DIDs, VCs, ERC-8004, eIDAS 2.0/EUDI wallets, Shane's VC-signed blog posts experiment
4. Incorporate remaining unread Shane posts (16+ posts from Jan-Mar 2026 not yet used)

**Sources used (this session):**
- Shane's blog posts: "Verifiable Intent" (2026-03-06), "AI Agents: Why Context Infrastructure May Be Your Best Long-Term Investment" (2026-02-09), "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge" (2026-03-02), "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting." (2026-02-02), "OpenClaw and Moltbook" (2026-02-17), "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First." (2026-03-05)
- Verifiable Intent specification (verifiableintent.dev) and GitHub credential format examples
- Mastercard announcement: "How Verifiable Intent builds trust in agentic AI commerce"
- Agentic JWT IETF draft (draft-goswami-agentic-jwt-00)
- Goswami, "Agentic JWT: A Secure Delegation Protocol for Autonomous AI Agents" (arXiv:2509.13597)
- SD-JWT specification (RFC 9901)
- SD-JWT VC specification (draft-ietf-oauth-sd-jwt-vc)
- MIT Technology Review, "Building a strong data infrastructure for AI agent success" (2026-03-10)
- MCP security incidents: 8000+ exposed servers (Feb 2026), CVE-2025-6514, Noma Security top-5 blindspots

---

## 2026-03-12 (Session 4): When Trust Breaks Down chapter and protocol landscape updates

**What I did:**
- Wrote "When Trust Breaks Down" (src/when-trust-breaks.md): the case studies chapter that the gaps chapter identified as the next priority. Grounded entirely in 2026 industry data rather than individual anecdotes. Uses two major reports (Gravitee State of AI Agent Security 2026, Teleport 2026 State of AI in Enterprise Infrastructure Security), MCP CVEs in production, Gartner predictions, NIST's response, and the EU AI Act August 2026 deadline. Every section connects back to PAC and the book's other chapters.
- Updated the Protocol Landscape chapter with four new IETF drafts: draft-yao-agent-auth-considerations (further OAuth considerations for agents), draft-yl-agent-id-requirements (identity management requirements for agent communication), draft-ietf-oauth-identity-assertion-authz-grant (identity assertion exchange), and expanded the NIST AI Agent Standards Initiative section with details about the CAISI three-pillar structure.
- Updated SUMMARY.md with new "The Evidence" section containing the case studies chapter
- Updated introduction.md to reference the new chapter
- Updated gaps.md to mark case studies and PAC framework as completed priorities

**Why these choices:**
The case studies chapter was the #1 remaining priority from the gaps chapter. The 2026 industry reports provide something the book was missing: empirical evidence that the trust infrastructure gap has concrete, measurable costs. The Teleport finding (4.5x incident rate from over-privilege) is particularly powerful because it validates the trust inversion argument from Chapter 1 with data. The Gravitee numbers (88% incident rate, 1.5M unmonitored agents) make the shadow agent problem real. The EU AI Act August 2026 deadline adds urgency. Together, these transform the book's argument from "here's what could go wrong" to "here's what is going wrong."

**What I'd do next session:**
1. Agent identity deep dive: DIDs, VCs, SPIFFE/SPIRE, eIDAS 2.0/EUDI wallets, ERC-8004, Shane's VC-signed blog posts
2. Regulatory landscape chapter: EU AI Act for agents, NIST initiatives, standards convergence/fragmentation
3. Agent payments and economic infrastructure: x402, EIP-3009, stablecoin rails for autonomous agents (Shane's Jan 2026 post)
4. Incorporate remaining unread Shane posts (x402, fitting agentic AI components, LFDT meetup)

**Sources used (this session):**
- Gravitee, "State of AI Agent Security 2026" (February 2026) - 750 respondents, 88% incident rate
- Teleport, "2026 State of AI in Enterprise Infrastructure Security" (February 2026) - 205 CISOs, 4.5x incident rate
- Gartner, "Strategic Predictions for 2026 and Beyond" - 2,000+ death-by-AI claims prediction
- NIST, "Accelerating the Adoption of Software and AI Agent Identity and Authorization" concept paper (2026-02-05)
- NIST, "AI Agent Standards Initiative" announcement (2026-02-17)
- NIST CAISI three-pillar structure for agent standards
- MCP CVEs: CVE-2025-68145, CVE-2025-68143, CVE-2025-68144 (Git MCP server)
- CVE-2025-6514 (mcp-remote npm package)
- Adversa AI MCP security roundups (February/March 2026)
- EU AI Act timeline and August 2, 2026 compliance deadline
- IETF draft-yao-agent-auth-considerations-01
- IETF draft-yl-agent-id-requirements-00
- IETF draft-ietf-oauth-identity-assertion-authz-grant-00
- OpenID Foundation AIIM whitepaper on agent identity challenges

---

## 2026-03-12 (Session 5): Agent Identity and Building Agents That Earn Trust

**What I did:**
- Wrote "Agent Identity: Proving Who (or What) Is Acting" (src/agent-identity.md): a comprehensive chapter covering the full identity stack agents inherit. Starts with the auth history (Kerberos through DIDs), then deep-dives into SPIFFE for workload identity (attestation-based, no secrets at rest, 144:1 NHI-to-human ratio), Verifiable Credentials and the eIDAS 2.0/EUDI Wallet convergence (four credential formats, SD-JWT VC as the agent format of choice), DIDs for cross-domain identity, ERC-8004 on-chain agent registries (identity, reputation, validation; mainnet since Jan 29 2026), and the IETF/OpenID response. Includes a composition table showing how the layers work together. Maps to all three PAC pillars.
- Wrote "Building Agents That Earn Trust" (src/earning-trust.md): the practical/operational chapter. Covers autonomy as output not input (Shane's profiler + CSA's six levels), sandbox architecture (native vs DevContainers vs Docker microVMs, 90% incident reduction), delegation patterns (OBO, PIC, TSP), the Framework-Runtime-Harness mental model, boardroom questions mapped to PAC, EU AI Act compliance requirements (Article 9/12/14, August 2026 deadline), Singapore's MGF, workforce signals, and a practical seven-step deployment sequence.
- Incorporated 12 previously unused Shane blog posts: history-of-auth, erc-8004-mainnet, eudi-credential-formats, signing-blog-posts-verifiable-credentials, lfdt-meetup-trust-ecosystems-authority-continuity, agent-profiler-reasoning, early-indicators-agent-use-cases-anthropic-data, docker-sandbox-coding-agents, ai-agents-beyond-pocs-iam-emerging-patterns, fitting-agentic-ai-components-in-a-mental-model, agentic-ai-curated-questions-for-the-boardroom, the-work-thats-leaving, ai-agents-eu-ai-act
- Updated SUMMARY.md: added Agent Identity under "What's Being Built", created new "Making It Real" section with the practical chapter alongside the PAC Framework
- Updated introduction.md with references to both new chapters
- Updated gaps.md to mark agent identity and practical guide as completed priorities, added two new priorities (agent payments, multi-agent coordination)

**Why these choices:**
Agent identity was the #1 priority from Session 4 and is foundational: multiple existing chapters reference identity concepts without a dedicated deep dive. The practical chapter was the biggest structural gap: the book had plenty of "what needs to exist" but no "how to actually do it." Together, these chapters shift the book from describing the problem and landscape to giving readers actionable guidance. The 12 incorporated Shane posts represent the bulk of his unused writing, ensuring the book is grounded in his voice and observations rather than drifting.

**What I'd do next session:**
1. Agent payments chapter: x402, EIP-3009, stablecoin rails, Shane's working PoC
2. Multi-agent coordination chapter: trust, identity, and authority when agents hire agents
3. Cross-reference pass: ensure all chapters link to each other where relevant
4. Remaining Shane posts: ai-agents-first-principles-resources, lfdt-member-summit-2026, new-explainers

**Sources used (this session):**
- Shane's blog posts (12): history-of-auth, erc-8004-mainnet, eudi-credential-formats, signing-blog-posts-verifiable-credentials, lfdt-meetup-trust-ecosystems-authority-continuity, agent-profiler-reasoning, early-indicators-agent-use-cases-anthropic-data, docker-sandbox-coding-agents, ai-agents-beyond-pocs-iam-emerging-patterns, fitting-agentic-ai-components-in-a-mental-model, agentic-ai-curated-questions-for-the-boardroom, the-work-thats-leaving, ai-agents-eu-ai-act
- SPIFFE/SPIRE documentation and concepts (spiffe.io)
- HashiCorp, "SPIFFE: Securing the identity of agentic AI and non-human actors" (2026)
- Aembit/Security Boulevard, "SPIFFE vs. OAuth: Access Control for Nonhuman Identities" (March 2026)
- Solo.io, "Agent Identity and Access Management: Can SPIFFE Work?" (2026)
- ERC-8004 specification (eips.ethereum.org/EIPS/eip-8004) and mainnet launch coverage (crypto.news)
- eIDAS 2.0 regulation and EUDI Wallet implementation timeline
- CSA, "Autonomy Levels for Agentic AI" (January 2026)
- Singapore IMDA, Model AI Governance Framework for Agentic AI (January 2026)
- Docker Sandboxes documentation and microVM architecture (docs.docker.com)
- Northflank, "How to sandbox AI agents in 2026" (2026)
- OpenID Foundation AIIM community group, NIST RFI response (March 2026)
- Tobin South, "Identity Management for Agentic AI" (arXiv:2510.25819)
- NHI-to-human ratio statistic (144:1, Q1 2026)

---

## 2026-03-12 (Session 6): Agent Payments chapter

**What I did:**
- Wrote "Agent Payments: When Agents Need to Spend Money" (src/agent-payments.md): covers the two emerging approaches to agent payments. x402 (Coinbase/Cloudflare/Stripe): HTTP 402-based protocol with on-chain stablecoin settlement, including Shane's hands-on proof-of-concept with EIP-3009 gasless payments, L2 economics, and current adoption reality ($28K daily volume despite $7B ecosystem valuation). AP2 (Google/Mastercard/60+ partners): Verifiable Digital Credentials with Intent and Cart Mandates, connection to Verifiable Intent's SD-JWT layers. Covers the fragmentation problem (AP2, ACP, UCP, x402, VI all emerging simultaneously), trust challenges specific to payments (KYA, intent preservation, liability when constraints are satisfied, EU EUDI wallet angle), and maps everything to PAC pillars.
- Updated SUMMARY.md to add the new chapter under "Making It Real"
- Updated gaps.md to mark agent payments as completed priority

**Why these choices:**
Agent payments was the #1 priority from Session 5 and the last major gap in the book's roadmap. The field moved significantly in early 2026: x402 launched with Coinbase/Cloudflare/Stripe support, Google announced AP2 with 60+ partners, and Verifiable Intent provided the credential bridge between the approaches. The chapter captures a moment where payment infrastructure for agents is being built in real time, with real data showing the gap between infrastructure readiness and actual adoption. It also connects naturally to the Verifiable Intent chapter (AP2's VDC chain maps to VI's SD-JWT layers) and the protocol landscape (fragmentation pattern).

**What I'd do next session:**
1. Multi-agent coordination chapter: DeepMind's Intelligent Delegation framework, Delegation Capability Tokens (Macaroons/Biscuits), trust when agents hire agents
2. Cross-reference pass across all chapters
3. Remaining Shane posts: ai-agents-first-principles-resources, lfdt-member-summit-2026

**Sources used (this session):**
- Shane's blog posts: "When Agents Pay for APIs: Getting Hands-On with x402 and EIP-3009" (2026-01-07), "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization" (2026-03-06)
- x402 specification and whitepaper (x402.org)
- Coinbase/Cloudflare x402 Foundation announcement (coinbase.com/blog, blog.cloudflare.com/x402)
- CoinDesk, "Coinbase-backed AI payments protocol wants to fix micropayment but demand is just not there yet" (2026-03-11)
- Google Cloud Blog, "Announcing Agent Payments Protocol (AP2)" (2026)
- AP2 specification (ap2-protocol.org/specification)
- PayPal Developer Blog, "Agent Payments Protocol: Building Verifiable Trust for Agentic Commerce" (2026)
- Stripe, "Introducing our agentic commerce solutions" (2026)
- Google Developers Blog, "Under the Hood: Universal Commerce Protocol (UCP)" (2026)
- PYMNTS, "Agentic Commerce Pushes 'Know Your Human' Into Verification Processes" (2026)
- Mastercard, "How Verifiable Intent builds trust in agentic AI commerce" (2026)
- Biometric Update, "EU can rein in AI agents with EUDI Wallets and business wallets: WE BUILD" (2026-03)
- Google DeepMind, "Intelligent AI Delegation" (arXiv:2602.11865, 2026-02-12)
- CSA, "AI Security Across Domains: Who Vouches?" (2026-03-11)
- IACR, "Trustworthy Agent Network" (eprint 2026/497)
