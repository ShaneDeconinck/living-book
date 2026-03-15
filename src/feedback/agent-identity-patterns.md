# Feedback Patterns: agent-identity.md

**For Ghosty — patterns, not corrections.**

---

## 1. Defensive openers

The draft opened with "This is not an abstract design question." That phrase is always filler. If the chapter is concrete, the reader will notice. Defending yourself against the hypothetical reader who might call it abstract undermines the confidence that should open a technical chapter.

**Pattern:** Cut any sentence that argues for the chapter's relevance before demonstrating it.

---

## 2. "This matters because" scaffolding

The draft used this construction several times:
- "This is significant because it preserves the delegation chain."
- "This matters for agent governance because it solves two problems simultaneously."
- "This matters for the book because it identifies a threat class..."
- "For agents, this matters because stolen tokens become useless."

Every one of these can either be cut (the point was already made) or integrated into the preceding statement. "The resulting token encodes two identities... This is significant because it preserves the delegation chain." becomes: "The resulting token encodes two identities... This preserves the delegation chain."

**Pattern:** Don't announce significance. Demonstrate it. Let the fact do the work.

---

## 3. Trailing section closers that restate the opener

"This gap is what the rest of this chapter addresses: the infrastructure emerging to close it." appeared as the last line of the Agentic Gap section, right before the heading "## OAuth Extensions for Agents." The section heading already says what comes next. The closing sentence was pure echo.

**Pattern:** Section closers should add something — a turn, a complication, a connection — or not exist. Summaries are not transitions.

---

## 4. Repeated data across sections

The Huntress 2026 Cyber Threat Report data (OAuth abuse 4.8% to 10.1% year-over-year) appeared in the Agentic Gap section (appropriately) and again in the "Agent Identity Is Now a Product Category" section (redundantly). The second citation added nothing and diluted the first's impact.

**Pattern:** Cite data where it does the most work. If the same figure appears in a later section, ask whether it's reinforcing a new point or just filling space.

---

## 5. The chapter does this well

- The PAC infrastructure table at the end (I1–I5) is excellent: it lands the framework mapping cleanly and gives practitioners a clear self-assessment tool.
- "What to Do Now" is clean, concrete, and actionable. No padding.
- The Verifiable Intent section is precise and tightly reasoned.
- The layering analysis (OAuth → Platform → Infrastructure) is a genuine contribution — it gives readers a mental model for how these standards compose.

---

## 6. Self-narrating openers

The chapter opened with "The previous chapters established why agents break trust and introduced the PAC Framework. This chapter goes deep on the technical problem at the center of the Control pillar: how do you know who an agent is..."

This tells the reader what they already know (they read the previous chapters) and announces what they are about to read (they are about to read it). The chapter's first real sentence — "Every time an agent calls an API, sends a message, or makes a purchase, something needs to answer: who authorized this?" — earns its place. The opener did not.

**Pattern:** Do not start a chapter by summarizing prior chapters or announcing your own structure. Start at the problem.

---

## 7. PAC interjection sentences

Eight sentences were cut that named the PAC Framework mapping explicitly in the body text: "This inversion maps directly to the Control pillar of PAC," "For the PAC Framework, Transaction Tokens operationalize the Control pillar," "For the PAC Framework, Entra Agent ID represents the I3 to I4 transition becoming productized," etc.

These sentences stop the argument to announce that you have noticed a connection to the framework. The connection is real. Naming it is not necessary. The reader who knows the framework will see it. The reader who does not will not be helped by a label. Both readers lose the rhythm.

**Pattern:** Do not narrate your own framework mappings. Make the technical point and let the PAC connection be visible in the structure.

---

## 8. Throat-clearing significance announcements

"This is architecturally significant." and "Most significant for agent governance:" were both cut. These phrases are the written equivalent of clearing your throat before speaking. If the finding is significant, the next sentence will show it. Announcing significance before delivering it weakens the delivery.

**Pattern:** Cut any sentence or phrase that announces importance without delivering it. "This is significant because..." and "Most significant:" are almost always replaceable with nothing.

---

## 9. "An important distinction:" openers

PIC section (added session 476): paragraph opened with "An important distinction: to continue authority..." The distinction is real and the paragraph delivers it well. The announcement adds nothing.

Compare: "An important distinction: to continue authority, a workload does not need its own identity." vs. "To continue authority, a workload does not need its own identity." The second sentence does all the work. The label was throat-clearing.

**Pattern:** Variant of #8. "An important distinction:" belongs in the same category as "This is significant because" — it announces before delivering. Cut it.

---

## 10. Dead-weight adverbs

"Precisely," "directly," "clearly," and "exactly" appeared throughout as filler. Most were cut: "addresses this gap directly" → "addresses this gap," "illustrates exactly why" → "illustrates why," "This maps directly to" → "This maps to." These adverbs do not intensify meaning — they pad it. The few remaining instances ("illustrates the gap precisely," "what exactly," "not develop protocols directly") all earn their place by adding actual semantic content.

**Pattern:** Challenge every instance of "precisely," "directly," "clearly," and "exactly." If the sentence means the same thing without the adverb, cut it.
