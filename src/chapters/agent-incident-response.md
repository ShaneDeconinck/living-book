# Agent Incident Response

An AI coding agent running on Replit received an instruction during a production code freeze. The instruction was legitimate: a developer had asked it to run cleanup tasks. The agent executed destructive commands. Production data was lost.[^replit-incident] The incident was documented, post-mortemed, and treated as a software failure.

That framing is wrong, and the wrong framing leads to the wrong fix.

The agent did not malfunction. It acted on an instruction that, under its delegated authority, it was technically permitted to carry out. The failure was not in the model's execution. It was in the governance that let the agent operate with authority it should never have held during a freeze — authority that no human had explicitly granted for that specific context, that had not been scoped to current conditions, and that no one had arranged to revoke when the situation changed. A traditional incident response playbook looks for the bug. There was no bug. There was a governance gap.

Agent incidents differ from software incidents in three structural ways. Each difference changes what the response looks like.

## Three Structural Differences

**Agent incidents are decision failures, not execution failures.** A software incident typically traces to code that behaved incorrectly: a race condition, an off-by-one error, an unhandled exception. The fix is a patch. An agent incident traces to a decision the agent made — a decision that was within its technical capacity but outside the intent of whoever delegated authority to it. The root cause is not correctable by patching the model. It requires revisiting what was delegated, to whom, and under what conditions.

**Blast radius assessment requires tracing the delegation chain.** In software incidents, blast radius is bounded by the system's data access scope. In agent incidents, the blast radius is bounded by the agent's delegated authority, which may span multiple systems, multiple tool integrations, and multiple downstream agents that acted on this agent's outputs before the incident was detected. The Operator agent that processed an unauthorized $31.43 transaction — documented in AI Incident Database Incident 1028 — had authority derived from a human approval, passed through a platform, and exercised across a payment integration.[^operator-transaction] Tracing what the agent touched requires following that chain, not scanning a single system's logs.

**Containment requires coordinated revocation.** Revoking a compromised agent's credentials stops that agent. It does not stop downstream agents that have already acted on its outputs, persisted its decisions in shared memory, or further delegated based on authority it passed along. Containment in multi-agent systems is closer to distributed transaction rollback than to account suspension. The question is not "did we revoke the token?" It is "did every system that received this agent's instructions before revocation get unwound?" The Salesloft Drift AI breach demonstrated this at scale: stolen OAuth tokens exposed over 700 companies in 10 days because revocation across SaaS integrations was not coordinated. When one organization revoked credentials, connected domains had no standard mechanism to receive that signal.[^csa-cross-domain]

These three differences mean the standard NIST incident response lifecycle — Preparation, Detection, Analysis, Containment, Eradication, Recovery — applies, but each phase requires agent-specific tooling and reasoning that the standard playbooks do not address.[^nist-ir-8596]

## Phase 1: Blast Radius Assessment

Before containment, before root cause, the first question is scope: what did this agent touch, and what did anything downstream touch as a result?

This requires delegation chain tracing. Every action the agent took — tool calls, API requests, sub-agent invocations, shared memory writes — needs to be enumerable from audit logs. If the logs are structured correctly, each action carries the agent's identity, the token or credential used, the scope of that credential, and the timestamp. Security Boulevard's March 2026 analysis of forensics for agent systems identifies the minimum required audit record: agent identity, tenant context, delegation status, and authorization scope.[^secboulevard-forensics]

Without structured audit logs, blast radius assessment is guesswork. This is the most common practical failure: organizations that have logs but not the right logs. A log that says "tool X was called at time T" is insufficient. A log that says "tool X was called at time T by agent Y acting under credential Z, delegated from principal P with scope S" is forensically useful.

The blast radius assessment answers four questions:
1. What systems did the agent access, and with what authority?
2. What downstream agents received outputs from this agent, and what did they do with those outputs?
3. Were any of those outputs persisted — in databases, shared memory, external APIs — in ways that require rollback?
4. Did any downstream agent further delegate based on authority this agent passed along?

A compromised agent in a multi-agent system is not just a threat actor. It is a corrupted instruction source for everything downstream.

## Phase 2: Containment

Traditional containment: revoke the account, isolate the system, stop the bleeding. Agent containment requires the same starting actions plus two additions.

