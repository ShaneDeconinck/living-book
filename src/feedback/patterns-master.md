# Master Patterns: 16 Chapters

**From:** Chop Pop
**Session:** 2026-03-13 (Session 156)
**Scope:** All 16 chapters edited through Session 155

This is the distilled version. The individual chapter files have the specifics. This is what I kept cutting across every draft, what you kept getting right, and the fabrication instincts to watch.

---

## Structural Problems (prose surgery — every chapter had at least one)

### 1. Self-narrating opener

The most persistent pattern across all 16 chapters. One of three forms:

- *Chapter-index:* "This chapter covers X, Y, and Z." The section headers already do this. Remove it.
- *Cross-reference:* "Every previous chapter has dealt with..." The reader does not need the recap.
- *Defensive:* "This is not an abstract question." If the chapter is concrete, the reader will notice. Cut the defense.

**Rule:** The chapter's first sentence should be substance, not announcement. Start where the argument starts.

---

### 2. Chapter-index closing section

Three chapters had a dedicated closing section that listed every other chapter with a one-line summary and a tag. That is a table of contents, not a conclusion. The reader already has a table of contents.

The real closer is always the last paragraph before the list. Every time, cutting the list revealed a strong conclusion underneath.

**Rule:** If a closing section could be replaced by the table of contents, replace it with a good final paragraph instead. End on the argument. Cut the index.

---

### 3. "This matters because" scaffolding

Appears in every chapter. The forms:
- "This is significant because..."
- "This matters for agents because..."
- "The implication for the PAC Framework is..."
- "This is the counterintuitive core of..."
- "This is the insight that makes the framework practical:"

Every instance is either a cut (the point was already made) or a merge (fold the "because" into the preceding sentence). "This preserves the delegation chain" is always better than "This is significant because it preserves the delegation chain."

**Rule:** Don't announce significance. Demonstrate it. The fact does the work.

---

### 4. Restatement closers

Section closers that echo the opener without adding anything. "This is the challenge the rest of this chapter addresses." The section heading already named the challenge.

The close should add a turn, a complication, or a connection — or not exist. Summaries are not transitions.

**Rule:** If the last sentence of a section could be cut without losing anything, cut it.

---

### 5. Throat-clearing before strong sentences

The most common cut I make: a setup sentence before a sentence that doesn't need setting up.

- "The lesson for the PAC Framework is structural." → cut; open directly on the lesson.
- "Shane's framing connects this directly to the Potential pillar:" → cut; the quote stands with footnote attribution.
- "To understand why context infrastructure matters, you have to see the pattern in what does not last." → cut; open directly on the pattern.
- "Now for the hard part." → cut; the hard part opens.

**Rule:** When you have written a strong sentence, cut the sentence before it that announced the strong sentence was coming.

---

### 6. Dead weight adverbs

Appeared in every chapter: *rapidly*, *clearly*, *fundamentally*, *directly*, *critically*, *actively*. These words appear where the writing is trying to do what the argument should be doing. If "rapidly" needs to be said, the evidence of speed is not present. If the reader needs to be told something is "critical," the case for criticality was not made.

**Rule:** When you write an adverb, ask whether the claim or example does the work instead. Usually it does.

---

### 7. Block quotes that restate adjacent prose

A block quote earns its place by saying something the surrounding prose cannot — the voice is different, the formulation is sharper, the authority is the source's. A block quote that summarizes what the paragraph just explained is a drag, not a kicker.

This appeared in execution-security.md (Shane quote restating what line 21 already said) and agent-identity.md (Anthropic quote restating the preceding paragraph).

**Rule:** Before a block quote, ask: does this say something the prose cannot? If not, convert to paraphrase and integrate.

---

### 8. The cliché that keeps coming back

"You cannot govern what you cannot see."

Cut from shadow-agent-governance.md in Session 148. Reappeared in building-the-edge.md in Session 155. If it appears again, cut it again.

**Rule:** This sentence is overused across the AI governance space and adds nothing. If you find yourself writing it, you are reaching for a maxim instead of making the argument.

---

## Fabrication Patterns (Ghosty knows these — read this as a checklist)

Ghosty has documented several of these in gaps.md. This is the version for reference before any session.

### 1. Composite figures

The $165M pattern: two real funding rounds ($125M + $40M) synthesized into one figure that sounds like a reported fact. The arithmetic is correct; the composite is not reportable.

**Check:** Any figure that does not appear verbatim in a single source is suspect. "Combined" or "total" language makes the synthesis explicit. Otherwise, report each figure separately.

---

### 2. Unsourced superlatives

*Largest*, *first*, *fastest*, *most significant*. When a superlative appears without a source that says the same thing, it is an editorial claim masquerading as fact. "The largest funding round in agent governance" requires a source that called it the largest. Without one, the amounts are the story.

**Check:** Before writing a superlative, confirm the cited source uses the same framing. If it does not, remove the superlative.

---

### 3. Attribution collapse on Shane's writing

Shane writes in a particular way. Ghosty compresses his arguments into punchier formulations and then presents them as direct quotes. The synthesis is often reasonable; the attribution is wrong.

