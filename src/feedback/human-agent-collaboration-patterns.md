# Feedback Patterns: human-agent-collaboration.md

Extracted from Chop Pop pre-read (Session 122) and full read (Session 126).

---

## Pattern 1 (Positive): The Progression That Earns Its Conclusion

HITL → HOTL → Infrastructure-in-the-Loop.

This works because each failure is established before the next model is introduced. HITL fails because of scale. HOTL fails because of passive monitoring. Infrastructure-in-the-loop is not presented as "better" — it is presented as the solution to what the previous two models could not solve.

Most multi-part progressions in the book announce the pattern up front and then describe each element. This one builds the case. By the time Infrastructure-in-the-Loop appears, the reader already knows HITL and HOTL failed. The third model lands as the answer to questions the chapter itself raised.

**Apply this pattern whenever comparing approaches:** Do not present three models and say one is better. Present the first model, show where it breaks, present the second as the fix, show where it breaks, then present the third. The reader reaches the conclusion with you, not because you told them.

---

## Pattern 2 (Positive): Two Distinct Failure Modes, Not One

The Complacency Trap and the Paradox of Supervision are named separately and kept separate.

- Complacency is an **attention failure**: the human is capable of evaluating but stops doing so.
- The Paradox of Supervision is a **capability failure**: the human watches, reviews, and approves, but the evaluation is less rigorous than it appears because the underlying expertise is degrading.

This distinction matters and it holds. Most treatments of human oversight reduce both to "complacency." This chapter recognizes they are different governance risks: one is motivation, one is skill. The fix for attention failure is infrastructure that does not depend on vigilance. The fix for capability failure is monitoring review quality (time spent, corrections made, escalation rates) — not just review completion.

**Apply this pattern wherever you see compound failure modes:** Do not bundle two distinct mechanisms under one label because they have the same surface symptom. Name each separately, show the different fix required by each. The distinction earns insight.

---

## Pattern 3 (Negative): Citation Mismatch When Bundling Stats

Line 188: "Zapier reports 89% AI adoption across their organization with 800+ agents deployed internally[^anthropic-coding-trends]."

The footnote is wrong. Zapier data is cited to the Anthropic Agentic Coding Trends Report. The Anthropic report covers Anthropic's own engineering data and industry trends. If Zapier data appears in that report, cite the passage; if not, find the Zapier primary source.

This is what happens when multiple statistics get bundled into a sentence that ends with one footnote: the citation drifts from the last stat to cover all of them, and when the stats come from different sources the footnote is wrong for all but one.

**Rule:** Each specific statistic gets its own footnote. If you cite Zapier data, find the Zapier source.

---

## Pattern 4 (Negative): Hard-Coded Chapter Numbers in Footnotes

Footnote [^complacency-chapter]: "See Chapter 6 of this book, 'Reliability, Evaluation, and the Complacency Trap'..."
Footnote [^vi-chapter]: "See Chapter 3 of this book, 'Agent Identity and Delegation'..."
Footnote [^identity-chapter]: "See Chapter 3 of this book, 'Agent Identity and Delegation'..."
Footnote [^shadow-chapter]: "See Chapter 12 of this book, 'Shadow Agent Governance'..."

Four hard-coded chapter numbers in one chapter. Same problem as reliability-evaluation.md, regulatory-landscape.md, building-the-edge.md, and at least three others.

This is a book-level habit. Every chapter has it. Fix: use mdBook markdown links instead of chapter numbers. "[Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md)" is stable; "Chapter 6" will be wrong the day the order changes.

**Also note:** [^vi-chapter] and [^identity-chapter] both say "Chapter 3" — but Agent Identity is one chapter, not two. If Verifiable Intent is in the identity chapter, they should not be separate footnotes pointing to the same chapter with different labels.

---

## Pattern 5 (Minor): The Informal Chapter Reference in Body Text

Line 3: "The complacency trap chapter diagnosed a problem..."

This works but uses an informal reference. When chapters are in a book, the informal name is fine conversationally; but for a reader who opens this chapter directly, "the complacency trap chapter" is ambiguous. Use the title link: "[Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md) diagnosed a problem."

This is minor — the sentence reads naturally. But since the chapter links appear correctly elsewhere in the chapter (line 141 properly links to reliability-evaluation.md in the body text), the opening should match that convention.

---

## What Is Working

The Controllability Trap section (lines 54-72) is the chapter's most original material. Six governance failures specific to agentic AI, each one distinct, each one mapped to an infrastructure-level fix. If arXiv:2603.03515 checks out, this section stands as some of the most rigorous governance analysis in the book. Do not touch the structure when editing — the six failures build on each other and the summary paragraph (lines 72) closes the sequence cleanly.

The Paradox of Supervision section (lines 168-180) is the chapter's best writing. The key quote lands hard: "effectively using Claude requires supervision, and supervising Claude requires the very coding skills that may atrophy from AI overuse." Keep every word of this section. It is original, sourced, and carries a governance insight that the field has not fully reckoned with.

The autonomy dial framework (lines 74-98) is the most practically useful section in any chapter so far. Five levels, per-task rather than per-agent, with Anthropic data behind the pattern. This will be the section practitioners reference. Keep the structure intact.
