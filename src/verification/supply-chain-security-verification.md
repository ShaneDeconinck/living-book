# Verification Report: Agent Supply Chain Security

**Chapter:** src/chapters/supply-chain-security.md
**Verified:** 2026-03-14
**Session:** 284
**Verifier:** Sapere Aude
**Status:** FULLY APPROVED — All issues resolved across all sessions. Session 420 final sign-off: M2 ("Amazon Q Developer" → "Amazon Q CLI") applied to published chapter (commit 41ba0fb by Chop Pop). Session 493 addendum: Snyk ToxicSkills new content verified clean (see addendum below). Draft propagation to published chapter pending.

---

## Summary

The chapter is structurally sound and covers a critical topic with good source density. Most technical claims, CVE details, and vendor figures check out. However, one set of figures is critically inflated — the SecurityScorecard breach-linked count is 100x the actual reported figure — and two other significant errors require correction: the RSP 3.0 framing misrepresents the document's structure, and the SPDX 3.0.1 claim contains two errors.

**Session 323 update:** Critical issue 1 (SecurityScorecard figures) resolved. All four figures verified correct: ~40,000 instances (Infosecurity reports 40,214), ~76 countries, ~12,812 RCE-vulnerable, 549 breach-linked. "Three distinct analyses" framing also removed. Fix in branch ghosty-session-163-fixes (commit 10fc80c), pending merge. Remaining open: Issues 2 and 3 (RSP 3.0, SPDX), plus 4 minor issues.

**Session 390 update:** All remaining issues confirmed resolved in published chapter (src/chapters/supply-chain-security.md). Issue 2 (RSP 3.0): "mandatory Frontier Safety Roadmap" → "public Frontier Safety Roadmap (non-binding goals)" in body and footnote — commit 4b58cbe. Issue 3 (SPDX): chapter now reads "introduced in SPDX 3.0.0; current release 3.0.1" and "33 fields" (resolved in an earlier session). Minor issues 4-7 all resolved: NHI ratio has dedicated CyberArk citation [^cyberark-nhi], "over 50 distinct," TechCrunch 875+ citation in [^dod-open-letter], "OAuth authorization handler" on line 229. Chapter is APPROVED.

**Confirmed clean:** BlueRock SSRF rate (36.7%, 7,000+ servers), arXiv:2510.07192 (250 poisoned documents, all three institutions), CSA ATF (Feb 2, 2026), CSA+Strata survey (21%/84%), AAIF membership (8 platinum, Dec 9 2025), Invariant Labs WhatsApp MCP (April 2025), arXiv:2504.16743 (Linux Foundation AI-BOM guide), MCPTox benchmark (previously verified), Anthropic RSP 3.0 date (Feb 24, 2026), Anthropic lawsuit (March 2026), 30+ employees amicus brief, JSON-LD serialization in SPDX.

---

## Critical Issues

### 1. SecurityScorecard STRIKE Team figures are wrong across all four metrics — RESOLVED (Session 323)

**Location:** Lines 17 and footnote [^securityscorecard]

**What the chapter originally claimed:**
> "SecurityScorecard's STRIKE Team conducted three distinct analyses of the OpenClaw exposure surface: a scan identifying over 135,000 publicly exposed instances across 82 countries, a vulnerability assessment finding over 15,000 directly vulnerable to remote code execution, and a threat intelligence correlation linking more than 53,000 to prior breach activity."

**What the SecurityScorecard report actually says:**

| Metric | Chapter claimed | Actual (per Infosecurity Magazine, SiliconANGLE, STRIKE Team) |
|---|---|---|
| Total exposed instances | 135,000+ | ~40,000+ (~40,214) |
| Countries | 82 | ~76 |
| Vulnerable to RCE | 15,000+ | ~12,812 |
| Linked to breach activity | 53,000+ | **549** |

The breach-linked figure is the most severe error: 53,000+ in the chapter versus 549 in the source. This is a 100x inflation, not a rounding difference.

**Also wrong:** The chapter describes "three distinct analyses" as a structured methodology. The SecurityScorecard source describes a single continuous scanning operation with a live dashboard (declawed.io), not three discrete studies.

**Fix applied (Session 323):** All four figures corrected. Text now reads: "SecurityScorecard's STRIKE Team scanned the OpenClaw exposure surface and found approximately 40,000 publicly exposed instances across roughly 76 countries, with around 12,812 directly vulnerable to remote code execution and 549 linked to prior breach activity." "Three distinct analyses" framing removed. Footnote updated to match. All four corrected figures verified independently against Infosecurity Magazine and SiliconANGLE coverage.

**Sources consulted:**
- SecurityScorecard STRIKE Team, "How Exposed OpenClaw Deployments Turn Agentic AI Into an Attack Surface," securityscorecard.com, February 2026
- Infosecurity Magazine, "Researchers Find 40,000+ Exposed OpenClaw Instances," February 2026
- SiliconANGLE, "Tens of thousands of OpenClaw systems exposed," February 2026
- declawed.io live dashboard

---

## Significant Issues

### 2. Anthropic RSP 3.0 framing misrepresents the document's structure

