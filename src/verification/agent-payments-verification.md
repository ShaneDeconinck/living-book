# Verification Report: agent-payments.md

**Verified by:** Sapere Aude
**Session:** 285
**Date:** 2026-03-14
**File:** src/chapters/agent-payments.md
**Status:** NEAR CLEAN — 1 significant fix, 1 minor fix required

---

## Summary

agent-payments.md is a well-sourced chapter with 21 footnotes covering x402, AP2, ACP, UCP, ERC-8004, KYA frameworks, and real-world payment milestones. The chapter is in good shape. Two issues found: one where the word "citing" misattributes journalist-reported reasons to OpenAI's own public statements, and one minor imprecision in the ERC-8004 author attribution.

---

## Issues Found

### SIGNIFICANT — Fix Required

**1. ACP: "citing" falsely attributes reasons to OpenAI**

Location: Section "ACP: Agentic Commerce Protocol," paragraph 1:
> "OpenAI dropped direct checkout from ChatGPT in early March 2026, within months of launch, **citing** inventory sync difficulties, tax infrastructure gaps, and low merchant adoption."

OpenAI's official public statement was: *"We are evolving our commerce strategy within ChatGPT to better meet merchants and users where they are. Instant checkout is transitioning to apps, where purchases can occur more seamlessly."* OpenAI did not publicly cite inventory sync difficulties, tax infrastructure gaps, or low merchant adoption. These were reporter-identified reasons from investigative coverage (The Keyword, Digital Commerce 360, ValueAddedResource). The word "citing" attributes them directly to OpenAI as stated reasons, which is inaccurate.

**Fix:** Change "citing inventory sync difficulties, tax infrastructure gaps, and low merchant adoption" to accurately represent these as reported findings rather than OpenAI's own statements. Options:
- "amid reported issues with inventory synchronization, tax compliance gaps, and low merchant adoption"
- "after internal and reported challenges with inventory synchronization, tax compliance, and merchant adoption"

---

### MINOR — Fix Recommended

**2. ERC-8004: "Ethereum ecosystem" should be "Ethereum Foundation"**

Location: Section "On-Chain Agent Identity: ERC-8004," paragraph 1:
> "The **Ethereum ecosystem**, together with Consensys, Google, and Coinbase, has taken a different approach to agent trust: on-chain registries."

The ERC-8004 proposal (EIP-8004) was authored by: Marco De Rossi (MetaMask, a Consensys product), Davide Crapis (Ethereum Foundation), Jordan Ellis (Google), and Erik Reppel (Coinbase). The contribution comes specifically from the **Ethereum Foundation**, not the broader "Ethereum ecosystem." "Ethereum ecosystem" is vague and could mislead readers into thinking it represents the community broadly rather than a specific institution.

**Fix:** Replace "Ethereum ecosystem" with "the Ethereum Foundation":
> "The **Ethereum Foundation**, together with Consensys, Google, and Coinbase, has taken a different approach..."

---

## Confirmed Clean

The following claims were verified against primary sources:

**x402 Infrastructure:**
- HTTP 402 "Payment Required" status code exists since 1997 — accepted, well-documented
- x402 Foundation co-founded by Coinbase and Cloudflare, announced September 23, 2025 — confirmed (Coinbase Blog, Cloudflare press release, Nasdaq)
- Stripe launched x402 integration on Base in February 2026 (USDC, The Block Feb 11 2026) — confirmed
- x402 daily organic volume ~$28,000 as of early March 2026 — confirmed (Artemis, MEXC, Bitget, ainvest)
- Daily transactions dropped over 92% from December 2025 peak of ~731,000 to ~57,000 in February 2026 — confirmed (Artemis via multiple sources)
- Roughly half of observed transactions reflecting artificial activity (self-dealing and wash trading) — confirmed: Artemis data shows ~48% of transaction count is gamed; "roughly half" is accurate for transaction count metric
- EIP-3009 TransferWithAuthorization: enables gasless payments, agent signs EIP-712 typed data, server settles on-chain — confirmed per Shane's x402 blog post and x402 spec
- Base L2 gas ~$0.002 (vs Ethereum mainnet ~$15) — confirmed, consistent with L2 economics and Shane's demo

**AP2 (Agent Payments Protocol):**
- Google announced AP2 in September 2025 — confirmed (Google Cloud Blog, September 16/19, 2025 per multiple sources)
- Over 60 organizations participating including Mastercard, American Express, PayPal, Adyen, Etsy, and Coinbase — confirmed (Google Cloud Blog)
- Mandate structure (Intent Mandate, Cart Mandate) separating browsing from buying — confirmed (Google Cloud Blog, AP2 documentation)
- Payment-agnostic (cards, bank transfers, crypto via x402), integrates with Verifiable Intent — confirmed

**ACP (Agentic Commerce Protocol):**
- Co-developed by Stripe and OpenAI — confirmed
- Specification maintained by OpenAI and Stripe (Apache 2.0) — confirmed (GitHub repository)
- Launched with ChatGPT Instant Checkout enabling purchases from Etsy — confirmed (OpenAI announcement, Stripe newsroom)
- Merchant remains merchant of record, not disintermediated — confirmed (ACP documentation)
- OpenAI dropped direct checkout from ChatGPT in early March 2026 — confirmed (Digital Commerce 360, The Keyword, multiple sources)
- ACP protocol continues — confirmed (OpenAI statement, Stripe documentation)
- Salesforce announcing support in collaboration with Stripe — confirmed (Salesforce investor relations press release)

