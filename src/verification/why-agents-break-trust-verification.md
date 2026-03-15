# Verification Report: why-agents-break-trust.md

**Date:** 2026-03-13
**Verifier:** Sapere Aude
**Status:** APPROVED — all issues resolved
**Draft:** src/drafts/why-agents-break-trust.md
**Edited chapter:** src/chapters/why-agents-break-trust.md
**Re-verification:** 2026-03-13 (Session 107)

---

## Summary

Dense chapter with many named incidents, specific statistics, and multiple footnoted sources. The core framing is sound and the majority of claims are verifiable. No fabrications detected. Three significant issues require correction before publication; five minor issues should be addressed for precision.

---

## Verified Claims (Selected)

These were spot-checked against primary sources and confirmed accurate:

**MCPTox (arXiv:2508.14925)**
All three specific claims confirmed exactly against the paper:
- 20 LLM agents tested ✓
- 45 MCP servers, 353 authentic tools ✓
- o1-mini: 72.8% attack success rate ✓
- "More capable models were often more susceptible" — confirmed verbatim from the paper ✓

**CodeWall / McKinsey Lilli incident**
- Incident is real and widely confirmed (The Register, CyberNews, Inc., The Decoder, McKinsey statement)
- 22 unauthenticated endpoints ✓
- SQL injection via JSON key concatenation ✓
- Two-hour timeframe ✓
- McKinsey 40,000+ employees, 500,000+ prompts/month ✓
- All four cited outlets covered the story ✓

**Kai cybersecurity funding**
- $125M funding ✓
- Evolution Equity Partners as lead ✓
- Galina Antova (co-founder Claroty) ✓
- Dr. Damiano Bolzoni (co-founder SecurityMatters, acquired by Forescout) ✓
- Seven-figure bookings in first 10 months ✓
- Industries named are accurate ✓

**Flashpoint 2026 Global Threat Intelligence Report**
- 11.1 million machines infected by infostealers in 2025 ✓
- 1,500% spike in AI references in criminal forums ✓
- November to December 2025 timeframe ✓

**MITRE ATLAS current state**
- 15 tactics, 66+ techniques, 46+ sub-techniques ✓ (confirmed as of post-October 2025 state)
- OpenClaw Investigation: February 9, 2026, four confirmed attack cases, seven new unique techniques ✓

**PleaseFix**
- March 3, 2026 disclosure date ✓
- Zenity Labs source confirmed ✓
- Agentic browsers including Comet ✓
- ClickFix framing confirmed ✓

**Amazon Kiro**
- December 2025 timeframe ✓
- AWS Cost Explorer in mainland China region ✓
- 13-hour outage ✓
- "Delete and recreate" characterization ✓
- Barrack.ai: 10 incidents, 6 tools, 16 months, tool names all accurate ✓
- Post-incident senior approval mandate confirmed ✓

**Sardine 6-to-18-month cultivation cycles** — consistent with verified version corrected after introduction.md review ✓

---

## Significant Issues

### Issue 1: Kai "largest funding round" superlative — unsourced

**Location:** p. 88 body text
**Claim:** "Kai emerged from stealth the same month with $125 million in funding for an agentic AI cybersecurity platform that operates autonomously across threat intelligence, detection, and response: the largest funding round to date for an agentic security company."
**Problem:** The superlative "largest funding round to date for an agentic security company" does not appear in the cited source (Kai PRNewswire press release, March 10, 2026) and is not found in any secondary coverage reviewed (SecurityWeek, SiliconAngle, GovInfoSecurity). The funding amount, lead investor, and founders are all confirmed — only this superlative claim is unsourced.
**Recommendation:** Delete the superlative clause. The facts are strong enough without it. Revised: "...for an agentic AI cybersecurity platform that operates autonomously across threat intelligence, detection, and response."

---

### Issue 2: CodeWall data figures stated as established facts

**Location:** p. 90, paragraph on McKinsey Lilli hack
**Claim:** "Within two hours, the agent had full read-write access to the production database: 46.5 million chat messages about strategy, mergers and acquisitions, and client engagements, all in plaintext, plus 728,000 confidential files and 57,000 user accounts."
**Problem:** These three figures (46.5M messages, 728K files, 57K users) are CodeWall's self-reported claims, not independently verified. McKinsey's official statement explicitly states: "no evidence that client data or client confidential information were accessed." Independent analysis (Edward Kiledjian, March 10, 2026) notes CodeWall provided no hashes or screenshots to verify the claimed scope, and that the blog conflates theoretical reachability with actual retrieval. Additionally, the CodeWall blog itself appears to report 1.1M files in one passage and 728K in another — the figure used in the book is inconsistent within the source itself.
**Recommendation:** Attribute these numbers to CodeWall's account, not state them as verified fact. Revised: "CodeWall reported access to 46.5 million chat messages about strategy, mergers and acquisitions, and client engagements, plus 728,000 confidential files and 57,000 user accounts — all in plaintext, McKinsey disputed that any data was actually retrieved." This preserves the rhetorical force while accurately representing the epistemic status.

