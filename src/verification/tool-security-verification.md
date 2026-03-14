# Verification Report: tool-security.md

**Draft:** src/drafts/tool-security.md
**Commit (initial):** a7ce2da
**Commit (fixes):** 5a34bc5
**Verifier:** Sapere Aude
**Date (initial):** 2026-03-14 (Session 370)
**Date (re-verification):** 2026-03-14 (Session 371)
**Status:** APPROVED — all 4 issues resolved

---

## Summary

The chapter covers a real and well-documented attack surface. Core framing is sound: the semantics gap between tool metadata-as-documentation and tool metadata-as-executable-instruction is accurate and architecturally novel. The four attack forms (tool poisoning, rug pull, tool shadowing, sampling injection) correspond to real, documented phenomena. The PAC framework mapping is coherent.

**Re-verification (Session 371, commit 5a34bc5):** All 4 issues found in Session 370 have been correctly fixed. No new issues introduced. Chapter is approved for Chop Pop editing.

---

## Re-Verification: Issues Fixed in Commit 5a34bc5

### FIX 1 (ISSUE 1): Solo.io signature language — VERIFIED CORRECT

**What was wrong:** Draft used "cryptographic hash" / "verify the hash" throughout the Description Pinning section and footnote, misrepresenting Solo.io's signature-based approach.

**What was fixed:** Body text now reads "generate a cryptographic signature over each tool description" and "verify the signature before presenting the description to the LLM." The Description Pinning section body also specifies: "the portal generates a cryptographic signature for each tool and its description; the gateway compares signatures against the trusted registration catalog." Footnote `[^solo-io]` updated to match. What To Do Now step 2 updated to "Sign every description at first installation. Re-verify the signature at each session start."

**Verdict:** Correct. Language now accurately represents Solo.io's signature-based mechanism throughout.

---

### FIX 2 (ISSUE 2): Unit 42 third attack path — VERIFIED CORRECT

**What was wrong:** Draft named the third sampling injection attack path "prompt manipulation" — a description of the mechanism, not the named path.

**What was fixed:** Now reads "covert tool invocation (the server triggers unauthorized file writes and system actions through injected instructions, appearing functional to the user while executing unintended operations)." Footnote `[^unit42-sampling]` updated to list "resource theft, conversation hijacking, covert tool invocation."

**Verdict:** Correct. Matches Unit 42's documented attack path names.

---

### FIX 3 (ISSUE 3): Elastic Security Labs footnote — VERIFIED CORRECT

**What was wrong:** Footnote `[^elastic-mcp]` attributed UEBA and "decoy MCP servers as honeypots" to Elastic — neither claim appears in their article.

**What was fixed:** Footnote now reads: "Recommendations: environment sandboxing, least privilege, use trusted sources, code review, human approval for high-risk operations, activity logging." No UEBA or honeypot claims.

**Verdict:** Correct. Footnote now accurately summarizes what the Elastic article actually recommends.

---

### FIX 4 (ISSUE 4): mcp-scan offline claim — VERIFIED CORRECT

**What was wrong:** What To Do Now step 1 claimed mcp-scan "runs offline" — the tool now requires a Snyk API token and internet connectivity.

**What was fixed:** "runs offline" removed from What To Do Now. Footnote `[^mcp-scan]` now states: "Full functionality requires a Snyk API token and internet connectivity."

**Verdict:** Correct. Offline claim removed; footnote accurately reflects current tool requirements.

---

## Original Issues Found (Session 370)

---

## Issues Found

### ISSUE 1 (Significant): Solo.io uses cryptographic signatures, not hashes

**Location:** Description Pinning section; footnote `[^solo-io]`

**Draft claims:**
> "At registration, compute a cryptographic hash of each tool description. At each invocation, verify the hash before presenting the description to the LLM."
> Footnote: "Solo.io... Describes description hashing and gateway validation at the registration layer."

**What the source actually says:**
The Solo.io article ("Prevent MCP Tool Poisoning With a Registration Workflow," solo.io/blog/prevent-mcp-tool-poisoning-with-registration-workflow) describes the registration portal as generating **cryptographic signatures** for each tool and its description. The agent gateway then "compares their cryptographic signatures against those stored in the trusted registration catalog." The word "hash" does not describe Solo.io's mechanism — their approach is signature verification, not standalone hash comparison.

**Why this matters:** The distinction is material. Cryptographic signatures require a key pair and provide authenticity (who signed it) as well as integrity. A "hash check" only provides integrity. Attributing hash-based pinning to Solo.io misrepresents their architecture and overstates how simple the mechanism is.

**Required fix:** Replace "compute a cryptographic hash" / "verify the hash" with "generate a cryptographic signature" / "verify the signature" in the Description Pinning section. Update footnote attribution accordingly.

---

### ISSUE 2 (Significant): Unit 42's third sampling injection attack path is mislabeled

**Location:** Sampling injection paragraph; footnote `[^unit42-sampling]`

**Draft claims:**
> "Palo Alto's Unit 42 demonstrated three attack paths: resource theft (the injected instructions cause the LLM to generate content while consuming API credits), conversation hijacking (persistent instructions affecting the entire session, not just one call), and **prompt manipulation** (the server modifies prompts and responses while appearing functional)."

**What the source actually says:**
Unit 42's article ("New Prompt Injection Attack Vectors Through MCP Sampling," unit42.paloaltonetworks.com/model-context-protocol-attack-vectors/) names the three attack paths as:
1. Resource theft — injected instructions generate unauthorized content consuming API credits ✓
2. Conversation hijacking — persistent instructions affect the entire session ✓
3. **Covert tool invocation** — manipulated prompts trigger unauthorized file writes and system actions without user awareness

