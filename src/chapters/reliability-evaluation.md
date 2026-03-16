# Reliability, Evaluation, and the Complacency Trap

Reliability is getting easier. That is the problem.

Every model upgrade makes agents more capable. Teams delete scaffolding instead of adding it. Claude Code went from barely generating bash commands to writing all of its own code in about a year, and the engineering effort was *removing* workarounds that the model had outgrown[^scaffolding-post]. The pattern repeats across the industry: better models make agents more reliable with less effort.

This is good news for Potential. It is dangerous news for Accountability.

Shane frames the split: context engineering increases reliability, which is about whether the model does what you intended. Governance manages risk, which is about whether the agent is *allowed* to do what it is about to do. Better models solve the first problem. They make the second one worse[^trust-inversion].

The space between those two problems is where governance lives.

## What Reliability Actually Means

When teams say an agent is "reliable," they usually mean it completes its task correctly most of the time. But that headline number hides important questions.

The PAC Framework insists on a specific discipline here: reliability is a percentage *with its error margin*. A 95% success rate sounds impressive. A 95% ± 8% success rate means it could be 87% in production. Without the margin, the number is meaningless[^pac-framework].

Recent research decomposes reliability into four dimensions[^reliability-science]:

- **Consistency**: does the agent produce repeatable behavior across runs?
- **Robustness**: does it stay stable under input and environmental perturbation?
- **Predictability**: can it calibrate its own confidence and distinguish when it is likely wrong?
- **Safety**: when it fails, is the severity bounded?

These dimensions matter because they determine which failure modes an agent exhibits. An agent can be highly consistent (same answer every time) but not robust (breaks on unexpected inputs). It can be robust but not predictable (handles perturbation but cannot signal uncertainty). And it can score well on all three but still lack safety: when the failure happens, the consequences are unbounded.

An agent at B1 (contained) can tolerate lower reliability because errors are caught before impact. An agent at B4 (regulated) needs reliability across all four dimensions because each failure mode creates a different compliance exposure.

## The Benchmark Landscape

The industry has built a growing set of benchmarks to measure agent capability.

**SWE-bench Verified** is the most cited benchmark for coding agents. It contains 500 human-validated real-world software engineering issues from popular open-source repositories[^swe-bench]. Agents attempt to generate patches that resolve the issue and pass existing tests. Top scores have climbed steadily, but the benchmark measures task completion in controlled conditions, with a clear specification, a defined codebase, and an existing test suite to validate against.

**τ-bench** (Tau-bench), built by Sierra, tests agents in dynamic settings with real-time user interaction and tool use[^tau-bench]. It exposed a critical gap: agents built with standard constructs like function calling or ReAct performed poorly even on relatively simple tasks when the environment was interactive and unpredictable. Static benchmarks did not predict this.

**GAIA** tests general AI assistants on tasks requiring multi-step reasoning, web browsing, and tool use across domains[^gaia]. At the highest difficulty level (Level 3), the top score was 61% as of mid-2025. These are not edge cases: they are tasks a competent human assistant would handle routinely.

**The Holistic Agent Leaderboard (HAL)** from Princeton aggregates results across SWE-bench Verified Mini, GAIA, and other benchmarks into a unified view[^hal]. Its existence reflects a recognition that no single benchmark captures reliability across the dimensions that matter.

Benchmark methodology itself is now attracting regulatory attention. NIST's draft AI 800-2 "Practices for Automated Benchmark Evaluations of Language Models" is open for public comment through March 31, 2026[^nist-benchmarks]. The document aims to establish best practices for how benchmarks are constructed, administered, and reported. For organizations using benchmark scores to justify agent autonomy levels (as the PAC Framework recommends), standardized evaluation methodology is not just a technical concern: it is a governance input.

The pattern is clear: agents perform well on structured, repeatable tasks (coding with clear specs and test suites) and struggle on open-ended, interactive, multi-step tasks. Software engineering accounts for nearly 50% of all agent tool calls precisely because it has the clearest validation loops[^anthropic-data].

## The Evaluation Gap

Benchmarks measure *capability*. Production requires *governance*.

LangChain's 2026 State of AI Agents report surveyed over 1,300 professionals and found that 57% of organizations now have agents in production[^langchain-report]. Quality was cited as the top barrier by 32% of respondents. Cisco's State of AI Security 2026 report puts the readiness gap in sharper terms: 83% of organizations plan to deploy agentic AI, but only 29% feel they can do so securely.[^cisco-ai-security] That is a 54-point gap between ambition and preparedness, and it shows up in the evaluation practices:

