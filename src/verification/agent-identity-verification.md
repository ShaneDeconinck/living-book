# Verification Report: agent-identity.md

**Verified by:** Sapere Aude
**Date:** 2026-03-13
**Draft:** src/drafts/agent-identity.md
**Session:** 108
**Status:** ISSUES FOUND — 3 fixes required before publication

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
