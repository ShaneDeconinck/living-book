# Feedback Patterns: reliability-evaluation.md

Extracted from Chop Pop pre-read (Session 119) and full read (Session 126).

---

## Pattern 1 (Positive): The Two-Sentence Reversal

The chapter opens: "Reliability is getting easier. That is the problem."

This is the best chapter-opening in the book. It does what a good opening should: state the conventional view, then turn it. Two sentences, no preamble, and the reversal earns the entire chapter that follows.

This works because the reversal is earned, not just claimed. The chapter then spends 3,500 words proving why reliability improvement makes governance harder. The opening plants the seed; the chapter waters it.

**Apply this pattern everywhere:** State the thing most readers believe, then show them why it is wrong. Not "conventional wisdom says X but actually Y." Just X. Then: that is the problem.

---

## Pattern 2 (Positive): The Named Phenomenon

"The 99% problem: an agent that is right 99% of the time is more dangerous than one that is right 80% of the time."

This is how to anchor a counterintuitive claim. Steps:
1. Name the phenomenon ("The 99% problem")
2. State the counterintuitive claim precisely
3. Quantify both sides ("At 80%... At 99%...")
4. Give the punchline: "1% of a million actions is ten thousand failures."

The naming matters. "The 99% problem" is memorable. It gives readers a handle to carry the concept out of the chapter. Compare to how "The Complacency Trap" and "The Paradox of Supervision" work in the next chapter: named phenomena stick.

**Apply this pattern everywhere:** Before introducing a counterintuitive concept, give it a name. The name does not need to be clever. It needs to be precise.

---

## Pattern 3 (Negative): "This Matters for the Book's Argument"

Line 190: "This matters for the book's argument. The industry has built increasingly sophisticated defenses against prompt injection..."

Cut it. The sentence is scaffolding. The next sentence makes the point directly. "The industry has built increasingly sophisticated defenses against prompt injection" is the observation. "This matters for the book's argument" is a stage direction, not writing.

This is the same pattern as "This is significant," "This connects to our earlier discussion," and "It is worth noting here." All of these announce that something is important instead of showing why it is. The showing is the writing. The announcement is the scaffolding.

**Rule:** If you catch yourself writing "this matters because," cut the sentence and start with the because.

---

## Pattern 4 (Negative): "Reliability Connects to Several Other Chapters"

Line 222: "Reliability connects to several other chapters."

Same scaffolding pattern, different form. This sentence announces what you are about to do instead of doing it. The cross-references that follow are useful. Start with them directly.

The correct version: "[Agent Identity and Delegation](agent-identity.md) covers the infrastructure (OBO, DPoP, Verifiable Intent) that makes autonomy progression from A2 to A5 safe..."

The sentence before it does the work of introduction. "Reliability connects to several other chapters" does nothing. It is a hesitation before the actual point.

**Rule:** Cross-reference sections should start with the substance of the connection, not the announcement that connections exist.

---

## Pattern 5 (Negative): Hard-Coded Chapter Numbers in Footnotes

Footnote [^regulatory-landscape]: "See Chapter 5 of this book, 'The Regulatory Landscape'..."
Footnote [^vi-chapter]: "See Chapter 3 of this book..."
Footnote [^identity-chapter]: "See Chapter 3 of this book..."

Three chapter numbers in one chapter. Chapter numbers will break when the book order changes, and book order will change. mdBook supports markdown links. Use them.

Correct form: "[The Regulatory Landscape](regulatory-landscape.md)" or "[Agent Identity and Delegation](agent-identity.md)".

**This is now confirmed across at least six drafts.** It is not a one-chapter problem. It is a book-level habit. Every chapter should audit its footnotes for hard-coded chapter numbers before it reaches edit.

---

## What Is Working

The chapter as a whole is the most structurally rigorous in the book. The PAC mapping table (lines 200-208) is the best table in any chapter: five dimensions, all three pillars, with the critical insight in the last row explicitly named ("only infrastructure-enforced checkpoints survive complacency"). Keep the table intact when editing.

The Bainbridge 1983 / Don Norman 1990 / aviation research arc (lines 86-95) is the strongest sustained argument in the book. Forty years of HCI research, applied cleanly to AI governance without over-claiming. The Lancet colonoscopy study (line 115) is the best unusual citation in any chapter: it earns its spot, it is surprising, and it proves the point more viscerally than any AI study could.

The "What to Do" section is tight and actionable. Keep it intact.
