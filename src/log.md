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