**UCP (Universal Commerce Protocol):**
- Google, Shopify, and Walmart co-developed/co-announced UCP in January 2026 — confirmed (Google Developers Blog, January 11, 2026; Shopify Engineering blog; Walmart among listed co-developers)
- Visa among more than 20 endorsing partners — confirmed (Google Developers Blog: "endorsed by over 20 global partners" including Visa)
- Open-source standard, product catalog discovery focus — confirmed
- Compatibility with AP2 for payment handling — confirmed

**ERC-8004:**
- Went live on Ethereum mainnet January 29, 2026 — confirmed (CoinDesk, Gate.io, crypto.news)
- Three registries: Identity (ERC-721 NFT), Reputation (signed feedback), Validation — confirmed (EIP-8004 specification, multiple explainers)
- Deployed across 18+ EVM-compatible chains including listed names — confirmed (Chainstack blog: "18+ EVM-compatible chains including Ethereum, Base, BNB Chain, Polygon, Arbitrum"; Avalanche and Mantle also confirmed)
- Singleton contracts so all agents share the same registry on each chain — confirmed

**KYA Statistics:**
- "Nearly 90% of enterprises report that bot management is a major challenge" — confirmed (PYMNTS "How Enterprises Can Build a 'Know Your Agent' Defense" study, 350 global risk/compliance/fraud leaders)
- "Outdated digital identity controls cost businesses nearly $100 billion annually" — confirmed (same PYMNTS study)

**Trulioo:**
- Launched Know Your Agent in August 2025 — confirmed
- Five-checkpoint framework (verify developer, lock code, capture consent, issue DAP, continuous validation) — confirmed, chapter's description matches Trulioo documentation
- Joined Google AP2 December 4, 2025 — confirmed (BusinessWire 20251204250789)
- Worldpay partnership August 14, 2025 — confirmed (BusinessWire 20250814588043)

**Prove:**
- Launched Verified Agent solution October 23, 2025 — confirmed (BusinessWire 20251023729694)
- AP2 support at launch — confirmed
- "Protocol-agnostic" expansion — confirmed

**Real-World Milestones:**
- Santander and Mastercard completed Europe's first live end-to-end payment by an AI agent on March 2, 2026 — confirmed (Mastercard Newsroom, Santander press release); used Mastercard Agent Pay ✓; not a commercial rollout ✓
- Stripe's x402 preview February 2026, open-source CLI (purl), Python and Node.js SDKs — confirmed
- J.P. Morgan and Mirakl announced strategic agreement March 10, 2026 — confirmed (J.P. Morgan Payments newsroom, Mirakl press release); Nexus platform for product catalog layer ✓; tokenization infrastructure ✓

**Verifiable Intent:**
- Mastercard and Google open-sourced Verifiable Intent — confirmed (GitHub: agent-intent/verifiable-intent; verifiableintent.dev)
- Announcement March 5, 2026 (Mastercard article), Shane's blog post March 6, 2026 — confirmed (Shane's blog at shanedeconinck.be/tags/control/)
- Three-layer SD-JWT architecture, selective disclosure — confirmed
- Network-enforced budget caps, constraint table fields (payment.amount, payment.budget, etc.) — confirmed per Verifiable Intent spec

---

## Notes

**On x402 volume measurement:** The chapter correctly attributes volume figures to Artemis and uses "roughly half" for transaction count (Artemis: 48% gamed transactions). Worth noting that 81% of *volume* (by dollar amount) was artificial — the chapter references transaction count not dollar volume, which is accurate as stated. No fix needed, but the distinction is worth understanding.

**On ACP "citing" fix scope:** Only the word "citing" is wrong; the substance of the three reasons (inventory, tax, merchant adoption) is accurate per investigative reporting. The fix is minimal: change attribution framing, not the substance.

---

## Verdict

NEAR CLEAN. Apply 2 fixes before publication approval:
1. ACP paragraph: change "citing" to accurately attribute the reasons as reporter-identified, not OpenAI-stated
2. ERC-8004 paragraph: change "Ethereum ecosystem" to "Ethereum Foundation"

Both are direct substitutions. No re-verification required.

---

## Session 498 Addendum — 2026-03-15

**Fix 1 (ACP "citing"):** RESOLVED. Draft now reads "amid reported issues with inventory sync, tax infrastructure, and low merchant adoption." — reporter-identified framing in place, not OpenAI-stated. CONFIRMED.

**Fix 2 (ERC-8004 "Ethereum ecosystem"):** RESOLVED. Draft now reads "The Ethereum Foundation, together with Consensys, Google, and Coinbase..." — precise institutional attribution. CONFIRMED.

**Status:** FULLY APPROVED. Both session 285 issues resolved. Chapter is factually clean.

---

## Session 501 Addendum: Ghosty Prose Fixes (Commit 58451ae)

**Date:** 2026-03-15
**Scope:** Ghosty session 501 applied 3 prose changes to src/drafts/agent-payments.md.
**Status:** CLEAN — APPROVED

### Changes Reviewed

| Edit | What Changed | Factual Impact |
|---|---|---|
| 1. Unsourced superlative removed | "most comprehensive attempt to standardize agent commerce" removed from AP2 intro | None. "over 60 organizations participating" (the factual claim) preserved intact. ✓ |
| 2. Throat-clear removed | "The theory is being tested in production." cut before milestones list | None. Santander/Mastercard, Klarna, x402 milestones unchanged. ✓ |
| 3. Scaffolding removed | "This layering matters because" cut; paragraph now starts "Neither layer alone is sufficient." | None. The explanation of why layering matters is fully intact; the announcement was redundant. ✓ |

All 3 changes are prose-only. All factual claims (AP2 participant count and organizations, mandate structure, milestone details, trust stack layers) remain accurate and verified.

**Draft status: APPROVED. Safe to propagate prose changes to published chapter.**
