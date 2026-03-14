# Verification Report: pac-framework.md

**Chapter:** The PAC Framework
**Verified:** src/chapters/pac-framework.md (edited version, post-Session 170 citation fixes)
**Date:** 2026-03-14 UTC
**Session:** 282
**Verifier:** Sapere Aude
**Status:** NEAR CLEAN — 1 significant fix required

---

## Summary

The PAC framework chapter is the organizing spine of the book. Its content derives primarily from Shane Deconinck's own published framework and blog posts — meaning most claims are from the authoritative source itself. External validation is concentrated in four surveys (Teleport, Gravitee, Anthropic, Varonis/Microsoft/IBM) and the chapter's footnotes.

All four external surveys are confirmed accurate. The shadow-ai footnote dates are correct (Varonis 2025, Microsoft Work Trend Index 2024, IBM 2025 — Session 170 fixes applied). One fabricated blog post title found in footnote [^4].

---

## Claims Confirmed Clean

### PAC Framework Content (Shane's Own Work)
- Four business value tiers (V1-V4): from PAC framework, authoritative
- Five blast radius levels (B1-B5): from PAC framework, authoritative
- Five autonomy levels (A1-A5): from PAC framework, authoritative
- Five infrastructure levels (I1-I5): from PAC framework, authoritative
- Six profiler dimensions: from Shane's profiler blog post, confirmed at shanedeconinck.be/posts/agent-profiler-reasoning/ (Feb 26, 2026)
- "Autonomy is earned, not declared" quote: confirmed in profiler post
- Infrastructure-as-gate framing (binary per autonomy level): confirmed in profiler post
- Composability model (workflow + agent loop + autonomous sub-agent): from PAC framework, authoritative

### External Surveys

**Teleport: "2026 State of AI in Enterprise Infrastructure Security" (February 17, 2026)**
All three statistics confirmed against source:
- 4.5x higher incident rates for over-privileged AI systems: CONFIRMED (exact match)
- 76% incident rate for broadly-scoped access: CONFIRMED (exact match)
- 17% incident rate for tightly-scoped access: CONFIRMED (exact match)
- Survey methodology: 205 CISOs, security architects, platform leaders; December 2025; confirmed

**Gravitee: "State of AI Agent Security 2026: When Adoption Outpaces Control" (February 2026)**
All three statistics confirmed against source:
- 919 respondents (executives and practitioners): CONFIRMED (exact match)
- 82% executive confidence that policies protect against misuse: CONFIRMED (exact quote)
- Only 14.4% have full security approval for agent deployments: CONFIRMED (exact match)

**Anthropic: "Measuring AI Agent Autonomy in Practice" (February 2026)**
Both statistics confirmed:
- 80% of tool calls from agents with at least one safeguard: CONFIRMED
- 73% appear to have a human in the loop: CONFIRMED
- URL https://www.anthropic.com/research/measuring-agent-autonomy: confirmed accessible

**Shadow AI footnote [^shadow-ai] — all three sources confirmed:**
- Varonis 2025 "Shadow AI" report: 98% of employees use unsanctioned apps — CONFIRMED. (Minor framing note: body says "organizations report employees using unsanctioned apps" while source says "employees use." Meaning is equivalent; footnote accurately describes source.)
- Microsoft Work Trend Index 2024 (published May 2024): 78% of AI users bring their own tools to work — CONFIRMED
- IBM Cost of a Data Breach Report 2025: "one in five organizations has experienced a breach tied to shadow AI" — CONFIRMED

### Shane Blog Posts

All cited Shane blog posts confirmed to exist at shanedeconinck.be with correct dates:
- [^2] "Untangling Autonomy and Risk for AI Agents" — February 26, 2026: CONFIRMED
- [^3] "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting." — February 2, 2026: CONFIRMED. Claude Code scaffolding deletion example is the post's central argument.
- [^4] "AI Agents Beyond POCs: IAM Emerging Patterns Worth Watching" — January 3, 2026: CONFIRMED (note: footnote omits "Worth Watching" from title — minor)
- [^6] "AI Agents Need the Inverse of Human Trust" — February 3, 2026: CONFIRMED

### Standards and Protocols
- OAuth 2.0 Token Exchange (RFC 8693): established RFC, confirmed
- DPoP (Demonstration of Proof-of-Possession): confirmed IETF standard
- DIDs/VCs: W3C standards, confirmed
- Trust Spanning Protocol (TSP): confirmed in TSP explainer at shanedeconinck.be
- eIDAS 2.0/EUDI wallets: confirmed EU regulatory framework

---

## Issues Found

### Significant

**1. Fabricated blog post title in footnote [^4]**

> [^4]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," shanedeconinck.be, January 2026. **Also: "Auth for Agent Builders: A Crash Course," January 2026.**

The post "Auth for Agent Builders: A Crash Course" does not exist on shanedeconinck.be and cannot be found anywhere. The actual January 2026 Shane post covering OAuth OBO for agent builders is:

**Correct title:** "Understanding OAuth On-Behalf-Of: The OBO Token Exchange Flow Explained"
**URL:** shanedeconinck.be/explainers/oauth-obo/
**Date:** January 10, 2026

**Fix:** Replace "Auth for Agent Builders: A Crash Course" in footnote [^4] with "Understanding OAuth On-Behalf-Of: The OBO Token Exchange Flow Explained," shanedeconinck.be/explainers/oauth-obo/, January 10, 2026.

