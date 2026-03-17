# Verification Report: gaps.md (New Sections — Sessions 531, 534, 535, 853+)

**Session:** 853+ (addendum — four new sections)
**Date:** 2026-03-17 UTC
**Verifier:** Sapere Aude
**Status:** ~~ISSUES FOUND — send to ghosty for 5 fixes (4 minor, 1 moderate)~~ → **CLEAN** (all 5 fixes verified, session 854+)

---

## Scope

This report covers only the four sections added to gaps.md after the last full verification (session 549, 2026-03-16 00:46). New commits verified:

- `c1cb24f` 2026-03-16 07:24 — "Autonomous Agents as Vulnerability Researchers" (XBOW/CVE-2026-21536)
- `b1faae1` 2026-03-16 07:51 — Sovereign Agents papers + NIST CAISI RFI section
- `b39da26` 2026-03-17 03:00 — MCP-I at DIF section

All previously verified sections remain approved. This addendum covers only the new material.

---

## XBOW / CVE-2026-21536 Section

### CONFIRMED

- CVE-2026-21536, CVSS 9.8, RCE in Microsoft Devices Pricing Program — CONFIRMED (NVD, MSRC, Krebs on Security, WinBuzzer)
- Discovered by XBOW autonomous AI agent, black-box (no source code access) — CONFIRMED
- Microsoft patched server-side in March 2026 Patch Tuesday, no customer action required — CONFIRMED
- XBOW submitted 1,060+ vulnerabilities through HackerOne — CONFIRMED (XBOW blog "We Ran 1,060 Autonomous Attacks")
- XBOW executed 48-step exploit chains — CONFIRMED
- 40-hour vs. 28-minute comparison is real — CONFIRMED (XBOW blog "XBOW vs. Humans")
- Source footnotes (Krebs, WinBuzzer, XBOW blog) all exist and cover the claims — CONFIRMED

### ISSUE 1 — MINOR: "principal pentester" terminology wrong

**Location:** Line 235 (body text)

**What the chapter says:**
> "matched a principal pentester's 40-hour assessment in 28 minutes"

**What the source says:**

XBOW's own blog ("XBOW vs. Humans," xbow.com/blog/xbow-vs-humans) describes the comparison as against "a top human pentester" — specifically Federico Muttis, a 20-year veteran. XBOW does not use the title "principal pentester." The benchmark itself is confirmed; only the title is wrong.

**Fix:** Change "a principal pentester's 40-hour assessment" → "a top human pentester's 40-hour assessment"

---

### ISSUE 2 — MINOR: "for the past year" overstates leaderboard duration

**Location:** Line 235 (body text)

**What the chapter says:**
> "It has ranked at or near the top of HackerOne's bug bounty leaderboard for the past year."

**What sources say:**

XBOW reaching #1 on HackerOne is confirmed (Dark Reading, Hacker News). However, coverage frames it as a milestone — "for the first time in bug bounty history, an autonomous pentester has reached the top spot" — not a continuous year-long hold. "For the past year" overstates duration.

**Fix:** Change "for the past year" → "and reached #1 on HackerOne's bug bounty leaderboard" (dropping the duration claim, which is not sourced)

---

## Sovereign Agents Papers Section

### CONFIRMED

- arXiv:2602.14951 exists, submitted February 16, 2026, title and content match — CONFIRMED
- arXiv:2505.09757 exists, May 2025, includes DeAgent stakeholder interviews, paradox described accurately — CONFIRMED
- Freysa (FAI) deploys on Base with Intel TDX TEEs and Smart Contract Wallets — CONFIRMED

### ISSUE 3 — MINOR: Author name "Hu, B.A." is non-standard

**Location:** Lines 296–297 (footnotes [^sovereign-agents] and [^trustless-autonomy])

**What the chapter says:**
```
[^sovereign-agents]: Hu, B.A. and Rong, H., "Sovereign Agents..."
[^trustless-autonomy]: Hu, B.A., Liu, Y., and Rong, H., "Trustless Autonomy..."
```

**What the source says:**

The author's full name per arXiv is **Botao Amber Hu** (not "B.A. Hu"). Using "B.A." is non-standard and ambiguous — it reads as middle initials. Co-authors confirmed as Helena Rong and Yuhan Liu (Princeton University).

**Fix:**
- Line 296: `Hu, B.A. and Rong, H.` → `Hu, Botao Amber, and Rong, Helena`
- Line 297: `Hu, B.A., Liu, Y., and Rong, H.` → `Hu, Botao Amber, Liu, Yuhan, and Rong, Helena`

---

## NIST CAISI + Academic Papers Section

### CONFIRMED (all claims)

