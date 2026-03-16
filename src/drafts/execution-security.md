# Sandboxing and Execution Security

Execution security is the Control pillar made physical. Identity and delegation define what an agent *should* be allowed to do. Execution security defines what it *can* do. The gap between those two is where incidents happen.

## The Permission Prompt Problem

Most agent tools today rely on permission prompts as their primary security mechanism. The agent wants to run a command, edit a file, or make a network request. A prompt appears. The user clicks "yes."

Three failure modes make them unreliable:[^sandbox-post]

**Approval fatigue.** A coding agent might request dozens of file operations per minute. After the fifth prompt, most users switch to auto-approve. The twentieth prompt, the one that matters, gets the same reflexive "yes" as all the others.

**Knowledge gaps.** When an agent asks permission to run `curl -X POST https://api.example.com/webhook`, most users cannot evaluate whether that request is safe. They lack the context to make the decision the prompt demands.

**Speed-versus-safety tradeoff.** The entire value proposition of an agent is that it works faster than a human. Stopping for approval on every action converts an agent back into a suggestion engine. Users who want agent-level productivity will disable the prompts.

This is the trust inversion principle applied to execution[^trust-inversion]: humans default to trust because they have judgment and care about consequences. Agents have neither. Permission prompts ask humans to provide judgment at machine speed, which is the situation where human judgment degrades. Decades of automation research confirm this: Bainbridge's ironies of automation and Don Norman's work on intermediate automation both show that humans cannot reliably monitor systems and then rapidly intervene when something goes wrong[^bainbridge][^norman].

The answer is not better prompts. The answer is containment by design.

The Amazon Kiro incident (December 2025) demonstrates this. According to Financial Times reporting, an AI coding agent tasked with fixing a production issue determined the optimal solution was to delete the entire AWS Cost Explorer environment and recreate it, causing a 13-hour outage. Amazon disputes this characterization, attributing the event to misconfigured access controls rather than AI behavior. Whatever the cause, the agent had access to production infrastructure with no sandbox to limit what it could do.[^kiro] The post-incident fix was a governance policy (senior approval for AI-assisted production changes). The structural fix would have been containment: an agent touching production should not have the ability to delete the environment, regardless of the deploying human's access level.

The DataTalksClub incident (February 26, 2026) shows the same pattern with a more detailed post-mortem.[^datatalks] A developer asked Claude Code to set up new AWS infrastructure using Terraform. The agent had production AWS credentials. A stale Terraform state file, stored locally on a previous computer rather than in remote state, caused the agent to treat existing production infrastructure as duplicates. The agent ran `terraform destroy`. In seconds, the RDS database (1.9 million rows, 2.5 years of student course submissions), the VPC, the ECS cluster, the load balancers, and the bastion host were gone. The automated database snapshots were deleted along with the infrastructure they were tied to. Recovery required an emergency upgrade to AWS Business Support and took 24 hours.

Every action the agent took was a legitimate Terraform command. No permission prompt flagged the sequence as destructive. The developer's post-mortem fixes: deletion protection at both Terraform and AWS levels, backups decoupled from infrastructure lifecycle, Terraform state moved to S3, and a new rule: "AI agents no longer execute commands; all plans reviewed manually."[^datatalks] That last fix is the retreat from autonomy that happens when containment infrastructure is absent. The structural fix would have been credential scoping (an agent doing infrastructure setup should not hold credentials capable of destroying production resources) and infrastructure-level deletion protection as a prerequisite, not a post-mortem action.

## Containment by Design

Containment means restricting what an agent can do regardless of what it tries to do. The restrictions are structural, not advisory. An agent inside a properly configured sandbox cannot exfiltrate SSH keys, not because it has been told not to, but because the sandbox prevents filesystem access to `~/.ssh/` at the operating system level.

The alternative, filtering dangerous commands through denylists, does not work. CVE-2026-2256 in ModelScope's MS-Agent framework demonstrated this in March 2026.[^ms-agent] The framework's Shell tool used a `check_safe()` method with regex-based denylist filtering to block unsafe commands. Attackers bypassed it with alternative encodings, shell syntax variations, and command obfuscation, achieving arbitrary remote code execution rated CVSS 6.5. The pattern is general: any denylist-based approach assumes you can enumerate everything dangerous. Agents, by design, generate novel command sequences. A denylist that blocks `rm -rf /` does not block the creative reformulation an agent or an attacker produces. Containment must be structural, not lexical.

