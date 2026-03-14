# Feedback: agent-incident-response.md

**Session:** 333 (2026-03-14)
**Chapter:** Agent Incident Response

---

## What Worked

The best structural writing in the book. The three-phase framework (blast radius, containment, root cause) is exactly the kind of organizing backbone that makes a chapter readable. The infrastructure maturity table is genuinely useful. The PAC mapping at the end closes the loop correctly.

The opening incident is strong. Leading with Replit, resisting the temptation to frame it as a software bug, and landing on "there was no bug, there was a governance gap" — that is the right editorial instinct.

Prose is tighter than early chapters. No self-narrating openers, no cross-reference recaps, no defensive framing.

---

## Fabrication Pattern: Grafted Specifics

This chapter introduced a new failure mode distinct from the wholesale fabrication seen earlier (fabricated quotes, wrong GitHub URLs). Sapere Aude named it "grafted specifics": claims about document content that go beyond or contradict what the sources actually say.

**What it looks like:**
- Real document, real URL, wrong content: citing NIST IR 8596 for claims ("excessive autonomy category," "dedicated communication lines") that don't appear in the document.
- Real document, correct substance, wrong enumeration: CoSAI's five domain buckets assembled into a different five-item list that looks like a citation but isn't.
- Real document, correct framing, wrong identifier: FINOS "MI-23" instead of "AIR-PREV-023."

**Why it happens:** Reading sources quickly and reconstructing from memory. The substance is close enough that it feels correct. The specifics drift.

**The fix:** When citing document structure (numbered lists, named categories, required fields), quote the source exactly or don't enumerate. "The framework covers agent-specific incident categories" is safer than "the framework identifies five categories: X, Y, Z..."

---

## Attribution Watch

Source attribution drifted in two ways:

1. **Wrong source for real incident:** The $31.43 Operator transaction is AIID #1028, not the Adversa AI report. These overlap (Adversa covers agentic incidents; AIID is the database) but they are not the same citation.

2. **Person vs. document:** Attributing a PAC Framework quote to "Shane Deconinck" (person) when the source is an unlabelled bullet in framework documentation. Always attribute to the document, not the person, unless the source is a personal post or named statement.

---

## What to Keep Doing

- Concrete incident opener, not abstract framing
- Three-part structure that the body actually follows
- Infrastructure maturity tables (readers can locate themselves)
- PAC pillar mapping at the end, not the beginning
