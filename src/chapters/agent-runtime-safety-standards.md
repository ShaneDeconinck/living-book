# Agent Runtime Safety Standards

If an organization deploys three agent frameworks, it gets three independent sandboxes. If a security team wants to enforce consistent policy across all three, they have no common interface to write against. They write it three times, in three different formats, and audit three different enforcement points.

Gen Digital's AARTS (AI Agent Runtime Safety Standard), introduced in March 2026, is the first structured attempt to standardize not just what containment does but how it plugs in.[^gen-aarts]

## Why Architecture Alone Is Not Enough

The execution security chapter establishes the principle: containment must be structural, not advisory. A sandbox that prevents filesystem access outside the working directory is a structural control. A permission prompt asking the user to approve each file write is an advisory one.

Structural controls are implemented today by individual tools, not shared infrastructure. Claude Code's native OS sandbox (Seatbelt on macOS, Landlock + seccomp BPF on Linux) and OpenAI Codex CLI's equivalent are both sound implementations of the same principle. They are also separate implementations with separate rule sets, separate update cycles, and no shared interface for external security engines to plug into.

## Three Components, One Interface

AARTS defines three component types and the interface between them:[^gen-aarts]

**Agent hosts** are the environments where agents run: IDEs, orchestrators, agent frameworks, coding assistants. The host intercepts agent actions at defined hook points and passes them to a security engine for evaluation.

**Security engines** receive the intercepted actions, evaluate them against policy, and return verdicts. They implement the detection and policy logic. The host does not need to know how the engine decides. The engine does not need to know how the host executes.

**Adapters** translate host-native events into the common schema the security engine expects. A host that represents file write events differently than the AARTS schema can ship an adapter without modifying the host itself.

The separation creates a market for security engines independently of agent hosting. A security team can build or buy a security engine that enforces their policies, and any AARTS-compliant host can use it without integration work. The architectural equivalent is how OS-level syscall interception (seccomp BPF, eBPF) works: the policy language is standardized; the enforcement point is in the kernel; any process runs under it without modification.

## Nineteen Hook Points

AARTS v0.1 defines 19 hook points across the agent lifecycle.[^gen-aarts] Four categories map directly to documented attack surfaces:

**PreToolUse** fires before a tool executes: shell commands, file writes, web requests, package installs. This is where injection attacks land. The execution security chapter documents CVE-2026-2256 in ModelScope's MS-Agent, where a denylist-based `check_safe()` method failed against reformulated shell commands. AARTS's PreToolUse hook is not a denylist: it passes the action to an external security engine that can apply behavioral analysis rather than pattern matching. The 43% of MCP CVEs classified as exec/shell injection are the natural target of this hook.[^kai-30-cves]

**PreLLMRequest** fires before a prompt reaches the model, intercepting injected instructions before they enter the model's context. The tool poisoning chapter covers indirect injection chains (the Graphiti CVE: untrusted content to LLM to MCP tool parameter to database query). PreLLMRequest creates an interception point before the first link in that chain.

**PreSkillLoad and PrePluginLoad** fire before a skill or plugin is loaded into the agent environment. These are the supply chain hooks. The supply chain security chapter covers SANDWORM_MODE (19 typosquatting npm packages targeting MCP server infrastructure) and ClawJacked. A security engine receiving a PreSkillLoad event can verify the skill against a known-good manifest, check its Skill ID (described below), or reject it if it has no provenance attestation.

**PreFileRead** and **PreFileWrite** protect credentials and sensitive paths. The DataTalksClub incident (Terraform destroying production infrastructure because the agent had production credentials) would have had a different outcome if a PreFileRead hook had verified that the agent reading AWS credentials from the environment was authorized to access them.

## Skill IDs: Content-Addressable Integrity

Alongside the hook interface, AARTS introduces Skill IDs: content-addressable fingerprints for agent skills.[^gen-aarts]

A Skill ID is a deterministic identifier derived from skill content. The same skill produces the same ID. A modified skill produces a different ID. This means a skill can be verified independently of where it was downloaded: an organization audits a skill, records its Skill ID, and any subsequent deployment can confirm it is running the audited version.

The supply chain security chapter covers SBOMs (Software Bills of Materials) for agent components: an inventory of what an agent is made of, with provenance for each component. Skill IDs operate at a finer grain: not just "this skill came from this package" but "this skill has this exact content."

The sigstore-a2a pattern provides complementary coverage: Sigstore's keyless signing records build provenance (where did this agent come from, and through what pipeline?) in the Rekor transparency log. Skill IDs verify content integrity (is this the skill I audited?). Sigstore-a2a answers: this skill was built from commit X in repository Y through pipeline Z. The Skill ID answers: this skill's content has not changed since I audited it.[^sigstore-a2a]

