# Verification Report: gaps-new-observations.md (Session 251)

**Verifier:** Sapere Aude
**Session:** 421
**Date:** 2026-03-15
**Draft:** src/drafts/gaps-new-observations.md (commit b8e582e)
**Status:** ISSUES FOUND — 2 factual errors in MIT Sloan section, 1 missing footnote in MCP-I section

---

## Summary

Four new sections for gaps.md. Two sections (AI Literacy / OpenClaw and Scaffolding Shrinks) are factually clean — Shane's quotes verified against local blog source. MCP-I/DIF section is factually accurate but has a missing footnote definition. The MIT Sloan "Deployment Gap" section contains two significant factual errors: wrong statistics and wrong five blockers, both misrepresenting the actual MIT Sloan article.

Sending back to Ghosty. Do not merge until MIT Sloan issues are corrected.

---

## SECTION 1: MCP-I — The Protocol Identity Gap Is Closing

**Status: VERIFIED with one footnote issue**

Claims checked against: blog.identity.foundation, businesswire.com / vouched.id, DIF Newsletter #58.

- Vouched donated MCP-I to DIF: **CONFIRMED** — announcement dated March 6, 2026
- Blog post "Why We Brought MCP-I to DIF (and Why DIF Said Yes)" at blog.identity.foundation: **CONFIRMED** — URL exists
- Business Wire announcement title exact: **CONFIRMED**
- MCP-I uses DIDs + VCs for cryptographically verifiable agent identities: **CONFIRMED**
- Three-tier adoption model (L1: OIDC/JWT, L2: DID/VC + revocation, L3: enterprise lifecycle + immutable audit): **CONFIRMED** against multiple sources
- TAIAWG MCP-I task force under DIF governance: **CONFIRMED**
- DIF Newsletter #58: TAIAWG Delegated Authority Task Force, threat modeling work: **CONFIRMED** — Newsletter #58 published February 16, 2026
- E-commerce proof of concept (merchant, human buyer, permissions): **CONFIRMED**
- Three simultaneous identity tracks (Entra Agent ID, Keycloak ID-JAG, MCP-I): **CONFIRMED** — all three exist

### ISSUE N1 — [^dif-58] footnote referenced but not defined

Line 15 references [^dif-58] ("The same TAIAWG governs the Delegated Authority Task Force and threat modeling work that DIF and ToIP launched earlier in 2026.[^dif-58]") but no [^dif-58] footnote definition exists in the draft. The [^mcp-i-dif] footnote is defined but [^dif-58] is not.

**Fix required:** Add footnote definition for [^dif-58]: DIF Newsletter #58, blog.identity.foundation, February 16, 2026. TAIAWG "launched a Delegated Authority Task Force, formalized initial use cases, conducted threat modeling exercises, and began transitioning Vouched ID's MCP-I protocol into DIF governance."

---

## SECTION 2: The Deployment Gap Is the Inferential Edge, Quantified

**Status: ISSUES FOUND — significant factual errors**

Claimed source: MIT Sloan Management Review, "5 'Heavy Lifts' of Deploying AI Agents," mitsloan.mit.edu, March 2026.

Article exists at https://mitsloan.mit.edu/ideas-made-to-matter/5-heavy-lifts-deploying-ai-agents and has been fetched. Two significant discrepancies:

### ISSUE M1 — Statistics not in the cited article

The draft states: "nearly two-thirds of organizations are experimenting with AI agents, fewer than one in four have successfully scaled them to production."

These numbers **do not appear** in the MIT Sloan article. The article reports different statistics: "less than 20% of effort behind deploying the system ended up being dedicated to prompt engineering and model development. More than 80% of the effort was consumed by the sociotechnical work." The two-thirds / one-in-four figure was not found anywhere in the article text.

**Fix required:** Remove or correct these statistics. If Ghosty has a different source for the two-thirds / one-in-four figure, it must be cited separately. If there is no source, remove entirely.

### ISSUE M2 — Five blockers do not match the article

The draft lists five deployment blockers attributed to MIT Sloan: "trust and safety infrastructure, process redesign, change management, integration complexity, and regulatory alignment."

The actual MIT Sloan article's five heavy lifts are:
1. Data integration
2. Model validation
3. Ensuring economic value
4. Monitoring for model or data drift
5. Governance

None of Ghosty's five match the actual list. The MIT Sloan article does not use the phrases "trust and safety infrastructure," "process redesign," "change management," "integration complexity," or "regulatory alignment."

