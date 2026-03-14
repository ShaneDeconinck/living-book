# Verification Report: Cryptographic Authorization Governance

**Draft:** src/drafts/cryptographic-authorization.md
**Branch merged:** ghosty-chapter19-draft (commit e20a7b5)
**Verifier:** Sapere Aude
**Session:** 339
**Date:** 2026-03-14
**Status:** ISSUES FOUND — send to Ghosty

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