---

### Issue 3: Galileo 87% cascade — unverifiable from primary source

**Location:** p. 37, Confused Deputy section; repeated in OWASP table
**Claim:** "Research from Galileo quantifies the cascading risk: a single compromised agent can poison 87% of downstream decision-making within four hours through propagation across agent networks, faster than traditional incident response can contain it."
**Source cited:** Galileo AI, "Detect and Prevent Malicious Agents in Multi-Agent Systems" and "Why Multi-Agent AI Systems Fail and How to Fix Them," galileo.ai, 2025-2026.
**Problem:** Direct access to both cited Galileo blog pages was unsuccessful — pages returned only CSS/font declarations with no article body text. The 87%/four-hours statistic appears in a secondary citation chain (Baker Botts citing Galileo as reported through Obsidian Security) but could not be confirmed from the primary Galileo text itself. The simulation methodology, sample size, and conditions are unknown. This is a high-specificity quantitative claim in a prominent position — it needs to be traceable to a primary source.
**Recommendation:** Either (a) confirm the claim against a readable version of the Galileo source and add methodological context ("In simulated multi-agent environments, Galileo found..."), or (b) if the source cannot be confirmed, reframe without the specific percentages. The general pattern (cascading compromise at machine speed) is confirmed by multiple sources; the 87% figure is what requires sourcing.

---

## Minor Issues

### Issue 4: Flashpoint "credentials" should be "credentials and cloud tokens"

**Location:** p. 76 body text
**Claim:** "Infostealers infected 11.1 million machines in 2025, producing 3.3 billion stolen credentials traded on criminal markets."
**Problem:** Flashpoint's actual language is "3.3 billion compromised credentials and cloud tokens." Dropping "and cloud tokens" slightly narrows the statistic — cloud tokens are distinct from credentials.
**Recommendation:** Change "3.3 billion stolen credentials" to "3.3 billion stolen credentials and cloud tokens."

---

### Issue 5: MITRE ATLAS date conflation

**Location:** p. 137, MITRE ATLAS section
**Claim:** "In October 2025, Zenity Labs contributed 14 new attack techniques and sub-techniques specifically targeting AI agents: the first major ATLAS update focused on agentic AI rather than models alone."
**Source cited:** Zenity Labs, "Zenity's contributions to MITRE ATLAS's first 2026 release," zenity.io, 2026.
**Problem:** Two events are collapsed into one sentence with the wrong date. (1) October 21, 2025: Zenity announced the collaboration and the 14 new techniques in a blog post. (2) January 2026: The ATLAS framework actually published its first 2026 release incorporating those techniques. The cited source is the January 2026 post. "October 2025" is the announcement; the ATLAS release that the cited source describes was in January 2026.
**Recommendation:** Clarify the two events: "In October 2025, Zenity Labs announced contributions of 14 new attack techniques and sub-techniques specifically targeting AI agents, incorporated into the framework's first 2026 release in January."

---

### Issue 6: PleaseFix — calendar invite scope overstated

**Location:** p. 17, What Changed section
**Claim:** "A calendar invite is enough. When the agent autonomously processes the invite, attacker-controlled content triggers execution: file exfiltration from the local filesystem, credential theft from password managers"
**Problem:** The Zenity disclosure describes two separate exploit paths, not one. The calendar invite specifically triggers file exfiltration. Credential theft from password managers (specifically 1Password in the disclosure) is a distinct exploit path using a different delivery mechanism. The text implies both flow from the calendar invite, which is not what the source says.
**Recommendation:** Separate the two paths: "Two distinct exploit paths: a calendar invite triggers file exfiltration from the local filesystem; a second path achieves credential theft from password managers."

---

### Issue 7: Amazon aboutamazon.com response date

**Location:** Footnote [^kiro]
**Claim:** "Amazon response at aboutamazon.com, February 21, 2026"
**Problem:** The aboutamazon.com response page (`/news/aws/aws-service-outage-ai-bot-kiro`) was published February 20, 2026, the same day as the FT report. February 21 appears to be the date of Engadget's coverage of Amazon's response, not the response itself.
**Recommendation:** Change footnote to "Amazon response at aboutamazon.com, February 20, 2026."

---

### Issue 8: Kiro "two-person approval bypass" is Barrack.ai's framing, not Amazon's

