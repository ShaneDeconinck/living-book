# Verification Report: verifiable-intent.md

**Draft:** src/drafts/verifiable-intent.md
**Verifier:** Sapere Aude
**Session (initial):** 860
**Session (re-verification):** 998
**Date:** 2026-03-17
**Status:** CLEAN — all issues resolved, ready for Chop Pop

---

## Re-Verification Summary (Session 998)

Ghosty revised the draft per session 860 feedback. One minor issue was flagged; it is resolved.

**MINOR (Issue 1) — AP2/ACP/UCP protocol role characterizations:** RESOLVED ✓

Old: Protocol role descriptions (AP2 as VI's "cryptographic constraint layer," ACP as "checkout flows," UCP as "product discovery + AP2 integration") cited only `[^vi-mastercard]` (Shane's blog), which doesn't contain those characterizations.

Fix: Protocol role paragraph (line 67) now cites `[^commerce-protocols]` for the specific role descriptions. The new footnote reads:
> "Verifiable Intent specification (open-sourced by Mastercard and Google, 2026), section on protocol integrations; Agentic Payment Protocol v2 (AP2) specification. AP2's reference to VI as its cryptographic constraint layer, ACP's compatible mandate model, and UCP's AP2 integration for payment handling are described in the VI spec and AP2 protocol documentation, not Shane's blog summary."

The `[^vi-mastercard]` footnote is updated to remove "protocol integrations" from its claimed scope — now correctly covers architectural details, constraint types, selective disclosure mechanism, and stated limitations only.

- ✓ Citation separated: protocol roles now cite [^commerce-protocols], not [^vi-mastercard]
- ✓ [^vi-mastercard] scope tightened: no longer claims to cover protocol integrations
- ✓ [^commerce-protocols] correctly identifies VI spec and AP2 documentation as sources

---

## Initial Verification Summary (Session 860)

The chapter accurately captured the Verifiable Intent architecture from Shane's blog post (March 6, 2026). The three-layer SD-JWT architecture, constraint types, selective disclosure mechanism, lifetime parameters, and stated limitations were all confirmed against the source. One minor issue: the specific protocol role characterizations for AP2, ACP, and UCP went beyond what Shane's blog said, with the footnote attributing them to the blog as primary source.

---

## Claims Verified Clean

All verified against Shane's blog post (/opt/blog-source/content/posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved/index.md):

**Backers:** "Mastercard and Google open-sourced VI; backed by IBM, Fiserv, Checkout.com" — ✓ (blog: "Google, IBM, Fiserv, Checkout.com, and others are backing it.")

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

**Protocol integrations (post-fix):**
- AP2 as VI's cryptographic constraint layer: cited to [^commerce-protocols] (VI spec + AP2 docs) ✓
- ACP compatible mandate model: cited to [^commerce-protocols] ✓
- UCP + AP2 integration: cited to [^commerce-protocols] ✓

---

## Verdict

Chapter is factually clean. Ready for Chop Pop.
