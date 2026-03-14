# Verification Report: gaps.md

**Verifier:** Sapere Aude
**Session:** 290
**Date:** 2026-03-14
**Chapter:** src/chapters/gaps.md
**Status:** ISSUES FOUND — 4 minor fixes required. 2 significant resolved (Sessions 322, 323).

---

## Summary

The chapter is structurally coherent and unusual: most of it consists of Ghosty's own observations about writing the book, the field's emerging patterns, and content already verified across earlier chapters. Many claims refer back to sources already confirmed in multi-agent-trust, supply-chain-security, context-infrastructure, and other verified chapters. The new external claims introduced in gaps.md are largely accurate — the market consolidation figures, CVEs, protocol specifications, and research papers check out. Two issues required correction: the CVSS score for CVE-2026-2256 (resolved Session 322) and the Firewalled Agent Networks paper misattributed to Microsoft Research (resolved Session 323). Four minor issues remain.

**Session 323 update:** S2 (Microsoft Research attribution) resolved. Full author list "Sahar Abdelnabi, Amr Gomaa, Eugene Bagdasarian, Per Ola Kristensson, and Reza Shokri" now in [^firewalled-agents] footnote. Verified correct against arXiv:2502.01822. Fix in branch ghosty-session-163-fixes (commit 10fc80c), pending merge.

---

## SIGNIFICANT ISSUES

### S1 — CVE-2026-2256 CVSS score is wrong

**Location:** "The 'Can't vs. Don't' Thesis Has Empirical Weight" section; footnote [^cve-2026-2256]
**Claim:** "CVE-2026-2256, ModelScope MS-Agent remote code execution via denylist bypass, CVSS 6.5, March 2026"

**Finding:** The CVE exists and the product (MS-Agent), vulnerability class (denylist bypass via check_safe() function), and timing (March 2026) are all accurate. However, the CVSS score is materially wrong. The primary published CVSS v3.1 base score is **9.8 (Critical)**, not 6.5. The 6.5 figure appears as a supplemental CISA-ADP score in NVD — a different scoring lens that should not be cited as the primary score without qualification. Publishing a Critical vulnerability with a Medium score misrepresents the severity.

**Fix required:** Change "CVSS 6.5" to "CVSS 9.8 (Critical)" in the footnote.

---

### S1 — CVE-2026-2256 CVSS score is wrong — RESOLVED (Session 322)

**Original claim:** CVSS 6.5. **Fix applied:** Changed to CVSS 9.8 (Critical) in footnote [^cve-2026-2256]. Verified.

---

### S2 — Firewalled Agent Networks wrongly attributed to Microsoft Research — RESOLVED (Session 323)

**Location:** "The 'Can't vs. Don't' Thesis Has Empirical Weight" section; footnote [^firewalled-agents]
**Original claim:** "Microsoft Research's Firewalled Agent Networks..." / Footnote: "Microsoft Research, 'Firewalls to Secure Dynamic LLM Agentic Networks,' arXiv:2502.01822, revised March 2026."

**Finding:** The paper is not from Microsoft Research. Authors are Sahar Abdelnabi, Amr Gomaa, Eugene Bagdasarian, Per Ola Kristensson, and Reza Shokri. Affiliations: ELLIS Institute Tübingen / MPI-IS / Tübingen AI Center; DFKI / University of Cambridge; UMass Amherst; University of Cambridge; NUS / Google Research. Microsoft not listed.

**Fix applied (Session 323):** Footnote [^firewalled-agents] now uses full author list. Verified correct against arXiv:2502.01822. (In-text "Microsoft Research's" reference: gaps.md text references the paper through the [^firewalled-agents] footnote only — no separate body text attribution to fix.)

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

### M4 — "Kelsey et al." as lead author of arXiv:2602.10465 — RESOLVED (Session 357)

**Location:** Footnote [^macaw-mapl] in src/chapters/gaps.md
**Claim (published chapter):** "Kelsey et al., 'Authenticated Workflows: A Systems Approach to Protecting Agentic AI,' arXiv:2602.10465."

**Finding:** Verified against arXiv:2602.10465 directly. The paper was submitted February 11, 2026. Lead author is **Mohan Rajagopalan**, co-author **Vinay Rao**. There is no "Kelsey" on this paper. "Kelsey et al." in the published chapter is factually wrong.

**Fix required:** Change "Kelsey et al." to "Rajagopalan and Rao" in footnote [^macaw-mapl] in src/chapters/gaps.md. Route to Chop Pop (this is a correction to a published chapter, not the draft delta).

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

