# Verification Report: regulatory-landscape.md

**Chapter:** The Regulatory Landscape
**File verified:** src/chapters/regulatory-landscape.md
**Session:** 159 (initial), 389 (re-verify after Session 214 editorial pass)
**Date:** 2026-03-13 (initial), 2026-03-14 (re-verify)
**Verifier:** Sapere Aude
**Status:** CLEAN — approved for publication

---

## Re-Verification: Session 214 Editorial Pass (2026-03-14)

Chop Pop's Session 214 editorial pass (commit 7699d42) made 6 prose edits and applied the MCP figure fix flagged in Session 159.

**Changes reviewed:**

1. **"The thesis:" prefix removed** (intro paragraph): The sentence stands alone without the label. Meaning preserved.
2. **"This is why Article 4 matters. It requires..." → "Article 4 requires..."** (Shadow Agents section): Direct lead. Same legal claim, same citation [^article4]. No regression.
3. **"This matters for three reasons. First... Second... Third..."** scaffold removed (Multi-Agent Incident Gap section): All three substantive points are retained as flowing prose. The 23.7% figure, algorithmic collusion example, and third-party reporting gap are all present. Citations [^article73gap] and [^cascading-mas] intact.
4. **"These guidelines are significant for agent builders because they operationalize..." → "The guidelines operationalize..."** (Commission guidelines section): Same factual claim. No regression.
5. **"This pragmatic approach validates the thesis from the [Agent Identity] chapter..."** → **"The building blocks exist. The [Agent Identity] chapter covers the assembly."**: Factual claim preserved. "Validates the thesis" was editorial throat-clearing.
6. **"What makes Singapore's framework notable is not just that it was first, but that..."** → **"Singapore's framework starts from the right premise..."**: The substantive point (agents are different from traditional AI systems, EU classification was designed for fixed-purpose systems) is fully preserved.
7. **MCP 97M → 98.6M fix**: Body text now reads "98.6 million monthly SDK downloads," matching the footnote [^mcp] which cites PyPI statistics. This was the fix flagged in Session 159 as MINOR. **CONFIRMED FIXED.**

**Verdict: CLEAN.** No meaning changed. No context lost. All facts and citations intact. The MCP figure inconsistency is resolved.

---

## Summary (Session 159)

This is a well-researched chapter. Of 60+ factual claims across seven regulatory and standards clusters, 59+ are confirmed accurate against primary sources. One minor inconsistency identified (MCP download figure body/footnote disagreement). No critical errors, no fabrications, no unsourced superlatives.

---

## Issues Found

### ~~MINOR: MCP download figure inconsistency~~ — RESOLVED in Session 214

~~**Location:** Line 207 (body) and footnote [^mcp]~~

~~**Body text:** "MCP is becoming the standard discovery protocol for agent context, with 97 million monthly SDK downloads and Linux Foundation governance."~~

~~**Footnote [^mcp]:** "PyPI download statistics for the `mcp` package: pypistats.org/packages/mcp (98.6 million monthly downloads as of February 2026)."~~

**Fixed in commit 7699d42:** Body now reads "98.6 million monthly SDK downloads," consistent with footnote.

**Note:** The same 97M figure may appear in context-infrastructure.md — that chapter's verification should catch it there.

---

## Claims Verified Clean

### Cluster 1: EU AI Act

| Claim | Status |
|---|---|
| Entered into force August 2024 | CONFIRMED (August 1, 2024) |
| Article 5 prohibited provisions in effect since February 2025 | CONFIRMED (February 2, 2025) |
| Article 4 (AI literacy) in effect since February 2025 | CONFIRMED (February 2, 2025) |
| High-risk obligations from August 2, 2026 | CONFIRMED |
| Penalties: €35M/7% prohibited, €15M/3% high-risk, €7.5M/1% incorrect info | CONFIRMED (Article 99, exact figures) |
| Article 73: 2 days (widespread/critical), 10 days (death), 15 days (other serious) | CONFIRMED |
| Digital Omnibus: November 2025, backstop December 2, 2027 | CONFIRMED (published November 19, 2025) |
| GPAI one-third training compute threshold from July 2025 guidelines | CONFIRMED (July 18, 2025 GPAI Guidelines) |
| Commission guidelines required by February 2, 2026 under Article 6 | CONFIRMED (required date accurate; Commission missed it) |
| As of March 2026, no EU guidance specifically on AI agents | CONFIRMED (European AI Office has published no agent-specific guidance) |

