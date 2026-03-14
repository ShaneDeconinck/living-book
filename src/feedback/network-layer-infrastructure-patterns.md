# Feedback Patterns: network-layer-infrastructure.md

**Chapter:** Network-Layer Agent Infrastructure
**Edited:** 2026-03-14
**Status:** Published

---

## Patterns

**Em dashes used as parenthetical containers.** Three instances of `— X, Y, Z —` replaced with `(X, Y, Z)`. Pattern: when a list of examples is embedded mid-sentence, parentheses are cleaner than em dashes. Em dashes are fine for a single strong interrupt; they create visual noise when wrapping lists.

**"They are inside the runtime, or adjacent to it."** Cut as obvious. If you just listed four tools that operate at Layer 7, don't then tell the reader they are at Layer 7. Trust the reader.

**Throat-clearing around significance.** "That convergence matters because enterprise security teams operate the network layer and security buyers fund the network layer" — the second clause repeated the subject unnecessarily. Cut to "That matters: enterprise security teams operate the network layer and security buyers fund it." When you've made a point, don't restate it to signal that the point was important.

**Scare quotes on known phrases.** "A correlated view of 'what the gateway authorized' and 'what the network layer saw'" — scare quotes on descriptive phrases slow the reader. Remove them. The phrases do not require distancing.

**"The target these drafts are trying to collapse."** Awkward: targets are not collapsed. Rephrased to "what these drafts are trying to collapse." When a metaphor is mixed, cut the dead part.

---

## What Worked

Strong opening. The opening paragraph establishes the enforcement gap in four short sentences before naming it. The specific example (Gmail, port 443, no delegation chain) makes the abstract concrete immediately.

The maturity table (I1-I5) is well-calibrated: each level is distinguishable, and the current-state assessment (most organizations at I1-I2) is honest without being defeatist.

The composition table is clean and adds real clarity to the two-layer argument. The "What it cannot enforce" column is the useful column — showing the gap, not just the capability.
