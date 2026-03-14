# Verification Report: reliability-evaluation.md

**Verifier:** Sapere Aude
**Session:** 291
**Date:** 2026-03-14
**Chapter:** src/chapters/reliability-evaluation.md
**Status:** ISSUES FOUND — 2 significant, 4 minor fixes required before publication approval

---

## Summary

The chapter is factually solid across its core argument. The benchmark descriptions (SWE-bench, τ-bench, GAIA, HAL), survey statistics (LangChain, Cisco, Dynatrace, Splunk), Lancet colonoscopy study, NIST reports, and OpenAI/Promptfoo acquisition all check out. Two issues require correction: the AgentShield footnote misreports the number of products tested (says 6, benchmark says 7), and the Don Norman 1990 footnote misquotes the paper title (wrong preposition: "of" vs "with"). Four minor issues follow.

---

## SIGNIFICANT ISSUES

### S1 — AgentShield footnote reports "6" products; correct count is 7

**Location:** "The Tool Abuse Blind Spot" section; footnote [^agentshield]
**Claim in text:** "Testing seven commercial products across 537 test cases in eight categories"
**Claim in footnote:** "Open-source benchmark of 6 commercial AI agent security tools across 537 test cases in 8 categories."

**Finding:** The chapter body correctly states "seven commercial products." The footnote contradicts this by saying "6 commercial AI agent security tools." The AgentShield benchmark repository README is unambiguous: "This benchmark currently includes tested results for 7 providers across ML models, SaaS APIs, and pattern-based scanners." The figure of 537 test cases and 8 categories are both confirmed. The "6" in the footnote appears to derive from early press coverage (a Hacker News post title), which predated the final benchmark release or reflected an older count. The authoritative source is the repository itself.

**Fix required:** Correct the footnote from "6 commercial AI agent security tools" to "7 commercial AI agent security products (or providers)."

---

### S2 — Don Norman 1990 paper title misquoted in footnote

**Location:** Footnote [^don-norman-1990]
**Claim:** "Don Norman, 'The Problem of Automation: Inappropriate Feedback and Interaction, Not Over-Automation'"

**Finding:** The actual published title is: **"The 'problem' with automation: inappropriate feedback and interaction, not 'over-automation'"** (Philosophical Transactions of the Royal Society of London. B, Biological Sciences, 1990. DOI: 10.1098/rstb.1990.0101). The chapter's title misquotes it in two ways:
1. **Wrong preposition**: "The Problem *of* Automation" should be "The 'problem' *with* automation." The word "with" versus "of" is not a cosmetic difference — Norman's title is rhetorically constructed to argue the problem lies *with* automation design, not that automation *is* the problem.
2. **Missing quotation marks**: The original places 'problem' and 'over-automation' in scare quotes, which are part of Norman's meaning. The footnote drops both sets of quotes.

The DOI in the footnote is correct and resolves to the right paper.

**Fix required:** Correct the footnote title to: "The 'problem' with automation: inappropriate feedback and interaction, not 'over-automation'"

---

## MINOR ISSUES

### M1 — Dynatrace date discrepancy between body text and footnote

**Location:** "The Observability Shift" section; footnote [^dynatrace-pulse]
**Claim in text:** "Dynatrace's survey of 919 enterprise leaders (March 2026)"
**Claim in footnote:** "Dynatrace, 'The Pulse of Agentic AI in 2026' (January 2026)."

**Finding:** The footnote correctly dates the report to January 2026. The survey was conducted in November–December 2025 and published in January 2026. The body text's "(March 2026)" is incorrect. The statistics (919 leaders, 44% manual review, Y2 Analytics, $100M+ revenue threshold) are all confirmed accurate against the Dynatrace press release.

**Fix required:** Change "March 2026" in the body text to "January 2026" to match the footnote and actual publication date.

---

### M2 — Help Net Security: underlying data source is AIUC-1 Consortium briefing

**Location:** "The Complacency Trap" section; footnote [^agent-security]
**Claim:** "Only 21% of executives report complete visibility into agent permissions, tool usage, or data access patterns" and "80% of organizations surveyed reported risky agent behaviors including unauthorized system access and improper data exposure."
**Footnote cites:** "Help Net Security, 'AI went from assistant to autonomous actor and security never caught up' (March 2026)."

**Finding:** The Help Net Security article exists and contains these figures. However, the statistics originate from an **AIUC-1 Consortium briefing document**, developed with input from Stanford's Trustworthy AI Research Lab and more than 40 security executives. Help Net Security is a secondary source reporting on this briefing. Citing a news article as the source for survey statistics when the actual source is a consortium white paper is weak attribution. The figures themselves are confirmed as reported.

**Fix required:** Either (a) add the AIUC-1 Consortium as the primary source in the footnote, or (b) soften the citation note to make clear these are consortium-reported figures, not an independently published survey. A parenthetical "(citing AIUC-1 Consortium briefing)" would suffice.

---

### M3 — HAL description implies full SWE-bench and τ-bench; HAL uses subsets

**Location:** "The Benchmark Landscape" section; footnote [^hal]
**Claim:** "The Holistic Agent Leaderboard (HAL) from Princeton aggregates results across SWE-bench, GAIA, τ-bench, and other benchmarks into a unified view."

**Finding:** HAL exists, is from Princeton PLI, and was accepted to ICLR 2026 — all confirmed. However, the chapter's description is imprecise in two ways:
1. HAL uses **SWE-bench Verified Mini** (a subset), not the full SWE-bench Verified benchmark.
2. **τ-bench results were excluded from HAL's analysis** due to data leakage found in the few-shot evaluation setup.

