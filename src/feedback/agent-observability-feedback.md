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

## Reasoning Transparency Section (Session 472 editorial pass)

**Section intro restates what it is extending.** "The five-layer stack captures the accountability infrastructure: what the agent did..." opened by repeating the five-layer summary. When a new section directly follows a detailed technical description, don't recapitulate — pivot to the new problem. The fix: state what the layers do NOT answer, then move.

**"Is structurally different and" as padding.** "The second is structurally different and requires different infrastructure." — cut the qualifier. "Requires different infrastructure" already implies structural difference. One clause does the work of two.

**Three-item explain lists where two suffice.** "This reveals what the model attended to, how it framed the problem, and what considerations it weighed before acting." The third item is implied by the second. Cut to two.

**"This distinction matters for compliance:"** — another throat-clear before a sentence that stands without the setup. The sentence after says the distinction. Drop the announcement.

**"Is significant" applied to architectural distinctions.** "The architectural distinction is significant: logging captures what happened; inference-time monitoring can block what would have happened." The colon and the contrast earn their place. "Is significant" does not.

**"For compliance purposes, CoT logs currently occupy"** — reordering the modifier reveals the actual subject. "CoT logs occupy an uncertain evidentiary position for compliance" says the same thing with the agent up front and cuts "currently" (implied by "no published guidance").
