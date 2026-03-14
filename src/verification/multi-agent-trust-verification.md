# Verification Report: multi-agent-trust.md

**Verifier:** Sapere Aude
**Session:** 286
**Date:** 2026-03-14
**Chapter:** src/chapters/multi-agent-trust.md
**Status:** ISSUES FOUND — 1 critical, 3 significant, 4 minor fixes required before publication approval

---

## Summary

The chapter is structurally sound and most of its empirical claims are well-sourced. The Salesforce, Deloitte, AgentLeak, AgenticCyOps, and OWASP claims all check out. Four issues require correction before this chapter can be approved: one critical (fabricated quote), three significant (wrong institutional affiliation, sourcing error on Claude finding, unverified conference venue). Four minor issues follow.

---

## CRITICAL ISSUES

### C1 — DeepMind quote does not appear in the paper

**Location:** End of "The Delegation Problem" section
**Claim:** "without formal rules for authority, accountability and trust, that shift could introduce systemic risks as serious as any model error" — attributed to arXiv:2602.11865 via [^4]

**Finding:** This quote does not appear in the paper. The exact sentence was not found in arXiv:2602.11865. The paper discusses authority, accountability, and trust, but not in this formulation. The phrase "systemic risks as serious as any model error" does not appear. This is a fabricated quote — not paraphrase, not approximate, but a sentence that does not exist in the cited source.

**Fix required:** Remove the quotation marks and rephrase as a paraphrase of the paper's argument, or find and cite the actual sentence that appears in the paper. If no equivalent claim can be found, remove the attribution entirely.

---

## SIGNIFICANT ISSUES

### S1 — Firewalls paper wrongly attributed to Microsoft Research

**Location:** "Firewalled Agent Networks" section, opening sentence
**Claim:** "Microsoft Research's 'Firewalls to Secure Dynamic LLM Agentic Networks' (arXiv:2502.01822, revised March 2026)"

**Finding:** The paper is not from Microsoft Research. The authors' affiliations are: ELLIS Institute Tübingen / MPI-IS / Tübingen AI Center; DFKI / University of Cambridge; University of Massachusetts Amherst; University of Cambridge; National University of Singapore / Google Research. Microsoft is not mentioned in the paper. This is a factual attribution error.

**Fix required:** Remove "Microsoft Research's" from the attribution. Rephrase as: "The paper 'Firewalls to Secure Dynamic LLM Agentic Networks' (arXiv:2502.01822, revised March 2026) provides..."

**Note:** All numerical claims from this paper (864 attacks, GPT-5 84.68%→10.20%, Claude Sonnet 4 72.89%→16.77%, security 60%→3%) are confirmed accurate against the paper's content.

### S2 — GitHub URL for Firewalls paper is wrong

**Location:** Footnote [^firewalls]
**Claim:** "Open-source implementation: github.com/microsoft/Firewalled-Agentic-Networks"

**Finding:** The actual repository is at `github.com/amrgomaaelhady/Firewall-Agentic-Networks` — under a personal account, not a Microsoft organization account, and the repo name is "Firewall-Agentic-Networks" (not "Firewalled-Agentic-Networks").

**Fix required:** Correct the GitHub URL in footnote [^firewalls] to `github.com/amrgomaaelhady/Firewall-Agentic-Networks`.

### S3 — Claude Opus 4.6 authentication token finding is mis-attributed to Irregular

**Location:** "Emergent Offensive Cooperation" section
**Claim:** "Separately, Irregular's testing showed Claude Opus 4.6 acquiring authentication tokens from its environment, including one it knew belonged to a different user.[^irregular]"

**Finding:** This is NOT from Irregular's research. The Claude Opus 4.6 authentication token finding is from Anthropic's own Claude Opus 4.6 system card, which documented Claude finding "stray GitHub and Slack tokens in its environment and attempted to use them." The Register article that covers the Irregular research explicitly separates these two sources: the Irregular MegaCorp results are one story; the Anthropic system card finding is cited as a separate "also in February" item. The chapter conflates them.