**Coordinated downstream notification.** Every agent that received instructions from the compromised agent needs to know those instructions are suspect. In systems using structured delegation (DCTs, authority chains, or delegation registries), this is mechanical: find everything the agent instructed, flag the chain. The FINOS Air Governance Framework's Agentic System Credential Protection Framework (AIR-PREV-023) specifies automated revocation with cascade rotation for derived credentials as a required response capability.[^finos-air-prev-023]

In systems without delegation registries, downstream notification requires manual log tracing — which is slow and error-prone at the scale of autonomous agents operating across dozens of tools and APIs simultaneously.

**Ephemeral credential design reduces containment scope.** The best containment is architectural. An agent operating with credentials that expire in minutes — ghost tokens, CAAM-style authorization sidecars, WIF-scoped tokens bound to specific request context — has a narrow window of exploitability. By the time an incident is detected, many credentials have already expired. The FINOS framework distinguishes between long-lived standing credentials (which require explicit revocation and cascade rotation) and ephemeral credentials (which expire and self-contain). Organizations running agents with long-lived service account tokens face a harder containment problem than those running with ephemeral, scoped credentials.

Strata Identity's analysis of compromised multi-agent systems: with standing privileges, a single compromised agent can pivot to any resource its credentials reach. With dynamic, ephemeral permissions enforced at runtime, the blast radius of any single compromise is bounded by the scope and lifetime of the credential in use at the moment of compromise.[^strata-analysis]

## Phase 3: Root Cause

Most organizations skip the governance root cause. Not "what did the agent do?" but "what governance failure made this possible?"

CoSAI's AI Incident Response Framework, adapted from the NIST lifecycle and published in October 2025, provides incident categories, detection methods, and response procedures for AI-specific threat vectors.[^cosai-ir] The immediate cause is a specific exploit or failure mode; the structural cause is almost always insufficient delegation controls. An agent that abuses a tool was given access it should not have had. An agent that follows injected instructions lacked input validation at a trust boundary. An agent that operates outside its intended scope was given credentials that did not constrain that scope.

Three governance questions frame the root cause:

- **Did the liability chain exist before the incident?** "If the chain isn't mapped before the incident, it's too late to draw one after."[^pac-framework] Most agent deployments cannot answer a regulator's question: "Who authorized this agent to take that action, and what limits did they impose?"

- **Was the delegation documented at the point of grant?** An agent operating with inherited service account credentials has no grant event to trace. The authority was ambient. Governance root cause requires a clear record of what was delegated, by whom, at what scope, and for what duration — not inferred from configuration, but recorded when the delegation occurred.

- **What control did architecture enforce, and what did it only advise?** A policy that said "this agent should not run destructive commands during a freeze" is advisory. Architecture that would have made those commands impossible — scoped credentials that excluded write operations, a freeze flag that reduced the agent's authorization scope automatically — is structural. Root cause analysis must identify the gap between what policy said and what architecture enforced.

The OWASP GenAI Incident Response Guide distinguishes this from traditional cybersecurity incidents: in GenAI incidents, root cause often leads to probabilistic failure rather than deterministic code flaws, but in agent incidents with governance failures, the root cause is deterministic — a specific gap in delegation design, scope enforcement, or credential lifecycle management.[^owasp-ir-guide]

## The Existing Frameworks

Three frameworks now provide structured guidance for AI incident response.

**CoSAI AI Incident Response Framework** (October 2025, OASIS Open Project): adapts the NIST lifecycle with CACAO-standard playbooks for AI-specific categories. Includes detection methods, triage criteria, containment steps, and recovery procedures for each category. The framework explicitly acknowledges that traditional IR playbooks were not designed for agentic AI and provides forensic investigation guidance for agent workflows.[^cosai-ir] Available open-source on GitHub (cosai-oasis/ws2-defenders).

**OWASP GenAI Incident Response Guide 1.0** (mid-2025): covers agentic-specific threats in GenAI deployments. Companion to the OWASP Top 10 for Agentic Applications, published December 9, 2025, developed with input from over one hundred security researchers.[^owasp-ir-guide] The OWASP Top 10 for Agentic Applications identifies ten risk categories that directly inform incident classification: ASI03 (Identity and Privilege Abuse) maps to delegation failures, ASI07 (Insecure Inter-Agent Communication) maps to trust boundary violations, and ASI08 (Cascading Failures) maps to the multi-agent propagation problem this chapter addresses.[^owasp-agentic-top10]

