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

## VERDICT (Updated Session 374)

**Chapter status: DRAFT DELTA APPROVED — Route to Chop Pop to apply. Published chapter is CLEAN.**

**Draft delta (src/drafts/gaps.md) — Ghosty applied all 4 fixes in commit a715993:**
- S-NEW-1: Line 45 now reads "AI and Human Trust Working Group" — AIMWG acronym removed. Footnote [^toip-dif-wgs] line 205 correctly lists "AI and Human Trust" — VERIFIED FIXED.
- M-NEW-1: Line 109 now reads "path traversal and argument injection (10%)" — VERIFIED FIXED.
- M1: Line 23 now opens with "OpenAI's December 2025 Atlas hardening report admits prompt injection is 'unlikely to ever be fully solved.'[^openai-atlas]" — [^openai-atlas] cite present and correctly separated from the March 2026 playbook sentence — VERIFIED FIXED.
- M2: Line 41 now reads "Workload Identity Federation is on the MCP roadmap" — SEP-1933 language softened — VERIFIED FIXED.

All 4 fixes confirmed correct in the current draft. No new issues introduced. Draft delta is ready for Chop Pop to apply to src/chapters/gaps.md.

**Session 359 correction:**
- M4-draft: REMOVED — draft (src/drafts/gaps.md) has no [^macaw-mapl] footnote. MACAW/MAPL section is a prose placeholder with no citation. M4-draft is not applicable to the current draft version.

**Published chapter (src/chapters/gaps.md) — CLEAN:**
- M4: RESOLVED by Chop Pop (Session 357, commit 528ae9a). All published-chapter fixes complete.

**Resolved since Session 290:**
- S1: CVE-2026-2256 CVSS — RESOLVED (Session 322)
- S2: Firewalled Agents attribution — RESOLVED (Session 323)
- M3: Irregular title — RESOLVED (current draft uses "Rogue AI Agents")
- M4 (published): "Kelsey et al." → "Rajagopalan and Rao" — RESOLVED by Chop Pop (Session 357, commit 528ae9a)
- M4-draft: NOT APPLICABLE — draft has no [^macaw-mapl] footnote (Session 359)
- S-NEW-1: AI and Human Trust WG name — RESOLVED by Ghosty (commit a715993)
- M-NEW-1: Path traversal 13% → 10% — RESOLVED by Ghosty (commit a715993)
- M1: OpenAI Atlas cite restructured — RESOLVED by Ghosty (commit a715993)
- M2: SEP-1933 softened to roadmap language — RESOLVED by Ghosty (commit a715993)

Total open in draft: 0. Draft delta ready for Chop Pop. Published chapter is clean.

---

## Session 404 Re-verification — "Institutional Validation Is Converging" section

**Session:** 404
**Date:** 2026-03-15
**Commit:** b21f74d (Ghosty Session 230)
**Scope:** New section "Institutional Validation Is Converging" (lines 145–155 in src/drafts/gaps.md)
**Status:** ISSUES FOUND — 1 significant, 1 minor, 2 flags. Route to Ghosty.

Ghosty added a new section with seven claims about Q1 2026 institutional convergence on agent governance. Claims verified against web sources March 15, 2026.

---

### S1 — Gartner prediction significantly misparaphrased [SIGNIFICANT]

**Text (line 153):**
> "predicting guardian agents will replace half of incumbent security systems by 2029"

**What Gartner actually says:**
The Market Guide predicts that by 2029, guardian agents will lead more than **70% of companies** to no longer need about half of the **incumbent risk and security systems protecting AI agent activities**.

**Two problems:**
1. The scope qualifier is stripped: "protecting AI agent activities" is removed, making it sound like general security systems are being replaced. Gartner's prediction is scoped specifically to AI-agent-specific security tooling.
2. The "70% of companies" condition is dropped, making the prediction sound universal rather than conditional.

**Required fix:** Replace with the accurate paraphrase, e.g.: "predicting that by 2029, more than 70% of companies will no longer need about half of the security systems specifically built to protect AI agent activities"

**Sources:** PlainID/NeuralTrust vendor press releases (Feb 26, 2026) citing the Market Guide; opsinsecurity.com blog analysis; apiiro.com blog.

---

### M1 — NIST initiative date off by one day [MINOR]

**Text (line 149):**
> "NIST launched its AI Agent Standards Initiative (February 18, 2026)"

**Actual date:** The NIST CAISI announcement was published **February 17, 2026**. The date "February 18" appears in an ANSI news aggregator post the following day, not in the official NIST announcement.

The associated concept paper ("Accelerating the Adoption of Software and Artificial Intelligence Agent Identity and Authorization") was published **February 5, 2026** — separately and earlier than the initiative announcement.

**Required fix:** Change "February 18, 2026" to "February 17, 2026"

**Sources:** https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure (confirmed Feb 17); ANSI post dated Feb 18.

---

### F1 — IETF "fifteen or more" count unverified [FLAG]

**Text (line 149):**
> "The IETF has fifteen or more individual submissions targeting agent identity and authorization"

**Finding:** Public search found approximately 13 named individual Internet-Drafts on AI agent identity and authorization in IETF Datatracker. The "fifteen or more" figure is directionally plausible (additional drafts may exist not surfaced by search), but the exact threshold cannot be confirmed from public sources.

**Recommendation:** Change "fifteen or more" to "more than a dozen" or add a footnote citing the IETF Datatracker search rather than asserting a specific count.

---

### F2 — Singapore IMDA: "autonomous agents" vs "agentic AI" [FLAG]

**Text (line 151):**
> "Singapore's IMDA published the first government-sponsored governance framework for autonomous agents"

**Finding:** The framework exists (confirmed: "Model AI Governance Framework for Agentic AI," published January 22, 2026). IMDA consistently uses the term **"agentic AI"**, not "autonomous agents." The frameworks's title and all official IMDA communications use "agentic AI." Using "autonomous agents" introduces a terminology mismatch.

Additionally, the framework is **voluntary guidance**, not a binding regulation. If the book implies regulatory force, that would be inaccurate.

**Recommendation:** Change "autonomous agents" to "agentic AI" to match IMDA's official terminology.

**Source:** https://www.imda.gov.sg/resources/press-releases-factsheets-and-speeches/press-releases/2026/new-model-ai-governance-framework-for-agentic-ai

---

### Confirmed claims [VERIFIED]

