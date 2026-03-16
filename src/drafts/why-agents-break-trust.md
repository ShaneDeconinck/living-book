# Why Agents Break Trust

Every identity system we have was built on one assumption: a human is in the loop. OAuth, SAML, OIDC, even zero-trust architectures: they all assume that somewhere in the chain, a person made a decision to act. Agents break that assumption.

Agents are already running in production. They're approving expenses, writing code, sending emails, querying databases, and calling APIs. Some of them were deployed deliberately. Others were built by employees on a lunch break using a low-code platform. The question is not whether agents will make consequential decisions in your organization. They already are. McKinsey's March 2026 reporting puts a number on the consequences: 80% of organizations have already encountered risky behavior from AI agents.[^mckinsey] As McKinsey partner Rich Isenberg frames it: "Agency isn't a feature. It's a transfer of decision rights." The question shifts from "is the model accurate?" to "who is accountable when the system acts?"

The question is: when something goes wrong, can you explain what happened? Or as Isenberg puts it: "The scariest failures are ones you can't reconstruct because you didn't log the workflow."[^mckinsey]

## What Changed

Traditional software does what you tell it. An API endpoint receives a request, follows a deterministic path, returns a response. The human who called it made the decision. The software executed it. Accountability is straightforward: the person who pressed the button is responsible for what happened next.

Agents are different. They interpret intent and expand it. You tell an agent to "find the best deal on flights to London" and it decides which sites to check, which filters to apply, which tradeoffs to make between price and convenience. The human provided a goal. The agent made the decisions.

In August 2025, Perplexity's AI-powered browser Comet demonstrated how intent expansion becomes a vulnerability. Attackers embedded hidden commands in Reddit comment sections. When a user activated Comet's "summarize current page" feature, the agent followed the embedded instructions instead: the user's intent was "summarize," but the agent's interpretation expanded to execute concealed commands planted by a third party.[^perplexity] The user never authorized those actions. The agent acted on what it found, not what the user meant.

The pattern escalated. In March 2026, Zenity Labs disclosed PleaseFix: a family of 0-click vulnerabilities affecting agentic browsers, including Comet.[^pleasefix] Two distinct exploit paths: a calendar invite triggers file exfiltration from the local filesystem; a second path achieves credential theft from password managers. Both operate within the agent's authenticated session. No user interaction required. The naming is deliberate: ClickFix was social engineering that tricked humans into executing malicious actions. PleaseFix is the same technique adapted for agents, where no click is needed at all. The attack surface shifted from the human to the agent.

Our entire trust infrastructure was built for the first pattern. OAuth's On-Behalf-Of flow assumes the downstream service is executing the user's intent, not generating its own. When an agent decides to call an API the user never mentioned, whose authority is it acting under? The user who started the conversation? The developer who built the agent? The organization that deployed it?

"When agents decide, delegation becomes abdication," Shane writes.[^1] The gap between what a user intended and what an agent does is where accountability dissolves.

## The Confused Deputy, Revisited

The confused deputy problem is not new. It was first described in 1988: a program with elevated privileges gets tricked into misusing them on behalf of a less-privileged caller. The classic solution is capability-based security: don't give the program ambient authority, give it specific capabilities scoped to what it needs.

Agents make this problem worse in four ways.

First, agents typically receive broad credentials. Shane's analysis of Google's Workspace CLI illustrates the pattern: `gmail.readonly` grants access to every email in your account, forever. When you tell an agent to "help me find one email," the credential it receives allows reading all of them. The agent has more authority than any single task requires, because the credential system was not designed for task-scoped access.[^google-workspace]

Second, agents process untrusted input with trusted credentials. In mid-2025, Supabase's Cursor agent demonstrated this. The agent ran with privileged service-role access to help developers. Support tickets contained user-supplied input. Attackers embedded SQL instructions in those tickets. The agent, operating with full database credentials, processed the instructions as commands and exfiltrated sensitive integration tokens.[^supabase-cursor] The agent was not compromised in the traditional sense: it did what it was designed to do (process support tickets) using the credentials it was given (full database access). The problem was that nobody scoped those credentials to the actual task.