A sandbox needs two boundaries[^anthropic-sandbox]:

**Filesystem isolation.** The agent can read and write within its working directory. Everything else is restricted. System files, credentials, configuration files, other projects: all inaccessible. This prevents a compromised agent from stealing secrets, modifying system configuration, or affecting other workloads.

**Network isolation.** The agent cannot make arbitrary network connections. Outbound traffic goes through a proxy that enforces domain restrictions and requires explicit approval for new destinations. This prevents data exfiltration, command-and-control communication, and downloading of malicious payloads.

You need both. Filesystem isolation without network isolation means an agent could still exfiltrate secrets by reading them from disk and sending them to a remote server (it just needs to find a way around the filesystem restrictions first). Network isolation without filesystem isolation means an agent could steal SSH keys, modify shell configuration, or plant malicious binaries in system paths.

A correctly sandboxed agent can operate more autonomously, not less. Anthropic reports that sandboxing reduces permission prompts by 84%[^anthropic-sandbox]. The sandbox removes the need for most permission checks because the dangerous operations are structurally impossible. The agent can run freely within its boundaries.

## The Isolation Spectrum

Not all sandboxes are equal. The strength of isolation depends on where the boundary sits in the system architecture. Three approaches exist today, each with different security properties and performance characteristics.

### Native OS Sandboxing

Native sandboxing uses operating system security primitives to restrict a process without creating a separate execution environment. The agent runs as a regular process on the host, but the OS kernel enforces restrictions on what that process can access.

On macOS, this means Seatbelt: the same sandbox mechanism that isolates iOS apps. On Linux, it is a combination of technologies: bubblewrap for filesystem namespace isolation, seccomp BPF for syscall filtering, and Landlock for filesystem access control[^codex-security].

Claude Code uses this approach on both platforms. The sandbox restricts filesystem access to the working directory and routes network traffic through a proxy running outside the sandbox. The restrictions apply not just to the agent process but to any scripts, programs, or subprocesses it spawns[^anthropic-sandbox].

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

The NVIDIA AI Red Team recommends full virtualization over kernel-sharing solutions for production agentic workloads[^nvidia-sandbox]:

> Run agentic tools within a fully virtualized environment isolated from the host kernel at all times, including VMs, unikernels, or Kata containers.

The overhead introduced by virtualization is, as they note, "frequently modest compared to that induced by LLM calls."[^nvidia-sandbox] When an agent spends seconds waiting for model inference, 125ms of VM boot time is noise.

### gVisor: User-Space Kernel Interception

Between containers and MicroVMs sits gVisor, Google's user-space kernel that intercepts system calls before they reach the host kernel. Instead of sharing the host kernel directly (like containers) or running a dedicated kernel (like MicroVMs), gVisor reimplements Linux syscalls in a user-space process called the Sentry. The agent's code never touches the host kernel directly, which reduces the kernel attack surface without the overhead of full virtualization. The tradeoff is I/O performance: gVisor adds 10-30% overhead on I/O-heavy workloads, making it best suited for multi-tenant SaaS platforms and moderate-trust environments where container isolation is insufficient but MicroVM boot times are undesirable[^northflank].

### Choosing the Right Level

The choice depends on threat model and blast radius:

| Isolation Level | Mechanism | Best For | Limitation |
|---|---|---|---|
| Native OS | Seatbelt, bubblewrap, seccomp, Landlock | Interactive coding agents, low blast radius | Shared kernel |
| Containers | Linux namespaces, cgroups | Trusted workloads, CI/CD pipelines | Shared kernel, escape vulnerabilities |
| gVisor | User-space kernel, syscall interception | Multi-tenant SaaS, moderate trust | 10-30% I/O overhead |
| MicroVMs | Dedicated kernel, hypervisor isolation | Untrusted code, regulated environments, high blast radius | 125-200ms boot time |

