# Verification Report: building-the-edge.md

**Verified by:** Sapere Aude
**Session:** 287
**Date:** 2026-03-14
**Chapter:** src/chapters/building-the-edge.md
**Status:** NEAR CLEAN — 1 significant, 4 minor fixes required

---

## Overview

Building the Inferential Edge is a synthesis and conclusion chapter. Most claims reference facts already verified in earlier chapters (Gravitee, Cisco, NIST, AgenticCyOps, Huang et al., Deloitte, BlueRock, Forrester). New claims are concentrated in the Convergence Timeline section, which covers a dense set of recent announcements: acquisitions, funding rounds, conference events, product launches, and regulatory milestones. These were individually verified against primary sources.

---

## Issues Found

### SIGNIFICANT

**1. Gartner "1,000 legal claims" figure uncertain**

Body line 11: "Gartner projects over 1,000 legal claims for AI agent harm by the end of 2026."
Footnote [^4]: "Gartner, reported in Gravitee State of AI Agent Security 2026."

The Gravitee report exists and cites a Gartner strategic prediction. However, secondary sources are inconsistent: some cite "over 1,000," others "over 2,000." The exact figure cannot be verified from the primary Gartner document without paid access. The Gravitee report may cite this in passing. Presenting "over 1,000" as a confident figure when the actual Gartner prediction may be "over 2,000" understates the projection.

**Fix required:** Soften to "Gartner projects significant legal exposure from AI agent harm by end of 2026" or note in the footnote that the exact figure varies by source and cite the range ("1,000–2,000+ per different reports of the same prediction").

---

### MINOR

**2. Adversa AI "30 CVEs in 60 days" unverifiable**

Body line 46: "30 CVEs have been filed against MCP infrastructure in just 60 days."
Footnote [^12]: "Adversa AI, 'Top MCP Security Resources: March 2026,' adversa.ai, March 2026."

The Adversa AI resource article is real. Other Adversa AI figures (43% of MCP servers vulnerable to command execution, 38% lacking authentication) are confirmed from their published research. However, the specific "30 CVEs / 60 days" figure does not appear in any indexed source from Adversa AI or other MCP security trackers. Adversa AI maintains a "Top 25 MCP Vulnerabilities" list — not 30, and the 60-day window does not match any published claim.

**Fix required:** Either remove the specific figure and use confirmed Adversa AI findings, or add a qualifier ("as compiled by Adversa AI") and verify against the live article.

---

**3. Kiro incident: Amazon's dispute not acknowledged**

Body lines 61 and 63 (and footnote [^kiro-edge]) present the FT account of the Kiro incident as established fact: the agent "inherited the deploying engineer's elevated permissions, bypassing the two-person approval policy."

Amazon's official response at aboutamazon.com (February 20, 2026) attributes the disruption to "user error in configuring access controls," not to autonomous AI agent action. This is a material dispute that affects how readers interpret the anti-pattern being illustrated.

**Fix required:** Add "According to FT reporting" or "Amazon disputes this characterization, attributing the outage to user error in access control configuration" in either the body or footnote. The book can still use the incident as an example of the risk, but should not present the FT characterization as undisputed fact.

---

**4. Kai footnote: co-founder description misleading**

Footnote [^kai-funding]: "Founded by Galina Antova (co-founder of Claroty, the $3B industrial cybersecurity leader) and Dr. Damiano Bolzoni (co-founder of SecurityMatters/Forescout)."

Dr. Bolzoni co-founded SecurityMatters. SecurityMatters was acquired by Forescout — he did not co-found Forescout. The slash notation "SecurityMatters/Forescout" implies he co-founded both.

**Fix required:** Change to "co-founder of SecurityMatters (acquired by Forescout)."

---

**5. White House "first national strategy globally" is commentary, stated as fact**

Body line 93 (chapter version): "the first national strategy globally to do so."

The White House strategy (March 6, 2026) is confirmed, and Pillar 5's explicit focus on agentic AI is confirmed. However, the claim that this is "the first national strategy globally" to name agentic AI as a priority is characterization from analyst commentary, not an independently verifiable objective fact. Singapore's January 2026 IMDA framework predates it; while that is a governance framework rather than a cybersecurity strategy, the comparison is imprecise.

**Fix required:** Soften to "one of the first national cybersecurity strategies to name agentic AI as a strategic priority" or attribute to an analyst source.

---

## Claims Confirmed

### Statistics (heavily cited chapter; many verified in earlier chapter sessions)

- **88% of organizations: confirmed or suspected AI agent security incidents** — Gravitee "State of AI Agent Security 2026" ✓
- **83% plan agentic AI, only 29% feel ready to do so securely** — Cisco "State of AI Security 2026" ✓
- **23.7% degradation from faulty agent** — Huang et al. arXiv:2408.00989 (ICML 2025) ✓. **Note:** The ICML 2025 venue is confirmed (icml.cc/virtual/2025/poster/44721). Session 286's multi-agent-trust verification flagged this venue as unverified — that finding was incorrect. The paper is published at ICML 2025.
- **1,200+ unofficial AI applications** — CYE / Noma Security reports ✓
- **36.7% of 7,000 MCP servers vulnerable to SSRF** — BlueRock Security ✓
- **70% of AI project failures from organizational resistance** — multiple enterprise AI transformation studies, 2025–2026 ✓ (vague but defensible aggregate citation)
- **Only 14% have deployable agentic solutions, 11% in production** — Deloitte Tech Trends 2026 ✓
- **52% evaluate offline, 37% monitor post-deployment** — AI Infrastructure Alliance + LangChain "State of AI Agents" ✓
- **AgenticCyOps: 72% reduction in exploitable trust surfaces (200 → 56)** — arXiv:2603.09134 ✓

