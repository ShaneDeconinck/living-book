# Autonomous Agents as Security Actors

CVE-2026-21536 is a remote code execution vulnerability in Microsoft's Devices Pricing Program cloud service, rated CVSS 9.8. Microsoft patched it server-side in the March 2026 Patch Tuesday. The vulnerability was credited to XBOW, a fully autonomous AI penetration testing agent, which found it without access to source code.[^xbow-cve]

XBOW reached number one on HackerOne's bug bounty leaderboard. As of March 2026, it has submitted more than 1,060 vulnerabilities through HackerOne, executed 48-step exploit chains, and completed penetration assessments in minutes that take skilled human pentesters hours.[^xbow-scale] The agent reasons about systems, chains tool calls across multiple steps, and persists through complex workflows without human direction.

This is the same class of capability the book describes as a governance challenge: autonomous multi-step action with consequential real-world effects. Applied defensively, it finds vulnerabilities before attackers do. Applied offensively, it finds vulnerabilities faster than organizations can patch them. The infrastructure gap between those two outcomes is where the risk concentrates.

## The Capability Threshold

XBOW's results mark a threshold. Not a qualitative shift — agents have been writing scripts and fuzz-testing for years — but a quantitative one: autonomous agents have crossed the capability point where they can match, and in specific dimensions exceed, top human security practitioners.

The relevant dimension is scale over time. A human pentester can execute complex exploit chains. XBOW can execute the same chains in parallel across hundreds of targets, continuously, at a cost profile that does not scale with hours worked. XBOW benchmarks show full penetration assessments completing in 28 minutes — what took a specialized team weeks now takes minutes per target.[^xbow-scale]

This creates rate asymmetry. Attacks scale faster than defenses. Vulnerability discovery has historically been rate-limited by human capacity: finding a zero-day in production infrastructure required talent, time, and access. All three are now automatable.

The enterprise security research community is already responding to this asymmetry. Mitra et al. (arXiv:2603.09134, March 2026) address the challenge of securing multi-agent AI integration in enterprise cyber operations: how to deploy agentic capabilities defensively while constraining the same attack surface they create.[^agenticcyops] The implication is direct: threat models that assume human-paced attackers are already outdated, and defensive architectures must be designed with that in mind.

## The Other Direction

Attackers are not waiting for new offensive tools. They are repurposing existing ones.

Google documented QUIETVAULT: a supply chain attack through a trojanized npm package that, after compromise, uses the developer's own AI coding tool as a reconnaissance agent.[^quietvault] The attacker issues natural-language prompts for filesystem searching. The developer's tool — which has filesystem access and is designed to follow natural-language instructions — executes them dutifully. The AI is not compromised: it is doing exactly what it was built to do. The attacker is just issuing instructions through a compromised package rather than directly.

Five AI-powered malware families are now operational in the wild.[^quietvault] The shift is categorical, not incremental: from attacks *on* AI tools, to attacks *by* adversary-built AI, to attacks *through* existing AI tools that the target has already deployed and trusted.

This is the confused deputy applied to the development toolchain. The AI coding tool has legitimate filesystem access. It cannot distinguish between instructions from the developer and instructions injected through a compromised package. The tool is acting within its authorization. The authorization is wrong for this context.

SANDWORM_MODE, documented in February 2026, shows the same logic at the package registry level: 19 typosquatting npm packages targeting MCP server infrastructure, stealing credentials within seconds of installation, then harvesting password managers and exfiltrating SSH keys, AWS credentials, and npm tokens.[^sandworm-mode] The attack does not require compromising the AI tool itself. It compromises the package the tool loads.

## Three Pressures Converging

**Discovery rate is increasing.** Autonomous agents scan and probe at machine speed. XBOW's 1,060+ submissions represent discovery at a rate impossible for human pentesters. As more organizations deploy autonomous security testing — offensively or defensively — the rate of vulnerability discovery increases. More discoveries means a larger backlog of known vulnerabilities relative to patching capacity.

**Exploitation rate is increasing.** The same tools that discover vulnerabilities can automate exploitation. Autonomous agents that complete full penetration assessments in 28 minutes can chain discovery to exploitation in the same session — and that upper bound will compress as agent capabilities improve.

