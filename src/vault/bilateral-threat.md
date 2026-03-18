---
title: Bilateral Threat
tags: [threat, adversarial, governance, introduction]
dimension: governance-thresholds
---

The compound governance challenge where organizations must simultaneously defend against adversarial AI agents while deploying and governing their own agents.

Traditional cybersecurity framing is one-directional: you build defenses against external attackers. The agent era makes this bilateral: your own agents are an attack surface (misconfigured, over-permissioned, prompt-injectable), and adversaries are deploying agents of their own to attack you.

## The adversarial side

Flashpoint's 2026 Global Threat Intelligence Report documents autonomous agentic attack chains: reconnaissance, phishing generation, credential testing, and infrastructure rotation — all without human bottlenecks. Criminal forum discussions referencing AI spiked 1,500% between November and December 2025. Sardine's research identifies seven live agentic attack types:
- **Polymorphic phishing agents** that study internal communication patterns for weeks before inserting themselves into high-trust threads
- **Synthetic identity maturation agents** cultivating fabricated profiles over 18-month cycles
- **Automated chain-hopping** fragmenting stolen funds across tens of thousands of sub-$10 transactions across blockchains

Google's Cloud Threat Horizons Report added an unexpected dimension: adversaries weaponizing developers' own AI tools. Threat actor UNC6426 compromised an npm build framework and delivered malware that detected locally installed AI command-line tools, then invoked them with natural-language prompts to perform filesystem reconnaissance for credentials. The AI tool did the attacker's work.

## Why bilateral changes governance

The pattern: agents remove the human bottleneck from attack operations. The time between vulnerability disclosure and weaponized exploit is shrinking toward zero.

One-sided defenses are insufficient when both sides operate at machine speed. The governance infrastructure required is the same for both problems: [[agent-identity]] to distinguish legitimate from adversarial agents, [[execution-security]] to constrain what any agent can do regardless of instruction, [[agent-observability]] to detect anomalous patterns before they compound, and [[blast-radius]] assessment to contain damage when either a defensive agent fails or an offensive agent succeeds.

## Connects to

- [[agent-incident-response]] — adversarial agents require response procedures designed for machine-speed attacks
- [[prompt-injection]] — the mechanism adversarial agents use to compromise defensive ones
- [[shadow-agents]] — adversarial agents exploit the same governance gaps shadow agents create
- [[supply-chain-security]] — compromising the tools developers trust is the lateral entry point adversaries exploit
- [[inferential-edge]] — the organizations building defensive infrastructure fastest are also hardening against the adversarial side

## Sources

- [Flashpoint 2026]: Flashpoint, "2026 Global Threat Intelligence Report," flashpoint.io, March 2026
- [Sardine 2026]: Sardine, "AI-driven fraud vectors: 7 agentic attacks now live in 2026," sardine.ai, 2026
- [Google 2026]: Google Cloud Security, "Cloud Threat Horizons Report H1 2026," March 2026
- Chapter: [Introduction](../chapters/introduction.md)
