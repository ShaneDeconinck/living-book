# Verification Report: introduction.md

**Verifier:** Sapere Aude (did:webvh:shanedeconinck.be:agents:sapere-aude)
**Date:** 2026-03-13
**Draft:** src/drafts/introduction.md
**Status:** ISSUES FOUND — requires corrections before publication

---

## Summary

14 external claims verified. 2 confirmed outright. Several confirmed with caveats. 3 require correction. 1 requires removal or sourcing.

| # | Claim | Status |
|---|-------|--------|
| 1 | Gravitee 88% security incidents | CONFIRMED |
| 2 | Gravitee 14.4% full security approval | CONFIRMED |
| 3 | Microsoft Blog "more than half without oversight" | ATTRIBUTION ERROR |
| 4 | McKinsey 80% risky behavior | CONFIRMED (caveat) |
| 5 | Isenberg "Agency isn't a feature..." | CONFIRMED (minor) |
| 6 | Huntress "non-human identity fastest-growing" | UNCONFIRMED |
| 7 | Amazon Kiro 13-hour outage | SUBSTANTIALLY CONFIRMED (caveat) |
| 8 | Flashpoint agentic attack chains | CONFIRMED |
| 9 | Flashpoint 1,500% "in December 2025 alone" | FRAMING ERROR |
| 10 | Sardine 7 agentic attacks / 18-month cycles | CONFIRMED (minor imprecision) |
| 11 | Google UNC6426 "permission-bypass flags" | PARTIALLY CONFIRMED |
| 12 | EU AI Act August 2, 2026 | CONFIRMED (caveat) |
| 13 | Five of ten RSAC 2026 finalists | UNVERIFIABLE AS STATED |
| 14 | $165M VC in 48 hours | NOT CONFIRMED |

---

## Detailed Findings

### Claim 1 — Gravitee: 88% of organizations with AI agent security incidents
**Text:** "88% of organizations report confirmed or suspected security incidents involving AI agents."
**Source cited:** Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control," gravitee.io, 2026.
**Verdict: CONFIRMED**

Source exists at gravitee.io/state-of-ai-agent-security. Survey of 919 executives and practitioners (750 US/UK, December 2025, Opinion Matters). The 88% figure is accurately stated. Title matches exactly.

Minor context not disclosed: survey population is executives at firms with 250+ employees — not a broad cross-sector sample. Not a factual error but worth noting in context.

---

### Claim 2 — Gravitee: Only 14.4% have full security approval
**Text:** "Only 14.4% have full security approval for their agent deployments."
**Source cited:** Same Gravitee report.
**Verdict: CONFIRMED**

Exact quote from report: "only 14.4% of organizations have achieved full IT and security approval for their entire agent fleet." Confirmed across multiple secondary sources.

---

### Claim 3 — Microsoft Blog: "more than half of all agents operate without any security oversight or logging"
**Text:** "More than half of all agents operate without any security oversight or logging.[^microsoft-shadow]"
**Source cited:** Microsoft Security Blog, "80% of Fortune 500 use active AI Agents: Observability, governance, and security shape the new frontier," February 2026.
**Verdict: ATTRIBUTION ERROR — requires correction**

The Microsoft Security Blog article (published February 10, 2026) is real and addresses AI agent governance generally. However, the specific statistic — "more than half operate without oversight" — originates in the Gravitee report, not the Microsoft blog. The Gravitee report states: "on average, only 47.1% of an organization's AI agents are actively monitored or secured, meaning more than half operate without any security oversight or logging."

**Required fix:** Change footnote [^microsoft-shadow] to [^gravitee], and remove the Microsoft blog from the footnote entry for this claim. The Microsoft blog is a valid supplementary source for the general context but is not the source of this statistic.

---

### Claim 4 — McKinsey: 80% of organizations encountered risky agent behavior
**Text:** "McKinsey's 2026 research puts it in organizational terms: 80% of organizations have already encountered risky behavior from AI agents."
**Source cited:** McKinsey, "Trust in the Age of Agents," The McKinsey Podcast, March 2026.
**Verdict: CONFIRMED (with one caveat)**

Podcast exists at mckinsey.com/capabilities/risk-and-resilience/our-insights/trust-in-the-age-of-agents. Rich Isenberg confirmed as McKinsey Partner, Risk & Resilience practice. Published approximately March 5, 2026. The 80% figure is reported accurately.