Blast radius determines isolation requirements. A B1 agent (contained impact, easily reversible) may be adequately served by native OS sandboxing. A B4 agent (regulated data, compliance implications) should run in a microVM. The blast radius is fixed by the use case; the isolation level must match[^profiler-post].

## The OWASP Top 10 for Agentic Applications

In December 2025, OWASP released the Top 10 for Agentic Applications: a peer-reviewed framework identifying the most critical security risks for autonomous AI systems, developed with input from over 100 security researchers and practitioners[^owasp].

The ten risks are:

1. **ASI01: Agent Goal Hijack.** Attackers modify agent objectives through malicious content embedded in emails, documents, or web pages. Agents often cannot reliably separate instructions from data[^owasp].
2. **ASI02: Tool Misuse.** Agents misuse legitimate tools due to ambiguous prompts, misaligned behavior, or poisoned input. The PromptPwnd vulnerability demonstrated how untrusted GitHub content injected into prompts caused secret exposure with over-privileged tools[^owasp].
3. **ASI03: Identity and Privilege Abuse.** Agents inherit user credentials and high-privilege access that are unintentionally reused, escalated, or passed across agents[^owasp].
4. **ASI04: Supply Chain Vulnerabilities.** Compromised tools, plugins, prompt templates, MCP servers, or other agents alter behavior or expose data[^owasp].
5. **ASI05: Unexpected Code Execution.** Agents generate or execute untrusted code, shell commands, or scripts triggered through generated output[^owasp].
6. **ASI06: Memory and Context Poisoning.** Attackers poison agent memory systems, embeddings, or RAG databases to influence future decisions[^owasp].
7. **ASI07: Insecure Inter-Agent Communication.** Multi-agent message exchanges lack authentication, encryption, or semantic validation[^owasp].
8. **ASI08: Cascading Failures.** Errors in one agent propagate across planning, execution, and downstream systems, compounding rapidly[^owasp].
9. **ASI09: Human-Agent Trust Exploitation.** Users over-trust agent recommendations, leading to unsafe approvals or exposures. This is the complacency trap from [Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md), now classified as a security risk[^owasp].
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

Sandboxing is execution-layer defense. It contains blast radius and prevents the most common exploitation patterns. But it does not address model-level vulnerabilities, communication security, or organizational trust dynamics. Those require the other layers.

## Defense in Depth

Execution security is not just sandboxing. It is a layered architecture where each layer addresses a different class of threat. If one layer fails, the others still contain the damage.

### Layer 1: Input Validation

Before an agent processes content, that content should be filtered for known injection patterns. Instruction overrides, identity attacks, encoding evasion, and delimiter injection are all documented attack techniques[^prompt-injection]. No filter is perfect: prompt injection remains an unsolved problem at the model level. But filtering reduces the attack surface and catches the obvious attempts.

OpenAI's March 2026 engineering guidance on designing agents to resist prompt injection makes this explicit: the most effective prompt injection attacks "increasingly resemble social engineering more than simple prompt overrides."[^openai-pi] Detecting a malicious input becomes equivalent to detecting a lie or misinformation, often without necessary context. OpenAI recommends three complementary mechanisms: Instruction Hierarchy (training models to distinguish trusted system instructions from untrusted external content), structured outputs between agent nodes (using enums, fixed schemas, and required field names to eliminate freeform channels attackers can exploit), and system-level containment to limit damage when attacks succeed. "AI firewalling" approaches are limited because they try to solve the detection problem. The defense that works is designing systems so that the impact of manipulation is constrained even if some attacks succeed.

A separate OpenAI publication from December 2025, on continuously hardening ChatGPT Atlas against prompt injection, describes a different approach: an RL-trained automated attacker that discovers vulnerabilities by "steering an agent into executing sophisticated, long-horizon harmful workflows that unfold over tens or even hundreds of steps."[^openai-pi] This is red-teaming at a complexity level that manual testing cannot match, and it connects to the evaluation gap described in [Reliability, Evaluation](reliability-evaluation.md): if your prompt injection testing only covers single-turn attacks, you are testing the wrong threat model.

