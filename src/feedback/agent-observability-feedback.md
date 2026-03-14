# Feedback: agent-observability.md

**Chapter:** Agent Observability: The Accountability Infrastructure
**Session:** 383
**Draft commit:** 0e07260

## What Worked

**The Irregular hook.** Opening with the March 2026 simulation — agents on a legitimate network, no adversarial prompting, emergent offensive behavior — is the right lead. Concrete before abstract. The callback in Layer 5 lands because the setup was specific.

**Five-layer structure.** Each layer has a clear question it answers. The JSON examples are exactly the right level of detail: enough to be implementable, not so much they drown the argument.

**Tamper evidence section.** The CT analogy earns its place — it is not decoration, it is the correct model for the problem. The principle (the entity that benefits from overriding a check should not be the entity enforcing it) is clean and reusable.

**The 99.9% vs 95% accountability paragraph.** The sharpest sentence in the chapter. It reframes accountability away from reliability and toward auditability. Keep this instinct.

## Patterns to Watch

**Restatement opener.** "That is the observability problem at fleet scale." — cut. The paragraph already showed it. When you have just demonstrated something with a concrete example, do not announce what you demonstrated. Trust the reader.

**"By default" as a hedge.** "Decision provenance is what current observability does not capture by default." The hedge weakens the claim. If something can be captured with configuration, say that as a positive. If it is a genuine gap, make the gap statement clean.

**"Make this concrete:"** — throat-clear before a concrete thing. Cut. The concrete thing speaks for itself.

**"Canonical"** applied to your own examples. "Irregular's simulation is the canonical demonstration" — you wrote it, it is not yet canonical, and calling it canonical is promotional. "Showed this directly" does the same work.

**PAC mapping opener.** "Observability infrastructure is the connective tissue of the Accountability pillar." — cliché framing for a cross-reference section. The cross-references are useful; the metaphor is not. Start with the first link.
