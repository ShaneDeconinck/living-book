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
