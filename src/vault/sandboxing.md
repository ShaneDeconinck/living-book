---
title: Sandboxing and Execution Security
tags: [control, security, containment, infrastructure]
---

Structural restriction of what an agent can physically do — independent of what it is instructed to do. The execution-layer implementation of [[trust-inversion]].

## Why permission prompts fail

Permission prompts are the default execution security mechanism for most agent tools. Three failure modes make them unreliable:

- **Approval fatigue**: agents generate dozens of actions per minute; users switch to auto-approve quickly
- **Knowledge gaps**: most users cannot evaluate whether a proposed action is safe
- **Speed-safety tradeoff**: stopping for approval on every action negates the value of autonomy

The deeper problem: permission prompts ask humans to provide judgment at machine speed — exactly when human judgment degrades. Bainbridge's ironies of automation and Don Norman's work on intermediate automation both confirm this. The answer is containment by design, not better prompts. [Deconinck 2026]

## The two mandatory boundaries

A correctly configured sandbox needs both:

1. **Filesystem isolation**: agent can read/write only within its working directory. System files, credentials, other projects — inaccessible.
2. **Network isolation**: agent cannot make arbitrary network connections. Outbound traffic routes through a proxy with explicit domain allowlists.

Each boundary alone leaves critical gaps. Without filesystem isolation, an agent with network access can still steal credentials. Without network isolation, a filesystem-contained agent can still exfiltrate data. Both are required.

Anthropic reports 84% reduction in permission prompts with full sandboxing in place. The sandbox removes the need for most checks because dangerous operations are structurally impossible. [Anthropic 2026]

## The isolation spectrum

Four approaches, ordered from lowest to highest isolation:

| Level | Mechanism | Best For | Limitation |
|---|---|---|---|
| Native OS | Seatbelt (macOS), bubblewrap/seccomp/Landlock (Linux) | Interactive coding agents, low blast radius | Shared kernel |
| Container | Linux namespaces, cgroups | Trusted workloads, CI/CD | Shared kernel, escape vulnerabilities |
| gVisor | User-space kernel, syscall interception | Multi-tenant SaaS, moderate trust | 10-30% I/O overhead |
| MicroVM | Dedicated kernel, hypervisor | Untrusted code, regulated environments, high blast radius | 125-200ms boot |

[[blast-radius]] determines the required level. A B1 agent may be adequately served by native OS sandboxing. A B4 agent should run in a microVM. The blast radius is fixed by the use case; the isolation level must match. [Deconinck 2026]

NVIDIA AI Red Team recommendation: full virtualization over kernel-sharing for production agentic workloads. "The overhead is frequently modest compared to that induced by LLM calls." [NVIDIA 2026]

## Denylist filtering does not work

CVE-2026-2256 (ModelScope MS-Agent Shell tool, March 2026): a regex-based denylist was bypassed with alternative encodings, shell syntax variations, and unblocked interpreters (python3, perl, ruby, node). CVSS 6.5. The pattern is general: agents generate novel command sequences; a denylist that blocks `rm -rf /` does not block creative reformulations. Containment must be structural (namespace boundaries), not lexical (pattern matching). [CVE-2026-2256]

## Defense in depth: seven layers

Sandboxing is one layer. Full execution security requires all seven:

1. **Input validation**: filter known injection patterns before agent processes content
2. **Sandboxed execution**: filesystem isolation, network isolation, syscall filtering
3. **Configuration protection**: prevent agent from modifying shell configs, git hooks, MCP config — closing the persistence vector
4. **Output validation**: scan agent output for credentials, API keys, internal URLs before it reaches users or downstream systems
5. **Credential scoping**: inject only the credentials needed for the current task; shortest practical lifetime
6. **Behavioral monitoring**: runtime anomaly detection for unusual filesystem scans, unexpected network requests, anomalous code patterns
7. **Semantic policy enforcement**: [[semantic-policy-enforcement]] — business-logic constraints above OS-level containment

NVIDIA on configuration protection: "Application-specific configuration files, including those located within the current workspace, must be protected from any modification by the agent, with no user approval of such actions." [NVIDIA 2026]

## Ephemeral vs persistent sandboxes

**Ephemeral**: destroyed after each task. Clean environment every time. Strongest isolation; highest setup cost.
**Persistent**: reused across tasks. Efficient; accumulates risk over time (stale files, modified configs).

Match to [[autonomy-levels]]: A1-A2 agents (suggestion/constrained) — persistent with periodic cleanup is adequate. A4-A5 agents (delegated/autonomous) — ephemeral is the safer default.

## OWASP coverage

Sandboxing directly addresses 5 of the [[owasp-agentic-top10]] risks (ASI02, ASI03, ASI04, ASI05, ASI10), partially addresses 2 (ASI01, ASI08), and cannot address 3 (ASI06, ASI07, ASI09). It is execution-layer defense; it does not address model-level vulnerabilities, communication security, or organizational trust dynamics.

## Connects to

- [[trust-inversion]] — sandboxing is the execution implementation of the allowlist principle
- [[blast-radius]] — isolation level must match blast radius
- [[infrastructure-levels]] — I3+ requires full sandbox; I4+ requires microVM and behavioral monitoring
- [[autonomy-levels]] — sandbox requirements scale with autonomy level
- [[owasp-agentic-top10]] — covers 5 of 10 risks directly
- [[semantic-policy-enforcement]] — complementary layer for business-logic constraints
- [[prompt-injection]] — sandboxing limits blast radius but does not prevent injection

## Appears in

- **Your Coding Agent Needs a Sandbox** (`posts/docker-sandbox-coding-agents`, 2026-02-07) — central thesis; full isolation spectrum and native vs Docker comparison
- **OpenClaw and Moltbook** (`posts/openclaw-moltbook-trust-fear-ai`, 2026-02-17) — Clawdbot's missing containment; documentation is not a security model
- **AI Agents Need the Inverse of Human Trust** (`posts/agent-trust-inversion`, 2026-02-03) — containment as the structural implementation of trust inversion

## Sources

- [Deconinck 2026]: Shane Deconinck, "Your Coding Agent Needs a Sandbox," shanedeconinck.be, February 7, 2026
- [Anthropic 2026]: David Dworken and Oliver Weller-Davies, "Beyond Permission Prompts," anthropic.com/engineering/claude-code-sandboxing, 2026
- [NVIDIA 2026]: NVIDIA AI Red Team, "Practical Security Guidance for Sandboxing Agentic Workflows," developer.nvidia.com, 2026
- [CVE-2026-2256]: ModelScope MS-Agent Shell tool RCE, CERT/CC VU#431821, March 2, 2026
- Chapter: [Sandboxing and Execution Security](../chapters/execution-security.md)
