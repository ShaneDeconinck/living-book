---
title: MITRE ATLAS
tags: [security, taxonomy, mitre, attack-techniques, adversarial]
dimension: standards
---

MITRE ATLAS (Adversarial Threat Landscape for AI Systems) extends the ATT&CK framework to AI and machine learning systems. Where [[owasp-agentic-top10]] organizes by risk category, ATLAS organizes by adversary technique: how attackers actually execute attacks against AI systems.

## Scale

As of the first 2026 release: 15 tactics, 66+ techniques, 46+ sub-techniques. Zenity Labs contributed 14 new agent-specific techniques and sub-techniques in January 2026, after announcing them in October 2025. [Zenity 2026]

## Three agent-specific techniques (absent from traditional security frameworks)

**AI Agent Clickbait (AML.T0100).** Content crafted to manipulate agent decision-making, not human judgment. Agents browsing the web, reading documents, and interacting with UIs can be steered toward attacker-controlled outcomes by content that appears task-aligned. As agentic browsers become embedded in enterprise copilots, this attack surface grows. [[intent-expansion]] explains why agents are structurally vulnerable: they do not distinguish data from instructions.

**AI Agent Context Poisoning (AML.T0080).** Adversaries manipulate the context an agent's LLM operates in to persistently influence responses and actions. This is the same mechanism Microsoft documented as AI Recommendation Poisoning: 31 companies across 14 industries embedding hidden instructions to bias agent memory and recommendations. Maps to ASI06/ASI07 in [[owasp-agentic-top10]].

**Exfiltration via AI Agent Tool Invocation.** The agent's own tools become the exfiltration channel. An attacker achieving [[prompt-injection]] does not need a C2 channel: they instruct the agent to use its legitimate write tools (send email, update CRM, post to Slack) with sensitive data encoded in the parameters. The data leaves through authorized channels that security tooling is designed to trust.

## OpenClaw investigation (February 2026)

MITRE published a detailed investigation mapping four confirmed OpenClaw attack cases to ATLAS techniques. Seven new techniques unique to the OpenClaw ecosystem were identified, all assessed as mature and in active use. One attack chain: a poisoned Skill shared on ClawHub achieved 4,000+ downloads in an hour using a malicious prompt hidden in the payload. [MITRE 2026]

This illustrates the defining characteristic of agentic attacks: the distinction between code exploitation and context exploitation. The attack asked the system to betray itself.

## How OWASP and ATLAS complement each other

OWASP Agentic Top 10 tells you which risk categories to prioritize. ATLAS tells you the specific adversary techniques within each category and how they chain together. [[pac-framework]] tells you what infrastructure prevents them.

For incident response: ATLAS provides the technique vocabulary for post-incident reconstruction — essential when an agent's behavior can only be understood by tracing which technique class was used.

## Connects to

- [[owasp-agentic-top10]] — the risk taxonomy ATLAS complements
- [[prompt-injection]] — primary technique for ASI01 and Context Poisoning
- [[intent-expansion]] — why agents are structurally susceptible to Clickbait
- [[mcp-tool-poisoning]] — supply chain variant of Exfiltration via Tool Invocation
- [[tamper-evident-logging]] — the audit infrastructure needed to reconstruct ATLAS technique chains

## Sources

- [Zenity 2026]: Zenity Labs, "Zenity's contributions to MITRE ATLAS's first 2026 release," zenity.io, January 2026
- [MITRE 2026]: MITRE, "ATLAS OpenClaw Investigation," mitre.org, February 9, 2026. Center for Threat-Informed Defense.
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#mitre-atlas-the-attack-technique-library)
