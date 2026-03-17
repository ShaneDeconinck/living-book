---
title: QUIETVAULT
tags: [attack-pattern, supply-chain, ai-tools, confused-deputy]
---

A supply chain attack documented by Google Threat Intelligence Group in which a trojanized npm package repurposes the developer's own AI coding tool as a reconnaissance agent. The attacker issues natural-language prompts for filesystem searching. The tool executes them because it has filesystem access and is designed to follow natural-language instructions.

## Why it matters

The AI tool is not compromised. It is doing exactly what it was built to do. The attacker is issuing instructions through a compromised package rather than directly. This is the [[confused-deputy]] applied to the development toolchain: the tool cannot distinguish between instructions from the developer and instructions injected through a compromised dependency.

Five AI-powered malware families are now operational in the wild. The shift is categorical: from attacks *on* AI tools, to attacks *by* adversary-built AI, to attacks *through* existing AI tools that the target has already deployed and trusted.

## Infrastructure implications

QUIETVAULT does not require deploying a malicious agent. It requires only that the organization's existing AI coding tool has filesystem access and follows natural-language instructions from any source. Organizations at [[infrastructure-levels|I1]] have maximum exposure. At I3+, instruction source verification closes the gap.

## Connects to

- [[confused-deputy]] — QUIETVAULT is the confused deputy at the tool level
- [[sandworm-mode]] — similar attack vector at the MCP package registry level
- [[supply-chain-security]] — trojanized packages as the delivery mechanism
- [[infrastructure-levels]] — I1/I2 organizations are fully exposed; I3+ contains the threat
- [[agentic-collapse]] — same structural pattern: legitimate access, wrong principal

## Sources

- Google Threat Intelligence Group, QUIETVAULT documentation, 2026
- src/drafts/autonomous-security-agents.md