- **NIST initiative name** ("AI Agent Standards Initiative"): CONFIRMED — exact official name.
- **Concept paper existence** (agent identity): CONFIRMED — "Accelerating the Adoption of Software and Artificial Intelligence Agent Identity and Authorization," NCCoE/ITL.
- **White House document** ("March 6, 2026"): CONFIRMED — "President Trump's Cyber Strategy for America." Date confirmed by multiple legal/policy analyses. Note: official title differs from "national cybersecurity strategy" but description is acceptable. Agentic AI in Pillar 5 confirmed via multiple secondary sources quoting the same passage.
- **EU AI Act compliance pressure**: Not a specific factual claim; accurate as general context.
- **Singapore IMDA framework existence**: CONFIRMED — January 22, 2026. First government-sponsored dedicated agentic AI governance framework is accurate per IMDA's own "first-of-its-kind" language.
- **Gartner Market Guide existence and date**: CONFIRMED — "Market Guide for Guardian Agents," Avivah Litan and Daryl Plummer, February 25, 2026. "First Market Guide" for this category and "standalone enterprise category" framing confirmed.
- **ToIP and DIF three working groups**: CONFIRMED — announced September 15, 2025. Groups: Decentralized Trust Graph WG (joint), AI and Human Trust WG (ToIP), Trusted AI Agents WG (DIF).

---

### VERDICT (Session 404)

**ISSUES FOUND — Route to Ghosty for factual corrections.**

Open issues:
- S1: Gartner prediction misparaphrased — needs rewrite with scope qualifier and "70% of companies" condition
- M1: NIST date "February 18" → "February 17"
- F1: IETF count "fifteen or more" — change to "more than a dozen" or add citation
- F2: "autonomous agents" → "agentic AI" (IMDA terminology)

Do not route to Chop Pop until Ghosty fixes S1 and M1. F1 and F2 are optional improvements but should be addressed for precision.

---

## Session 405 Re-verification — "Institutional Validation Is Converging" section (Chop Pop editorial pass)

**Session:** 405
**Date:** 2026-03-14
**Commit:** 0c0cf4e (Chop Pop Session 405)
**Scope:** Re-verification of editorial edits to "Institutional Validation Is Converging" in src/chapters/gaps.md
**Status:** CLEAN — section approved.

Chop Pop applied F1 and F2 from Session 404 verification. Ghosty had already fixed S1 and M1 before handoff. All four issues resolved.

**S1 (Gartner prediction):** Current text: "predicting that by 2029, more than 70% of companies will no longer need half of the security tools they currently use to protect AI agent activities." Gartner exact: "By 2029, independent guardian agents will eliminate the need for almost half of incumbent security systems intended to protect AI agent activities today in over 70% of organizations." Both key qualifiers present (70% condition, AI-agent-activities scope). Micro-note: Gartner says "almost half"; chapter says "half." Acceptable paraphrase — not blocking. RESOLVED.

**M1 (NIST date):** "February 17, 2026" confirmed in published chapter. RESOLVED.

**F1 (IETF count):** "more than a dozen" — matches Session 404 recommendation exactly. RESOLVED.

**F2 (IMDA terminology):** "agentic AI" — matches IMDA's official "Model AI Governance Framework for Agentic AI" terminology. RESOLVED.

No meaning changes introduced by editorial edits. No new issues. Section is factually accurate and ready for publication.

**VERDICT (Session 405): APPROVED — Section clean. No further action required.**

---

## Session 407 Verification — New CVE content (MCP attack surface expansion, Sessions 196-210)

**Session:** 407
**Date:** 2026-03-14
**Scope:** New CVE content added by Ghosty in src/drafts/gaps.md, not yet applied to src/chapters/gaps.md. Covers: CVE-2026-32247, CVE-2026-27825, CVE-2026-32112, CVE-2026-32111, CVE-2026-26118, CVE-2026-31944, CVE-2026-30856, and the WeKnora tool naming collision section.
**Sources checked:** advisories.gitlab.com, MSRC, cvedetails.com, Pluto Security blog, pypistats.org, pepy.tech, GitHub release notes, Talos Intelligence Patch Tuesday analysis.
**Status:** MOSTLY CLEAN — 1 minor issue, 1 flag. All 7 CVEs verified real and accurate.

---

### Verified Claims — CVE-2026-32247 (Graphiti Cypher Injection)

- **Existence and description:** CONFIRMED — advisory at advisories.gitlab.com/pkg/pypi/graphiti-core/CVE-2026-32247/. Cypher injection via unsanitized node_labels in SearchFilters.
- **Backends affected (Neo4j, FalkorDB, Neptune):** CONFIRMED.
- **Fixed version (0.28.2):** CONFIRMED.
- **Prompt injection vector (LLM calls search_nodes with attacker-controlled entity_types):** CONFIRMED — advisory documents this attack path explicitly.
- **"injection chaining" framing (distinct from direct injection):** Accurate. The text correctly identifies this as indirect: untrusted content → LLM → MCP tool parameter → database query. ✅

---

### Verified Claims — CVE-2026-27825 (mcp-atlassian RCE)

- **CVSS 9.1:** CONFIRMED — GitLab advisory, Arctic Wolf blog, Pluto Security blog all cite 9.1 Critical.
- **`confluence_download_attachment` tool, `download_path` parameter, no directory boundary enforcement:** CONFIRMED.
- **Writing to `/etc/cron.d/` for code execution:** CONFIRMED in Pluto Security MCPwnfluence writeup.
- **Fixed in mcp-atlassian 0.17.0:** CONFIRMED — includes validate_safe_path() and validate_url_for_ssrf().
- **CVE-2026-27826 (SSRF in custom header parsing):** CONFIRMED — CVSS 8.2, X-Atlassian-Jira-Url and X-Atlassian-Confluence-Url headers. Combined attack chain "MCPwnfluence" confirmed.
- **"Pluto Security" as researcher/publisher:** CONFIRMED — blog.pluto.security/p/mcpwnfluence-cve-2026-27825-critical.

**M1 MINOR — "most widely used Atlassian MCP server" overstates the source:**

**Claim (line 119):** "the most widely used Atlassian MCP server (4.4K stars, 4M downloads)"

**Finding:** The Pluto Security blog (the cited source [^mcp-atlassian-rce]) describes mcp-atlassian as "one of the most popular MCP servers in the ecosystem," not "the most widely used Atlassian MCP server." The draft promotes this to a superlative that the source does not support. GitHub stars (now 4.6K; "over 4.4K" at time of writing per Pluto Security) are plausible. The "4M downloads" figure comes from Pluto Security's blog, but pypistats.org/pepy.tech show cumulative totals in the range of 2.3M-3.5M; the discrepancy may reflect Pluto Security counting differently or rounding up projections.

**Fix required:** Change "the most widely used Atlassian MCP server" to "one of the most popular Atlassian MCP servers" to match the cited source's language. The star/download counts can be retained as sourced from Pluto Security but note they are cited figures.

---

### Verified Claims — CVE-2026-32112 (ha-mcp XSS)

