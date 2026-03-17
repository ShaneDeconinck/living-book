# Verification Report: verifiable-intent.md

**Draft:** src/drafts/verifiable-intent.md
**Verifier:** Sapere Aude
**Session:** 860
**Date:** 2026-03-17
**Status:** ISSUE FOUND — 1 minor citation issue in protocol integration section

---

## Summary

The chapter accurately captures the Verifiable Intent architecture from Shane's blog post (March 6, 2026). The three-layer SD-JWT architecture, constraint types, selective disclosure mechanism, lifetime parameters, and stated limitations are all confirmed against the source. One minor issue: the specific protocol role characterizations for AP2, ACP, and UCP go beyond what Shane's blog says, and the footnote attributes them to the blog as primary source. These claims are likely accurate (consistent with external AP2/UCP documentation) but need a better citation.

---

## ISSUE 1 — MINOR: AP2/ACP/UCP protocol role characterizations not in cited source

**Location:** Lines 67, footnote [^vi-mastercard]

**Draft claims:**
> "VI integrates with all three major commerce protocols. AP2 references Verifiable Intent as its cryptographic constraint layer. ACP handles checkout flows through a compatible mandate model. UCP handles product discovery and integrates with AP2 for secure payment handling.[^vi-mastercard]"

**Footnote:** "Shane Deconinck, 'Verifiable Intent: Mastercard and Google Open-Source Agent Authorization,' shanedeconinck.be, March 6, 2026. Primary source for all architectural details, constraint types, selective disclosure mechanism, and **protocol integrations**..."

**What Shane's blog actually says:**

The blog lists the three protocols with backers and status only:

| Protocol | Backed by | Status |
|---|---|---|
| AP2 | Google, Mastercard, AmEx, PayPal | 60+ partners |
| ACP | Stripe, OpenAI | Open standard |
| UCP | Google, Shopify, Walmart, Visa | Announced Jan 2026 |

The blog says VI is "protocol-agnostic, with integration mappings for the three leading agentic commerce protocols." It does not describe the specific functional role of each protocol vis-à-vis VI.

**External verification:** AP2 documentation (ap2-protocol.org) and third-party analysis partially support the characterizations — "AP2 handles payment authorization within either flow," "UCP Translates AP2 Requirements into Reality" — but these come from AP2's own documentation, not from Shane's blog.

**Why this matters:** The specific characterizations (AP2 as VI's "cryptographic constraint layer," ACP as "checkout flows," UCP as "product discovery + AP2 integration") are specific claims that go beyond the cited source. They may be accurate from the VI spec (verifiableintent.dev) or AP2 documentation, but [^vi-mastercard] (Shane's blog) doesn't contain them.

**Fix required:** Either:
- Add the VI spec (verifiableintent.dev) and/or AP2 documentation (ap2-protocol.org) as supplementary citations for this paragraph, or
- Trim the protocol role descriptions to match what Shane's blog says (VI has integration mappings for all three; VI is protocol-agnostic), or
- Fetch the VI spec to verify the characterizations and add a footnote citing the spec directly

The rest of the footnote [^vi-mastercard] remains accurate as-is.

---

## Claims Verified Clean

All verified against Shane's blog post (/opt/blog-source/content/posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved/index.md):

**Backers:** "Mastercard and Google open-sourced VI; backed by IBM, Fiserv, Checkout.com" — Blog: "Google, IBM, Fiserv, Checkout.com, and others are backing it." ✓ (note: search result also found Adyen and Worldpay; blog's characterization accurate as written)

**SD-JWT RFC 9901:** ✓ (blog links to datatracker.ietf.org/doc/rfc9901/)

**Three-layer architecture (L1 identity, L2 intent, L3 action):** ✓ exact match

**L1 lifetime ~1 year:** ✓ (blog table: "~1 year")

**L2 autonomous mode: 24h–30 days:** ✓ (blog table: "24h-30 days (autonomous)")

**L2 immediate mode: ~15 minutes:** ✓ (blog table: "~15 min (immediate)")

**L3 splits into L3a (payment network) and L3b (merchant):** ✓

**Chain stops at L3 — agent cannot sub-delegate:** ✓ ("The chain stops at L3: the agent cannot delegate further.")

**sd_hash mechanism** (L2 hashes full serialized L1; L3a hashes L2 + payment disclosures; L3b hashes L2 + checkout disclosures): ✓

**Eight constraint types** (exact table match): ✓

**Budget/recurrence require network state:** ✓ ("constraint enforcement happens at the network level, not at the agent level")

**Selective disclosure: each party sees only what they need:** ✓

**Stated limitations:**
- L3 is terminal (no sub-delegation): ✓
- Agent compromise mid-execution: ✓
- Trust bootstrapping for agent keys: ✓ ("The `kid` format is left to implementations")
- Liability not defined by VI: ✓

**L2 includes agent's public key (cnf.kid):** ✓ (confirmed in blog's JSON examples)

---

## Fix Summary

| # | Severity | Location | Required Fix |
|---|---|---|---|
| 1 | **Minor** | Lines 67, [^vi-mastercard] | Add VI spec (verifiableintent.dev) or AP2 documentation as citation for AP2/ACP/UCP protocol role descriptions, or trim to match what Shane's blog confirms. |

**After fix:** Chapter is clean and ready for Chop Pop.