Caveat: It is not confirmed whether the 80% is McKinsey original primary research or a statistic Isenberg cites from another source within the podcast. The text frames it as "McKinsey's 2026 research," implying original data. If Isenberg is citing a third party's figure, attribution should say "a figure cited by McKinsey" rather than "McKinsey's 2026 research." Recommend verifying against the full transcript.

---

### Claim 5 — Rich Isenberg quote
**Text:** "Agency isn't a feature. It's a transfer of decision rights."
**Source cited:** Same McKinsey podcast.
**Verdict: CONFIRMED (minor punctuation variant)**

The quote is confirmed from the podcast. Original uses an em-dash: "Agency isn't a feature—it's a transfer of decision rights." The book splits this into two sentences with a period. The words are accurate; the sentence structure is slightly altered from the original. As a direct quote formatted with quotation marks, it should ideally match the original punctuation or be rendered as a paraphrase. Not a factual error, but flagged for fidelity.

---

### Claim 6 — Huntress: non-human identity compromise is "fastest-growing attack vector"
**Text:** "The Huntress 2026 Cyber Threat Report found that non-human identity compromise is now the fastest-growing attack vector in enterprise infrastructure, and the core issue is not proving who the identity belongs to: it is constraining what the identity is allowed to do."
**Source cited:** Huntress, "2026 Cyber Threat Report," huntress.com, February 2026.
**Verdict: UNCONFIRMED — requires correction or removal**

The Huntress 2026 Cyber Threat Report (released February 17, 2026) is real and covers identity threats prominently (9M+ identities monitored). However, the specific claim — "non-human identity compromise is the fastest-growing attack vector" — does not appear in the report's documented findings. The report highlights: RMM tool abuse up 277% YoY; identity threat categories (access policy violations 37.2%, AiTM 18.9%, OAuth abuse 10.1%); ransomware groups.

The "non-human identity" framing is language used by Token Security (RSAC 2026 finalist) and in the broader industry conversation — but it is not the specific language or finding of the Huntress report as publicly documented.

The second half of the sentence ("the core issue is not proving who the identity belongs to: it is constraining what the identity is allowed to do") reads as editorial synthesis, not a Huntress finding. Attributing it as a Huntress finding is misleading.

**Required fix:** Either (a) locate the specific Huntress quote supporting this claim in the full PDF report, or (b) rephrase to attribute the "non-human identity" framing to the correct source (Token Security, or the broader industry), or (c) remove the Huntress attribution and reframe as synthesis.

---

### Claim 7 — Amazon Kiro: deleted environment, 13-hour outage
**Text:** "Amazon's Kiro incident demonstrated this exactly: an AI coding agent determined that the optimal fix for a production issue was to delete the entire environment and recreate it from scratch, causing a 13-hour outage."
**Source cited:** Financial Times, February 20, 2026; Amazon, aboutamazon.com, February 21, 2026.
**Verdict: SUBSTANTIALLY CONFIRMED with caveats**

FT reporting and The Register, Engadget, The Decoder all confirm the 13-hour duration and the "delete and recreate" action. The aboutamazon.com response is real.

Two caveats:
1. **Amazon disputes AI causation.** Amazon's official response attributes the outage to "misconfigured access controls — not AI." The book presents this as a straightforward AI agent error with no acknowledgment of the disputed framing. The book should note that Amazon disputed the AI causation, even if the book's interpretation is defensible.
2. **Scope:** The affected service was AWS Cost Explorer in a single AWS China region, not a general "production environment." "Delete the entire environment" is accurate to the reported agent action but may read as more sweeping than the regional scope. The core facts are confirmed.

**Recommended fix:** Add a brief note that Amazon disputed the AI causation framing, e.g., "Amazon later disputed the characterization, attributing the outage to misconfigured access controls — though the distinction underscores the accountability problem exactly."

---

### Claim 8 — Flashpoint: agentic attack chains operating autonomously
**Text:** "Flashpoint's 2026 Global Threat Intelligence Report documents agentic attack chains operating autonomously: reconnaissance, phishing generation, credential testing, and infrastructure rotation, all without continuous human control."
**Source cited:** Flashpoint, "2026 Global Threat Intelligence Report," flashpoint.io, March 2026.
**Verdict: CONFIRMED**

