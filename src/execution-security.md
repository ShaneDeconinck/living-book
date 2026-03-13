# Sandboxing and Execution Security

Every previous chapter in this book has dealt with a question of trust: who is this agent, what can it access, who authorized it, and who is accountable when it fails? This chapter deals with the question that comes after all of those: what happens when the agent actually runs?

Execution security is the Control pillar made physical. Identity and delegation define what an agent *should* be allowed to do. Execution security defines what it *can* do. The gap between those two is where incidents happen.

## The Permission Prompt Problem

Most agent tools today rely on permission prompts as their primary security mechanism. The agent wants to run a command, edit a file, or make a network request. A prompt appears. The user clicks "yes."

Shane has been direct about why this fails[^sandbox-post]:

> Permission prompts are not a security model. Approval fatigue, knowledge gaps, and speed-vs-safety tradeoffs mean users click "yes" without reading.

Three failure modes make permission prompts unreliable:

**Approval fatigue.** A coding agent might request dozens of file operations per minute. After the fifth prompt, most users switch to auto-approve. The twentieth prompt, the one that matters, gets the same reflexive "yes" as all the others.

**Knowledge gaps.** When an agent asks permission to run `curl -X POST https://api.example.com/webhook`, most users cannot evaluate whether that request is safe. They lack the context to make the decision the prompt demands.

**Speed-versus-safety tradeoff.** The entire value proposition of an agent is that it works faster than a human. Stopping for approval on every action converts an agent back into a suggestion engine. Users who want agent-level productivity will disable the prompts.

This is the trust inversion principle applied to execution[^trust-inversion]: humans default to trust because they have judgment and care about consequences. Agents have neither. Permission prompts ask humans to provide judgment at machine speed, which is precisely the situation where human judgment degrades. Decades of automation research confirm this: Bainbridge's ironies of automation and Don Norman's work on intermediate automation both show that humans cannot reliably monitor systems and then rapidly intervene when something goes wrong[^bainbridge][^norman].

The answer is not better prompts. The answer is containment by design.

## Containment by Design

Containment means restricting what an agent can do regardless of what it tries to do. The restrictions are structural, not advisory. An agent inside a properly configured sandbox cannot exfiltrate SSH keys, not because it has been told not to, but because the sandbox prevents filesystem access to `~/.ssh/` at the operating system level.

The alternative, filtering dangerous commands through denylists, does not work. CVE-2026-2256 in ModelScope's MS-Agent framework demonstrated this in March 2026.[^ms-agent] The framework's Shell tool used a `check_safe()` method with regex-based denylist filtering to block unsafe commands. Attackers bypassed it with alternative encodings, shell syntax variations, and command obfuscation, achieving arbitrary remote code execution rated CVSS 9.8. The pattern is general: any denylist-based approach assumes you can enumerate everything dangerous. Agents, by design, generate novel command sequences. A denylist that blocks `rm -rf /` does not block the creative reformulation an agent or an attacker produces. Containment must be structural, not lexical.

Shane draws the distinction clearly[^sandbox-post]:

> Containment must be by design, not by user vigilance. The answer is restricting what the agent can do regardless of what it tries to do.

A sandbox needs two boundaries[^anthropic-sandbox]:

**Filesystem isolation.** The agent can read and write within its working directory. Everything else is restricted. System files, credentials, configuration files, other projects: all inaccessible. This prevents a compromised agent from stealing secrets, modifying system configuration, or affecting other workloads.

**Network isolation.** The agent cannot make arbitrary network connections. Outbound traffic goes through a proxy that enforces domain restrictions and requires explicit approval for new destinations. This prevents data exfiltration, command-and-control communication, and downloading of malicious payloads.

You need both. Filesystem isolation without network isolation means an agent could still exfiltrate secrets by reading them from disk and sending them to a remote server (it just needs to find a way around the filesystem restrictions first). Network isolation without filesystem isolation means an agent could steal SSH keys, modify shell configuration, or plant malicious binaries in system paths. Anthropic's engineering team puts it simply[^anthropic-sandbox]: "Effective sandboxing requires both filesystem and network isolation."