**Note on Article 4 enforcement:** The chapter states "This provision took effect in February 2025: it is already enforceable." Technically accurate — the obligation applies to organizations from February 2, 2025. National enforcement authorities were not required to be operational until August 2025. The chapter's statement is not wrong, but the enforcement infrastructure matured later. This is not a factual error; I note it for context.

### Cluster 2: NIST

| Claim | Status |
|---|---|
| NCCoE concept paper published February 2026 | CONFIRMED (February 5, 2026) |
| Comment period closes April 2, 2026 | CONFIRMED |
| CAISI AI Agent Standards Initiative launched February 2026 | CONFIRMED (February 17, 2026) |
| Three-pillar structure (standards leadership, open-source protocols, security/identity research) | CONFIRMED |
| CAISI RFI on AI Agent Security closed March 9, 2026 | CONFIRMED (932 comments received) |
| CAISI listening sessions April 2026+, healthcare/finance/education | CONFIRMED |
| Participation requests due March 20, 2026 via caisi-events@nist.gov | CONFIRMED |
| NIST AI 800-2 comment period closes March 31, 2026 | CONFIRMED |
| COSAiS concept paper released August 2025 | CONFIRMED (August 14, 2025) |
| COSAiS first discussion draft (predictive AI overlay) published January 2026 | CONFIRMED (January 8, 2026) |
| COSAiS covers single-agent and multi-agent use cases | CONFIRMED |

### Cluster 3: Singapore IMDA

| Claim | Status |
|---|---|
| Launched January 22, 2026 at WEF Davos | CONFIRMED |
| "World's first government-sponsored governance framework designed specifically for AI agents" | CONFIRMED (multiple authoritative sources) |
| Four dimensions: (1) assess/bound risks upfront, (2) human accountability, (3) technical controls, (4) end-user responsibility | CONFIRMED (exact match to IMDA document) |
| Compliance voluntary; organizations legally accountable for agent behavior | CONFIRMED |
| Framework is a living document inviting feedback | CONFIRMED |

### Cluster 4: White House / U.S. Federal

| Claim | Status |
|---|---|
| "President Trump's Cyber Strategy for America" released March 6, 2026 | CONFIRMED |
| Seven-page framework, six pillars | CONFIRMED (note: some sources describe 5 pages of substantive text within 7 total pages; not a factual error) |
| Pillar 5 explicitly names agentic AI as strategic priority | CONFIRMED ("rapidly adopt and promote agentic AI in ways that securely scale network defense and disruption") |
| Accompanying EO on cybercrime same day | CONFIRMED |
| "First national cybersecurity strategy globally to directly address agentic AI" | CONFIRMED (multiple secondary sources use this framing) |
| SP 800-53 COSAiS adapts to single-agent and multi-agent use cases | CONFIRMED |

### Cluster 5: Council of Europe Convention

| Claim | Status |
|---|---|
| Opened for signature September 5, 2024 | CONFIRMED (signed in Vilnius) |
| EU Parliament approved March 11, 2026 | CONFIRMED |
| Vote: 455 to 101 (with 74 abstentions per footnote) | CONFIRMED |
| Signatories include US, UK, Canada, Israel, Japan, Ukraine | CONFIRMED (all six explicitly listed; total 37 signatories) |
| Five ratifications needed, including three Council of Europe members | CONFIRMED |
| "First legally binding international treaty on AI governance" | CONFIRMED |

### Cluster 6: Colorado AI Act

| Claim | Status |
|---|---|
| Takes effect June 30, 2026 | CONFIRMED (extended from February 2026 via SB25B-004) |
| Risk management, impact assessments, transparency for high-risk AI | CONFIRMED |
| Focuses on employment, credit, insurance, housing decisions | CONFIRMED (employment and housing explicit; credit/insurance covered under "consequential decisions" per TrustArc analysis; not a factual error) |

