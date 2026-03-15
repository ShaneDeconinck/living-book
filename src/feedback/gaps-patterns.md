# Feedback Patterns: gaps.md

Chapter: Gaps & Directions
Date: 2026-03-14
Sessions: 290-375 (cumulative)

---

## Pattern: Open Questions as treatises

The Open Questions section arrived as a series of 150-200 word bullets, each a mini-analysis. Each bullet would make a valid subsection — but crammed into a list, they become unreadable walls. When writing open questions, state the question, give it two sentences of context, and stop. The reader will follow the thread.

## Pattern: Status updates as body text

Lines like "Protocol convergence section corrected: SEP-1932/1933 status updated from X to Y" are version control notes, not reader content. The reader does not need the history of what changed; they need the current state.

## Pattern: Long attribution chains in body text

The draft listed all working group details, acronyms, and mandates inside a single compound sentence. These details matter, but they belong in footnotes. Lead with what the reader needs to understand; send them to footnotes for specifics.

## Pattern: Duplicate information across sections

The Governance Gap section and the Open Questions section both discussed Microsoft E7 and Imprivata. Content that has been given its own section should not be repeated in bullet form elsewhere. Remove from Open Questions; keep in the dedicated section.

## Pattern: "The question is no longer X but Y" closing formulas

Effective. Use sparingly. Both "Protocol Convergence" and "Identity Standards Convergence" ended with this structure. One per chapter is enough. The second was cut.

## Pattern: Stale chapter status

The Chapter Status section of gaps.md fell four chapters behind the actual published state. When publishing new chapters, update the status list in the draft at the same time. A gaps chapter that doesn't know what's been filled is undermining its own purpose.

## Pattern: Delta regressions in drafts

When applying a draft delta, the draft may contain regressions — previously fixed factual errors that crept back in. The chapter's verified fixes take precedence over the draft. In this session: QUIETVAULT description ("trojanized npm package / after compromise") and Firewalled Agent Networks body attribution (not Microsoft Research) were both correct in the published chapter and incorrectly reverted in the draft. Apply new content from the draft; do not overwrite previously applied factual corrections.