**Location:** Lines 47 and footnote [^anthropic-rsp]

**What the chapter claims:**
> "The policy introduced conditional safety commitments: Anthropic's safety measures now account for competitive context, adjusting based on what other labs are doing rather than maintaining fixed thresholds regardless."

**What RSP 3.0 actually says:**

The date (February 24, 2026) and URL cited are correct. The characterization is not.

RSP 3.0 introduces a **two-tier structure**:
- **Unilateral commitments**: safety thresholds fixed by capability level, maintained regardless of what other labs do
- **Industry-wide recommendations**: stronger mitigations, framed as conditional on broader industry adoption

The phrase "conditional safety commitments" does not appear in the document. More precisely, the safety *thresholds* remain fixed — what becomes conditionally tiered are the *mitigations* applied at each threshold level. The claim "rather than maintaining fixed thresholds regardless" directly contradicts the document: thresholds are still fixed.

The chapter's framing adopts critics' characterization of RSP 3.0 (GovAI, Cybernews, and secondary press described it as "scaling back" safety pledges) and presents it as what the document says. These are different things.

**Fix required:** Revise to accurately reflect the document's two-tier structure. For example: "The policy introduced tiered mitigations: Anthropic maintained fixed safety thresholds by capability level while making stronger mitigations conditional on broader industry adoption." If the chapter intends to include the critical perspective, it should be attributed as such ("critics described it as...").

**Source consulted:** Anthropic, "Responsible Scaling Policy Version 3.0," anthropic.com, effective February 24, 2026; GovAI analysis of RSP v3.0.

---

### 3. SPDX 3.0.1 — wrong version for "added" and wrong field count

**Location:** Lines 147–148 and footnote [^spdx-ai]

**What the chapter claims:**
> "The Software Package Data Exchange specification (maintained by the Linux Foundation) added formal AI and Dataset profiles in version 3.0.1... Together they define 36 fields..."

**Two errors:**

**Error A: Wrong version.** AI and Dataset profiles were introduced in SPDX **3.0.0** (released April 16, 2024), not 3.0.1. Version 3.0.1 carries these profiles but did not introduce them. "Added formal AI and Dataset profiles in version 3.0.1" is factually incorrect.

**Error B: Wrong field count.** The SPDX 3.0.1 specification defines:
- AI profile: **20 fields** (autonomyType, domain, energyConsumption, etc.)
- Dataset profile: **13 fields** (datasetType, datasetSize, knownBias, etc.)
- Combined: **33 fields**, not 36

The "36 fields" figure is not supported by the official spec. The difference between 33 and 36 is not a counting convention; the spec pages enumerate the fields explicitly.

**Fixes required:**
- "added formal AI and Dataset profiles in version 3.0.1" → "includes formal AI and Dataset profiles (introduced in SPDX 3.0.0)"
- "36 fields" → "33 fields"

**Sources consulted:** SPDX 3.0.1 specification, AI profile page (spdx.github.io/spdx-spec/v3.0.1/model/AI/AI/); SPDX 3.0.1 Dataset profile page; Linux Foundation SPDX 3.0 announcement.

---

## Minor Issues

### 4. NHI ratio "up to 100:1" lacks a dedicated citation

**Location:** Lines 245 and footnote [^csa-survey]

**What the chapter claims:**
> "Non-human identities (service accounts, API tokens, agent credentials) now outnumber human users by up to 100:1"

The footnote for this claim points to the CSA+Strata survey, which was verified as correctly sourcing the 21% and 84% figures. However, the "up to 100:1" ratio does not appear in the CSA+Strata survey. The most-cited 2025 research on this ratio is CyberArk's State of Machine Identity Security Report (April 2025, 2,600 respondents), which reports **more than 80:1** (not 100:1). The 100:1 figure as an upper bound appears in Rubrik Zero Labs and ManageEngine 2026 data.

"Up to 100:1" is defensible as a ceiling figure but it is presented without a dedicated source, and the number it is attached to (the CSA survey footnote) does not source it. The more authoritative number is the CyberArk 82:1 average.

**Fix required:** Add a dedicated citation for the ratio, or revise to "more than 80:1" with CyberArk as the source, or keep "up to 100:1" and cite Rubrik/ManageEngine explicitly as the upper-bound source.

---

### 5. Microsoft AI Recommendation Poisoning: "50" should be "over 50"

**Location:** Lines 53 and footnote [^ai-rec-poison]

**What the chapter claims:**
> "Microsoft identified 50 distinct prompt-based attempts from 31 companies across 14 industries"

The Microsoft Security Blog post and all secondary coverage (The Hacker News, The Register, Help Net Security) consistently say "**over** 50 unique prompts," not exactly 50. The footnote repeats the same error ("50 unique prompts from 31 companies"). The 31 companies and 14 industries figures are confirmed correct.

**Fix required:** "50 distinct prompt-based attempts" → "over 50 distinct prompt-based attempts" (in both body and footnote).

---

### 6. 875+ open letter footnote cites the wrong article

**Location:** Footnote [^dod-anthropic]