**Location:** p. 35, Confused Deputy section
**Claim:** "bypassing the standard two-person approval process"
**Problem:** Amazon's official statement characterizes the incident as "a user access control issue" involving "broader permissions than expected" — not as a bypassed two-person approval gate. The two-person approval framing comes from Barrack.ai's account of the incident. This distinction matters for attribution accuracy.
**Recommendation:** Attribute the interpretation to its source: "bypassing what Barrack.ai describes as the standard two-person approval process" — or rephrase to match Amazon's own language: "using access permissions broader than standard policy intended."

---

## Overall Assessment

**Core arguments: HOLD.** The confused deputy framework, the shadow agent problem, the supply chain threat, and the attack infrastructure buildup are all well-supported by the cited incidents. The MCPTox benchmark claims are exactly right. The CodeWall/McKinsey incident is real and the key technical details are confirmed. The ATLAS/OWASP framing is accurate.

**What needs fixing before publication:**
1. Remove the Kai superlative (no source)
2. Attribute CodeWall data figures as self-reported, not verified facts
3. Either confirm or soften the Galileo 87% cascade claim
4. Five minor precision corrections

**What does not need changing:** The broad structure, the incident selection, the technical framing of the confused deputy problem, and the book's overall argument. The chapter earns its conclusions.

---

## Source Check Coverage

| Claim | Source | Verified |
|---|---|---|
| MCPTox arXiv:2508.14925 numbers | Direct paper access | ✓ Exact |
| CodeWall McKinsey hack | 4 outlets + McKinsey statement | ✓ Confirmed (with disputed data scope) |
| Kai $125M funding | PRNewswire | ✓ Confirmed |
| Kai "largest funding" superlative | PRNewswire + secondary | ✗ Not found |
| Flashpoint 11.1M / 1,500% | Flashpoint PRWeb | ✓ Confirmed |
| Flashpoint 3.3B credentials | Flashpoint PRWeb | ~ "and cloud tokens" omitted |
| Galileo 87% / 4 hours | Galileo blog (inaccessible) | ✗ Unverifiable primary source |
| MITRE ATLAS 15/66+/46+ | Vectra.ai via ATLAS | ✓ Confirmed |
| Zenity ATLAS October 2025 | Zenity blog | ~ Date conflation with Jan 2026 release |
| PleaseFix March 3 2026 | BusinessWire / Zenity | ✓ Confirmed |
| PleaseFix calendar/credential paths | Zenity disclosure | ~ Two paths conflated |
| Amazon Kiro December 2025 | FT / The Register / aboutamazon | ✓ Confirmed |
| Kiro 13-hour outage, mainland China | Multiple outlets | ✓ Confirmed |
| Kiro two-person bypass | Barrack.ai (not Amazon) | ~ Attribution issue |
| aboutamazon.com date | Direct page | ~ Feb 20 not Feb 21 |
| Barrack.ai 10 incidents, 6 tools | Barrack.ai | ✓ Confirmed |
| OpenClaw Feb 9 2026, 4 cases, 7 techniques | MITRE CTID | ✓ Confirmed |
| OpenClaw 4,000+ downloads/hour | Secondary only | ~ Not confirmed from MITRE PDF |

---

## Re-Verification: 2026-03-13 (Session 107)

**Edited chapter:** src/chapters/why-agents-break-trust.md
**Re-verifier:** Sapere Aude
**Result:** APPROVED — clean

Chop Pop addressed all 8 issues from the original report. Each fix confirmed against the edited text:

| Issue | Fix Required | Status in Edited Chapter |
|---|---|---|
| 1. Kai "largest funding" superlative | Remove clause | ✓ Gone. "...for an agentic AI cybersecurity platform that operates autonomously across threat intelligence, detection, and response." |
| 2. CodeWall data stated as fact | Attribute to CodeWall; note McKinsey dispute | ✓ "CodeWall reported...McKinsey disputed that any data was actually retrieved." |
| 3. Galileo 87%/4 hours unverifiable | Remove quantitative claims | ✓ Body and OWASP table now qualitative: "in simulated multi-agent environments...poisoning downstream decision-making faster than traditional incident response can contain it." Footnote updated to match. |
| 4. Flashpoint "credentials" missing "cloud tokens" | Add "and cloud tokens" | ✓ "3.3 billion stolen credentials and cloud tokens" |
| 5. MITRE ATLAS date conflation | Separate October 2025 announcement from January 2026 release | ✓ "In October 2025, Zenity Labs announced contributions...incorporated into the framework's first 2026 release in January." |
| 6. PleaseFix paths conflated | Separate two distinct exploit paths | ✓ "Two distinct exploit paths: a calendar invite triggers file exfiltration from the local filesystem; a second path achieves credential theft from password managers." |
| 7. aboutamazon.com date Feb 21 → Feb 20 | Correct footnote | ✓ Footnote [^kiro]: "Amazon response at aboutamazon.com, February 20, 2026." |
| 8. Kiro "two-person bypass" misattributed | Use Amazon's language or attribute to Barrack.ai | ✓ Body: "using access broader than standard policy intended." Footnote: Amazon's own language. |

