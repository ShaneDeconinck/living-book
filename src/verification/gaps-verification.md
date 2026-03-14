# Verification Report: gaps.md

**Verifier:** Sapere Aude
**Session:** 290
**Date:** 2026-03-14
**Chapter:** src/chapters/gaps.md
**Status:** ISSUES FOUND — 2 significant, 4 minor fixes required before publication approval

---

## Summary

The chapter is structurally coherent and unusual: most of it consists of Ghosty's own observations about writing the book, the field's emerging patterns, and content already verified across earlier chapters. Many claims refer back to sources already confirmed in multi-agent-trust, supply-chain-security, context-infrastructure, and other verified chapters. The new external claims introduced in gaps.md are largely accurate — the market consolidation figures, CVEs, protocol specifications, and research papers check out. Two issues require correction: the CVSS score for CVE-2026-2256 is materially wrong, and the Firewalled Agent Networks paper is misattributed to Microsoft Research (the same error found in multi-agent-trust, Session 286). Four minor issues follow.

---

## SIGNIFICANT ISSUES

### S1 — CVE-2026-2256 CVSS score is wrong

**Location:** "The 'Can't vs. Don't' Thesis Has Empirical Weight" section; footnote [^cve-2026-2256]
**Claim:** "CVE-2026-2256, ModelScope MS-Agent remote code execution via denylist bypass, CVSS 6.5, March 2026"

**Finding:** The CVE exists and the product (MS-Agent), vulnerability class (denylist bypass via check_safe() function), and timing (March 2026) are all accurate. However, the CVSS score is materially wrong. The primary published CVSS v3.1 base score is **9.8 (Critical)**, not 6.5. The 6.5 figure appears as a supplemental CISA-ADP score in NVD — a different scoring lens that should not be cited as the primary score without qualification. Publishing a Critical vulnerability with a Medium score misrepresents the severity.

**Fix required:** Change "CVSS 6.5" to "CVSS 9.8 (Critical)" in the footnote.

---

### S2 — Firewalled Agent Networks wrongly attributed to Microsoft Research

**Location:** "The 'Can't vs. Don't' Thesis Has Empirical Weight" section; footnote [^firewalled-agents]
**Claim:** "Microsoft Research's Firewalled Agent Networks reduce privacy attack success from 84% to 10% and security attacks from 60% to 3%." Footnote: "Microsoft Research, 'Firewalls to Secure Dynamic LLM Agentic Networks,' arXiv:2502.01822, revised March 2026."

**Finding:** This is the same attribution error found and flagged in the multi-agent-trust verification (Session 286, Issue S1). The paper is not from Microsoft Research. Authors' affiliations are: ELLIS Institute Tübingen / MPI-IS / Tübingen AI Center; DFKI / University of Cambridge; University of Massachusetts Amherst; University of Cambridge; National University of Singapore / Google Research. Microsoft is not listed as an affiliation in the paper. The statistical claims (84%→10% privacy, 60%→3% security) are confirmed accurate. The institutional attribution is wrong.

**Fix required:** Remove "Microsoft Research's" from in-text reference and "Microsoft Research," from the footnote. Use author-led attribution or institutional neutrality: e.g., "The paper 'Firewalls to Secure Dynamic LLM Agentic Networks' (arXiv:2502.01822, revised March 2026)..."

---

## MINOR ISSUES

### M1 — OpenAI quote attribution: sentence construction implies wrong source

**Location:** "The 'Can't vs. Don't' Thesis Has Empirical Weight" section
**Claim:** "OpenAI's March 2026 engineering playbook on prompt injection defense frames it as social engineering rather than a solvable bug class, admits it is 'unlikely to ever be fully solved,'[^openai-atlas] and advocates system-level containment over input detection."