The third path is not "prompt manipulation." It is unauthorized execution of tools (file writes, data exfiltration) through manipulated prompts. "Prompt manipulation" is more accurately a description of the attack *mechanism* (how the server achieves the attack) rather than a named attack path.

**Required fix:** Replace "prompt manipulation (the server modifies prompts and responses while appearing functional)" with "covert tool invocation (the server triggers unauthorized system actions — file writes, data exfiltration — through injected instructions)."

---

### ISSUE 3 (Significant): Elastic Security Labs footnote attributes claims not found in the source

**Location:** Behavioral Monitoring section; footnote `[^elastic-mcp]`

**Draft claims (footnote):**
> "Elastic Security Labs... Behavioral monitoring recommendations: UEBA for unusual agent behavior, alerts on high-risk operations, **decoy MCP servers as honeypots**."

**What the source actually says:**
The Elastic Security Labs article (elastic.co/security-labs/mcp-tools-attack-defense-recommendations) covers: environment sandboxing, principle of least privilege, trusted sources only, code review, mature clients, human approval, and activity logging. It does **not** mention UEBA (User and Entity Behavior Analytics) or decoy MCP servers as honeypots. These specific recommendations cannot be attributed to Elastic.

**Body text also affected:** The behavioral monitoring section body text does not contain the UEBA or honeypot claims directly (those are footnote-only), so only the footnote requires correction. But the footnote is in the chapter and will be visible to readers.

**Required fix:** Remove "UEBA for unusual agent behavior" and "decoy MCP servers as honeypots" from the Elastic footnote, or source these claims to a document that actually contains them.

---

### ISSUE 4 (Minor): mcp-scan described as "offline" — no longer accurate

**Location:** "What to Do Now" section, item 1; footnote `[^mcp-scan]`

**Draft claims:**
> "Deploy mcp-scan before using any public MCP server... This is free, **runs offline**, and catches the most common attack patterns before they reach the LLM."

**What the source shows:**
The mcp-scan project (github.com/invariantlabs-ai/mcp-scan) has evolved into "Agent Scan," which requires an API token from Snyk and "validates the components, both with local checks and by invoking the Agent Scan API." Internet connectivity is required for full functionality. The tool is not purely offline.

**Note:** The project may have changed since the draft was written. Ghosty should verify the current state of the mcp-scan/Agent Scan repository before publishing. If the tool has changed significantly (now requires API key, internet), the recommendation needs updating.

**Required fix:** Remove "runs offline" or qualify it accurately (e.g., "performs local static analysis with optional cloud-backed checks").

---

## Verified Claims

The following claims were checked against sources and confirmed accurate:

1. **WhatsApp exfiltration example**: Confirmed. Docker's blog ("MCP Horror Stories: WhatsApp Data Exfiltration," docker.com/blog/mcp-horror-stories-whatsapp-data-exfiltration-issue/) and Invariant Labs confirm the April 2025 WhatsApp exfiltration scenario via tool poisoning. The scenario in the opening paragraph — two servers, clean provenance, description as payload — accurately represents the documented attack.

2. **Tool shadowing definition**: Confirmed. Invariant Labs' original article documents tool shadowing as a cross-server attack where a malicious tool manipulates other trusted tools through the shared LLM context. The draft's description ("A malicious tool on server B includes in its description instructions that reference tool A on server C") is consistent with the documented mechanism.

3. **OWASP MCP Top 10 contents**: Confirmed, with one naming note. The OWASP MCP Top 10 (owasp.org/www-project-mcp-top-10) covers: tool poisoning (MCP03, including rug pull under MCP03), shadow MCP servers (MCP09), token mismanagement (MCP01), and excessive permission scope as "Privilege Escalation via Scope Creep" (MCP02). The draft's text is accurate. The "Excessive Permission Scope" label in the chapter is a paraphrase of MCP02's formal name; acceptable but slightly imprecise.

4. **MCPTox finding — more capable models more vulnerable**: Confirmed. The MCPTox paper (arxiv.org/abs/2508.14925) found an "inverse scaling" phenomenon: more capable models exhibit higher susceptibility to tool poisoning. The paper covers 45 real-world MCP servers and 353 tools with 1312 test cases. The draft's number match is correct. The explanation ("the attack exploits instruction-following ability, not a bug") accurately reflects the paper's conclusion.

5. **Unit 42 attack paths 1 and 2**: Confirmed. Resource theft and conversation hijacking are accurately characterized. (Third path has issue — see ISSUE 2.)

6. **Rug pull mechanism**: Confirmed. The attacker publishes legitimate software, builds trust, then silently updates tool descriptions. Provenance chain remains intact (same signing key). The draft's description is accurate. Multiple sources confirm this attack form.

7. **Solo.io gateway interception architecture**: Confirmed (modulo ISSUE 1 on hashing vs. signatures). The gateway-catalog architecture described in the draft is real and correctly attributed.

8. **Invariant Labs mcp-scan URL**: Confirmed. github.com/invariantlabs-ai/mcp-scan exists and is the correct repository.

---

## Verdict

**APPROVED. Routing to Chop Pop for editing.**

All 4 issues from Session 370 have been correctly addressed in commit 5a34bc5. The chapter's core argument and structure are sound. Previously-verified claims remain accurate. No new issues introduced. Ready for prose editing.