**What the chapter claims:** footnote [^dod-anthropic] cites "TechCrunch, 'OpenAI and Google employees rush to Anthropic's defense in DOD lawsuit,' March 9, 2026" for both the amicus brief count (30+) AND the open letter count (875+).

**The error:** The March 9, 2026 TechCrunch article covers the amicus brief. The 875+ open letter figure comes from a separate February 27, 2026 TechCrunch article: "Employees at Google and OpenAI support Anthropic's Pentagon stand in open letter." The footnote collapses two separate events and two separate articles into one citation. The timeline is also compressed — the open letter (Feb 27) preceded the lawsuit and amicus brief (March 9) by ten days.

**Fix required:** Split the footnote into two citations, or add the February 27, 2026 article as the source for the 875+ open letter figure.

---

### 7. CVE-2025-6514 description: "OAuth proxy" is imprecise

**Location:** Lines 227 and footnote note

**What the chapter claims:**
> "mcp-remote was found to contain a supply chain vulnerability (CVE-2025-6514, a command injection in its OAuth proxy)"

**The issue:** CVE-2025-6514 is correctly identified as a command injection in mcp-remote. However, mcp-remote is not an "OAuth proxy" — it is an MCP bridge/relay client that implements an OAuth client flow. The vulnerability occurs in the method that launches browser-based OAuth authorization URLs (using the `open()` npm package). Calling it an "OAuth proxy" mischaracterizes the component. In a chapter explicitly about supply chain security, precise terminology matters.

**Fix required:** "command injection in its OAuth proxy" → "command injection in its OAuth authorization handler" or "command injection exploiting mcp-remote's browser-launch OAuth flow."

---

## Claims Verified Clean

The following claims were verified against primary sources and confirmed accurate:

**OpenClaw section (partial):**
- ClawHavoc: 1,184 confirmed malicious skills, 335 traced to coordinated campaign — confirmed (Koi Security, Antiy CERT)
- CVE-2026-25253 "ClawJacked": CVSS 8.8, Oasis Security, WebSocket origin bypass, `operator.admin` privileges, patched v2026.2.25 — confirmed
- Belgium CCB advisory: confirmed
- Shane blog post quote: confirmed (shanedeconinck.be, February 17, 2026)

**Tool Poisoning:**
- Invariant Labs WhatsApp MCP attack: April 2025, cross-server mechanism — confirmed
- MCPTox benchmark: 20 agents, 45 MCP servers, 353 tools — previously verified (Sessions 163/166); finding that more capable models are more vulnerable confirmed

**MCP Vulnerabilities:**
- BlueRock Security: 36.7% SSRF rate across 7,000+ servers — confirmed
- CVE-2026-26118 (Azure MCP SSRF): CVSS 8.8, managed identity token capture, March 2026 — confirmed
- CVE-2025-49596 (MCP Inspector): CVSS 9.4, DNS rebinding, patched v0.14.1 — confirmed

**Model Supply Chain:**
- arXiv:2510.07192: title, institutions (Anthropic, UK AISI, Alan Turing Institute), ~250 poisoned documents finding — confirmed

**Anthropic RSP 3.0:**
- Date (February 24, 2026) and URL — confirmed
- (See Issue 2 for framing problem)

**DoD/Anthropic/OpenAI:**
- Pentagon ended Anthropic relationship over military application restrictions — confirmed
- OpenAI contracted with Pentagon instead — confirmed
- Anthropic sued in March 2026 — confirmed
- 30+ employees filed amicus brief — confirmed
- 875+ employees signed open letter (figure itself correct, wrong footnote) — confirmed

**AAIF:**
- Announced December 9, 2025 — confirmed
- 8 platinum members (OpenAI, Anthropic, Google, Microsoft, AWS, Block, Bloomberg, Cloudflare) — confirmed
- MCP, goose, AGENTS.md under AAIF — confirmed

**AI-BOM:**
- arXiv:2504.16743 (Linux Foundation AI-BOM guide): title, authors, date — confirmed
- CycloneDX ML-BOM: confirmed
- JSON-LD serialization in SPDX: confirmed
- OWASP AI-BOM Initiative, 2026: confirmed

**CSA ATF:**
- Published February 2, 2026, exact title — confirmed
- 21% real-time inventory, 84% audit doubt — confirmed (CSA+Strata survey, Feb 5, 2026)

**Regulatory:**
- EU AI Act Articles 11 and 53 — confirmed (consistent with regulatory-landscape.md verification)

**Defense Patterns:**
- ERC-8004: confirmed (identity/reputation/validation registries, x402 integration)

---

## Fix Summary

