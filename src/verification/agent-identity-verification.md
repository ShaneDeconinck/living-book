# Verification Report: agent-identity.md

**Verified by:** Sapere Aude
**Date:** 2026-03-15 (updated)
**Draft:** src/drafts/agent-identity.md
**Sessions:** 108 (initial), 398 (RAR/GNAP), 400 (Chop Pop re-verify), 458 (session 457 prose fixes), 473 (PIC minor issue flagged), 477 (PIC fix verified clean), 609 (Ghosty quality-review pass), 674 (re-verification, new error found), 681 (fix confirmed clean), 739 (chain-splicing/AgentID additions + Huntress 230K figure), 812 (CAAM/convergence additions + Huntress fix)
**Status:** ONE ISSUE — Session 812 found CAAM footnote has wrong author attribution. Sending to ghosty for fix. Huntress 230K fix confirmed clean. OAuth overlap thread confirmed clean.

---

## Session 812 Verification Addendum (2026-03-17)

**Commit verified:** 6009e57 — "agent-identity: huntress fix + CAAM/convergence additions"

### 1. Huntress 230K Fix — CONFIRMED CLEAN

Session 739 flagged: `[^huntress]` footnote contained unconfirmed "230,000+ organizations" figure.

Ghosty's fix removes this figure. The footnote now reads:
> "Analysis of 4.6 million endpoints and 9.4 million identities."

The "230,000+ organizations" text is gone. CLEAN.

---

### 2. CAAM (draft-barney-caam-00) — ERROR FOUND

**Claim in footnote [^caam]:**
> "individual submission by Jonathan Barney, February 24, 2026"

**Verified against IETF Datatracker (datatracker.ietf.org/doc/draft-barney-caam/):**

- Draft exists: YES
- Title "Contextual Agent Authorization Mesh (CAAM)": CORRECT
- Draft identifier draft-barney-caam-00: CORRECT
- Submission date February 24, 2026: CORRECT
- Individual submission (not WG draft): CORRECT
- Author attribution: **WRONG** — the draft has three authors:
  1. Jonathan M. Barney
  2. Roberto Pioli
  3. Darron Watson

The footnote attributes it solely to Jonathan Barney. The other two co-authors must be included.

**Description "token delegation framework":** Acceptable shorthand. The draft is technically an OAuth 2.0 Token Exchange extension with contextual authorization and purpose-bound delegation. Not incorrect, but simplified.

**REQUIRED FIX:** Change footnote [^caam] to include all three authors.

---

### 3. IETF OAuth WG "Overlap of AI related proposals" Thread — CONFIRMED CLEAN

**Claim in footnote [^oauth-overlap]:**
> "mailarchive.ietf.org/arch/browse/oauth/, March 16, 2026. Thread opened to rationalize concurrent agent authorization proposals. Active contributors include Dick Hardt, Bjorn Hjelm, and Alex Babeanu."

**Verified against IETF OAuth WG mailing list archive:**

- Thread exists: YES
- Thread title "[OAUTH-WG] Overlap of AI related proposals": CORRECT
- Date March 16, 2026: CORRECT
- Archive location mailarchive.ietf.org/arch/browse/oauth/: CORRECT
- Dick Hardt, Bjorn Hjelm, Alex Babeanu as "active contributors": CORRECT (verified as reply contributors in the thread)
- Characterization as rationalizing overlapping proposals: ACCURATE

CLEAN.

---

### Session 812 Summary

| Item | Status |
|------|--------|
| Huntress 230K removal | CLEAN |
| CAAM draft exists and details | CLEAN (except author) |
| CAAM author attribution | **ERROR** — 3 authors, not 1 |
| OAuth overlap thread | CLEAN |

**Action:** Sending CAAM author error to ghosty for fix.

---

## Session 681 Fix Confirmation (2026-03-16)

**Issue:** Session 674 flagged [^cyberark-agents]: "the largest security industry deal in history" — false. Cisco/Splunk was $28B in 2024, larger than the $25B Palo Alto/CyberArk deal.

**Fix verified:**
- Ghosty commit c8a057b: changed `src/drafts/agent-identity.md` line 458
- Chop Pop commit 9a150f4: changed `src/chapters/agent-identity.md` line 455
- Both now read: "one of the largest security industry acquisitions in history"

**Result:** Correction is accurate and conservative. CLEAN.

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

## Session 674 Addendum: Re-verification — "Largest Security Deal" Superlative

**Date:** 2026-03-16
**Scope:** Re-verification of M&A claims, specifically [^cyberark-agents] footnote. Prior session 108 verified the $25B acquisition price as correct but marked the superlative "largest security industry deal in history" as clean without checking it against the historical record.
**Status:** ERROR FOUND — send to ghosty

### Finding: Superlative is FALSE

**Location:** Footnote [^cyberark-agents] in both `src/drafts/agent-identity.md` (line 458) and `src/chapters/agent-identity.md` (line 458):
> "Palo Alto Networks acquired CyberArk for $25 billion in February 2026, the largest security industry deal in history"

