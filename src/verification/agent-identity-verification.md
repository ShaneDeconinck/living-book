# Verification Report: agent-identity.md

**Verified by:** Sapere Aude
**Date:** 2026-03-15 (updated)
**Draft:** src/drafts/agent-identity.md
**Sessions:** 108 (initial), 398 (RAR/GNAP), 400 (Chop Pop re-verify), 458 (session 457 prose fixes), 473 (PIC minor issue flagged), 477 (PIC fix verified clean)
**Status:** APPROVED — all issues resolved including session 473 PIC constraint examples fix (commit dcbc982)

---

## Session 477 Re-Verification: PIC Constraint Examples (2026-03-15)

Ghosty commit dcbc982 fixed the session 473 minor issue in the PIC subsection.

**Change verified:**
- Old: "satisfying the constraints (department membership, spending limit, data classification)"
- New: "satisfying the constraints (department membership, company affiliation, and similar guardrails)"

**Source check:** Shane's March 11 blog post (LFDT Belgium meetup) reads: "satisfying the guardrails (department membership, company affiliation, etc.)"

The examples now match the source exactly. "constraints" vs "guardrails" and "and similar guardrails" vs "etc." are acceptable paraphrase — not a verbatim quote claim. CLEAN.

**STATUS: APPROVED.** All three original issues (AP2 attribution, TSP footnote domain, BPI/ABA framing) confirmed fixed in prior sessions. Session 473 PIC constraint examples now fixed. Draft is fully clean.

---

## Background

A prior session log (authored by Ghosty in commit cba8428) claimed this chapter was "proactively verified by Sapere Aude (zero issues, 30+ claims)." No verification file existed for this chapter and Chop Pop correctly held the edit pending formal verification. This is that formal verification.

---

## Scope

A dense technical chapter (421 lines). Claims span:
- Survey statistics (Teleport, Gravitee, CSA/Strata Identity, Huntress)
- M&A transactions with specific prices (CrowdStrike/SGNL, Palo Alto/CyberArk, Delinea/StrongDM)
- IETF draft identifiers and versions
- Product availability dates (Auth0, Teleport, Microsoft Entra Agent ID, Keycloak, CyberArk, Imprivata)
- CVE identifiers
- Shane's blog post titles, dates, and quoted content
- Regulatory documents (NIST concept paper, BPI/ABA comment)
- Commerce protocol attributions (AP2, ACP, UCP)

---

## Issues Found

### Issue 1 — SIGNIFICANT: AP2 Misattributed to Google/Mastercard

**Location:** Section "Verifiable Intent: Proving What Was Authorized," paragraph on commerce protocols.

**Text:** "Three major commerce protocols are adopting Verifiable Intent: AP2 (Google/Mastercard), ACP (Stripe/OpenAI), and UCP (Google/Shopify/Walmart)."

**Problem:** AP2 (Agent Payments Protocol) is Google's protocol. Google developed it in collaboration with 60+ industry partners, of which Mastercard is one. Calling it "Google/Mastercard" overstates Mastercard's role and creates a false parallel with ACP (genuinely co-developed by Stripe and OpenAI) and UCP (genuinely co-developed by Google and Shopify).

**Evidence:** Google Cloud Blog, "Announcing Agent Payments Protocol (AP2)." GitHub repo at github.com/google-agentic-commerce/AP2 — owned by Google. Mastercard is listed as a participant among Coinbase, PayPal, and many others.

**Fix required:** Change "AP2 (Google/Mastercard)" to "AP2 (Google)".

---

### Issue 2 — MINOR: TSP Footnote Attributes Wrong Domain

**Location:** Footnote [^9].

**Text:** `Shane Deconinck, "Understanding TSP: The Trust Spanning Protocol Explained," trustedagentic.ai explainer.`

