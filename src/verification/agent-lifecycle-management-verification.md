# Verification: Agent Lifecycle Management

**Session:** 390
**Date:** 2026-03-14
**Verifier:** Sapere Aude
**Draft commit:** HEAD (agent-lifecycle-management.md in src/drafts/)
**Status:** ISSUES FOUND — route to Ghosty for 3 corrections

---

## Summary

The chapter is factually strong. Core quantitative claims (CyberArk ratios, Teleport stats, RSAC finalist details, IETF draft metadata, SailPoint announcement, Gravitee survey numbers) are all verified against primary sources. Three issues were found: one medium (Saviynt phase names), two minor (Okta product claims, Auth0 revocation).

---

## Verified Claims

### CyberArk [^cyberark-82]
- **80:1 ratio**: CyberArk 2025 Identity Security Landscape confirms "more than 80 to 1" (reported as 82:1). ✅
- **42% have privileged access**: Confirmed exact. ✅
- **88% define privileged as human-only**: Confirmed exact: "88% of respondents say that in their organization, the definition of a 'privileged user' applies solely to human identities." ✅
- Source: https://www.cyberark.com/press/machine-identities-outnumber-humans-by-more-than-80-to-1-new-report-exposes-the-exponential-threats-of-fragmented-identity-security/

### CyberArk [^cyberark-96]
- **96:1 in financial services**: Confirmed: "For every human employee, there are 96 machine identities that teams must manage." ✅
- **45% unsanctioned AI agents in financial services**: Confirmed exact: "Nearly half (45%) of financial services organizations admit unsanctioned AI agents are already creating identity silos outside formal governance programs." ✅
- Source: https://www.cyberark.com/resources/blog/96-machines-per-human-the-financial-sectors-agentic-ai-identity-crisis

### Teleport [^teleport]
- **70% grant AI higher access than humans**: Confirmed exact: "70% say AI systems have more access than a human in the same role." ✅
- **4.5x more security incidents**: Confirmed: "enterprises deploying AI systems with excessive permissions are experiencing 4.5x more security incidents." ✅
- Source: Teleport 2026 State of AI in Enterprise Infrastructure Security (press release confirmed via goteleport.com/about/newsroom)

### IETF draft-klrc-aiagent-auth [^klrc]
- **Draft exists**: Confirmed at IETF Datatracker. ✅
- **Date March 2, 2026**: Confirmed. ✅
- **Authors from Defakto Security, AWS, Zscaler, Ping Identity**: Confirmed exactly: Pieter Kasselman (Defakto Security), Jean-François Lombardo (AWS), Yaroslav Rosomakho (Zscaler), Brian Campbell (Ping Identity). "klrc" = first initials of authors' surnames. ✅
- Source: https://datatracker.ietf.org/doc/draft-klrc-aiagent-auth/

### SailPoint [^sailpoint]
- **March 9, 2026 announcement**: Confirmed. ✅
- **Eight platform connectors listed**: All eight confirmed exact in press release: "Microsoft 365 Co-Pilot, Databricks, Amazon Bedrock, Google Vertex AI, Microsoft Foundry, Salesforce Agentforce, ServiceNow AI Platform, and Snowflake Cortex AI." ✅
- Source: https://www.globenewswire.com/news-release/2026/03/09/3251896/0/en/SailPoint-redefines-identity-security-with-new-adaptive-identity-innovations.html

### RSAC Innovation Sandbox 2026 [^rsac-finalists]
- **Token Security finalist**: Confirmed. ✅
- **Geordie AI finalist**: Confirmed in top 10. ✅
- **$5M per finalist**: Confirmed exact: "each of the Top 10 Finalists listed below has been awarded a $5M investment." ✅
- Source: https://www.rsaconference.com/library/press-release/finalists-announced-for-rsac-innovation-sandbox-contest-2026

### Gravitee [^gravitee]
- **47.1% actively monitored**: Confirmed exact. ✅
- **21.9% treat agents as independent identity-bearing entities**: Confirmed exact. ✅
- **919 participants**: Confirmed — Gravitee's own landing page states 919 participants. ✅
- Source: https://www.gravitee.io/state-of-ai-agent-security

### Okta "When Authorization Outlives Intent" [^okta-outlives]
- **Four design principles**: All four confirmed with exact wording in the Okta article. ✅
- Source: https://www.okta.com/blog/ai/ai-agent-security-when-authorization-outlives-intent/

### WIMSE draft [^wimse-agents]
- **Draft exists at version -02**: Confirmed. Current version is -02. ✅
- **Identity Proxy description**: Confirmed: "An intermediary component that can request, inspect, replace or augment agent identity credentials." ✅
- Source: https://datatracker.ietf.org/doc/draft-ni-wimse-ai-agent-identity/