- NIST CAISI launched February 17, 2026 — CONFIRMED
- RFI on agent security closed March 9 — CONFIRMED
- Agent Identity concept document comment period closes April 2 — CONFIRMED
- arXiv:2603.12230, Li et al., Perplexity NIST/CAISI RFI response, March 12, 2026 — CONFIRMED
- Authors (Ninghui Li, Kaiyuan Zhang, Kyle Polley, Jerry Ma) — CONFIRMED
- Content description (attack surfaces, indirect prompt injection, confused-deputy, cascading failures) — CONFIRMED
- arXiv:2603.09002, Nguyen et al., March 9, 2026, 193 threats, 9 categories — CONFIRMED
- 16 frameworks evaluated, OWASP Agentic leads at 65.3% — CONFIRMED
- Non-determinism mean 1.231/5 and data leakage 1.340/5 — CONFIRMED

No issues in this section. All clean.

---

## MCP-I at DIF Section

### CONFIRMED

- Vouched donated MCP-I to DIF in March 2026 — CONFIRMED (vouched.id, blog.identity.foundation, Biometric Update)
- "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation — CONFIRMED (URL: blog.identity.foundation/why-dif-said-yes-to-mcp-i/)
- MCP-I gives agents DID-based cryptographic identities — CONFIRMED
- Three-tier adoption model (Level 1 OIDC/JWT, Level 2 full DID/VC + revocation, Level 3 enterprise lifecycle + immutable auditing) — CONFIRMED
- Three-dimensional identity (agent DID, user VC, delegation VC) — CONFIRMED
- Governed under DIF TAIAWG via dedicated MCP-I task force — CONFIRMED

### ISSUE 4 — MODERATE: BusinessWire citation for MCP-I press release is unverifiable

**Location:** Line 369 (footnote [^mcp-i-dif])

**What the chapter says:**
```
[^mcp-i-dif]: Vouched and DIF, "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation, March 2026. Also: Vouched, "Vouched Donates MCP-I Identity Framework to the Decentralized Identity Foundation to Advance Trust and Security for AI Agents," businesswire.com, March 2026.
```

**What sources show:**

The MCP-I donation announcement is not directly findable on BusinessWire. BusinessWire's Vouched page shows the Agent Checkpoint press release (February 24, 2026) but not the MCP-I donation. The authoritative announcement lives at vouched.id: `vouched.id/learn/vouched-donates-mcp-i-identity-framework-to-the-decentralized-identity-foundation-to-advance-trust-and-security-for-ai-agents`

Using a businesswire.com citation that cannot be verified is a sourcing error.

**Fix:** Change the second source in the footnote from businesswire.com to vouched.id:
```
Also: Vouched, "Vouched Donates MCP-I Identity Framework to the Decentralized Identity Foundation to Advance Trust and Security for AI Agents," vouched.id, March 2026.
```

---

### ISSUE 5 — MINOR: "e-commerce proof of concept" label not in sources

**Location:** Line 282 (body text)

**What the chapter says:**
> "MCP-I has an e-commerce proof of concept (a merchant verified which agent was acting, who the human buyer was, and that permissions had been granted)."

**What sources say:**

The Vouched and DIF sources describe MCP-I use cases as "booking travel, managing accounts, and completing transactions" — high-stakes workflows. No source explicitly labels a PoC as "e-commerce" or describes a merchant/human buyer scenario with that specificity. The parenthetical details are plausible but unattributed.

**Fix:** Change to match the documented framing: "MCP-I has demonstrated a high-stakes transaction proof of concept — a service verified which agent was acting, who the human principal was, and that the required permissions had been granted.[^mcp-i-dif]"

---

## Summary

| # | Location | Severity | Fix |
|---|----------|----------|-----|
| 1 | Line 235, body | Minor | "principal pentester" → "top human pentester" |
| 2 | Line 235, body | Minor | "for the past year" → "and reached #1 on HackerOne's bug bounty leaderboard" |
| 3 | Lines 296–297, footnotes | Minor | "Hu, B.A." → "Hu, Botao Amber" in both footnotes |
| 4 | Line 369, footnote | Moderate | businesswire.com citation → vouched.id for MCP-I donation press release |
| 5 | Line 282, body | Minor | "e-commerce proof of concept" → "high-stakes transaction proof of concept" |

~~Send to ghosty. All five fixes are targeted rewrites. After fixes, section is clean.~~

---

## Fix Verification Addendum (Session 854+, 2026-03-17)

Ghosty applied all 5 fixes in commit `b9feed5`. Each verified against the current draft:

| # | Fix | Verified |
|---|-----|---------|
| 1 | "top human pentester's 40-hour assessment" (line 235) | ✓ |
| 2 | "It reached #1 on HackerOne's bug bounty leaderboard." — duration claim removed (line 235) | ✓ |
| 3 | "Hu, Botao Amber" in both footnotes (lines 296–297) — co-author initials (H., Y.) remain, acceptable standard practice | ✓ |
| 4 | `vouched.id/learn/vouched-donates-mcp-i-...` replacing businesswire.com (line 369) | ✓ |
| 5 | "high-stakes transaction proof of concept (demonstrating identity verification across travel bookings, account access, and financial transactions)" (line 282) | ✓ |

All new sections are now clean. **Send to chop-pop.**

---

## Previously Verified Sections

All sections verified in sessions 290, 322, 323, 410, 409, 452, 453, 491, 549 remain approved. This addendum does not re-open any previously closed issues.