## Sage: The Reference Implementation

Gen's open-source Sage tool implements AARTS with 200+ detection rules covering four categories: supply chain attacks (typosquatting, compromised packages), credential exposure (reads from credential paths), dangerous commands (destructive shell commands, privilege escalation), and persistence mechanisms (cron modifications, shell config writes).[^gen-sage]

Sage integrates Gen's threat intelligence: detection rules are updated as new attacks are documented. The 19 typosquatting packages from SANDWORM_MODE, once identified, become detection signatures that any Sage user benefits from. This is the security engine operating as shared infrastructure rather than per-tool reimplementation.

The Vercel partnership (announced February 2026) brings Gen's Agent Trust Hub safety verification to Vercel's AI skills ecosystem: skills deployed through Vercel can be evaluated before reaching agent hosts. Vercel is a deployment platform, not an agent framework. This is supply chain verification at the distribution layer rather than the execution layer.

## How AARTS Maps to PAC

AARTS is primarily Control infrastructure. It addresses the gap between what an agent is *authorized* to do (the delegation chain) and what it *can* do (structural enforcement at runtime).

The hook positions make this concrete:

- PreSkillLoad / PrePluginLoad: enforce supply chain controls at load time.
- PreLLMRequest: protect the delegation chain at its most vulnerable point. If the prompt reaching the model has been tampered with, no downstream authorization check can compensate.
- PreToolUse: enforce what the model can do regardless of what it has been instructed to do. Containment by design as a standardized interface.

The separation between host and security engine also has Accountability implications. When the security engine logs its verdicts (allow / deny / modify / redirect), those logs are produced by infrastructure outside the agent's own context. An agent cannot selectively disable its own audit trail. The observability chapter describes tamper-evident logging as a property that must be enforced outside the logged system. AARTS's external security engine enforces this structurally.

## What to Do Now

AARTS v0.1 is a draft, not a ratified standard. It has not been submitted to a standards body, and its adoption outside Gen's own ecosystem is not yet established (as of March 2026). That said, the architectural pattern is sound and the problem it addresses is real.

**If you are building an agent host:** Assess whether your current safety implementation is host-internal (a denylist inside your process) or structurally external (an enforcement point outside the agent's context). If it is host-internal, an attacker who compromises the host bypasses your safety checks. External enforcement is stronger. AARTS provides a vocabulary for that interface.

**If you are evaluating agent tools for deployment:** Ask whether the tool supports external security engine integration. A tool that can only enforce its own safety rules is a single point of failure. A tool that supports external enforcement allows your security team to apply consistent policy across multiple tools.

**If you are building security infrastructure for agent environments:** The AARTS hook schema is a reasonable starting point for defining your interception surface. PreToolUse and PreSkillLoad cover the highest-priority attack surfaces (injection and supply chain). Build your detection rules against those hooks before addressing the remaining 17.

**On Skill IDs specifically:** Content-addressable skill verification is something you can implement today without waiting for AARTS adoption. Compute the hash of any skill or plugin before deployment. Record it. Verify it at load time. This is the same pattern as checking a package hash against a lock file, applied to agent skills.

Whether AARTS becomes the standard or another approach does, the requirement it addresses will not go away: agent runtime safety needs a common interface, not just a collection of individual tool implementations.

---

[^gen-aarts]: Gen Digital, "Introducing AARTS: An Open Standard for AI Agent Runtime Safety," gendigital.com, 2026. Also: "Leading the Way for AI Agent Safety," gendigital.com, February 4, 2026. AARTS v0.1 defines 19 hook points, three component types (host, engine, adapter), and verdict semantics. Skill IDs use content-addressable fingerprinting.
[^gen-sage]: Gen Digital, "Introducing Sage: Safety for Agents," gendigital.com, March 2026. Open-source tool with 200+ detection rules. Also: Help Net Security, "Open-source tool Sage puts a security layer between AI agents and the OS," March 9, 2026. Partnership with Vercel announced February 17, 2026.
[^kai-30-cves]: Kai Security, "30 CVEs Later: How MCP's Attack Surface Expanded Into Three Distinct Layers," dev.to, 2026. Analysis of 30 CVEs filed January-February 2026 against MCP server implementations. Injection vulnerabilities (exec/shell injection) constitute 43% of the total.
[^sigstore-a2a]: Sigstore, sigstore-a2a, github.com/sigstore/sigstore-a2a. Also: Luke Hinds, "Building Trust in the AI Agent Economy: Sigstore Meets Agent2Agent," dev.to, July 2025. Keyless signing via Fulcio, transparency log via Rekor, SLSA provenance attestation.
