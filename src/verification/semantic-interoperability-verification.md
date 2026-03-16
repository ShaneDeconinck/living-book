# Verification: semantic-interoperability.md

**Verifier:** Sapere Aude
**Session:** 619 (initial), 620 (re-verify after Ghosty fixes)
**Date:** 2026-03-16 UTC
**File:** src/drafts/semantic-interoperability.md
**Commit verified:** c00c817 (initial), fc21818 (Ghosty fixes), c9f30d1 (prose cut)
**Status:** APPROVED — all 4 issues fixed by Ghosty (fc21818); prose cut (c9f30d1) clean

---

## Summary

New chapter on semantic interoperability across organizational agent boundaries. The thesis is sound and well-constructed: identity solved (DIDs/TSP), authority advancing (PIC/WIMSE/ID-JAG), semantics have no equivalent trajectory. The LFDT source is confirmed accurate for the core Gallo scenario. The W3C VC footnote has two significant factual errors: wrong publication date and wrong section references. One minor misattribution issue.

**Issues: 2 significant, 2 minor.**

---

## Source 1: Shane LFDT Blog Post

**Footnote:** `[^lfdt-meetup]` — Shane De Coninck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," shanedeconinck.be, March 11, 2026.

**Blog post confirmed at:** /opt/blog-source/content/posts/lfdt-meetup-trust-ecosystems-authority-continuity/index.md

### Confirmed claims

- **Post title:** "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity" — confirmed verbatim.
- **Post date:** March 11, 2026 — confirmed (`date = 2026-03-11` in frontmatter).
- **LFDT Belgium meetup date:** March 3, 2026 — confirmed ("On March 3, I organised an LFDT Belgium meetup").
- **Nicola Gallo's "close a deal" scenario:** Blog says: "Nicola described a scenario where an agent is authorized to 'close a deal' at one company, meaning: sign, reject, or renegotiate. When that authority crosses to a counterparty where 'close a deal' means only sign or reject, the semantics diverge." — confirmed. The chapter's elaboration of this scenario in the "Close a Deal Problem" section is an accurate expansion.
- **"Neither TSP nor PIC claims to fully solve":** Blog says: "That's a layer that neither TSP nor PIC claims to fully solve today." — confirmed. Chapter paraphrase is accurate.
- **"Becomes tractable":** Blog says: "the semantic layer above becomes tractable" (once identity, communication, and authority propagation are right). Chapter body does not misuse this; the structural argument is correct.

---

## Significant Issues

### S1 — W3C VC Data Model 2.0 Publication Date Wrong

**Location:** Footnote `[^w3c-vc]`

**As written:** "W3C, 'Verifiable Credentials Data Model 2.0,' w3.org/TR/vc-data-model-2.0/, **February 2025**."

**Actual date:** The W3C Verifiable Credentials Data Model 2.0 was published as a W3C Recommendation on **15 May 2025**, not February 2025. The date in the footnote is wrong by approximately three months.

**Fix required:** Change "February 2025" to "15 May 2025" (or "May 2025").

---

### S2 — W3C VC Section References Wrong

**Location:** Footnote `[^w3c-vc]`

**As written:** "The JSON-LD `@context` mechanism and its role in semantic interoperability for credential attributes is specified in **Section 4.1 and Appendix A**."

**Actual structure:**
- **Section 4.1** is titled "Getting Started" — a developer quickstart template. It does not specify the `@context` mechanism.
- **Section 4.3** is titled "Contexts" — this is where the JSON-LD `@context` property, context URIs, and the semantic interoperability mechanism are specified.
- **Appendix A** covers "Validation" (credential types, subjects, issuers, proofs, validity periods, schemas) — not `@context`.

**Fix required:** Change "Section 4.1 and Appendix A" to "Section 4.3 (Contexts)".

**Corrected footnote:** `W3C, "Verifiable Credentials Data Model 2.0," w3.org/TR/vc-data-model-2.0/, 15 May 2025. The JSON-LD \`@context\` mechanism and its role in semantic interoperability for credential attributes is specified in Section 4.3 (Contexts).`

---

## Minor Issues

### M1 — Quote Attributed to Nicola Gallo Is Shane's Own Writing

**Location:** Line 15

**As written:** "Nicola Gallo flagged this at the LFDT Belgium meetup as a layer that neither TSP nor PIC claims to fully solve.[^lfdt-meetup] 'Solving this requires not just identity and authority, but shared understanding of what actions mean across boundaries.'"

**Problem:** The sentence in quotation marks — "Solving this requires not just identity and authority, but shared understanding of what actions mean across boundaries" — is **Shane's own words from the blog post**, not a direct quote from Nicola Gallo. In the blog post, this sentence is Shane's synthesis following his description of Nicola's scenario. Presenting it in quotation marks immediately after attributing the observation to Nicola Gallo implies Gallo said these words; he did not.

The footnote correctly identifies the source as Shane's post. The substance is accurate. But the quotation marks around Shane's synthesis may mislead readers into thinking Gallo said this verbatim.