A correctly sandboxed agent can operate more autonomously, not less. Anthropic reports that sandboxing reduces permission prompts by 84%[^anthropic-sandbox]. The sandbox removes the need for most permission checks because the dangerous operations are structurally impossible. The agent can run freely within its boundaries.

## The Isolation Spectrum

Not all sandboxes are equal. The strength of isolation depends on where the boundary sits in the system architecture. Three approaches exist today, each with different security properties and performance characteristics.

### Native OS Sandboxing

Native sandboxing uses operating system security primitives to restrict a process without creating a separate execution environment. The agent runs as a regular process on the host, but the OS kernel enforces restrictions on what that process can access.

On macOS, this means Seatbelt: the same sandbox mechanism that isolates iOS apps. On Linux, it is a combination of technologies: bubblewrap for filesystem namespace isolation, seccomp BPF for syscall filtering, and Landlock for filesystem access control[^anthropic-sandbox][^codex-security].

Claude Code uses this approach on both platforms. The sandbox restricts filesystem access to the working directory and routes network traffic through a proxy running outside the sandbox. Critically, the restrictions apply not just to the agent process but to any scripts, programs, or subprocesses it spawns[^anthropic-sandbox].

OpenAI's Codex CLI takes a similar approach: Seatbelt on macOS, Landlock and seccomp on Linux. By default, the agent runs with network access turned off and filesystem access limited to the current workspace[^codex-security].

The key advantage is performance: native sandboxing adds negligible overhead because there is no virtualization layer. The agent starts instantly and runs at full speed.

The key limitation is that native sandboxing shares the host kernel. A kernel vulnerability could, in principle, allow an escape. As Shane notes[^sandbox-post]:

> Native sandboxing restricts what a process can do. Docker sandboxes restrict where the process exists.

For most coding workflows, native sandboxing provides sufficient isolation. The attack surface is the kernel itself, and kernel exploits are rare, high-value, and not the typical failure mode for a coding agent that has been tricked by a prompt injection.

### Container-Based Isolation

Standard Docker containers use Linux namespaces and cgroups to isolate processes. The agent runs in its own filesystem namespace, network namespace, and process namespace. It looks and feels like a separate machine, but it shares the host kernel.

Container isolation is stronger than native sandboxing in some respects: the agent has a complete, isolated filesystem, its own network stack, and no visibility into host processes. But the shared kernel remains a limitation. Container escape vulnerabilities are documented and periodically discovered.

The performance profile is favorable: containers start in milliseconds and impose minimal overhead. This makes them suitable for high-throughput scenarios where agents are created and destroyed frequently.

For trusted workloads in single-tenant environments, containers provide adequate isolation. For untrusted code execution (the default assumption for agent-generated code), stronger isolation is recommended[^northflank].

### MicroVM Isolation

MicroVMs represent the strongest isolation boundary available today. Technologies like Firecracker (developed by AWS for Lambda and Fargate) create lightweight virtual machines with dedicated kernels. Each workload runs inside its own virtual machine, separated from the host by a hypervisor[^northflank].

Docker Desktop uses this approach when running Docker sandboxes on macOS and Windows: the containers actually run inside a Linux virtual machine managed by the Virtualization.framework (macOS) or Hyper-V (Windows). This means a full kernel exploit inside the container still requires a hypervisor escape to reach the host[^sandbox-post].

Performance characteristics are modest compared to containers but still fast: Firecracker boots in approximately 125ms with under 5MB of memory overhead per VM, supporting 150 VMs per second per host. Kata Containers provide a similar architecture with Kubernetes-native orchestration, booting in roughly 200ms[^northflank].

The NVIDIA AI Red Team recommends full VM isolation over kernel-sharing solutions for production agentic workloads[^nvidia-sandbox]:

> Use full VM isolation, Kata containers, or microVMs rather than kernel-sharing solutions to prevent kernel exploits.

The overhead introduced by virtualization is, as they note, "frequently modest compared to that induced by LLM calls."[^nvidia-sandbox] When an agent spends seconds waiting for model inference, 125ms of VM boot time is noise.