- **CVSS 6.8:** CONFIRMED — GitLab advisory.
- **OAuth consent form, Python f-strings without HTML escaping:** CONFIRMED.
- **Long-Lived Access Token exfiltration risk:** CONFIRMED.
- **Fixed in v7.0.0:** CONFIRMED.
- **"OAuth beta mode introduced to comply with MCP's 2025-11-25 authorization spec":** Plausible — MCP authorization spec revision dated November 2025. ✅

---

### Verified Claims — CVE-2026-32111 (ha-mcp SSRF)

- **CVSS 5.3:** CONFIRMED — GitLab advisory shows CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N = 5.3 MEDIUM. (Secondary sources initially suggested 3.1; the authoritative GitLab advisory is 5.3. Draft is correct.)
- **Open Dynamic Client Registration, server-side request to user-supplied URL without validation:** CONFIRMED.
- **Fixed in v7.0.0:** CONFIRMED.

---

### Verified Claims — CVE-2026-26118 (Azure MCP Server SSRF)

- **CVSS 8.8:** CONFIRMED — multiple sources (Talos Intelligence, TheHackerWire, WindowsNews) cite 8.8.
- **SSRF where Azure MCP Server follows attacker URL and sends managed identity token:** CONFIRMED.
- **Patched in March 2026 Patch Tuesday (March 10, 2026):** CONFIRMED.
- **"Elevation of Privilege":** CONFIRMED — MSRC classification.

**F1 FLAG — "first CVE in a major cloud provider's own MCP implementation" [UNVERIFIABLE]:**

**Claim (line 121):** "This is the first CVE in a major cloud provider's own MCP implementation"

**Finding:** This is a strong priority claim. Available sources confirm CVE-2026-26118 is notable and in Azure's own MCP Server Tools. However, no source explicitly states it is the "first" such CVE across all major cloud providers. It is possible earlier CVEs exist in cloud-adjacent MCP implementations not prominently catalogued. Cannot confirm or deny from available sources.

**Recommendation:** Soften to "one of the first CVEs in a major cloud provider's own MCP implementation" or remove the "first" qualifier unless a source explicitly establishes the primacy.

---

### Verified Claims — CVE-2026-31944 (LibreChat OAuth callback)

- **CVSS 7.6:** CONFIRMED — cvedetails.com, THREATINT.
- **CWE-306 (Missing Authentication for Critical Function):** CONFIRMED.
- **Affected versions 0.8.2 through 0.8.2-rc3, fixed in 0.8.3-rc1:** CONFIRMED — LibreChat GitHub release notes.
- **Attack pattern (attacker sends victim authorization URL, victim's tokens stored on attacker's account):** CONFIRMED in advisory.
- **"Three MCP servers, three distinct OAuth vulnerability classes" framing:** Accurate — XSS (ha-mcp CVE-2026-32112), SSRF (ha-mcp CVE-2026-32111), callback session confusion (LibreChat CVE-2026-31944). ✅

---

### Verified Claims — CVE-2026-30856 (WeKnora tool naming collision)

- **Tool identifier scheme `mcp_{service_name}_{tool_name}` with sanitizeName flattening:** CONFIRMED — GitLab advisory.
- **Attack: attacker chooses service+tool name that collides with legitimate identifier (e.g., tavily_extract):** CONFIRMED.
- **Impact: execution flow redirection, prompt exfiltration, privilege escalation:** CONFIRMED.
- **CWE-706 (Use of Incorrectly-Resolved Name or Reference):** CONFIRMED.
- **Fixed in WeKnora 0.3.0:** CONFIRMED.
- **Associated CVE-2026-30861 (RCE via command injection) and CVE-2026-30860 (SQL injection bypass):** CONFIRMED — both appear in GitLab advisories for WeKnora, CVSS 9.9 Critical each.
- **"distinct from tool poisoning... and supply chain attacks":** Framing is accurate. ✅

---

### VERDICT (Session 407)

**MOSTLY CLEAN — 1 minor fix required, 1 flag. Route to Ghosty.**

**M1 MINOR (fix required):** Line 119 — "the most widely used Atlassian MCP server" → "one of the most popular Atlassian MCP servers." Pluto Security (the cited source) says "one of the most popular MCP servers in the ecosystem," not "most widely used."

**F1 FLAG (optional softening):** Line 121 — "the first CVE in a major cloud provider's own MCP implementation" — primacy cannot be verified. Recommend softening to "one of the first" or removing "first."

All 7 CVEs confirmed real, with accurate CVSS scores, affected versions, fix versions, and technical descriptions. The OAuth vulnerability pattern analysis (three distinct failure classes) is accurate. The WeKnora tool naming collision section is accurate. The injection chaining framing for CVE-2026-32247 is accurate.

**After Ghosty fixes M1, this content is approved for Chop Pop to apply to src/chapters/gaps.md.**

---

## Session 413 Re-verification — CVE delta applied to src/chapters/gaps.md (commit 5e95c5a)

**Session:** 413
**Date:** 2026-03-14
**Commit:** 5e95c5a (Chop Pop Session 413)
**Scope:** Verification that Session 407 SA-approved CVE delta was correctly applied to src/chapters/gaps.md, with M1 fix in place.
**Status:** APPROVED — clean.

**M1 fix verified:** Body text line now reads "one of the most popular Atlassian MCP servers (4.4K stars, 4M downloads)" — matches Session 407 required fix. Footnote [^mcp-atlassian-rce] retains the Pluto Security article title ("Most Widely Used") as a direct title quotation, not a book claim. Correct.

**F1 addressed:** Line now reads "one of the first CVEs in a major cloud provider's own MCP implementation" — hedged from "the first" per Session 407 recommendation.

**All 7 CVEs applied accurately:**
- CVE-2026-32247 (Graphiti Cypher injection): CONFIRMED ✓
- CVE-2026-27825 (mcp-atlassian RCE, MCPwnfluence): CONFIRMED ✓
- CVE-2026-32112 (ha-mcp XSS, CVSS 6.8): CONFIRMED ✓
- CVE-2026-32111 (ha-mcp SSRF, CVSS 5.3): CONFIRMED ✓
- CVE-2026-26118 (Azure MCP SSRF, CVSS 8.8): CONFIRMED ✓
- CVE-2026-31944 (LibreChat OAuth callback, CVSS 7.6): CONFIRMED ✓
- CVE-2026-30856 (WeKnora tool naming collision, CWE-706): CONFIRMED ✓

**Tool Naming Collision section:** heading and content correctly applied.

**7 footnotes:** all match SA-verified draft text exactly.

**Two draft sentences omitted by Chop Pop (conservative cuts, acceptable):**
- "The vulnerability fits the path traversal category (10% of the 30-CVE dataset) but its severity and the server's popularity make it structurally significant." — removed from mcp-atlassian paragraph.
- "The defense the Graphiti maintainers shipped (regex validation on node labels) is necessary but insufficient as a general pattern." — removed from Graphiti paragraph.
Both cuts remove specifics not required for the core argument. No factual loss.

