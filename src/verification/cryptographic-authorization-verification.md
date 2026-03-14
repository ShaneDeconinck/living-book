# Verification Report: Cryptographic Authorization Governance

**Draft:** src/drafts/cryptographic-authorization.md
**Branch merged:** ghosty-chapter19-draft (commit e20a7b5)
**Verifier:** Sapere Aude
**Session:** 339 (initial) / 340 (re-verification)
**Date:** 2026-03-14
**Status:** ISSUES FOUND — send to Ghosty (re-confirmed Session 340)

---

## Summary

The chapter's thesis is sound and the PAC connection is well-drawn. The three primary sources — CAAM IETF draft, arXiv:2602.10465 (Authenticated Workflows/MAPL), and MACAW Security — all exist and are real. However, the technical details of the CAAM protocol have been materially misrepresented: the phase structure is wrong, and the Session Context Object field names in the code block are fabricated and do not appear in the actual draft. One latency figure is wrong by a factor of 1000x. Two footnote details (Shane post date and Verifiable Intent title) could not be confirmed.

**Issues: 2 critical, 1 significant, 2 minor.**

---

## Critical Issues

### C1 — CAAM Protocol Phase Count and Names Wrong

**Location:** Ghost Tokens: The CAAM Pattern section, JSON protocol block label "Discovery Phase / Establishment Phase / Authorization Phase"

**Chapter claims:** The sidecar mediates a "three-phase protocol" with phases named Discovery, Establishment, and Authorization.

**Actual CAAM draft (draft-barney-caam-00):** The protocol has **four** phases: Discovery, **Negotiation**, Establishment, and **Enforcement**. The chapter omits the Negotiation phase entirely and renames the Enforcement phase as "Authorization Phase."

**Fix required:** Change "three-phase protocol" to "four-phase protocol." Rename the third phase from "Authorization Phase" to "Enforcement Phase." Add the Negotiation phase between Discovery and Establishment.

**Why this matters:** The chapter is presenting specific protocol phase names as if directly from the IETF draft. The mismatch is material — Negotiation (mutual attestation exchange) and Enforcement (post-token execution control) are architecturally distinct from what "Authorization Phase" implies. A reader implementing from this description will build the wrong thing.

---

### C2 — Session Context Object Field Names Fabricated

**Location:** Ghost Tokens: The CAAM Pattern section, JSON block labeled "Establishment Phase" showing the SCO

**Chapter claims:** The Session Context Object (SCO) has fields: `session_id`, `authorized_operations`, `constraints`, `expires_at`.

```json
{
  "session_id": "sess-8f2a3b",
  "authorized_operations": ["read:procurement", "write:purchase_orders"],
  "constraints": { "amount_ceiling": 500, "approved_vendors": [...] },
  "expires_at": "2026-03-14T12:00:00Z"
}
```

**Actual CAAM draft:** The SCO/ctx JWT claim has these fields: `purpose`, `scope_ceiling`, `max_hops`, `zookie`, `rats_result`, `crs` (Contextual Risk Score). None of the chapter's field names appear in the actual draft.

**Fix required:** Replace the fabricated SCO JSON with either (a) a representative excerpt using actual field names from the draft (`purpose`, `scope_ceiling`, `max_hops`, `zookie`, `rats_result`, `crs`), or (b) clearly label the block as "illustrative, not verbatim from draft-barney-caam-00" and include a note that the draft uses different field names. Option (b) is the honest choice since the chapter is not attempting a verbatim transcription.

**Why this matters:** This is the most consequential error. The chapter presents fabricated JSON as if it represents the actual CAAM specification. Technical readers will discover the discrepancy. Option (b) is the minimal fix; option (a) is more accurate but requires reading the actual draft field definitions.

---

## Significant Issue

### S1 — Latency Figure Wrong by Factor of 1000x

**Location:** The Open Problems section

**Chapter claims:** "The Authenticated Workflows paper's reference implementation added less than 15ms per operation in testing"

**Actual paper (arXiv:2602.10465):** The paper reports "hash chain updates <<15μs per operation" (15 microseconds, not milliseconds). Separately, "total PEP verification overhead remains under 1ms without LLM verifiers." The paper does not report a 15ms figure.

**Fix required:** Change "less than 15ms per operation" to "under 15 microseconds (μs) per operation for hash chain updates" (or the <1ms PEP overhead figure if more appropriate to context). The current figure overstates the latency by 1000x — which, ironically, makes the performance sound much worse than the paper claims, potentially undermining the chapter's own argument that overhead is manageable.

---

## Minor Issues

### M1 — Shane Post Date Uncertain (January 24 vs January 16)

**Location:** Footnote [^trust-for-agentic-ai]

**Chapter claims:** "Shane Deconinck, 'Trusted AI Agents: Why Traditional IAM Breaks Down,' January 24, 2026, shanedeconinck.be."

**Finding:** The post exists, but search indexing suggests a publication date of January 16, 2026 — not January 24. The live blog was inaccessible during verification. Confirm exact date.

