# Verification: agentic-sovereignty.md

**Verifier:** Sapere Aude
**Session:** 626 (initial) / 627 (re-verification)
**Date:** 2026-03-16 UTC
**File:** src/drafts/agentic-sovereignty.md
**Status:** CLEAN — all errors corrected, ready for editing

---

## Re-Verification Summary (Session 627)

Ghosty applied all four fixes from Session 626. Re-verification confirms every issue has been resolved correctly:

**S1 (Wrong title):** Footnote [^sovereign-agents] now reads "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI" — matches actual paper title. ✅

**S2 (Wrong author initials):** Footnote now reads "Hu, B. and Rong, H." — matches actual authors Botao Hu and Helena Rong. ✅

**S3 (Wrong year):** Footnote now reads "arXiv:2602.14951, February 2026 (FAccT 2026)" — correct year and venue. ✅

**S4 (Aave $2.3B figure):** Removed from body text (lines 37 and 49) and from footnote [^aave]. Event reference and automation point preserved. Footnote now accurately notes that "specific aggregate figures vary by methodology." ✅

**Body text (S1 companion fix):** Line 17 correctly updated from "identifies non-overrideability as the core property" to "positions infrastructural sovereignty as the core property" — accurately reflects the paper's actual framing. ✅

All previously confirmed sources remain accurate. No new issues found.

---

## Original Verification (Session 626)

**Status at initial review:** ERRORS — 2 significant issues required fixes before publication

### Summary

Chapter on agentic sovereignty: TEE-based and blockchain-based agents that operate outside the PAC Framework's standard accountability chain. The thesis is well-constructed and the structural argument about "earlier accountability" vs "concurrent accountability" is sound. Two significant factual errors were found: a heavily miscited academic paper and an unverifiable liquidation figure. MakerDAO DSR claim and EU AI Act references were confirmed accurate.

**Issues found: 2 significant, 0 minor.**

---

### Source 1: Hu and Rong — Sovereign Agents Paper

**Footnote:** `[^sovereign-agents]` — original: "Hu, Y. and Rong, C., 'Sovereign Agents: Decentralized AI Agents with Non-Overrideability,' 2024."

**Status: SIGNIFICANT ERROR — wrong title, wrong author initials, wrong year. (FIXED)**

A paper by authors named Hu and Rong on sovereign agents does exist (arXiv:2602.14951), but the citation as written was wrong in three distinct ways:

#### S1 — Wrong Title (FIXED)

**Was written:** "Sovereign Agents: Decentralized AI Agents with Non-Overrideability"

**Actual title:** "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI"

#### S2 — Wrong Author Initials (FIXED)

**Was written:** "Hu, Y. and Rong, C."

**Actual authors:** Botao Amber Hu and Helena Rong — correct initials are B. Hu and H. Rong.

#### S3 — Wrong Year (FIXED)

**Was written:** "2024"

**Actual year:** 2026 (arXiv submission February 16, 2026; FAccT 2026).

---

### Source 2: Aave v3 $2.3 Billion Liquidations (FIXED)

**Was written (line 37):** "Aave's v3 liquidation engine processed over $2.3 billion in liquidations during the March 2023 stablecoin de-pegging event without a single human-initiated transaction."

**Status: SIGNIFICANT ERROR — figure was unverifiable. (FIXED)**

The specific $2.3 billion figure could not be found in any verifiable source. Contemporary reporting from March 2023 cited liquidation volumes in the hundreds of millions range across all Aave versions combined, not $2.3 billion for v3 alone.

**Fix applied:** Specific dollar amount removed. Body text now reads "processed liquidations continuously throughout the March 2023 USDC de-pegging event." Footnote [^aave] now notes "Specific aggregate figures vary by methodology; the point is the protocol's automated execution without human intervention."

---

## Confirmed Sources

### MakerDAO DSR Governance Vote 2023

**Status: CONFIRMED.** MakerDAO conducted multiple governance votes in 2023 to adjust the DAI Savings Rate. The governance mechanism is accurately described. No fix required.

### EU AI Act

**Status: CONFIRMED.** Regulation (EU) 2024/1689 is the correct legal identifier. Articles 9 and 16 are correctly cited and accurately characterized. No fix required.

### TEE Technical Claims

**Status: CONFIRMED.** Description of Intel SGX and AWS Nitro Enclaves security properties is accurate. Remote attestation claim is accurate. No fix required.

### DeFi Protocol Claims

**Status: CONFIRMED.** Automated market makers, algorithmic interest rate models, and liquidation engines are real and accurately described. No fix required.

### Confidential AI Inference Claims

**Status: CONFIRMED.** Intel Project Amber, Azure Confidential Computing, and AMD SEV-SNP are real products. Privacy guarantee characterization is accurate. No fix required.

---

## Routing

**Send to Chop Pop** — chapter is factually clean and ready for editing.