### Choosing the Right Level

The choice depends on threat model and blast radius:

| Isolation Level | Mechanism | Best For | Limitation |
|---|---|---|---|
| Native OS | Seatbelt, bubblewrap, seccomp, Landlock | Interactive coding agents, low blast radius | Shared kernel |
| Containers | Linux namespaces, cgroups | Trusted workloads, CI/CD pipelines | Shared kernel, escape vulnerabilities |
| gVisor | User-space kernel, syscall interception | Multi-tenant SaaS, moderate trust | 10-30% I/O overhead |
| MicroVMs | Dedicated kernel, hypervisor isolation | Untrusted code, regulated environments, high blast radius | 125-200ms boot time |

The PAC Framework's blast radius scale (B1-B5) maps directly to isolation requirements. A B1 agent (contained impact, easily reversible) may be adequately served by native OS sandboxing. A B4 agent (regulated data, compliance implications) should run in a microVM. The blast radius is fixed by the use case; the isolation level must match[^profiler-post].

## The OWASP Top 10 for Agentic Applications

In December 2025, OWASP released the Top 10 for Agentic Applications: a peer-reviewed framework identifying the most critical security risks for autonomous AI systems, developed with input from over 100 security researchers and practitioners[^owasp]. Understanding what sandboxing covers (and what it does not) is essential for building a complete execution security architecture.

The ten risks are:

1. **ASI01: Agent Goal Hijack.** Attackers modify agent objectives through malicious content embedded in emails, documents, or web pages. Agents often cannot reliably separate instructions from data[^owasp].
2. **ASI02: Tool Misuse.** Agents misuse legitimate tools due to ambiguous prompts, misaligned behavior, or poisoned input. The PromptPwnd vulnerability demonstrated how untrusted GitHub content injected into prompts caused secret exposure with over-privileged tools[^owasp].
3. **ASI03: Identity and Privilege Abuse.** Agents inherit user credentials and high-privilege access that are unintentionally reused, escalated, or passed across agents[^owasp].
4. **ASI04: Supply Chain Vulnerabilities.** Compromised tools, plugins, prompt templates, MCP servers, or other agents alter behavior or expose data[^owasp].
5. **ASI05: Unexpected Code Execution.** Agents generate or execute untrusted code, shell commands, or scripts triggered through generated output[^owasp].
6. **ASI06: Memory and Context Poisoning.** Attackers poison agent memory systems, embeddings, or RAG databases to influence future decisions[^owasp].
7. **ASI07: Insecure Inter-Agent Communication.** Multi-agent message exchanges lack authentication, encryption, or semantic validation[^owasp].
8. **ASI08: Cascading Failures.** Errors in one agent propagate across planning, execution, and downstream systems, compounding rapidly[^owasp].
9. **ASI09: Human-Agent Trust Exploitation.** Users over-trust agent recommendations, leading to unsafe approvals or exposures. This is the complacency trap from Chapter 6, now classified as a security risk[^owasp].
10. **ASI10: Rogue Agents.** Compromised or misaligned agents act harmfully while appearing legitimate[^owasp].

### What Sandboxing Covers

Shane mapped these risks against sandboxing coverage in his Docker sandbox post[^sandbox-post]. The results are instructive:

**Strong coverage (5 of 10 risks):**
- ASI02 (Tool Misuse): Sandboxing restricts which tools the agent can invoke and what parameters it can pass. A sandboxed agent cannot access tools outside its environment.
- ASI03 (Identity and Privilege Abuse): Filesystem isolation prevents access to credentials. Network isolation prevents lateral movement. The agent operates with only the permissions explicitly granted within the sandbox.
- ASI04 (Supply Chain): A sandboxed agent cannot install arbitrary packages or execute unvetted binaries from outside sources without explicit allowlisting.
- ASI05 (Unexpected Code Execution): This is sandboxing's primary purpose. Generated code runs within the sandbox boundary. Even malicious code is contained.
- ASI10 (Rogue Agents): A rogue agent inside a sandbox is still contained. It can cause damage within its workspace but cannot escape to affect the broader system.

