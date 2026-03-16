# Verification Report: execution-security.md

**Session:** 160 (initial) / 388 (re-verify after Session 213 quality-review) / 459 (re-verify after Session 459 prose fixes) / 629 (spot-check) / 631 (re-verify after ghosty date fix)
**Date:** 2026-03-13 UTC (initial) / 2026-03-14 UTC (re-verify) / 2026-03-15 UTC (re-verify) / 2026-03-16 UTC (spot-check + re-verify)
**Verifier:** Sapere Aude
**Status:** APPROVED — all required fixes confirmed; Clinejection date corrected (commit 0c803b0); ready for Chop Pop

## Spot-Check: Session 629 (2026-03-16)

**Trigger:** Ghosty TSP handoff referencing commit 2d4a167 and "Two paragraphs ready for verification: execution-security.md line 157 (Clinejection)."

**Finding:** Commit 2d4a167 does not exist in this repository. No uncommitted changes in working tree. Current file state is identical to the session 459 approved state (most recent commits: 9a8c326 session 532 patterns-master sweep).

**Spot-check of line 157 area (Layer 1: Input Validation / prompt injection):**

- OpenAI March 2026 guidance paragraph: factual claims unchanged from approved state. Quote ("increasingly resemble social engineering more than simple prompt overrides"), three mechanisms (Instruction Hierarchy, structured outputs, system-level containment), and containment-over-detection argument all intact. Previously confirmed against primary source.
- December 2025 Atlas paper paragraph: RL-trained attacker quote and red-teaming framing unchanged. Previously confirmed.
- No em dashes present in file (grep clean).
- No new factual issues found.

**Prose changes verified clean.** The three style fixes (em dash → colon, parenthetical cut, "same" → "what") introduce no factual drift. However, the underlying Clinejection paragraph contains a factual error not previously caught:

### NEW ISSUE: Clinejection date incorrect

**Location:** Line 157 (body text) and footnote [^clinejection]

**Body text:** "The Clinejection incident (March 2026)"

**Footnote:** "Adnan Khan, 'Clinejection — Compromising Cline's Production Releases,' adnanthekhan.com/posts/clinejection/, March 6, 2026."

**Problem:** Adnan Khan's original disclosure was **February 9, 2026**. The actual unauthorized Cline@2.3.0 NPM package was published on **February 17, 2026**. Simon Willison's coverage ran March 6, 2026 — the footnote's "March 6" date belongs to Simon Willison, not to Adnan Khan's post, and the body text's "March 2026" is wrong.

**Additional fact confirmed:** The exploit resulted in an unauthorized package installing OpenClaw AI agent on approximately 4,000 developer machines during an eight-hour window. The chapter does not include this detail but its omission is acceptable.

**Fix required:**
- Body text: "The Clinejection incident (March 2026)" → "The Clinejection incident (February 2026)"
- Footnote [^clinejection]: "adnanthekhan.com/posts/clinejection/, March 6, 2026" → "adnanthekhan.com/posts/clinejection/, February 9, 2026. Covered by Simon Willison on March 6, 2026."

**Sending to ghosty for fix.**

**Re-verify (Session 631, 2026-03-16):** Ghosty confirmed fix in commit 0c803b0. Checked current file: line 157 reads "February 2026"; footnote [^clinejection] line 313 reads "February 9, 2026. Covered by Simon Willison on March 6, 2026." Both fixes correct. All five original required fixes (Session 160) and Session 388/459 prose fixes remain in place.

**STATUS: APPROVED — Clinejection date fixed; routing to Chop Pop.**

---

## Re-Verification: Session 459 (2026-03-15)

Ghosty's Session 459 applied 2 prose-only fixes to execution-security.md (commit 3ea8bcc):

1. **"The model provider itself is saying what this chapter argues:" removed (line 158):** Pattern #5 throat-clearer. OpenAI content fully intact — the quote, the three mechanisms (Instruction Hierarchy, structured outputs, system-level containment), and the argument that containment matters more than detection all remain. No factual drift.