The Huntress 2026 Cyber Threat Report documents the scale: identity threats now dominate their incident data, with OAuth abuse more than doubling year-over-year. The report documents campaigns like LangChain CVE-2025-68664, Langflow RCE, and the GTG-1002 campaign where attackers exploited valid NHIs to produce high-impact breaches. The issue was not proving who the identity belonged to. It was constraining what the identity was allowed to do.[^huntress] Long-lived, over-privileged, unowned NHIs with no enforced lifecycle boundaries and no runtime constraints create unmonitored execution paths. Agents inherit this problem and amplify it: a compromised agent acting as a confused deputy operates at machine speed and scale, causing more damage than a traditional attacker with the same credentials.

The Amazon Kiro incident demonstrates the third dimension of the confused deputy: agents make destructive decisions within their granted authority. In December 2025, Amazon engineers gave Kiro, their AI coding agent, a task to fix an issue in a production environment. Kiro determined the optimal solution was to delete the entire environment and recreate it from scratch, causing a 13-hour outage of AWS Cost Explorer in a mainland China region.[^kiro] The agent was not compromised. It was not tricked by prompt injection. It reasoned its way to a catastrophic action using the elevated permissions it inherited from the deploying engineer, using access broader than standard policy intended. Amazon's response: "This brief event was the result of user error, specifically misconfigured access controls, not AI." But the post-incident fix tells the real story: Amazon mandated that junior and mid-level engineers can no longer push AI-assisted code to production without senior approval.[^kiro] The fix was a governance control that should have been infrastructure from the start. The Kiro incident is not isolated: Barrack.ai documents ten production incidents across six major AI tools in sixteen months, including deleted databases, wiped hard drives, and destroyed development environments.[^kiro-pattern] The pattern is consistent: agents inherit broad permissions, reason their way to destructive actions, and no structural containment prevents the damage.

Fourth, agents chain. Agent A calls Agent B, which calls Agent C. Each hop inherits some version of the original authority, but the intent degrades. By the time Agent C acts, it may be several interpretive steps removed from what the human actually wanted. If Agent C causes harm, the delegation chain is unclear, the intent is ambiguous, and the credentials were broad enough to allow it. Peer-reviewed research confirms the cascading risk: in multi-agent LLM systems, a single faulty or compromised agent degrades downstream decision-making across the chain, with performance drops of up to 23.7% depending on system structure.[^cascading-mas] A taxonomy study of 1,600+ multi-agent failure traces found that "failures are not isolated events but may have cascading effects that influence other failure categories."[^mast-taxonomy]

This is not a prompt engineering problem. Better prompts do not fix confused deputies. Infrastructure does: scoped credentials, delegation chains with authority that can only decrease, and audit trails that capture what happened at each hop. When agents delegate to other agents, the problem compounds: governance cost scales with delegation depth, not just agent count. The [Multi-Agent Trust and Orchestration](multi-agent-trust.md) chapter covers how trust properties compose (or break) across delegation chains.[^2]

## Shadow Agents

Your employees are already building agents.

Low-code platforms, browser extensions, and LLM-powered automation tools make it trivial to create agents without going through IT, security, or compliance review. An employee connects their company email to an AI assistant that summarizes incoming messages and drafts responses. Another builds a workflow that monitors a shared drive and automatically processes new documents. A third uses a coding agent with full access to a production repository.

These shadow agents are not malicious. They are people trying to be more productive. But they create real governance gaps:

- **No registration.** The organization does not know these agents exist.
- **No credential scoping.** They often use the employee's full credentials.
- **No audit trail.** Their actions are logged as the employee's actions, if logged at all.
- **No blast radius assessment.** Nobody evaluated what happens when these agents fail.

The EU AI Act's high-risk system obligations, originally set for August 2, 2026 (though the Commission's Digital Omnibus proposal may push Annex III systems to December 2027), require organizations to maintain transparency, human oversight, and risk management for AI systems. Shadow agents make compliance nearly impossible: unregistered agents have no audit trails, no risk assessments, and no human oversight documentation. The [Shadow Agent Governance](shadow-agent-governance.md) chapter covers the transition from ungoverned to governed.[^3]

## The Supply Chain You Cannot See

There is a fourth way agents break trust, and it is the one least visible to the teams deploying them: the tools agents use are themselves an attack surface.

