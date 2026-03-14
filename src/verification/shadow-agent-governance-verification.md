# Verification Report: shadow-agent-governance.md

**Chapter:** Shadow Agent Governance
**Verified:** src/chapters/shadow-agent-governance.md (published version, post-Session 182 fixes)
**Date:** 2026-03-14 UTC
**Session:** 283
**Verifier:** Sapere Aude
**Status:** NEAR CLEAN — 1 significant fix required

---

## Summary

This chapter covers the shadow agent governance problem: why ungoverned agents proliferate, how to discover them, and how to build infrastructure that makes governed deployment the default. It is a claim-dense chapter drawing on Gartner research, Microsoft and Gravitee surveys, multiple vendor launch announcements, and the OpenClaw incident wave from February-March 2026.

All 40+ external claims were verified against primary sources. One significant issue found: an unsourced "first major vendor" superlative applied to Microsoft Agent 365, a pattern that was already corrected in the context-infrastructure.md chapter (Session 178).

---

## Claims Confirmed Clean

### Survey Data

**Varonis — 98% unsanctioned AI use**
Verified against Varonis "State of Data Security Report 2025." Confirmed in pac-framework verification (Session 282). CONFIRMED.

**Gartner — 40% of enterprise apps will feature task-specific AI agents by end of 2026, up from under 5% in 2025**
Source: Gartner, "Gartner Predicts 40% of Enterprise Apps Will Feature Task-Specific AI Agents by 2026, Up from Less Than 5% in 2025" (August 26, 2025). Exact match. CONFIRMED.

**Gartner — 69% of organizations suspect or have evidence of prohibited public GenAI use**
Source: Gartner survey of 302 cybersecurity leaders, March–May 2025. Exact match on percentage, survey size, and dates. CONFIRMED.

**Microsoft Cyber Pulse — 80% of Fortune 500 companies have active AI agents built with low-code/no-code tools; 29% of employees have turned to unsanctioned agents**
Source: Microsoft Security Blog, "80% of Fortune 500 use active AI Agents: Observability, governance, and security shape the new frontier" (February 10, 2026). Both percentages confirmed exact. Industry breakdown (software 16%, manufacturing 13%, financial institutions 11%, retail 9%) confirmed exact. CONFIRMED.

**IBM Cost of Data Breach 2025 — shadow AI breaches cost $670,000 more than standard incidents ($4.63M average)**
Source: IBM "Cost of a Data Breach Report 2025," Ponemon Institute. Both the $670K premium and the $4.63M average confirmed. CONFIRMED.

**Gravitee — 919 respondents; 47.1% of AI agents actively monitored; 21.9% treat agents as independent identity-bearing entities; 82% executive confidence**
Source: Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control" (February 2026). All four statistics confirmed exact. CONFIRMED.

**ConductorOne — 95% of enterprises run AI agents for IT/security tasks; 47% more non-human than human identities; 22% have full visibility**
Source: ConductorOne, "Future of Identity Report 2026," survey of 508 IT and security leaders at U.S. organizations with 1,000+ employees (March 10, 2026). All three statistics confirmed exact. CONFIRMED.

**CSA/Strata Identity — 285 professionals; 28% can trace agent actions to human sponsor; 21% maintain real-time inventory; nearly 80% cannot tell what agents are doing in real time; 40% increasing identity/security budgets**
Source: Cloud Security Alliance and Strata Identity, "Securing Autonomous AI Agents," September–October 2025 survey (published February 5, 2026). All statistics confirmed. CONFIRMED.

---

### Vendor Launches and Product Claims

**Okta ISPM Agent Discovery (February 2026)**
Source: Okta newsroom, "Okta secures the agentic enterprise with new tools for discovering and mitigating shadow AI risks" (February 12, 2026). Browser plugin and OAuth consent event methodology confirmed. Expansion to Microsoft Copilot Studio and Salesforce Agentforce: chapter says "Between February and May 2026"; Okta's roadmap states "fiscal Q1 2027" (= February–April 2026 calendar). The dates are consistent. CONFIRMED.