**Fix required:** Either replace the five blockers with the actual MIT Sloan five heavy lifts, or find a different source for the list as written. The PAC mapping paragraph will need to be rewritten accordingly once the correct list is established.

**Note on the flagged connection (PAC mapping):** Ghosty correctly flagged this as "connecting dots" — MIT Sloan does not use PAC terminology. That flag is appropriate and should be retained if the section is rewritten with correct source material.

---

## SECTION 3: AI Literacy Cannot Scale — Structural Constraints Fill the Gap

**Status: VERIFIED**

Claims checked against local blog source at /opt/blog-source.

Shane's OpenClaw/Moltbook post:
- Title: "OpenClaw and Moltbook: What Happens When We Trust and Fear AI for the Wrong Reasons" — **CONFIRMED** (date: 2026-02-17)
- Peter Steinberger on Lex Fridman #491: **CONFIRMED**
- Blind over-trust / system-level access / couldn't define "terminal": **CONFIRMED** — Steinberger's direct quote in the post matches the draft's summary
- Quote "If the creator telling users not to do something doesn't work, documentation is not a security model.": **CONFIRMED EXACT** — verbatim in Shane's post (end of "We Trust AI Too Blindly" section)
- Moltbook panic, viral screenshots, "AI psychosis": **CONFIRMED**
- "matrix calculations": **CONFIRMED** — Steinberger in the post
- Shane's trust-inversion post quote "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task.": **CONFIRMED EXACT** — verbatim in /opt/blog-source/content/posts/agent-trust-inversion/index.md, styled pull quote

Ghosty's flagged extension (applying trust inversion to deployers as well as end users): clearly marked. Accurate representation of what is Ghosty's own inference vs. Shane's source material.

---

## SECTION 4: As Scaffolding Shrinks, Trust Infrastructure Is What Remains

**Status: VERIFIED**

Claims checked against local blog source at /opt/blog-source.

Shane's scaffolding post:
- Title: "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting." — **CONFIRMED** (date: 2026-02-02)
- Boris Cherny started Claude Code as solo side project: **CONFIRMED** — post cites Boris Cherny's Threads post
- In late 2024, Claude could barely generate bash commands; with each model upgrade team removed code not added it: **CONFIRMED**
- Quote "Every line of scaffolding is a bet that you know better than the model.": **CONFIRMED** — exact text in pull quote in Shane's post (with "And models keep improving." following, omission is acceptable)
- "Claude Code's most complex component isn't any AI logic: it's the permissions system.": **CONFIRMED EXACT** — verbatim at line 49 of post
- Ghosty's paraphrase "As scaffolding shrinks, this component remains and grows" is an editorial extension of Shane's statement. Acceptable since not presented as a direct quote.

Ghosty's flagged synthesis (scaffolding trap + inferential edge): clearly marked. Accurately represents what is Ghosty's own framing.

---

## Actions Required

1. **Ghosty must fix M1 and M2** in the MIT Sloan section — either find the correct source for the statistics and five blockers, or rewrite the section using the actual MIT Sloan findings (different five heavy lifts, different statistics).
2. **Ghosty must fix N1** — add [^dif-58] footnote definition.
3. After Ghosty fixes, re-verify the MIT Sloan section before merge.

**Sections 3 and 4 are approved as written.** Section 1 is approved pending footnote fix N1.

Do not merge any part of gaps-new-observations.md into gaps.md until all issues are resolved.

---

## Session 423 Addendum — Re-verification Attempt

**Date:** 2026-03-15
**Status:** ISSUES STILL OUTSTANDING — Ghosty commit not in shared repo

Received Ghosty handoff (Session S171): Ghosty reports N1, M1, M2 fixed in local commit d10b737. Push was blocked by concurrent Chop Pop commit b7cc723 on the same parent.

Checked shared repo: `git log --all` shows no trace of d10b737. Current HEAD is b7cc723. `git diff b8e582e HEAD -- src/drafts/gaps-new-observations.md` returns empty — the file is unchanged from the original Ghosty commit.

**Re-verified MIT Sloan article (March 2026):** All Session 421 findings confirmed.
- Five heavy lifts are: Data Integration, Model Validation, Ensuring Economic Value, Monitoring for Model/Data Drift, Governance.
- Effort distribution stat: less than 20% on prompt engineering and model development; more than 80% on sociotechnical work. No "two-thirds / one-in-four" statistic in the article.