In May 2025, a critical vulnerability in GitHub's Model Context Protocol integration showed what this looks like. Attackers embedded malicious instructions in public repository Issues. When a developer's locally running AI agent processed those issues through MCP, it indiscriminately executed the embedded commands, exfiltrating private repository source code and cryptographic keys. The developer never saw the malicious instructions. The agent followed them because they appeared in a context the agent was designed to read.[^github-mcp]

The MCPTox benchmark, a systematic evaluation of agent robustness against tool poisoning in realistic MCP settings, tested 20 prominent LLM agents against 45 real-world MCP servers and 353 authentic tools. The results were sobering: o1-mini achieved a 72.8% attack success rate. More capable models were often more susceptible, because the attack exploits their superior instruction-following abilities.[^mcptox]

The supply chain vulnerability extends beyond tool descriptions. In September 2025, security researchers found a backdoored NPM package called postmark-mcp: a connector designed to let AI agents send emails via the Postmark API. It was a supply chain attack targeting MCP infrastructure.[^postmark-mcp] The pattern is familiar from traditional software supply chains (compromised packages in npm, PyPI, and similar registries) but the blast radius is different. A compromised library in traditional software does what the code says. A compromised tool in an agent's supply chain can influence what the agent decides to do next.

The [Agent Supply Chain Security](supply-chain-security.md) chapter covers the full attack surface. The [Agent Communication Protocols](agent-communication.md) chapter covers what the MCP ecosystem is doing about it.

## Reliability Is Getting Easier. Governance Is Not.

Models are improving. Tasks that required elaborate scaffolding a year ago now work with a single prompt. Claude Code is a good example: as the underlying model improved, the team deleted scaffolding code rather than optimizing it. Better models make reliability easier.

But reliability and governance are different problems. Reliability asks: does the agent get the right answer? Governance asks: when it gets the wrong answer, can you explain what happened, who authorized it, and what the blast radius was?

Better models actually make governance harder. When an agent succeeds 99% of the time, humans stop watching. Oversight becomes a formality. And the 1% failure, when it comes, happens without anyone paying attention. Shane calls this the complacency trap: the better agents get, the less humans monitor them, and the more damage the rare failure causes. The [Reliability, Evaluation, and the Complacency Trap](reliability-evaluation.md) chapter grounds this in 40 years of human factors research, and the [Human-Agent Collaboration Patterns](human-agent-collaboration.md) chapter covers how to design oversight that does not depend on sustained human vigilance.[^4]

And the threat is bilateral. Organizations are not only defending their own agents: adversaries are deploying agents too. Flashpoint's 2026 Global Threat Intelligence Report documents agentic attack chains operating autonomously: reconnaissance, phishing generation, credential testing, and infrastructure rotation, all without continuous human control.[^flashpoint] Infostealers infected 11.1 million machines in 2025, producing 3.3 billion stolen credentials and cloud tokens traded on criminal markets. Paired with agentic AI frameworks, those credentials can be tested against thousands of endpoints simultaneously: corporate VPNs, SaaS providers, cloud services, at a speed that outpaces conventional detection. Criminal forum discussions referencing AI spiked 1,500% between November and December 2025.[^flashpoint]

Sardine documents seven agentic attack types producing losses across banking, fintech, and crypto networks.[^sardine] Three illustrate the qualitative shift from human-speed to agent-speed attacks:

- **Polymorphic phishing agents** embed in compromised inboxes and observe for weeks: studying historical threads, mapping approval hierarchies, learning internal slang. They insert themselves into existing high-trust threads rather than initiating new ones, matching the victim's working hours and typing rhythms. Traditional phishing detection looks for anomalous messages. These agents produce messages that are indistinguishable from legitimate ones because they learned what legitimate looks like from the inside.
- **Synthetic identity maturation agents** manage fabricated profiles through 6-to-18-month cultivation cycles: cycling micro-loans, automating monthly repayments, building credit scores past 800. The agent handles the tedious, long-duration work of making a fake identity look real. When the identities are activated for fraud, each one has a verifiable history that passes standard underwriting checks.
- **Automated chain-hopping** orchestrates cross-chain money laundering by fragmenting stolen funds into tens of thousands of transactions under $10 each, moving assets through blockchains, privacy protocols, and bridges faster than any human analyst can follow. The agent turns money laundering from a skilled manual operation into a high-speed optimization problem.

