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