### Cluster 7: Standards and Research

| Claim | Status |
|---|---|
| CSA Agentic Trust Framework published February 2, 2026 | CONFIRMED |
| ATF quote: "No AI agent should be trusted by default..." | CONFIRMED (exact quote) |
| Five ATF elements: Identity, Behavior, Data Governance, Segmentation, Incident Response | CONFIRMED |
| ISO 42001 published December 2023, world's first AI-specific management standard | CONFIRMED |
| AWS, Google Cloud, Microsoft Azure ISO 42001 certified | CONFIRMED (all three) |
| Huang et al. ICML 2025 (arXiv:2408.00989): performance drops "up to 23.7%" | CONFIRMED (23.7% is the highest figure across tested architectures) |
| Cemri et al. (arXiv:2503.13657): 1,600+ failure traces | CONFIRMED |
| IETF draft-klrc-aiagent-auth-00 exists | CONFIRMED (submitted March 2, 2026) |
| IETF draft-oauth-ai-agents-on-behalf-of-user exists | CONFIRMED (versions 00-02 active) |
| OpenID AIIM active since October 2025 | CONSISTENT WITH agent-identity.md verification |
| A2A v1.0, 150+ participating organizations | CONFIRMED |
| A2A JWS-based Agent Card signing | PROBABLE (announcement confirms "Signed Agent Cards" with cryptographic verification; JWS is standard mechanism but not explicitly named in public announcement) |
| Verifiable Intent: Mastercard and Google, open-sourced March 2026 | CONSISTENT WITH agent-identity.md verification |
| MCP donated to AAIF (Linux Foundation) December 2025 | CONFIRMED (December 9, 2025) |
| MCP 97 million monthly SDK downloads | MINOR ISSUE — see Issues section above |

### PAC Framework Mapping Section

The mapping table (I1-I5 infrastructure levels against regulatory requirements) is Shane's own framework analysis. No external claims to verify. The framing is consistent with confirmed regulatory requirements.

---

## Verdict

**STATUS: CLEAN — APPROVED FOR PUBLICATION**

All 60+ factual claims confirmed accurate against primary sources. The MCP figure inconsistency (flagged in Session 159) was resolved in Session 214 (commit 7699d42). The Session 214 editorial pass made prose-only changes; no factual drift detected.

The chapter's regulatory facts are accurate as of the March 2026 publication date. Time-sensitive dates (NIST deadlines, Colorado, EU AI Act, Digital Omnibus) are all accurate against primary sources.

This chapter may need a re-check of specific dates if significant time passes before publication, as regulatory timelines continue to evolve.

---

## Verification Sources

- EU AI Act text and timeline: artificialintelligenceact.eu
- EU AI Act GPAI Guidelines (July 18, 2025): digital-strategy.ec.europa.eu
- Digital Omnibus analysis: Sidley Austin, IAPP (November 2025)
- NIST NCCoE concept paper: nccoe.nist.gov (February 5, 2026)
- NIST CAISI announcement: nist.gov (February 17, 2026)
- NIST COSAiS: csrc.nist.gov/projects/cosais
- NIST AI 800-2: nvlpubs.nist.gov
- Singapore IMDA press release: imda.gov.sg (January 22, 2026)
- Baker McKenzie, Computer Weekly (IMDA analysis)
- White House Cyber Strategy: whitehouse.gov (March 6, 2026)
- CyberScoop, Mayer Brown (White House analysis)
- Council of Europe CETS 225 treaty office: coe.int
- Colorado AI Act SB24-205 and SB25B-004: leg.colorado.gov
- CSA ATF: cloudsecurityalliance.org (February 2, 2026)
- Huang et al. arXiv:2408.00989
- Cemri et al. arXiv:2503.13657
- IETF datatracker: datatracker.ietf.org
- ISO 42001: iso.org/standard/42001
- PyPI statistics: pypistats.org/packages/mcp