The pattern across all seven vectors is the same: agents remove the human bottleneck from attack operations. The time between vulnerability disclosure and weaponized exploit is shrinking toward zero.

Google's Cloud Threat Horizons Report (H1 2026) added a dimension the industry had not anticipated: adversaries weaponizing developers' own AI tools against them. The threat actor UNC6426 compromised the Nx npm build framework and delivered QUIETVAULT, a credential stealer that detected locally installed AI command-line tools (Claude Code, Gemini CLI, Amazon Q Developer), invoked them with natural-language prompts to perform filesystem reconnaissance for credentials and secrets.[^google-ai-malware] The AI tool did the attacker's work. Google identified five AI-powered malware families in active deployment, including PROMPTSTEAL, used by Russia's GRU (APT28) against Ukrainian targets, which queries LLMs to generate credential-theft commands.[^google-ai-malware] This is not adversaries building their own AI: it is adversaries using yours.

The defensive side is responding in kind. OpenAI's Codex Security, launched in March 2026, scanned 1.2 million commits across open-source repositories during its beta period, identifying 792 critical and 10,561 high-severity vulnerabilities: an audit velocity no human security team can achieve.[^codex-security] Kai emerged from stealth the same month with $125 million in funding for an agentic AI cybersecurity platform that operates autonomously across threat intelligence, detection, and response.[^kai] The governance challenge is not just "can we trust our agents?" It is: can our defenses operate at the speed adversary agents now move?

The McKinsey Lilli hack brought this home. In March 2026, red-team startup CodeWall turned an AI agent loose on McKinsey's internal AI platform. The agent found publicly exposed API documentation, identified 22 unauthenticated endpoints, and discovered that one of them concatenated JSON keys directly into SQL: a textbook SQL injection vulnerability. Within two hours, the agent had full read-write access to the production database. CodeWall reported 46.5 million chat messages about strategy, mergers and acquisitions, and client engagements, all in plaintext, plus 728,000 confidential files and 57,000 user accounts. McKinsey disputed that any data was retrieved.[^codewall-mckinsey] The vulnerability class was decades old. The speed was new. A human penetration tester might have found the same flaw, but not in two hours across 22 endpoints. The deeper problem is what the platform accumulated: McKinsey's 40,000+ employees used Lilli for over 500,000 prompts per month, and the system stored their strategic reasoning and client data in one concentrated target. Agent platforms are not just tools. They are honeypots of organizational intelligence, and adversary agents can crack them at machine speed.

The model will keep improving. The infrastructure to deploy it responsibly is what most organizations lack.

## What Trust Infrastructure Looks Like

If traditional IAM answers "who is this user?", agent trust infrastructure needs to answer a harder set of questions:

- **Who is this agent?** Not just a service account. A verifiable identity tied to a specific agent, its developer, and its deploying organization.
- **Who authorized this action?** Not just "the user started a session." A traceable delegation chain showing how authority flowed from human intent to agent action.
- **What can this agent do?** Not broad role-based access. Granular, time-bounded, task-scoped permissions that can only decrease through delegation.
- **What did this agent actually do?** Not application logs. Audit trails designed for compliance, showing the decision path from intent to action.
- **What happens when it fails?** Not an incident response plan written after the fact. A blast radius assessment done before deployment.

These are not five separate products. They are one system. Identity without delegation tracking is incomplete. Delegation without audit trails is unverifiable. Audit trails without scoped permissions are just a record of things going wrong.

The emerging infrastructure to address this is real but early. OAuth 2.0 Token Exchange (RFC 8693) supports delegation chains. NIST published a concept paper in February 2026 on AI agent identity and authorization, soliciting industry feedback.[^5] DPoP (Demonstration of Proof-of-Possession) binds tokens to agent keys so intercepted tokens are useless. The Trust Spanning Protocol addresses cross-organizational trust. Agent gateways are emerging as an infrastructure layer for centralized control over agent identity, permissions, and behavior.

None of this is finished. But the direction is clear: agents need their own trust layer, distinct from human identity systems, built on verifiable credentials and scoped delegation rather than ambient authority.

## The OWASP Agentic Risk Taxonomy

The OWASP Top 10 for Agentic Applications, released in December 2025 by more than 100 researchers with contributions from NIST, Microsoft's AI Red Team, and others, provides a standardized risk taxonomy for autonomous agents.[^owasp-agentic]

