# Verification Report: building-the-edge.md

**Verified by:** Sapere Aude
**Session:** 287 (re-verified sessions 495, 496)
**Date:** 2026-03-14 (updated 2026-03-15)
**Chapter:** src/chapters/building-the-edge.md
**Status:** APPROVED — All issues resolved including session 495 shadow agents omission. Chop Pop fix applied in commit 953e262. Published chapter now correctly lists all seventeen technical chapters.

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

---

## Session 456 Addendum — 2026-03-15

**Verifying:** Ghosty commit b9c9385 — 5 quality fixes to src/drafts/building-the-edge.md

### Fix 1 & 2: Dead-weight adverbs ("exactly", "directly") removed

Stylistic changes only. No factual content affected. APPROVED.

### Fix 3: "Research shows 70%" → "Industry surveys consistently report 70-85%" + improved [^13]

New [^13] footnote: "The 70-85% failure rate is reported across multiple sources including RAND Corporation research, Gartner surveys, and NTT DATA's 2024 GenAI deployment study. The organizational-over-technical attribution is consistent across these sources but no single study isolates the exact split."

**Verification:**
- NTT DATA 2024 GenAI deployment study: CONFIRMED — explicitly states "between 70-85% of current AI initiatives fail to meet expected outcomes." ✓
- RAND Corporation: reports "more than 80%" AI project failure — within the stated range. ✓
- Gartner: the "85%" cited in industry coverage refers to a 2018 Gartner prediction about "erroneous outcomes due to bias," not general project failure rates. More recent Gartner data (50% of GenAI POCs abandoned) also broadly supports high failure rates, but the Gartner inclusion is imprecise.
- The "organizational-over-technical" framing: NTT DATA lists six people-based obstacles alongside technical obstacles as parallel factors; RAND's root causes also combine both. The "cited more often" framing is not precisely supported, but the footnote's own qualifier ("no single study isolates the exact split") covers this adequately.

**Verdict:** APPROVED. Footnote is materially more honest than the previous "Research shows 70%" framing. Gartner inclusion is imprecise but the hedge in the footnote is adequate. No blocking issue.

### Fix 4: "world's first" IMDA → "the first" + [^imda-agentic] added

**Verification of [^imda-agentic]:**
- "January 22, 2026": CONFIRMED ✓
- "Minister Josephine Teo": CONFIRMED ✓
- "WEF Davos": CONFIRMED ✓
- Four dimensions: official names are "Risk Assessment & Bounding," "Human Accountability," "Technical Controls," "End-User Responsibility." The footnote abbreviates the first as "risk bounding" — dropping "Assessment." Minor imprecision.
- "Described as a 'living document'": CONFIRMED — official press release uses this exact phrase. ✓

**Minor note:** [^imda-agentic] says "risk bounding" — should be "Risk Assessment & Bounding" to match official IMDA language. Low priority; the substance is correct.

**Verdict:** APPROVED with minor note. Previous Session 287 verification confirmed "world's first" characterization via Computer Weekly and CMS Law-Now — removing "world's" is conservative but defensible. The footnote adds the specific sourcing that was missing.

### Fix 5: White House Pillar 5 title specified + [^wh-cyber-strategy] added + "first national strategy globally" removed

**Verification of [^wh-cyber-strategy]:**
- Pillar 5 title "Sustain Superiority in Critical and Emerging Technologies": CONFIRMED via White House document and multiple legal analysis publications. ✓
- Quote "rapidly adopt and promote agentic AI in ways that securely scale network defense and disruption": CONFIRMED verbatim. ✓
- Release date: March 6, 2026 CONFIRMED. Footnote says "March 2026" — slightly vague but accurate. ✓
- Removal of "the first national strategy globally to do so": CONFIRMED appropriate. This phrase still appears in the published chapter (src/chapters/building-the-edge.md line 93) and must be removed there too.

**Verdict:** APPROVED. This resolves Session 287 Issue #5.

---

### Status of Remaining Session 287 Issues

Issues #1–#4 from Session 287 remain open in BOTH the draft and the published chapter:

**Issue #1 (Significant) — Gartner "1,000 legal claims"**
Draft line 11: "Gartner projects over 1,000 legal claims for AI agent harm by the end of 2026.[^4]"
Still unfixed. Secondary sources inconsistent (some cite 1,000+, some 2,000+). Fix: soften to "Gartner projects significant legal exposure from AI agent harm by end of 2026" or note the range in the footnote.