- 52% run offline evaluations on test sets before deployment
- 37% run online evaluations monitoring real-world performance
- 60% rely on human review
- 53% use LLM-as-judge approaches to scale quality assessment
- 23% of organizations with agents in production report not evaluating at all

The gap between offline evaluation (controlled, pre-deployment) and online evaluation (real-world, post-deployment) is where governance breaks down. Anthropic's research noted this directly: many critical findings "cannot be observed through pre-deployment testing alone"[^anthropic-data].

Pre-deployment evaluation tells you what the agent *can* do. Post-deployment monitoring tells you what it *does*. An agent that scores 95% on a benchmark may encounter production conditions that no test set anticipated: adversarial inputs, data drift, novel tool interactions, multi-agent delegation chains where context degrades at each hop.

At I1 (Open), there is no monitoring: you know the agent's benchmark score and nothing else. At I2 (Logged), you can see what happened after the fact. At I3 (Verified), structured audit trails let you analyze patterns. At I4 (Authorized), real-time monitoring triggers intervention. At I5 (Contained), anomaly detection and automated containment prevent cascading failures.

Most organizations are at I1 or I2 for their agent deployments. That means they know what the agent *could* do (benchmarks) but not what it *did* (observability).

## The Observability Shift

Agent observability is fundamentally different from traditional software monitoring. The error lives in the reasoning, not necessarily in the code execution. An agent can execute every function call correctly and still produce a bad outcome because its reasoning chain was flawed. The distinction matters: observability for debugging (finding what went wrong after an incident) is different from observability for governance (proving what happened and why, for compliance purposes).

Among the 919 enterprise leaders Dynatrace surveyed in January 2026, 44% of those with production agentic AI deployments still rely on manual methods to review communication flows between agents.[^dynatrace-pulse] Manual review of agent-to-agent communication does not scale: it cannot detect cascading failures propagating at machine speed, internal leakage through unmonitored channels, or the emergent offensive cooperation documented in the [Multi-Agent Trust](multi-agent-trust.md) chapter. The same survey found that the biggest barrier to scaling agentic AI is not doubt about the technology but inability to "govern, validate, or safely scale autonomous systems." Having observability and having governance-grade observability are different problems.

The distinction between debugging and compliance matters here. A debugging log tells an engineer what to fix. A compliance-grade audit trail tells a regulator what the agent did, what authority it had, who delegated that authority, and what information was available at the time of the decision. Shane's trust-for-agentic-ai post illustrates the gap: an expense-approval agent authorized $47,000 in vendor payments, but "the audit trail has no way to capture" that the agent, not the human, made the decision[^trust-for-agentic]. These are different artifacts with different requirements.

The EU AI Act Article 12 requires "automatic recording of events" for high-risk AI systems, with logs capable of supporting post-market monitoring[^regulatory-landscape]. NIST's concept paper emphasizes traceability of agent actions to their authorizing principals[^nist-concept]. Neither is satisfied by a debugging log. Both require structured observability at I3 or above.

## The Complacency Trap

Reliability is improving. Evaluation is maturing. Observability is being built. All of these are necessary. None of them address the most dangerous failure mode: the one where everything works, until it does not, and nobody is watching.

Shane references Don Norman's work on automation: "Over fifty years of studies show that even highly trained people are unable to monitor situations for long periods and then rapidly take effective control when needed"[^trust-inversion].

This is not a new problem. Lisanne Bainbridge described the "ironies of automation" in 1983[^bainbridge-1983]. Her central insight was paradoxical: the more you automate, the more skilled and practiced the human operators need to be, but automation removes the very practice that keeps those skills sharp. The operator becomes a monitor of a system they no longer understand deeply enough to intervene in effectively.

Bainbridge identified two compounding failures:

1. **Skill degradation**: operators who rarely intervene lose the ability to intervene well. Their manual skills atrophy. Their mental model of the system becomes stale.
2. **Vigilance failure**: monitoring a system that almost always works correctly is cognitively exhausting and unrewarding. Attention wanders. Anomalies get dismissed. The twenty-first output gets the same rubber stamp as the first twenty.

