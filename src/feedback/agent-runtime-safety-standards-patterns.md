# Patterns: agent-runtime-safety-standards.md

**From:** Chop Pop
**Sessions:** 772 (3 cuts), 776 (1 cut), 851 (2 cuts)
**Status:** Clean after session 851

---

## What Was Cut

### Pattern 4 — Restatement closer (session 772, session 851)

Session 851 cut: "AARTS's external security engine enforces this." — the sentence that precedes it ("An agent cannot selectively disable its own audit trail.") already made the point. The restatement added nothing and weakened the close.

Session 772 cuts (3 total) not individually documented here — see commit d831bc5.

**Rule applied:** If the last sentence of a section could be cut without losing anything, cut it.

---

### Pattern 5 — Throat-clearing before recommendations (sessions 776, 851)

Session 851 cut: "That said, the architectural pattern is sound and the problem it addresses is real." — in the "What to Do Now" section, after acknowledging AARTS is a draft standard. The entire chapter has already demonstrated the architectural pattern is sound. The recommendations that follow are the evidence. Announcing that the pattern is sound before giving recommendations is throat-clearing.

Session 776 cut (1 total): same pattern, different location — see commit 8a8f49f.

**Rule applied:** When you have written a strong sentence (a recommendation), cut the sentence before it that announced the recommendation was worth following.

---

## What Works Well

**The concrete-failure-to-structural-fix pattern** is strong here. CVE-2026-2256 earns the PreToolUse argument. The Graphiti CVE earns the PreLLMRequest argument. The DataTalksClub incident earns the PreFileRead argument. Each failure is doing argumentative work the abstract hook-point description cannot.

**The analogical close** ("The architectural equivalent is how OS-level syscall interception works") does real work — it places AARTS in a pattern the reader already understands, without making the analogy the point. The analogy appears once, serves its purpose, and stops.

**The Skill IDs / sigstore-a2a distinction** is precise: Skill IDs answer "is this the skill I audited?"; sigstore-a2a answers "where did this skill come from?" The chapter keeps these separate rather than conflating them.

---

## What to Watch

**No fabrication issues found.** All statistics have footnotes with specific sources. The 43% MCP CVE figure traces to Kai Security's named analysis.

**Draft-standard hedging** is correctly placed in "What to Do Now" and does not infect the technical sections. The chapter does not hedge on whether AARTS's architecture is sound — only on its adoption status.

---

## Patterns Check (all 9)

1. Self-narrating opener: CLEAN (opens on concrete problem — three frameworks, three sandboxes)
2. Chapter-index closer: CLEAN
3. "This matters because" scaffolding: CLEAN
4. Restatement closers: FIXED (session 851)
5. Throat-clearing: FIXED (sessions 776, 851)
6. Dead-weight adverbs: CLEAN
7. Block quotes restating prose: CLEAN (no block quotes)
8. "You cannot govern" cliché: CLEAN (not present)
9. In-prose PAC interjections: CLEAN (PAC mapping in dedicated section)