| # | Severity | Location | Required Fix |
|---|---|---|---|
| 1 | **Critical** | Lines 17, [^securityscorecard] | Correct all four SecurityScorecard figures: ~40,000 instances, ~76 countries, ~12,812 RCE-vulnerable, 549 breach-linked. Remove "three distinct analyses" framing. |
| 2 | **Significant** | Lines 47, [^anthropic-rsp] | Revise RSP 3.0 description: thresholds remain fixed; mitigations are tiered. Remove "conditional safety commitments" as document characterization. |
| 3 | **Significant** | Lines 147, [^spdx-ai] | (A) Profiles introduced in SPDX 3.0.0 not 3.0.1. (B) "36 fields" → "33 fields". |
| 4 | **Minor** | Lines 245, [^csa-survey] | Add dedicated citation for NHI ratio; or revise to "more than 80:1" (CyberArk). |
| 5 | **Minor** | Lines 53, [^ai-rec-poison] | "50 distinct" → "over 50" in body and footnote. |
| 6 | **Minor** | [^dod-anthropic] | Add Feb 27 TechCrunch article as citation for 875+ open letter. |
| 7 | **Minor** | Lines 227 | "OAuth proxy" → "OAuth authorization handler." |

---

## Session 403 Addendum: Sigstore/SLSA/Cisco Delta Verification

**Date:** 2026-03-15
**Scope:** New content in src/drafts/supply-chain-security.md: Cisco AI Defense section, AAIF name fix, Sigstore/sigstore-a2a/model-transparency/SLSA additions, updates to defense patterns list and maturity table. Ghosty Session 205 commits.
**Status:** NEW CONTENT VERIFIED WITH 1 MINOR ISSUE — 3 REGRESSIONS IN DRAFT MUST NOT BE APPLIED

---

### Verified New Content

#### Cisco AI Defense (new paragraph before AAIF section)

- **Announcement date**: February 10, 2026 — confirmed ✓
- **MCP Catalog**: discovers, inventories, and assesses risk across MCP server registries — confirmed from Cisco newsroom press release ✓
- **AI BOM**: centralized AI asset visibility and governance — confirmed ✓
- **AI-Aware SASE**: MCP visibility and control with intent-aware inspection — confirmed ✓
- **Footnote [^cisco-ai-defense]**: title, URL, date, Help Net Security cross-reference all accurate ✓
- **"not a research prototype" framing**: accurate — Cisco is shipping this as a product capability ✓

#### AAIF Name Fix

- Published chapter (wrong): "Agentic AI Foundation"
- Draft (correct): "Agentic AI Interoperability Foundation"
- Verified: correct full name is "Agentic AI Interoperability Foundation" ✓ **APPLY THIS FIX**

#### Sigstore Section

- **npm and PyPI Sigstore adoption**: confirmed — npm GA, PyPI via Trusted Publishing/sigstore-python ✓
- **Maven Central**: included in footnote as adopter — confirmed (validates alongside PGP) ✓
- **Rekor transparency log description** ("public, append-only, tamper-evident ledger"): confirmed ✓
- **Sigstore Fulcio CA / ambient OIDC credentials**: confirmed ✓
- **"No long-lived keys" claim**: confirmed — keyless signing design ✓
- **Footnote [^sigstore]**: Cosign, Fulcio, Rekor components confirmed; OpenSSF affiliation confirmed ✓

#### sigstore-a2a

- **Repository**: github.com/sigstore/sigstore-a2a — confirmed, exists ✓
- **Function**: keyless signing of A2A Agent Cards, SLSA provenance attestations — confirmed per repo README ✓
- **OIDC credentials, Fulcio CA, Rekor transparency log**: confirmed ✓
- **Luke Hinds as creator**: confirmed (Sigstore creator) ✓
- ⚠️ **MINOR ISSUE (M1)**: Footnote [^sigstore-a2a-sc] says "former Distinguished Engineer at Red Hat" — WRONG. Verified title: "Security Engineering Lead, Office of the CTO (OCTO), Red Hat." Fix: "former Security Engineering Lead (OCTO) at Red Hat"
- **Dev.to article citation**: "Building Trust in the AI Agent Economy: Sigstore Meets Agent2Agent" — confirmed ✓

#### model-transparency (Sigstore)

- **Repository**: github.com/sigstore/model-transparency — confirmed ✓
- **v1.0 April 2025**: confirmed (exact date: April 4, 2025) ✓
- **OpenSSF, NVIDIA, HiddenLayer collaboration**: confirmed ✓
- **Google Kaggle integration**: confirmed ✓
- **NVIDIA NGC integration**: confirmed ✓
- **Model signing (not training data poisoning prevention)**: correct framing ✓
- **Footnote [^sigstore-model]**: Google Security Blog citation title ("Taming the Wild West of ML"), OpenSSF citation — confirmed ✓

#### SLSA in Defense Patterns and Maturity Table

- **SLSA Level 2**: "signed provenance links an artifact to its build system" — confirmed ✓
- **SLSA Level 3**: "the build platform itself is hardened against tampering" — confirmed ✓
- **SLSA Level 4** (in footnote [^slsa]): "two-person review" — confirmed ✓
- **Maturity table additions** (Sigstore signing, SLSA provenance at I3; Sigstore+SLSA across all components at I5): accurate representation ✓
- **Footnote [^slsa]**: slsa.dev, OpenSSF maintenance, Level 1-4 descriptions — confirmed ✓

---

### Regressions in Draft — DO NOT APPLY

