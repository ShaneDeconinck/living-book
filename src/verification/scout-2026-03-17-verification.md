# Verification Report: scout-2026-03-17.md

**Verified:** 2026-03-17
**Verdict:** FACTUAL ERRORS — send to ghosty for correction

---

## Section 1: IETF OAuth WG

### draft-klrc-aiagent-auth-00 (Kasselman)
**CONFIRMED** with minor omission.
- Filing date March 2, 2026: confirmed via IETF datatracker.
- The brief attributes it to "Pieter Kasselman" — correct as lead author, but the draft has four co-authors: Pieter Kasselman (Defakto Security), Jeff Lombardo (AWS), Yaroslav Rosomakho (Zscaler), Brian Campbell (Ping Identity). The acronym "klrc" reflects all four initials.
- **Fix:** Attribute as "Kasselman et al." or name all four authors.

### draft-barney-caam-00 / CAAM (Barney)
**DATE CONTRADICTED.**
- The brief states "Jonathan Barney, March 12." The IETF datatracker shows submission date as **February 24, 2026**, not March 12.
- March 12 is when a feedback request thread appeared on the IETF OAuth WG mailing list ("[OAUTH-WG] Contextual Agent Authorization Mesh (CAAM) & Token Delegation feedback request") — this was conflated with the filing date.
- **Fix:** Change filing date from March 12 to February 24.

### AgentID (Warren Parad et al., March 15)
**UNCONFIRMED — caveat in brief is appropriate.**
- A thread "[OAUTH-WG] New I-D: AgentID - An Identity Protocol for Autonomous AI Agents" appeared on the mailing list March 15, 2026.
- No datatracker entry found for any draft with "agentid" in the name.
- The thread was posted by "tim" (not Warren Parad); Parad replied but is not confirmed as the submitter or lead author.
- The brief's own caveat ("not confirmed in datatracker as of yesterday's scout") is accurate and appropriate. No correction needed beyond noting Parad's role is uncertain.

### "Overlap of AI related proposals" thread, March 16
**CONFIRMED.**
- Thread exists in OAuth WG mailing list archive, dated March 16, 2026.
- Dick Hardt, Bjorn Hjelm, and Alex Babeanu confirmed as respondents.
- Thread originator appears as "george" in the archive listing.

### A2A OAuth Transaction Token Profile ("George, March 16")
**CONFIRMED** (circumstantially — the thread originator is "george," consistent with the brief's attribution).

---

## Section 2: MCP Roadmap

### Spec version 2025-11-25, no 2026 release
**CONFIRMED.** Matches modelcontextprotocol.io and GitHub releases.

### Roadmap page updated March 5
**CONFIRMED with minor precision note.** The roadmap.mdx file carries "last updated: 2026-03-05." The corresponding GitHub commit is dated March 6 (commit message: "Update roadmap to reflect 2026 core maintainer priorities (#2321)"). One-day discrepancy; the document's own date is March 5. Not a meaningful error.

### SEP-1932 (DPoP) and SEP-1933 (Workload Identity Federation)
**CONFIRMED.** Both are open PRs/issues in the modelcontextprotocol repo:
- SEP-1932: authored by PieterKas, in review
- SEP-1933: authored by PieterKas, sponsored by D-McAdams, in review
- Note: both are proposals under review, not yet merged into the spec. The brief correctly says "in progress."

### Enterprise gaps named in roadmap
**PARTIALLY CONTRADICTED.**
- Audit trails/observability: **CONFIRMED**
- Enterprise-managed auth (SSO away from static secrets): **CONFIRMED**
- Gateway/proxy authorization propagation: **CONFIRMED** (roadmap phrasing is "gateway and proxy patterns with defined behavior" — brief's paraphrase is accurate)
- Conformance test suites: **MISCLASSIFIED.** The roadmap places conformance test suites under a "Validation Focus" section, not under the Enterprise Readiness gap areas. The brief groups it with enterprise gaps, which is incorrect.
- Missing: "Configuration portability across different MCP clients" is listed as an enterprise gap in the roadmap but absent from the brief's list. Minor omission.
- **Fix:** Move "conformance test suites" out of enterprise gaps; note it is a validation priority. Add "configuration portability" to the enterprise gaps list.

---

## Section 3: Google A2A

### v1.0.0 released "March 16"
**CONTRADICTED.** v1.0.0 was released **March 12, 2026**, not March 16. The brief says "Three spec editorial errors found within 4 days of v1.0.0 release (March 16)" — the parenthetical "(March 16)" is the release date, which is wrong. The issues were opened March 16, which is indeed 4 days after the March 12 release. The "4 days" calculation is correct; the stated release date is wrong.
- **Fix:** Change "v1.0.0 release (March 16)" to "v1.0.0 release (March 12)."

### Issue #1639 (deprecated `application/a2a+json`)
**CONFIRMED** with framing note. The issue title is "[Bug]: v1.0.0 spec examples use the `application/a2a+json` content type." The issue frames this as an inconsistency with the requirement to use `application/json`, not explicitly as a "deprecated" type. Brief's characterization is reasonable. No correction required.

### Issue #1642 (TASK_STATE_RUNNING enum, lowercase values)
**CONFIRMED exactly.**

### Issue #1643 (Section 6 RFC 7807 vs Section 11.6 AIP-193)
**CONFIRMED exactly.**

### PRs #1640-1641
**CONFIRMED for #1639 and #1642.** PR #1640 fixes Issue #1639; PR #1641 fixes Issue #1642. No PR found for Issue #1643 as of the scout date. The brief says these PRs are fixing "these issues" — minor overstatement since #1643 has no PR yet.

### Issue #1638 (community Rust SDK, March 16)
**CONFIRMED exactly.**

### Repository identity
The A2A repo is now under `a2aproject/A2A` (Linux Foundation governance), not `google/A2A`. The brief does not specify the repo path, so no error — but worth noting for chapter references.

---

## Summary of Errors

| Error | Location | Severity | Fix |
|---|---|---|---|
| CAAM filing date wrong (Feb 24, not March 12) | Section 1 | Medium | Change date |
| A2A v1.0.0 release date wrong (March 12, not March 16) | Section 3 | Medium | Change date |
| Conformance test suites misclassified as enterprise gap | Section 2 | Low | Move to validation priority |
| draft-klrc-aiagent-auth-00 has 4 co-authors, not just Kasselman | Section 1 | Low | Add "et al." |
| AgentID submitter/author uncertain | Section 1 | Low | Brief's own caveat is adequate |

**Overall:** The scout's strategic analysis and relevance assessments are sound. The errors are factual date/classification issues in the raw data, not in the narrative conclusions.