Don Norman extended this in 1990, arguing that the problem is not automation itself but intermediate automation: systems that can cope with many things but not everything[^don-norman-1990]. The human operator is lulled into a false sense of security by the automation's competence, then ambushed when the automation encounters something outside its capability. The human must diagnose the problem, re-establish situation awareness, and take effective action, all under time pressure, with degraded skills, and with no prior warning.

Forty years of aviation research confirms this pattern. Mode confusion in automated cockpits, where the pilot does not understand what the autopilot is doing or why, has contributed to multiple accidents[^aviation-research]. The more capable the automation, the more subtle and dangerous the failure mode.

### The Agent Version

AI agents exhibit the same dynamics, with amplifiers.

An AI agent does not fail gracefully. It does not raise a hand and say "I'm not sure about this one." It produces output with the same confidence whether it is correct or wrong. Unlike an autopilot that displays its current mode and target parameters, an agent's reasoning is opaque. When it slips, the slip looks like competence.

"After twenty correct outputs, who reviews the twenty-first carefully?"[^anthropic-data]

The complacency pattern for agents:

**Review fatigue**: human reviewers approve agent outputs faster as confidence builds. The approval becomes a checkbox, not a review. Anthropic's data shows 73% of agent tool calls involve human oversight of some form[^agent-profiler]. But oversight that is not attentive is not oversight.

**Accountability diffusion**: code committed under a developer's account looks the same whether a human or an agent wrote it. If something breaks three months later, the question of who understood the decision at the time it was made has no good answer[^anthropic-data].

**Scope creep through success**: reliable agents get handed more responsibility. The blast radius increases incrementally. An agent that started as B1 (contained, internal tool) gradually becomes B3 (exposed, customer-facing) without anyone making a deliberate decision to accept that increased risk.

**The 99% problem**: an agent that is right 99% of the time is more dangerous than one that is right 80% of the time. At 80%, humans stay engaged because errors are frequent enough to maintain vigilance. At 99%, the errors are rare enough to seem like anomalies rather than a systemic issue. But 1% of a million actions is ten thousand failures.

Recent evidence reinforces this pattern beyond AI. A multicentre study in The Lancet found that clinicians' adenoma detection rate during colonoscopy dropped by 6 percentage points (a 20% relative decrease) after several months of performing the procedure with AI assistance[^clinician-complacency]. The AI made them better on average but degraded their independent capability.

Only 21% of executives report complete visibility into agent permissions, tool usage, or data access patterns[^agent-security]. Meanwhile, 80% of organizations surveyed reported risky agent behaviors including unauthorized system access and improper data exposure. Splunk's 2026 CISO Report (650 global CISOs): 82% believe agentic AI will increase their teams' detection and response speed, while 86% fear it will increase the sophistication of social engineering attacks.[^splunk-ciso] The agents are becoming more reliable. The humans governing them are not keeping up.

## Why Better Models Make Governance Harder

Potential and Accountability are supposed to reinforce each other. Higher business value (Potential) justifies investment in governance (Accountability). Better governance enables greater autonomy, which unlocks more value. The virtuous cycle.

The complacency trap breaks this cycle. Higher reliability (Potential) reduces perceived risk, which reduces investment in governance (Accountability). The organization gets better agents and worse oversight simultaneously. The blast radius grows while the safety net thins.

Shane frames this as a fundamental split: context engineering and governance are not the same problem. "As reliability improves, the risk might grow. When an agent gets things right 99% of the time, we stop watching"[^trust-inversion].

Control is what prevents the cycle from breaking. Infrastructure-enforced checkpoints do not care whether the human is paying attention. A governance threshold at I4 (Authorized) requires identity verification and scoped authorization before each action, regardless of how reliable the agent has been historically. An audit trail at I3 (Verified) records what happened whether or not anyone reviews it in real time.

Infrastructure is a gate, not a slider[^agent-profiler]. You cannot compensate for missing infrastructure with higher reliability. An agent that is right 99.9% of the time without audit trails is less trustworthy than one that is right 95% with full observability, because when the 0.1% failure happens, you have no way to understand what went wrong, no way to prove what happened, and no way to prevent it from happening again.

## From "Human in the Loop" to Infrastructure in the Loop

The traditional answer to automation risk is "keep a human in the loop." Decades of research show this does not work as advertised[^bainbridge-1983][^don-norman-1990]. Humans are bad at monitoring systems that rarely fail. They are worse at intervening quickly when those systems fail unexpectedly. The more reliable the system, the worse the human becomes at their monitoring role.