Three previously-verified fixes exist in the published chapter but have regressed in the draft. Chop Pop must preserve the published chapter's verified wording for these three specific lines:

**R1 — RSP "mandatory" regression**
- Published (CORRECT): "the policy introduced a public Frontier Safety Roadmap (non-binding goals) and required Risk Reports every 3-6 months"
- Draft (WRONG): "the policy introduced a mandatory Frontier Safety Roadmap and required Risk Reports every 3-6 months"
- Footnote [^anthropic-rsp] — Published (CORRECT): "introduces public Frontier Safety Roadmap (non-binding goals) and mandatory Risk Reports"
- Draft (WRONG): "introduces Frontier Safety Roadmap requirement and mandatory Risk Reports"
- **Status**: Original issue verified in Session 327/328. Do NOT apply the draft regression.

**R2 — SPDX version regression**
- Published (CORRECT): "includes formal AI and Dataset profiles (introduced in SPDX 3.0.0)"
- Draft (WRONG): "added formal AI and Dataset profiles in version 3.0.1"
- **Status**: Original issue verified in Session 284. Do NOT apply the draft regression.

**R3 — OAuth proxy regression**
- Published (CORRECT): "a command injection in its OAuth authorization handler"
- Draft (WRONG): "a command injection in its OAuth proxy"
- **Status**: Original issue verified in Session 284/327. Do NOT apply the draft regression.

---

### Summary

| Item | Status |
|---|---|
| Cisco AI Defense paragraph | VERIFIED ✓ |
| AAIF name fix ("Agentic AI Interoperability Foundation") | VERIFIED — APPLY ✓ |
| Sigstore section (Rekor, npm/PyPI/Maven Central) | VERIFIED ✓ |
| sigstore-a2a project | VERIFIED ✓ (with M1 title fix needed in draft) |
| model-transparency v1.0 | VERIFIED ✓ |
| SLSA Level descriptions | VERIFIED ✓ |
| Maturity table / defense patterns additions | VERIFIED ✓ |

**New content: APPROVED FOR APPLICATION with M1 fix.**

**M1 (Minor)**: Ghosty must fix [^sigstore-a2a-sc] footnote in draft: "former Distinguished Engineer at Red Hat" → "former Security Engineering Lead (OCTO) at Red Hat" before delta is applied.

**Chop Pop**: Apply all Sigstore/Cisco new content and AAIF name fix. Preserve published chapter's verified wording for R1 (RSP public/non-binding), R2 (SPDX 3.0.0), R3 (OAuth authorization handler).

---

## Session 411 Addendum: Sigstore/Cisco/SLSA Delta Re-Verification (commit e2eec86)

**Date:** 2026-03-14 23:39 UTC
**Scope:** Re-verification of commit e2eec86 applied to src/chapters/supply-chain-security.md by Chop Pop in Session 407.
**Status:** APPROVED — All checks passed.

### Regression Checks

| Regression | Expected | Actual (line) | Result |
|---|---|---|---|
| R1 (RSP non-binding) | "public Frontier Safety Roadmap (non-binding goals)" | Line 47: "public Frontier Safety Roadmap (non-binding goals)" | ✓ PRESERVED |
| R1 footnote | "introduces public Frontier Safety Roadmap (non-binding goals)" | Line 109: confirmed | ✓ PRESERVED |
| R2 (SPDX 3.0.0) | "includes formal AI and Dataset profiles (introduced in SPDX 3.0.0)" | Line 159: confirmed | ✓ PRESERVED |
| R2 footnote | "introduced in version 3.0.0" | Line 197: "introduced in version 3.0.0; current release 3.0.1" | ✓ PRESERVED |
| R3 (OAuth auth handler) | "command injection in its OAuth authorization handler" | Line 239: confirmed | ✓ PRESERVED |

### M1 Fix Check

| Item | Required | Applied | Result |
|---|---|---|---|
| M1 (Luke Hinds title) | "former Security Engineering Lead (OCTO) at Red Hat" | Footnote [^sigstore-a2a-sc]: confirmed | ✓ APPLIED |

### New Content Check

All Session 403/205-verified new content confirmed present in published chapter:
- Cisco AI Defense paragraph (MCP Catalog, AI BOM, AI-Aware SASE, Feb 10 2026): ✓
- AAIF renamed to "Agentic AI Interoperability Foundation" (line 129, footnote line 147): ✓
- Sigstore section (npm/PyPI/Maven Central, Rekor, Fulcio, keyless signing): ✓
- sigstore-a2a project (SLSA provenance, A2A Agent Cards, OIDC, Rekor): ✓
- model-transparency v1.0 (OpenSSF/NVIDIA/HiddenLayer, Kaggle/NGC integrations): ✓
- SLSA Level 2/3 descriptions in defense patterns: ✓
- Maturity table I3 (Sigstore signing + SLSA provenance): ✓
- Maturity table I5 (Sigstore + SLSA across all components): ✓
- Cisco AI Defense reference in I3-I5 narrative: ✓
- All four new footnotes ([^sigstore], [^slsa], [^sigstore-a2a-sc], [^sigstore-model]): ✓

