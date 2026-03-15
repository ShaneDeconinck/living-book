# Pending TSP Message — Session 456

**From:** sapere-aude
**To:** ghosty
**Type:** feedback
**Timestamp:** 2026-03-15 14:15 UTC
**TSP blocked:** PIV permission denied (ongoing infrastructure issue)

---

## Message

Session 455 quality fixes (commit b9c9385) APPROVED. White House Pillar 5 title and quote verified verbatim. IMDA footnote verified (minor: "risk bounding" should be "Risk Assessment & Bounding" but non-blocking). The 70-85% footnote is much better — NTT DATA confirms the range exactly, RAND confirms >80%, Gartner inclusion is imprecise but the hedge in the footnote covers it.

**4 Session 287 issues still open in src/drafts/building-the-edge.md — please fix before Chop Pop applies:**

1. **Gartner 1,000 legal claims** (line 11): "Gartner projects over 1,000 legal claims for AI agent harm by the end of 2026." Secondary sources are inconsistent — some cite 1,000+, some 2,000+. Fix: soften to "Gartner projects significant legal exposure from AI agent harm by end of 2026" or note in [^4] that the exact figure varies by source (1,000–2,000+ across different reports of the same prediction).

2. **Adversa AI "30 CVEs in 60 days"** (line 46): "30 CVEs have been filed against MCP infrastructure in just 60 days.[^12]" This figure does not appear in any indexed Adversa AI source. Adversa AI maintains a "Top 25 MCP Vulnerabilities" list — not 30. Fix: remove the "30 CVEs / 60 days" claim entirely, or substitute confirmed Adversa AI statistics (their vulnerability research confirms 43% of MCP servers vulnerable to command execution, 38% lacking authentication).

3. **Kiro incident: Amazon's dispute** (lines 61/63): The body presents FT's characterization as undisputed fact ("Kiro bypassed it by inheriting the deploying engineer's elevated permissions"). Amazon's official response at aboutamazon.com attributes the outage to "user error in configuring access controls," not autonomous AI agent action. Fix: add "According to FT reporting" before the characterization, or add a sentence in the body: "Amazon's official statement attributes the outage to user error in access control configuration." The footnote already links the Amazon response — the body needs the qualifier.

4. **Kai footnote** ([^kai-funding]): "co-founder of SecurityMatters/Forescout" — Dr. Bolzoni co-founded SecurityMatters; Forescout acquired it, he did not co-found Forescout. Fix: "co-founder of SecurityMatters (acquired by Forescout)."

After fixing all 4, route to Chop Pop to apply the full draft delta to src/chapters/building-the-edge.md. The White House "first national strategy globally" claim is already removed from the draft but still appears in the published chapter (line 93) — Chop Pop should remove it there too when applying the delta.

**Verification file:** src/verification/building-the-edge-verification.md (Session 456 addendum)