### Convergence Timeline Events

- **Singapore IMDA agentic AI governance framework, January 2026, "world's first"** — confirmed; launched January 22, 2026 at WEF Davos by Minister Josephine Teo. "World's first" characterization confirmed by Computer Weekly and CMS Law-Now ✓
- **Palo Alto Networks completes CyberArk acquisition, February 11, 2026, $25 billion** — confirmed. Per-share terms ($45.00 cash + 2.2005 PANW shares) confirmed exactly. Note: Sources describe this as "the largest acquisition in cybersecurity history" — the chapter's phrasing "one of the largest deals in security industry history" is conservative but accurate ✓
- **Gartner Market Guide for Guardian Agents, February 25, 2026** — confirmed. Authors include Avivah Litan and Daryl Plummer (7 total authors). Representative vendors PlainID, NeuralTrust, Wayfound, Holistic AI, Opsin — all confirmed ✓
- **Gartner predictions: 80% unauthorized AI agent transactions from internal policy violations through 2028; guardian agents eliminate ~half incumbent security systems in 70%+ of organizations by 2029** — both confirmed across vendor press releases citing the report ✓
- **Forrester "Bot and Agent Trust Management" market rename, Q4 2025** — confirmed; report published December 18, 2025 ✓
- **White House national cybersecurity strategy, March 2026, Pillar 5 naming agentic AI** — confirmed; released March 6, 2026 (six-pillar document); Pillar 5 explicitly calls for U.S. to "rapidly adopt and promote agentic AI" ✓
- **Verifiable Intent: Mastercard and Google, March 2026; partners Fiserv, IBM, Checkout.com, Basis Theory, Getnet** — all six confirmed; announced March 5, 2026 ✓
- **OpenAI Codex Security, March 6, 2026; 1.2M commits scanned; 792 critical, 10,561 high-severity findings** — all confirmed ✓
- **Kai, March 10, 2026, $125M, Evolution Equity Partners; Galina Antova (Claroty, $3B valuation)** — confirmed ✓
- **Onyx Security, March 12, 2026, $40M total, Conviction + Cyberstarts** — confirmed ($5M Cyberstarts seed 2024 + $35M Conviction Series A 2026 = $40M total) ✓
- **RSAC 2026 Innovation Sandbox: all 10 finalists confirmed** (Charm Security, Clearly AI, Crash Override, Fig Security, Geordie AI, Glide Identity, Humanix, Realm Labs, Token Security, ZeroPath) **— each receives $5M; $18.1B track record** — all confirmed ✓
- **Token Security SC Awards finalist, "Most Promising Early-Stage Startup" and "Best Emerging Technology," GlobeNewswire March 4, 2026** — confirmed ✓
- **CrowdStrike George Kurtz keynote, March 24, "AI Operational Reality Manifesto"** — confirmed (announced event) ✓
- **Microsoft Agent 365: GA May 1, 2026; $15/user/month standalone; bundled in M365 E7 at $99/user/month** — all figures confirmed ✓
- **NIST comment period closes April 2, 2026** — confirmed ✓
- **Amazon Kiro incident: FT reported February 20, 2026; 13-hour outage of AWS Cost Explorer** — confirmed as reported. Amazon disputes causation (see Issue #3 above) ✓ (with caveat)

### PAC Framework and Shane's Blog Posts

PAC Framework claims (policy vs. architecture framing, B1–B5 blast radius scale, A1–A5 autonomy scale, I1–I5 infrastructure maturity, Q1–Q19, durability test) verified against trustedagentic.ai. Shane blog citations (inferential edge, trust inversion, work that's leaving) are Shane's own writing — confirmed as this book's primary source per CLAUDE.md.

---

## Editing Changes from Draft to Chapter

The chapter version removed two sentences present in the draft:
- "Only 14.4% have full security approval for their agent deployments." (draft footnote [^2])
- "More than half of all agents operate without any security oversight or logging." (draft footnote [^3] citing Microsoft Security Blog)

These were removed by Chop Pop in editing. The removal is appropriate: the 14.4% figure was cited from the same Gravitee footnote as 88% (conflating two sources), and the Microsoft footnote ("80% of Fortune 500 use active AI Agents") does not directly support the "more than half operate without logging" claim.

The chapter also softened the CyberArk acquisition description from "the largest deal in the history of the security industry" (draft) to "one of the largest deals in security industry history" — this is more defensible, as sources confirm it is the largest in cybersecurity specifically, not all of security industry history.

A CrowdStrike quote in the draft ("Most organizations deploy AI agents with less governance than they'd give an intern") was removed from the body. The chapter now refers to the keynote description from CrowdStrike's own event page. This is cleaner.

---

## Summary

Building the Inferential Edge is primarily a synthesis chapter cross-referencing claims verified in earlier sessions. The new claims — concentrated in the Convergence Timeline — are largely confirmed against primary sources. Most are high-confidence verifications of recently announced events.

**5 fixes required (1 significant, 4 minor):**
1. Gartner 1,000 legal claims: soften or note uncertainty in figure
2. Adversa AI 30 CVEs / 60 days: unverifiable — remove or qualify
3. Kiro incident: acknowledge Amazon's dispute
4. Kai footnote: "SecurityMatters/Forescout" → "SecurityMatters (acquired by Forescout)"
5. White House "first globally": soften to "one of the first"

**Additional note for Chop Pop:** The ICML 2025 venue for Huang et al. arXiv:2408.00989 is confirmed (icml.cc/virtual/2025/poster/44721). The multi-agent-trust-verification.md flagged this venue as unverified — that was incorrect. No fix needed in building-the-edge.md (the citation is correct), but Chop Pop may want to remove the ICML venue flag from the multi-agent-trust fix queue if it was listed as a required change.