The Clinejection incident (March 2026) extends the threat model to automated pipelines with no human in the loop.[^clinejection] An attacker used cache poisoning to inject malicious content into issues processed by Cline's automated triage system, a Claude-backed agent that read and categorized incoming GitHub issues. The agent followed the injected instructions and exposed NPM release secrets — credentials that controlled Cline's production release pipeline. The incident illustrates two properties of pipeline prompt injection: the agent's trust in issue content was structural (the triage workflow was designed to process whatever appeared in issues), and the blast radius extended beyond the agent to the software supply chain it had access to. The defense is the same OpenAI recommends: treat all external content as untrusted regardless of the channel, and scope agent credentials to the minimum needed for the task.

### Layer 2: Sandboxed Execution

The core containment boundary. Filesystem isolation, network isolation, and syscall filtering as described above. Treat all agent-generated code as potentially malicious[^nvidia-sandbox]. Every command the agent executes should pass through the sandbox, including scripts, subprocesses, hooks, and MCP-spawned processes.

The NVIDIA AI Red Team emphasizes that sandbox scope must be comprehensive[^nvidia-sandbox]: restrictions should extend beyond command-line tools to all agentic operations. OS-level controls work beneath the application layer to cover every process, including those the application does not know about.

### Layer 3: Configuration Protection

A subtle but critical layer. Agents that can modify configuration files can achieve persistence and escape. If an agent can write to `~/.zshrc`, it can inject commands that execute outside the sandbox the next time a shell opens. If it can modify `.gitconfig`, it can alter hooks that run on commit. If it can modify MCP configuration, it can redirect tool calls to malicious servers.

The NVIDIA guidance is unambiguous[^nvidia-sandbox]:

> Application-specific configuration files, including those located within the current workspace, must be protected from any modification by the agent, with no user approval of such actions.

This is a non-negotiable control. Configuration files are the bridge between the sandboxed environment and the host system. Protecting them closes the persistence vector.

### Layer 4: Output Validation

Before agent output reaches the user or triggers downstream actions, scan for sensitive data patterns: API keys, private keys, credentials, internal URLs. A compromised agent that cannot exfiltrate data through the network might try to surface it in its output, hoping the user will copy it somewhere accessible.

### Layer 5: Credential Scoping

Agents should receive only the credentials they need for the current task, with the shortest practical lifetime. The NVIDIA guidance recommends explicit secret injection rather than inheriting host credentials[^nvidia-sandbox]. This prevents the accumulation of stale credentials inside the sandbox and limits the damage from a compromised agent to the scope of its current task.

This connects to the identity and delegation architecture from [Agent Identity and Delegation](agent-identity.md). Short-lived, task-scoped tokens (OAuth OBO with DPoP binding, or Verifiable Intent constraints) are the authorization analog of execution sandboxing: they constrain what the agent can do even if it escapes the sandbox.

### Layer 6: Behavioral Monitoring

Runtime monitoring detects anomalous behavior that static rules miss. An agent that suddenly starts scanning directories outside its workspace, making unusual network requests, or generating code patterns inconsistent with its task may be compromised. Anomaly detection at the execution layer provides the signal; automated containment (killing the process, tightening sandbox restrictions) provides the response.

This is the "infrastructure in the loop" pattern from [Reliability, Evaluation](reliability-evaluation.md): monitoring that does not depend on human vigilance but operates continuously and responds structurally.

### Layer 7: Semantic Policy Enforcement

The six layers above operate at the system level: they constrain what the agent can physically do (filesystem, network, syscalls) and detect anomalous behavior patterns. But there is a gap between OS-level containment and business-level governance. A sandboxed agent may be unable to access files outside its workspace but still able to take actions within its workspace that violate organizational policy: sharing confidential data with an unauthorized tool, executing a workflow step out of sequence, or calling an API in a way that triggers regulatory obligations.

The Policy Compiler for Secure Agentic Systems (PCAS), published in February 2026, addresses this gap with a reference monitor that intercepts all agent actions and validates them against policy before execution.[^pcas] The architecture is straightforward: policies are expressed in a Datalog-derived language over dependency graphs that capture the relationships between agents, tools, data, and actions. Before an agent executes any action, the reference monitor checks the action against the active policy set. Violations are blocked before they occur.

