# Feedback Patterns: Agent Accountability at Scale

## What worked

**The opening vignette is the strongest in the book.** Concrete, specific, immediate. $47,000, alice@company.com, delegated three months ago. The problem is visible before the reader knows they're reading about accountability architecture. Follow this pattern in future chapters: name the amount, name the actor, name the failure mode. Don't tell the reader why it matters — show it.

**"The accountability problem does not scale linearly. It changes in kind."** Perfect standalone line. One declarative sentence that reframes everything that follows. This structure — short thesis sentence after the vignette — works. Use it.

**"Individual audit trails do not compose into organizational accountability."** The kind of sentence that earns its place. It is precise, it is surprising, and it does work that couldn't be done in paraphrase. When you find the right formulation, trust it. Don't dilute with elaboration.

**Infrastructure-enforced governance definition.** "Accountability requirements are not policies agents can ignore but architecture agents cannot bypass." Strong parallel construction. The contrast does the argumentative work without editorializing.

## What was cut and why

**"A coding assistant, a support triage agent, an internal knowledge bot. Governance at this scale is manageable: a human reviews the agent's setup, monitors its behavior, intervenes when something looks wrong."** Cut. The reader knows what single-digit agent governance looks like. These sentences explain the problem before stating it. State the breakpoint; skip the hand-holding.

**"The difference matters for accountability:"** Cut. The preceding sentence already says event logs capture what happened and causal graphs capture why. The scaffold phrase repeats what the contrast already shows. Trust the reader.

**"This is the scale-specific version of the emergence pattern documented in the [Multi-Agent Trust] chapter."** Tightened to "This is fleet-scale emergence, documented in [Multi-Agent Trust]." The original sounds like a textbook cross-reference. The revision sounds like the author knows what they're talking about.

**"simultaneously"** at end of registry paragraph. Redundant. "Satisfies both requirements" already means both.

## Recurring patterns to stop

**Explaining the implication of a contrast you just made.** If you write "X, not Y" the reader understands that X differs from Y. Don't follow with "The difference matters because..." Let the contrast do its job.

**"Chapter" as a word in cross-references.** "The shadow agent governance chapter identified" loses the hyperlink and adds a word. Just link and name the chapter: "[Shadow Agent Governance] identified." The chapter label is redundant when you have a hyperlink.

**Closing redundancy on strong sentences.** "The gap is closing, and it is closing before X" — the second clause repeats the first. Say it once. Strong sentences don't need a second swing.