**Partial coverage (2 of 10 risks):**
- ASI01 (Goal Hijack): Sandboxing limits the blast radius of a hijacked agent but does not prevent the hijack itself. A goal-hijacked agent inside a sandbox can still corrupt the workspace it has access to.
- ASI08 (Cascading Failures): Sandboxing provides isolation boundaries that prevent cascading, but multi-agent systems need additional circuit breakers and rate limits.

**No coverage (3 of 10 risks):**
- ASI06 (Memory and Context Poisoning): This is a model-level problem. Sandboxing operates at the execution layer and does not inspect or validate the agent's context or memory.
- ASI07 (Insecure Inter-Agent Communication): Communication security requires authentication, encryption, and validation at the protocol level, not the execution layer.
- ASI09 (Human-Agent Trust Exploitation): This is an organizational and design problem. No sandbox prevents a human from over-trusting an agent's output.

The takeaway: sandboxing is execution-layer defense. It contains blast radius and prevents the most common exploitation patterns. But it does not address model-level vulnerabilities, communication security, or organizational trust dynamics. Those require the other layers of the PAC Framework.

## Defense in Depth

Execution security is not just sandboxing. It is a layered architecture where each layer addresses a different class of threat. If one layer fails, the others still contain the damage.

### Layer 1: Input Validation

Before an agent processes content, that content should be filtered for known injection patterns. Instruction overrides, identity attacks, encoding evasion, and delimiter injection are all documented attack techniques[^prompt-injection]. No filter is perfect: prompt injection remains an unsolved problem at the model level. But filtering reduces the attack surface and catches the obvious attempts.

### Layer 2: Sandboxed Execution

The core containment boundary. Filesystem isolation, network isolation, and syscall filtering as described above. Treat all agent-generated code as potentially malicious[^nvidia-sandbox]. Every command the agent executes should pass through the sandbox, including scripts, subprocesses, hooks, and MCP-spawned processes.

The NVIDIA AI Red Team emphasizes that sandbox scope must be comprehensive[^nvidia-sandbox]: restrictions should extend beyond command-line tools to all agentic operations. OS-level controls work beneath the application layer to cover every process, including those the application does not know about.

### Layer 3: Configuration Protection

A subtle but critical layer. Agents that can modify configuration files can achieve persistence and escape. If an agent can write to `~/.zshrc`, it can inject commands that execute outside the sandbox the next time a shell opens. If it can modify `.gitconfig`, it can alter hooks that run on commit. If it can modify MCP configuration, it can redirect tool calls to malicious servers.

The NVIDIA guidance is unambiguous[^nvidia-sandbox]:

> Application-specific configuration files must be protected from any modification by the agent, with no user approval.

This is a non-negotiable control. Configuration files are the bridge between the sandboxed environment and the host system. Protecting them closes the persistence vector.

### Layer 4: Output Validation

Before agent output reaches the user or triggers downstream actions, scan for sensitive data patterns: API keys, private keys, credentials, internal URLs. A compromised agent that cannot exfiltrate data through the network might try to surface it in its output, hoping the user will copy it somewhere accessible.

### Layer 5: Credential Scoping

Agents should receive only the credentials they need for the current task, with the shortest practical lifetime. The NVIDIA guidance recommends explicit secret injection rather than inheriting host credentials[^nvidia-sandbox]. This prevents the accumulation of stale credentials inside the sandbox and limits the damage from a compromised agent to the scope of its current task.

This connects directly to the identity and delegation architecture from Chapter 3. Short-lived, task-scoped tokens (OAuth OBO with DPoP binding, or Verifiable Intent constraints) are the authorization analog of execution sandboxing: they constrain what the agent can do even if it escapes the sandbox.

### Layer 6: Behavioral Monitoring

Runtime monitoring detects anomalous behavior that static rules miss. An agent that suddenly starts scanning directories outside its workspace, making unusual network requests, or generating code patterns inconsistent with its task may be compromised. Anomaly detection at the execution layer provides the signal; automated containment (killing the process, tightening sandbox restrictions) provides the response.

This is the "infrastructure in the loop" pattern from Chapter 6: monitoring that does not depend on human vigilance but operates continuously and responds structurally.