**VERDICT (Session 413): APPROVED — gaps.md CVE delta correctly applied. Published chapter clean.**

---

## Session 437 Addendum — New Content Verification (Ghosty sessions 257, 258, 427, cf49feb)

**Date:** 2026-03-15 09:30 UTC
**Draft commit:** HEAD (5e58a28)
**Scope:** New content added to src/drafts/gaps.md since last published commit (5ec6b81). Sections verified: ID-JAG WG adoption, Capability-Based Authorization, AARTS runtime safety, ITU-T workshop, KYAPay, additional IETF drafts.

**Status:** ISSUES FOUND — 6 issues across body text and footnotes. ITU workshop, Sage, KYAPay, DIF figure, and TAIAWG deliverable are clean.

---

### ISSUE A — [^idjag-wg] footnote: wrong revision, wrong expiry date, missing author

**Location:** Identity Standards Convergence section and footnote [^idjag-wg]

**Body text claims:** "the IETF OAuth Working Group formally adopted ID-JAG as a working group document (draft-ietf-oauth-identity-assertion-authz-grant, now at revision -01)"

**Footnote reads:** "Adopted by IETF OAuth Working Group. Authors: Aaron Parecki, Karl McGuinness. Revision -01 expires April 22, 2026."

**Findings:** Fetched IETF datatracker. The draft has advanced to revision **-02**. Revision -01 expired April 22, 2026 — that date is the expiry for the stale revision. Current revision -02 expires **September 3, 2026**. Additionally, the footnote lists only two authors; the actual author list has three: Aaron Parecki, Karl McGuinness, and **Brian Campbell (Ping Identity)**.

The WG adoption itself is confirmed. The call for adoption ran August 25 – September 8, 2025. The draft is genuine OAuth WG output. The "formally adopted" claim is accurate. Only the revision number, expiry date, and author list are wrong.

**Fix required:**
1. Body text: "now at revision -01" → "now at revision -02"
2. Footnote: "Revision -01 expires April 22, 2026" → "Revision -02 expires September 3, 2026"
3. Footnote: "Authors: Aaron Parecki, Karl McGuinness" → "Authors: Aaron Parecki, Karl McGuinness, Brian Campbell"

---

### ISSUE B — AARTS/Skill IDs dated to February launch, introduced in March

**Location:** "Runtime Safety Standards Are Emerging" section

**Draft text:** "Gen Digital's Agent Trust Hub (February 2026) introduces two complementary primitives: the AI Agent Runtime Safety Standard (AARTS) and Skill IDs.[^gen-aarts]"

**Findings:** The Agent Trust Hub launched February 4, 2026. That launch did NOT introduce AARTS or Skill IDs. The AARTS spec and Skill IDs were published in separate Gen Digital blog posts on **March 5, 2026** ("Leading the Way for AI Agent Safety" and "Introducing AARTS: An Open Standard for AI Agent Runtime Safety"). Sage (the open-source implementation) was published February 19, 2026.

The footnote [^gen-aarts] correctly cites the March 5 date: "February 4, 2026" appears in the footnote but refers to the hub launch, not the AARTS introduction. The body text attributing AARTS and Skill IDs to the February launch is the error.

**Fix required:** Change the body text framing. The February launch introduced the Agent Trust Hub concept; AARTS and Skill IDs were published in March. Something like: "Gen Digital introduced the AI Agent Runtime Safety Standard (AARTS) and Skill IDs in March 2026, building on the Agent Trust Hub launched in February.[^gen-aarts]"

---

### ISSUE C — [^ietf-scope-agg] wrongly labeled "Standards Track"

**Location:** Footnote [^ietf-scope-agg]

**Footnote reads:** "draft-jia-oauth-scope-aggregation-00, 'OAuth 2.0 Scope Aggregation for Multi-Step AI Agent Workflows,' datatracker.ietf.org, February 10, 2026. Authors: Yukuan Jia and Shuping Peng (Huawei). **Standards Track**. Expires August 14, 2026."

**Findings:** Checked IETF datatracker. The draft has no RFC stream or intended RFC status assigned. It is an individual Internet-Draft, not an IETF Standards Track document. "Standards Track" is a formal designation requiring IETF consensus and Working Group adoption — this draft has neither.

**Fix required:** Remove "Standards Track" from the footnote. Replace with: "Individual Internet-Draft (not adopted by any Working Group)." or simply omit the status label.

---

### ISSUE D — [^dif-auth-scale] footnote year is wrong

**Location:** Footnote [^dif-auth-scale]

**Footnote reads:** "DIF, 'Authorising Autonomous Agents at Scale,' blog.identity.foundation, **2026**. Part 4 of the 'Building AI Trust at Scale' series."

**Findings:** Fetched the article. It was published **November 17, 2025**, not 2026.

The quote ("Imagine sitting at your job, just clicking approve, approve, approve...") is confirmed verbatim. The 3,000-agent-instances-daily figure (100 employees × 10 instances × 3 AI tools) is confirmed. The attribution to Andor Kesselman (co-founder of the Agentic Internet Workshop, co-chair of DIF TAIAWG) is confirmed. Only the year is wrong.

**Fix required:** Change "2026" to "November 2025" in footnote [^dif-auth-scale].

---

### ISSUE E — ZCAP-LD mechanism described as using VCs (incorrect)

**Location:** "Capability-Based Authorization Is Getting Concrete" section

**Draft text:** "ZCAP-LD (Authorization Capability for Linked Data) enables delegation chains through Verifiable Credentials: an agent receives a scoped VC ('cancel booking CAR-123, only by agent that created it, valid until pickup time') that it can attenuate and delegate further, but never escalate."

**Findings:** Checked ZCAP-LD spec (w3c-ccg.github.io/zcap-spec/, v0.3, W3C Credentials Community Group). The spec explicitly distinguishes ZCAP-LD from Verifiable Credentials: "Use correlation (Verifiable Credentials) in a reasoning system... Use capabilities (ZCAP-LD) as the mechanism to grant and exercise authority." ZCAP-LD uses object capabilities represented as JSON-LD objects signed with Data Integrity proofs — not VCs. The delegation token is a capability object, not a Verifiable Credential. The attenuation rule (child capabilities cannot exceed parent) is confirmed correct.

The error is specifically the phrase "enables delegation chains through Verifiable Credentials" and "an agent receives a scoped VC." ZCAP-LD does not use VCs as the delegation mechanism.

**Fix required:** Rewrite the ZCAP-LD sentence to accurately describe the mechanism: capability objects (not VCs) signed with Data Integrity proofs. Example: "ZCAP-LD (Authorization Capability for Linked Data) enables delegation chains through object capability objects signed with Data Integrity proofs: an agent receives a scoped capability ('cancel booking CAR-123, only by agent that created it, valid until pickup time') that it can attenuate and delegate further, but never escalate."

