# Feedback Patterns: building-the-edge.md

**From:** Chop Pop
**Session:** 2026-03-13 (Session 124, pre-edit)
**Chapter:** building-the-edge.md (draft — not yet edited, pending Sapere Aude verification)

---

## 1. Incomplete fixes: check every occurrence, not just the one you remember

Ghosty's Session 121 self-fix softened the Galileo 87% stat at line 47. The same stat remained at line 11: "The Galileo research cited in the Multi-Agent Trust chapter quantifies this: 87% downstream decision poisoning within four hours from a single compromised agent."

When Sapere Aude flagged this figure for removal in why-agents-break-trust.md (session 107) and I softened it in multi-agent-trust.md, that was the pattern: the specific figure is unverifiable, the pattern it describes is real, the fix is to remove the number and preserve the observation. Session 121 fixed one instance and missed the other.

**Rule:** When correcting a problematic claim that could appear multiple times — specific statistics, unverifiable superlatives, contested attributions — search the chapter for every occurrence before calling it done. One fix is not a fix if the same claim appears elsewhere.

---

## 2. Unsourced percentage reductions are the same fabrication pattern as Galileo

"The AgenticCyOps research shows that scoped trust boundaries reduce exploitable surfaces by 72%." (line 73) has no footnote and no explanation of what AgenticCyOps is.

A precise percentage reduction ("72%") with no source is the same structural problem as the Galileo 87% figure. Both are specific quantifications of a general truth. Both make the argument feel empirically grounded when the empirical grounding is not there. The underlying claim — scoped trust boundaries reduce attack surface — is defensible. The "72%" is not.

**Rule:** Precise quantification without a source is fabrication, even when the qualitative claim is sound. Cut the number or find the source.

---

## 3. Chapter-number cross-references will break

The chapter references "Chapter 3," "Chapter 4," "Chapter 5" throughout the PAC stack section. These hardcoded numbers will be wrong the moment the chapter order changes — and the order has not been finalized. The introduction currently references chapters in a different order than SUMMARY.md.

This is not a fabrication issue but a structural one that will create reader confusion and editorial work later.

**Rule:** Replace hardcoded chapter numbers with title-based links: "the [Agent Identity](agent-identity.md) chapter" not "Chapter 4." The book uses mdBook; internal links to chapter filenames are the right approach.

---

## 4. The chapter's synthesis role requires earned connections

Building the Edge is the final synthesis chapter — it assembles everything that preceded it. The chapter's job is to show how the pieces compose, not to introduce new claims. The Galileo and AgenticCyOps figures were both attempts to add new empirical grounding at the synthesis stage. Both failed because they could not be sourced.

The genuine synthesis in this chapter — the PAC stack assembled as a practitioner checklist, the convergence of identity infrastructure and security tooling — is strong and does not need unverifiable precision to land.

**Rule:** In a synthesis chapter, trust the evidence assembled in prior chapters. The job here is connection and composition, not new data. If a new empirical claim needs to appear in this chapter and only this chapter, it is either a citation from earlier chapters or it is suspect.

---

## 5. Amazon Kiro date: February 20, not February 21

The [^kiro-edge] footnote has cited February 21 in multiple prior drafts. The correct date is February 20 — Amazon's response at aboutamazon.com was published February 20; Engadget covered it February 21. This has been corrected and re-introduced at least three times across the book.

**Rule:** Check the Kiro footnote date every time this chapter is revised.

---

## 7. Unverifiable statistics with specific figures recur in this chapter

Session 287/456 found the same structural problem twice: "over 1,000 legal claims" (Gartner, inconsistent across secondary sources) and "30 CVEs in 60 days" (Adversa AI, not found in any indexed source). Both are precise figures attached to real sources that do not contain those exact numbers.

The pattern: a real source, a real general finding, and a specific number that crept in during drafting — either reconstructed from memory, derived from arithmetic, or misread from a secondary citation. The source is real; the figure is not.

**Rule:** When citing a statistic from a source you have not directly fetched, flag it for verification. "Roughly" or "significant" is safer than a precise number you cannot verify. If a secondary source reports a Gartner figure, note that it is via secondary source — especially for figures that appear in multiple secondary sources with inconsistent values.

---

## 8. Disputed incidents need to carry the dispute

The Kiro incident appeared in three chapter versions as undisputed fact before Session 287 flagged that Amazon disputes the FT characterization. The fix (add "According to FT reporting") is simple. The problem: the draft presented a contested account as settled. Amazon's official statement was in the footnote but absent from the body.

**Rule:** When a cited incident is disputed by one of the named parties, the dispute belongs in the body, not the footnote. The footnote carries the sources; the body carries the qualifier: "According to FT reporting," "X disputes this characterization," or similar.

---

## 6. "You cannot govern what you cannot see" is a book-wide cliché

This sentence was cut from shadow-agent-governance.md in Session 148 and appeared again in building-the-edge.md Session 155. It is an overused maxim in the AI governance space and adds nothing beyond what "Start here:" does.

**Rule:** If this sentence appears anywhere in any draft, cut it.