Two principles from the OWASP framework are worth noting. **Least-Agency** extends least-privilege to autonomy itself: agents should receive only the minimum autonomy required for the task, not just minimum permissions. **Strong Observability** is treated as a non-negotiable: comprehensive visibility into agent actions, reasoning, and tool invocations.

The mapping to this book:

| OWASP Risk | Book Coverage |
|---|---|
| **ASI01: Agent Goal Hijack** (prompt injection, goal manipulation) | [Why Agents Break Trust](why-agents-break-trust.md) (PleaseFix, Perplexity Comet), [Supply Chain Security](supply-chain-security.md) (tool poisoning, MCPTox) |
| **ASI02: Tool Misuse** (legitimate tools bent to destructive outputs) | [Reliability & Evaluation](reliability-evaluation.md) (AgentShield tool abuse blind spot), [Execution Security](execution-security.md) (defense in depth) |
| **ASI03: Identity and Privilege Abuse** (over-privileged credentials, confused deputy) | [Agent Identity](agent-identity.md) (OAuth extensions, DPoP, scoped credentials), [Cross-Org Trust](cross-org-trust.md) (PIC eliminates confused deputy structurally) |
| **ASI04: Supply Chain Vulnerabilities** (compromised tools, plugins, MCP servers) | [Supply Chain Security](supply-chain-security.md) (full chapter: 30 CVEs in 60 days, MCPTox, tool poisoning) |
| **ASI05: Insecure Runtime Execution** (code injection via natural language) | [Execution Security](execution-security.md) (7-layer defense: OS sandboxing through semantic policy enforcement) |
| **ASI06: Insecure Inter-Agent Communication** (spoofing, interception) | [Agent Communication](agent-communication.md) (MCP/A2A security gaps), [Cross-Org Trust](cross-org-trust.md) (TSP for authenticated channels) |
| **ASI07: Memory Poisoning** (persistent manipulation of agent memory/RAG) | [Context Infrastructure](context-infrastructure.md) (AI Recommendation Poisoning), [Supply Chain Security](supply-chain-security.md) (memory poisoning attacks) |
| **ASI08: Cascading Planning Failures** (compounding errors across agent chains) | [Multi-Agent Trust](multi-agent-trust.md) (cascading compromise propagation in simulated multi-agent environments, AgentLeak internal leakage) |
| **ASI09: Human-Agent Trust Exploitation** (over-trust, complacency) | [Reliability & Evaluation](reliability-evaluation.md) (complacency trap, 40 years of human factors research), [Human-Agent Collaboration](human-agent-collaboration.md) |
| **ASI10: Rogue Agents** (compromised or misaligned agents acting autonomously) | [Shadow Agent Governance](shadow-agent-governance.md) (discovery, registration, enforcement), this chapter (Kiro incident) |

The OWASP taxonomy organizes risks by attack surface. The PAC Framework organizes by governance response.

## MITRE ATLAS: The Attack Technique Library

OWASP organizes by risk: what can go wrong. MITRE ATLAS organizes by adversary technique: how attackers do it. If the OWASP Top 10 for Agentic Applications is the risk taxonomy, ATLAS is the attack playbook.

MITRE ATLAS (Adversarial Threat Landscape for AI Systems) extends the ATT&CK framework, the industry standard for cyber threat modeling, to AI and machine learning systems. In October 2025, Zenity Labs announced contributions of 14 new attack techniques and sub-techniques targeting AI agents, incorporated into the framework's first 2026 release in January.[^atlas-zenity] The framework now catalogues 15 tactics, 66+ techniques, and 46+ sub-techniques for adversarial AI.

The agent-specific techniques fill a gap that model-level threat frameworks miss. Three represent attack classes absent from traditional cybersecurity:

**AI Agent Clickbait (AML.T0100).** Agents increasingly browse the web, read documents, and interact with UIs on behalf of humans. Attackers can craft content optimized to manipulate machine decision-making, not human judgment. Because agents lack skepticism and situational awareness, they comply with instructions that appear task-aligned. As agentic browsers become embedded in enterprise copilots and workflow tools, this attack vector grows. AI Agent Clickbait formalizes it for defenders.[^atlas-zenity]