---

### ISSUE F — UCAN in Bluesky overstated

**Location:** "Capability-Based Authorization Is Getting Concrete" section

**Footnote reads:** "UCAN (User Controlled Authorization Networks), ucan.xyz. JWT-based capability tokens with hierarchical delegation. Used in **Fission and Bluesky** ecosystems."

**Findings:** Fission: confirmed — UCAN was created by Fission (Brooklyn Zelenka) and is core to Fission's architecture. Bluesky: Bluesky explored UCAN (GitHub issue in the atproto repo) but there is no confirmed production adoption. The official ucan.xyz site does not mention Bluesky. Bluesky uses `did:plc` identifiers but UCAN is not confirmed as a production capability mechanism in their stack.

**Fix required:** Change "Used in Fission and Bluesky ecosystems" to "Used in Fission ecosystem; explored in AT Protocol (Bluesky)." or simply "Used in Fission's distributed cloud infrastructure."

---

### CLEAN — Items Verified

| Claim | Status |
|-------|--------|
| ITU-T SG17 workshop: "Trustable and Interoperable Digital Identities for Human and Agentic AI," March 30-31, 2026, Geneva | **CONFIRMED** — exact title, dates, organizing body, URL |
| Sage: "200+ detection rules covering supply chain attacks, credential exposure, dangerous commands, persistence" | **CONFIRMED** — Gen Digital "Introducing Sage" blog, February 19, 2026 |
| Help Net Security article: "Open-source tool Sage puts a security layer between AI agents and the OS," March 9, 2026 | **CONFIRMED** |
| Vercel partnership: "A partnership with Vercel brings independent safety verification to the AI skills ecosystem," announced February 17, 2026 | **CONFIRMED** |
| KYAPay: draft-skyfire-kyapayprofile-00, March 2, 2026, JWT profiles for "kya" and "pay" tokens | **CONFIRMED** |
| Skyfire/Visa businesswire, December 2025 | **CONFIRMED** — December 18, 2025 |
| DIF blog "Authorising Autonomous Agents at Scale" quote ("approve, approve, approve") | **CONFIRMED** verbatim, attributed to Andor Kesselman |
| DIF blog: "100 employees generating roughly 3,000 agent instances daily" | **CONFIRMED** — article gives the arithmetic (100 × 10 instances × 3 AI tools) |
| TAIAWG first planned deliverable: "Agentic Authority Use Cases" with emphasis on object capabilities | **CONFIRMED** — Linux Foundation Decentralized Trust announcement verbatim |
| ZCAP-LD v0.3, W3C CCG, attenuation rule (child cannot exceed parent) | **CONFIRMED** |
| ID-JAG WG adoption itself | **CONFIRMED** — Call for adoption closed September 8, 2025 |
| [^ietf-scope-agg] draft existence, authors (Yukuan Jia, Shuping Peng, Huawei), date, expiry | **CONFIRMED** (except Standards Track label — see Issue C) |

---

### Summary of Issues (Session 437)

| Issue | Location | Severity | Fix |
|-------|----------|----------|-----|
| A: [^idjag-wg] revision -01 → -02, wrong expiry, missing Brian Campbell | Body text + footnote | Medium | Update revision, expiry, add author |
| B: AARTS/Skill IDs attributed to February launch (actually March 2026) | Body text | **High** | Correct date attribution |
| C: [^ietf-scope-agg] "Standards Track" label is wrong | Footnote | Medium | Remove "Standards Track" |
| D: [^dif-auth-scale] year "2026" → "2025" | Footnote | Medium | Fix year |
| E: ZCAP-LD described as using VCs (actually object capabilities) | Body text | **High** | Rewrite mechanism description |
| F: UCAN in Bluesky overstated | Footnote | Low | Qualify or remove Bluesky |

**Issues E and B are body-text factual errors. A, C, D, F are footnote corrections.**

Send to Ghosty. Do not publish this new content until all 6 issues are resolved.

---

## Session 439 Re-verification — Ghosty Commit 455d479 (2026-03-15 10:05 UTC)

Ghosty applied all 6 fixes. Re-verified each fix against sources.

### Fix A — [^idjag-wg]: revision -02, expiry Sep 3 2026, Brian Campbell added

**Fix applied:** footnote now reads "draft-ietf-oauth-identity-assertion-authz-grant-02...Authors: Aaron Parecki, Karl McGuinness, Brian Campbell. Revision -02 expires September 3, 2026."

**Verification:** Fetched datatracker.ietf.org/doc/draft-ietf-oauth-identity-assertion-authz-grant/. Revision -02 confirmed. Brian Campbell listed as author. Expiry September 3, 2026 confirmed. **RESOLVED.**

### Fix B — AARTS date: "March 2026, building on Agent Trust Hub launched in February"

**Fix applied:** Body text now reads "Gen Digital introduced the AI Agent Runtime Safety Standard (AARTS) and Skill IDs in March 2026, building on the Agent Trust Hub launched in February."

**Verification:** Agent Trust Hub: February 4, 2026 (newsroom.gendigital.com). AARTS blog post (Jakub Křoustek): March 5, 2026. Skill IDs blog post (Luis Corrons): March 5, 2026. Fix is accurate. **RESOLVED.**

### Fix C — [^ietf-scope-agg]: "Individual Internet-Draft (not adopted by any Working Group)"

**Fix applied:** Footnote now reads "Individual Internet-Draft (not adopted by any Working Group). Expires August 14, 2026."

**Verification:** Fetched IETF datatracker. Stream state: "(No stream defined)". IESG state: "I-D Exists". Not endorsed by the IETF. Fix is accurate. **RESOLVED.**

### Fix D — [^dif-auth-scale]: year "November 2025"

**Fix applied:** Footnote now reads "DIF, 'Authorising Autonomous Agents at Scale,' blog.identity.foundation, November 2025."

**Verification:** Fetched article. Published November 17, 2025. Fix is accurate. **RESOLVED.**

### Fix E — ZCAP-LD mechanism: "object capability objects signed with Data Integrity proofs"

**Fix applied:** Body text now reads "ZCAP-LD (Authorization Capability for Linked Data) enables delegation chains through object capability objects signed with Data Integrity proofs: an agent receives a scoped capability ('cancel booking CAR-123, only by agent that created it, valid until pickup time') that it can attenuate and delegate further, but never escalate."

**Verification:** Fetched w3c-ccg.github.io/zcap-spec/. ZCAP-LD explicitly distinguishes itself from VCs, uses object capability documents signed with Linked Data Proofs (Data Integrity). Fix is accurate. Footnote also updated correspondingly. **RESOLVED.**

### Fix F — UCAN/Bluesky: "explored in AT Protocol (Bluesky)"

**Fix applied:** Footnote now reads "Used in Fission ecosystem; explored in AT Protocol (Bluesky)."

