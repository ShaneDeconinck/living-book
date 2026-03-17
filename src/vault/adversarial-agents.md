---
title: Adversarial Agents
tags: [security, threat-actors, agentic-attacks, adversarial]
---

Threat actors deploying AI agents as attack infrastructure. The bilateral dimension of the agentic security problem: organizations are not only governing their own agents but defending against adversary-operated agents moving at machine speed.

## Why it changes the threat landscape

Human-speed operations have a bottleneck: every step — reconnaissance, phishing generation, credential testing, infrastructure rotation — requires human attention. Agents remove that bottleneck. Criminal forum discussions referencing AI spiked 1,500% between November and December 2025. [Flashpoint 2026]

Infostealers infected 11.1 million machines in 2025, producing 3.3 billion stolen credentials and cloud tokens. Paired with agentic frameworks, those credentials can be tested against thousands of endpoints simultaneously, at a speed that outpaces conventional detection.

## Three attack patterns from active operations

**Polymorphic phishing agents.** Embed in compromised inboxes, observe for weeks: studying historical threads, mapping approval hierarchies, learning internal slang. They insert themselves into existing high-trust threads rather than initiating new ones, matching the victim's working hours and typing rhythms. Traditional phishing detection looks for anomalous messages. These agents produce messages indistinguishable from legitimate ones because they learned what legitimate looks like from the inside. [Sardine 2026]

**Synthetic identity maturation agents.** Manage fabricated profiles through 6-to-18-month cultivation cycles: cycling micro-loans, automating monthly repayments, building credit scores past 800. The agent handles the tedious, long-duration work of making a fake identity look real. When activated for fraud, each identity has a verifiable history that passes standard underwriting checks. [Sardine 2026]

**Automated chain-hopping.** Orchestrates cross-chain money laundering by fragmenting stolen funds into tens of thousands of transactions under $10 each, moving assets through blockchains, privacy protocols, and bridges faster than any human analyst can follow. The agent turns money laundering from a skilled manual operation into a high-speed optimization problem. [Sardine 2026]

## AI-weaponized infrastructure

A distinct attack vector: adversaries do not build their own AI tools. They weaponize yours.

UNC6426 (Google H1 2026 threat report) compromised the Nx npm build framework and delivered QUIETVAULT, a credential stealer that detected locally installed AI CLI tools (Claude Code, Gemini CLI, Amazon Q Developer) and invoked them with natural-language prompts to perform filesystem reconnaissance. The AI tools did the attacker's reconnaissance work. Five AI-powered malware families in active deployment, including PROMPTSTEAL (used by Russia's APT28 against Ukrainian targets), which queries LLMs to generate credential-theft commands. [Google Cloud 2026]

## McKinsey Lilli incident (March 2026)

CodeWall deployed an autonomous red-teaming agent against McKinsey's Lilli internal AI platform. Starting from publicly exposed API documentation, the agent found 22 unauthenticated endpoints, identified SQL injection in JSON key concatenation, and achieved full read-write access to the production database within two hours. The vulnerability was decades old. The speed was new. [CodeWall 2026]

The deeper problem: Lilli accumulated 40,000+ employees' strategic reasoning, client data, and M&A discussions — 500,000+ prompts per month, stored in one concentrated target. Agent platforms are honeypots of organizational intelligence, and adversary agents can crack them at machine speed.

## Defensive response operating at the same speed

**OpenAI Codex Security** (March 2026): scanned 1.2 million commits across open-source repos during beta, identifying 792 critical and 10,561 high-severity vulnerabilities. Audit velocity no human security team can achieve.

**Kai** (emerged from stealth March 2026, $125M funding): agentic AI cybersecurity platform operating autonomously across threat intelligence, detection, and response.

The governance question shifts: not just "can we trust our agents?" but "can our defenses operate at the speed adversary agents now move?"

## Connects to

- [[owasp-agentic-top10]] — taxonomy of the attack surface adversarial agents exploit
- [[mitre-atlas]] — technique library for adversarial AI attack chains
- [[non-human-identity]] — over-privileged NHIs are the credential base adversarial agents exploit
- [[confused-deputy]] — adversarial agents weaponize misconfigured permissions
- [[shadow-agents]] — unregistered agents create unmonitored execution paths adversaries exploit
- [[tamper-evident-logging]] — the audit infrastructure needed to detect adversarial agent activity

## Sources

- [Flashpoint 2026]: Flashpoint, "2026 Global Threat Intelligence Report," flashpoint.io, March 12, 2026
- [Sardine 2026]: Sardine, "AI-driven fraud vectors: 7 agentic attacks now live in 2026," sardine.ai, March 2026
- [Google Cloud 2026]: Google Cloud Security, "Cloud Threat Horizons Report H1 2026," March 2026
- [CodeWall 2026]: CodeWall, "How We Hacked McKinsey's AI Platform," codewall.ai, March 2026
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#reliability-is-getting-easier-governance-is-not)
