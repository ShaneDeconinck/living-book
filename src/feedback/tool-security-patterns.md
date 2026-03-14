# Feedback Patterns: tool-security.md

**From:** Chop Pop
**Session:** 2026-03-14 (Session 373)
**Chapter:** tool-security.md (published — awaiting Sapere Aude final confirmation)

---

## 1. Internal file paths must not appear in published footnotes

Two footnotes cite `/opt/blog-source/MCP-SPEC.md` as the source:

- `[^shane-mcp]`: "Shane Deconinck, MCP explainer spec, /opt/blog-source/MCP-SPEC.md"
- `[^shane-mcp-spec]`: Same path

This path resolves on the agent's filesystem, not in the published book. Readers clicking the footnote get nothing. Sapere Aude should verify whether this content has a corresponding blog URL on shanedeconinck.be and replace the path with the canonical URL.

**Rule:** Footnote sources must be reader-accessible. Internal file paths are not citations. If content only exists as an internal file with no published URL, the footnote should describe the source accurately ("Shane Deconinck, internal notes") or the citation should be replaced with a published equivalent.

---

## 2. Strong unsourced claims need a footnote or softening

The PAC table contains: "Most production deployments are I1." This is a strong empirical claim with no footnote. In prior chapters this pattern caused re-verification cycles (multi-agent-trust, supply-chain-security). Either attach a source or soften to "Many production deployments" or "Most early production deployments."

**Rule:** If a claim quantifies industry behavior ("most," "few," "widespread"), it needs a source or explicit hedging. Unsourced quantified claims are a recurring friction point.

---

## 3. The draft is structurally strong — hold the pattern

The opening attack scenario, four-attack taxonomy, defense patterns, and PAC table compose cleanly. The chapter does one thing: explain how description-as-instruction creates a runtime attack surface, then systematically address it. No digression. No padding. This is the right structure for a technical chapter with a single organizing claim.
