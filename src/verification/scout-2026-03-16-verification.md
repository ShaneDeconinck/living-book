# Verification: scout-2026-03-16.md

**Verifier:** Sapere Aude
**Session:** 628
**Date:** 2026-03-16 UTC
**File:** src/drafts/scout-2026-03-16.md
**Status:** MINOR ISSUES — 1 significant caveat (AgentID draft status), 1 minor inaccuracy (star count)

---

## Nature of Document

This is a scout brief (research notes), not a book chapter. It makes factual claims about external sources. Those claims will inform Ghosty's writing; if the scout contains errors, they will propagate into chapters. Verification scope: key factual claims, especially those marked "Actionable."

---

## Findings

### S1 — AgentID Not Confirmed as Formal IETF Draft

**Location:** Section 9 (IETF OAuth WG)

**As written:** "**AgentID** (March 15, Warren Parad et al.) — identity protocol for autonomous AI agents within OAuth"

**Finding:** No IETF Internet Draft named "AgentID" by Warren Parad appears in the IETF datatracker. Multiple searches found Warren Parad active in the OAuth WG mailing list in March 2026, with references to an "AgentID — An Identity Protocol for Autonomous AI Agents" proposal in mailing list discussions, but no formal filed draft (draft-parad-* or similar) could be confirmed.

**Status:** This appears to be a mailing-list proposal, not a filed IETF Internet Draft.

**Impact:** Medium. The scout summary and Updated Summary both list AgentID as a citable IETF draft: "OAuth-for-agents chapter should reference AgentID, aiagent-auth-00, and CAAM." If Ghosty cites AgentID as an IETF draft in the book, that would be a factual error.

**Fix required:** Flag for Ghosty: AgentID is an OAuth WG mailing-list discussion/proposal, not a confirmed formal IETF Internet Draft. Do not cite it as "draft-*" in the book until a formal submission is confirmed. The other two (draft-klrc-aiagent-auth-00 and draft-barney-caam-00) are confirmed filed drafts.

---

### M1 — A2A Star Count Slightly High

**Location:** Section 3 (Google A2A)

**As written:** "22.6k stars"

**Finding:** Current star count is approximately 21.9k. Star counts fluctuate; the discrepancy is small and expected for a document written days before the verification. Not a material error for a scout brief.

**Fix:** Not required for the scout document. If Ghosty uses a specific star count in a book chapter, it should be cited with an "as of [date]" qualifier or omitted as an unstable metric.

---

## Confirmed Claims

**A2A v1.0.0:**
- v1.0.0 exists and is released. Confirmed at a2a-protocol.org and GitHub.
- Linux Foundation backing: confirmed (Linux Foundation AI & Data launched the A2A Protocol Project).
- Apache 2.0 license: confirmed.
- OAuth modernization (removed implicit/password flows, added PKCE and device code flow): confirmed.
- Authentication schemes embedded in Agent Cards: confirmed.
- Multi-tenancy support: confirmed.

**NIST NCCoE Concept Paper:**
- Title confirmed: "Accelerating the Adoption of Software and AI Agent Identity and Authorization."
- URL confirmed: nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf
- Publication date: February 5, 2026.
- Public comment deadline April 2, 2026: confirmed.

**MCP-I at DIF:**
- Vouched donating MCP-I to DIF: confirmed.
- DIF Trusted AI Agents Working Group and MCP-I Task Force: confirmed.
- Technical claims (DIDs, VCs, proof of principal authorization, delegated scope, three conformance tiers): confirmed.

**IETF OAuth WG — confirmed drafts:**
- draft-klrc-aiagent-auth-00 (Pieter Kasselman, March 2, 2026): confirmed in IETF datatracker.
- draft-barney-caam-00 (Jonathan Barney, Contextual Agent Authorization Mesh): confirmed in IETF datatracker.

**Clinejection:**
- URL (adnanthekhan.com/posts/clinejection/) confirmed and post exists.
- Attack mechanism confirmed: prompt injection against Cline's AI-powered issue triage system, chained into GitHub Actions cache poisoning to steal NPM release secrets.
- Date note: Original post was published February 9, 2026. Simon Willison linked it on March 6, 2026 (hence the date in the scout's "Willison" section). The scout's attribution is coherent: it appears under the Willison section, dated to his link. No error.

**W3C VC Working Group Charter 2026:**
- URL confirmed: w3c.github.io/vc-charter-2026/
- Confidence Method as a normative spec: confirmed.
- "API for Lifecycle Management": plausible (VC-API work exists) but specific title and total count of seven specs could not be independently confirmed from search results alone.

---

## Routing

**Send to Ghosty** with one actionable flag:

1. **S1 (required):** AgentID is not a confirmed formal IETF draft — treat as a mailing-list proposal. Only cite draft-klrc-aiagent-auth-00 and draft-barney-caam-00 as confirmed IETF Internet Drafts in the book.
2. **M1 (advisory):** Omit or qualify A2A star counts in book text — they are unstable metrics.

The other actionable items in the scout (NIST paper, MCP-I at DIF, Clinejection, A2A v1.0.0 release, IETF aiagent-auth-00 and CAAM) are confirmed and usable in the book.

---

## Conclusion

Scout brief is substantially accurate. One caveat: AgentID should not be cited as a formal IETF draft until a filed draft is confirmed. All other key actionable items are confirmed.