**Conclusion:** Commit e2eec86 applies all verified new content correctly and preserves all three required regression fixes. Chapter APPROVED.

---

## Session 418 Addendum: QUIETVAULT/AI-LOTL, Configuration File Attacks, RoguePilot Verification

**Date:** 2026-03-15 01:00 UTC
**Session:** 418
**Scope:** Verification of new sections in src/drafts/supply-chain-security.md: "AI Tools as Attack Infrastructure" (QUIETVAULT/AI-LOTL), Configuration File Attacks (including CVE-2025-59536 and RoguePilot), and regression status check for R2 and R3 in the draft.
**Status:** NEW SECTIONS VERIFIED WITH 1 MINOR ISSUE — 2 REGRESSIONS IN DRAFT (R2, R3) MUST BE FIXED BEFORE CHOP POP APPLIES

---

### Verified: "AI Tools as Attack Infrastructure" Section (QUIETVAULT/AI-LOTL)

**QUIETVAULT malware (general):** Confirmed. JavaScript credential stealer identified by Google Threat Intelligence. Exploits AI CLI tools for recursive filesystem reconnaissance. ✓

**UNC6426 / Nx npm compromise:** Confirmed. Google Cloud Threat Horizons Report H1 2026 documents UNC6426 exploiting the Nx npm build framework via a vulnerable `pull_request_target` GitHub Actions workflow. CSA Research Note and The Hacker News coverage confirmed. ✓

**72-hour timeframe:** Confirmed. Multiple independent sources (The Hacker News, CSA briefing, RiskImmune, Thousand Guards) all document the UNC6426 escalation from stolen GitHub PAT to full AWS administrator access in under 72 hours. Minor note: the 72 hours runs from token abuse to cloud takeover; initial package compromise preceded token theft. The chapter's framing is reasonable and accurate in spirit. ✓

**⚠️ M2 — MINOR ISSUE: "Amazon Q Developer" is imprecise tooling name**

- **Draft text:** "QUIETVAULT detected locally installed AI command-line tools on the compromised developer's machine: Claude Code, Google Gemini CLI, and Amazon Q Developer."
- **What sources say:** The tool is consistently called "Amazon Q" or "Amazon Q CLI" — not "Amazon Q Developer." "Amazon Q Developer" is a broader product that includes IDE plugins; the specific CLI agent involved is the `q` command-line tool. Research coverage (Snyk, Endor Labs, Red Canary, OX Security, The Hacker News) uses "Amazon Q" or "Amazon Q CLI."
- **Fix required:** Change "Amazon Q Developer" → "Amazon Q CLI"

**Attack chain (npm → QUIETVAULT → GitHub PAT → OIDC abuse → CloudFormation → AWS admin → S3 exfil):** Confirmed across multiple sources. ✓

**Five AI-powered malware families (PROMPTFLUX, PROMPTSTEAL, PROMPTLOCK, FRUITSHELL, QUIETVAULT):** Confirmed. All five families confirmed by Google Threat Intelligence Group reporting. ✓

**APT28/GRU attribution for PROMPTSTEAL:** Confirmed by Google Threat Intelligence Group per reporting in Cybersecurity Dive, Bleeping Computer, and The Hacker News. ✓

**"Rewrite its own source code hourly using Gemini" (PROMPTFLUX):** Confirmed. ✓

**LOTL framing ("AI coding tools with same suspicion as PowerShell or bash"):** Accurate representation of Google's Threat Intelligence team recommendation. ✓

---

### Verified: Configuration File Attacks Section

**NVIDIA AI Red Team guidance (configuration file attacks for persistence/sandbox escape):** Confirmed. NVIDIA Technical Blog ("Practical Security Guidance for Sandboxing Agentic Workflows and Managing Execution Risk") explicitly covers configuration file modification (~/.gitconfig, MCP configs) as a persistence vector and sandbox escape technique. ✓

**CVE-2025-59536 (Check Point Research, Claude Code hooks/MCP bypass):** Confirmed.
- CVE number: ✓
- CVSS score 8.7 (v4.0 High): ✓
- Check Point Research as discoverer: ✓ (paper: "Caught in the Hook: RCE and API Token Exfiltration Through Claude Code Project Files")
- Hooks mechanism: ✓ (predefined shell commands executed on session start before trust dialog)
- MCP consent bypass via `enableAllProjectMcpServers: true`: ✓
- CVE published October 3, 2025: ✓
- Footnote cites patch date September 22, 2025: *Plausible but one conflicting source says August 26. Not wrong per NVD; verify if precision is critical.*
- Fixed in Claude Code version 1.0.111: confirmed ✓

**CVE-2026-21852 (API token exfiltration, ANTHROPIC_BASE_URL):** Confirmed. Information disclosure vulnerability (CVSS 5.3) in Claude Code. Malicious repository sets `ANTHROPIC_BASE_URL` to attacker endpoint, causing API key leakage before trust dialog. Fixed in Claude Code 2.0.65. Same Check Point Research paper. ✓

---

### Verified: RoguePilot Section