**NIST IR 8596** (Cyber AI Profile, preliminary draft December 2025): defines conditions for disabling AI autonomy during risk response and integrates AI-specific procedures for containment and recovery into the NIST Cybersecurity Framework.[^nist-ir-8596]

Microsoft's security team published a prompt abuse playbook in March 2026 that frames prompt injection as an operational failure mode requiring dedicated IR procedures. The playbook covers detection telemetry (Defender for Cloud Apps, Purview DLP, Microsoft Sentinel) for enterprise AI tool abuse.[^msft-prompt-abuse]

None of these frameworks addresses coordinated revocation in multi-agent delegation chains as a first-class response action. The frameworks identify the problem, but the tooling for cascade revocation, downstream notification, and delegation-chain forensics does not yet exist at production maturity. NIST's AI Agent Standards Initiative (February 2026) may close part of this gap: its concept paper on agent identity and authorization is open for comment through April 2, 2026, with sector-specific listening sessions scheduled for April.[^nist-caisi]

## Infrastructure Maturity for Incident Response

| **Level** | **IR Capability** | **What You Can Do** |
|-----------|------------------|---------------------|
| **I1: Open** | No dedicated IR capability. Agent failures handled as software incidents. | Incident detected by user reports or system monitoring. No agent-specific logs. |
| **I2: Logged** | Basic audit logging. Can reconstruct what happened post-incident. | Tool call logs with identity. Limited blast radius assessment. Manual trace. |
| **I3: Verified** | Structured delegation logs. Blast radius assessment is tractable. Agent-specific IR playbooks exist. | Delegation chain trace from logs. Credential revocation. No automated cascade. |
| **I4: Authorized** | Delegation registries. Automated downstream notification. Ephemeral credentials reduce containment scope. | Cascade revocation. Downstream agent notification. Governance root cause traceable. |
| **I5: Contained** | Full IR automation. Continuous monitoring with anomaly detection. Automated quarantine. Root cause leads to delegation design, not individuals. | Real-time detection. Automated containment. Post-incident governance review produces delegation design changes. |

Most enterprise agent deployments are at I1 or I2. The CoSAI and OWASP frameworks are designed for I3. The gap between I2 (logs that exist) and I3 (logs that answer the right questions) is the immediate practical priority.

## PAC Framework: Incident Response as Accountability Infrastructure

Three PAC Accountability questions bear directly on incident response:

**A2: If an agent causes harm, is the liability chain clear?** The liability chain must be documented before the incident to be usable during one. This means: each agent has a registered owner, each delegation has a documented grant event, and each credential scope is recorded at issuance. Organizations that have not done this work before the first incident cannot do it under incident conditions.

**A4: Could you explain to a regulator what your agent did and why?** Post-incident regulatory reporting requires a coherent narrative: the agent was authorized by X to do Y within scope Z; the incident occurred when the agent acted on W, which exceeded Y; the governance gap was that Z did not explicitly exclude W. This narrative requires structured audit logs, not log aggregation.

**A5: When an agent makes a consequential decision, can you trace who authorized it and what happened?** The forensic minimum: every consequential action maps to an authorization event (who delegated what to whom), a credential (what token was used), and a reasoning trace (what the agent was responding to). Systems that can answer A5 under incident conditions are at I3 or above.

The Potential pillar determines blast radius: an agent with a narrow task scope (B1: contained) has less blast radius than one with broad system access (B4: regulated). Blast radius is not decided during incident response. It is decided during deployment — when the delegation scope is set.

The Control pillar determines what architecture enforced versus what policy only requested. Post-incident root cause analysis that identifies a policy gap leads to a policy update, which fails again at the next incident. Root cause that identifies an architectural gap — missing scope constraint, long-lived credential where ephemeral was needed, no delegation registry — leads to structural change.

## What to Do Now

1. **Audit your current agent logs.** For each production agent, determine whether its logs can answer: what authority did it have, what did it do, who or what received its outputs? If not, define the minimum required log structure before the next incident.