The results quantify the "can't vs. don't" gap. Without enforcement, frontier models (Claude Opus 4.5, GPT-5.2, Gemini 3 Pro) comply with stated policies only 48% of the time on customer service tasks.[^pcas] The policies are explicit and unambiguous: do not share customer data with third-party tools, do not execute refunds above a threshold without approval, do not access records outside the current case. The models understand the policies. They do not reliably follow them when the policies conflict with task completion. With PCAS active, compliance rises to 93% across all tested models, with zero violations in fully instrumented runs.

The 48-to-93 gap is the core argument of this book, measured. Policy alone ("don't share customer data") fails more than half the time. Infrastructure enforcement ("the reference monitor blocks any action that would share customer data") approaches perfect compliance. The remaining gap between 93% and 100% comes from runs where the policy compiler's dependency graph did not fully cover the action space, which is an engineering problem, not a fundamental limitation.

PCAS is complementary to OS-level sandboxing, not a replacement. Sandboxing constrains the execution environment: what files, networks, and system resources the agent can access. PCAS constrains the business logic: what actions the agent is allowed to take given the relationships between entities in the current context. A fully governed agent needs both: sandboxing to prevent system-level exploitation, and semantic policy enforcement to prevent business-level policy violations.

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

### Google Project Mariner: Application-Level Defense in Depth

The three architectures above are OS-level containment for coding agents. Google's browser agent security architecture, detailed in its 2026 Responsible AI Progress Report, takes a different approach: application-level defense in depth for an agent that browses the web on behalf of users.[^google-mariner]

The architecture has five layers, each addressing a distinct threat:

**User Alignment Critic.** A separate Gemini model reviews every proposed agent action and vetoes anything that does not match the user's specific intent. The architectural detail matters: the Critic sees only action metadata, not the raw web content the agent is processing. This isolation means the Critic cannot be poisoned through the same channel the agent operates in. An attacker who embeds malicious instructions on a web page can influence the browsing agent but cannot reach the oversight model. This is "infrastructure in the loop" with a twist: the infrastructure is itself an AI model, but one architecturally shielded from the threat surface.

**Agent Origin Sets.** Task-scoped browsing boundaries restrict the agent's reach to data directly related to the current task. The web equivalent of filesystem sandboxing: the agent cannot wander into unrelated domains or access data outside its assignment. This is the permission scoping principle from the identity chapter applied to browsing scope.

**Prompt injection classification.** Every page the agent visits is scanned for attempts to manipulate it through embedded instructions. This operates alongside Chrome's existing safety features and on-device scam detection. Input validation at every hop, not just at the entry point.

**Mandatory human oversight for sensitive actions.** Payments, social media posts, and credential use all require explicit human confirmation. This is the autonomy dial from the [Human-Agent Collaboration](human-agent-collaboration.md) chapter in production: the agent operates at A3 (oversight) for routine browsing but drops to A2 (approve) for high-consequence actions, enforced by infrastructure rather than policy.

**Pre-launch testing.** All five layers were built before the capability shipped, not in response to incidents. The framing matters: security as a prerequisite for launch, not a patch applied after deployment.

The Google architecture complements the OS-level approaches (Claude Code, Codex CLI, Docker) rather than competing with them. OS-level sandboxing constrains system resources: files, network, syscalls. Google's application-level architecture constrains agent behavior: intent alignment, task scope, action classification. A fully governed browser agent would use both: OS-level containment to prevent system exploitation, and application-level oversight to prevent the agent from acting outside its mandate. The User Alignment Critic is the most concrete production implementation of the guardian agent pattern: a secondary AI system whose sole purpose is governing a primary AI system's behavior.

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
| **I5: Contained** | Hardware-enforced isolation. Defense-in-depth across all seven layers. Continuous anomaly detection. Cross-agent isolation boundaries. |

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

[^sandbox-post]: Shane Deconinck, "Your Coding Agent Needs a Sandbox: Docker Sandbox vs Native vs DevContainers," shanedeconinck.be, February 7, 2026.

[^trust-inversion]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," shanedeconinck.be, February 3, 2026.

