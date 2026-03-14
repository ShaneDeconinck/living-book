# Feedback Patterns: Cryptographic Authorization Governance

**Chapter:** cryptographic-authorization.md
**Session:** 347

---

## What Worked

**The opening vignette.** The $847 flight upgrade is concrete, specific, and immediately demonstrates the gap. It does not explain itself — the reader arrives at the problem before you name it. Keep this approach for chapters on subtle technical failures: show the failure, then name the cause.

**Three-mode structure.** Organizing "can't / don't / prove" as parallel modes with parallel failure scenarios works well. The structure does what a chapter structure should: it makes the logic visible before you read the argument.

**Protocol blocks used well.** The four-phase CAAM protocol block is long but earns its length — each phase is architecturally distinct and the block shows the full flow. The MAPL JSON blocks are tight: two blocks, one composition rule, one intersection result. This is the right ratio of code to explanation.

**The open problems section is honest.** Naming standardization instability and the bootstrapping problem directly is more useful than downplaying them. Readers building on this will hit both.

---

## Patterns to Watch

**Self-referential asides.** "The book's chapters on sandboxing, capability restrictions, and containment patterns make the case for 'can't' over 'don't'" — this is a footnote thought inserted into the argument. Cross-references belong at the end of sections or as footnotes, not in the middle of a paragraph building momentum. Cut and trust the reader to connect the earlier chapters.

**Fabricated technical specifications.** C1 (wrong phase count) and C2 (fabricated JSON field names) are the same underlying problem: drafting from memory of a spec rather than from the spec itself. When writing about an active IETF draft, quote the actual field names or label the block as illustrative explicitly. The JSON blocks in this chapter are close to authoritative-looking — the "illustrative" label on the SCO block is exactly right and should be the pattern for any spec-quoting code block where verbatim accuracy is not guaranteed.

**Unit errors in technical claims.** S1 was a 1000x error (ms vs μs). For performance figures from papers, copy the exact unit from the source. "Under 15ms" and "under 15μs" are different sentences that support opposite arguments about deployment feasibility. Check units the way you check attribution.

**Footnote dates.** M1 and M2 were date/title uncertainties on Shane's own posts. Blog post dates are verifiable — check them. The pattern of unverified dates on Shane's posts has appeared in multiple chapters. If the live blog is not accessible during drafting, note the date as approximate or leave it out until confirmed.
