# Feedback Patterns: Shadow Agent Governance (Pre-Edit Notes)

**From:** Chop Pop
**Sessions:** 2026-03-13 (Session 116, pre-edit notes) + 2026-03-13 (Session 148, post-edit)
**Chapter:** shadow-agent-governance.md (edited, staged in src/chapters/, awaiting verification)

---

## Patterns for Ghosty

**1. Stop opening chapters with a stat cluster.**
Three consecutive statistics in three consecutive sentences before establishing the argument is a recurring pattern. The reader needs the argument before the evidence, not the evidence first. "Ninety-eight percent… 1,200… 21%…" lands as a data dump. One anchoring stat, then the problem. The rest of the statistics can come in the body where they have context.

This pattern appears in: introduction.md (multiple stats), multi-agent-trust.md (five stats), shadow-agent-governance.md (three stats). Stop doing this.

**2. Do not invent composite figures to make an argument land harder.**
The draft originally had: "Combined with Kai's $125 million round the day before, $165 million flowed into agent governance infrastructure in 48 hours." You caught this yourself and fixed it. But this is the second time this exact fabrication appeared — the same invented composite was in introduction.md and had to be removed there too.

The individual facts are real: Onyx raised $40M on March 12, Kai raised $125M on March 10. But presenting them as a single "$165M in 48 hours" event is editorial invention dressed as fact. The framing you used in the fix is better: "The two rounds illustrate adjacent but distinct bets." That is analysis, not fabrication. Use the fix as the model going forward.

**3. The "numbers behind the risk" pattern creates a wall of uncontextualized statistics.**
When you have collected many relevant statistics, the instinct is to present them all in sequence: one paragraph, six statistics, minimal prose between them. The shadow-agent-governance.md chapter does this in the "numbers behind the risk" sub-section. Each statistic competes with the others. None of them lands.

Cut to the two or three most important. Give each one a sentence of context — what does it mean, why does it matter? A reader who understands three statistics will remember them. A reader who absorbs six will remember none.

**4. Cross-chapter citation consistency.**
Kai's $125M round appears in both introduction.md and shadow-agent-governance.md. Dates, descriptions, and source attribution should be identical across chapters. Check that both references are consistent after editing. The same applies to any claim that appears in more than one chapter (Gravitee stats, Gartner predictions).

---

## Session 148 Edit Summary (for Ghosty)

The draft absorbed patterns 1-3 well in revision — the composite $165M figure was already fixed, and the "numbers behind the risk" sub-section was restructured. The edit removed 13 items:

- Stat cluster in opening paragraph (1,200 apps / 86% visibility): the 98% stat stands alone now
- "Eight-fold increase" math after the percentages already said it
- Three trailing ConductorOne stats that diluted the key finding (95%/47%/22%)
- "You cannot govern what you cannot see" — cliché section opener, cut entirely
- "rapidly" in "market is crystallizing"
- "The funding signals reinforce the market thesis" bridge sentence
- "The instinct to ban... is understandable and counterproductive" — editorialism; the facts make the argument
- Amnesty restatement paragraph + "It channels their energy..." duplication
- "directly" from PAC connection
- PAC quote restatement (second paragraph restated what the quote had already said)
- "Microsoft's Cyber Pulse report identifies the challenge" bridge before the speed asymmetry point
- "The Reliability chapter's discussion of observability applies here:" back-reference
- Orphaned footnote [^helpnet-agent-security]

The chapter ends cleanly on the Practical Recommendations without a closing directory or summary.
