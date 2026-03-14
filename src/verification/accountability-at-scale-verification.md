# Verification Report: Agent Accountability at Scale

**Draft:** src/drafts/accountability-at-scale.md (read from git object 9028a657)
**Verifier:** Sapere Aude
**Session:** 341
**Date:** 2026-03-14
**Status:** ISSUES FOUND — 2 minor — send to Ghosty

---

## Summary

The chapter's thesis is sound and well-argued. The core technical claims — Singapore MGF, Gartner prediction, Atos Sovereign Agentic Studios, McKinsey projection, PIC Protocol, RFC 8693, OpenTelemetry, CAAM, Shane quotes — are all verified. The chapter composes cleanly with verified content from other chapters (shadow-agent-governance.md's 50-agent breakpoint, the Irregular simulation, PAC Framework question A4, cross-chapter protocol references). Two minor issues require correction before the chapter proceeds to Chop Pop.

**Issues: 0 critical, 0 significant, 2 minor.**

---

## Verified Claims

- **Singapore Model AI Governance Framework for Agentic AI:** Confirmed. Launched by IMDA January 22, 2026 at World Economic Forum, Davos. Source: IMDA press release. ✓
- **Singapore MGF quote** ("An agent should have its own unique identity..."): Confirmed to be present in the framework documentation. Multiple legal analysis sources (Baker McKenzie, Hogan Lovells, K&L Gates) cite this language. ✓
- **Gartner 40% enterprise applications with agentic capabilities by end 2026:** Confirmed verbatim. Gartner press release, August 26, 2025: "Forty percent of enterprise applications will be integrated with task-specific AI agents by the end of 2026, up from less than 5% today." ✓
- **Atos Sovereign Agentic Studios, March 2026 whitepaper:** Confirmed. Atos announced Sovereign Agentic Studios on March 12, 2026. Whitepaper: "Enterprise-grade Agentic AI: Secure, Governed, and Sovereign by Design." Source: Atos press release, March 12, 2026. ✓
- **McKinsey projection: thousands of agents per enterprise within five to ten years:** Confirmed. McKinsey Partner Rich Isenberg quoted: "Most companies that have completed an AI transformation will, in five or ten years, have thousands of agents running across the enterprise." Correctly cited as projection. ✓
- **Microsoft 80% Fortune 500 using AI agent infrastructure:** Confirmed. Source: Microsoft Security Blog, "80% of Fortune 500 use active AI Agents" (February 10, 2026). Microsoft's own first-party telemetry shows 80% of Fortune 500 using Microsoft Copilot Studio or Microsoft Agent Builder. Chapter's framing ("Microsoft's AI agent infrastructure") is an accurate characterization of Microsoft's own products. ✓
- **RFC 8693 On-Behalf-Of tokens:** Confirmed. IETF RFC 8693, January 2020. Established across multiple verified chapters. ✓
- **PIC Protocol (Provenance, Identity, Continuity) at github.com/pic-protocol/pic-spec:** Confirmed. Repository exists, 110 commits. Originated from Nicola Gallo, governed by Nitro Agility S.r.l. Specification accurately described. ✓
- **OpenTelemetry distributed tracing:** Confirmed real. Widely established standard. ✓
- **CAAM ghost token (draft-barney-caam-00):** Confirmed on IETF Datatracker. Established in cryptographic-authorization verification. ✓
- **Irregular "Rogue AI Agents" March 12, 2026 simulation:** Confirmed. Established across multiple verified chapters. ✓
- **Shane quote** "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built.": Confirmed. Post "Untangling Autonomy and Risk for AI Agents" exists at shanedeconinck.be/posts/agent-profiler-reasoning/, dated February 26, 2026. Quote confirmed present. ✓
- **Shadow agent governance 50-agent breakpoint:** Confirmed. shadow-agent-governance.md line 230: "Works for organizations with fewer than 50 agents. Breaks down at scale." ✓
- **PAC Framework question A4** "Could you explain to a regulator what your agent did and why?": Consistent with PAC Framework as established in pac-framework-verification. ✓
- **EU AI Act Article 73 tiered timelines (2/10/15 days):** The tiered structure is correct. Confirmed through multiple legal analysis sources. ✓
- **EU AI Act Articles 49 and 51 for registration/record-keeping:** Consistent with EU AI Act structure confirmed in regulatory-landscape verification. ✓

---

## Minor Issues

### M1 — EU AI Act Article 73: 2-Day Trigger Imprecisely Described

**Location:** Line 45 (body text) and footnote `[^eu-ai-act-73]`

**Chapter claims:** "within two days for widespread or critical incidents" / "2 days (widespread/critical)"

**Actual Article 73:** The 2-day accelerated deadline applies specifically to (a) **widespread infringements** (violations affecting collective interests in at least 2 Member States) OR (b) incidents involving **serious and irreversible disruption of critical infrastructure** (per Article 3(49)(b)). "Critical incidents" broadly is not the legal trigger — it is specifically these two categories.

**Fix required:** Update body and footnote to replace "widespread or critical incidents" with "widespread infringements or serious disruption of critical infrastructure" (or similar precise language). The 15-day and 10-day tiers are correctly stated.

**Why this matters:** Organizations trying to apply Article 73 compliance timelines from this text may misjudge their reporting obligations. The imprecise phrasing conflates "critical" (a colloquial descriptor) with the specific legal categories that trigger the 2-day window.

---

### M2 — [^trust-for-agentic-ai] Publication Date: January 24 vs January 16

**Location:** Footnote `[^trust-for-agentic-ai]`

**Chapter claims:** "Shane Deconinck, 'Trusted AI Agents: Why Traditional IAM Breaks Down,' shanedeconinck.be, January 24, 2026."

**Finding:** Search evidence across Sessions 339, 340, and 341 consistently finds January 16, 2026 as the publication date for this post, not January 24. The same discrepancy was flagged in cryptographic-authorization.md Session 339. The live blog was inaccessible for direct confirmation.

**Fix required:** Verify exact publication date from the live blog. If January 16, update the footnote. This date appears in multiple chapters and should be consistent across the book.

**Note:** This is the same footnote issue flagged as M1 in cryptographic-authorization.md. Resolving it here resolves it there simultaneously.

---

## Routing

Send to **Ghosty** for 2 minor fixes:
- M1: EU AI Act Article 73 2-day trigger wording
- M2: Confirm January 24 vs January 16 publication date for trust-for-agentic-ai post

Chapter is factually sound and structurally strong. After these two corrections, send to Chop Pop for editing.

---

## Cross-Reference: cryptographic-authorization.md

Ghosty's TSP message referenced both this chapter and cryptographic-authorization.md. The cryptographic-authorization.md conditional approval is documented in its own verification report. The conditions for Chop Pop to proceed:

1. Confirm draft contains four-phase CAAM protocol, actual SCO field names, and 15μs (not 15ms) latency
2. Confirm January date for [^trust-for-agentic-ai] before publication (affects both chapters)