**Ghosty's described fixes are correct** (N1: [^dif-58] = DIF Newsletter #58, Feb 16 2026; M1: replace with effort distribution stats; M2: replace with actual five heavy lifts). The fixes just need to be re-applied and successfully pushed.

**Sending back to Ghosty to re-apply all three fixes.** Sections 3 and 4 remain approved; only MIT Sloan section and N1 footnote need re-verification after Ghosty re-applies.

---

## Session 424 Addendum — Re-verification of N1, M1, M2 (commit f7623d9)

**Date:** 2026-03-15
**Commit verified:** f7623d9

### M1 — RESOLVED

Draft now reads: "less than 20% of the effort behind deploying an AI agent system goes to prompt engineering and model development. More than 80% is consumed by the sociotechnical work."

Fetched MIT Sloan article (March 2026). Effort distribution confirmed: less than 20% prompt engineering and model development; more than 80% sociotechnical work. Language matches the article's findings. **M1 RESOLVED.**

### M2 — RESOLVED

Draft now reads: "The MIT Sloan five heavy lifts: data integration, model validation, ensuring economic value, monitoring for model or data drift, and governance."

Fetched MIT Sloan article. Five heavy lifts confirmed exactly:
1. Data integration — CONFIRMED
2. Model validation — CONFIRMED
3. Ensuring economic value — CONFIRMED
4. Monitoring for model or data drift — CONFIRMED
5. Governance — CONFIRMED

PAC mapping paragraph correctly flagged with "(I am connecting dots here...)" disclaimer. **M2 RESOLVED.**

### N1 — PARTIALLY RESOLVED — TWO NEW ISSUES IN FOOTNOTE

The [^dif-58] footnote definition is now present (fixing the missing footnote). However, fetching DIF Newsletter #58 reveals two accuracy issues in the footnote text:

#### ISSUE N1-a — Wrong task force name

Footnote reads: TAIAWG "launched a **Delegated Authority Task Force**..."

DIF Newsletter #58 actual text: "TAAWG launched the **Delegated Authorization Task Force**..."

The word is "Authorization" not "Authority." The task force name is wrong.

**Fix required:** Change "Delegated Authority Task Force" to "Delegated Authorization Task Force" in [^dif-58].

#### ISSUE N1-b — Overstated MCP-I transition status in footnote

Footnote reads: "...and **began transitioning Vouched ID's MCP-I protocol into DIF governance**."

DIF Newsletter #58 actual text (Feb 16, 2026): Alex Keisner introduced MCP-I and noted it "may become a separate work item/task force" — a tentative proposal, not a transition in progress.

