---
title: AI-Assisted Living Off the Land (AI LOTL)
tags: [threat, supply-chain, agents, attack-pattern]
---

An attack pattern where adversaries weaponize developers' existing AI coding tools for post-exploitation reconnaissance, treating AI agents as administrative tools equivalent to PowerShell or bash.

## The Pattern

Traditional Living Off the Land (LOTL) uses legitimate system tools (PowerShell, WMI, certutil) to avoid detection. AI LOTL extends this: malware invokes locally installed AI CLI tools (Claude Code, Gemini CLI, Amazon Q CLI) with natural-language prompts that instruct them to perform recursive filesystem searches for credentials, secrets, and configuration files.

The malware does not need to hardcode file paths or exfiltration endpoints. It issues prompts to an AI tool the developer is already running. The AI tool does the reconnaissance.

## QUIETVAULT Case Study

Google's Cloud Threat Horizons H1 2026 report documented the first case. Threat actor UNC6426 compromised the Nx npm build framework through a vulnerable GitHub Actions workflow, injecting QUIETVAULT: a JavaScript credential stealer. After conventional credential theft, QUIETVAULT detected locally installed AI CLI tools and invoked them for filesystem reconnaissance.

Full kill chain: npm package compromise -> QUIETVAULT credential stealer -> GitHub PAT theft -> OIDC trust chain abuse -> AWS IAM administrator role via CloudFormation -> full AWS admin access -> S3 exfiltration and production destruction. 72 hours from trojanized package to full cloud takeover.

## Broader Pattern

Google identified five AI-powered malware families deployed in the wild:
- **PROMPTFLUX** — rewrites its own source code hourly using Gemini to evade detection
- **PROMPTSTEAL** (APT28/GRU) — queries LLMs to generate credential-theft commands targeting Ukrainian systems
- **PROMPTLOCK** — ransomware using LLMs to dynamically generate malicious Lua scripts
- **FRUITSHELL** — includes hardcoded prompts to bypass LLM-powered security analysis
- **QUIETVAULT** — uses AI tools for filesystem reconnaissance

## Defense Implications

AI tools are simultaneously the asset to protect and the weapon being wielded. Organizations need to:
- Monitor AI tool activity on developer machines like administrative shells
- Apply [[sandboxing|structural containment]] that cannot be bypassed through natural-language instructions
- Treat AI CLI tools as high-privilege executables in endpoint security policies

## Connects to

- [[sandboxing]] — containment prevents AI tools from acting on malicious prompts
- [[skill-supply-chain]] — QUIETVAULT arrived through a compromised npm package
- [[prompt-injection]] — the malware uses prompt injection against local AI tools
- [[owasp-agentic-top10]] — ASI05 (Unexpected Code Execution) through AI tool weaponization

## Sources

- Google Cloud Security, "Cloud Threat Horizons Report H1 2026," March 2026
- Google Threat Intelligence Group, AI-powered malware family reports, 2025-2026
- src/chapters/supply-chain-security.md