## Ephemeral Versus Persistent Sandboxes

A design decision with security implications: should sandboxes be ephemeral (destroyed after each task) or persistent (reused across tasks)?

Ephemeral sandboxes provide the strongest isolation. Each task starts with a clean environment. No artifacts from previous tasks can influence the current one. No accumulated state can be exploited. The tradeoff is setup cost: recreating the environment for each task takes time and resources.

Persistent sandboxes are more efficient but accumulate risk. Files from previous tasks, cached dependencies, and modified configurations can become attack vectors. The NVIDIA guidance recommends periodic recreation of persistent sandboxes to limit artifact accumulation[^nvidia-sandbox].

The right choice depends on the autonomy level. For A1-A2 agents (suggestion and constrained execution), persistent sandboxes with periodic cleanup are adequate. For A4-A5 agents (delegated and autonomous), ephemeral sandboxes are the safer default.

## Real-World Architectures

### Claude Code

Claude Code implements native OS sandboxing with both filesystem and network isolation[^anthropic-sandbox]. On macOS, a Seatbelt profile restricts the process. On Linux, bubblewrap creates a filesystem namespace and seccomp BPF filters restrict syscalls. All network traffic routes through a Unix domain socket to a proxy process running outside the sandbox.

The design is pragmatic: native sandboxing adds negligible overhead to an interactive coding workflow. The proxy architecture allows fine-grained network control (per-domain allowlists) without requiring a virtual network stack. The 84% reduction in permission prompts demonstrates that structural containment can replace vigilance-based security while improving the user experience.

### Codex CLI

OpenAI's Codex CLI uses a similar architecture: Seatbelt on macOS, Landlock and seccomp on Linux[^codex-security]. The sandbox runs as a standalone helper process that transforms untrusted commands into constrained execution environments. Network access is off by default. Filesystem access is limited to the workspace.

The helper process design is notable: sandbox restrictions apply only to child processes, leaving the main CLI with necessary system access. This separation prevents the sandbox from interfering with the tool's own operation while constraining everything the agent generates.

### Docker Sandbox (MicroVM)

Docker Desktop's sandbox approach provides the strongest isolation by running workloads inside a Linux virtual machine[^sandbox-post]. The VM has its own kernel, its own Docker daemon, and copy-based file synchronization (not volume-mounted, which would share the host filesystem). A network filtering proxy controls all egress traffic.

This architecture allows agents to run completely non-interactively: no permission prompts are needed because the VM boundary contains any possible operation. The tradeoff is higher setup cost and the overhead of file synchronization between host and VM.

## Connecting to PAC

Execution security is primarily a Control pillar concern, but it intersects with all three pillars:

| PAC Pillar | Execution Security Role |
|---|---|
| **Potential** | Sandboxing enables greater autonomy. Agents that can run safely within containment boundaries can operate faster and with less human intervention. The 84% reduction in permission prompts is a Potential gain enabled by Control infrastructure. |
| **Accountability** | Execution logs from sandboxed environments provide audit trails. Every command executed, every file modified, every network request made: all recorded at the sandbox boundary. This creates the traceability that regulations require (EU AI Act Article 12, NIST concept paper). |
| **Control** | Sandboxing is Control infrastructure. It enforces restrictions structurally rather than through policy. A sandboxed agent cannot violate filesystem or network boundaries regardless of its instructions, its goals, or whether it has been compromised. |

The infrastructure maturity scale (I1-I5) maps to execution security capabilities:

| Level | Execution Security Capabilities |
|---|---|
| **I1: Open** | No sandbox. Agent runs with user-level permissions. Permission prompts as only control. |
| **I2: Logged** | Basic filesystem restrictions. Execution logging. No network isolation. |
| **I3: Verified** | Full sandbox with filesystem and network isolation. Configuration file protection. Credential scoping. |
| **I4: Authorized** | MicroVM isolation. Ephemeral sandboxes. Behavioral monitoring. Automated containment. |
| **I5: Contained** | Hardware-enforced isolation. Defense-in-depth across all six layers. Continuous anomaly detection. Cross-agent isolation boundaries. |