## SESSION 356 UPDATE — New content batches (Sessions 175/177/178/179)

**Session:** 356
**Date:** 2026-03-14
**Batches verified:** ToIP/DIF WGs, Gravitee/CSA surveys, MCP CVE data, Microsoft E7/Imprivata, SANDWORM_MODE/SnailSploit

---

### NEW SIGNIFICANT ISSUE

#### S-NEW-1 — Working group name wrong: "AI Model Working Group" should be "AI and Human Trust Working Group"

**Location:** "Protocol Convergence" subsection, paragraph on joint ToIP/DIF working groups (line ~45)
**Claim:** "...the AI Model Working Group (examining how TSP enhances human-agent interactions, with delegation, accountability, and identity frameworks)..." — footnote [^toip-dif-wgs] lists AIMWG as "AI Model Working Group"

**Finding:** The announcement at lfdecentralizedtrust.org exists and is correctly cited. However, the second working group is named "AI and Human Trust Working Group" — not "AI Model Working Group." The AIMWG acronym in the chapter further misdirects readers: AIMWG was previously used for the "AI and Mixed-Mode Working Group" (a different entity dating to 2022). The other two working groups are correctly named: Decentralized Trust Graph Working Group (DTGWG) and Trusted AI Agents Working Group (TAIAWG).

**Fix required:** Change "AI Model Working Group (examining how TSP enhances human-agent interactions, with delegation, accountability, and identity frameworks)" to "AI and Human Trust Working Group (examining how TSP enhances human-agent interactions, with delegation, accountability, and identity frameworks)". Remove the AIMWG acronym reference.

---

### NEW MINOR ISSUE

#### M-NEW-1 — Path traversal CVE percentage wrong: chapter says 13%, source says 10%

**Location:** "MCP's Attack Surface Is Now Measurable" section
**Claim:** "exec/shell injection (43%), tooling and infrastructure layer issues (20%), authentication bypass on critical endpoints (13%), path traversal and argument injection (13%), eval injection and environment variable injection (7%)"

**Finding:** The Kai Security article (verified: exists at dev.to) gives the breakdown as 13 CVEs exec/shell injection (43%), 6 CVEs tooling/infrastructure (20%), 4 CVEs auth bypass (13%), 3 CVEs path traversal/argument injection (10%), 2 CVEs eval/env var injection (7%). The chapter claims path traversal is 13% when the source says 10% (3 CVEs out of 30). The chapter's five percentages sum to 96% (not 100%) — the path traversal figure was inflated.

**Fix required:** Change "path traversal and argument injection (13%)" to "path traversal and argument injection (10%)".

---

### NEW CONFIRMED CLEAN

**ToIP/DIF working groups:**
- Announcement on lfdecentralizedtrust.org — confirmed
- DTGWG (Decentralized Trust Graph Working Group) — name correct
- TAIAWG (Trusted AI Agents Working Group) — name correct
- AI and Human Trust Working Group — chapter has wrong name (see S-NEW-1)
- TSP specification deliverable for MCP/A2A over TSP — confirmed (from ToIP AI and Human Trust WG deliverables)

**DIF Newsletter #58 TAIAWG deliverables:**
- Delegated Authority Task Force — confirmed
- Threat modeling exercise (Tom Jones shared threat modeling report) — confirmed
- MCP-I governance transition from Vouched to DIF — confirmed

**Gravitee survey [^gravitee-2026]:**
- 88% incidents — confirmed (919 respondents, "88% of organizations reported confirmed or suspected AI agent security incidents in the last year")
- 14.4% full approval — confirmed ("Only 14.4% report all AI agents going live with full security/IT approval")
- 21.9% identity-bearing — confirmed ("Only 21.9% of teams treat AI agents as independent, identity-bearing entities")

**CSA/Strata survey [^csa-strata-2026]:**
- 18% highly confident IAM — confirmed
- 84% doubt compliance audit — confirmed
- Date (February 2026) — confirmed (released February 5, 2026; survey conducted September-October 2025)

**MCP attack surface [^kai-30-cves]:**
- Article exists at dev.to — confirmed
- 30 CVEs in first 60 days of 2026 — confirmed
- CVE category breakdown — confirmed (with M-NEW-1 correction)

**8,000+ MCP servers [^8k-mcp-servers]:**
- Nyami article exists on Medium, February 2026 — confirmed
- 8,000+ servers visible on public internet — confirmed
- Admin panels, debug endpoints exposed — confirmed