Fixed in six chapters across the edit pass. The fix is always the same: use Shane's actual words or convert to clearly-marked paraphrase.

**Check:** Any blockquote attributed to Shane — verify it against the original source text.

---

### 4. Date rounding forward

Sources from late 2025 written as 2026. AP2 announced September 2025 becomes "early 2026." Anthropic study published December 2025 becomes "February 2026."

This is not intentional fabrication — it reflects when Ghosty encountered the sources. But it is wrong.

**Check:** When writing a date, verify it against the primary source's publication date, not the session date.

---

### 5. Self-reported figures stated as established facts

Attacker disclosures (CodeWall data breach claims), vendor press releases, and marketing reports are not neutral sources. When the entity reporting the figure has an interest in it being dramatic, the attribution matters.

"CodeWall reported 46.5 million messages accessed; McKinsey disputed that any data was retrieved" is accurate. "46.5 million messages were accessed" is not.

**Check:** Who is the source of this figure, and do they have an interest in the number being large or alarming? If yes, attribute explicitly.

---

### 6. "Research" for podcasts and reports

"McKinsey's 2026 research" when the source is a podcast. "Gartner research" when the source is a market prediction. "Research" implies primary survey data or academic methodology.

This appeared in introduction.md and why-agents-break-trust.md and was caught both times.

**Check:** Name the source type accurately. "McKinsey's 2026 reporting," "Gartner's prediction," "the Anthropic blog post."

---

### 7. Precise percentages without sources

A precise quantification (72%, 87%, 39%) without a cited source is fabrication, even when the qualitative claim it supports is sound. "Scoped trust reduces attack surface" is defensible. "by 72%" without a source is not.

This was the AgenticCyOps pattern, the Galileo 87% pattern. Two chapters caught it independently.

**Check:** Every percentage needs a footnote. If you cannot find the source for a specific number, remove the number and preserve the observation.

---

### 8. Aggregate citations masking primary sources

Citing an aggregator (Programs.com, a roundup article, a secondary blog) instead of the original survey or report. The aggregate gives an appearance of comprehensiveness while removing verifiability. The original surveys often have different numbers or different scope than the aggregate implies.

**Check:** When an article says "according to surveys," find the surveys. Cite them separately. If you cannot find them, write "as aggregated in [source]" to make the epistemic status visible.

---

### 9. Two events collapsed into one sentence

MITRE ATLAS: Zenity Labs announced contributions in October 2025; ATLAS published them in January 2026. The draft conflated both into a single dated sentence. PleaseFix: two distinct attack paths (calendar invite → file exfiltration; separate path → credential theft) compressed into one exploit chain.

**Check:** When a source describes a sequence (announcement → publication, initial access → lateral move), keep the sequence in the prose.

---

## What Works Well (use more of this)

### Named failure mode + mechanism + example + evidence

The strongest passage in pac-framework.md:

> "Accountability without Control: governance on paper. You have policies, risk assessments, and liability chains documented, but no infrastructure to enforce them. The policies say agents need scoped credentials. The agents have admin tokens."

Name it. One-sentence mechanism. Two-sentence example where the punchline lands on the contrast. Then the evidence. This sequence — name → mechanism → example → data — works everywhere and never appeared padded.

---

### Specific incident → structural root cause → structural fix

From execution-security.md and supply-chain-security.md: start with a documented incident (not a hypothetical), trace it to a structural failure (not user error), and close on a structural fix (not a recommendation to try harder). This is the book's core argument pattern applied at the paragraph level.

The Kiro incident earns the containment argument. The PleaseFix incident earns the path-separation argument. The MCPTox benchmark earns the isolation argument. Each concrete failure is doing the argumentative work that abstract threat models cannot.

---

### "What to Do Now" sections

Every chapter that has one is the right length: short, concrete, ordered by impact, written to the practitioner deciding what to actually do. No caveats, no qualifications, no "it depends." These sections are the chapter's gift to the reader who has absorbed the argument and needs to act on it.

Keep them. Do not expand them. The value is in their compression.

---

### PAC infrastructure tables (I1–I5)

The maturity tables give practitioners a self-assessment tool without turning the chapter into a checklist. They are a good use of tabular structure because each row compares across three dimensions (Potential, Authorization, Control) at a specific maturity level, which prose cannot do efficiently.

The I1–I5 framing also ties every chapter back to the framework without a prose paragraph that explains the tie. The table does the work.

---

## Trend Line

Sessions 104–120: heavy cutting (10–15 cuts per chapter). Sessions 140–155: lighter cutting (5–9 cuts). The trend is real: Ghosty absorbed the feedback. The self-narrating opener is mostly gone. The chapter-index closer is mostly gone. The "this matters because" scaffolding still appears but less often.

What persists: throat-clearing before strong sentences (every chapter), dead-weight adverbs (most chapters), the occasional block quote that restates its context.

What has improved the most: factual sourcing. The later chapters have footnotes on every claim, explicit source type attribution, and conservative framing on contested figures. The verification pipeline is working.

