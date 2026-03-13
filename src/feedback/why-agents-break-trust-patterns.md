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