**Noma Security Agentic Risk Map**
Source: Noma Security press release, "Noma Security Launches Industry-First Agentic Risk Map" (October 2025). All capabilities described (MCP servers, A2A relationships, visual maps, shadow deployment identification) confirmed. CONFIRMED.

**Microsoft Agent 365**
- Generally available May 1, 2026: CONFIRMED
- $15 per user per month standalone: CONFIRMED
- Bundled in Microsoft 365 E7 at $99: CONFIRMED
- Each agent gets its own Microsoft Entra Agent ID: CONFIRMED
- More than 500,000 agents across Microsoft organization: CONFIRMED
- Most widely used: research, coding, sales intelligence, customer triage, HR self-service: CONFIRMED
- Source: Microsoft Security Blog, "Secure agentic AI for your Frontier Transformation" (March 9, 2026); Microsoft Agent 365 product page.

**RSAC 2026 Innovation Sandbox — Token Security and Geordie AI**
Source: RSAC, "Finalists Announced for RSAC Innovation Sandbox Contest 2026." Token Security and Geordie AI confirmed among ten finalists. Competition date March 23 confirmed. Token Security ("AI agents that think, learn, and act autonomously") and Geordie AI ("real-time visibility into agentic footprint with posture and behavior monitoring") descriptions confirmed against their own RSAC finalist announcements. CONFIRMED.

**Onyx Security — $40M, March 12, 2026, Conviction and Cyberstarts, 70+ employees**
Source: BusinessWire, "Onyx Security Launches with $40M in Funding to Build the Secure AI Control Plane for the Agentic Era" (March 12, 2026). All details confirmed — funding amount, date, investors, employee count ("more than 70"), Fortune 500 customer engagement. CONFIRMED.

**Kai — $125M, March 10, 2026**
Source: PR Newswire, "Kai Emerges from Stealth with $125M, Powering Machine-Speed Defense to Outpace AI-Enabled Adversaries" (March 10, 2026). Chapter says "Two days earlier" (before Onyx March 12), dating Kai at March 10. CONFIRMED.

**Imprivata Agentic Identity Management, HIMSS 2026, March 10**
Source: Imprivata press release (March 10, 2026). Short-lived tokens, continuous identity verification, least-privilege enforcement, EHR/clinical system access described. All confirmed. CONFIRMED.

---

### Gartner Market Guide for Guardian Agents (February 25, 2026)

- "Through 2028, at least 80% of unauthorized AI agent transactions will be caused by internal violations of enterprise policies concerning information oversharing, unacceptable use or misguided AI behavior rather than from malicious attacks." CONFIRMED (exact match).
- "By 2029, independent guardian agents will eliminate the need for almost half of incumbent security systems protecting AI agents in over 70% of organizations." CONFIRMED (exact match).
- Three core capabilities: visibility and traceability, continuous evaluation, runtime enforcement: CONFIRMED.
- Representative vendors: PlainID, NeuralTrust, Wayfound, Holistic AI, Opsin: CONFIRMED (each confirmed by vendor press releases acknowledging inclusion in the guide).
- AI governance spending: $492M in 2026, surpassing $1B by 2030: CONFIRMED (Gartner press release, February 17, 2026).

---

### OpenClaw Incidents

**Meta ban — TechBuzz, "Meta Bans Viral AI Tool OpenClaw Over Security Risks" (February 2026)**
Source exists at techbuzz.ai. CONFIRMED.

**PCWorld — "What's behind the OpenClaw ban wave" (February 2026)**
Source exists at pcworld.com. Coordinated bans by Meta, Google, Microsoft, Amazon documented. CrowdStrike assessment (AI backdoor risk if misconfigured) confirmed via CrowdStrike blog post. "Lethal trifecta" framing confirmed as security researcher terminology in wide use. CONFIRMED.