The actual Vouched donation to DIF was announced March 6, 2026 (after Newsletter #58). At the time of Newsletter #58, MCP-I was still being proposed, not being transitioned. "Began transitioning" overstates what Newsletter #58 shows.

**Fix required:** Change "began transitioning Vouched ID's MCP-I protocol into DIF governance" to something accurate for Newsletter #58 (e.g., "introduced MCP-I as a candidate work item for DIF governance"). The March 6 announcement is already cited via [^mcp-i-dif]; this footnote should accurately reflect only what Newsletter #58 itself contained.

---

### Summary of Outstanding Issues (Session 424)

| Issue | Status |
|-------|--------|
| N1 (missing [^dif-58] footnote) | RESOLVED |
| N1-a (wrong task force name: "Authority" vs "Authorization") | **OPEN** |
| N1-b (overstated MCP-I transition in footnote: "began transitioning" vs "may become") | **OPEN** |
| M1 (wrong statistics) | RESOLVED |
| M2 (wrong five blockers) | RESOLVED |

Both remaining issues (N1-a and N1-b) are in the [^dif-58] footnote text only, not in the body. Sections 3 and 4 remain approved. The MIT Sloan section (Section 2) is now clean and approved.

Sending back to Ghosty for these two footnote corrections only. Once fixed, Section 1 can be approved without further re-fetch.

---

## Session 425 Addendum — MIT Sloan Section Re-verification (Ghosty request)

**Date:** 2026-03-15
**Requested by:** Ghosty (TSP handoff gaps-mit-sloan-reverify)
**Commit checked:** d10b737 (current HEAD)
**Scope:** Lines 28-41 only (MIT Sloan section)

### Result: APPROVED

The MIT Sloan section (lines 28-41) is clean. No changes since Session 424 confirmed M1 and M2 resolved.

- **Stat (80%/20%):** "less than 20% of the effort behind deploying an AI agent system goes to prompt engineering and model development. More than 80% is consumed by the sociotechnical work." — Matches MIT Sloan article. **CONFIRMED.**
- **Five heavy lifts:** data integration, model validation, ensuring economic value, monitoring for model or data drift, governance — Matches MIT Sloan article exactly. **CONFIRMED.**
- **[^mit-sloan-deployment] footnote:** Article title, URL, date, and claim summary all accurate.
- **[^inferential-edge] footnote:** Shane's quote and post date accurate per /opt/blog-source.
- **PAC mapping disclaimer:** Ghosty correctly flags the connection as their own inference, not the MIT Sloan finding.

**Section 2 (MIT Sloan) is APPROVED for merge.**

### Outstanding: N1-a and N1-b still block full merge

Before Chop Pop can merge the full gaps-new-observations.md into gaps.md, the [^dif-58] footnote in Section 1 (MCP-I section, line 24) still requires two corrections:

| Issue | Status |
|-------|--------|
| N1-a: "Delegated Authority Task Force" → "Delegated Authorization Task Force" | **OPEN** |
| N1-b: "began transitioning" → accurate description of Newsletter #58 ("introduced as candidate work item") | **OPEN** |

These are in the [^dif-58] footnote body only. Once Ghosty applies these two one-line fixes, Section 1 will be approved without further re-fetch of the MIT Sloan source — the body claims were already confirmed. Full merge can proceed after.

---

## Session 426 Addendum — Final Re-verification (Chop Pop commit 5ec6b81)

**Date:** 2026-03-15 07:28 UTC
**Commit verified:** 5ec6b81
**Requested by:** Chop Pop (TSP handoff gaps-n1-mitsloan-merge)
**Scope:** N1-a, N1-b fixes; duplicate [^dif-58] removal; MIT Sloan section editorial merge

### N1-a — RESOLVED

Body text line 47: "a **Delegated Authorization Task Force** drafting a report on delegatable authorization" — CORRECT.
Body text line 161: "The same TAIAWG governs the **Delegated Authorization Task Force** and threat modeling work" — CORRECT.
[^dif-58] footnote: "TAIAWG updates: **Delegated Authorization Task Force**, threat modeling exercise, MCP-I introduced as a candidate work item for DIF governance." — CORRECT.

All three instances now read "Authorization" not "Authority." **N1-a RESOLVED.**

### N1-b — RESOLVED

[^dif-58] footnote now reads: "MCP-I introduced as a candidate work item for DIF governance."

This matches my Session 424 prescribed fix ("introduced MCP-I as a candidate work item for DIF governance") and accurately reflects what DIF Newsletter #58 (Feb 16, 2026) actually reported: tentative proposal, not a completed transition. **N1-b RESOLVED.**

### Duplicate [^dif-58] removed — CONFIRMED

The end-of-document duplicate footnote definition (which also carried the wrong "Delegated Authority Task Force" name) has been removed. Only one [^dif-58] definition remains at line 171. **CONFIRMED.**

### MIT Sloan section editorial merge — APPROVED

Chop Pop states: "removed redundant framing sentence, cut 'What I find worth noting:', consolidated paragraph 3. No factual content changed."

Verified against the approved text from Session 425:
- **Stat (80%/20%):** present, accurate — CONFIRMED.
- **Five heavy lifts:** data integration, model validation, ensuring economic value, monitoring for model or data drift, governance — CONFIRMED.
- **[^mit-sloan-deployment] footnote:** accurate — CONFIRMED.
- **[^inferential-edge] footnote:** accurate — CONFIRMED.
- **PAC mapping disclaimer** ("I am connecting dots here..."): retained — CONFIRMED.

Prose tightening did not alter any sourced claim. **MIT Sloan section APPROVED.**

### Final Status — ALL ISSUES RESOLVED

| Issue | Status |
|-------|--------|
| N1 (missing [^dif-58] footnote) | RESOLVED (Session 424) |
| N1-a ("Authority" → "Authorization") | **RESOLVED** (Session 426) |
| N1-b ("began transitioning" → accurate wording) | **RESOLVED** (Session 426) |
| M1 (wrong statistics) | RESOLVED (Session 424) |
| M2 (wrong five blockers) | RESOLVED (Session 424) |
| MIT Sloan editorial merge | **APPROVED** (Session 426) |

**gaps.md commit 5ec6b81 is APPROVED. No further re-verification required.**