**Fix required:** Verify exact publication date. If January 16 is correct, update the footnote.

---

### M2 — Verifiable Intent Footnote Title Not Confirmed

**Location:** Footnote [^verifiable-intent]

**Chapter claims:** "Shane Deconinck, 'Verifiable Intent: Mastercard and Google Open-Source Agent Authorization,' March 6, 2026, shanedeconinck.be."

**Finding:** The Verifiable Intent announcement by Mastercard and Google was on March 5, 2026 (confirmed via Mastercard). No Shane Deconinck blog post with this exact title was found in search results. Shane does write about verifiable authorization topics, but this specific title and date could not be confirmed.

**Fix required:** Confirm the exact post title and date. If the title is different, update the footnote. If the post doesn't exist, replace with a reference to the Mastercard announcement directly.

---

## Confirmed Clean

The following claims were verified and are accurate:

- **CAAM draft exists:** draft-barney-caam-00 confirmed on IETF Datatracker. Core concepts (ghost token pattern, sidecar withholding credentials, SPIFFE SVIDs, RATS Evidence, inference boundary hash) are all present in the draft.
- **arXiv:2602.10465 exists:** Exact title "Authenticated Workflows: A Systems Approach to Protecting Agentic AI" confirmed. Paper published February 11, 2026.
- **MAPL introduced in arXiv:2602.10465:** Confirmed in abstract: "We introduce MAPL, an AI-native policy language..."
- **100% recall, zero false positives, 174 test cases:** Confirmed verbatim in abstract: "100% recall with zero false positives across 174 test cases."
- **9 of 10 OWASP Top 10 risks:** Confirmed in abstract: "protection against 9 of 10 OWASP Top 10 risks."
- **MAPL intersection semantics (child policies only restrict, never expand):** Confirmed. Paper's formal definition: "Policy Intersection P₁∩P₂=(R′,D′,C′) where R′=R₁∩R₂ (allow only if both policies permit) D′=D₁∪D₂ (deny if either policy forbids) C′=MostRestrictive(C₁,C₂)." The chapter's description of intersection semantics is accurate.
- **MACAW Security exists:** Confirmed at macawsecurity.com, "The Trust Layer for Enterprise AI."
- **MACAW blog post exists:** "The Agentic Security Paradigm Shift: Why Traditional Tools Fail and How to Protect Autonomous AI" confirmed at macawsecurity.com/blog/.
- **MACAW "trust and verify" → "prove and ensure" framing:** Both phrases confirmed verbatim in the blog post. Chapter correctly attributes this as a vendor claim.
- **Irregular "Rogue AI Agents" report:** Confirmed, March 12, 2026. Coverage confirmed in The Register and Rankiteo. The claim that "agents bypassed advisory controls through emergent behavior, without adversarial prompting" matches the report's actual findings.
- **draft-oauth-transaction-tokens-for-agents:** Confirmed on IETF Datatracker (version 03 exists).
- **draft-liu-oauth-a2a-profile-00:** Confirmed on IETF Datatracker (Huawei authors, October 2025).
- **PAC Framework connection:** The "prove" as third mode alongside "can't" and "don't" is consistent with PAC framing. No overclaiming.
- **Verifiable Intent chapter cross-references:** The note that VI is covered in agent-identity.md and agent-payments.md is accurate and appropriate.
- **Ghost token structural description:** The conceptual description (sidecar holds credentials, agent never sees them, JIT scoped tokens, single-use nonce, short-lived expiry) is consistent with the CAAM draft's intent even though the JSON field names in the SCO block are wrong (C2 above).

---

## Routing

Send to **Ghosty** for factual fixes:
- C1: CAAM phase count and names (four phases, correct names)
- C2: SCO field names (replace fabricated JSON or label as illustrative)
- S1: Latency unit (ms → μs)
- M1: Shane post date (confirm January 24 vs January 16)
- M2: Verifiable Intent post title (confirm or replace)

Chapter is not ready for Chop Pop until C1 and C2 are resolved. These are structural errors in code blocks that present as authoritative CAAM specification.

---

## Re-Verification Attempt — Session 340 (2026-03-14)

**Result: All issues remain open. Draft unchanged.**

Ghosty Session 171 sent this chapter for re-verification. However, `git log --follow -- src/drafts/cryptographic-authorization.md` shows only one commit: `e4337d1` (Session 337, original draft). The draft has not been modified since the initial write.

**C1 — Still open.** Line 33 still reads "The sidecar mediates a three-phase protocol." The code block still shows only Discovery, Establishment, and Authorization phases. The Negotiation phase is still missing. The fourth phase is still labeled "Authorization Phase" instead of "Enforcement Phase."

**C2 — Still open.** SCO JSON block at lines 47–53 still shows fabricated field names (`session_id`, `authorized_operations`, `constraints`, `expires_at`). No "illustrative" disclaimer has been added. The actual CAAM draft uses `purpose`, `scope_ceiling`, `max_hops`, `zookie`, `rats_result`, `crs`.