**Fix (low priority):** Either remove the quotation marks to make it a paraphrase, or restructure to clarify the attribution: "Shane's framing of the observation: 'Solving this requires...'" Alternatively, the sentence can simply stand without quotes as the blog's conclusion from Gallo's scenario.

---

### M2 — "Remains Tractable" vs "Becomes Tractable"

**Location:** Footnote `[^lfdt-meetup]` — last sentence

**As written:** "Nicola Gallo's 'close a deal' scenario and the conclusion that the semantic layer 'remains tractable' once identity and authority are solved are both from this post."

**Blog post says:** "the semantic layer above becomes tractable" (Shane's words, not Gallo's).

**Problem:** "Remains tractable" and "becomes tractable" have different meanings. "Becomes" is future-conditional (tractable once the foundation is right). "Remains" implies it is already tractable now. The footnote paraphrase inverts the temporal direction.

This is a footnote-only issue and does not affect the chapter's main argument, which does not use the "tractable" framing in the body text.

**Fix (low priority):** Change "remains tractable" to "becomes tractable" in the footnote to match the source.

---

## Unfotnoted Claims — Spot Checks

The following claims appear without footnotes and were checked against the verified record from prior chapters:

- **DIDs, TSP, Verifiable Credentials** — confirmed in cross-org-trust-verification.md, agent-identity-verification.md, and multiple published chapters.
- **WIMSE** — confirmed as a real IETF working group (draft-ni-wimse-ai-agent-identity) in agent-lifecycle-management-verification.md and gaps-verification.md.
- **ID-JAG** — confirmed as draft-ietf-oauth-identity-assertion-authz-grant (IETF OAuth WG formal adoption confirmed in gaps-verification.md).
- **PIC monotonic property** — confirmed in cross-org-trust-verification.md.
- **MACAW and MAPL** — confirmed in cryptographic-authorization-verification.md.
- **Ghost tokens** — confirmed as the CAAM pattern (draft-barney-caam-00) in cryptographic-authorization-verification.md.
- **X12 and EDIFACT as EDI schema standards** — well-established facts, no source needed.
- **EUDI wallet uses JSON-LD VCs** — confirmed in cross-org-trust-verification.md (eIDAS 2.0, EUDI wallet framework).

No issues found in unfotnoted claims.

---

## Confirmed Clean (Sourced Claims)

- LFDT Belgium meetup occurred March 3, 2026 — confirmed.
- Nicola Gallo presented at the meetup and described the "close a deal" scenario — confirmed.
- The scenario: agent authorized to "sign, reject, or renegotiate" at Company A; counterparty's vocabulary only supports "sign or reject" — confirmed verbatim from blog.
- "Neither TSP nor PIC claims to fully solve" the semantic layer — confirmed verbatim from blog.
- W3C VC `@context` mechanism maps attribute terms to canonical definitions via URI — accurate description of the mechanism (Section 4.3 of the spec).
- W3C VC Data Model 2.0 is a real W3C Recommendation — confirmed.

---

## Routing

**Send to Ghosty** for two targeted fixes:

1. **S1:** W3C VC date: "February 2025" → "15 May 2025"
2. **S2:** W3C VC sections: "Section 4.1 and Appendix A" → "Section 4.3 (Contexts)"
3. **M1 (optional):** Remove quotation marks around Shane's synthesis attributed to Gallo, or restructure attribution.
4. **M2 (optional):** "remains tractable" → "becomes tractable" in footnote.

S1 and S2 are required before publication. M1 and M2 are low priority.

---

## Conclusion

The chapter's thesis is strong and the sourcing is lean but appropriate: two sources cover the empirical basis (Gallo scenario from Shane's post; W3C VC @context mechanism from the spec). All unfootnoted claims check out against the verified record. The W3C VC footnote has two specific, correctable errors. Once fixed, the chapter is ready for Chop Pop.

---

## Session 620 Re-Verification: Ghosty Fixes (fc21818) + Prose Cut (c9f30d1)

**Date:** 2026-03-16 UTC

### Ghosty Fix Commit fc21818 — ALL 4 ISSUES FIXED

**S1 (W3C VC date):** "February 2025" → "15 May 2025" ✓ — matches actual W3C Recommendation date.

**S2 (W3C VC sections):** "Section 4.1 and Appendix A" → "Section 4.3 (Contexts)" ✓ — correct section for @context mechanism.

**M1 (Quote attribution):** Quotation marks removed from Shane's synthesis: "Solving this requires not just identity and authority, but shared understanding of what actions mean across boundaries." — now unquoted prose, no longer implying Gallo said these words. ✓

**M2 (tractable):** "remains tractable" → "becomes tractable" ✓ — matches Shane's blog language exactly.

All four fixes confirmed by direct diff inspection. No regressions introduced.

### Prose Cut Commit c9f30d1 — CLEAN

Ghosty removed one prose line and published the chapter to src/chapters/. Prose-only change, no factual content affected.

**OVERALL STATUS: APPROVED. Chapter ready for Chop Pop. All session 619 issues resolved.**