The statement that HAL "aggregates results across SWE-bench, GAIA, τ-bench" is technically inaccurate: τ-bench was dropped from the analysis and the SWE-bench version is a mini subset.

**Fix required:** Minor clarification preferred: "HAL from Princeton aggregates results across SWE-bench Verified (Mini), GAIA, and other benchmarks into a unified view." Alternatively, soften to "aggregates results across major agent benchmarks." The τ-bench reference should be removed or noted as excluded.

---

### M4 — Lancet publication date: "August 2025" is online-first; print issue is October 2025

**Location:** Footnote [^clinician-complacency]
**Claim:** "*The Lancet Gastroenterology & Hepatology* (August 2025)"

**Finding:** The paper was published online first on August 12, 2025. The print/journal issue date is **October 2025** (Volume 10, Issue 10, pages 896–903). Citing the online publication date is defensible practice, but it is non-standard without marking it as "online first." The specific statistics — adenoma detection rate 28.4% → 22.4%, 6 percentage point absolute drop, 20% relative decrease — are all confirmed accurate.

**Fix required:** Minor. Consider updating to "published online August 12, 2025; *The Lancet Gastroenterology & Hepatology*, October 2025" to be precise, or add "(online first, August 2025)."

---

## CONFIRMED CLEAN

**Benchmarks:**
- SWE-bench Verified: 500 human-validated samples — confirmed (OpenAI announcement, swebench.com)
- τ-bench (Tau-bench) by Sierra: dynamic user interaction, tool use, function calling/ReAct perform poorly — confirmed (sierra.ai blog, arXiv:2406.12045)
- GAIA Level 3 top score 61% as of mid-2025 (Writer's Action Agent, July 29, 2025) — confirmed
- HAL from Princeton PLI, ICLR 2026 — confirmed (OpenReview, hal.cs.princeton.edu)
- AgentShield: 7 products (body text correct), 537 test cases, 8 categories — confirmed (GitHub repo)

**Survey statistics:**
- LangChain State of AI Agents 2026: 1,300+ respondents (1,340), 57% in production, 32% quality as top barrier — confirmed
- LangChain evaluation percentages: 52% offline evals, 37% online evals, 60% human review, 53% LLM-as-judge, 23% not evaluating (production orgs) — all confirmed
- Cisco State of AI Security 2026: 83% plan agentic AI, 29% feel ready — confirmed verbatim
- Dynatrace 919 leaders, 44% manual review of agent communication, Y2 Analytics, $100M+ threshold — all confirmed (date fix required)
- Splunk CISO Report: 650 global CISOs, 86% fear increased social engineering sophistication — confirmed
- Splunk 82% figure — confirmed (correlation and response speeds); minor wording compression in chapter ("detection and response speed") is acceptable

**Research and reports:**
- Anthropic: 73% of agent tool calls involve human oversight, ~50% in software engineering — both confirmed from Anthropic's "Measuring AI Agent Autonomy in Practice." Footnote [^anthropic-data] correctly cites both Shane's post and Anthropic's original research — attribution is sound.
- arXiv:2602.16666 (Rabanser, Kapoor et al.) "Towards a Science of AI Agent Reliability" — confirmed; paper exists; four-dimension framework (consistency, robustness, predictability, safety) confirmed
- Bainbridge 1983 "Ironies of Automation," *Automatica* 19(6), 775-779 — well-established foundational paper, confirmed
- Don Norman 1990, DOI 10.1098/rstb.1990.0101 — paper confirmed at that DOI; title fix required (S2)
- NIST AI 800-2 "Practices for Automated Benchmark Evaluations of Language Models" — draft confirmed, public comment through March 31, 2026 confirmed
- NIST AI 800-4 "Challenges to the Monitoring of Deployed AI Systems" — confirmed, March 2026, three practitioner workshops basis confirmed
- Lancet colonoscopy study: Budzyń et al., 28.4%→22.4% ADR, 6 point drop, 20% relative decrease — all confirmed (date clarification recommended)

**Events:**
- OpenAI acquisition of Promptfoo, March 9, 2026 — confirmed; 350,000+ developers, 25%+ Fortune 500 — both confirmed
- Help Net Security statistics (21% visibility, 80% risky behaviors) — figures confirmed as reported; attribution note recommended

**Shane blog posts:**
- "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting." (February 2026) — cited at correct URL pattern; not independently verifiable but Shane is primary source for his own work
- "AI Agents Need the Inverse of Human Trust" (February 2026) — same
- "Untangling Autonomy and Risk for AI Agents" (February 2026) — same
- "Trust for Agentic AI" (January 2026) — same
- "Agentic AI: Curated Questions for the Boardroom" (February 2026) — same

---

## VERDICT

**2 significant fixes required:**
1. AgentShield footnote: change "6 commercial AI agent security tools" to "7 commercial AI agent security products"
2. Don Norman 1990 footnote title: correct to "The 'problem' with automation: inappropriate feedback and interaction, not 'over-automation'"

**4 minor fixes:**
3. Dynatrace: change "(March 2026)" in body text to "(January 2026)"
4. Help Net Security: add AIUC-1 Consortium as primary data source in footnote
5. HAL: clarify uses SWE-bench Verified Mini; remove or qualify τ-bench reference
6. Lancet: add "(online first, August 2025)" or update to October 2025 print date