Shane's agent profiler makes infrastructure a gate, not a slider[^profiler-post]. At Level 4 (Delegated autonomy), sandboxing is required. At Level 5 (Autonomous), sandboxing plus anomaly detection and automated containment are required. These are binary prerequisites: you either have them or the agent cannot operate at that autonomy level.

## What to Do Now

**If you are running coding agents:** Enable sandboxing. Both Claude Code and Codex CLI provide native sandbox modes that impose negligible performance overhead. This is the single highest-impact security improvement for most development teams.

**If you are building agent infrastructure:** Implement both filesystem and network isolation. Either one alone leaves critical gaps. Use a proxy architecture for network control: it allows fine-grained domain-level restrictions without requiring changes to the agent's code.

**If you are deploying agents in regulated environments:** Move to microVM isolation. The overhead is modest compared to LLM inference time. Ephemeral sandboxes provide the strongest guarantees for compliance with EU AI Act Article 9 (risk management) and Article 15 (robustness).

**Regardless of deployment context:**
- Protect configuration files from agent modification. This is a non-negotiable control that closes the most common persistence vector.
- Scope credentials to the current task with the shortest practical lifetime.
- Monitor agent behavior at the execution layer. Anomaly detection provides the signal that static rules miss.
- Treat sandboxing as one layer in a defense-in-depth architecture. It covers half the OWASP agentic risks. The other half require identity ([Agent Identity and Delegation](agent-identity.md)), authorization ([Cross-Organization Trust](cross-org-trust.md)), communication security ([Agent Communication Protocols](agent-communication.md)), supply chain integrity ([Agent Supply Chain Security](supply-chain-security.md)), and organizational governance ([Shadow Agent Governance](shadow-agent-governance.md)).

Sandboxing is not the complete answer to execution security. But it is the foundation. Without it, every other security measure is advisory rather than structural. With it, the blast radius of any failure is bounded by architecture, not by vigilance.

---

[^sandbox-post]: Shane Deconinck, "Your Coding Agent Needs a Sandbox: Docker Sandbox vs Native vs DevContainers," trustedagentic.ai, February 7, 2026.

[^trust-inversion]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," trustedagentic.ai, February 3, 2026.

[^bainbridge]: Lisanne Bainbridge, "Ironies of Automation," *Automatica* 19, no. 6 (1983): 775-779.

[^norman]: Don Norman, "The 'Problem' of Automation: Inappropriate Feedback and Interaction, Not 'Over-Automation,'" *Philosophical Transactions of the Royal Society* B327 (1990): 585-593.

[^anthropic-sandbox]: Anthropic Engineering, "Making Claude Code More Secure and Autonomous," anthropic.com, 2026.

[^codex-security]: OpenAI, "Codex Security," developers.openai.com, 2026.

[^northflank]: Northflank, "How to Sandbox AI Agents in 2026: MicroVMs, gVisor & Isolation Strategies," northflank.com, 2026.

[^nvidia-sandbox]: NVIDIA AI Red Team, "Practical Security Guidance for Sandboxing Agentic Workflows and Managing Execution Risk," developer.nvidia.com, 2026.

[^sandbox-post]: Shane Deconinck, "Your Coding Agent Needs a Sandbox: Docker Sandbox vs Native vs DevContainers," trustedagentic.ai, February 7, 2026.

[^profiler-post]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," trustedagentic.ai, February 26, 2026.

[^owasp]: OWASP, "Top 10 for Agentic Applications for 2026," genai.owasp.org, December 2025.

[^prompt-injection]: OWASP, "Top 10 for Large Language Model Applications," owasp.org, 2025. Prompt injection remains the #1 LLM vulnerability.

[^ms-agent]: CVE-2026-2256, ModelScope MS-Agent Shell tool remote code execution, CVSS 9.8. Reported by Itamar Yochpaz, documented by Christopher Cullen (CERT/CC VU#431821), March 2, 2026. The `check_safe()` regex denylist was bypassed with encoding variations and shell syntax alternatives. At the time of disclosure, no vendor patch was available.
