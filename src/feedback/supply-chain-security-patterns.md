# Feedback Patterns: supply-chain-security.md

**From:** Chop Pop
**Session:** 2026-03-13 (Session 124, pre-edit)
**Chapter:** supply-chain-security.md (draft — not yet edited, pending verification)

---

## 1. Institutional characterizations require primary sources

The draft characterizes two high-stakes institutional positions:

- Anthropic RSP 3.0: "shifting from absolute safety commitments to relative ones: safety measures now conditioned on competitor behavior." The footnote cites Help Net Security secondary coverage, not Anthropic's own RSP 3.0 document.
- U.S. Department of Defense: "designated Anthropic a supply-chain risk." The footnotes cite Malwarebytes and TechCrunch.

When you write what a major institution said, did, or decided, the primary source must be the one doing the characterizing. Secondary reporting paraphrases. Paraphrases drift. "Designated a supply-chain risk" is a legal-technical characterization that could mean several distinct things; citing a Malwarebytes summary of a TechCrunch article of a DoD document is three layers of drift.

**Rule:** For institutional characterizations — Anthropic policy, DoD designations, regulatory decisions — cite the institution's own document. If you cannot access the primary source, do not characterize it. Describe the secondary reporting accurately: "According to TechCrunch..." not "The DoD designated..."

---

## 2. Threat intelligence attribution is contested — say so

"PROMPTSTEAL, used by APT28 (Russia's GRU) targeting Ukrainian systems" is a serious attribution claim. Threat intelligence attribution is never settled — it is a probability estimate from analysts with access to signals you do not have. APT28 attribution claims have been revised, contested, and disputed in past reporting.

This book is read by security practitioners who know how attribution works. Stating attribution claims as fact without qualification will signal carelessness about the epistemics of threat intelligence.

**Rule:** When attributing threat activity to a specific state actor, add a clause: "attributed to APT28 by [source]" or "Google Cloud Threat Intelligence linked to APT28." The attribution belongs to the analyst, not to you.

---

## 3. Superlatives — this is the fourth instance

"The fastest GitHub repository to hit 100,000 stars in history" follows the exact pattern as:
- "Microsoft is shipping the first major agent governance control plane" (introduction.md — removed)
- "The largest funding round to date" for Kai (why-agents-break-trust.md — removed)
- "$165M in 48 hours" composite (introduction.md and shadow-agent-governance.md — removed twice)

You keep writing superlatives that make the opening more dramatic but cannot be sourced. The OpenClaw story is genuinely significant without being the fastest repository in GitHub history. The pace of its rise is the point — that does not require a "fastest ever" claim.

**Rule:** Before writing any historical superlative (fastest, largest, first, most), ask: does the cited source say this in those exact words? If not, cut it. The facts are strong enough.

---

## 4. Large specific figures presented as a cluster need individual sourcing — and the SecurityScorecard figures were wrong by 100x

The SecurityScorecard passage originally cited:
- 135,000+ exposed instances across 82 countries (actual: ~40,000, ~76 countries)
- 15,200+ vulnerable to RCE (actual: ~12,812)
- 53,000+ correlated with prior breach activity (actual: **549**)

The breach-linked figure was inflated 100x. This is not a rounding error. This is the kind of error that destroys the chapter's credibility if it reaches readers — security practitioners will check that number.

The error pattern is: writing large specific figures from memory without returning to the primary source. "53,000" sounds credible as a threat intelligence figure. So does "135,000." The specificity signals precision. But specificity without source verification produces false precision, not accuracy.

**Rule:** When citing specific figures from a security report, look up the actual number every time. Do not write from memory. Large round numbers that sound credible should trigger extra skepticism — if you cannot open the source and point to the exact figure, do not write it.

**Rule:** When citing multiple distinct figures from one source, verify each figure independently rather than assuming the same citation covers all of them. If they are different analyses, note that briefly.

---

## 6. Post-publish quality scan (2026-03-14)

Technical chapters with high citation density can still carry prose overhead even after editing. Specific patterns found in the published version:

**Negative framing before positive statement.** "This is not prompt injection in the traditional sense" is setup that doesn't add value before "There is no malicious payload." Lead with what a thing is, not what it isn't.

**Redundant two-sentence pairs.** "At no point does the developer see anything suspicious. The agent does exactly what it was instructed to do" — same point stated twice, once abstractly, once concretely. One sentence usually does the job.

**Category label scaffolding.** "A new category emerged in early 2026:" before describing the category. The category names itself in what follows. Cut the announcement.

These are recurring prose habits, not just this chapter. See patterns-master.md patterns 3 and 4.

---

## 7. "What is emerging / What is still missing" is stronger than "What is missing"

When describing a gap in the ecosystem, structure the section as: state what is emerging to address the gap, then name what remains unsolved. This is more useful to the reader than a flat "What is missing" list.

The Sigstore/sigstore-a2a/model-transparency additions demonstrate this: instead of just noting absence of certificate transparency for agent tools, the chapter now shows what infrastructure exists (Sigstore is production-grade, npm/PyPI adopted it) and exactly what gap remains (behavior attestation, not provenance). The reader leaves with something actionable.

**Rule:** Before writing a "What is missing" section, ask whether partial solutions already exist. If they do, describe them first. Name the gap in terms of what real solutions cannot yet cover.

---

## 5. The chapter's best writing is in the QUIETVAULT/AI malware section

The QUIETVAULT section — UNC6426 exploiting the nx npm build framework via pull_request_target GitHub Actions, postinstall injection — is the most technically precise and original analysis in the chapter. The five AI malware families section is also strong. This is where the chapter earns its place.

The OpenClaw framing sections that open the chapter are competent but relatively familiar. The attack-chain specificity in the QUIETVAULT section is what distinguishes this from a threat roundup. Lean into that precision in revision — it is what the reader came for.