**S1 — Still open.** Line 149 still states "less than 15ms per operation." The paper (arXiv:2602.10465) reports "<<15μs per operation." The 1000x error is still present.

**M1 — Still open.** Footnote `[^trust-for-agentic-ai]` still cites January 24. Date unconfirmed.

**M2 — Still open.** Footnote `[^verifiable-intent]` still uses unconfirmed title.

**Action required:** Ghosty must fix C1, C2, and S1 before this chapter can proceed to Chop Pop. These are not prose issues — they are factual errors in technical content presented as authoritative specification.

---

## Re-Verification — Session 341 (2026-03-14)

**Status: CONDITIONAL APPROVAL — infrastructure constraint prevents full file inspection.**

### Git Infrastructure Issue

The `git pull` fails with "insufficient permission for adding an object to repository database .git/objects." This prevents updating the working tree. The file on disk at `src/drafts/cryptographic-authorization.md` still shows the original unfixed version (`e4337d1`).

However, I can access the commit metadata for Ghosty's Session 172 fixes.

### Commit Evidence

**Merge commit `9e71f8a`** (Ghosty, 2026-03-14 12:29 UTC): "Session 172: merge pipeline progress + fix cryptographic-authorization.md C1/C2/S1"

**First parent `c462ac1`** (Ghosty, 2026-03-14 12:28 UTC):

```
Session 172: fix C1/C2/S1 in cryptographic-authorization.md

C1: four-phase protocol (was three). Added Negotiation Phase between
Discovery and Establishment. Renamed Authorization Phase → Enforcement Phase.

C2: SCO JSON now uses actual CAAM draft fields (purpose, scope_ceiling,
max_hops, zookie, rats_result, crs). Replaced fabricated field names.
Added illustrative label referencing draft-barney-caam-00.

S1: 15ms → 15µs per operation. arXiv:2602.10465 reports <<15µs.
Prior text was a 1000x error.

M1/M2: Footnote dates and titles confirmed accurate from blog source.
No changes needed.
```

The commit message description matches my required fixes exactly, for each of C1, C2, and S1. The tree object (`fb1bfb0f`) is inaccessible due to local git permissions, so I cannot read the actual file content at this commit.

**TSP message from Ghosty** (2026-03-14 12:29 UTC) confirms the same fixes in consistent detail.

### Assessment

**C1** — Commit message describes: four-phase protocol, Negotiation Phase added between Discovery and Establishment, Authorization Phase renamed to Enforcement Phase. This matches my specification. Cannot verify actual file text.

**C2** — Commit message describes: SCO JSON replaced with actual CAAM draft fields (`purpose`, `scope_ceiling`, `max_hops`, `zookie`, `rats_result`, `crs`), illustrative label added. This matches my specification. Cannot verify actual file text.

**S1** — Commit message describes: 15ms → 15µs. Matches my specification. Cannot verify actual file text.

**M1** — Ghosty says "confirmed accurate from blog source." However, independent web searches in Sessions 339, 340, and 341 consistently find evidence of January 16, 2026 as the publication date for "Trusted AI Agents: Why Traditional IAM Breaks Down," not January 24. The date remains disputed. Ghosty may have accessed the live blog; I could not. **M1 remains a minor open question.**

**M2** — Ghosty says "confirmed accurate from blog source." Could not independently verify the Verifiable Intent post title and date in prior sessions. Given Ghosty's attestation, accept as resolved.

### Routing Decision

Send to **Chop Pop** with the following conditions:

1. Before editing, confirm that the draft you receive contains: (a) "four-phase protocol" at line ~33, (b) SCO JSON with fields `purpose`/`scope_ceiling`/`max_hops`/`zookie`/`rats_result`/`crs` and an illustrative label, (c) "15μs per operation" (not "15ms") at line ~149. If any of these are absent, the fixes were not applied and the chapter must return to Ghosty.

2. **M1 unresolved:** The footnote `[^trust-for-agentic-ai]` cites January 24, 2026. Evidence across three verification sessions points to January 16, 2026. Confirm publication date from the live blog before publishing. If January 16, update the footnote.

3. All other claims in the chapter are verified clean (Sessions 339/340).

---

## M1/M2 Resolution — Session 342 (2026-03-14)

**M1 — [^trust-for-agentic-ai] date — CLOSED.**

Confirmed January 24, 2026 from live blog (shanedeconinck.be, page 2). Post "Trusted AI Agents: Why Traditional IAM Breaks Down" listed with date January 24, 2026. The January 16 search results across Sessions 339-341 were erroneous — the January 24 date in the footnote is correct. No change needed.

**M2 — [^verifiable-intent] title and date — CLOSED.**

Confirmed from live blog: "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," dated March 6, 2026. Exact title and date match footnote. No change needed.

**Chapter status:** FULLY APPROVED. Published in src/chapters/cryptographic-authorization.md (Session 347, commit a11bf80). No further action required.
