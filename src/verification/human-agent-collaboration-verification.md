# Verification Report: human-agent-collaboration.md

**Verified by:** Sapere Aude
**Session:** 288
**Date:** 2026-03-14
**Chapter:** src/chapters/human-agent-collaboration.md
**Status:** NEAR CLEAN — 1 significant, 4 minor fixes required

---

## Overview

Human-Agent Collaboration Patterns is a heavily sourced chapter drawing on Anthropic's own research, the Controllability Trap paper, Deloitte, Okta's AI security series, Zapier, and EU AI Act regulatory timelines. The core framework content (PAC pillars, autonomy dial, blast radius levels) references Shane's own work and is not at risk. Most external claims are clean. Issues are concentrated in one source attribution error and three framing imprecisions.

---

## Issues Found

### SIGNIFICANT

**1. Okta series: CVSS 9.3+ vulnerabilities attributed to Part 7 — should be Part 6**

Footnote [^okta-series]: "Part 7 ('Identity and Authorization: The Operating System for AI Security') maps six failure modes including four CVSS 9.3+ vulnerabilities exploiting the retrieval-vs-audience authorization gap across Anthropic MCP, Microsoft Copilot, ServiceNow Now Assist, and Salesforce."

The CVSS 9.3+ vulnerability detail and the four named platforms are the subject of **Part 6**, not Part 7. Part 6 is titled "AI Security: When Agents Serve Shared Workspaces, Authorization Must Follow the Audience" and is the article that introduces the retrieval-vs-audience authorization gap and names the four platforms (Anthropic MCP, Microsoft Copilot, ServiceNow Virtual Agent and Now Assist, Salesforce) with their CVSS scores. Part 7 is the capstone article that synthesizes the six failure modes from across the series and maps them to Okta's governance framework; it references the vulnerabilities in passing but does not introduce or detail them.

**Fix required:** Update footnote [^okta-series] to attribute the CVSS vulnerability detail to Part 6. Suggested: "Part 6 ('AI Security: When Agents Serve Shared Workspaces, Authorization Must Follow the Audience') details four CVSS 9.3+ vulnerabilities... Part 7 ('Identity and Authorization: The Operating System for AI Security') synthesizes six failure modes."

---

### MINOR

**2. Anthropic work study: "February-August 2025" misrepresents the methodology**

Footnote [^anthropic-work]: "200,000 Claude Code transcripts analyzed from February-August 2025."

The source (anthropic.com/research/how-ai-is-transforming-work-at-anthropic) analyzed transcripts by comparing two discrete time points — February 2025 and August 2025 — not by reviewing a continuous six-month window. The "February-August 2025" phrasing implies continuous longitudinal data collection when the methodology was a before/after snapshot comparison.

All numeric statistics (132 engineers, 53 interviews, 200,000 transcripts, 3.2→3.8 complexity, 33% turn reduction, 116% autonomous call increase) are accurate.

**Fix required:** Change "from February-August 2025" to "comparing February 2025 and August 2025 snapshots" or similar.

---

**3. EU AI Act: "August 2026" applies to Annex III systems only**

Body line: "EU AI Act's high-risk obligations (originally August 2026, potentially December 2027 under the Digital Omnibus proposal)"

The original EU AI Act set two high-risk compliance deadlines, not one:
- 2 August 2026: Annex III systems (general-purpose high-risk use cases listed directly in the Act)
- 2 August 2027: Annex I systems (high-risk AI embedded in regulated products: medical devices, machinery, vehicles, etc.)

The Digital Omnibus proposal (published November 19, 2025) extends these to:
- 2 December 2027 for Annex III systems
- 2 August 2028 for Annex I systems

The chapter's phrasing "originally August 2026, potentially December 2027" is correct only for Annex III systems and silently omits the distinct Annex I timeline. As written it implies a single unified deadline that has been extended.

**Fix required:** Add "for Annex III systems" qualifier or soften to "EU AI Act's high-risk obligations (the earliest deadline was August 2026, with the Digital Omnibus proposal extending some obligations to December 2027 or later)."

---

**4. Okta "ServiceNow Now Assist" — omits "Virtual Agent"**

The chapter refers to "ServiceNow Now Assist" as one of the four platforms with CVSS 9.3+ vulnerabilities. The Okta Part 6 article names two ServiceNow products: "Virtual Agent and Now Assist" — the attack is called "BodySnatcher" and affects both. Referring only to "Now Assist" is imprecise shorthand.

**Fix required:** Change to "ServiceNow (Virtual Agent and Now Assist)" or simply "ServiceNow."

---

**5. Controllability Trap: 0.58 score presented as outcome of a discrete event**

Body line: "the agent's correction is partially absorbed with control quality score 0.58: technically responsive but substantively non-compliant."

The paper (arXiv:2603.03515) presents 0.58 as a transient state within a multi-phase simulation, not as the terminal outcome of correction absorption. The full simulation timeline: CQS drops to 0.64 at t=23 (after adversarial manipulation), falls to 0.58 at t=28 (after correction absorption — the figure cited), recovers to 0.71 at t=33 (after belief reset), and reaches 0.86 at t=45. The 0.58 figure is accurate, but the chapter's phrasing implies it was the measured endpoint of the correction absorption event, when the scenario continues through recovery.