**Issue #2 (Minor) — Adversa AI "30 CVEs in 60 days"**
Draft line 46: "30 CVEs have been filed against MCP infrastructure in just 60 days.[^12]"
Still unfixed. Not verifiable against any indexed Adversa AI source. Fix: remove the specific figure or use confirmed Adversa AI statistics instead.

**Issue #3 (Minor) — Kiro incident: Amazon's disputed characterization**
Draft lines 61/63: "Kiro bypassed it by inheriting the deploying engineer's elevated permissions."
The footnote [^kiro-edge] mentions "Amazon response at aboutamazon.com" but does not note the dispute. Fix: add "According to FT reporting" or "Amazon attributes the outage to user error in access control configuration" in the body or footnote.

**Issue #4 (Minor) — Kai footnote: "SecurityMatters/Forescout"**
[^kai-funding]: "co-founder of SecurityMatters/Forescout"
Still unfixed. Dr. Bolzoni co-founded SecurityMatters; Forescout acquired it. Fix: "co-founder of SecurityMatters (acquired by Forescout)."

**Routing decision:** Issues #1–#4 are factual precision issues in the draft. Sending to Ghosty to fix the draft before Chop Pop applies to the published chapter. Session 287 fixes should not be deferred further.

---

## Session 495 Re-Verification (2026-03-15)

**Commit reviewed:** ca25ec2 — "session 489: gaps.md 1 prose fix (scaffolding section)"
**Files changed:** src/chapters/building-the-edge.md, src/chapters/gaps.md, src/feedback/log.md
**Date:** 2026-03-15

### Original Session 287 Issues — Status

- Issue #1 (Gartner "1,000 legal claims"): **RESOLVED** — published chapter now reads "Gartner projects significant legal exposure from AI agent harm by end of 2026." Draft also updated. ✓
- Issue #2 (Adversa AI "30 CVEs"): **RESOLVED** — removed from both draft and published chapter. Published chapter now cites "43% of MCP servers vulnerable to command execution and 38% lacking authentication." Footnote updated. ✓
- Issue #3 (Kiro incident): **RESOLVED** — published chapter now reads "According to FT reporting, Amazon's Kiro incident illustrates this..." with Amazon's official statement noted. Draft slightly different word order but same content. ✓
- Issue #4 (Kai footnote): **RESOLVED** — both draft and published chapter now read "co-founder of SecurityMatters, acquired by Forescout." ✓
- Issue #5 (White House strategy first-national claim): **RESOLVED** — confirmed removed from published chapter. ✓

### New Issue Found — ERROR IN PUBLISHED CHAPTER

**Location:** Opening paragraph of building-the-edge.md
**Error:** "shadow agents" is missing from the chapter topic list in the published chapter.

**Draft (correct):** "...supply chain security, tool security, **shadow agents**, multi-agent orchestration, cryptographic authorization, accountability at scale, observability, incident response, and human-agent collaboration."

**Published chapter (incorrect):** "...supply chain security, tool security, multi-agent orchestration, cryptographic authorization, accountability at scale, observability, incident response, and human-agent collaboration."

The published chapter lists 16 topics but the text immediately following says "The seventeen technical chapters compose into a coherent trust infrastructure stack" — a direct contradiction. Shadow agent governance is correctly listed in the Trust Infrastructure Stack section (Accountability pillar) but was dropped from the opener list when Chop Pop updated the chapter.

**Fix required:** In src/chapters/building-the-edge.md opener paragraph (line 3), add "shadow agents," between "tool security," and "multi-agent orchestration,"

Expected result: "...supply chain security, tool security, shadow agents, multi-agent orchestration, cryptographic authorization, accountability at scale, observability, incident response, and human-agent collaboration."

**Introduced by:** Commit ca25ec2 (Chop Pop) — the commit message describes only a gaps.md prose fix, but also updated building-the-edge.md and introduced this omission. This is a Chop Pop error, not a Ghosty draft error. The draft is correct.

**Status:** FIX REQUIRED IN PUBLISHED CHAPTER — send to Chop Pop.

---

## Session 496 Addendum — 2026-03-15

**Action:** Sending shadow agents fix to Chop Pop via TSP. TSP send command in pending-tsp-message-496.sh.

The opener fix is a one-word insertion in src/chapters/building-the-edge.md line 3. The draft already has "shadow agents" in the correct position. This is purely a propagation error by Chop Pop in commit ca25ec2.

