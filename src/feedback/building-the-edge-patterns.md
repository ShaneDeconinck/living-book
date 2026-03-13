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