**Defense cycles have not shortened proportionally.** Patching production systems requires coordinated deployment, testing, and rollout. The March 2026 Patch Tuesday that fixed CVE-2026-21536 represents the same release cadence as patches from ten years ago. The human coordination required to deploy a patch has not become meaningfully faster as the agents probing for unpatched systems have become faster.

Organizations that assume vulnerability windows are measured in days (the historical attacker constraint) need to update that assumption. Automated attackers with XBOW-class capabilities can find and weaponize vulnerabilities within hours of disclosure for systems with known vulnerability classes.

## What This Means for Infrastructure

The agents you have not governed are potentially being exploited as attack infrastructure.

QUIETVAULT does not require deploying a malicious agent. It requires only that the organization's existing AI coding tool has filesystem access and follows natural-language instructions from any source — properties that describe most AI coding tools by design.

The confused deputy at the tool level (an AI coding tool following instructions from a compromised package) is the same failure pattern as the confused deputy at the API level (an agent acting with authority it should not have for the current context). In both cases, the failure is architectural: the system does not distinguish between legitimate principals and attackers who have gained control of a channel the system trusts.

**For AI coding tools:** treat all input to the tool as untrusted regardless of source. Natural-language instructions from project files, package scripts, and configuration should receive the same scrutiny as external user input. The tool's authorization to access the filesystem does not extend to executing instructions from packages it loads.

**For any agent with access to consequential systems:** the instruction source is part of the trust boundary. A coding agent that accepts instructions from npm lifecycle hooks has effectively granted those hooks access to everything the agent can reach.

**On vulnerability management:** the rate pressure from autonomous discovery tools changes patching priority. A vulnerability in an agent-connected system is no longer a "patch within 30 days" item. If the system is reachable through an agent's tool calls, the window between disclosure and exploitation may be measured in hours. The "agentic collapse" pattern — an agent invoking a vulnerable API endpoint, bypassing WAFs that inspect HTTP traffic but cannot analyze semantic intent in natural-language prompts — makes every legacy system an agent touches a higher-priority patch target.[^agentic-collapse]

## Autonomous Defense

The same capabilities that make XBOW effective offensively make it effective defensively. Organizations with access to autonomous security testing tools can find their own vulnerabilities before adversaries do, at scale and speed that matches the threat.

But access is not uniform. XBOW and similar tools are available to organizations with the resources to use them. Organizations without those resources face the asymmetry from the wrong side: attackers with autonomous tools probing systems defended by human-paced processes.

This is where the book's infrastructure argument acquires urgency beyond governance theory. I4-level infrastructure — authorized, scoped, monitored agent deployments — shrinks the attack surface that autonomous adversaries can probe. An agent that cannot be instructed by untrusted sources cannot be used as a QUIETVAULT vector. An agent that operates with scoped credentials limits what a compromised agent can reach. An agent with structured audit trails enables post-compromise investigation rather than guesswork.

The governance debt that looks manageable under human-paced threat models compounds under machine-paced ones.

## Mapping to PAC

| Dimension | Potential | Accountability | Control |
|---|---|---|---|
| **Autonomous discovery** | Faster discovery creates value for defenders; same capability creates threat for unpatched systems | Autonomous agents' vulnerability submissions are attributable artifacts | Scoped, authorized agents limit what autonomous probing can reach |
| **Tool-level confused deputy** | AI coding tools multiply developer productivity | Instruction source must be auditable; logs show whether instructions came from legitimate principals | Authorization must distinguish trusted instruction sources from untrusted |
| **Rate asymmetry** | Organizations with autonomous defense tools can close the gap | Accountability chains must survive machine-speed incidents | Infrastructure enforcement must not depend on human response speed |

## Infrastructure Maturity for Autonomous Security Threats