2. **Map the delegation chain for every production agent.** For each agent: who granted its authority, at what scope, for how long? If this cannot be answered from records — as opposed to inferred from configuration — the liability chain does not exist yet.

3. **Write one agent-specific IR playbook.** Do not start with a universal framework. Start with one production agent, one incident type (prompt injection or unauthorized action), and write the specific steps for that agent: how to assess blast radius, who to notify, how to contain, what the governance root cause analysis looks like. CoSAI's framework provides the structure; you provide the specifics.[^cosai-ir]

4. **Replace standing credentials with ephemeral ones on the highest-blast-radius agents.** The fastest way to reduce containment scope is to reduce credential lifetime. Agents operating with credentials scoped to specific tasks and short lifetimes have a bounded incident surface by design.

5. **Define what "coordinated revocation" means for your multi-agent setup.** If you run agents that hand off to other agents, write down how you would revoke across that chain: which systems to notify, in what order, and what downstream rollback looks like. This is the capability most organizations do not have but need before their first multi-agent incident.

---

[^replit-incident]: AI Incident Database, Incident 1152: "LLM-Driven Replit Agent Reportedly Executed Unauthorized Destructive Commands During Code Freeze, Leading to Loss of Production Data," documented 2025. incidentdatabase.ai/cite/1152.
[^operator-transaction]: AI Incident Database, Incident 1028: Operator agent processing an unauthorized $31.43 transaction, documented February 7, 2025. incidentdatabase.ai/cite/1028.
[^cosai-ir]: Coalition for Secure AI (CoSAI), "AI Incident Response Framework," OASIS Open Project, October 2025. Open-source at github.com/cosai-oasis/ws2-defenders. Announcement: coalitionforsecureai.org/defending-ai-systems-a-new-framework-for-incident-response-in-the-age-of-intelligent-technology.
[^owasp-ir-guide]: OWASP, "GenAI Incident Response Guide 1.0," mid-2025. genai.owasp.org/resource/genai-incident-response-guide-1-0. Companion: "OWASP Top 10 for Agentic Applications," December 9, 2025. genai.owasp.org/2025/12/09/owasp-top-10-for-agentic-applications.
[^nist-ir-8596]: NIST, "IR 8596: Cybersecurity Framework Profile for Artificial Intelligence (Cyber AI Profile)," preliminary draft, December 16, 2025. Public comment period closed January 30, 2026. nvlpubs.nist.gov/nistpubs/ir/2025/NIST.IR.8596.iprd.pdf.
[^msft-prompt-abuse]: Microsoft Security Blog, "Detecting and Analyzing Prompt Abuse in AI Tools," March 12, 2026. microsoft.com/en-us/security/blog/2026/03/12/detecting-analyzing-prompt-abuse-in-ai-tools.
[^secboulevard-forensics]: Security Boulevard, "Logging Chain-of-Thought for AI Agent Forensics," March 2026. securityboulevard.com/2026/03/logging-chain-of-thought-for-ai-agent-forensics.
[^finos-air-prev-023]: FINOS Air Governance Framework, "AIR-PREV-023: Agentic System Credential Protection Framework," 2026. air-governance-framework.finos.org/mitigations/air-prev-023_agentic-system-credential-protection-framework.html.
[^strata-analysis]: Strata Identity, "Why One Compromised Agent Can Take Down Everything You Built," 2026. strata.io/agentic-identity-sandbox/why-one-compromised-agent-can-take-down-everything-you-built.
[^csa-cross-domain]: Kundan Kolhe / Cloud Security Alliance, "AI Security: When Your Agent Crosses Multiple Independent Systems, Who Vouches for It?" March 11, 2026. cloudsecurityalliance.org/blog/2026/03/11/ai-security-when-your-agent-crosses-multiple-independent-systems-who-vouches-for-it.
[^owasp-agentic-top10]: OWASP, "Top 10 for Agentic Applications 2026," December 2025. genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026.
[^nist-caisi]: NIST, "Announcing the AI Agent Standards Initiative," February 2026. nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure. Concept paper: nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf.
[^pac-framework]: PAC Framework, trustedagentic.ai. Accountability pillar, liability chains dimension: "if the chain isn't mapped before the incident, it's too late to draw one after."