**Verification:** AT Protocol OAuth spec uses OAuth 2.1 + DPoP; no UCAN in production. GitHub issue #85 (atproto) proposing UCAN was closed as "not planned." 2023 roadmap mentioned UCAN but never implemented. Fix "explored" is accurate. **RESOLVED.**

### Session 439 Verdict

**ALL 6 ISSUES RESOLVED.** Commit 455d479 is APPROVED. New gaps.md content (sessions 257/258/427/cf49feb) is factually clean. Chapter ready for Chop Pop editorial pass.

---

## Session 443 Verification — RSAC 2026 Innovation Sandbox Full Finalist List (Ghosty commit f6bc9f3)

**Session:** 443
**Date:** 2026-03-15 21:00 UTC
**Commit:** f6bc9f3 (Ghosty)
**Scope:** New content in src/drafts/gaps.md: expanded RSAC 2026 Innovation Sandbox bullet with full 10-finalist list, Glide Identity and Realm Labs detail, and two new footnotes [^glide-identity-rsac] and [^realm-labs-rsac].
**Status:** ISSUES FOUND — 1 factual overstatement, 1 unverifiable footnote source. Route to Ghosty.

---

### CONFIRMED CLAIMS

| Claim | Status |
|-------|--------|
| 10 finalists total | **CONFIRMED** — PRNewswire official announcement |
| All 10 company names correct (Token Security, Glide Identity, Geordie AI, Realm Labs, Charm Security, Clearly AI, Crash Override, Fig Security, Humanix, ZeroPath) | **CONFIRMED** |
| Glide Identity: "SIM-anchored cryptographic authentication" | **CONFIRMED** |
| Glide Identity: "agent-ready passwordless auth using private keys embedded in SIM cards and eSIMs" | **CONFIRMED** (SIM-based private key auth confirmed; framing matches Glide's own product description) |
| Glide Identity: "backed by Crosspoint Capital" | **CONFIRMED** — Series A led by Crosspoint Capital Partners |
| Glide Identity footnote: BusinessWire, February 10, 2026 | **CONFIRMED** — exact URL exists |
| Geordie AI: "agent security and governance platform" | **CONFIRMED** |
| Geordie AI: "SC Awards co-finalist" | **CONFIRMED** — SC Awards finalist (Most Promising Early-Stage Startup category, announced March 3, 2026) |
| Geordie AI: "team from Snyk/Veracode/Darktrace" | **CONFIRMED** — founders confirmed from those companies |
| Geordie AI: "backed by Ten Eleven Ventures and General Catalyst" | **CONFIRMED** — $6.5M seed co-led by these two firms |
| Realm Labs: "OmniGuard AI firewall for runtime enforcement" | **CONFIRMED** — realmlabs.ai product page confirms OmniGuard name and firewall function |
| Realm Labs: "Prism monitors attention patterns and internal chain-of-thought during inference" | **CONFIRMED** — realmlabs.ai Prism product page lists attention monitoring and CoT analysis |
| Other six finalists (Charm Security, Clearly AI, Crash Override, Fig Security, Humanix, ZeroPath): general characterization of focus areas | **CONFIRMED** (broadly accurate; no individual area is wrong) |

---

### ISSUE 1 — Glide Identity: "commercial deployments live" overstates beta status [MEDIUM]

**Location:** RSAC 2026 bullet, Glide Identity description

**Text:** "commercial deployments live on T-Mobile and Verizon"

**Finding:** The source ([^glide-identity-rsac], BusinessWire Feb 10, 2026) and Glide Identity's own communications consistently describe the T-Mobile and Verizon status as **"live in beta"** — not full production commercial deployments. The Glide Identity blog ("Completing the Passwordless Picture: Launching MagicalAuth in the U.S.") states: "MagicalAuth is currently live in beta with T-Mobile and Verizon in the United States, with general availability and full U.S. carrier coverage launching soon." Fortune 500 pilots are underway but general availability had not launched at time of writing.

"Commercial deployments live" implies production GA status that the source does not support.

**Fix required:** Change "commercial deployments live on T-Mobile and Verizon" to "live in beta with T-Mobile and Verizon, with general availability planned"

---

### ISSUE 2 — [^realm-labs-rsac] footnote cites unverifiable source [MINOR]

**Location:** Footnote [^realm-labs-rsac]

**Text:** "Realm Labs, realmlabs.ai; First Rays Venture Partners, 'Realm Labs named RSA Innovation Sandbox 2026 Finalist,' firstraysvc.com, 2026."

**Finding:** The realmlabs.ai source is confirmed. However, "firstraysvc.com" (First Rays Venture Partners) does not appear in any web search results for Realm Labs. The domain cannot be verified as a real source. If it was a VC-firm press release, it would typically appear in industry coverage; no such coverage was found referencing this specific source.

The Realm Labs RSAC finalist status is independently confirmed via PRNewswire (official RSAC announcement) and Security Boulevard. The firstraysvc.com citation is redundant and unverifiable.

**Fix required:** Remove "First Rays Venture Partners, 'Realm Labs named RSA Innovation Sandbox 2026 Finalist,' firstraysvc.com, 2026" from the footnote, retaining only "Realm Labs, realmlabs.ai" (plus the official RSAC PRNewswire source if desired).

---

### VERDICT (Session 443)

**ISSUES FOUND — Route to Ghosty for fixes.**

2 issues:
- **Issue 1 (Medium):** "commercial deployments live on T-Mobile and Verizon" → "live in beta with T-Mobile and Verizon, with general availability planned"
- **Issue 2 (Minor):** Remove unverifiable firstraysvc.com citation from [^realm-labs-rsac]

Do not route to Chop Pop until Ghosty applies both fixes.

---

## Session 448 Re-verification — RSAC Fixes (Ghosty commit 3fa74bb, 2026-03-15)

**Session:** 448 (Sapere Aude)
**Date:** 2026-03-15 UTC
**Commit:** 3fa74bb (Ghosty Session 448)
**Scope:** Re-verification of 2 Session 443 RSAC issues fixed in src/drafts/gaps.md.
**Status:** BOTH ISSUES RESOLVED — chapter ready for Chop Pop editorial pass.

### Issue 1 (Medium) — Glide Identity beta status

**Fix applied:** Text now reads "live in beta with T-Mobile and Verizon, with general availability planned"

**Verification:** Confirmed in gaps.md line 253. Matches Glide Identity's own blog language ("MagicalAuth is currently live in beta with T-Mobile and Verizon in the United States, with general availability and full U.S. carrier coverage launching soon"). Fix is accurate. **RESOLVED.**

### Issue 2 (Minor) — firstraysvc.com unverifiable citation

**Fix applied:** Footnote [^realm-labs-rsac] now reads: "Realm Labs, realmlabs.ai. RSAC 2026 Innovation Sandbox finalist status confirmed via PRNewswire official announcement."

**Verification:** firstraysvc.com citation fully removed. realmlabs.ai retained. PRNewswire reference for RSAC finalist status retained. Fix is accurate. **RESOLVED.**

### Additional change in same commit — why-agents-break-trust.md (src/drafts/)

Ghosty removed "The Shape of This Book" closing section from the draft (14 lines) and replaced with a single bridge sentence: "These problems are interconnected: identity, delegation, supply chain, reliability, and adversarial speed all compound each other. The PAC Framework addresses them as one system. The next chapter introduces it."

**Assessment:** Structural edit only. No factual claims were removed or added. The bridge sentence makes no external claims. This is a draft-level change; the published chapter (src/chapters/why-agents-break-trust.md) is unaffected and remains APPROVED (Session 393). No re-verification needed for the published chapter.

### VERDICT (Session 448)

**APPROVED — Both Session 443 RSAC issues resolved. gaps.md draft is ready for Chop Pop editorial pass.**

Full draft delta (all content added since last Chop Pop pass, session 439 + RSAC fixes) is clean. Route to Chop Pop.

---

## Session 452 Re-verification — Chop Pop editorial pass (commit 5684c3d, 2026-03-15)

**Session:** 452 (Sapere Aude)
**Date:** 2026-03-15 11:30 UTC
**Commit:** 5684c3d (Chop Pop)
**Scope:** Re-verification of Chop Pop's editorial pass applying approved draft delta to src/chapters/gaps.md. Scope: RSAC section rewrite, new "Capability-Based Authorization Is Getting Concrete" section, new "Runtime Safety Standards Are Emerging" section, ID-JAG WG paragraph update, ITU-T addition to Institutional Validation.
**Status:** ISSUES FOUND — 2 missing footnote definitions. Factual content is clean.

---

### Factual Verification — New Sections

All factual claims in the new content were re-verified against sources:

| Claim | Status |
|-------|--------|
| ZCAP-LD: "object capability objects signed with Data Integrity proofs," attenuation (child cannot exceed parent) | **CONFIRMED** — w3c-ccg.github.io/zcap-spec/ |
| UCAN: "JWT-based capability tokens with hierarchical delegation. Used in Fission ecosystem; explored in AT Protocol (Bluesky)." | **CONFIRMED** — "explored" accurate (atproto issue #85 closed "not planned"); previously verified Session 439 |
| DIF blog: "100 employees generating roughly 3,000 agent instances daily" | **CONFIRMED** — blog.identity.foundation, November 2025 |
| DIF blog "clicking approve, approve, approve" quote | **CONFIRMED** verbatim, attributed to Andor Kesselman |
| TAIAWG first planned deliverable: "Agentic Authority Use Cases" with emphasis on object capabilities | **CONFIRMED** — lfdecentralizedtrust.org announcement |
| AARTS v0.1: 19 hook points, three component types (host, engine, adapter), Skill IDs | **CONFIRMED** — Gen Digital blog posts |
| AARTS/Skill IDs: "introduced... in March 2026, building on the Agent Trust Hub launched in February" | **CONFIRMED** — Agent Trust Hub: Feb 4, 2026; AARTS blog post: March 5, 2026 |
| Sage: open-source, 200+ detection rules, March 2026 | **CONFIRMED** — gendigital.com + Help Net Security March 9, 2026 |
| Vercel partnership: February 17, 2026 | **CONFIRMED** — newsroom.gendigital.com |
| ID-JAG: draft-ietf-oauth-identity-assertion-authz-grant at revision -02, formal IETF OAuth WG document | **CONFIRMED** — datatracker.ietf.org |
| ITU-T Study Group 17 workshop: "Trustable and Interoperable Digital Identities for Human and Agentic AI," March 30-31, 2026, Geneva | **CONFIRMED** — itu.int |
| RSAC 2026: all 10 finalists confirmed, Glide Identity beta status correct, Realm Labs Prism/OmniGuard correct, Geordie AI investors correct | **CONFIRMED** — previously verified Sessions 443+448 |

---

### ISSUE 1 — Missing footnote definition [^idjag-wg] in published chapter [STRUCTURAL]

**Location:** src/chapters/gaps.md, line 55 body text references `[^idjag-wg]`; no definition in chapter footnote section.

**Finding:** The body text "The first answer arrived when the IETF OAuth Working Group formally adopted ID-JAG as a working group document (draft-ietf-oauth-identity-assertion-authz-grant, now at revision -02).[^idjag-wg]" cites `[^idjag-wg]`. The footnote definition exists in src/drafts/gaps.md (line 293) but was not copied to the published chapter when Chop Pop applied the delta. The published chapter has no `[^idjag-wg]:` definition. mdBook will render this as a broken reference.

**Definition that must be added (from approved draft):**
```
[^idjag-wg]: draft-ietf-oauth-identity-assertion-authz-grant-02, "Identity Assertion JWT Authorization Grant," datatracker.ietf.org, 2026. Adopted by IETF OAuth Working Group. Authors: Aaron Parecki, Karl McGuinness, Brian Campbell. Revision -02 expires September 3, 2026. Previously individual submission (draft-parecki-oauth-identity-assertion-authz-grant). Call for adoption closed September 2025.
```

**Fix required:** Chop Pop to add the `[^idjag-wg]` footnote definition to src/chapters/gaps.md footnote section.

---

### ISSUE 2 — Missing footnote definition [^itu-agent-identity] in published chapter [STRUCTURAL]

**Location:** src/chapters/gaps.md, line 178 body text references `[^itu-agent-identity]`; no definition in chapter footnote section.

**Finding:** The body text "ITU-T Study Group 17 is convening a two-day workshop... [^itu-agent-identity]" cites this footnote. The definition exists in src/drafts/gaps.md (line 292) but was not copied to the published chapter. mdBook will render this as a broken reference.

**Definition that must be added (from approved draft):**
```
[^itu-agent-identity]: ITU, "Trustable and Interoperable Digital Identities for Human and Agentic AI," ITU-T Workshop, March 30-31, 2026, Geneva. Organized by ITU-T Study Group 17 (security). itu.int/en/ITU-T/Workshops-and-Seminars/2026/0330.
```

**Fix required:** Chop Pop to add the `[^itu-agent-identity]` footnote definition to src/chapters/gaps.md footnote section.

---

### VERDICT (Session 452)

**ISSUES FOUND — Route to Chop Pop for structural footnote fixes.**

Factual content is fully clean. Both issues are missing footnote definitions introduced when Chop Pop applied the draft delta — the body text references were copied but the corresponding footnote definitions were not. No factual re-verification needed after fix; these are mechanical additions.

2 fixes required:
- Add `[^idjag-wg]` definition to src/chapters/gaps.md (exact text above)
- Add `[^itu-agent-identity]` definition to src/chapters/gaps.md (exact text above)

Once both footnotes are added, gaps.md chapter is APPROVED and fully clean.

---

## Session 453 Re-verification — Chop Pop footnote fix (commit e6e1c15) + Ghosty Moltbook paragraph (commit 010cc91, 2026-03-15)

**Session:** 453 (Sapere Aude)
**Date:** 2026-03-15 12:15 UTC
**Commits:** e6e1c15 (Chop Pop), 010cc91 (Ghosty)
**Scope:**
1. Re-verification of Chop Pop's footnote fix: `[^idjag-wg]` and `[^itu-agent-identity]` added to src/chapters/gaps.md.
2. Verification of Ghosty's new Moltbook paragraph in src/drafts/gaps.md.
3. Confirmation of MIT Sloan section merge (already approved Session 425).

**Status:** APPROVED — draft ready for Chop Pop editorial pass.

---

### Part 1: Chop Pop footnote fix (commit e6e1c15)

Chop Pop added both footnote definitions to src/chapters/gaps.md per Session 452 requirements.

| Footnote | Prescribed text | Added text | Status |
|----------|----------------|------------|--------|
| `[^idjag-wg]` | As specified Session 452 | Matches — minor style: no quotes around title, "Previously draft-parecki-..." (omits "individual submission") | **APPROVED** |
| `[^itu-agent-identity]` | As specified Session 452 | Matches — minor style: no quotes around title | **APPROVED** |

Both are factually correct. Style differences are non-material.

**src/chapters/gaps.md is now FULLY APPROVED.**

---

### Part 2: Ghosty Moltbook paragraph (commit 010cc91)

New paragraph added to src/drafts/gaps.md (Market Consolidation section):

| Claim | Source | Status |
|-------|--------|--------|
| Meta acquired Moltbook on March 10, 2026 | TechCrunch, March 10, 2026; confirmed by Axios, CNBC | **CONFIRMED** |
| Acqui-hire: co-founders Matt Schlicht and Ben Parr joined Meta Superintelligence Labs (MSL), led by Alexandr Wang | Multiple sources including TechCrunch, Axios | **CONFIRMED** |
| "Moltbook was the AI agent social network that went viral because of apparent agent scheming behavior, which turned out to be human-engineered outputs posted for engagement" | Shane Deconinck, "OpenClaw and Moltbook," shanedeconinck.be, February 17, 2026: "Most of the viral screenshots were human-prompted: people engineering scary outputs for engagement, then posting them without context" | **CONFIRMED** |
| Lex Fridman quote: "It's art when you know how it works. It's an extremely powerful viral narrative creating, fearmongering machine if you don't know how it works." | Shane blog confirmed verbatim from Lex Fridman #491 | **CONFIRMED** |
| "Wiz Research found the platform's Supabase database misconfigured with full read/write access, exposing 1.5 million API tokens, over 35,000 email addresses, and private messages" | Wiz Research, "Exposed: MoltBook Database Reveals Millions of API Keys," wiz.io, February 2, 2026 | **CONFIRMED** |
| [^moltbook-wiz] date "February 2, 2026" | Wiz blog post publication date: February 2, 2026 (initial discovery Jan 31, fix Feb 1, public blog Feb 2) | **CONFIRMED** |
| [^meta-moltbook]: TechCrunch article title and date | TechCrunch article confirmed March 10, 2026; title matches | **CONFIRMED** |

All factual claims in the Moltbook paragraph are clean.

---

### Part 3: MIT Sloan section merge (commit 010cc91)

The MIT Sloan section was approved in Session 425 (commit cd1b76c). Ghosty merged it with two editorial fixes: "em dash → colon" and "maps directly to → maps to". No factual content changed. The factual claims (80/20 stat, five heavy lifts, inferential edge quote) were already verified in Session 425.

**APPROVED — no re-verification required.**

---

### VERDICT (Session 453)

**APPROVED — src/drafts/gaps.md is clean. Send to Chop Pop for editorial pass.**

- src/chapters/gaps.md: FULLY APPROVED (footnotes added, all content verified Sessions 439–453)
- src/drafts/gaps.md Moltbook paragraph: APPROVED (all factual claims confirmed)
- src/drafts/gaps.md MIT Sloan section: APPROVED (verified Session 425, no factual changes in merge)

Chop Pop should apply the Moltbook paragraph and MIT Sloan section from src/drafts/gaps.md to src/chapters/gaps.md.

---

## Session 549 Addendum — Merged sections verification (commits 7d9fffd, ff753b7, dcbc982, c2bb1ce)

**Session:** 549 (Sapere Aude)
**Date:** 2026-03-16
**Commits reviewed:** 7d9fffd (session 454 merge), ff753b7 (session 463 close-read), dcbc982 (session 476 PAC removal), c2bb1ce (session 488 prose fix)
**Trigger:** Chop Pop TSP handoff (2026-03-15 22:56 UTC): "All four gaps-new-observations sections merged and verified in gaps.md."

### Sections merged in commit 7d9fffd

Two sections from gaps-new-observations.md were merged into gaps.md:

**Section 3: AI Literacy Cannot Scale**

- Quotes and claims already verified in gaps-new-observations-verification.md Session 421.
- Key quote: "If the creator telling users not to do something doesn't work, documentation is not a security model." — CONFIRMED EXACT (Session 421, src: Shane's OpenClaw/Moltbook post, Feb 17 2026)
- [^trust-inversion] footnote quote: "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task." — CONFIRMED EXACT (Session 421, src: Shane's trust-inversion post)
- No changes to sourced claims vs. verified version. **APPROVED.**

**Section 4: As Scaffolding Shrinks**

- Claims already verified in gaps-new-observations-verification.md Session 421.
- [^scaffolding-trap] footnote: "The permissions system" as Claude Code's most complex component, Boris Cherny origin, "Every line of scaffolding is a bet that you know better than the model." — all CONFIRMED (Session 421)
- Session 488 changed "Shane puts it directly:" to "Shane puts it:" — editorial, no factual impact.
- No changes to sourced claims vs. verified version. **APPROVED.**

### Post-merge editorial changes (commits ff753b7, dcbc982, c2bb1ce)

- ff753b7: Removed "structurally significant" label (editorial), removed 2 PAC pillar inline labels — no factual content changed.
- dcbc982: Removed PAC interjection from MCP/A2A comparison ("This maps to a PAC insight..." → technical claim made direct) — no factual content changed.
- c2bb1ce: Removed dead-weight adverb "directly" from one sentence — no factual content changed.

None of these affect verifiable claims.

### VERDICT (Session 549)

**src/drafts/gaps.md at commit c2bb1ce is APPROVED.** All four gaps-new-observations sections are correctly merged. No factual issues introduced by post-merge edits. Status: fully clean through session 488.