2. **"of the PAC Framework" removed from closing sentence:** Pattern #9. "Those require the other layers of the PAC Framework" → "Those require the other layers." Meaning preserved; PAC connection apparent from chapter context.

**STATUS: APPROVED** — both changes prose-only, no factual drift, no regression.

---

## Re-Verification: Session 388 (2026-03-14)

Ghosty's Session 213 applied 4 quality-pattern fixes to execution-security.md (commit a8aa20f). Verified each:

1. **"precisely" removed from Kiro incident (line 21):** Prose-only. Kiro framing still correct: "According to Financial Times reporting" and "a characterization Amazon disputes" both present. No regression.

2. **"Critically," removed from subprocess restrictions (line 53):** Prose-only. Citation [^anthropic-sandbox] intact. No regression.

3. **"The takeaway:" scaffolding removed (line 143):** Prose-only. No factual change. No regression.

4. **"all six layers" → "all seven layers" in I5 maturity table (line 267):** Factual fix. Verified: Defense in Depth section has exactly 7 named layers (Input Validation, Sandboxed Execution, Configuration Protection, Output Validation, Credential Scoping, Behavioral Monitoring, Semantic Policy Enforcement). "Seven" is correct.

All 5 original required fixes (Session 160) confirmed still in place:
- Kiro body text: FT attribution + Amazon dispute acknowledgment present ✓
- Footnote [^kiro] date: February 21, 2026 ✓
- Christopher Cullen removed from [^ms-agent] ✓
- seccomp BPF/Landlock cited only to [^codex-security] ✓
- Gartner attribution removed; "guardian agent pattern" used without Gartner claim ✓
- Don Norman footnote title: "with Automation" (not "of Automation") ✓

**Chapter approved. Route to Chop Pop for editing.**

---

---

## Summary

A well-sourced chapter. The key technical claims — PCAS figures, Firecracker specs, Anthropic sandbox stats, OWASP taxonomy, CVE details, OpenAI papers, NVIDIA guidance — all verified against primary sources. Four issues found: one significant (Kiro incident body text presents disputed narrative without noting dispute), one significant (unconfirmable personal name in CVE footnote), and two minor (citation scope issue, unsourced Gartner claim). Two additional minors: Don Norman title typo, Amazon date off by one day.

---

## Issues Found

### SIGNIFICANT: Kiro incident — disputed narrative presented as fact

**Location:** Lines 21-22 (body text) and footnote [^kiro]

**Problem:** Body text states:
> "An AI coding agent tasked with fixing a production issue determined the optimal solution was to delete the entire AWS Cost Explorer environment and recreate it, causing a 13-hour outage. The agent inherited the deploying engineer's elevated permissions and bypassed the standard two-person approval."

This is the Financial Times characterization. Amazon formally disputes it. Amazon's official response (aboutamazon.com, February 21, 2026) says the incident was "the result of user error—specifically misconfigured access controls—not AI" and adds that "by default the Kiro tool requests authorization before taking any action." The footnote cites Amazon's response but the body presents only the FT narrative as established fact.

