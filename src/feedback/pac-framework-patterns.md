# Feedback Patterns: pac-framework.md

Read as part of Chop Pop Session 127 pre-read. Five patterns.

---

## Pattern 1 (Positive): The forcing-function definition

**"PAC is a forcing function: it makes you address all three before something breaks."**

This is how to define a framework in one sentence. Not a description of what it contains. Not a list of pillars. A statement of what it does to you. The sentence creates urgency. It tells the reader why the framework exists before they have to ask.

Compare the introduction paragraph, which does the same work over four sentences. The forcing-function sentence makes those four sentences dispensable. It is the whole argument compressed.

When you define a technical framework, try to write the one-sentence version first. If you can't, you don't understand the framework yet.

---

## Pattern 2 (Negative): Same argument, said twice in succession

**Location:** Lines 52-58 (Implementation Architecture: Composability, Not Categories)

The composability section explains how layers compose (line 52-53), illustrates with the customer service example (line 56), then closes: "This matters because the implementation architecture determines how knowable your error margin is. A pure workflow has enumerable failure modes: you can test every branch. A pure autonomous agent has an open-ended failure space."

That closing logic was already stated at lines 26-28: "A workflow's failures are enumerable: you can test every branch. An autonomous agent's failures are not: the space of possible behaviors is open-ended."

The argument appears verbatim in two places. The second appearance weakens the first. When you make an argument, trust it. State it once, in the right place.

**How to apply:** When you write "This matters because..." check whether you already made that point. If you did, cut the restatement. If the new context genuinely requires it, integrate rather than repeat.

---

## Pattern 3 (Negative): The chapter-index closing section

**Location:** "Applying the Framework" (lines 269-287)

The section lists every chapter with a one-line description and a PAC tag. It is a table of contents. The reader already has the table of contents. The 19 Questions section above already linked to each chapter in context.

The real closing paragraph is the last one: "The goal is not to memorize the levels and scales. It is to internalize the relationships between them, so that when you make a decision about agent deployment, you naturally ask: what is the blast radius, do I have the infrastructure, and can I prove accountability?" That paragraph is the chapter's conclusion. The list before it is noise.

**How to apply:** If a closing section could be replaced by a table of contents, it should be replaced by a good final paragraph instead. This is the third time this pattern has appeared (agent-identity had a similar listing section; shadow-agent-governance nearly did). End on the argument, not the index.

---

## Pattern 4 (Positive): The named failure mode with a short mechanism

**"Accountability without Control: governance on paper. You have policies, risk assessments, and liability chains documented, but no infrastructure to enforce them. The policies say agents need scoped credentials. The agents have admin tokens."**

This is how to make an abstract failure mode concrete: name it, one-sentence mechanism, two-sentence example with the punchline on the last beat. "The policies say agents need scoped credentials. The agents have admin tokens." — the contrast is embedded in the syntax. No explicit comparison needed.

The Teleport and Gravitee statistics that follow directly substantiate this failure mode, so the writing earns the evidence that comes after it. That sequence — named failure → mechanism → concrete example → quantified evidence — works everywhere in the book. Use it.

---

## Pattern 5 (Negative): Aggregate citation masking primary sources

**Location:** Footnote [^shadow-ai]

"98% figure (unsanctioned app use) and 76% BYOAI adoption are aggregated in Programs.com, 'Shadow AI Statistics,' 2026, drawing on CIO.com, Cybersecurity Insiders, and IBM Cost of a Data Breach Report 2024."

This is the same pattern flagged in context-infrastructure-patterns.md ([^6], TDS article). Programs.com aggregates third-party surveys. The original data is from CIO.com, Cybersecurity Insiders, and IBM — three separate primary sources with separate methodologies. Citing the aggregate instead of the primary sources adds apparent comprehensiveness while removing verifiability.

When you need multiple surveys to support a claim, cite them separately. If you cannot find the primary sources, write "aggregate reported in Programs.com" explicitly in the footnote, not just in parentheses. This makes the epistemic status visible.

**Note for Sapere Aude:** the 98% and 76% figures need primary source confirmation, not aggregate confirmation, before this chapter is clean.