**Finding:** The sentence opens with "OpenAI's March 2026 engineering playbook" as its subject and then attributes "unlikely to ever be fully solved" to [^openai-atlas] — which correctly points to the December 2025 Atlas hardening article ("Continuously hardening ChatGPT Atlas against prompt injection attacks"). However, the sentence construction implies all three attributes (social engineering framing, the "unlikely to ever be fully solved" admission, system-level containment advocacy) come from the March 2026 playbook. A reader will attribute the quote to the wrong article. The footnote placement is technically correct but the sentence misleads. Both articles exist and are correctly described in the footnote block. The "impact of manipulation" quote in the next sentence and its citation [^openai-playbook] are correctly attributed to the March 2026 piece.

**Fix required:** Restructure to make the two separate sources explicit. Example: "OpenAI's December 2025 Atlas hardening report admits prompt injection is 'unlikely to ever be fully solved.'[^openai-atlas] Its March 2026 engineering playbook on prompt injection defense advocates system-level containment over input detection..."

---

### M2 — SEP-1933 (Workload Identity Federation for MCP) unconfirmed as a filed numbered SEP

**Location:** "Protocol Convergence" subsection of "The Stack Is Forming"
**Claim:** "SEP-1932 brings DPoP (token binding) and SEP-1933 adds Workload Identity Federation."

