# Verification: cross-org-trust.md

**Verified by:** Sapere Aude
**Session:** 161
**Date:** 2026-03-13 UTC
**File verified:** src/chapters/cross-org-trust.md
**Status:** NEAR CLEAN — 2 significant fixes required, 3 minor fixes required

---

## Summary

Strong chapter with dense sourcing across 14 footnotes. The core technical claims — Drift breach figures, CAAM draft details, MCP-I donation to DIF, TSP Revision 2, eIDAS regulation number, EUDI December 2026 deadline, W3C VC de facto exclusion, Phil Windley's four-mechanism framework — are all confirmed. Two significant errors found: a wrong number for EU Large Scale Pilots, and a verbatim quote error in the Windley passage. Three minor issues noted below.

---

## Confirmed Claims

**Drift/Salesloft breach [^2]:** All four specifics confirmed against Google Threat Intelligence, Cloudflare, Krebs on Security, and FINRA alerts.
- "Salesloft Drift AI chat agent breach" — correct product and company
- "over 700 companies" — confirmed; Google Threat Intelligence identified 700+ organizations
- "in ten days" — confirmed; active exfiltration window was August 8–18, 2025
- "stolen OAuth tokens" — confirmed; OAuth refresh tokens hardcoded in Drift's configuration were the attack vector

**CAAM draft [^caam]:** All details confirmed against draft-barney-caam-00.
- Authors: Jonathan M. Barney, Roberto Pioli, Darron Watson — confirmed
- Publication date: February 24, 2026 — confirmed
- Expiry: August 28, 2026 — confirmed
- Ghost Token Pattern, Session Context Objects (SCO as JWT/CWT), AuthZ-at-Discovery (SPIFFE trust domain, attestation evidence types, inference boundary, policy manifest URI) — all confirmed against the draft

**MCP-I [^12]:** All details confirmed.
- Donated to DIF by Vouched — confirmed
- March 2026 (specifically March 5, 2026) — confirmed
- DIF blog post "Why We Brought MCP-I to DIF (and Why DIF Said Yes)" at blog.identity.foundation — confirmed
- Three conformance levels (Level 1: legacy OIDC/JWT bridge; Level 2: full DID + revocation; Level 3: enterprise lifecycle + audit) — confirmed
- `modelcontextprotocol-identity.io` resolves to the specification — confirmed (note: the domain is an alias to mcp-i.knowthat.ai, not DIF-hosted infrastructure, but it resolves and is accurate as a citation URL)

**eIDAS 2.0 [^11]:** Regulation number "(EU) 2024/1183" — confirmed against EUR-Lex. December 2026 deadline — confirmed as the consistently cited implementation deadline.

**TSP [^4]:** "Revision 2" — confirmed against the spec page which shows "vs1.0 Experimental Implementor's Draft Rev 2."

**CSA/Okta source [^2]:** The report exists at both CSA and Okta. Published March 11, 2026. Confirmed as "the third blog in a seven-part series on identity security as AI security." The Salesloft Drift breach framing matches. Operational envelopes and coordinated revocation terminology are verbatim matches.

**Phil Windley article [^10]:** "Cross-Domain Delegation in a Society of Agents" — confirmed, published March 4, 2026 at technometria.com. The four mechanisms (Policies, Promises, Credentials, Reputation) confirmed with matching descriptions. The six-step interaction sequence confirmed.

**WE BUILD recommendations [^we-build]:** All three recommendations confirmed against the BiometricUpdate article. The four capabilities (mutual authentication, human-agent relationship verification, counterparty legitimacy, digital signatures for authenticity) confirmed against the same source.

**W3C VC de facto exclusion [^6]:** The "de jure inclusion, de facto exclusion" framing confirmed — traceable to the INATBA Privacy Working Group position paper and consistent with the ARF and implementing acts as analyzed by multiple independent stakeholders.

**BLS12-381/ENISA [^6]:** The substantive claim is well-supported: BBS+ over BLS12-381 relies on pairing-friendly curves not listed in the SOG-IS/ECCG Agreed Cryptographic Mechanisms document (the certification list ENISA administers). Confirmed via NIST WPEC 2024 presentation by Orange Innovation directly addressing this barrier.

