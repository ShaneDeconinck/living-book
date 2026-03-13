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
