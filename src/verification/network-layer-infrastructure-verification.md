# Verification: network-layer-infrastructure.md (Chapter 24)

**Status:** ISSUES FOUND — routing back to Ghosty (re-verification of commit 4b5e778)
**Verified by:** Sapere Aude
**Date:** 2026-03-15 02:15 UTC
**Draft commit:** 4b5e778

---

## Re-Verification Summary

Ghosty fixed the Agent-GW MCP/A2A issue (RESOLVED). The Cisco section remains problematic: the URL correction introduced a new wrong-author error, and the three original unverifiable feature names and claims were not addressed. The chapter cannot proceed to Chop Pop.

---

## Fix-by-Fix Assessment

### Fix 1: Agent-GW MCP/A2A softened — RESOLVED ✓

The draft now reads: "The draft references MCP and A2A as illustrative examples of protocols the gateway would adapt between — MCP for agent-to-external-resource communication, A2A for agent-to-agent coordination — but does not specify them as native implementations."

This correctly reflects the draft's language. Issue 3 from the original report is closed.

---

### Fix 2: "largest" → "most significant" — UNRESOLVED

The text was changed to "most significant expansion." The Cisco blog post at `blogs.cisco.com/security/redefining-security-for-the-agentic-era` (fetched March 15, 2026) does **not** contain the phrase "most significant expansion" or "largest expansion." Neither phrasing appears in the source. The footnote's claim about how Cisco described this announcement remains unsourced.

**Status:** The word change did not resolve the issue — both phrasings are absent from the source.

---

### Fix 3: Cisco blog URL corrected — PARTIALLY RESOLVED, NEW ISSUE INTRODUCED

The footnote was changed from `newsroom.cisco.com` to `blogs.cisco.com/security/redefining-security-for-the-agentic-era`. The URL now resolves and the page exists. However:

**New error:** The footnote now reads: `Jeetu Patel, "Redefining Security for the Agentic Era," blogs.cisco.com/security/redefining-security-for-the-agentic-era, February 10, 2026.`

**The author of this post is Peter Bailey (SVP and GM of Cisco's Security business), not Jeetu Patel.** Jeetu Patel is Cisco's Chief Product Officer. This is a wrong attribution introduced by Ghosty's fix.

**Status:** URL is now correct, but the author name in the footnote is factually wrong. Must be corrected to Peter Bailey.

---

### Fix 4: Separate [^cisco-ai-bom] footnote added — PARTIALLY RESOLVED

A new footnote was added: `Cisco, "Know Your AI Stack: Introducing AI BOM in Cisco AI Defense," blogs.cisco.com/ai/know-your-ai-stack-introducing-ai-bom-in-cisco-ai-defense, 2026. Covers AI BOM and MCP Catalog capabilities for supply chain visibility.`

The URL resolves and the page exists. The source confirms:
- "AI BOM (AI Bill of Materials)" — **CONFIRMED**
- "AI supply chain risk management" — **CONFIRMED**
- "MCP tools" (in supply chain context) — **CONFIRMED**

However: The phrase **"MCP Catalog"** does **not appear** in this blog post. The footnote claims this source "Covers AI BOM and MCP Catalog capabilities" but the source does not use the term "MCP Catalog." The draft text reads: "The MCP Catalog discovers and manages risk across MCP servers on both public and private platforms." This specific capability name remains unsourced.

**Status:** AI BOM citation is now sourced. "MCP Catalog" as a named capability remains unverified from the cited source.

---

## Persistent Issues from Original Report

### Issue A: "MCP Visibility and Policy Control" — STILL UNRESOLVED

The draft still contains: "**MCP Visibility and Policy Control.** Cisco's AI-Aware SASE can now discover and govern MCP communications with in-path controls and inspection outcomes, managing agent-to-tool connectivity at the network layer."

The Cisco blog post (Peter Bailey, February 10, 2026) mentions MCP once: "inspecting MCP communications, detecting threats in encrypted traffic, and identifying emerging attack patterns." The named capability "MCP Visibility and Policy Control" does not appear in the source. The concept of MCP inspection is present, but the branded feature name is not.

**Required action:** Either find a source that uses the exact name "MCP Visibility and Policy Control" (product datasheet, press release, launch page), or rephrase using language from what the source actually says.

---

### Issue B: "AI Traffic Optimization" / "packet duplication techniques" — STILL UNRESOLVED

The draft reads: "**AI Traffic Optimization.** The platform detects AI traffic and applies packet duplication techniques to maintain reliable, low-latency interactions during agentic workload bursts."

The Cisco blog post (Peter Bailey, February 10, 2026) contains no mention of "AI Traffic Optimization," "packet duplication," or "traffic optimization." The post does not describe this capability.

**Required action:** Find a Cisco source that documents "AI Traffic Optimization" and "packet duplication techniques" specifically, or remove this section. This cannot remain in the chapter unsourced.

---

## Issues Summary

| # | Severity | Location | Status |
|---|---|---|---|
| 1 | **MAJOR** | Cisco section, `[^cisco-sase-2026]` footnote | NEW: Wrong author — Peter Bailey is the author, not Jeetu Patel |
| 2 | **MAJOR** | Cisco section, "MCP Visibility and Policy Control" | PERSISTENT: Named capability not found in any located Cisco source |
| 3 | **MAJOR** | Cisco section, "AI Traffic Optimization" / "packet duplication techniques" | PERSISTENT: Not found in any located Cisco source |
| 4 | **MEDIUM** | Cisco section, para 1 | PERSISTENT: "most significant expansion" not found in source |
| 5 | **MINOR** | Cisco section, `[^cisco-ai-bom]` footnote | PERSISTENT: Footnote claims "MCP Catalog" but source does not use that term |
| 6 | ~~MINOR~~ | Agent-GW section | **RESOLVED** ✓ |

---

## What the Source Actually Says

For reference, the located Cisco blog post (Peter Bailey, `blogs.cisco.com/security/redefining-security-for-the-agentic-era`, February 10, 2026) can be sourced for:

- Intent-based inspection / semantic understanding of agent behavior ("understand intent and context," NLP-based intent classification)
- MCP inspection in Secure Firewall ("inspecting MCP communications, detecting threats in encrypted traffic")
- eBPF and Cilium for kernel-level visibility
- The general framing: moving from "block/allow" to intent-aware security

The Cisco AI BOM blog post (`blogs.cisco.com/ai/know-your-ai-stack-introducing-ai-bom-in-cisco-ai-defense`) can be sourced for:
- AI BOM concept and Cisco's implementation
- AI supply chain risk management with MCP tools (not "MCP Catalog" specifically)

---

## Routing Decision

**→ Ghosty.** Five issues remain, including three majors. Most critical: wrong author attribution (Peter Bailey not Jeetu Patel), and two feature names ("MCP Visibility and Policy Control," "AI Traffic Optimization"/"packet duplication techniques") with no traceable source. Ghosty should either locate a Cisco product datasheet or dedicated capability page that contains these names, or rephrase the Cisco section using only what the two located blog posts actually say. Chop Pop should not receive this chapter until the Cisco section is factually clean.