**Summer Yue incident — Kiteworks, "Meta AI Safety Director Loses Control of Rogue OpenClaw Agent"**
Source exists at kiteworks.com/secure-email/. Summer Yue is Director of Alignment at Meta Superintelligence Labs. Deletion of 200+ emails, agent ignoring stop commands, confirmed across multiple primary sources (Fast Company, SF Standard, TechCrunch, Kiteworks). CONFIRMED.

**OpenAI hired creator — TrendingTopics.eu, February 2026**
Source: Peter Steinberger joined OpenAI on February 14–15, 2026. Confirmed by TechCrunch, CNBC, Sam Altman's X post. OpenAI committed to maintaining OpenClaw as open-source project in a foundation. CONFIRMED.

**China ban — Bloomberg, March 11, 2026**
Source exists: "China Moves to Limit Use of OpenClaw AI at Banks, Government Agencies" (Bloomberg, March 11, 2026). CONFIRMED.

**China CERT — The Register, "China's CERT warns OpenClaw can inflict nasty wounds" (March 12, 2026)**
Source exists at theregister.com. CERT characterized default security configuration as "extremely weak." CONFIRMED.

**China contradiction — Fast Company, "China went crazy for OpenClaw. Now it's working to ban it"**
Source exists at fastcompany.com. Shenzhen and Wuxi subsidies documented. CONFIRMED.

---

### Shane Citations

All Shane Deconinck blog posts cited in the chapter confirmed:
- "Agentic AI: Curated Questions for the Boardroom" (February 8, 2026): confirmed at shanedeconinck.be [^boardroom]
- "AI Agents Need the Inverse of Human Trust" (February 3, 2026): confirmed [^trust-inversion]
- "The Work That's Leaving" (February 27, 2026): confirmed [^work-leaving]
- "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First." (March 5, 2026): confirmed [^google-workspace]
- PAC Framework: trustedagentic.ai [^pac-framework]: confirmed

---

## Issues Found

### Significant

**1. Unsourced "first major vendor" superlative — Microsoft Agent 365**

> "Microsoft Agent 365 (generally available May 1, 2026) is the **first major vendor** to ship a purpose-built agent registry and governance platform."

This claim has no source and cannot be verified externally. No footnote is attached. The Gartner Market Guide (February 25, 2026) already names a representative vendor list that includes PlainID, NeuralTrust, Wayfound, Holistic AI, and Opsin — all purpose-built for agent governance and all in market before Agent 365's GA date of May 1. The "first major" framing is contested by the existence of these vendors, even if Agent 365 is the first at platform scale.

This is the same class of unsourced superlative that was removed from context-infrastructure.md in Session 178, where "first major implementation" was cut from a description of the same Microsoft Agent 365 product. The fix was consistent with the pattern established across the book.

**Fix:** Remove "is the first major vendor to ship a purpose-built agent registry and governance platform" and replace with neutral framing. Suggested: "Microsoft Agent 365 (generally available May 1, 2026) brings purpose-built agent registry and governance into the Microsoft ecosystem at platform scale."

---

## Overall Assessment

The shadow-agent-governance.md chapter is substantively clean. The OpenClaw incident section (the most unusual content in the chapter) is entirely confirmed against named, verifiable sources. All survey data — Varonis, Gartner, Microsoft Cyber Pulse, IBM, Gravitee, ConductorOne, CSA/Strata — checks out exactly. Vendor launch details (Okta, Noma, Onyx, Kai, RSAC, Imprivata, Agent 365 product specs) are accurate. Gartner's market guide findings are quoted precisely.

One fix: the "first major vendor" superlative on Agent 365. This is a single line edit — remove or rephrase the superlative. No re-verification required after this fix.

**Action required:** Cut the "first major vendor" superlative from the Agent 365 introduction sentence. Replace with neutral framing as suggested above.
