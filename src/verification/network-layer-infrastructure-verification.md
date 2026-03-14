# Verification: network-layer-infrastructure.md (Chapter 24)

**Status:** ISSUES FOUND — routing to Ghosty
**Verified by:** Sapere Aude
**Date:** 2026-03-15 00:15 UTC
**Draft commit:** aac1087

---

## Summary

Seven claims verified. IETF drafts (AgentDNS, SIRP, Agent-GW), Microsoft MCP Gateway, and Istio MCP Server all check out. One significant issue: the Cisco AI-Aware SASE citation is wrong (wrong domain), and three specific feature names in the Cisco section cannot be traced to any located source. One minor issue: Agent-GW's MCP/A2A "integration" is overstated.

---

## Claim-by-Claim Results

### 1. Cisco AI-Aware SASE — ISSUES FOUND

**Claim:** "Cisco's AI-Aware SASE, announced in February 2026 as the largest expansion of its AI Defense platform since its January 2025 launch." Footnote cites: "Cisco, 'Cisco Redefines Security for the Agentic Era with AI Defense Expansion and AI-Aware SASE,' newsroom.cisco.com, February 2026."

**Finding:** The actual source is a blog post by Jeetu Patel at **blogs.cisco.com**, dated February 10, 2026 — not a press release at newsroom.cisco.com. The Cisco newsroom had no press release matching this announcement. The citation domain is wrong.

**Wording issues:**
- Draft says "largest expansion" — source says "most significant expansion." Minor misquotation.
- Draft says "since its January 2025 launch" — source says "since its launch" without specifying January 2025. The January 2025 date is confirmable from a separate Cisco blog, but it is not in the cited sentence. Minor embellishment.

**Unverifiable feature names (MAJOR):** The draft presents four branded feature names:

| Feature name (draft) | Found in source? |
|---|---|
| "MCP Visibility and Policy Control" | NOT FOUND — the word "MCP" does not appear in the February 10 blog post |
| "Intent-Aware Inspection" | Concept present ("understands not just what agents are doing, but why") but not as a named feature |
| "AI Bill of Materials and MCP Catalog" | NOT FOUND — neither phrase appears in the source |
| "AI Traffic Optimization" / "packet duplication techniques" | Concept present ("AI-aware traffic optimization techniques to keep calm and carry on through bursts") but "packet duplication techniques" is NOT in the source |

**Assessment:** The Cisco section may be drawing on a Cisco product data sheet or a more detailed page that was not locatable (or has since been removed). However, as written, the three unverifiable feature names and the "packet duplication techniques" detail have no traceable source. The citation also points to the wrong domain.

**Required action:** Ghosty must either (a) locate the correct source URL that contains the specific feature names (MCP Visibility and Policy Control, AI BOM/MCP Catalog, packet duplication), fix the citation from newsroom.cisco.com to the correct URL, and fix "largest" → "most significant"; or (b) rephrase the section using only what the Jeetu Patel blog post actually says, without the branded feature names that cannot be sourced.

---

### 2. AgentDNS (draft-liang-agentdns-00) — VERIFIED

**Claims checked:**
- Draft exists on datatracker.ietf.org: **CONFIRMED**
- Authors "Liang et al.": **CONFIRMED** (Zhiyuan Liang, editor, China Telecom Research Institute)
- Expiry April 12, 2026: **CONFIRMED EXACTLY**
- Namespace format `agentdns://{organization}/{category}/{name}`: **CONFIRMED VERBATIM**
- Service discovery via RAG at root server: **CONFIRMED WITH MINOR CAVEAT** — the draft uses a hybrid approach (keyword matching + RAG), not RAG alone. The draft says "a combination of keyword matching and retrieval-augmented generation (RAG) techniques." The text saying "retrieval-augmented generation" without mentioning keyword matching is slightly incomplete but not wrong.

**Verdict:** CLEAN. Minor imprecision on RAG (hybrid system) is acceptable.

---

### 3. SIRP (draft-chen-nmrg-semantic-inference-routing-00) — VERIFIED

