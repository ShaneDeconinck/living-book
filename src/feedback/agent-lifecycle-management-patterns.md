# Feedback Patterns: Agent Lifecycle Management

**From:** Chop Pop
**Session:** 2026-03-14

---

## What was cut

### 1. Chapter-index cross-reference paragraph (opening)

The draft opened with a paragraph listing every previous chapter by name ("The previous chapters covered how to identify agents... how to discover ungoverned ones... how to enforce authorization boundaries...") before announcing "This chapter covers the operational gap between those concerns."

Cut in full. The chapter heading and first two sentences already establish the subject. The cross-reference added nothing except bureaucratic scaffolding.

**Pattern:** Self-narrating openers. Master pattern #1. Still appearing.

---

### 2. Restatement at section opening

"Death: Decommissioning" opened with: "Decommissioning is where lifecycle management most consistently fails."

The lede — "Decommissioning that agent takes indefinitely, because nobody planned for it" — already established this. The section opener restated it without adding anything.

Cut. Let the section header name the subject. Let the content make the argument.

**Pattern:** Restatement closers/openers. The same sentence cannot open both the chapter and the section.

---

### 3. Double "you cannot X what you cannot Y" in the same subsection

"Nobody knows they exist" paragraph ended with: "You cannot decommission what you cannot find." Then added: "You cannot govern a lifecycle you cannot see."

Two structurally identical sentences back to back. The first lands. The second is an echo that softens the first. The second also approximates the cliché ("You cannot govern what you cannot see") flagged in the master patterns.

Cut the second. The first carries the argument.

**Pattern:** Cliché. Master pattern #8. Variations still appearing.

---

### 4. Significance announcement before evidence

"The scale of the orphan problem is significant." followed immediately by the Entra Agent ID announcement, which is the evidence of scale.

Cut the announcement. Let the evidence speak.

**Pattern:** "This matters because" scaffolding. Master pattern #3.

---

### 5. Restatement tail on Token Security orphan paragraph

After stating Token Security's approach to orphan management, the paragraph closed with: "The goal is preventing ghost services from lingering with active access."

This restated what was just said. Cut.

**Pattern:** Restatement closers. Master pattern #4.

---

### 6. Dead-weight adverb: "rapidly"

"The lifecycle management tooling landscape consolidated rapidly in early 2026."

"Rapidly" does not add information; the 2026 consolidation of four major platforms in a single year is the evidence of speed. Cut.

**Pattern:** Dead-weight adverbs. Master pattern #6.

---

### 7. Dead-weight adverb: "precisely"

"Okta identified the root cause precisely: authorization outlives intent."

"Precisely" is throat-clearing. The quote that follows is either precise or it is not. Cut.

**Pattern:** Dead-weight adverbs. Master pattern #6.

---

## What worked well

- **Lede**: "An agent gets created in minutes... Decommissioning that agent takes indefinitely, because nobody planned for it." Two sentences. Sets the asymmetry. Earns the chapter.
- **Three bold headers for "Why agents do not die"**: "Nobody knows they exist / Nobody owns them anymore / Nobody knows the dependencies." Parallel structure, each landing on its evidence.
- **Scope drift sequence**: "It gets connected to email. Then to a calendar API. Then to a payment system." Staccato accumulation mirrors the incremental drift it describes.
- **PAC mapping table**: Clean. Spans the right dimensions at each maturity level.
- **What to Do Now**: Five items, all concrete, no caveats.
