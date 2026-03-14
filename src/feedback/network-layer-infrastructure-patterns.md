# Feedback Patterns: network-layer-infrastructure.md

**Chapter:** Network-Layer Agent Infrastructure
**Edited:** 2026-03-15 (updated after Session 396 citation fixes)
**Status:** Published

---

## Patterns

**Em dashes used as parenthetical containers.** Three instances of `— X, Y, Z —` replaced with `(X, Y, Z)`. Pattern: when a list of examples is embedded mid-sentence, parentheses are cleaner than em dashes. Em dashes are fine for a single strong interrupt; they create visual noise when wrapping lists.

**"They are inside the runtime, or adjacent to it."** Cut as obvious. If you just listed four tools that operate at Layer 7, don't then tell the reader they are at Layer 7. Trust the reader.

**Throat-clearing around significance.** "That convergence matters because enterprise security teams operate the network layer and security buyers fund the network layer" — the second clause repeated the subject unnecessarily. Cut to "That matters: enterprise security teams operate the network layer and security buyers fund it." When you've made a point, don't restate it to signal that the point was important.

**Scare quotes on known phrases.** "A correlated view of 'what the gateway authorized' and 'what the network layer saw'" — scare quotes on descriptive phrases slow the reader. Remove them. The phrases do not require distancing.

**"The target these drafts are trying to collapse."** Awkward: targets are not collapsed. Rephrased to "what these drafts are trying to collapse." When a metaphor is mixed, cut the dead part.

**Parenthetical IETF draft expiry dates belong in footnotes, not inline.** "(filed with an expiry of April 12, 2026, indicating first-draft status)" — this is footnote-level detail. Inline parentheticals that explain how to interpret a parenthetical fact slow the reader and signal authorial anxiety about the reader not knowing what draft expiry means. If the expiry date matters, it's in the footnote. Cut the explainer.

**IETF draft boilerplate.** "meaning they represent first or second proposals undergoing IETF review" — if you've already said they are -00 and -01 drafts, don't translate that for the reader. Technical readers know what draft stages mean. Non-technical readers don't need the translation here. Cut.

**Attribution sentence structure.** "was authored by H. Chen (Red Hat) and L. Jalil (Verizon) and proposes" — stacking "was authored by X and Y and proposes Z" requires three mental holds. Lead with what the thing does: "SIRP proposes..." with authors in a parenthetical or footnote. Keeps the reader moving.

**Redundant framing clauses.** "Both were built by different communities, for different threat models, and they do not yet speak the same language." — the enforcement gap was already named in the preceding sentence. "do not yet speak the same language" restates what "enforcement gap" already captures. Cut.

**Verb precision: aim vs. try.** "is what these drafts are trying to collapse" → "is what these drafts aim to collapse." "Trying" is informal and implies effort without result. "Aim" is precise and directional.

---

## What Worked

Strong opening. The opening paragraph establishes the enforcement gap in four short sentences before naming it. The specific example (Gmail, port 443, no delegation chain) makes the abstract concrete immediately.

The maturity table (I1-I5) is well-calibrated: each level is distinguishable, and the current-state assessment (most organizations at I1-I2) is honest without being defeatist.

The composition table is clean and adds real clarity to the two-layer argument. The "What it cannot enforce" column is the useful column — showing the gap, not just the capability.