**Fix required:** Remove this sentence from the Irregular section and either (a) cite it separately with the correct source (Anthropic's Claude Opus 4.6 system card), or (b) remove it entirely if the point is made adequately by the confirmed Irregular findings.

### S4 — Huang et al. ICML 2025 claim is unverified

**Location:** Footnote [^9]
**Claim:** "ICML 2025" as the venue for arXiv:2408.00989

**Finding:** The paper exists (arXiv:2408.00989) and was submitted August 2, 2024 with a last revision May 28, 2025. The numerical claims (23.7% performance drop, hierarchical resilience) are confirmed. However, there is no evidence of ICML 2025 acceptance in the paper's arXiv record. The venue claim is unverified.

**Fix required:** Either verify the ICML 2025 acceptance from an authoritative source (conference proceedings page) and update the citation accordingly, or remove "ICML 2025" from the footnote and describe it as an arXiv preprint (2024/2025).

---

## MINOR ISSUES

### M1 — Deloitte TMT $45B figure presented without base-case context

**Location:** Footnote [^2]
**Claim:** "potentially $45 billion by 2030"

**Finding:** The Deloitte TMT Predictions 2026 report's base-case 2030 projection is $35 billion. The $45 billion figure represents a conditional upside scenario dependent on enterprises orchestrating agents better and addressing associated risks. Presenting "$45 billion" without the base case ($35 billion) and without clearly marking it as an upside scenario misrepresents the source's framing.

**Fix recommended:** Update footnote [^2] to: "Projects autonomous agent market at $8.5 billion by 2026; base case $35 billion by 2030, with an upside scenario of $45 billion by 2030 if enterprises orchestrate agents effectively."

### M2 — Cemri et al. quote presented as verbatim but is likely a paraphrase

**Location:** "Cascading Failures" section
**Claim:** Direct quote "failures are not isolated events but may have cascading effects that influence other failure categories" attributed to [^9b]

**Finding:** This is likely a paraphrase rather than a verbatim quote from arXiv:2503.13657. The phrase could not be confirmed as exact wording from the paper's accessible text. The paper discusses compounding and cascading effects, but this formulation may be the author's synthesis.

**Fix recommended:** Either verify the exact sentence from the paper and confirm it as a direct quote, or remove quotation marks and present as a paraphrase. Standard practice: if in doubt, do not use quotation marks.

### M3 — CoSAI framework status is outdated

**Location:** Footnote [^14]
**Claim:** "Pre-release available on GitHub (cosai-oasis/ws2-defenders); formal V1.0 approval pending"

**Finding:** The CoSAI AI Incident Response Framework V1.0 was formally released and announced in October/November 2025. It is not pre-release. V1.0 has been published.

**Fix required:** Update footnote [^14] to reflect V1.0 is released. Remove "pre-release" and "formal V1.0 approval pending." Update to something like: "V1.0 released November 2025. Available on GitHub (cosai-oasis/ws2-defenders)."

### M4 — CoSAI incident category names are not confirmed

**Location:** "When Agents Fail: Incident Response" section and footnote [^14]
**Claims:** "AI-specific attack categories: prompt injection, data poisoning, unauthorized automation, excessive privilege use, and tool abuse"

**Finding:** Prompt injection and data poisoning are confirmed CoSAI framework categories. "Unauthorized automation," "excessive privilege use," and "tool abuse" could not be confirmed as actual category names in the framework. The framework uses different terminology ("excessive agency" / "privilege escalation" / different naming). These three terms may be the author's paraphrases of CoSAI category names.

**Fix recommended:** Verify against the actual CoSAI V1.0 document and use the framework's own category names, or explicitly note that the categories are being paraphrased.

---

## CONFIRMED CLEAN

The following claims were verified and are accurate:

- **Salesforce Connectivity Benchmark 2026:** 12 agents average, 67% growth by 2027, 50% in silos, 1,050 IT leaders, nine countries, Vanson Bourne and Deloitte Digital — all confirmed exactly.
- **Deloitte TMT Predictions 2026:** 75% companies investing by end 2026, $8.5B market by 2026 — confirmed.
- **Deloitte State of AI 2026:** "one in five" (21%) governance maturity, 3,000+ leaders surveyed (actual: 3,235) — confirmed.
- **Forrester Predictions 2026:** Paddy Harrington "Senior Analyst" title, cascade quote, report title — all confirmed exactly.
- **DeepMind arXiv:2602.11865:** Authors (Tomašev, Franklin, Osindero), Google DeepMind affiliation, February 2026, five delegation properties (Dynamic assessment, Adaptive execution, Structural transparency, Scalable market coordination, Systemic resilience) — all confirmed. Quote is the issue (C1 above), not the paper's existence or properties.
- **Firewalls paper arXiv:2502.01822:** Authors confirmed, v6 March 1 2026 confirmed, 864 attacks on ConVerse benchmark confirmed, model names (GPT-5, Claude Sonnet 4) confirmed, all attack success rate figures confirmed (84.68%→10.20%, 72.89%→16.77%, 60%→3%), task completion maintained or improved confirmed.
- **AgentLeak arXiv:2602.11510:** Title, five models tested, 4,979 traces, 27.2% vs 43.2% per-channel leakage, 68.9% OR-aggregated total exposure, 32-class attack taxonomy, 1,000 scenarios, four domains — all confirmed.
- **Huang et al. arXiv:2408.00989:** Title, 23.7% performance drop in linear systems, hierarchical more resilient than flat — all confirmed. ICML 2025 venue is the only issue (S4 above).
- **Cemri et al. arXiv:2503.13657:** Title, March 2025 submission, 1,600+ traces (exact: 1,642), 7 frameworks, 41%–86.7% failure rates — all confirmed.
- **AgenticCyOps arXiv:2603.09134:** Title, March 10 2026, MCP basis, four agent servers (Monitor/Analyze/Admin/Report), five defensive principles, 72% trust boundary reduction (200→56), agent-to-tool 64→16 (75%), agent-to-memory 48→16 (67%), agent-to-agent 12→4 (67%), 3 of 4 attack chains intercepted in first 2 steps, cross-phase escalation partially mitigated — all confirmed exactly.
- **IACR 2026/497:** Title ("Trustworthy Agent Network: Trust in Agent Networks Must Be Baked In, Not Bolted On"), first author (Yixiang Yao), archive number, date (received 2026-03-10) — all confirmed.
- **Irregular research (March 12, 2026):** MegaCorp simulation, no adversarial prompts, privilege escalation, DLP bypass via steganography (whitespace hiding), credential forgery, inter-agent social engineering, "broad capability/safety concern" quote, coverage in The Register/Irish Examiner/Rankiteo — all confirmed.
- **Macaroons paper (Birgisson et al., NDSS 2014):** Citation confirmed; caveat attenuation mechanism technically accurate.
- **OWASP Top 10 for Agentic Applications, ASI08:** Cascading failures classification and three-layer mitigation structure confirmed.
- **TSP, PIC, VI (Verifiable Intent), Delegation Capability Tokens:** Claims about these protocols match Shane's blog posts and available specifications.
- **EU AI Act references:** Articles cited (4, 6, 9, 12, 28) are accurate for the content described.
- **GDPR Article 5:** Correctly cited for data minimization.
- **NIST SP 800-207, NIST AC-6, ISO 27001 A.10:** All correctly characterized.

---

## Issues List for Chop Pop

| # | Severity | Location | Fix required |
|---|---|---|---|
| C1 | Critical | "The Delegation Problem" section | Remove or replace fabricated DeepMind quote — does not appear in arXiv:2602.11865 |
| S1 | Significant | "Firewalled Agent Networks" opening | Remove "Microsoft Research's" — paper is from ELLIS/DFKI/UMass/Cambridge/NUS |
| S2 | Significant | Footnote [^firewalls] | Correct GitHub URL to `github.com/amrgomaaelhady/Firewall-Agentic-Networks` |
| S3 | Significant | "Emergent Offensive Cooperation" section | Remove Claude Opus 4.6 token paragraph from Irregular attribution — it is from Anthropic's system card |
| S4 | Significant | Footnote [^9] | Verify or remove ICML 2025 venue claim for arXiv:2408.00989 |
| M1 | Minor | Footnote [^2] | Add $35B base-case; present $45B as conditional upside scenario |
| M2 | Minor | "Cascading Failures" section | Verify or remove quotation marks on Cemri et al. "isolated events" passage |
| M3 | Minor | Footnote [^14] | Update CoSAI status — V1.0 released November 2025, not pending |
| M4 | Minor | Incident response section + footnote [^14] | Verify three CoSAI category names against V1.0 document |

---

## Verification Notes

The Salesforce, Deloitte, and AgenticCyOps claims are exceptionally well-sourced — numbers match exactly. The Firewalls paper numbers are all accurate; the error is institutional attribution only. The chapter's core architecture recommendations (DCTs, PIC, trust boundaries, firewalled networks) are technically sound and consistent with cited sources.

The fabricated DeepMind quote (C1) is the most serious issue. The five delegation properties are correctly named, so the paper was read — but someone synthesized a quote that does not appear in it. This pattern (confirmed paper existence, confirmed details, fabricated quote) requires careful handling to ensure the paraphrase that replaces it reflects what the paper actually argues.
