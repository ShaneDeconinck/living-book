# Verification Report: agent-runtime-safety-standards.md

**Session:** 768
**Date:** 2026-03-17 UTC
**Verifier:** Sapere Aude
**Status:** MINOR ISSUES ONLY — 2 fixes required; send to ghosty, then chop-pop

---

## Summary

A well-sourced new chapter on Gen Digital's AARTS (AI Agent Runtime Safety Standard). All major technical claims verified against primary sources. Two minor issues found: one imprecise framing for the Vercel partnership (scoped to AI Skills ecosystem, not AARTS specifically), and one imprecise description of the DataTalksClub incident (agent "requesting" vs. "reading" credentials).

---

## Issues Found

### MINOR 1: Vercel partnership framing overstates AARTS specificity

**Location:** Line 57 (body text) and footnote [^gen-sage]

**What the chapter claims:**
> "The Vercel partnership (announced February 17, 2026) is structurally interesting: Vercel is not an agent framework, it is a deployment platform. The partnership brings AARTS-based safety verification to Vercel's AI skills ecosystem..."

**What the source says:**

The Gen Digital / Vercel press release (newsroom.gendigital.com/2026-02-17-Gen-and-Vercel-Partner-to-Bring-Independent-Safety-Verification-to-the-AI-Skills-Ecosystem) describes the partnership as "independent safety verification for the AI skills ecosystem" via Gen's Agent Trust Hub. The specific capability involved is an AI Skills Scanner for skills.sh, not the AARTS standard itself.

AARTS is one component of the broader Agent Trust Hub; the Vercel partnership is about the Agent Trust Hub's scanning capability, not AARTS specifically. Calling it "AARTS-based safety verification" overstates the connection.

**Fix required:** "brings AARTS-based safety verification to Vercel's AI skills ecosystem" → "brings Gen's Agent Trust Hub safety verification to Vercel's AI skills ecosystem" (or "brings independent safety verification to Vercel's AI skills ecosystem").

The date (February 17, 2026) and structural observation about skills.sh as a distribution layer are both correct.

---

### MINOR 2: DataTalksClub — "requesting" vs. "reading" credentials

**Location:** Line 39 (body text)

**What the chapter claims:**
> "The DataTalksClub incident (Terraform destroying production infrastructure because the agent had production credentials) would have had a different outcome if a PreFileRead hook had verified that the agent requesting AWS credentials was authorized to hold them."

**What the source says:**

Per the verified execution-security.md draft (footnote [^datatalks], February 26, 2026): the agent already had production AWS credentials. It read the credentials from the existing environment to perform its Terraform work. It did not "request" credentials from a service or credential store in the sense of initiating a new credential acquisition.

The AARTS mechanism described (PreFileRead intercepting a read of a credential file) is technically accurate. But the phrase "the agent requesting AWS credentials" implies the agent was initiating a credential request, not reading an existing credential file. The correct framing is "the agent reading AWS credentials."

**Fix required:** "the agent requesting AWS credentials was authorized to hold them" → "the agent reading AWS credentials from the environment was authorized to access them"

---

## Claims Verified Clean

### Gen Digital AARTS

- **AARTS introduction date "March 2026":** Confirmed. Blog post "Introducing AARTS: An Open Standard for AI Agent Runtime Safety" at gendigital.com published March 5, 2026. ✓
- **AARTS v0.1 defines 19 hook points:** Confirmed against primary blog post. ✓
- **Three component types (host, engine, adapter):** Confirmed exactly. The host intercepts and enforces; the adapter translates; the engine evaluates and returns verdicts. ✓
- **Verdict semantics (allow/deny/modify/redirect):** Confirmed. ✓
- **Skill IDs as content-addressable fingerprints:** Confirmed. Same skill → same ID; modified skill → different ID. ✓
- **"Leading the Way for AI Agent Safety," gendigital.com, February 4, 2026:** Confirmed. Associated with Agent Trust Hub launch (February 4, 2026 press release at newsroom.gendigital.com). The blog article covers AARTS at a high level; detailed AARTS claims should cite the March 5 post, which the chapter correctly does via [^gen-aarts]. ✓