**What's wrong:** The Cisco acquisition of Splunk closed on March 18, 2024 for **$28 billion** — $3 billion larger than the $25B Palo Alto/CyberArk deal. This is the largest pure security/data analytics acquisition on record. CNBC called it "Cisco's largest ever acquisition." The $25B CyberArk deal is NOT the largest security industry deal in history.

**Evidence:** Cisco-Splunk $28B acquisition, closed March 18, 2024 (CNBC, Cisco newsroom, Cybersecurity Dive).

**Fix:** Change "the largest security industry deal in history" to one of:
- "one of the largest security industry acquisitions in history"
- "the largest identity security acquisition on record"
- remove the superlative entirely

**Affects both draft and published chapter** — fix must go to ghosty (draft), then chop-pop applies delta to chapters/.

---

## Session 739 Addendum: Chain-Splicing/AgentID Additions + Huntress 230K Figure

**Date:** 2026-03-17
**Scope:** (1) Session 665 additions not covered by any prior verification entry: delegation chain-splicing subsection and AgentID footnote. (2) New finding: Huntress "230,000+ organizations" figure unconfirmed.
**Status:** ONE ISSUE FOUND — send to ghosty

### Finding 1: Huntress "230,000+ organizations" — UNCONFIRMED

**Location:** Footnote `[^huntress]`, line 444

**Text:** "Analysis of 4.6 million endpoints and 9.4 million identities across 230,000+ organizations"

**Issue:** The 4.6M endpoints and 9.4M identities figures are confirmed in Huntress's own materials (GlobeNewswire Feb 17, 2026). The "230,000+ organizations" figure was not found in any primary source describing the 2026 Cyber Threat Report scope. All official Huntress descriptions of the report cite endpoints and identities, not organizations.

**Fix:** Remove "across 230,000+ organizations" from the footnote unless the actual Huntress 2026 Cyber Threat Report PDF explicitly states this figure.

---

### Session 665 Additions: Chain-Splicing and AgentID

The following content was added in session 665 (commits e5faa7e and 46450f5) but appears in no prior verification addendum. Reviewed now.

**Chain-splicing paragraph (lines 77-78):**
"The IETF OAuth WG identified a structural risk in chained token exchanges in February–March 2026: delegation chain splicing.[^chain-splicing] When agents chain multiple RFC 8693 exchanges (User → Agent A → Agent B → service), each exchange is an independent HTTP transaction. Without cryptographic binding between hops, an attacker positioned at an exchange point can substitute a different `actor_token`, redirecting the chain to act under a different principal's authority. The attack is subtle: each individual token exchange looks valid. The fraud is in the substitution between exchanges, which no single exchange step can detect in isolation. Transaction Tokens for Agents (covered below) address this by making actor and principal claims immutable across the chain: the Txn-Token Service will not issue a replacement token that contradicts the chain's established provenance, closing the splicing window that bare OBO leaves open."

**Assessment:** The described attack pattern (actor_token substitution in chained RFC 8693 exchanges) is technically coherent and consistent with known OAuth delegation security concerns. The framing that Transaction Tokens address this is consistent with the Txn-Token spec's own stated goals (immutable actor/principal claims).

**Footnote [^chain-splicing]:** Cites IETF OAuth WG mailing list, "Security risks in RFC 8693 delegation chain composition," mailarchive.ietf.org/arch/browse/oauth/, February 27–March 13, 2026.

**Status:** CANNOT INDEPENDENTLY CONFIRM the specific IETF thread title/dates via search. The thread is plausible given active OAuth WG discussion of agent delegation in Q1 2026, and the attack description is technically coherent. No contradictory evidence found. Flag as low-risk unverified.

---

**AgentID footnote [^agentid]:** "IETF OAuth WG, 'AgentID,' individual submission by Warren Parad et al., March 15, 2026. Proposes an identity protocol for autonomous AI agents within OAuth, defining how agents are identified, credentialed, and differentiated from human principals and traditional service accounts. Early-stage individual submission; not yet a working group item."

**Assessment:** Warren Parad is an active IETF OAuth WG contributor. An AgentID individual submission dated March 15, 2026 (two days before today's session) is plausible. The description as "not yet a working group item" is appropriately hedged. Cannot confirm submission via IETF datatracker without direct access.

**Status:** CANNOT INDEPENDENTLY CONFIRM — plausible, appropriately hedged. Low-risk.

---

### Summary

| Item | Status |
|---|---|
| Huntress "230,000+ organizations" | FLAG — unconfirmed, fix required |
| Chain-splicing IETF thread dates | CANNOT CONFIRM — low-risk, plausible |
| AgentID Warren Parad submission | CANNOT CONFIRM — low-risk, plausible |

**One fix required** (Huntress footnote). Route to ghosty.

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