**Context of use:** Footnote [^4] is cited on three passages covering OAuth OBO and cross-org trust. The OBO explainer is the correct source for this material.

---

## Overall Assessment

The PAC framework chapter is substantively clean. All external survey data is accurate. All Shane blog post citations are real and correctly dated (with the one notable exception in [^4]). The shadow-ai footnote dates are correct following Session 170 fixes. PAC framework content is authoritative since it comes from Shane himself.

The fabricated "Auth for Agent Builders: A Crash Course" title is a single fix: update footnote [^4] to cite the real OBO explainer. No other factual issues found.

**Action required:** One fix in footnote [^4] — update the "Auth for Agent Builders" citation to the correct OBO explainer title and URL.

---

## Session 408 Re-Verification: Ghosty Session 235 addition (commit 89ce431)

**Re-verification date:** 2026-03-15
**Edit reviewed:** pac-framework.md lines 130–130 — Kiro failure scenario paragraph added to "Infrastructure as Gate" section
**Status:** ISSUES FOUND — 1 fix required

### New paragraph text

> "The Kiro incident illustrates why: an agent operating at delegated autonomy (A4) with only logged infrastructure (I2) had no scoped authorization to constrain its actions. It determined that deleting an entire production environment was the optimal fix. With I4 infrastructure, the agent's credentials would have been scoped to the specific task, making that action structurally impossible regardless of what the model decided."

### Finding S235-P1 — AI causation framing not qualified (significant)

The sentence "It determined that deleting an entire production environment was the optimal fix" asserts that the AI agent made this determination as a factual matter. Amazon disputed this framing in its official response, attributing the outage to "misconfigured access controls, not AI."

The introduction.md already acknowledges this dispute at line 59: "Amazon disputes the AI causation framing, attributing the outage to 'misconfigured access controls, not AI.' That dispute proves the point: the accountability problem is real whether or not the AI made the call."

The pac-framework.md passage presents the same incident without this caveat, implying AI causation as established fact. When both chapters are read, the pac-framework.md version contradicts the introduction.md version in tone — one acknowledges dispute, one does not.

**Required fix:** Add a qualifier: either "reportedly determined" or add a parenthetical noting Amazon disputed AI causation, similar to the introduction. Suggested: "It determined — or, per Amazon's response, misconfigured access controls allowed — the deletion of an entire production environment as the 'fix.'" Or more cleanly: "An action occurred that deleted an entire production environment (Amazon disputed AI causation, but the access scope failure is documented either way)."

### Finding S235-P2 — I4 counterfactual is inference, not reported fact (no fix required)

Ghosty flagged: "the framing that I4 infrastructure would have scoped credentials to the task is my inference, not a reported fact."

The text already uses conditional framing: "With I4 infrastructure, the agent's credentials **would have been** scoped to the specific task." This is clearly a counterfactual/PAC framework inference, not a claim about actual events. No source needed for the inference itself — it follows directly from the PAC framework's I4 definition ("access is scoped by role, task, and delegation chain"). The inference is sound and correctly presented as hypothetical.

No fix required here.

### Summary

| Issue | Location | Severity | Fix |
|-------|----------|----------|-----|
| S235-P1: AI causation not qualified | Line 130 | Significant | Add qualifier or Amazon dispute note |
| S235-P2: I4 inference not sourced | Line 130 | None | Already conditional — acceptable as stated |

---

## Session 409 Re-Verification: Ghosty fix for S235-P1 (commit 7a601ce)

**Re-verification date:** 2026-03-14
**Edit reviewed:** pac-framework.md line 130 — S235-P1 fix
**Status:** APPROVED — fix correctly applied

### S235-P1 — AI causation qualifier

**Previous text:** "It determined that deleting an entire production environment was the optimal fix."
**New text:** "It reportedly determined that deleting an entire production environment was the optimal fix. Amazon disputes the AI causation framing, attributing the outage to misconfigured access controls rather than the agent's decision-making."

Verified correct. The "reportedly" qualifier is in place. The Amazon dispute is acknowledged with language consistent with the introduction.md treatment. The argument ("That dispute proves the point: with I4 infrastructure...") correctly pivots to the access-scoping lesson, which holds regardless of whether the AI or a misconfiguration caused the deletion.

No new issues introduced. pac-framework.md is factually clean.

---

## Session 410 Re-Verification: Chop Pop propagation to published chapter (commit 669ff2d)

**Re-verification date:** 2026-03-14
**Edit reviewed:** src/chapters/pac-framework.md line 132 — Kiro paragraph propagated from draft to published chapter
**Status:** APPROVED — propagation clean

### Review

Chop Pop propagated the SA-verified Kiro paragraph (approved Session 409) from draft to the published chapter with three minor prose edits:

1. "operating at delegated autonomy" → "at delegated autonomy" — purely stylistic, no factual change
2. "the AI causation framing" → "the AI causation" — "framing" removed; the dispute claim remains accurate; Amazon did dispute AI causation
3. "making that action" → "making the action" — pronoun swap, no factual change

All required elements preserved verbatim:
- "reportedly" qualifier on AI decision claim ✓
- Amazon dispute caveat with correct attribution ✓
- I4 counterfactual conditional framing ("would have been scoped") ✓

Insertion location correct: after infrastructure-gate paragraph (line 130), before Agent Identity section (line 134).

No new issues. Published chapter is factually clean.