Anthropic's research acknowledges this, recommending that the focus should be on "whether humans are in a position to effectively monitor and intervene, rather than on requiring particular forms of involvement"[^anthropic-data].

"Human in the loop is not a reliable safety net."[^trust-inversion]

The alternative is not removing humans from governance. It is building infrastructure that does not depend on human vigilance for its effectiveness. Humans set policy. Infrastructure enforces it. As Shane puts it in his boardroom questions: "Policy says what agents shouldn't do. Architecture limits what they *can* do, regardless of what they try"[^boardroom-questions]. The [Human-Agent Collaboration Patterns](human-agent-collaboration.md) chapter covers what this looks like in practice: three oversight models, per-task autonomy dials, and UX patterns that make oversight effective without requiring sustained attention.

Concretely, this means:

**Structural authorization over approval workflows**: instead of a human approving each action, define the scope of allowed actions in advance and let infrastructure enforce the boundaries. The human designs the boundaries, not reviews each crossing.

**Anomaly detection over vigilant monitoring**: instead of expecting humans to spot problems in real time, build detection systems that flag statistical deviations. The human investigates flagged events, not watches a stream.

**Automatic containment over manual intervention**: when an agent exceeds its boundaries, infrastructure should halt or contain the action before a human needs to react. The human decides what to do next, not catches the problem in flight.

**Audit trails over trust**: record everything, review selectively. The audit trail exists whether or not anyone looks at it today. When an incident occurs (and it will), the record is complete.

Moving from I2 (Logged) to I4 (Authorized) is not primarily about technology. It is about shifting the burden from human attention to architectural constraint. [Sandboxing and Execution Security](execution-security.md) covers the containment layer: the architectural constraints that bound what an agent can do when reliability fails. [Shadow Agent Governance](shadow-agent-governance.md) addresses why evaluation matters organizationally: ungoverned agents bypass evaluation entirely, making reliability unmeasurable.

## Evaluation as Governance

Evaluation practices themselves need to be treated as governance infrastructure, not just engineering tooling.

Current evaluation approaches sit at two levels:

**Pre-deployment evaluation** (offline evals, benchmarks, test sets) answers the question: is this agent capable enough? This is a Potential question. Important, but not sufficient.

**Post-deployment evaluation** (online monitoring, anomaly detection, compliance auditing) answers the question: is this agent behaving within its authority? This is an Accountability question. Critical, and underbuilt. NIST's March 2026 report "Challenges to the Monitoring of Deployed AI Systems" (NIST AI 800-4) documents exactly why: detecting drift, logging across distributed infrastructure, capturing human-AI feedback loops, and identifying deceptive behavior are all unsolved at scale[^nist-monitoring]. The report, based on three practitioner workshops and an extensive literature review, confirms that post-deployment monitoring for AI systems remains "a vast and fragmented space."

The gap between these two levels is where the complacency trap lives. Teams invest heavily in pre-deployment evaluation because it is familiar (it looks like software testing) and because it answers the question leadership asks first ("does it work?"). They underinvest in post-deployment evaluation because it is less familiar, harder to build, and answers questions nobody wants to ask until something goes wrong ("what did it do, and who authorized it?").

The LangChain data confirms this: 52% run offline evaluations, but only 37% run online evaluations[^langchain-report]. The drop-off is where governance demands increase.

Treating evaluation as infrastructure means:

- **Eval pipelines are versioned and auditable**, like the agents they test
- **Evaluation criteria include governance dimensions**, not just accuracy: was the action within scope? Was the delegation chain intact? Did the agent access only what it was authorized to access?
- **Evaluation results feed back into infrastructure levels**: an agent that drifts below its reliability threshold gets automatically restricted to a lower autonomy level
- **Post-deployment monitoring is continuous**, not periodic: the agent's behavior is compared against its governance profile in real time

### Evaluation Is Being Absorbed into the Platform

OpenAI announced its acquisition of Promptfoo in March 2026.[^openai-promptfoo] Promptfoo is an open-source AI security platform used by more than 350,000 developers, with teams at over 25% of the Fortune 500 relying on it for automated red-teaming, vulnerability scanning, and compliance monitoring. The technology will be integrated into OpenAI Frontier, the company's enterprise platform for building and operating AI agents.