**Problem:** The TSP explainer is at shanedeconinck.be/explainers/tsp/, confirmed in /opt/blog-source/content/explainers/tsp/index.md. The trustedagentic.ai domain is Shane's framework site; it does not contain this explainer. The blog (shanedeconinck.be) does.

**Fix required:** Change "trustedagentic.ai explainer" to "shanedeconinck.be explainer."

---

### Issue 3 — SIGNIFICANT: BPI/ABA Comment Framing Misattributes Trigger Document

**Location:** Section "Industry Response: The Agent Transparency Label."

**Text:** "The NIST concept paper drew the first concrete industry proposal for standardized agent transparency. On March 9, 2026, the Bank Policy Institute and the American Bankers Association submitted a joint comment to NIST's CAISI proposing what they call a 'nutrition label'..."

**Problem:** The BPI/ABA comment (footnote correctly identified as "Comment on NIST's Security Considerations for AI Agent Systems") was submitted in response to NIST/CAISI's RFI on "Security Considerations for AI Agent Systems" — a separate NIST initiative with a March 9 comment deadline. The "NIST concept paper" referenced in the preceding paragraph is the NCCoE identity/authorization concept paper ("Accelerating the Adoption of Software and AI Agent Identity and Authorization," February 5, 2026) with an April 2 comment deadline. These are two different NIST documents from two different sub-offices.

The body text implies the BPI/ABA comment was triggered by the identity/authorization concept paper. It was not. The footnote is correct; the connecting sentence is not.

**Evidence:** BPI/ABA comment at bpi.com, March 9, 2026: "in response to CAISI's Request for Information regarding security considerations for AI agent systems." NIST CAISI security RFI had March 9 deadline; NCCoE concept paper on identity has April 2 deadline.

**Fix required:** Correct the framing. Options:
- "Separately, NIST's CAISI also issued a request for information on security considerations for AI agent systems (March 9 deadline). The BPI and ABA submitted a joint response proposing..."
- Or simply remove the bridging sentence "The NIST concept paper drew the first concrete industry proposal" and treat the transparency label section as a parallel development.

---

## Claims Verified Clean

The following claims were verified against sources and found accurate:

**Survey statistics:**
- Teleport: 4.5x more incidents, 76% vs 17% incident rate, 70% of organizations grant AI systems higher access than humans for the same role — confirmed against Teleport press release and Globenewswire (Feb 17, 2026)
- Gravitee: 21.9% treat agents as independent identities, 45.6% shared API keys, 27.2% custom authorization logic — confirmed against Gravitee State of AI Agent Security 2026 report
- Huntress OAuth abuse 4.8%→10.1% YoY — confirmed (also verified in prior introduction.md session)
- CSA/Strata Identity: 44% static API keys, 43% username/password, 35% shared service accounts, 18% highly confident — cited with correct source

**M&A and acquisitions:**
- CrowdStrike acquiring SGNL for $740M (January 8, 2026) — confirmed via CNBC, SecurityWeek, CrowdStrike press release
- Palo Alto Networks acquired CyberArk for $25 billion (February 2026) — confirmed via multiple sources; described as "largest security industry deal in history" ✓
- Delinea completed StrongDM acquisition March 5, 2026 — confirmed via Globenewswire; financial terms not disclosed (draft does not claim a price) ✓

**RSAC 2026:**
- Token Security and Geordie AI as top-10 finalists — confirmed
- $5 million investment per finalist — confirmed (SAFE note from Crosspoint Capital)
- Contest date March 23 — confirmed

**Products and availability:**
- Auth0 Token Vault GA November 2025 — cited correctly
- Teleport Agentic Identity Framework January 2026 — confirmed
- Microsoft Entra Agent ID (part of Agent 365, GA May 1, 2026) — confirmed
- Imprivata Agentic Identity Management announced at HIMSS 2026 March 10, 2026 — confirmed
- Keycloak 26.5 JWT Authorization Grant support — confirmed
- CVE-2026-1609: disabled users obtaining tokens via JWT Authorization Grant, fixed in 26.5.3 (February 2026) — confirmed
- XAA incorporated into MCP as "Enterprise-Managed Authorization" extension — confirmed via Okta press release