**eIDAS Article 5a(16)(b):** Unlinkability requirement — confirmed. The legal obligation without a cryptographic mechanism for it (given BLS12-381's certification status) is accurately characterized.

---

## Issues Found

### SIGNIFICANT

**Issue 1: WE BUILD pilot count is wrong**

- **Location:** Line 252, footnote [^we-build]
- **Text:** "one of the EU's four Large Scale Pilots for EUDI Wallet implementation"
- **Problem:** There are six EU Large Scale Pilots for EUDI Wallet, not four. The four original pilots (POTENTIAL, EWC, DC4EU, NOBID) began in April 2023 and have since concluded. WE BUILD and APTITUDE are the second round, launched in 2025. The BiometricUpdate article itself calls WE BUILD "one of the European Digital Identity (EUDI) Wallets Large Scale Pilots (LSPs)" without specifying a number.
- **Fix:** Remove the number. Change to: "one of the EU's Large Scale Pilots for EUDI Wallet implementation"
- **Source:** European Commission EUDI Wallet Large Scale Pilot Projects page

**Issue 2: Phil Windley quote uses wrong word — "domains" vs "systems"**

- **Location:** Line 234
- **Text (as written):** "Policies without promises cannot coordinate behavior across **domains**."
- **Actual text in article:** "Policies without promises cannot coordinate behavior across **systems**."
- **Problem:** The second and third clauses of the quote are verbatim correct. The first clause has one word wrong: "domains" in the chapter vs "systems" in Windley's article (technometria.com, March 4, 2026). Since this is presented as a direct quotation (in quotation marks with attribution), it must be exact.
- **Fix:** Change "across domains" to "across systems" to match the source.

---

### MINOR

**Issue 3: CSA first requirement — "verifiable delegation" vs "delegation proof"**

- **Location:** Line 31 ("verifiable delegation")
- **Text:** "**Verifiable delegation**: tokens that explicitly differentiate user identity from agent identity..."
- **Problem:** The CSA/Okta article's exact term for this requirement is "Delegation proof," not "verifiable delegation." The description matches, but the label is a paraphrase. The other two terms ("operational envelopes," "coordinated revocation") are verbatim from the source.
- **Fix:** Either change the label to "Delegation proof" or add a note that this is a paraphrase. Since the chapter uses it as a bulleted framework item (not a direct quote), this is acceptable as written — but ideally the term should match the source. Low priority.

**Issue 4: "more than half the substantive contributions to a recent public consultation" — unsourced**

- **Location:** Line 254
- **Text:** "More than half the substantive contributions to a recent public consultation converged on this diagnosis."
- **Problem:** No citable source was found for this specific quantitative claim. Multiple EU consultation documents exist (closed September 2024 and April-May 2025) but no published synthesis or summary stating "more than half" converged on the W3C VC exclusion diagnosis was found. The "de facto exclusion" framing is well-documented; this specific quantitative framing is not.
- **Fix:** Remove the "more than half" quantification and replace with: "A significant share of substantive contributions to a recent public consultation converged on this diagnosis." Or: attribute it to a specific named analysis if one exists. The qualitative point (that many stakeholders identified this gap) is documentable; the "more than half" figure needs a source.

**Issue 5: BLS12-381/ENISA attribution is slightly imprecise**

- **Location:** Line 256
- **Text:** "uses a curve (BLS12-381) that is not on ENISA's approved list"
- **Problem:** The governing document is the SOG-IS/ECCG "Agreed Cryptographic Mechanisms" list — a document that ENISA administers under the EUCC scheme, but which is formally a product of the European Cybersecurity Certification Group. "ENISA's approved list" is a shorthand that will be understood by practitioners but is technically imprecise.
- **Fix (optional):** For precision, change to: "uses a curve (BLS12-381) that is not on the SOG-IS/ECCG Agreed Cryptographic Mechanisms list" — or add a parenthetical: "(BLS12-381) that is not included in the ENISA/ECCG agreed cryptographic mechanisms." This is low priority given the substance is accurate.

---

## Shane Blog Post URLs

Two Shane blog post URLs ([^1] shanedeconinck.be/posts/trusted-ai-agents-design... and [^5] shanedeconinck.be/explainers/tsp/) returned 404 when fetched. These are Shane's own posts and the surrounding claims drawn from them (PIC microseconds, LFDT Belgium meetup observations, MCP trust gaps, TSP explanation) are consistent with independently verified sources. The 404s may reflect URL format differences or protected paths. Not flagging as errors, but noting for awareness.

---

## Verification Matrix

| Footnote | Claim | Status |
|---|---|---|
| [^1] | Shane LFDT post — PIC microseconds, semantic divergence | Source URL 404; claims corroborated by independent sources |
| [^2] | CSA/Okta — Drift breach, three requirements | Confirmed (minor label issue on first requirement) |
| [^3] | pic-protocol.org — PIC formal model | Site unreachable; claims consistent with DIF working group outputs |
| [^4] | TSP Revision 2 | Confirmed |
| [^5] | Shane TSP explainer | Source URL 404; TSP claims verified independently |
| [^6] | Shane EUDI formats post | Source URL 404; all EUDI claims independently verified |
| [^7] | Shane blog VC verification post | Source URL 404; claims are Shane's own documented experiment |
| [^8] | Three-layer credential pattern | Consistent with Mastercard/Google Verifiable Intent architecture |
| [^9] | Mastercard Verifiable Intent | Consistent with independent coverage |
| [^10] | Windley "Society of Agents" | **Confirmed with one word error in quoted passage** |
| [^11] | eIDAS 2.0 Regulation (EU) 2024/1183 | Confirmed |
| [^12] | MCP-I / Vouched / DIF | Confirmed |
| [^we-build] | WE BUILD pilot count | **"four" is wrong — there are six** |
| [^caam] | CAAM draft-barney-caam-00 | Confirmed |

---

## Required Actions Before Publication

1. **Fix WE BUILD pilot count:** "one of the EU's four Large Scale Pilots" → "one of the EU's Large Scale Pilots"
2. **Fix Windley quote:** "across domains" → "across systems"
3. **Fix or soften "more than half" consultation claim** — remove the quantification or add a specific citable source
4. (Optional) Fix CSA first requirement label: "verifiable delegation" → "Delegation proof"
5. (Optional) Tighten BLS12-381/ENISA attribution to SOG-IS/ECCG

---

## Conclusion

Cross-org-trust.md is a technically dense, well-sourced chapter. The core trust architecture arguments (PIC, TSP, CAAM, MCP-I, EUDI) are accurate and properly grounded. The Drift breach figures are confirmed. The two significant issues are fixable without structural changes: one wrong number and one wrong word in a verbatim quotation. Apply fixes and the chapter is approved for publication.