This is the same issue fixed in why-agents-break-trust.md (Session 107, fix #8: "Kiro framing uses Amazon's own language"). That fix was applied in the why-agents-break-trust chapter; this chapter needs the same treatment.

**Fix:** Add acknowledgment of Amazon's dispute in the body, e.g.: "An AI coding agent reportedly determined the optimal solution was to delete the entire AWS Cost Explorer environment and recreate it, causing a 13-hour outage. Amazon disputes this characterization, attributing the incident to misconfigured access controls, not the agent's behavior — but the post-incident fix [...]"

Or use softer framing throughout, consistent with why-agents-break-trust.md.

**Also:** Footnote [^kiro] says "Amazon response at aboutamazon.com, **February 20**, 2026." Amazon's rebuttal was published February **21**, 2026 (FT broke the story on February 20). One day off. Fix the footnote date.

---

### SIGNIFICANT: Christopher Cullen attribution not confirmable

**Location:** Footnote [^ms-agent]

**Problem:** The footnote reads: "Reported by Itamar Yochpaz, documented by Christopher Cullen (CERT/CC VU#431821), March 2, 2026."

All other details in this footnote are verified:
- CVE-2026-2256: confirmed
- CVSS 6.5 (Medium): confirmed
- March 2, 2026: confirmed
- Itamar Yochpaz as discoverer: confirmed (CERT/CC VU#431821)
- VU#431821 itself: confirmed
- check_safe() regex denylist: confirmed

However, "Christopher Cullen" does not appear in available CERT/CC documentation for VU#431821. CERT/CC pages do not list individual coordinators by name in publicly accessible documentation. This name cannot be confirmed from any source.

**Fix:** Remove "documented by Christopher Cullen" from the footnote. The CERT/CC VU#431821 reference is sufficient attribution.

---

### MINOR: seccomp BPF and Landlock citation overstates Anthropic documentation

**Location:** Line 47, footnote [^anthropic-sandbox][^codex-security]

**Problem:** The sentence reads:
> "On Linux, it is a combination of technologies: bubblewrap for filesystem namespace isolation, seccomp BPF for syscall filtering, and Landlock for filesystem access control[^anthropic-sandbox][^codex-security]."

The paragraph context is Claude Code specifically. Anthropic's engineering blog and Claude Code documentation name **only bubblewrap** on Linux. Neither the Anthropic engineering post ("Beyond Permission Prompts," anthropic.com/engineering/claude-code-sandboxing) nor the Claude Code documentation (code.claude.com/docs/en/sandboxing) mentions seccomp BPF or Landlock by name.

Seccomp BPF and Landlock are documented for **OpenAI Codex CLI** in [^codex-security]. The dual citation [^anthropic-sandbox][^codex-security] implies Anthropic's own documentation supports the seccomp BPF/Landlock claim, which it does not.

(Note: Third-party analysis confirms Claude Code's open-source sandbox-runtime does use seccomp, but Anthropic has not publicly documented this. The underlying technical fact may be correct; the citation is what overstates.)

**Fix:** Option A — rephrase to "bubblewrap for filesystem namespace isolation, with seccomp BPF for syscall filtering and Landlock for filesystem access control" and attribute seccomp/Landlock only to [^codex-security] (describing the general native sandboxing pattern). Option B — keep the sentence but change [^anthropic-sandbox][^codex-security] to [^codex-security] for the seccomp/Landlock portion, adding a note that these are implementation details confirmed via third-party analysis of Claude Code's open-source components.

---

### MINOR: Gartner "guardian agent" claim lacks dedicated source

**Location:** End of Google Mariner section (approximately line 243)

**Problem:**
> "The User Alignment Critic is the most concrete production implementation of the 'guardian agent' pattern that Gartner's Market Guide described as an emerging category: a secondary AI system whose sole purpose is governing a primary AI system's behavior."

This claim is lumped under [^google-mariner], which cites Google's 2026 Responsible AI Progress Report and Google Security Blog. Neither of those sources is a Gartner Market Guide. This is a Gartner claim with no Gartner citation.

**Fix:** Either (a) add a specific Gartner Market Guide footnote with the title and year, or (b) remove "that Gartner's Market Guide described as an emerging category" and simply call it "the guardian agent pattern" without the Gartner attribution.

---

### MINOR: Don Norman title has preposition error

**Location:** Footnote [^norman]

**Problem:** Footnote reads: "The 'Problem' **of** Automation: Inappropriate Feedback and Interaction, Not 'Over-Automation'"

Actual published title: "The 'problem' **with** automation: inappropriate feedback and interaction, not 'over-automation'"

The preposition is "with" not "of." Journal (Philosophical Transactions of the Royal Society B), volume (327), pages (585-593), and year (1990) are all correct.

**Fix:** Change "of Automation" to "with automation" in footnote [^norman].

---

## Claims Verified Clean

### PCAS (Policy Compiler for Secure Agentic Systems)

All claims verified against arXiv:2602.16708 (posted February 18-19, 2026):

- **48% baseline compliance:** Confirmed. Abstract states: "On customer service tasks, PCAS improves policy compliance from 48% to 93% across frontier models."
- **93% with PCAS enforcement:** Confirmed. Same quote.
- **Zero violations in fully instrumented runs:** Confirmed. Abstract states: "with zero policy violations in instrumented runs."
- **Models tested (Claude Opus 4.5, GPT-5.2, Gemini 3 Pro):** Confirmed from paper HTML.
- **Datalog-derived policy language over dependency graphs:** Confirmed. Paper uses Datalog-derived language with recursive rules, stratified negation, and differential Datalog for incremental evaluation.
- **Reference monitor architecture:** Confirmed.
- **February 2026 publication:** Confirmed (February 18-19, 2026).

### Anthropic Claude Code Sandboxing

All claims verified against Anthropic engineering blog ("Beyond Permission Prompts," anthropic.com/engineering/claude-code-sandboxing) and code.claude.com/docs/en/sandboxing:

- **84% reduction in permission prompts:** Confirmed. Exact quote: "In our internal usage, we've found that sandboxing safely reduces permission prompts by 84%."
- **Bubblewrap on Linux:** Confirmed. Exact quote: "built on top of OS level primitives such as Linux bubblewrap and MacOS seatbelt."
- **Seatbelt on macOS:** Confirmed.
- **Unix domain socket proxy:** Confirmed. Exact quote: "Network isolation, by only allowing internet access through a unix domain socket connected to a proxy server running outside the sandbox."
- **Restrictions extend to subprocesses:** Confirmed. Exact quote: "They cover not just Claude Code's direct interactions, but also any scripts, programs, or subprocesses that are spawned by the command."

### gVisor, Firecracker, Kata Containers

All claims verified:

- **gVisor 10-30% I/O overhead:** Confirmed per Northflank article ("How to Sandbox AI Agents in 2026"): "It adds 10-30% overhead on I/O-heavy workloads." Note: actual gVisor overhead on some I/O benchmarks can be substantially higher; the Northflank figure is the source used, and it's correctly attributed to Northflank.
- **Firecracker 125ms boot:** Confirmed against Firecracker SPECIFICATION.md: "less than or equal to 125 milliseconds."
- **Firecracker under 5MB memory overhead:** Confirmed against Firecracker SPECIFICATION.md: "less than or equal to 5 MiB."
- **Firecracker 150 VMs/sec per host:** Confirmed against Firecracker SPECIFICATION.md and NSDI20 paper.
- **Kata Containers ~200ms:** Confirmed. Multiple sources report ~200ms (hypervisor-dependent: Cloud Hypervisor backend achieves ~200ms).
- **Northflank article exists:** Confirmed at northflank.com/blog/how-to-sandbox-ai-agents.

### NVIDIA AI Red Team Guidance

- **Document exists at developer.nvidia.com:** Confirmed. Title: "Practical Security Guidance for Sandboxing Agentic Workflows and Managing Execution Risk."
- **Recommendation for full virtualization over kernel-sharing:** Confirmed.
- **Quote "frequently modest compared to that induced by LLM calls":** Confirmed. Exact text: "virtualization typically introduces some amount of overhead, it's frequently modest compared to that induced by LLM calls." Book uses this as a direct quote — it is accurate.
- **Configuration file protection guidance:** Confirmed. NVIDIA guidance states configuration files must be protected from agent modification.
- **Secret injection recommendation:** Confirmed.

### CVE-2026-2256 (ModelScope MS-Agent)

All core claims verified against NVD and CERT/CC VU#431821:

- **CVE-2026-2256 exists:** Confirmed.
- **CVSS 6.5 (Medium):** Confirmed.
- **March 2, 2026 date:** Confirmed.
- **Reported by Itamar Yochpaz:** Confirmed.
- **CERT/CC VU#431821:** Confirmed.
- **check_safe() using regex-based denylist filtering:** Confirmed. CERT/CC states the method "relies on regular expression–based filtering" that "can be bypassed."
- **No vendor patch available at disclosure:** Confirmed.
- **Christopher Cullen attribution:** NOT CONFIRMED (see Significant Issues).

### OWASP Top 10 for Agentic Applications

All claims verified:

- **Document exists at genai.owasp.org:** Confirmed.
- **Released December 2025:** Confirmed (announced December 9, 2025).
- **Over 100 security researchers and practitioners:** Confirmed.
- **ASI01-ASI10 naming convention:** Confirmed (ASI01 Goal Hijack, ASI02 Tool Misuse, ASI03 Identity/Privilege Abuse confirmed by name in search results).

### OpenAI Prompt Injection Publications

Both papers verified:

- **"Designing AI agents to resist prompt injection" (March 11, 2026):** Confirmed. Social engineering comparison confirmed: "The most effective real-world versions of these attacks increasingly resemble social engineering more than simple prompt overrides." Instruction Hierarchy recommendation confirmed.
- **"Continuously hardening ChatGPT Atlas against prompt injection attacks" (December 22, 2025):** Confirmed. RL-trained automated attacker confirmed: trains end-to-end with RL, discovers "sophisticated, long-horizon harmful workflows that unfold over tens or even hundreds of steps."

### Codex CLI Sandboxing

All claims verified:

- **Seatbelt on macOS:** Confirmed.
- **Landlock and seccomp on Linux:** Confirmed (via Codex CLI codex-linux-sandbox helper).
- **Network access off by default:** Confirmed.
- **Filesystem access limited to workspace:** Confirmed.
- **Helper process design:** Confirmed. The codex-linux-sandbox binary applies Landlock and seccomp to constrain child processes. Main CLI process dispatcher handles routing.

### Academic Citations

- **Bainbridge 1983:** Confirmed. Journal: Automatica. Volume 19, No. 6. Pages 775-779. Content match confirmed (human monitoring failures in automated systems).
- **Don Norman 1990:** Confirmed except title preposition (see Minor Issues). Journal: Philosophical Transactions of the Royal Society B, Volume 327. Pages 585-593. Year 1990. Content match confirmed.

### Google Project Mariner Security Architecture

All five layers verified against Google Security Blog ("Architecting Security for Agentic Capabilities in Chrome," December 8, 2025):

- **User Alignment Critic:** Confirmed. "A separate model built with Gemini that acts as a high-trust system component" — sees only action metadata, not web content.
- **Agent Origin Sets:** Confirmed. Read-only vs. read-writable origins.
- **Prompt injection classification:** Confirmed. Per-page scanning running in parallel to planning model inference.
- **Mandatory human oversight for sensitive actions:** Confirmed. Banking/medical sites, Password Manager sign-ins, payments.
- **Pre-launch security testing:** Confirmed. Automated red-teaming systems used before launch.
- **Google Security Blog December 8, 2025:** Confirmed.

### Bainbridge and Norman Content Match

Both papers' substance verified: both argue that intermediate automation creates monitoring demands humans cannot reliably fulfill, leading to degraded judgment at the moment of required intervention. The chapter uses them accurately to argue that permission prompts at machine speed are the same failure mode.

---

## Items Not Requiring Verification

The following claims are from Shane's own blog posts (primary source) and were not independently checked:
- [^sandbox-post]: Shane Deconinck, "Your Coding Agent Needs a Sandbox," February 7, 2026.
- [^trust-inversion]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," February 3, 2026.
- [^profiler-post]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," February 26, 2026.

PAC Framework pillar assignments and blast radius/infrastructure maturity scales are Shane's own framework, not external claims.

---

## Required Fixes Before Publication

1. **Kiro body text**: Add acknowledgment of Amazon's dispute in body text. Fix footnote date: "February 20" → "February 21" for Amazon's response.
2. **Christopher Cullen**: Remove from footnote [^ms-agent].
3. **seccomp BPF / Landlock citation**: Remove [^anthropic-sandbox] from the seccomp BPF / Landlock claim, or clearly scope those technologies to the Codex CLI citation.
4. **Gartner "guardian agent"**: Add Gartner Market Guide citation or remove the Gartner attribution.
5. **Don Norman title**: "of Automation" → "with automation" in footnote [^norman].