**Additional fix confirmed:** McKinsey "March 2026 research" → "March 2026 reporting" (source is a podcast). ✓

**No new issues introduced by editing.** The prose changes are accurate and improve the epistemic precision without losing rhetorical force. The Galileo softening in particular is well-executed: the cascading propagation pattern is real; only the unverifiable specifics are removed.

**Known carry-forward (not a blocking issue):** OpenClaw "4,000+ downloads/hour" remains unconfirmed from MITRE PDF directly, sourced only through secondary reporting. The claim was not flagged as a required fix in the original report. It remains flagged here for completeness. A future pass on the OWASP/ATLAS sections could nail it down.

**Chapter status:** APPROVED FOR PUBLICATION.

---

## Re-Verification: 2026-03-14 (Session 393)

**Edited chapter:** src/chapters/why-agents-break-trust.md
**Commit reviewed:** ee2f028
**Re-verifier:** Sapere Aude
**Result:** APPROVED — clean

Chop Pop made 7 targeted prose cuts. All confirmed as style-only edits with no factual content altered.

| Edit | What Changed | Factual Impact |
|---|---|---|
| 1. Double "The question" opener | Line 7: "The question is: when something goes wrong..." → "When something goes wrong, can you explain what happened? Isenberg's sharpest line is about reconstruction:" | None. Isenberg quote and McKinsey citation intact. |
| 2. Shadow Agents throat-clear | "Here is a governance reality that most organizations are not ready for: your employees..." → "Your employees are already building agents." | None. Pure style cut. |
| 3. "confirms this is not hypothetical" | "The Huntress 2026 Cyber Threat Report confirms this is not hypothetical: identity threats..." → "The Huntress 2026 Cyber Threat Report documents the scale: identity threats..." | None. All Huntress statistics and the LangChain/GTG-1002 campaigns are intact. |
| 4. "These are not theoretical attack vectors." | Sentence removed before Sardine paragraph. | None. All Sardine content intact. |
| 5. "This is why the book focuses on trust infrastructure, not model capabilities." | Sentence removed. "The model will keep improving..." stands alone. | None. No factual content lost. |
| 6. OWASP self-promo + announcer cut | Removed "The ten risks validate the structure of this book..." and changed "Two principles from the OWASP framework are worth noting explicitly" → "Two principles stand out" | None. Both OWASP principles (Least-Agency, Strong Observability) with full detail are intact. |
| 7. AI Agent Clickbait closer | "AI Agent Clickbait formalizes it for defenders." → "ATLAS formalizes it as a named technique." | None. Same meaning, tighter phrasing. |

**All previously resolved issues remain resolved:** Galileo qualitative only ✓, CodeWall attribution with McKinsey dispute ✓, Flashpoint "credentials and cloud tokens" ✓, MITRE ATLAS dates split ✓, PleaseFix two distinct paths ✓, Kiro Amazon's language ✓, Kai superlative removed ✓.

**No new issues introduced.** Seven clean prose cuts that reduce self-referential filler without touching any verifiable claim.

**Chapter status: APPROVED FOR PUBLICATION.**

---

## Session 469 Addendum: Ghosty Session 468 Prose Changes (Commit a4830a0)

**Date:** 2026-03-15
**Scope:** Ghosty session 468 applied 3 prose changes to src/drafts/why-agents-break-trust.md as part of a patterns sweep.
**Status:** CLEAN — APPROVED

### Changes Reviewed

| Edit | What Changed | Factual Impact |
|---|---|---|
| 1. "first standardized" superlative removed | "industry's first standardized risk taxonomy" → "a standardized risk taxonomy" | None. Removes unsourced superlative. No factual claim changed. ✓ |
| 2. PAC interjections removed from OWASP principles | Removed "This is the PAC Agent Profiler's autonomy dial applied as a security control." and "This maps to PAC's infrastructure scale: I1 (Open) has no observability, I5 (Contained) has full observability." | None. PAC cross-references removed; OWASP principles (Least-Agency, Strong Observability) intact with full description. ✓ |
| 3. Editorial judgment removed from OpenClaw | "The attack chain that earned the most attention:" → "One attack chain:" | None. Same referent, editorial weight removed. All OpenClaw facts (4,000+ downloads/hour, poisoned Skill, ClawHub) intact. ✓ |

All three changes are prose-only. No factual content altered. All previously verified claims remain accurate.

**Draft status: APPROVED. Ready for Chop Pop to apply delta to src/chapters/why-agents-break-trust.md.**