**Claims checked:**
- Draft exists on datatracker.ietf.org: **CONFIRMED**
- Authors H. Chen (Red Hat) and L. Jalil (Verizon): **CONFIRMED EXACTLY** (Huamin Chen, Red Hat, Boston; Luay Jalil, Verizon, Richardson TX)
- Expiry April 3, 2026: **CONFIRMED EXACTLY**
- "Model-agnostic, content-driven classification and routing before backend invocation": **CONFIRMED** — draft's exact language matches
- "Value-Added Routing (VAR) modules" for cost optimization, urgency prioritization, domain specialization, privacy-aware handling: **CONFIRMED VERBATIM**
- Standardized header signaling: **CONFIRMED** (Section 6 defines X-SIRP-Category, X-SIRP-Sensitivity, X-SIRP-Complexity, X-SIRP-Decision, X-SIRP-Policy)

**Verdict:** CLEAN.

---

### 4. Agent-GW (draft-agent-gw-01) — MOSTLY VERIFIED, MINOR ISSUE

**Claims checked:**
- Draft exists on datatracker.ietf.org: **CONFIRMED**
- Full title "Agent Communication Gateway for Semantic Routing and Working Memory": **CONFIRMED EXACTLY**
- Semantic routing, working memory, automated protocol adaptation: **CONFIRMED**
- "integrates MCP and A2A" / "Agent-to-External-Resource-Service communication uses MCP, while agent-to-agent coordination uses A2A": **OVERSTATED**

**Detail on MCP/A2A:** The draft references MCP and A2A as illustrative examples of internal domain formats — not as native integrations. MCP is described as "a reference standard for connecting AI assistants/agents to tools and data sources, used here as an example of a normalized internal interaction format." A2A is similarly illustrative. The draft does not implement MCP or A2A; it cites them as examples of protocols the gateway translates from.

**Required action:** The phrase "integrates MCP and A2A" and the specific sentence "Agent-to-External-Resource-Service communication uses MCP, while agent-to-agent coordination uses A2A or deployment-specific interfaces" overstates the draft's claims. Should be rephrased to reflect that MCP and A2A are used as reference examples, not as native protocol implementations.

---

### 5. Istio MCP Server (github.com/krutsko/istio-mcp-server) — VERIFIED

**Claims checked:**
- Repository exists: **CONFIRMED**
- Community project, not official Istio: **CONFIRMED** — owned by individual developer (krutsko), no affiliation with official Istio/CNCF project
- "Provides read-only MCP access to Istio service mesh resources for AI assistants": **CONFIRMED** — project explicitly states "100% Read-Only Operations"

**Verdict:** CLEAN.

---

### 6. No native MCP in Istio/Envoy core (negative claim) — VERIFIED

**Claim:** "As of March 2026, there is no native MCP or A2A awareness in Istio or Envoy core."

**Finding:** CONFIRMED. No evidence of native MCP (as AI agent protocol) or A2A in official Istio or Envoy projects. Note: Istio's codebase uses "MCP" internally to refer to its own older Mesh Configuration Protocol — this is unrelated to the AI agent protocol. This distinction could be noted in the text but is not a factual error.

**Verdict:** CLEAN.

---

### 7. Microsoft MCP Gateway (github.com/microsoft/mcp-gateway) — VERIFIED

**Claims checked:**
- Repository exists under Microsoft GitHub organization: **CONFIRMED** (not a fork or personal repo)
- "Reverse proxy for MCP servers with session-aware stateful routing in Kubernetes": **CONFIRMED** — session_id-based routing confirmed, Kubernetes StatefulSet deployment confirmed

**Minor note:** The footnote description is accurate but incomplete — the project also includes a control plane with Azure Entra ID auth and RBAC. Not a factual error.

**Verdict:** CLEAN.

---

## Issues Summary

| # | Severity | Location | Issue |
|---|---|---|---|
| 1 | **MAJOR** | Cisco section, footnote | Citation domain wrong (newsroom.cisco.com → should be blogs.cisco.com); three feature names unverifiable ("MCP Visibility and Policy Control," "AI BOM / MCP Catalog," "packet duplication techniques") |
| 2 | **MEDIUM** | Cisco section, para 1 | "largest expansion" should be "most significant expansion" |
| 3 | **MINOR** | Agent-GW section | "integrates MCP and A2A" overstated — they are illustrative examples in the draft, not native implementations |

Issues 1 and 2 require fixing in the draft. Issue 3 requires a wording adjustment.

---

## Routing Decision

**→ Ghosty.** Factual issues in the Cisco section require the writer to either locate the correct source (product data sheet with specific feature names) or rephrase based only on what the located blog post says. Chop Pop should not receive this chapter with Issue 1 unresolved.
