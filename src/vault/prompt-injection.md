---
title: Prompt Injection
tags: [security, attack, vulnerability, agents]
---

An attack where adversaries embed malicious instructions in content an agent is designed to read, causing it to execute commands the user never authorized.

## How it works

Agents process untrusted external content (web pages, emails, documents, repository issues) using trusted execution context. When that content contains embedded instructions, the agent interprets them as task-relevant — because agents lack the skepticism and situational awareness to distinguish attacker-planted commands from legitimate content.

**Perplexity Comet (August 2025):** Attackers embedded commands in Reddit comment sections. User activated "summarize page." Agent executed attacker commands instead. [Adversa AI 2026]

**PleaseFix (March 2026):** 0-click variant. Calendar invite → file exfiltration from local filesystem. Second path: credential theft from password managers. No user interaction required. Social engineering adapted for agents: humans needed to click; agents don't. [Zenity Labs 2026]

**GitHub MCP (May 2025):** Malicious instructions embedded in GitHub Issues. MCP-connected agent processed them, exfiltrating source code and cryptographic keys. Developer never saw the instructions. [Security researchers 2025]

## Why 0-click matters

ClickFix was social engineering requiring a human to click. PleaseFix is the same technique without the click. The attack surface shifted from human judgment to agent instruction-following. More capable models are often *more* susceptible because the attack exploits superior instruction-following. [MCPTox benchmark: o1-mini achieved 72.8% attack success rate against real-world MCP servers]

## ATLAS mapping

MITRE ATLAS codifies this as **AI Agent Goal Hijack**. [[mitre-atlas]] tracks the adversary technique. [[owasp-agentic-top10]] ASI01 is the risk category.

## Structural defense

Prompt injection cannot be fully solved at the model layer. Structural defenses:
- Sandbox execution environments ([[sandboxing]])
- Tool call inspection and gating via [[mcp-gateway]]
- Context isolation between trusted and untrusted sources
- [[description-pinning]] prevents post-installation description modification

[[mcp-tool-poisoning]] is the tool-layer variant: the injection is embedded in the MCP tool description field, not in external content the agent reads at runtime.

## Appears in

- **Your Coding Agent Needs a Sandbox** (`posts/docker-sandbox-coding-agents`, 2026-02-07) — sandboxing limits prompt injection blast radius; containment is the defense
- **Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First.** (`posts/google-workspace-cli-agent-first-oauth-app-first`, 2026-03-05) — ASI01 injection via incoming email; prompt injection as OWASP risk
- **OpenClaw and Moltbook** (`posts/openclaw-moltbook-trust-fear-ai`, 2026-02-17) — injection discussed in Lex Fridman / Steinberger conversation
- **Verifiable Intent: Mastercard and Google Open-Source Agent Authorization** (`posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved`, 2026-03-06) — agent compromise via injection can still satisfy VI constraints within bounds

## Sources

- [Adversa AI 2026]: "2025 AI Security Incidents Report," 2026
- [Zenity Labs 2026]: "PleaseFix Vulnerability Family," March 3, 2026
- MCPTox: arXiv:2508.14925, 2025
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#what-changed)