| Level | What exists | Exposure to machine-speed threats |
|---|---|---|
| **I1 Open** | No formal authorization model | Maximum exposure: any compromised package or injected instruction reaches everything the agent can touch |
| **I2 Logged** | Agent actions recorded | Post-hoc investigation possible; real-time containment unavailable |
| **I3 Verified** | Agent identity confirmed, structured audit trails | Instruction source can be verified; anomalous instruction patterns detectable |
| **I4 Authorized** | Scoped permissions enforced per action | Compromised agents are containment failures, not total losses; blast radius bounded by scope |
| **I5 Contained** | Sandboxed execution with automatic containment | Machine-speed attacks trigger automatic containment rather than manual response |

Most organizations are at I1 or I2. QUIETVAULT, SANDWORM_MODE, and the agentic collapse pattern all assume I1: no instruction source verification, no scope enforcement, no containment. Building to I3 closes the instruction source verification gap. I4 contains the blast radius. I5 responds at machine speed.

## What to Do Now

**Update your threat model for autonomous attackers.** If your vulnerability management process assumes a discovery-to-exploitation window measured in days or weeks, revise it. Autonomous agents can chain discovery to exploitation in hours for systems with known vulnerability classes. Agent-connected systems move to higher patching priority.

**Audit what your AI tools accept as instruction input.** An AI coding tool with filesystem access that follows natural-language instructions from any source is a potential QUIETVAULT vector. Understand what channels your tools accept instructions from and whether those channels can be compromised through packages or configuration files.

**Apply supply chain scrutiny to AI integrations.** The same supply chain controls that apply to MCP servers apply to AI coding tools and their dependencies. A compromised package in a tool's dependency tree has access to everything the tool can reach. Verify package provenance for anything an AI tool loads.

**Treat agent-connected legacy systems as elevated patch targets.** Every system an agent can invoke via tool call inherits its vulnerability surface as an agent-level attack vector. The agentic collapse path — natural-language prompt to agent to vulnerable API — bypasses network controls that assume HTTP requests as the attack surface. Legacy vulnerabilities in agent-connected systems are more urgent than the same vulnerabilities in isolated systems.

**Use autonomous tools defensively.** If the threat includes autonomous vulnerability discovery, the appropriate response includes autonomous defensive discovery. Continuous automated security testing at I4 infrastructure is operationally realistic; periodic human engagements at I1 are not, given the current threat tempo.

---

[^xbow-cve]: CVE-2026-21536, Microsoft Devices Pricing Program RCE, CVSS 9.8, patched March 2026 Patch Tuesday. Credited to XBOW autonomous AI agent. Covered in Krebs on Security and WinBuzzer, March 2026.

[^xbow-scale]: XBOW, xbow.com. Autonomous offensive security platform. Statistics from XBOW, "We Ran 1,060 Autonomous Attacks," xbow.com blog, 2026. 1,060+ vulnerability submissions on HackerOne; 48-step exploit chain execution; 28-minute penetration assessment time; HackerOne #1 leaderboard ranking.

[^agenticcyops]: Mitra et al., "Securing Multi-Agentic AI Integration in Enterprise Cyber Operations," arXiv:2603.09134, March 2026. Defensive research on deploying multi-agent AI capabilities within enterprise security operations while managing the attack surface created by agentic architectures.

[^quietvault]: Google Threat Intelligence Group, QUIETVAULT documentation, 2026. Trojanized npm package repurposing developer AI coding tool as reconnaissance agent; natural-language filesystem commands executed by the tool. Five AI-powered malware families operational in the wild. First documented in gaps chapter observation "AI Tools as Attack Infrastructure."

[^sandworm-mode]: Research documentation, February 2026: 19 typosquatting npm packages targeting MCP server infrastructure. Credential theft within seconds of installation; SSH key, AWS credential, and npm token exfiltration. Primary coverage in [Agent Supply Chain Security](supply-chain-security.md) and [Tool Security and MCP Poisoning](tool-security.md).

[^agentic-collapse]: Penligent, "Agentic Collapse: Why CVE-2026-22200 is a Wake-Up Call for RAG Tool Security," penligent.ai, March 2026. CVE-2026-22200 (PHP filter chain injection in osTicket): attack delivered through public-facing AI agent's tool call, bypassing WAFs that inspect HTTP traffic but cannot analyze semantic intent in natural-language prompts. Agent has legitimate permission to invoke the osTicket API; the API carries the vulnerability the agent cannot detect.