### Microsoft Entra Agent ID [^entra-agent-id]
- **Real announcement**: Confirmed. ✅
- **Dedicated identity type for agents**: Confirmed. ✅
- **Entitlement management processes**: Confirmed: "You can establish controls for agent access lifecycle using features such as entitlement management access packages." ✅
- Note: The Microsoft Learn documentation was last updated February 28, 2026; product is in preview.
- Source: https://learn.microsoft.com/en-us/entra/agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents

### Auth0 Token Vault [^auth0-vault]
- **Token Vault product exists**: Confirmed. ✅
- **Consent flows, token storage, automatic refresh**: All three confirmed. ✅
- See issue M1 below for partial concern on "revocation."

### Shane's blog posts [^trust-inversion], [^profiler]
- Dates and URLs consistent with known Shane blog posts on trustedagentic.ai and blog-source. Not independently web-fetched this session; consistent with prior verified sessions.

---

## Issues Found

### M1 (Minor) — Auth0 Token Vault: "revocation" claim unverified

**Location:** Life: Runtime Governance > Credential rotation section; [^auth0-vault] footnote

**Claim:** "Auth0's Token Vault manages the refresh lifecycle: handling consent flows, storing tokens, refreshing them automatically, and revoking them when the agent's task ends."

**Footnote:** "Token Vault manages OAuth lifecycle for agents: consent flows, token storage, automatic refresh, and revocation."

**Finding:** Auth0 Token Vault documentation confirms consent flows, storage, and automatic refresh. Revocation is not explicitly documented in the available Auth0 Token Vault sources. The footnote asserts revocation as a confirmed capability, which is overstated relative to what the source documents.

**Fix:** Revise footnote to remove "and revocation" unless Auth0 explicitly documents this capability in the Token Vault. Body text should also soften: "handling consent flows, storing tokens, and refreshing them automatically" (drop "revoking them when the agent's task ends" or attribute separately).

---

### M2 (Medium) — Saviynt phase names do not match source

**Location:** "The Emerging Infrastructure" section, Saviynt paragraph; [^saviynt] footnote

**Claim:** "a six-phase framework covering registration, ownership, access management, monitoring, certification, and retirement."

**Footnote:** "Six-phase framework for agent lifecycle governance."

**Finding:** The Saviynt source describes six phases with different names:
1. Registration
2. Ownership Management
3. Entitlement Assignment
4. Lifecycle Governance
5. Retirement
6. Integration with Access Gateways and IGA Systems

The chapter's phase names have partial overlap ("registration" and "retirement" are correct) but "monitoring" (should be "Lifecycle Governance"), "access management" (should be "Entitlement Assignment"), and especially "certification" (which does not map to any Saviynt phase — the 6th phase is "Integration with Access Gateways and IGA Systems") are inaccurate.

"Certification" is a common IGA concept (periodic access reviews) but it does not appear to be a named phase in Saviynt's lifecycle framework for AI agents.

**Fix:** Update the phase list to match source: "registration, ownership management, entitlement assignment, lifecycle governance, retirement, and integration with access gateways and IGA systems." Or summarize at a higher level without naming phases if precision is a concern.

---

### M3 (Minor) — Okta AI Agent Lifecycle product claims not substantiated on cited page

**Location:** "The Emerging Infrastructure" section, Okta for AI Agents paragraph; [^okta-lcm] footnote

**Claim:** "The platform includes Identity Security Posture Management for identifying risky agents, Universal Directory for agent registration and ownership, and Privileged Access management for enforcing least-privilege."

**Footnote:** "Includes Identity Security Posture Management, Universal Directory, and Privileged Access."

**Finding:** The cited Okta page (okta.com/identity-101/ai-agent-lifecycle-management/) describes AI agent lifecycle management in general terms (provisioning, monitoring, adaptation, offboarding). While ISPM, Universal Directory, and Privileged Access are Okta products, the cited article does not explicitly present them as the components of "Okta for AI Agents" in the way the chapter states. These claims may be from a separate Okta product announcement or press release, not the lifecycle management article.

**Fix:** Either locate the specific Okta source that lists ISPM + Universal Directory + Privileged Access as the AI agent platform components and update the footnote, or revise the claim to match what the cited article actually says (general lifecycle management capabilities without the specific product names).

---

## Verdict

**ISSUES FOUND. Route to Ghosty for 3 corrections before routing to Chop Pop.**

- M2 (Saviynt phase names) is medium: the current text misrepresents the source's framework.
- M1 and M3 are minor: footnote overclaims a single capability (Auth0 revocation) and attributes specific product names not substantiated on the cited page (Okta).

No significant issues with the chapter's argument or structure. The overall framing (lifecycle from provisioning to decommissioning, identity infrastructure consolidation) is accurate and well-sourced. Once corrections are applied, the chapter is ready for a second verification pass.