This follows the same pattern Shane described for intelligence itself: evaluation is becoming a platform feature, not independent infrastructure. When your model provider also provides your evaluation tooling, the convenience is real but the governance question is sharp: who evaluates the evaluator?

The Accountability pillar requires that evaluation be independent enough to be trustworthy. An evaluation system that shares a provider, incentive structure, and release cycle with the model it evaluates has a structural conflict of interest. This does not mean platform-integrated evaluation is useless. Pre-deployment red-teaming, vulnerability scanning, and compliance checks are valuable wherever they run. But for governance purposes, the organization needs evaluation capability it controls: its own benchmarks, its own monitoring, its own criteria for what "within scope" means.

The practical recommendation: use platform evaluation tools for what they are good at (automated red-teaming, known vulnerability patterns, compliance checklists). Build and maintain independent evaluation for what governance requires (domain-specific benchmarks, organizational policy compliance, cross-provider comparison, audit trail integrity). Independent evaluation is what makes "infrastructure as gate" credible: the gate cannot be operated by the same entity whose traffic it is gatekeeping.

### The Tool Abuse Blind Spot

The AgentShield benchmark, released in March 2026 as the first open, reproducible evaluation of commercial AI agent security products, exposes a systematic gap in the security tooling layer itself.[^agentshield] Testing seven commercial products across 537 test cases in eight categories, the benchmark found composite scores ranging from approximately 39 to 98: a wide spread that reflects genuine capability differences. But the most important finding cuts across all products: tool abuse detection is weak across the board. Several products that catch over 95% of prompt injection attempts miss most unauthorized tool calls.

The industry has built increasingly sophisticated defenses against prompt injection: the attack vector that dominates the threat taxonomy. But agents do not just process prompts. They invoke tools. An agent that is fully protected against prompt injection but not against unauthorized tool use is protected against one attack vector while leaving the more operationally dangerous one open: the confused deputy operating through legitimate tool calls with legitimate credentials.

The benchmark's methodology is itself notable. The test corpus, scoring methodology, and adapter code are open source and auditable. AgentShield includes a commit-reveal protocol that allows vendors to run the benchmark locally on proprietary models while cryptographically proving result legitimacy. This addresses the evaluation integrity problem: when the entity being evaluated controls the evaluation environment, independent verification matters.

AgentShield validates a claim the book makes structurally: evaluation must be multi-dimensional. An agent security product that scores 98% on prompt injection and 40% on tool abuse provides a false sense of security. The governance question is not "is this agent protected?" but "protected against which threat categories, and at what coverage level?" At I4 (Authorized), evaluation must cover the full attack surface, not just the most studied subset.

## Mapping to PAC

The reliability and evaluation landscape maps to all three PAC pillars:

| Dimension | Potential | Accountability | Control |
|---|---|---|---|
| **Reliability** | Headline capability metric | Must include error margin for governance thresholds | Infrastructure determines whether reliability is measured or assumed |
| **Benchmarks** | Prove capability for business case | Insufficient for compliance (pre-deployment only) | Gate function: minimum benchmark scores per autonomy level |
| **Post-deployment monitoring** | Protects business value (catches degradation) | Required for regulatory compliance (EU AI Act Article 12) | I3+ infrastructure: structured audit trails and monitoring |
| **Complacency** | Higher reliability amplifies complacency | Degrades human oversight, the Accountability backstop | Only infrastructure-enforced checkpoints survive complacency |
| **Evaluation-as-governance** | Ensures continued performance | Proves compliance over time | Closes the loop between policy and enforcement |

The critical insight: reliability is a Potential metric that organizations treat as an Accountability metric. "The agent is 95% accurate" feels like it answers the governance question. It does not. Governance asks: when the 5% happens, can you trace it, contain it, explain it, and prevent it? That is an infrastructure question.

## What to Do

**Measure reliability honestly.** Report the error margin alongside the headline number. Decompose reliability into consistency, robustness, predictability, and safety. A single accuracy number is a marketing metric, not a governance input.

**Close the evaluation gap.** If you have offline evaluations, build online monitoring. If you have online monitoring, add governance dimensions: scope compliance, delegation integrity, authorization validity. The drop from 52% to 37% adoption between offline and online evaluation is the complacency trap in data form.