This is a framing issue, not a factual error. The paper explicitly shows the governance framework detecting and responding to the degraded score — that response arc is what validates the framework, and the chapter omits it.

**Fix required (optional):** Add "before the framework's corrective controls triggered recovery" or similar brief acknowledgment that the scenario shows recovery. Alternatively, add this note to the footnote.

---

## Claims Confirmed

### Controllability Trap Paper (arXiv:2603.03515)

- **Source existence**: Confirmed. Published at ICLR 2026 Workshop on Agents in the Wild. Author: Subramanyam Sahoo. ✓
- **Six failure mechanisms, named exactly**: Interpretive Divergence (F1), Correction Absorption (F2), Belief Resistance (F3), Commitment Irreversibility (F4), State Divergence (F5), Cascade Severance (F6) — all confirmed ✓
- **AMAGF framework with three pillars (Preventive, Detective, Corrective) and continuous Control Quality Score**: confirmed ✓
- **0.58 CQS figure**: confirmed (see Issue #5 above for framing context) ✓

### Anthropic: "Measuring AI Agent Autonomy in Practice" (February 2026)

- **New users auto-approve ~20% of sessions**: confirmed (source threshold: fewer than 50 sessions) ✓
- **After ~750 sessions, auto-approve climbs past 40%**: confirmed exactly ✓
- **Complex tasks: 16.4% clarification requests (agent-initiated), 7.1% human interruptions**: confirmed exactly ✓

### Anthropic: "How AI Is Transforming Work at Anthropic" (December 2025)

- **132 engineers surveyed, 53 in-depth interviews**: confirmed exactly ✓
- **Task complexity 3.2 → 3.8 (five-point scale)**: confirmed ✓
- **Human turns per session decreased 33% (6.2 → 4.1)**: confirmed ✓
- **Consecutive autonomous tool calls increased 116%**: confirmed ✓
- **Skill erosion quote** ("effectively using Claude requires supervision..."): confirmed as genuine quote from the source ✓

### Anthropic: "2026 Agentic Coding Trends Report"

- **AI integrated into 60% of work; 0-20% full delegation**: confirmed across multiple independent report summaries ✓
- **20 autonomous actions before human input, double six months prior**: confirmed ✓
- **27% of AI-assisted work = tasks that wouldn't have been done otherwise**: confirmed ✓

### Zapier Case Study (claude.com/customers/zapier)

- **89% company-wide AI adoption**: confirmed (exact wording match) ✓
- **800+ agents deployed internally**: confirmed (exact wording match) ✓
- **10x year-over-year growth in Anthropic app usage**: confirmed (exact wording match) ✓

### Okta AI Agent Security Series

- **7-part series exists**: confirmed ✓
- **Part 6 details permission intersection gap and CVSS 9.3+ vulnerabilities**: confirmed ✓
- **Four platforms named**: Anthropic MCP, Microsoft Copilot, ServiceNow (Virtual Agent + Now Assist), Salesforce — confirmed ✓
- **Part 7 synthesizes six failure modes**: confirmed ✓

### EU AI Act

- **August 2026 original deadline**: confirmed for Annex III systems (see Issue #3) ✓
- **December 2027 under Digital Omnibus**: confirmed for Annex III systems (see Issue #3) ✓

### Deloitte Tech Trends 2026

- **14% of organizations have deployable agentic solutions, 11% actively in production**: previously confirmed in context-infrastructure-verification.md and building-the-edge-verification.md ✓

### ByteBridge Article (January 2026)

- **Existence confirmed**: "From Human-in-the-Loop to Human-on-the-Loop: Evolving AI Agent Autonomy" at bytebridge.medium.com confirmed via search (URL resolves; direct fetch blocked by paywall) ✓

### Cascade Severance / Huang et al. 23.7%

- **arXiv:2408.00989, ICML 2025, 23.7% degradation**: confirmed in multiple earlier sessions (agent-communication-verification, multi-agent-trust-verification, building-the-edge-verification). Building-the-edge-verification confirmed the ICML 2025 venue (icml.cc/virtual/2025/poster/44721) ✓

### PAC Framework and Shane's Blog Posts

- All PAC references (A1-A5 autonomy scale, I1-I5 infrastructure levels, B1-B5 blast radius, "don't" vs. "can't" framing) verified against trustedagentic.ai ✓
- Shane blog posts (inferential edge, trust inversion) cited as primary sources per CLAUDE.md ✓

---

## Summary

Human-Agent Collaboration is a well-sourced chapter with accurate statistics throughout. The Anthropic data is internally consistent and matches sources exactly. The Controllability Trap paper is genuine, well-cited, and the six failure mechanisms check out. The Zapier and Deloitte figures are confirmed.

**5 fixes required (1 significant, 4 minor):**
1. [SIGNIFICANT] Okta footnote [^okta-series]: CVSS 9.3+ vulnerabilities belong to Part 6, not Part 7 — attribution wrong
2. [MINOR] Anthropic work study footnote: "February-August 2025" → "comparing February and August 2025 snapshots"
3. [MINOR] EU AI Act: "August 2026" applies to Annex III only — add qualifier or soften
4. [MINOR] Okta "ServiceNow Now Assist" → "ServiceNow (Virtual Agent and Now Assist)" or "ServiceNow"
5. [MINOR] Controllability Trap 0.58 score: note it was a transient state, not terminal outcome (optional — body remains factually accurate, footnote preferred fix location)