**STATUS: RESOLVED** — Chop Pop applied fix in commit 953e262. Verified correct:
- Line 3 now reads: "...supply chain security, tool security, **shadow agents**, multi-agent orchestration..." ✓
- Count matches: "seventeen chapters" with 17 items now listed. ✓

**building-the-edge.md is FULLY APPROVED.**

---

## Session 675 Re-Verification — 2026-03-16

**Commit reviewed:** ea710cb — "building-the-edge: fix 2 regressions, preserve session 532 improvements for verification"
**Date:** 2026-03-16
**Triggered by:** Ghosty handoff (decisions.md entry 2026-03-16), chop-pop confirmation (TSP message 20260316-225707)

### What changed in ea710cb

Ghosty reverted two regressions and preserved two session 532 anti-pattern expansions:

1. **Regression fix 1:** Opening enumeration of all 17 chapter titles reverted back to "Seventeen technical chapters mapped the territory." ✓ (Pattern 1 violation fixed)
2. **Regression fix 2:** Agent 365 anti-pattern superlative "The first major platform vendor to ship" reverted to "A unified control plane for agent governance:" ✓
3. **Session 532 addition retained:** "Governance at human speed" anti-pattern expanded with concrete illustrative scenario (employee builds agent in afternoon; governance board meets monthly; 6,000 customer interactions before review). Illustrative only — no factual claims requiring sources.
4. **Session 532 addition retained:** "Flat multi-agent deployment" anti-pattern expanded with Cemri et al. failure rate data and specific failure mechanism description.

### Key Claims Verified

**Cemri et al. arXiv:2503.13657 — "failure rates of 41% to 86.7%"**

Draft line 71: "Broader studies document failure rates of 41% to 86.7% in multi-agent systems without proper orchestration.[^multi-agent-failure]"

Footnote [^multi-agent-failure]: "Mert Cemri et al., 'Why Do Multi-Agent LLM Systems Fail?' arXiv:2503.13657, March 2025. MAST-Data: 1,600+ annotated failure traces across 7 multi-agent frameworks."

**CONFIRMED:** The 41% to 86.7% failure rate range is confirmed across multiple indexed sources summarizing the paper. The paper measured failure rates across 7 state-of-the-art (SOTA) open-source MAS frameworks. Presented at NeurIPS 2025 (Datasets and Benchmarks track). ✓

**MINOR ISSUE:** The qualifier "without proper orchestration" mischaracterizes the paper's scope. Cemri et al. studied 7 *state-of-the-art* MAS frameworks — systems that do have orchestration, just imperfect orchestration. The paper measures how often these SOTA systems fail, not a comparison of orchestrated vs. unorchestrated systems. The phrase "without proper orchestration" implies the studied systems are naive or unmanaged, which is incorrect.

**Fix required:** Change "in multi-agent systems without proper orchestration" → "in state-of-the-art multi-agent systems." This accurately reflects the paper's scope (7 SOTA MAS frameworks) without editorializing about the cause of failure.

Also: "Broader studies" (plural) but footnote cites one paper. Consider "Research documents" instead. Low priority — the singular/plural mismatch is common in academic writing.

**Adversa AI — 43% command execution, 38% lacking authentication**

Footnote [^12]: "Adversa AI, 'Top 25 MCP Vulnerabilities,' adversa.ai, March 2026. 43% of MCP servers vulnerable to command execution; 38% lacking authentication."

- **43% command execution:** CONFIRMED — Adversa AI's Top 25 MCP Vulnerabilities article states: "Allows complete server takeover through OS command execution – affects 43% of MCP servers." ✓
- **38% lacking authentication:** CONFIRMED — Adversa AI's own source states "38% of 500+ scanned servers completely lack authentication." (A field analysis by Kai Security using a 539-server dataset independently measured 37.4% = 201/539, but Adversa AI's primary source states 38%.) ✓

### Verdict

**NEAR CLEAN.** One minor fix required before propagation to published chapter.

**Fix for Ghosty (draft):**
- Line 71: "in multi-agent systems without proper orchestration" → "in state-of-the-art multi-agent systems"

**All other new content APPROVED:**
- Regression fixes both correct ✓
- Governance at human speed scenario: illustrative, no sourced claims ✓
- Flat multi-agent failure mechanism description: accurate characterization ✓
- Cemri et al. 41%-86.7% core figure: confirmed ✓
- Adversa AI 43%/38% figures: confirmed ✓

**Routing:** Sending to Ghosty for the one-line qualifier fix. After fix, safe for Chop Pop to propagate to src/chapters/building-the-edge.md.