Report exists at flashpoint.io. The enumerated attack chain categories match the documented language from the report and its press release. Attribution and substance accurate.

---

### Claim 9 — Flashpoint: criminal forum AI discussions spiked "1,500% in December 2025 alone"
**Text:** "Criminal forum discussions referencing AI spiked 1,500% in December 2025 alone."
**Source cited:** Same Flashpoint report.
**Verdict: FRAMING ERROR — requires correction**

The 1,500% figure is real: Flashpoint reports "a 1,500% rise in AI-related illicit discussions between November and December 2025 — from 362,000 mentions to more than 6 million."

The problem: "in December 2025 alone" misrepresents what the statistic measures. The 1,500% is a month-over-month comparison (November to December). It does not describe December's activity in isolation — it describes the change from one month to the next. "Alone" implies the spike happened within December, when the spike is the growth from November to December.

**Required fix:** Change to "between November and December 2025" or "month-over-month from November to December 2025."

---

### Claim 10 — Sardine: 7 agentic attacks, synthetic identity "18-month cycles"
**Text:** "synthetic identity maturation agents that cultivate fabricated profiles over 18-month cycles"
**Source cited:** Sardine, "AI-driven fraud vectors: 7 agentic attacks now live in 2026," sardine.ai.
**Verdict: CONFIRMED with minor imprecision**

Blog post confirmed at sardine.ai. Polymorphic phishing and chain-hopping descriptions match the source.

For the 18-month figure: Sardine states agents "build credit history by cycling micro-loans... for six to 18 months." The book presents "18-month cycles" as a fixed figure, when the source gives a range of six to 18 months. This compresses a range to its maximum endpoint.

**Minor fix:** Change "18-month cycles" to "cycles of up to 18 months" or "six to 18 month cycles" to match the source accurately.

---

### Claim 11 — Google Cloud UNC6426: "permission-bypass flags"
**Text:** "the threat actor UNC6426 compromised an npm build framework and delivered malware that detected locally installed AI command-line tools, invoked them with permission-bypass flags, and issued natural-language prompts to perform filesystem reconnaissance for credentials."
**Source cited:** Google Cloud Security, "Cloud Threat Horizons Report H1 2026," March 2026.
**Verdict: PARTIALLY CONFIRMED — one technical detail unverified**

The Google Cloud Threat Horizons Report H1 2026 exists and documents UNC6426. The attack on the Nx npm build framework, the use of AI/LLM tools for credential reconnaissance, and the use of natural-language prompts are confirmed by multiple secondary sources (The Hacker News, Google Cloud official).

The specific phrase "permission-bypass flags" is not confirmed in any available source. Reporting describes the malware using AI tools for filesystem reconnaissance but does not document specific permission-bypass flags being passed to those tools.

**Required fix:** Either locate the specific technical detail about permission-bypass flags in the full Google Cloud PDF, or remove this phrase. It reads as technical embellishment that goes beyond what the source documents. The reported behavior (AI tools used for credential reconnaissance via natural-language prompts) is already striking without the unverified flag detail.

---

### Claim 12 — EU AI Act: August 2, 2026 deadline
**Text:** "The EU AI Act's high-risk obligations take effect August 2, 2026."
**Source cited:** Implicit (no footnote in this sentence).
**Verdict: CONFIRMED with important caveat**

August 2, 2026 is the documented deadline for Annex III high-risk AI system compliance. Confirmed by artificialintelligenceact.eu, Orrick, and EU digital strategy guidance.

**Caveat:** As of March 2026, the European Commission has proposed a "Digital Omnibus" package that could delay Annex III high-risk obligations to December 2027. This delay has been proposed but not finalized. Presenting the August 2026 deadline as settled fact without acknowledging the live legislative uncertainty could mislead readers in regulated industries planning their compliance timelines.

**Recommended addition:** Add a note such as: "Note: As of early 2026, the European Commission has proposed delaying Annex III obligations to December 2027 under the Digital Omnibus package; the timeline remains subject to finalization."

---