### Gen Digital Sage

- **Open-source Sage tool with 200+ detection rules:** Confirmed. Published under avast/sage on GitHub. The chapter does not misstate the org. ✓
- **Four detection categories (supply chain, credential exposure, dangerous commands, persistence):** Confirmed per Gen Digital blog post and Sage GitHub README. ✓
- **Help Net Security article "Open-source tool Sage puts a security layer between AI agents and the OS," March 9, 2026:** Confirmed at helpnetsecurity.com/2026/03/09/open-source-tool-sage-security-layer-ai-agents/. ✓
- **Vercel partnership date (February 17, 2026):** Confirmed. (See Minor 1 for framing issue.) ✓

### Kai Security MCP CVE Analysis

- **"30 CVEs Later" article exists at dev.to:** Confirmed. ✓
- **43% of MCP CVEs classified as exec/shell injection:** Confirmed. Kai Security reports 13/30 CVEs (43%) as exec/shell injection. This is consistent with the gaps.md verified figures. ✓
- Note: gaps.md uses "53% of MCP CVEs" for "injection and path traversal classes combined" (43% exec/shell + 10% path traversal). The agent-runtime-safety-standards chapter correctly uses 43% for exec/shell only, which is the more precise figure. ✓

### Cross-References to Verified Content

- **CVE-2026-2256 (ModelScope MS-Agent, denylist check_safe() bypass):** Previously verified in execution-security-verification.md Sessions 160/388. CVE number, CVSS 6.5, March 2, 2026, Itamar Yochpaz reporter, CERT/CC VU#431821 all confirmed. ✓
- **SANDWORM_MODE (19 typosquatting npm packages targeting MCP server infrastructure):** Previously verified in gaps-verification.md (Session batch including SANDWORM_MODE/SnailSploit). Source: Socket Threat Research Team, February 2026; 19 packages confirmed; multi-stage credential theft confirmed. ✓
- **ClawJacked (CVE-2026-25253):** Previously verified in supply-chain-security-verification.md Session 284. ✓
- **DataTalksClub incident (Terraform destroying production infrastructure, agent had production credentials):** Previously verified in execution-security.md (Session 190 delta, February 26, 2026 incident). Agent had production credentials, ran `terraform destroy` via Claude Code, destroying RDS database (1.9M rows), VPC, ECS cluster, and backups. (See Minor 2 for framing precision issue.) ✓
- **sigstore-a2a (github.com/sigstore/sigstore-a2a):** Previously verified in supply-chain-security-verification.md Session 403. Repository confirmed. ✓
- **Luke Hinds, "Building Trust in the AI Agent Economy: Sigstore Meets Agent2Agent," dev.to, July 2025:** Confirmed. Published July 31, 2025. ✓
- **Rekor transparency log, Fulcio CA, SLSA provenance attestation:** Previously verified across multiple sessions. ✓

### AARTS Hook Specifics

- **PreSkillLoad / PrePluginLoad as supply chain hooks:** Confirmed against AARTS architecture. ✓
- **PreLLMRequest for prompt integrity:** Confirmed as a defined hook in AARTS v0.1. ✓
- **PreToolUse for tool/shell execution interception:** Confirmed. ✓
- **PreFileRead / PreFileWrite for credential path protection:** Confirmed. ✓
- **AARTS v0.1 is draft, not ratified standard:** Confirmed — correctly caveated in the chapter. ✓
- **Adoption outside Gen's ecosystem not established as of March 2026:** Confirmed — correctly caveated. ✓

---

## Required Fixes Before Publication

| # | Severity | Location | Required Fix |
|---|---|---|---|
| 1 | **Minor** | Line 57 | "brings AARTS-based safety verification" → "brings Gen's Agent Trust Hub safety verification" |
| 2 | **Minor** | Line 39 | "the agent requesting AWS credentials was authorized to hold them" → "the agent reading AWS credentials from the environment was authorized to access them" |

---

## Routing

Both issues are minor prose fixes. Send to **ghosty** for correction, then route to **chop-pop** for editing.
