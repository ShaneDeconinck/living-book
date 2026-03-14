# Verification Report: agent-incident-response.md

**Session:** 332
**Date:** 2026-03-14
**Verifier:** Sapere Aude
**Draft commit:** d4a22b2
**Status:** ISSUES FOUND — send to Ghosty for factual fixes

---

## Overall Assessment

New chapter. Sources are real documents and real blog posts — the fabrication pattern is not wholesale invention but **grafted specifics**: claims about document content that go beyond or contradict what the sources actually say. Three critical issues, four significant issues, four minor issues. Chapter cannot be approved until at least C1–C3 and S1–S2 are fixed.

---

## Critical Issues

### C1: Adversa AI footnote — wrong source for the $31.43 Operator transaction

**Line 15 / footnote [^adversa-operator]**

The chapter states: "The Operator agent that processed an unauthorized $31.43 transaction — documented in Adversa AI's 2025 security incidents report..."

The $31.43 Operator transaction is **AI Incident Database Incident 1028**, documented February 7, 2025, at incidentdatabase.ai/cite/1028/. It is not verifiably in the Adversa AI 2025 report. The Adversa AI report covers agentic AI incidents (crypto transfers, etc.) but no search or fetch of the report found any mention of the $31.43 amount or the specific Operator agent incident.

Additionally, the Adversa AI URL in footnote [^adversa-operator] is truncated and returns a 404:
- Cited: `adversa.ai/blog/adversa-ai-unveils-explosive-2025-ai-security-incidents-report`
- Working URL: `adversa.ai/blog/adversa-ai-unveils-explosive-2025-ai-security-incidents-report-revealing-how-generative-and-agentic-ai-are-already-under-attack/`

The category label "unauthorized autonomous action incidents" cannot be verified as terminology in the Adversa AI report.

**Fix:** Correct the source attribution to AIID Incident 1028 (incidentdatabase.ai/cite/1028/). Fix the Adversa AI URL. Remove or verify the category name.

---

### C2: CoSAI IR Framework date wrong by four months

**Line 53 / footnote [^cosai-ir]**

The chapter states: "CoSAI's AI Incident Response Framework, adapted from the NIST lifecycle and published in July 2025..."

The CoSAI AI Incident Response Framework V1.0 was published/announced **October–November 2025** (CoSAI blog: October 30, 2025; press release: November 18, 2025). The July 2025 OASIS announcement was for a different document: the "Preparing Defenders of AI Systems" whitepaper and "Principles for Secure-by-Design Agentic Systems."

**Fix:** Change "July 2025" to "October 2025" (or "late 2025") in both line 53 and footnote [^cosai-ir].

---

### C3: CoSAI five agent-specific categories do not exist as stated

**Line 53**

The chapter states: "CoSAI...identifies five agent-specific incident categories: prompt injection, data poisoning, unauthorized automation, excessive privilege use, and tool abuse."

The CoSAI framework organizes incidents into five **domain buckets**: Data Incidents, Model Incidents, Deployment Incidents, Infrastructure Incidents, and User Interaction Incidents. The specific named list of "prompt injection, data poisoning, unauthorized automation, excessive privilege use, and tool abuse" does not appear as a discrete enumerated taxonomy in the framework. Prompt injection appears under Deployment Incidents; data poisoning under Data Incidents — but "unauthorized automation," "excessive privilege use," and "tool abuse" as three named CoSAI categories cannot be verified.

This is attribution collapse: real terms from the document assembled into a list that is not in the document.

**Fix:** Remove or replace the five-category list. Either describe the actual CoSAI domain structure (five domain buckets) or remove the enumeration. If specific agent categories exist in the document, cite the exact location.

---

## Significant Issues

### S1: NIST IR 8596 — two content claims not found in document

**Lines 19 and 73 / footnote [^nist-ir-8596]**

The bibliographic details are accurate: NIST IR 8596, "Cyber AI Profile," preliminary draft December 16, 2025, public comment closed January 30, 2026. The document exists.

However, two specific content claims cannot be verified:

**(a) Line 19:** "the standard NIST incident response lifecycle... applies, but each phase requires agent-specific tooling" — this general framing is supportable but does not specifically cite 8596 for agent-specific guidance.

**(b) Line 73:** "Explicitly covers excessive autonomy in AI agents as an incident category" — "excessive autonomy in AI agents" as a named incident category was not found in the document. The document covers securing AI systems and AI-enabled cyber defense, but this specific category name is unverified.

**(c) Line 73:** "recommends dedicated communication lines for AI risks to accelerate escalation" — this specific recommendation was not found in the document.

**Fix:** Remove both specific content claims (b) and (c) from line 73, or cite the exact section in NIST IR 8596 where these appear. The footnote is accurate; the body text overclaims.

---

### S2: Microsoft blog — "comparable to phishing" claim not found

**Line 75 / footnote [^msft-prompt-abuse]**

The Microsoft Security Blog post exists at the cited URL (March 12, 2026). The post names Defender for Cloud Apps, Purview DLP, and Microsoft Sentinel — confirmed.

However: "The playbook covers detection telemetry... comparable in frequency and impact to phishing" — the phrase "comparable in frequency and impact to phishing" was not found in the article. This specific framing appears to be fabricated.

**Fix:** Remove "comparable in frequency and impact to phishing" from line 75. The post frames prompt injection as an operational failure mode requiring dedicated IR procedures — that framing is supportable. The phishing comparison is not.

---

### S3: OWASP categories possibly misattributed

**Line 71 / footnote [^owasp-ir-guide]**

The chapter attributes to the **GenAI IR Guide 1.0 (mid-2025)** the following coverage: "agent behavior hijacking, tool misuse and exploitation, and identity/privilege abuse."

These three category names ("Agent Behavior Hijacking," "Tool Misuse and Exploitation," "Identity and Privilege Abuse") appear in the **OWASP Top 10 for Agentic Applications** (December 2025) — a separate document. They may also appear in the GenAI IR Guide, but the evidence from verification is that these labels are associated with the Agentic Top 10, not the IR Guide.

**Fix:** Verify which document uses these category names. If they are from the Agentic Top 10, attribute to that document. Do not attribute both to [^owasp-ir-guide].

---

### S4: FINOS identifier wrong

**Footnote [^finos-mi23]**

The chapter uses the identifier "MI-23." The correct FINOS AIR Framework identifier is **AIR-PREV-023**, not "MI-23." The document title and URL are correct; the identifier format is wrong.

Additionally: "coordinated notification to downstream workloads" as a specified required response capability — this exact phrase was not found in the AIR-PREV-023 document. The document covers cascade rotation and automated revocation separately, but "coordinated notification to downstream workloads" as a named required response capability cannot be confirmed.

**Fix:** Change "MI-23" to "AIR-PREV-023" in footnote [^finos-mi23]. Remove or verify "coordinated notification to downstream workloads" against the actual document text.

---

## Minor Issues

### M1: Replit incident title paraphrased as if exact

**Footnote [^replit-incident]**

The chapter cites: "Replit Agent Executes Destructive Commands During Code Freeze."

The actual AIID title (Incident 1152) is: "LLM-Driven Replit Agent Reportedly Executed Unauthorized Destructive Commands During Code Freeze, Leading to Loss of Production Data."

The footnote presents a paraphrase as a title. Should either use the exact title or describe it as a description rather than title.

**Fix:** Update footnote [^replit-incident] to use the actual AIID title, or change to a description format (e.g., "incident involving Replit agent executing destructive commands during a code freeze, AIID #1152").

---

### M2: Security Boulevard field enumeration overstated

**Line 25 / footnote [^secboulevard-forensics]**

The chapter says Security Boulevard "identifies the minimum required audit record: agent identity (including tenant and delegating principal), authorization scope, delegated authority chain, and a reference to the reasoning trace that preceded the action."

The article (March 10, 2026) actually says: "Every AI action should include identity-bound metadata. This includes the AI agent identity, tenant context, delegation status, and authorization scope associated with the action."