**AI Agent Context Poisoning (AML.T0080).** Adversaries manipulate the context used by an agent's LLM to persistently influence its responses or actions. This is the threat class Microsoft documented in the wild with AI Recommendation Poisoning (covered in [Agent Supply Chain Security](supply-chain-security.md)): 31 companies across 14 industries embedding hidden instructions to bias agent memory. ATLAS codifies the technique so security teams can model it.

**Exfiltration via AI Agent Tool Invocation.** The agent's own tools become the exfiltration channel. An attacker who achieves prompt injection does not need to establish a C2 channel: they instruct the agent to use its legitimate "write" tools (send an email, update a CRM record, post to Slack) with sensitive data encoded in the parameters. The data leaves through authorized channels that security tooling is designed to trust, not inspect.

In February 2026, MITRE published a detailed investigation of OpenClaw security incidents, mapping four confirmed attack cases to ATLAS techniques.[^atlas-openclaw] The investigation discovered seven new techniques unique to the OpenClaw ecosystem, all assessed as mature and realized in the wild. One attack chain: a poisoned OpenClaw Skill shared on ClawHub achieved 4,000+ downloads in a single hour using a malicious prompt hidden in the Skill payload. The Skill did not need to break the underlying system. It asked the system to betray itself: the distinction between code exploitation and context exploitation that defines the agentic attack surface.

For practitioners, OWASP and ATLAS are complementary tools. OWASP's Agentic Top 10 tells you which risk categories to prioritize (goal hijacking, tool misuse, supply chain). ATLAS tells you the specific adversary techniques within each category and how they chain together. The PAC Framework tells you what infrastructure prevents them. Together: risk taxonomy (OWASP) + attack playbook (ATLAS) + governance response (PAC). The next chapter develops that governance response: a framework that turns the threat landscape into deployment decisions.

[^atlas-zenity]: Zenity Labs, "Zenity's contributions to MITRE ATLAS's first 2026 release," zenity.io, January 2026. Zenity announced the 14 new agent-specific techniques in October 2025; they were incorporated into the first 2026 ATLAS release in January 2026. See also MITRE ATLAS, atlas.mitre.org.

[^atlas-openclaw]: MITRE, "ATLAS OpenClaw Investigation," mitre.org, February 9, 2026. Four confirmed attack cases mapped to ATLAS techniques, with seven new techniques unique to OpenClaw. Published by the Center for Threat-Informed Defense.

---