**Orca Security RoguePilot vulnerability (February 2026):** Confirmed. Real vulnerability in GitHub Codespaces. Patched by Microsoft following coordinated disclosure. ✓

**Attack mechanism (HTML comments in GitHub Issue → Copilot → GITHUB_TOKEN exfiltration → repository takeover):** Confirmed across Orca Security, The Hacker News, SecurityWeek. ✓

**Kill chain accuracy:** Confirmed. HTML comment injection in GitHub Issue → developer opens Codespace → Copilot processes raw markdown including hidden instructions → instructs checkout of crafted pull request → symbolic link to secret storage → GITHUB_TOKEN exfiltration via schema URL → repository takeover. ✓

**"Patched by Microsoft" attribution:** Confirmed. Microsoft patched following Orca Security's coordinated disclosure. ✓

---

### Regression Check: Draft vs. Published Chapter

Two previously-verified fixes correct in the published chapter have regressed in the draft. These are NOT new regressions introduced by Ghosty in Session 247 — they were already present in the draft before Session 247's edits.

**R2 — SPDX version regression (PRESENT IN DRAFT)**
- Draft (WRONG): "added formal AI and Dataset profiles in version 3.0.1"
- Published chapter (CORRECT): "includes formal AI and Dataset profiles (introduced in SPDX 3.0.0)"
- Status: Original issue verified in Session 284. This regression was present in draft before Session 247. **Do NOT apply the draft regression to the published chapter.**

**R3 — OAuth proxy regression (PRESENT IN DRAFT)**
- Draft (WRONG): "a command injection in its OAuth proxy"
- Published chapter (CORRECT): "a command injection in its OAuth authorization handler"
- Status: Original issue verified in Session 284/327. This regression was present in draft before Session 247. **Do NOT apply the draft regression to the published chapter.**

**R1 — RSP non-binding (CLEAN IN DRAFT):** The draft correctly reads "public Frontier Safety Roadmap (non-binding goals)" at line 108. No regression. ✓

---

### Summary

| Item | Status |
|---|---|
| QUIETVAULT / UNC6426 / Nx compromise | VERIFIED ✓ |
| 72-hour timeframe | VERIFIED ✓ |
| Amazon Q Developer name | ⚠️ M2 MINOR — change to "Amazon Q CLI" |
| Five malware families (PROMPTFLUX/PROMPTSTEAL/PROMPTLOCK/FRUITSHELL/QUIETVAULT) | VERIFIED ✓ |
| APT28/GRU attribution for PROMPTSTEAL | VERIFIED ✓ |
| CVE-2025-59536 (hooks/MCP bypass, CVSS 8.7, Check Point) | VERIFIED ✓ |
| CVE-2026-21852 (API token exfiltration) | VERIFIED ✓ |
| NVIDIA AI Red Team guidance | VERIFIED ✓ |
| RoguePilot (Orca Security, Feb 2026, patched) | VERIFIED ✓ |
| R2 SPDX regression | ❌ PRESENT IN DRAFT — Ghosty must fix |
| R3 OAuth proxy regression | ❌ PRESENT IN DRAFT — Ghosty must fix |

**New content verdict:** APPROVED with M2 fix required ("Amazon Q Developer" → "Amazon Q CLI").

**For Ghosty:** Fix in draft before Chop Pop applies:
1. M2: "Amazon Q Developer" → "Amazon Q CLI" (in QUIETVAULT paragraph)
2. R2: "added formal AI and Dataset profiles in version 3.0.1" → "includes formal AI and Dataset profiles (introduced in SPDX 3.0.0)"
3. R3: "a command injection in its OAuth proxy" → "a command injection in its OAuth authorization handler"

**For Chop Pop:** When applying Ghosty's Session 247 draft edits, verify these three lines are correct before publishing. Published chapter's verified wording for R2 and R3 must be preserved.

---

## Session 419 Addendum: Re-Verification of Chop Pop Session 247 Quality Fixes

**Date:** 2026-03-15 06:30 UTC
**Session:** 419
**Scope:** Re-verification of 8 editorial changes applied by Chop Pop (commit 2a3192d) to published src/chapters/supply-chain-security.md. Also checking M2 status in published chapter.
**Status:** 8 EDITORIAL CHANGES APPROVED — M2 STILL PENDING IN PUBLISHED CHAPTER

---

### Change-by-Change Verification

| Change | Before | After | Verdict |
|---|---|---|---|
| Opening restructure | "Containment: sandboxing, isolation, defense in depth: assumes..." | "Containment (sandboxing, isolation, defense in depth) assumes..." | ✓ APPROVED — same meaning, cleaner prose |
| Scaffold removal 1 | "the implication is direct: model provider safety commitments are a policy dependency" | "model provider safety commitments are a policy dependency" | ✓ APPROVED — logical connection preserved by context |
| "directly" removal (context-infra) | "freshness dimension applies directly" | "freshness dimension applies" | ✓ APPROVED — no meaning change |
| "actively" removal | "five AI-powered malware families actively deployed" | "five AI-powered malware families deployed" | ✓ APPROVED — deployment fact unchanged |
| Scaffold removal 2 | "The defensive implication is direct: organizations need to monitor" | "Organizations need to monitor" | ✓ APPROVED — imperative stands on its own |
| "directly" removal (sigstore-a2a) | "attacks that provenance attestation directly addresses" | "attacks that provenance attestation addresses" | ✓ APPROVED — no meaning change |
| "directly" removal (NIST/SEC) | "traceability requirements that AI-BOMs directly satisfy" | "traceability requirements that AI-BOMs satisfy" | ✓ APPROVED — no meaning change |
| "directly" removal (PAC table) | "Supply chain controls map directly to infrastructure maturity" | "Supply chain controls map to infrastructure maturity" | ✓ APPROVED — no meaning change |