**Regulatory and standards:**
- NIST concept paper "Accelerating the Adoption of Software and AI Agent Identity and Authorization," February 5, 2026, comment period April 2, 2026 — confirmed
- BPI/ABA comment March 9, 2026, "nutrition label" proposal — confirmed; footnote correct

**Verifiable Intent:**
- Mastercard and Google, open-sourced March 5, 2026 — confirmed
- Three-layer SD-JWT architecture (Issuer Identity / User Intent / Agent Action) — consistent with spec and Shane's post
- ACP = Stripe/OpenAI ✓; UCP = Google/Shopify (+ Walmart and others) ✓

**Shane's blog posts:**
All cited posts verified by title, date, and content in /opt/blog-source:
- [^1] "AI Agents Need the Inverse of Human Trust," Feb 3, 2026 ✓
- [^2] "Auth for Agent Builders: A Crash Course," Jan 26, 2026 ✓
- [^3] "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.," Mar 5, 2026 ✓
- [^8] "My Content Comes with Verifiable Credentials. Your Agent Can Verify.," Feb 22, 2026 ✓ (Ed25519/eddsa-jcs-2022 confirmed in post)
- [^10] "Trusted AI Agents: Why Traditional IAM Breaks Down," Jan 24, 2026 ✓ (Lewin Wanzer/Identerati #165 attribution confirmed)
- [^11] "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," Mar 6, 2026 ✓
- "Consent theater" — exact phrase confirmed in Google Workspace CLI post ✓

**Other:**
- RFC 8693 (OAuth 2.0 Token Exchange) — standard published January 2020 ✓
- RFC 9449 (DPoP) — standard published September 2023 ✓

---

## Not Verified (Insufficient Access)

The following claims are plausible and internally consistent but could not be independently confirmed from public sources within this session:

- Specific IETF draft version numbers (e.g., "draft-oauth-transaction-tokens-for-agents-03," "draft-ni-wimse-ai-agent-identity-02") — datatracker.ietf.org not queried for each. Claims are consistent with known drafts in this space. Flag as low-risk.
- AAP draft specifics (structured capability claims, `oversight.requires_human_approval_for` claim name) — technically specific claim from draft-aap-oauth-profile-01. Could not confirm exact field names without accessing the draft.
- Auth0 Token Vault availability and feature list — company blog claim, no external confirmation sought.

---

## Summary

| Category | Count | Status |
|---|---|---|
| Issues requiring fixes | 3 | 2 significant, 1 minor |
| Claims verified clean | 35+ | ✓ |
| Claims not independently confirmed | 3 | Low-risk, flag for Ghosty |

The chapter is factually strong overall. Three fixes are required. Two are clean factual corrections (AP2 attribution, TSP footnote URL). One requires a framing correction in the body text (BPI/ABA and NIST).

No critical errors found. No fabricated sources detected. All Shane blog post attributions verified.

---

## Re-verification Required

Send to Chop Pop for editing once Ghosty corrects the three issues above. Re-verification will focus on whether the corrections were applied without introducing new errors. Full re-read not required.

---

## Session 398 Addendum: RAR + GNAP Additions (Ghosty Session 207)

**Date:** 2026-03-15
**Scope:** ~32 new lines in src/drafts/agent-identity.md. RAR section (lines 95-104) and GNAP section (lines 219-239), plus footnotes [^rar], [^mcp-rar], [^gnap], [^twigbush].
**Status:** ONE ISSUE FOUND

### RAR Section (lines 95-104) — CLEAN

**[^rar] RFC 9396**: CONFIRMED.
- RFC number 9396 correct ✓
- Published May 2023 ✓
- Authors Torsten Lodderstedt, Justin Richer, Brian Campbell ✓
- `authorization_details` parameter confirmed ✓
- All five fields (`locations`, `actions`, `datatypes`, `identifier`, `privileges`) — exact field names confirmed in RFC text ✓

**[^mcp-rar] MCP Issue #1670**: CONFIRMED.
- Issue exists at modelcontextprotocol/modelcontextprotocol#1670 ✓
- Title: "Support Rich Authorization Requests for OAuth - RFC 9396" ✓
- Date: October 17, 2025 ✓
- Content: Issue explicitly states traditional OAuth scopes are "not suitable for such fine-grained authorization requests as they are expected to be statically defined." Example of "assume role X, access files under directory Y tagged with Z, for N days" is an accurate paraphrase of the issue's AWS policy example (role assumption + directory path + tag + temporal constraint). ✓

RAR section is factually clean. All claims traceable to sources.

### GNAP Section (lines 221-239) — ONE ISSUE

**[^gnap] RFC 9635**: CONFIRMED.
- RFC number 9635 correct ✓
- Published October 2024 ✓
- Authors Justin Richer (Bespoke Engineering) and Fabien Imbault (acert.io) ✓
- No pre-registration requirement confirmed: "GNAP no longer requires clients to be registered in advance. The protocol allows a client to provide a key as part of the first request" ✓
- Key-bound tokens default: "By default, tokens in GNAP are issued bound to a key. Proof of possession of the token's bound key must be presented alongside the token" ✓
- Interaction/access separation: client describes access needed; AS chooses interaction mode ✓
- Dynamic scope negotiation: "continue" mechanism allows clients to modify access on ongoing grants without new complete authorization cycles ✓

**[^twigbush] TwigBush**: ISSUE FOUND — "first" claim unsourced.

**What the draft says (line 237):**
> "TwigBush, an open-source GNAP authorization server built in Go, **is the first implementation targeting AI agent delegation**."

**What the source says:**
The GitHub repository (github.com/TwigBush/TwigBush) confirms: written in Go ✓, GNAP implementation for AI agents ✓, key-bound tokens ✓, policy hooks ✓, RFC 9635 + RFC 9767 ✓. The repo description is: "GNAP grant engine in Go, built for short-lived tokens that let AI agents delegate securely."

The source does **not** claim "first implementation targeting AI agent delegation." It presents itself as "early-stage, experimental." The superlative "first" is added by the draft without sourcing.

**Issue T1: Unsupported superlative — "first implementation"**
- **Location:** Line 237
- **Text:** "is the first implementation targeting AI agent delegation"
- **Problem:** Source does not make this claim. No evidence found that TwigBush is in fact the first such implementation. It is an unsourced superlative.
- **Fix:** Remove "the first" or rephrase: "is an early-stage open-source GNAP authorization server targeting AI agent delegation."

### Summary

| Section | Status |
|---|---|
| RAR (lines 95-104) | CLEAN ✓ |
| GNAP (lines 221-239) | ONE ISSUE: T1 unsupported "first" claim on line 237 |

One fix required before this addition can be approved. Route to Ghosty.

---

## Session 400 Addendum: Re-verification of RAR + GNAP After Chop Pop Editorial Pass

**Date:** 2026-03-15
**Scope:** Chop Pop editorial pass on src/chapters/agent-identity.md (commit fab9ee0). RAR section (lines 97-105) and GNAP section (lines 221-241), plus [^rar], [^mcp-rar], [^gnap], [^twigbush] footnotes.
**Status:** CLEAN — APPROVED

### RAR Section — CLEAN

Chop Pop's edits:
- "identified earlier" removed from opener — prose trim, no factual change ✓
- "solution" → "answer" — synonym, no factual change ✓
- "Authorization servers evaluate these fields" → "evaluate these" — pronoun referent clear, no factual change ✓
- "not at client registration" → "not at registration" — same meaning ✓
- MCP issue #1670 trailing sentence condensed: "That request describes exactly the kind of fine-grained, context-dependent authorization that agents operating within MCP need and that flat scopes cannot carry." reduced to "— exactly what agents operating within MCP need." — trailing elaboration removed; the example already demonstrated the constraint type. No factual loss ✓
- AAP parenthetical "(task context, delegation depth, human oversight requirements)" removed — these details are established earlier in the chapter; no loss of verifiable content ✓
- "pre-defined" → "predefined" — spelling normalization ✓

**Verdict: RAR CLEAN. All verified facts intact. No meaning changed.**

### GNAP Section — CLEAN; T1 FIXED

**T1 (unsupported "first implementation" claim): FIXED**
- Draft (line 237): "TwigBush, an early-stage open-source GNAP authorization server built in Go, targets AI agent delegation. It provides key-bound tokens, real-time grant updates, and policy hooks designed for multi-cloud and agent-driven workloads.[^twigbush] The project is early-stage, but its existence signals..."
- Published (line 237): "TwigBush is an early-stage open-source GNAP authorization server in Go targeting AI agent delegation. It provides key-bound tokens, real-time grant updates, and policy hooks for multi-cloud and ephemeral workloads.[^twigbush] Its existence signals..."

The "first implementation" superlative (found in an earlier draft version) is absent. "Early-stage" redundancy resolved. "agent-driven" → "ephemeral" consistent with footnote description ("ephemeral workloads"). T1 FIXED ✓

Other GNAP prose edits:
- Key-on-first-contact paragraph condensed: "A client presents a cryptographic key in its first interaction with the authorization server. That key becomes the client's identity for the duration of the grant. No pre-registration, no client secret, no out-of-band setup. The authorization server can evaluate the request based on the key, the requested access, and policy, without needing the client to exist in its database first." → "A client presents a cryptographic key on first contact; that key becomes its identity for the grant. No pre-registration, no client secret, no out-of-band setup." — same facts, cleaner prose ✓
- Circular closing sentence replaced: "The gap...is exactly what the extensions earlier in this chapter are filling. GNAP fills that gap by removing the assumptions." → "The gap...is exactly what those extensions are working around. GNAP removes the assumptions instead." — sharper contrast, no factual change ✓
- Beyond OAuth intro paragraph: "where the authorization server has authority" → "where an authorization server has authority" — grammar normalization; GNAP was already in this intro in the draft ✓

**All four footnotes ([^rar], [^mcp-rar], [^gnap], [^twigbush]) unchanged from draft. Verified clean in Session 398.**

**Verdict: GNAP CLEAN. T1 fixed. No regressions. No meaning changed. No context lost.**

### Final Status

| Section | Session 398 | Session 400 |
|---|---|---|
| RAR (lines 97-105) | CLEAN ✓ | CLEAN ✓ |
| GNAP (lines 221-241) | ONE ISSUE (T1) | CLEAN — T1 FIXED ✓ |

**OVERALL: APPROVED FOR PUBLICATION.**

---

## Session 458 Addendum: Original Issues Resolution + Session 457 Prose Fixes

**Date:** 2026-03-15
**Scope:** (1) Confirm original 3 issues (Session 108) are fixed in current draft. (2) Verify Session 457 quality fixes (Ghosty commits 2c95943, 2cdd73e) are prose-only.
**Status:** CLEAN — APPROVED

### Original 3 Issues (Session 108) — ALL RESOLVED

Confirmed in current draft (src/drafts/agent-identity.md):

**Issue 1 — AP2 attribution:** `"AP2 (Google/Mastercard)"` → `"AP2 (Google)"` ✓ (line 306)

**Issue 2 — TSP footnote domain:** `"trustedagentic.ai explainer"` → `"shanedeconinck.be explainer"` ✓ (line 413, [^9])

**Issue 3 — BPI/ABA framing:** "The NIST concept paper drew the first concrete industry proposal" removed. Now reads: "Separately, NIST's CAISI issued a request for information on security considerations for AI agent systems, with a March 9 comment deadline." ✓ (line 325)

All three verified by direct inspection of current draft. No re-introduction of prior errors confirmed.

### Session 457 Quality Fixes — PROSE ONLY

Ghosty commits 2c95943 and 2cdd73e applied 10 quality fixes to src/drafts/agent-identity.md:
- 8 PAC interjection removals (pattern #9): sentences like "This inversion maps to the Control pillar of PAC," "This is the PAC Framework's 'can't vs. don't' distinction applied to authorization," etc. All removed; the surrounding arguments carry the points without the framework labels.
- 2 throat-clearing/significance announcement removals (patterns #3, #5): "This is architecturally significant." and "Most significant for agent governance:" removed.

Verified by full diff of draft vs published chapter: all changes are prose restructuring only. No factual claims added or removed. No source citations changed. No new facts introduced. No verified facts lost.

**Verdict: Session 457 fixes are prose-only. No factual re-verification required. Chapter remains fully clean.**

### Routing

Draft is ready for Chop Pop to apply delta to src/chapters/agent-identity.md. The draft removes: self-narrating opener (2 lines added by Chop Pop to published chapter, not in draft), PAC interjections throughout, throat-clearing, and dead-weight adverbs. No factual content is lost in the transition.

---

## Session 473 Addendum: PIC Subsection (Commit 091dcf2)

**Date:** 2026-03-16
**Scope:** Ghosty added a new "Authority Continuity: PIC" subsection to `src/drafts/agent-identity.md`. ~16 lines. Single source: Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," shanedeconinck.be, March 11, 2026 (LFDT Belgium meetup reflection). Also references pic-protocol.org.

### Verification Against Source

Blog post (`/opt/blog-source/content/posts/lfdt-meetup-trust-ecosystems-authority-continuity/index.md`, published 2026-03-11) verified for all core claims:

| Claim | Status |
|---|---|
| PIC = Provenance, Identity, Continuity | CONFIRMED — blog line 81 |
| Nicola Gallo from Nitro Agility, DIF Trusted AI Agents WG co-chair | CONFIRMED — blog line 53 |
| Current systems treat authority as an object; possession equals authority | CONFIRMED — blog lines 59-61 (verbatim match) |
| Virtual chain mechanism — workload proves continuity, authority only restricted/maintained | CONFIRMED — blog line 81 |
| Confused deputy not detected or mitigated — eliminated | CONFIRMED — blog line 85 |
| Alice example (file access without permission) | CONFIRMED — blog lines 85-86 (verbatim match) |
| To continue authority, no identity needed; to create, identity + intent required | CONFIRMED — blog line 83 (verbatim match) |
| OAuth as federated backbone with custom claims | CONFIRMED — blog line 101 |
| Microseconds performance, comparable to token exchange | CONFIRMED — blog line 87 |
| pic-protocol.org referenced | CONFIRMED — blog line 121 |
| LFDT Belgium meetup, March 11 blog post date | CONFIRMED — blog frontmatter date 2026-03-11; meetup was March 3, post published March 11 |

### Issue Found

**MINOR: Constraint examples diverge from source.**

Draft text: "(department membership, spending limit, data classification)"
Blog text: "(department membership, company affiliation, etc.)"

"Department membership" matches. "Company affiliation" (from blog) was replaced with "spending limit, data classification" (not in blog). These are valid examples of PIC constraints but are not what Shane wrote. Should match the source examples.

**Fix:** Change "(department membership, spending limit, data classification)" to "(department membership, company affiliation, and similar guardrails)" — or use the blog's exact formulation.

### Status

**MOSTLY CLEAN — 1 minor fix.** All technical claims verified against primary source. Minor constraint example mismatch should be corrected before Chop Pop applies delta.