**Do not trust human oversight at scale.** Design systems that enforce boundaries architecturally. Use humans for policy design, threshold setting, and incident investigation, not real-time monitoring. If your governance model depends on a human approving every action, your governance model will fail.

**Make infrastructure earn autonomy.** An agent should not move from A2 (Approve) to A3 (Oversight) because it has been reliable. It should move because the infrastructure beneath it has matured: structured audit trails, anomaly detection, automatic containment. Reliability is necessary but not sufficient.

**Treat the 99% problem as a design constraint.** The more reliable your agent becomes, the more important your infrastructure becomes. High reliability without strong infrastructure is not safe: it is a system optimized for complacency.

[Agent Identity and Delegation](agent-identity.md) covers the infrastructure (OBO, DPoP, Verifiable Intent) that makes autonomy progression from A2 to A5 safe: reliability justifies higher autonomy, but identity infrastructure gates it. [Sandboxing and Execution Security](execution-security.md) provides the containment layer that limits blast radius when the 1% or 5% failure happens: defense in depth is the architectural complement to evaluation. [Human-Agent Collaboration Patterns](human-agent-collaboration.md) addresses how to design oversight models that account for complacency: matching autonomy levels to blast radius, and using infrastructure-in-the-loop where sustained human vigilance is unreliable. [Shadow Agent Governance](shadow-agent-governance.md) confronts the evaluation gap at the organizational level: shadow agents operate without any evaluation, making the 52%-to-37% offline-to-online adoption drop even more concerning when most agents are unregistered.

