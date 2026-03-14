# Feedback Patterns: why-agents-break-trust.md

For Ghosty. These are patterns, not individual corrections.

---

## 1. Unsourced superlatives

"The largest funding round to date" appeared with no footnote and no source. This is the same pattern as "the first major agent governance control plane" in introduction.md. Superlatives about market position or historical firsts need sources or they come out. The claim was strong without it.

**Rule:** Before writing any superlative (largest, first, fastest, most), ask: does the cited source say this? If not, cut it.

---

## 2. Conflating two events into one sentence

The MITRE ATLAS section had a date error because two events were collapsed: Zenity Labs announced contributions in October 2025, but the ATLAS framework published those contributions in January 2026. The sentence said "In October 2025, Zenity Labs contributed..." when the contribution to the framework happened later.

**Rule:** When a source describes an announcement AND a publication of that announcement, separate them. "X announced Y in [month]; it was incorporated in [month]."

---

## 3. Self-reported figures stated as verified facts

CodeWall's data breach claims (46.5M messages, 728K files, 57K accounts) were stated as facts. The source is the attacker's own blog post. McKinsey disputed retrieval. The fix was to attribute: "CodeWall reported..." and note the dispute.

**Rule:** When the source for a dramatic statistic is a party with an interest in the claim (attacker's disclosure, vendor's press release), attribute explicitly. Don't flatten "CodeWall claimed" into bare fact.

---

## 4. Two exploit paths collapsed into one

PleaseFix had two separate attack paths (calendar invite → file exfiltration; separate path → credential theft). The draft implied both flowed from the calendar invite. The verification caught this.

**Rule:** When a source documents distinct attack paths, keep them distinct in the text. Don't let narrative flow collapse separate technical mechanisms into one.

---

## 5. Source type matters for framing

McKinsey's 80% figure was introduced as "McKinsey's March 2026 research" — same issue caught in introduction.md. The source is a podcast (The McKinsey Podcast), not primary research. "Research" overclaims.

**Rule:** Name the source type accurately. "McKinsey reporting" or "McKinsey's podcast" is correct. "McKinsey research" implies survey data or primary study.

---

## 6. Throat-clear setup openers

"Here is a governance reality that most organizations are not ready for: your employees are already building agents." The setup adds nothing. The second clause is the sentence.

**Rule:** Openers like "Here is a [noun] that [negative judgment]:" signal that the real sentence hasn't started yet. Cut everything before the colon and start with the fact.

---

## 7. Meta-commentary about the book

"The ten risks validate the structure of this book: every one is covered in depth, and the book goes deeper than the taxonomy by connecting risks to infrastructure, governance, and the PAC Framework." This is marketing inside content. The reader will judge whether the book goes deep.

**Rule:** Never describe the book's own quality or completeness inside the text. Cut all "the book covers X in depth" and "validates the structure of this book" constructions.

---

## 8. Disclaimer before evidence

"These are not theoretical attack vectors." appeared immediately before three concrete, named attack vectors with sources. The evidence refutes the concern without needing the disclaimer stated first.

**Rule:** Don't pre-empt skepticism before presenting evidence. The evidence answers the skepticism. "X confirms this is not hypothetical: [evidence]" becomes "[Evidence]."

---

## 9. Self-referential section closes

"This is why the book focuses on trust infrastructure, not model capabilities." This explains the author's purpose inside the narrative. The section already demonstrated that purpose.

**Rule:** Cut closing sentences that explain why the chapter or book covers what it covers. The content speaks. The author doesn't need to explain why it matters.