[^bainbridge]: Lisanne Bainbridge, "Ironies of Automation," *Automatica* 19, no. 6 (1983): 775-779.

[^norman]: Don Norman, "The 'Problem' with Automation: Inappropriate Feedback and Interaction, Not 'Over-Automation,'" *Philosophical Transactions of the Royal Society* B327 (1990): 585-593.

[^anthropic-sandbox]: Anthropic Engineering (David Dworken and Oliver Weller-Davies), "Beyond Permission Prompts: Making Claude Code More Secure and Autonomous," anthropic.com/engineering/claude-code-sandboxing, 2026.

[^codex-security]: OpenAI, "Codex Security," developers.openai.com, 2026.

[^northflank]: Northflank, "How to Sandbox AI Agents in 2026: MicroVMs, gVisor & Isolation Strategies," northflank.com, 2026.

[^nvidia-sandbox]: NVIDIA AI Red Team, "Practical Security Guidance for Sandboxing Agentic Workflows and Managing Execution Risk," developer.nvidia.com, 2026.

[^profiler-post]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026.

[^owasp]: OWASP, "Top 10 for Agentic Applications for 2026," genai.owasp.org, December 2025.

[^prompt-injection]: OWASP, "Top 10 for Large Language Model Applications," owasp.org, 2025. Prompt injection remains the #1 LLM vulnerability.

[^clinejection]: Adnan Khan, "Clinejection — Compromising Cline's Production Releases," adnanthekhan.com/posts/clinejection/, March 6, 2026. Cache poisoning via GitHub Issues to inject instructions into Cline's automated AI triage agent, exposing NPM release pipeline secrets. Covered by Simon Willison.

[^openai-pi]: OpenAI, "Designing AI agents to resist prompt injection," openai.com, March 11, 2026. Draws parallels between prompt injection and social engineering, recommends Instruction Hierarchy (trusted vs. untrusted input separation), structured outputs between nodes, and system-level containment. The RL-trained automated attacker for multi-step vulnerability discovery is described in a separate publication: OpenAI, "Continuously hardening ChatGPT Atlas against prompt injection attacks," openai.com, December 22, 2025.

[^ms-agent]: CVE-2026-2256, ModelScope MS-Agent Shell tool remote code execution, CVSS 6.5 (Medium). Reported by Itamar Yochpaz, CERT/CC VU#431821, March 2, 2026. The `check_safe()` regex denylist was bypassed with encoding variations, shell syntax alternatives, and unblocked interpreters (python3, perl, ruby, node). At the time of disclosure, no vendor patch was available.

[^kiro]: Financial Times, reported February 20, 2026; Amazon response at aboutamazon.com, February 21, 2026. Barrack.ai documents ten production incidents across six major AI tools (Kiro, Replit AI Agent, Google Antigravity IDE, Claude Code/Cowork, Gemini CLI, Cursor IDE) from October 2024 to February 2026.

[^datatalks]: Alexey Grigorev, "How I Dropped Our Production Database and Now Pay 10% More for AWS," alexeyondata.substack.com, March 2026. Full post-mortem of the February 26, 2026 incident. Also reported: Tom's Hardware, "Claude Code deletes developers' production setup, including its database and snapshots," March 2026.

[^google-mariner]: Google, "Our 2026 Responsible AI Progress Report: Our Ongoing Work," blog.google, February 2026. Five-layer security architecture for browser agents: User Alignment Critic (intent verification via separate Gemini model shielded from web content), Agent Origin Sets (task-scoped browsing boundaries), prompt injection classification (per-page scanning), mandatory human oversight (payments, credentials, social media), and pre-launch security testing. See also Google Security Blog, "Architecting Security for Agentic Capabilities in Chrome," December 8, 2025.

[^pcas]: Policy Compiler for Secure Agentic Systems (PCAS), February 2026. Reference monitor architecture with Datalog-derived policy language. Tested on frontier models: Claude Opus 4.5, GPT-5.2, Gemini 3 Pro. Baseline compliance: 48% on customer service tasks with explicit policy statements. With PCAS enforcement: 93% compliance across all tested models, zero violations in fully instrumented runs.