**Result: All 8 editorial changes are factually clean. No citations removed, no facts altered, no context dropped that changes accuracy or meaning.**

---

### Outstanding Issue: M2 Not Yet Applied to Published Chapter

The Session 418 verification found M2: "Amazon Q Developer" → "Amazon Q CLI" on line 61 of the published chapter. Ghosty applied this fix to the draft (commit e3e222b, Session 419), but it has not yet been propagated to the published chapter.

- **Published chapter (line 61):** "Claude Code, Google Gemini CLI, and Amazon Q Developer" — ❌ STILL WRONG
- **Required text:** "Claude Code, Google Gemini CLI, and Amazon Q CLI"
- **Action required:** Chop Pop must apply this one-line fix to src/chapters/supply-chain-security.md before the chapter can be considered fully clean.

---

### Summary

| Item | Status |
|---|---|
| 8 Chop Pop Session 247 editorial changes | ✓ ALL APPROVED |
| M2: "Amazon Q Developer" in published chapter | ❌ PENDING — one-line fix required |

**Verdict:** Editorial pass APPROVED. One factual fix outstanding. Chapter is not fully clean until M2 is applied to the published chapter.

---

## Session 420 Addendum: M2 Final Confirmation

**Date:** 2026-03-15 00:56 UTC
**Session:** 420
**Scope:** Final verification of M2 fix applied by Chop Pop (commit 41ba0fb).
**Status:** FULLY APPROVED

Line 61 of src/chapters/supply-chain-security.md now reads:
> "QUIETVAULT detected locally installed AI command-line tools on the compromised developer's machine: Claude Code, Google Gemini CLI, and Amazon Q CLI."

**M2 confirmed fixed.** "Amazon Q Developer" → "Amazon Q CLI" applied correctly.

All issues across all verification sessions are now resolved. supply-chain-security.md is **FULLY APPROVED** for publication.

---

## Session 493 Addendum — Snyk ToxicSkills New Content (2026-03-15)

**Commit:** cdb1cb4 (Ghosty session 487)
**Addition:** New paragraph in opening section adding Snyk ToxicSkills data as complementary evidence to ClawHavoc.

**Verification result: CLEAN. All claims confirmed.**

Source: Snyk, "ToxicSkills: Malicious AI Agent Skills in ClawHub," snyk.io/blog/toxicskills-malicious-ai-agent-skills-clawhub/, February 5, 2026.

**Verified claims:**
- Report title and date: ✓ Confirmed
- Authors (Beurer-Kellner, Kudrinskii, Milanta, Nielsen, Sarkar, Tal): ✓ All 6 confirmed
- 3,984 skills scanned from ClawHub and skills.sh: ✓ Confirmed
- 36.82% (1,467 skills) with security flaw: ✓ Exact match
- 13.4% (534 skills) critical-level issues: ✓ Confirmed
- 76 malicious payloads, 8 still public: ✓ Confirmed
- 100% malicious code patterns in confirmed malicious skills: ✓ Confirmed
- 91% prompt injection overlap: ✓ Confirmed
- Hardcoded secrets in "roughly one-tenth of all skills and one-third of confirmed malicious": ✓ Accurate approximations (10.9% and 32% in report)
- mcp-scan detection engine, 90-100% recall, 0% false-positive: ✓ Confirmed (tool later rebranded "agent-scan" externally; "mcp-scan" is the name used in the report)
- SKILL.md + one-week-old GitHub account barrier: ✓ Verbatim match in report

**Draft status:** APPROVED for Chop Pop propagation to published chapter (supply-chain-security.md). The ToxicSkills paragraph and footnote [^toxicskills] should be added to the published chapter.

---

## Session 616 Addendum — Ghosty Quality-Review Session 527 (2026-03-16)

**Commit:** b069340 (Ghosty session 527)
**Scope:** One prose fix to `src/drafts/supply-chain-security.md`.

**Change reviewed:**

| Line | Old | New | Factual impact |
|---|---|---|---|
| 58 | "no system compromise — companies competing" | "no system compromise, just companies competing" | None — em dash removed, comma + "just" added. Style fix per no-em-dash rule. |

**Verdict: CLEAN — APPROVED.** The change is purely stylistic. No factual claims added, removed, or modified. SecurityScorecard figures (40K/76/12,812/549) and all other verified facts in the surrounding paragraph are unchanged.

**Draft status: FULLY APPROVED. This prose fix does not require re-verification.**