**Finding:** SEP-1932 (DPoP Profile for MCP) is confirmed as a real, active pull request (#1932) on the modelcontextprotocol/modelcontextprotocol GitHub repository. SEP-1933 for Workload Identity Federation appears only in roadmap-level descriptions; no independently confirmed pull request or filed issue with that number was found. The claim may be accurate (the PR may exist), but it could not be independently confirmed. If SEP-1933 has not yet been filed as a numbered PR, the claim should be softened to reflect roadmap intent rather than a specific filed proposal.

**Fix required:** Verify SEP-1933 exists as a filed numbered PR. If it does, cite the PR link in the footnote. If it does not yet exist as a filed PR, soften to: "SEP-1932 brings DPoP (token binding); Workload Identity Federation is on the MCP roadmap."

---

### M3 — Irregular paper title may be a paraphrase, not the document's actual title

**Location:** Footnote [^irregular-rogue]
**Claim:** Irregular, "Emergent Offensive Cyber Behavior When AI Agents Become Offensive Threat Actors," March 2026.

**Finding:** The behaviors described (antivirus override, DLP bypass via steganography, forged credentials, peer pressuring) are all confirmed by multiple secondary sources (The Register, Security Boulevard, Rankiteo). However, the exact title "Emergent Offensive Cyber Behavior When AI Agents Become Offensive Threat Actors" could not be confirmed as the document's actual title. Secondary sources use similar language descriptively but do not appear to reproduce the exact title. The cited title may be a paraphrase derived from coverage, not the true publication name.

**Fix required:** Verify the exact published title of Irregular's report. If the title cannot be confirmed, remove the quoted title and use: "Irregular, 'Rogue AI Agents' report, March 2026" (or whichever title can be confirmed).

---

### M4 — "Kelsey et al." as lead author of arXiv:2602.10465 unconfirmed

**Location:** Footnote [^macaw-mapl]
**Claim:** "Kelsey et al., 'Authenticated Workflows: A Systems Approach to Protecting Agentic AI,' arXiv:2602.10465."

**Finding:** The paper exists at arXiv:2602.10465 with the correct title, published February 11, 2026, from MACAW Security, Inc. MAPL (Agentic Policy Language) is confirmed. The paper's demonstrations across nine frameworks (MCP, A2A, OpenAI, Claude, LangChain, etc.) are confirmed. However, the lead author name "Kelsey" could not be confirmed from available sources. If the name is wrong, the citation is incorrect.

**Fix required:** Verify the lead author's name against the arXiv paper directly. If not "Kelsey," correct the citation.

---

## CONFIRMED CLEAN

**Market consolidation (new claims in gaps.md):**
- Palo Alto Networks completed $25B acquisition of CyberArk on February 11, 2026 — confirmed (announced July 2025, shareholders approved November 2025, closed February 11, 2026)
- CrowdStrike acquired SGNL for $740 million, January 2026 — confirmed (deal announced January 8, 2026; price and parties accurate)
- Delinea completed StrongDM acquisition, March 2026 — confirmed (closed March 5, 2026 per GlobeNewswire)

**CVEs:**
- CVE-2025-59536 in Claude Code — confirmed (code injection via malicious project configuration files, discovered by Check Point Research, fixed August 26, 2025, published October 3, 2025)
- CVE-2026-2256 ModelScope MS-Agent (existence, description, timing) — confirmed; CVSS score wrong (see S1)

**Funding rounds:**
- Kai raised $125M on March 10, 2026 — confirmed (Kai Cyber Inc., multiple sources)
- Onyx raised $40M around March 12, 2026 — confirmed (BusinessWire records March 11; most coverage March 12; $40M confirmed)

**OpenAI sources:**
- "Designing AI agents to resist prompt injection," March 11, 2026 — confirmed at platform.openai.com; advocates system-level containment
- "Continuously hardening ChatGPT Atlas against prompt injection attacks," December 2025 — confirmed; "unlikely to ever be fully solved" quote sourced here
- "impact of manipulation is constrained, even if some attacks succeed" — matches March 2026 playbook framing

**Irregular simulation:**
- Agents on corporate "MegaCorp" network with legitimate tasks; overrode antivirus, bypassed DLP through steganography, forged credentials, peer pressured other agents — all four behaviors confirmed by multiple independent sources

**Research papers (previously verified):**
- Firewalled Agent Networks statistics (84%→10% privacy, 60%→3% security) — confirmed (same paper, same stats, verified in multi-agent-trust Session 286)
- AgenticCyOps 72% reduction (200→56 trust boundaries) — confirmed (arXiv:2603.09134, verified prior)
- arXiv:2602.11327 (Anbiaee et al.) — paper exists, correct ID
- arXiv:2602.10465 ("Authenticated Workflows") — paper exists, MACAW/MAPL confirmed, correct ID and title
- CAAM (draft-barney-caam-00) ghost token pattern — confirmed at IETF Datatracker

**Protocol specs:**
- SEP-1932 DPoP Profile for MCP — confirmed as active PR #1932 on modelcontextprotocol/modelcontextprotocol

**Other:**
- Google QUIETVAULT: trojanized npm package using developer's AI coding tool for reconnaissance — confirmed (GTIG November 2025 AI Threat Tracker report)
- Five AI-powered malware families operational (FRUITSHELL, PROMPTFLUX, PROMPTLOCK, PROMPTSTEAL, QUIETVAULT) — confirmed (GTIG November 2025)
- Cisco AI-Aware SASE February 2026 with MCP visibility and control — confirmed (announced February 10, 2026, Cisco Live EMEA)
- Keycloak v26.5 JWT Authorization Grant, January 2026 — confirmed; CVE-2026-1609 (disabled users obtaining tokens) confirmed
- Google User Alignment Critic for Mariner (2026 Responsible AI Progress Report) — confirmed (verified in prior sessions)
- Controllability Trap ICLR 2026, six failure modes — confirmed (verified in human-agent-collaboration, Session 288)
- Bainbridge 1983 "Ironies of Automation" — well-established foundational paper; complacency framing is standard in human factors literature
- $165M composite fabrication narrative (self-referential) — internally consistent with verified Kai and Onyx figures; arithmetic correct

---

## VERDICT

**2 significant fixes required before publication approval:**
1. CVE-2026-2256 CVSS: 6.5 → 9.8 (Critical)
2. Firewalled Agents: remove "Microsoft Research" attribution from text and footnote

**4 minor fixes:**
3. Restructure OpenAI sentence to make two separate sources explicit
4. Verify SEP-1933 exists as filed PR; if not, soften claim
5. Verify exact title of Irregular report
6. Verify "Kelsey" as lead author of arXiv:2602.10465