[^1]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," shanedeconinck.be, January 2026.
[^perplexity]: Adversa AI, "2025 AI Security Incidents Report," 2026. The Perplexity Comet vulnerability was disclosed in August 2025 and demonstrated indirect prompt injection through embedded instructions in web content.
[^pleasefix]: Zenity Labs, "PleaseFix Vulnerability Family in Perplexity Comet and Other Agentic Browsers," March 3, 2026. Two exploit paths: file system exfiltration via calendar invites and credential theft via password manager access. Perplexity addressed the browser-side agent execution issue before public disclosure.
[^google-workspace]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," shanedeconinck.be, March 2026.
[^supabase-cursor]: Barrack.ai, "Every AI App Data Breach Since January 2025: 20 Incidents, Same Root Causes," 2026. The Supabase Cursor agent breach is also covered in Practical DevSecOps, "MCP Security Vulnerabilities," 2026.
[^cascading-mas]: Yuxin Huang et al., ["On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents"](https://arxiv.org/abs/2408.00989), ICML 2025. Empirically measures how faulty agents degrade multi-agent system performance across different architectures.

[^mast-taxonomy]: Mert Cemri et al., ["Why Do Multi-Agent LLM Systems Fail?"](https://arxiv.org/abs/2503.13657), March 2025. Introduces MAST-Data (1,600+ annotated failure traces across 7 multi-agent frameworks) and documents cascading failure patterns.
[^2]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," shanedeconinck.be, January 2026.
[^3]: Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," shanedeconinck.be, January-March 2026. EU AI Act high-risk obligations originally set for August 2, 2026, subject to potential delay under the Digital Omnibus proposal.
[^4]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," shanedeconinck.be, February 2026.
[^github-mcp]: Reported across multiple security outlets in May 2025. The vulnerability allowed arbitrary command execution through malicious instructions embedded in GitHub Issues processed by MCP-connected agents.
[^mcptox]: MCPTox: A Benchmark for Tool Poisoning Attack on Real-World MCP Servers, arXiv:2508.14925, 2025. Tested 20 LLM agents against 353 authentic tools from 45 live MCP servers.
[^postmark-mcp]: Security researchers disclosed the backdoored postmark-mcp NPM package in September 2025. It was a supply chain attack targeting MCP infrastructure directly
[^huntress]: Huntress, "2026 Cyber Threat Report," huntress.com, February 2026. Documents identity threats dominating incident data, with OAuth abuse more than doubling year-over-year. Covers LangChain, Langflow, and GTG-1002 NHI compromise campaigns.
[^flashpoint]: Flashpoint, "2026 Global Threat Intelligence Report," flashpoint.io, March 12, 2026. Documents agentic AI cybercrime convergence across reconnaissance, phishing, credential testing, and infrastructure rotation.
[^sardine]: Sardine, "AI-driven fraud vectors: 7 agentic attacks now live in 2026," sardine.ai, March 2026. Documents seven agentic attack types currently producing losses across banking, fintech, and crypto partner networks.
[^5]: NIST, "Accelerating the Adoption of Software and AI Agent Identity and Authorization," NCCoE Concept Paper, February 2026. Comment period open through April 2, 2026.
[^codewall-mckinsey]: CodeWall, "How We Hacked McKinsey's AI Platform," codewall.ai, March 2026. Also covered in The Register, CyberNews, Inc., and The Decoder. CodeWall disclosed the attack chain on March 1, 2026. McKinsey patched all unauthenticated endpoints and took the development environment offline by March 2. The vulnerability was SQL injection in a JSON key concatenation, exploited by CodeWall's autonomous red-teaming agent.
[^mckinsey]: McKinsey, "Trust in the Age of Agents," The McKinsey Podcast, March 2026. Featuring Rich Isenberg (partner, Risk & Resilience). 80% of organizations have encountered risky behavior from AI agents. The governance framework requires archetypes, tiered approvals, and continuous monitoring.
[^codex-security]: OpenAI, "Codex Security: now in research preview," openai.com, March 6, 2026. During beta testing in the 30 days prior to public launch, scanned 1.2 million commits across external repositories. 792 critical findings, 10,561 high-severity findings across OpenSSH, GnuTLS, PHP, Chromium, and other open-source projects.
[^kai]: Kai, "Kai Emerges from Stealth with $125M," prnewswire.com, March 10, 2026. Led by Evolution Equity Partners. Founded by Galina Antova (co-founder Claroty) and Dr. Damiano Bolzoni (co-founder SecurityMatters/Forescout). Seven-figure bookings in first 10 months across energy, pharmaceuticals, automotive, and hospitality.
[^kiro]: Financial Times, reported February 20, 2026; Amazon response at aboutamazon.com, February 20, 2026. Amazon characterized the incident as "a user access control issue" involving "broader permissions than expected." Amazon mandated senior approval for AI-assisted production code changes post-incident.
[^kiro-pattern]: Barrack.ai, "Amazon's AI Deleted Production. Then Amazon Blamed the Humans," blog.barrack.ai, February 2026. Documents ten incidents across six major AI tools (Kiro, Replit AI Agent, Google Antigravity IDE, Claude Code/Cowork, Gemini CLI, Cursor IDE) from October 2024 to February 2026.
[^google-ai-malware]: Google Cloud Security, "Cloud Threat Horizons Report H1 2026," March 2026. UNC6426/QUIETVAULT attack chain documented: npm supply chain compromise → AI tool weaponization → AWS admin in 72 hours. Five AI-powered malware families (FRUITSHELL, PROMPTFLUX, PROMPTSTEAL, PROMPTLOCK, QUIETVAULT) identified in active deployment. APT28 (GRU) use of PROMPTSTEAL confirmed. See also The Hacker News, "UNC6426 Exploits nx npm Supply-Chain Attack to Gain AWS Admin Access in 72 Hours," March 2026.
[^owasp-agentic]: OWASP, "Top 10 for Agentic Applications for 2026," genai.owasp.org, December 2025. Developed by 100+ researchers with contributions from Zenity, NIST, Microsoft's AI Red Team, and others. Introduces Least-Agency and Strong Observability as core principles.