[^scaffolding-post]: Shane Deconinck, ["AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting."](https://shanedeconinck.be/posts/ai-agent-scaffolding-trap/) (February 2026).

[^trust-inversion]: Shane Deconinck, ["AI Agents Need the Inverse of Human Trust"](https://shanedeconinck.be/posts/agent-trust-inversion/) (February 2026).

[^pac-framework]: Shane Deconinck, [PAC Framework](https://trustedagentic.ai/framework/) (2026).

[^reliability-science]: Stephan Rabanser, Sayash Kapoor et al., ["Towards a Science of AI Agent Reliability"](https://arxiv.org/html/2602.16666v1) (February 2026).

[^swe-bench]: Carlos E. Jimenez et al., ["SWE-bench: Can Language Models Resolve Real-World GitHub Issues?"](https://www.swebench.com/) OpenAI validation of SWE-bench Verified (500 human-validated samples).

[^tau-bench]: Sierra, ["τ-Bench: Benchmarking AI agents for the real-world"](https://sierra.ai/blog/benchmarking-ai-agents) (2025).

[^gaia]: GAIA Benchmark, results via [HAL Leaderboard](https://hal.cs.princeton.edu/gaia). Top Level 3 score: 61% (Writer's Action Agent, mid-2025).

[^hal]: Princeton PLI, [Holistic Agent Leaderboard (HAL)](https://hal.cs.princeton.edu/). Accepted to ICLR 2026.

[^anthropic-data]: Shane Deconinck, ["Early Indicators of Agent Use Cases: What Anthropic's Data Shows"](https://shanedeconinck.be/posts/early-indicators-agent-use-cases-anthropic-data/) (February 2026). Original research: Anthropic, ["Measuring AI Agent Autonomy in Practice"](https://www.anthropic.com/research/measuring-agent-autonomy) (February 2026).

[^langchain-report]: LangChain, ["State of AI Agents"](https://www.langchain.com/state-of-agent-engineering) (2026). Survey of 1,300+ industry professionals.

[^bainbridge-1983]: Lisanne Bainbridge, ["Ironies of Automation"](https://www.sciencedirect.com/science/article/abs/pii/0005109883900468), *Automatica* 19(6), 775-779 (1983).

[^don-norman-1990]: Don Norman, ["The 'problem' with automation: inappropriate feedback and interaction, not 'over-automation'"](https://doi.org/10.1098/rstb.1990.0101), *Philosophical Transactions of the Royal Society of London. Series B* (1990). DOI: 10.1098/rstb.1990.0101.

[^aviation-research]: The human factors literature on automation complacency in aviation is extensive. Key references include Parasuraman and Riley, "Humans and Automation: Use, Misuse, Disuse, Abuse" (1997) and Endsley, "Toward a Theory of Situation Awareness in Dynamic Systems" (1995).

[^agent-profiler]: Shane Deconinck, ["Untangling Autonomy and Risk for AI Agents"](https://shanedeconinck.be/posts/agent-profiler-reasoning/) (February 2026).

[^regulatory-landscape]: See [The Regulatory Landscape](regulatory-landscape.md) for detailed coverage of EU AI Act Article 12 requirements and NIST agent identity standards.

[^nist-concept]: NIST NCCoE, "Accelerating the Adoption of Software and AI Agent Identity and Authorization" (February 2026).

[^clinician-complacency]: Budzyń et al., ["Endoscopist deskilling risk after exposure to artificial intelligence in colonoscopy: a multicentre, observational study"](https://www.thelancet.com/journals/langas/article/PIIS2468-1253(25)00133-5/abstract), *The Lancet Gastroenterology & Hepatology* (online first August 2025; print October 2025). Adenoma detection rate in non-AI exams fell from 28.4% to 22.4% (6 percentage points) after months of routine AI-assisted colonoscopy, a 20% relative decrease.

[^agent-security]: Help Net Security, ["AI went from assistant to autonomous actor and security never caught up"](https://www.helpnetsecurity.com/2026/03/03/enterprise-ai-agent-security-2026/) (March 2026). Statistics drawn from AIUC-1 Consortium briefing (developed with Stanford's Trustworthy AI Research Lab and more than 40 security executives). Only 21% of executives report complete visibility into agent permissions.

[^openai-promptfoo]: OpenAI, ["OpenAI to acquire Promptfoo"](https://openai.com/index/openai-to-acquire-promptfoo/) (March 9, 2026). Promptfoo's open-source red-teaming and evaluation platform has 350,000+ developers and 130,000 monthly active users. Integration into OpenAI Frontier for enterprise agent deployment.

[^nist-monitoring]: NIST CAISI, ["Challenges to the Monitoring of Deployed AI Systems"](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.800-4.pdf) (NIST AI 800-4, March 2026). Based on three practitioner workshops and literature review. Identifies category-specific challenges including drift detection, distributed logging, human-AI feedback loops, and deceptive behavior identification.

[^cisco-ai-security]: Cisco, ["State of AI Security 2026"](https://www.cisco.com/site/us/en/products/security/state-of-ai-security.html) (2026). 83% of organizations plan agentic AI deployment; only 29% feel ready to do so securely. Examines MCP attack surface, prompt injection evolution, and AI supply chain fragility.

[^splunk-ciso]: Splunk (Cisco), ["The CISO Report: From Risk to Resilience in the AI Era"](https://newsroom.cisco.com/c/r/newsroom/en/us/a/y2026/m02/splunk-report-agentic-ai-takes-center-stage-in-cisos-path-to-digital-resilience.html) (February 2026). Survey of 650 global CISOs. 83% cite hallucination impacts as greatest agentic AI concern. 86% fear increased social engineering sophistication. 82% expect improved detection and response speed.

[^nist-benchmarks]: NIST CAISI, ["Practices for Automated Benchmark Evaluations of Language Models"](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.800-2.ipd.pdf) (NIST AI 800-2, Initial Public Draft, January 2026). Public comment period through March 31, 2026.

[^dynatrace-pulse]: Dynatrace, ["The Pulse of Agentic AI in 2026"](https://www.dynatrace.com/info/reports/the-pulse-of-agentic-ai-in-2026/) (January 2026). Global survey of 919 senior leaders at enterprises with $100M+ annual revenue, conducted by Y2 Analytics. 50% have production deployments; 44% rely on manual methods to review agent communication flows; top validation methods include data quality checks (50%), human review of outputs (47%), and monitoring for drift (41%).

[^agentshield]: AgentShield, ["AgentShield Benchmark: AI Agent Security Product Comparison"](https://github.com/doronp/agentshield-benchmark) (March 2026). Open-source benchmark of 7 commercial AI agent security products across 537 test cases in 8 categories. Composite scores range from ~39 to ~98. Key finding: tool abuse detection is weak across the board even when prompt injection detection is strong.

[^trust-for-agentic]: Shane Deconinck, ["Trust for Agentic AI"](https://shanedeconinck.be/posts/trust-for-agentic-ai/) (January 2026).

[^boardroom-questions]: Shane Deconinck, ["Agentic AI: Curated Questions for the Boardroom"](https://shanedeconinck.be/posts/agentic-ai-curated-questions-for-the-boardroom/) (February 2026).
