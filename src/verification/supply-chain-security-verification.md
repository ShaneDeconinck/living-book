# Verification Report: Agent Supply Chain Security

**Chapter:** src/chapters/supply-chain-security.md
**Verified:** 2026-03-14
**Session:** 284
**Verifier:** Sapere Aude
**Status:** ISSUES FOUND — 1 critical, 2 significant, 4 minor fixes required before re-approval

---

## Summary

The chapter is structurally sound and covers a critical topic with good source density. Most technical claims, CVE details, and vendor figures check out. However, one set of figures is critically inflated — the SecurityScorecard breach-linked count is 100x the actual reported figure — and two other significant errors require correction: the RSP 3.0 framing misrepresents the document's structure, and the SPDX 3.0.1 claim contains two errors.

**Confirmed clean:** BlueRock SSRF rate (36.7%, 7,000+ servers), arXiv:2510.07192 (250 poisoned documents, all three institutions), CSA ATF (Feb 2, 2026), CSA+Strata survey (21%/84%), AAIF membership (8 platinum, Dec 9 2025), Invariant Labs WhatsApp MCP (April 2025), arXiv:2504.16743 (Linux Foundation AI-BOM guide), MCPTox benchmark (previously verified), Anthropic RSP 3.0 date (Feb 24, 2026), Anthropic lawsuit (March 2026), 30+ employees amicus brief, JSON-LD serialization in SPDX.

---

## Critical Issues

### 1. SecurityScorecard STRIKE Team figures are wrong across all four metrics

**Location:** Lines 17 and footnote [^securityscorecard]

**What the chapter claims:**
> "SecurityScorecard's STRIKE Team conducted three distinct analyses of the OpenClaw exposure surface: a scan identifying over 135,000 publicly exposed instances across 82 countries, a vulnerability assessment finding over 15,000 directly vulnerable to remote code execution, and a threat intelligence correlation linking more than 53,000 to prior breach activity."

**What the SecurityScorecard report actually says:**

| Metric | Chapter claims | Actual (per Infosecurity Magazine, SiliconANGLE, STRIKE Team) |
|---|---|---|
| Total exposed instances | 135,000+ | ~40,000+ (~40,214) |
| Countries | 82 | ~76 |
| Vulnerable to RCE | 15,000+ | ~12,812 |
| Linked to breach activity | 53,000+ | **549** |

The breach-linked figure is the most severe error: 53,000+ in the chapter versus 549 in the source. This is a 100x inflation, not a rounding difference.

**Also wrong:** The chapter describes "three distinct analyses" as a structured methodology. The SecurityScorecard source describes a single continuous scanning operation with a live dashboard (declawed.io), not three discrete studies. The three-part framing is the chapter's own editorial structure, not how the report describes its methodology.

**Fix required:** Replace all four figures with the correct values. Remove "three distinct analyses" framing or rephrase to accurately describe a single scanning operation with multiple metrics. The footnote [^securityscorecard] body also states the three-figure structure as fact — revise to match the actual report.

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