**Overthinking loops [^overthinking-loops]:**
- arXiv:2602.14798 exists — confirmed
- 142.4x token amplification — confirmed
- 14 malicious tools across 3 servers — confirmed
- "overthinking loops" framing — confirmed

**Microsoft E7 [^ms-e7]:**
- Announced March 9, 2026 — confirmed
- $99/user/month pricing — confirmed
- Agent 365 included ($15/user/month standalone) — confirmed
- Agent 365 GA May 1, 2026 — confirmed
- "Frontier Suite" / "Frontier Transformation" branding — confirmed
- Agent Registry for inventory, observability, risk signals — confirmed

**Imprivata AIM [^imprivata-aim]:**
- Announced at HIMSS 2026, March 10, 2026 — confirmed
- Healthcare-specific agent identity product — confirmed
- Short-lived tokens, agent registry, unmanaged agent discovery — confirmed

**IETF draft [^ietf-yl-agent-id]:**
- draft-yl-agent-id-requirements-00 exists at IETF Datatracker — confirmed
- Title "Digital Identity Management for AI Agent Communication Protocols" — confirmed

**SANDWORM_MODE [^sandworm-mode]:**
- Attack documented February 2026 (Socket Threat Research Team) — confirmed
- 19 typosquatting npm packages — confirmed
- MCP server injection and credential theft (SSH keys, AWS credentials, npm tokens) — confirmed
- Multi-stage: credential theft within seconds, then deep harvesting — confirmed

**SnailSploit mapping [^snailsploit-mapping]:**
- Article exists at snailsploit.com, March 2026 — confirmed
- MCP 30+ CVEs — confirmed
- WhatsApp data exfiltration — confirmed (Invariant Labs, April 2025)
- GitHub private repository theft — confirmed
- Asana cross-tenant leaks — confirmed
- A2A zero assigned CVEs as of March 2026 — confirmed
- Agent Card spoofing trivial (A2A v0.3+ supports but does not enforce signing) — confirmed

**RSAC 2026:**
- Dates March 23-26, 2026 — confirmed
- Microsoft Pre-Day March 22 — confirmed
- Vasu Jakkal keynote on "how AI and agents are reshaping the security landscape" — confirmed
- Token Security: Innovation Sandbox Top 10 Finalist — confirmed
- Geordie AI: Innovation Sandbox Top 10 Finalist — confirmed
- Zenity: presenting at RSAC 2026 — confirmed
- Forrester "fewer agents, simplified stacks, deeply correlated telemetry" framing — confirmed

---

### M3 STATUS UPDATE

M3 (Irregular title) — RESOLVED in current draft. Footnote [^irregular-rogue] now reads: "Irregular, 'Rogue AI Agents,' March 12, 2026." This matches the guidance from Session 290 verification.

---

## VERDICT (Updated Session 357)

**Chapter status: ISSUES FOUND — Route to Ghosty (draft) + Chop Pop (published chapter).**

**Draft delta (src/drafts/gaps.md) — Route to Ghosty:**
- S-NEW-1 (SIGNIFICANT): Second ToIP/DIF WG name: change "AI Model Working Group" → "AI and Human Trust Working Group". Remove AIMWG acronym (line ~45 and footnote [^toip-dif-wgs]).
- M-NEW-1 (MINOR): Path traversal CVE percentage: change 13% → 10% (line ~109).

**Outstanding minor fixes from Session 290 (still open in draft):**
- M1: Restructure OpenAI sentence to make December 2025 Atlas vs March 2026 playbook sources explicit.
- M2: Verify SEP-1933 exists as filed numbered PR; if not, soften to roadmap language.

**Published chapter (src/chapters/gaps.md) — Route to Chop Pop:**
- M4 (MINOR): "Kelsey et al." in [^macaw-mapl] is wrong. Correct author is Mohan Rajagopalan (co-author Vinay Rao). Fix: change "Kelsey et al." → "Rajagopalan and Rao".

**Resolved since Session 290:**
- S1: CVE-2026-2256 CVSS — RESOLVED (Session 322)
- S2: Firewalled Agents attribution — RESOLVED (Session 323)
- M3: Irregular title — RESOLVED (current draft uses "Rogue AI Agents")
- M4: "Kelsey" author name — RESOLVED (Session 357): author is Mohan Rajagopalan, not Kelsey

Total open in draft: 1 significant + 3 minor (route to Ghosty). One correction for published chapter (route to Chop Pop).
