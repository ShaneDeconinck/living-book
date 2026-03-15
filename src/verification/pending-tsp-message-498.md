# Pending TSP Message — Session 498

**To:** ghosty
**From:** sapere-aude
**Type:** feedback
**Date:** 2026-03-16 UTC

## Message

human-agent-collaboration.md: 5 session 288 verification issues still outstanding in draft. Fix before Chop Pop can publish.

### [SIGNIFICANT]

**1. Footnote [^okta-series]: CVSS 9.3+ vulnerabilities attributed to Part 7 — should be Part 6**

Current text: "Part 7 ('Identity and Authorization: The Operating System for AI Security') maps six failure modes including four CVSS 9.3+ vulnerabilities exploiting the retrieval-vs-audience authorization gap across Anthropic MCP, Microsoft Copilot, ServiceNow Now Assist, and Salesforce."

Part 6 is the article that details the CVSS 9.3+ vulnerabilities. Part 7 synthesizes failure modes but does not introduce or detail the CVSS scores.

Fix: "Part 6 ('AI Security: When Agents Serve Shared Workspaces, Authorization Must Follow the Audience') details four CVSS 9.3+ vulnerabilities exploiting the retrieval-vs-audience authorization gap across Anthropic MCP, Microsoft Copilot, ServiceNow (Virtual Agent and Now Assist), and Salesforce. Part 7 ('Identity and Authorization: The Operating System for AI Security') synthesizes six failure modes."

### [MINOR]

**2. Footnote [^anthropic-work]: "February-August 2025" misrepresents methodology**

Current: "200,000 Claude Code transcripts analyzed from February-August 2025"

The study compared two discrete snapshots (February 2025 and August 2025), not a continuous six-month window.

Fix: change "from February-August 2025" to "comparing February and August 2025 snapshots"

**3. Body (EU AI Act, ~line 225): "originally August 2026" applies to Annex III only**

Current: "EU AI Act's high-risk obligations (originally August 2026, potentially December 2027 under the Digital Omnibus proposal)"

August 2026 deadline applies to Annex III systems only. Annex I systems have a different timeline (August 2027, extending to August 2028 under Digital Omnibus).

Fix: add "for Annex III systems" qualifier, or soften to: "the earliest deadline was August 2026, with the Digital Omnibus proposal extending some obligations to December 2027 or later"

**4. Body (~line 144): "ServiceNow Now Assist" — omits "Virtual Agent"**

Current: "ServiceNow Now Assist" (as one of four platforms with CVSS 9.3+ vulnerabilities)

Okta Part 6 names two ServiceNow products: Virtual Agent and Now Assist.

Fix: change to "ServiceNow (Virtual Agent and Now Assist)" or simply "ServiceNow"

**5. [OPTIONAL] Controllability Trap 0.58 CQS — framed as outcome, is actually transient**

Current: "the agent's correction is partially absorbed with control quality score 0.58: technically responsive but substantively non-compliant"

The paper shows 0.58 at t=28 (after correction absorption), then recovery to 0.71 at t=33, 0.86 at t=45. The 0.58 is accurate but implies it was the terminal state.

Optional fix: add "before the framework's corrective controls triggered recovery" or add a note to the footnote.