The chapter's formulation introduces "delegating principal," "delegated authority chain," and "a reference to the reasoning trace" as minimum fields — none of these appear as minimum required fields in the source. The article discusses reasoning traces in a broader context, not as a minimum required audit field.

**Fix:** Align the field list with the source. The source supports: agent identity, tenant context, delegation status, authorization scope. The other formulations are additions not sourced to Security Boulevard.

---

### M3: PAC Framework quote capitalization and attribution

**Line 57 / footnote [^pac-framework]**

The chapter quotes: "If the chain isn't mapped before the incident, it's too late to draw one after."

The PAC Framework text reads: "if the chain isn't mapped before the incident, it's too late to draw one after" — lowercase "if."

If presented as a verbatim quote (in quotation marks), the capitalization should match the source. Additionally, attributing the quote to "Shane Deconinck" personally is an overreach: it appears as an unlabelled bullet point in framework documentation, not as a named personal statement.

**Fix (optional/minor):** Either use lowercase "if" in the quote, or convert to paraphrase without quotation marks. Attribution to "PAC Framework" (document) rather than "Shane Deconinck" (person) would be more accurate.

---

### M4: Strata Identity — specific phrases may not be verbatim

**Lines 47–47 / footnote [^strata-analysis]**

The Strata Identity article exists (January 19, 2026). The substance is accurately characterized. However, the specific phrasing "long-lived standing credentials" as a single phrase and "dynamic, ephemeral permissions enforced at runtime" may not appear verbatim in the article body.

**Fix (minor):** If these are paraphrases (no quotation marks), no change needed — the substance is fair. If presented as direct quotes, verify the exact wording.

---

## Confirmed Clean

- NIST IR 8596 bibliographic details (title, date, comment period close)
- Microsoft Security Blog post existence, date, and product names (Defender for Cloud Apps, Purview DLP, Sentinel)
- Security Boulevard article existence and general concept
- OWASP GenAI IR Guide 1.0 URL and publication (July 28, 2025 — "mid-2025" acceptable)
- OWASP Agentic Top 10 URL and "over one hundred security researchers" claim
- CoSAI GitHub repo (cosai-oasis/ws2-defenders) — confirmed
- CoSAI CACAO playbooks — confirmed in document
- FINOS AIR-PREV-023 existence and document title
- Strata Identity article existence and substance
- PAC Framework quote existence and location
- Three IR phases structure (blast radius, containment, root cause)
- Infrastructure maturity table I1–I5 (no external claims to verify)
- NIST lifecycle phases (Preparation, Detection, Analysis, Containment, Eradication, Recovery) — standard
- Replit incident substance (code freeze, destructive commands, data loss) — confirmed via AIID

---

## Issue Summary

| ID | Severity | Location | Issue |
|----|----------|----------|-------|
| C1 | Critical | Line 15, [^adversa-operator] | $31.43 transaction source is AIID not Adversa AI; URL truncated/404; category name unverified |
| C2 | Critical | Line 53, [^cosai-ir] | CoSAI date wrong: July → October/November 2025 |
| C3 | Critical | Line 53 | CoSAI 5 named categories do not exist as stated in document |
| S1 | Significant | Line 73, [^nist-ir-8596] | Two NIST 8596 content claims not found: "excessive autonomy" category and "dedicated communication lines" |
| S2 | Significant | Line 75, [^msft-prompt-abuse] | "Comparable in frequency and impact to phishing" not found in Microsoft post |
| S3 | Significant | Line 71, [^owasp-ir-guide] | Agent behavior hijacking etc. may belong to Agentic Top 10, not IR Guide |
| S4 | Significant | [^finos-mi23] | "MI-23" should be "AIR-PREV-023"; "coordinated notification to downstream workloads" unverified |
| M1 | Minor | [^replit-incident] | Incident title paraphrased; use AIID #1152 exact title |
| M2 | Minor | Line 25, [^secboulevard-forensics] | Field list overstated; source supports only 4 fields |
| M3 | Minor | Line 57, [^pac-framework] | Quote capitalization; attribution to document not person |
| M4 | Minor | Lines 47, [^strata-analysis] | Specific phrasing may not be verbatim |
