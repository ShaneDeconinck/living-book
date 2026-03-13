# Feedback Patterns: regulatory-landscape.md

Read as part of Chop Pop Session 128 pre-read. Five patterns.

---

## Pattern 1 (Positive): The runtime classification insight

**"You can classify a tool at build time. You cannot classify an agent whose use case emerges at runtime."**

This is the chapter's best sentence. Two sentences, one contrast, the whole classification problem stated precisely. The reader does not need three more sentences explaining why this matters — the sentence explains itself.

This is how to introduce a structural argument: state the asymmetry directly, then build the chapter around it. The entire EU AI Act section earns its existence because of these two sentences. Everything that follows — multi-purpose problem, Future Society citation, provider/deployer distinction — is elaboration, not discovery.

When a chapter's central insight can be stated in two sentences, put it at the beginning. Do not bury it in the middle of a subsection.

---

## Pattern 2 (Positive): Infrastructure maturity as regulatory readiness

**Location:** Table, lines 245-253 (I1-I5 → regulatory readiness)

Each row says something different. I1 gives the reader a blunt verdict ("Non-compliant for any high-risk use"). I3 specifies which articles it satisfies and which it does not ("Meets Article 12 and partial Article 14. Sufficient for most NIST recommendations"). I5 closes with cross-organizational trust and eIDAS interoperability. The progression is real: each level adds something that changes the compliance status.

This is what a table earns: the rows say genuinely different things, and the reader leaves with actionable intelligence, not a summary of what they just read.

Compare the ATF five-element list (lines 193-200), which has the same structure but no progression — each element is parallel, not cumulative. Tables work. Parallel lists are less interesting. When you have a scale, use a table.

---

## Pattern 3 (Negative): Non-chronological timeline

**Location:** "The Convergence Timeline" section (lines 258-271)

The timeline opens with January 22, 2026, then steps back to February 2025, then jumps to March 6, 2026. The reader has to track the date while also absorbing the content. A timeline that is not in chronological order is not a timeline.

The intent is clear: February 2025 is "already in effect," distinct from upcoming deadlines. But the mechanism for signaling this — inserting it out of sequence — defeats the purpose of a timeline.

Fix: order chronologically, and add a note before the list: "Already in effect as of March 2026:" followed by the February 2025 entry before moving to future dates. Or add a column for status. The reader needs to parse "what must I do" vs "what is already law" — give them a structure for that, not a date anomaly.

---

## Pattern 4 (Negative): The Galileo citation across chapters

**Location:** Footnote [^galileo] (line 328)

This is the fourth chapter using Galileo AI's December 2025 research as evidence for cascading multi-agent failures. It has appeared in why-agents-break-trust, building-the-edge, and now here. Each time, the specific 87%/four-hours statistic was either removed or not included, but the citation anchor remains — carrying the "rapidly poison downstream decisions" claim.

One document cannot be the primary evidence for a claim this central across four chapters. The claim that multi-agent systems cascade failures faster than incident response can contain is real and important. It needs multiple independent sources.

**Note for Sapere Aude:** confirm whether the Galileo "Multi-Agent AI System Failures and Prevention" (December 2025) is a peer-reviewed publication, a research report, or a company white paper. If it is vendor research, it should not be the load-bearing citation for cascading failure claims across four separate chapters.

---

## Pattern 5 (Negative): Vendor blog for a government standard

**Location:** Footnote [^cosais] (line 318)

"NIST SP 800-53 COSAiS (Controls Overlay for Secure AI Systems) adapts federal security controls for single-agent and multi-agent use cases. Referenced in Zenity, 'From Policy Planning to Agentic Action,' March 2026."

Zenity is an agentic security vendor. They are summarizing a NIST document. This is the third chapter with this pattern: context-infrastructure ([^6], TDS article), supply-chain-security (multiple vendor and secondary sources), and now here. When the primary source is a government publication, cite the government publication. The Zenity blog post is marketing copy.

COSAiS is a NIST document. It has a document number and a URL. Cite it directly. If the primary NIST source is not yet publicly available, say so explicitly in the footnote rather than silently substituting a vendor reference.
