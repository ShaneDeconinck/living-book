# Feedback Patterns: context-infrastructure.md

**From:** Chop Pop
**Session:** 2026-03-13 (Session 125, pre-edit)
**Chapter:** context-infrastructure.md (draft — not yet edited, pending Sapere Aude verification)

---

## 1. The principled-example structure works — keep it

The Claude Code / Manus / Clawdbot sequence is the best example structure in the book. Each example is anchored to a specific argument before it appears: scaffolding trap → Claude Code (deletion as progress), KV-cache optimization → Manus (production discipline), rich context + missing controls → Clawdbot (liability). Each earns its place by serving a distinct claim. None could swap positions.

This is in contrast to other chapters where examples illustrate loosely and feel interchangeable. The discipline here: introduce the claim, then the example. Never introduce the example and hope the claim emerges.

**Rule:** Before naming a product or company as an example, write the sentence it is supposed to prove. If you cannot write that sentence, the example is decoration.

---

## 2. Vendor product sections break from argument into summary

The "convergence of identity and information governance" subsection (under Permissions) breaks the chapter's rhythm. It opens well — Gartner identifies a structural gap between ICAM and information governance. Then it shifts into product specification: Agent 365 integrates Entra, Purview, and Defender. Each agent gets Conditional Access. Purview evaluates data interactions. Defender assesses risk. The integration means evaluations happen together.

This is a product capability list, not an argument. The reader gets features, not insight. Compare it to the Manus section: four concrete principles derived from a single engineering constraint (KV-cache hit rate). Every sentence is argument. The Agent 365 section is only argument in the final paragraph — and that final paragraph ("organizations should not treat permissions as a separate layer") is the point the whole subsection was building to. Everything before it could be a footnote.

**Rule:** When a vendor product is your evidence, the body should make the argument. The product is the footnote. If you find yourself listing product features, stop and ask: what is the sentence I am trying to prove? Lead with that.

---

## 3. Hedge-stacking is filler

"How do they interact with service mesh architectures? Are they a separate layer or an extension of existing API infrastructure? The answers are still forming, but the pattern is clear."

This sequence acknowledges uncertainty, raises two open questions, then claims a pattern is clear — without stating the pattern. It is three sentences of motion with no destination. Either state what the pattern is, or cut the uncertainty gesture entirely.

**Rule:** If you are going to say "the answers are still forming," you must either (a) give enough of the answer to be useful, or (b) cut the sentence. Uncertainty acknowledged but unresolved is filler.

---

## 4. "What to Do Now" is the right ending — make it standard

The chapter's closing section is the most actionable in the book. Five concrete steps: audit what agents actually access, start with CLAUDE.md, model information after the domain, invest in discovery, treat freshness as a feature. Each is specific. None requires qualification. "Start with CLAUDE.md. Seriously." is the best single sentence in the book.

This pattern — argument, framework, then immediate practical steps — is the right chapter-ending structure. It respects the reader's time: you have read the theory, here is what to do Monday morning.

**Rule:** End chapters with an action list. Not a summary of the argument you just made. Not a gesture toward future chapters. A list of things the reader can do now.

---

## 5. Secondary citations add weight without adding evidence

Footnote [^6] points to a Towards Data Science article summarizing the evolution from basic RAG to structured retrieval. The chapter already explains this evolution clearly in the preceding paragraphs. The footnote does not add a primary source or new evidence; it adds a secondary summary that makes the citation look more substantial than it is.

This pattern appears elsewhere in the book: a claim is made well, then footnoted with a secondary article that restates the same claim. The citation does not strengthen the argument — it just adds the visual signal of a footnote.

**Rule:** Footnotes should point to primary sources or to the original formulation of a claim. A TDS article summarizing a trend is not a source for the trend. If you cannot find a primary source, the claim stands on its own merits.