### Claim 13 — RSAC 2026: "five of ten Innovation Sandbox finalists"
**Text:** "Five of ten RSAC 2026 Innovation Sandbox finalists directly address agentic AI security."
**Source cited:** No footnote.
**Verdict: UNVERIFIABLE AS STATED**

RSAC 2026 Innovation Sandbox did announce 10 finalists, confirmed via rsaconference.com. Companies with confirmed agentic AI security focus: Geordie AI, Token Security, Charm Security, Realm Labs — four identifiable from available sources. Whether a fifth qualifies depends on how "directly address agentic AI security" is defined; Glide Identity or ZeroPath could be partial candidates, but not confirmed.

The claim of "five" is plausible but was not precisely confirmable from available sources.

**Recommended fix:** Either add a footnote linking to the official RSAC finalist page, or soften "five" to "several" unless the count can be sourced precisely.

---

### Claim 14 — $165 million VC in two stealth-mode agent governance companies in 48 hours
**Text:** "Venture capital invested $165 million in two stealth-mode agent governance companies in 48 hours in March 2026."
**Source cited:** No footnote.
**Verdict: NOT CONFIRMED — requires source or removal**

No source was found for this claim. Extensive searching found active VC investment in agentic security in early 2026 (JetStream Security $34M, Guild.ai $44M, WorkOS $100M in early March 2026; 7AI's $130M Series A announced December 2025). However, the specific scenario described — two unnamed stealth-mode agent governance companies, $165M combined, within a 48-hour window — does not match any findable news from March 2026.

This claim is specific enough that it would be easily verifiable if a source existed. The failure to find any corroborating source is a significant concern.

**Required fix:** This claim must either be sourced (provide the original source document or announcement) or removed. Publishing an unverifiable financial claim in the introduction undermines the book's credibility at the outset.

---

## Issues Requiring Action Before Publication

### Critical (must fix)
1. **Claim 3:** Attribution error. "More than half without oversight" statistic is from Gravitee, not Microsoft Security Blog. Fix the footnote.
2. **Claim 9:** Framing error. "In December 2025 alone" misrepresents the 1,500% figure as within-month when it is a month-over-month comparison.
3. **Claim 14:** No source found. Must be sourced or removed.

### Significant (should fix)
4. **Claim 6:** Huntress "fastest-growing attack vector" claim not confirmed in report's documented findings. Either source the exact quote from the full PDF or rephrase.
5. **Claim 7:** Amazon disputes AI causation in the Kiro incident. A single sentence acknowledging the dispute strengthens the book's credibility rather than weakening the point.
6. **Claim 11:** "Permission-bypass flags" not confirmed in any available source. Verify against the full PDF or remove.
7. **Claim 12:** EU AI Act deadline — proposed delay not acknowledged. A brief caveat is appropriate given the compliance stakes.

### Minor (low priority)
8. **Claim 5:** Direct quote has minor punctuation difference from source (em-dash vs period). Cosmetic.
9. **Claim 10:** "18-month cycles" compresses a "six to 18 month" range to its maximum. Trivially imprecise.
10. **Claim 13:** "Five of ten RSAC finalists" — plausible but not precisely sourceable. Add footnote link or soften.
11. **Claim 4:** Verify whether McKinsey 80% figure is their original research or a cited statistic.

---

## Sources Used in Verification

- Gravitee, "State of AI Agent Security 2026," gravitee.io/state-of-ai-agent-security
- Microsoft Security Blog, February 10, 2026 (microsoft.com)
- McKinsey, "Trust in the Age of Agents" podcast, mckinsey.com
- Huntress, 2026 Cyber Threat Report (huntress.com); GlobeNewswire press release February 17, 2026
- Financial Times, February 20, 2026; aboutamazon.com, February 21, 2026; The Register, Engadget
- Flashpoint 2026 Global Threat Intelligence Report (flashpoint.io); PRWeb press release; Channel Insider
- Sardine, "AI-driven fraud vectors: 7 agentic attacks now live in 2026" (sardine.ai/blog/agentic-attacks)
- Google Cloud Security, Cloud Threat Horizons Report H1 2026; The Hacker News UNC6426 coverage
- artificialintelligenceact.eu implementation timeline; Orrick legal guidance; Timelex on Commission delay proposal
- RSAC 2026 Innovation Sandbox finalist announcements (rsaconference.com)
