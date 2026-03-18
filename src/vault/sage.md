---
title: Sage (Gen Digital)
tags: [tool, aarts, runtime, supply-chain, security]
dimension: supply-chain
---

Gen Digital's open-source reference implementation of [[aarts]], providing 200+ detection rules across four threat categories: supply chain attacks, credential exposure, dangerous commands, and persistence mechanisms.

## How it works

Sage integrates Gen's threat intelligence: detection rules are updated as new attacks are documented. When SANDWORM_MODE's 19 typosquatting npm packages targeting MCP server infrastructure were identified, they became detection signatures every Sage user benefits from automatically.

This is the key architectural advantage: **security engine as shared infrastructure, not per-tool reimplementation**. One organization's observed attack becomes every compliant deployment's protection.

## Four detection categories

**Supply chain attacks** — typosquatting, compromised packages. The PreSkillLoad/PrePluginLoad hooks in AARTS intercept these before they enter the agent environment.

**Credential exposure** — reads from credential paths (e.g., AWS credentials from environment variables). Addresses the class of incident where an agent with production credentials causes production damage.

**Dangerous commands** — destructive shell commands, privilege escalation patterns. Catches the reformulation attacks that denylist-based `check_safe()` methods miss.

**Persistence mechanisms** — cron modifications, shell config writes. Detection for attacks attempting to survive agent session restarts.

## Shared threat intelligence model

Sage's architecture separates threat intelligence (Gen's maintained rule set) from enforcement (the agent host deploying it). This enables:
- Rules updated centrally without agent host changes
- Host-agnostic deployment: any AARTS-compliant host can use Sage
- Cumulative coverage: new attack patterns discovered anywhere in Gen's visibility become universally available protections

This is the same model that makes cloud-based antivirus effective at scale: a single observed attack becomes a global signature.

## Vercel partnership

The Vercel partnership (February 2026) extends safety verification to the distribution layer: Vercel's AI skills ecosystem evaluates skills through Gen's Agent Trust Hub before they reach agent hosts. This is supply chain verification at distribution time rather than execution time — raising the bar upstream of deployment.

## Connects to

- [[aarts]] — Sage implements the AARTS standard; it is the reference security engine
- [[skill-supply-chain]] — the supply chain attack category Sage's PreSkillLoad rules address
- [[skill-ids]] — complementary mechanism: Sage detects known-bad patterns; Skill IDs verify known-good content
- [[mcp-tool-poisoning]] — Sage's dangerous command rules cover the execution side of MCP poisoning attacks
- [[containment-by-design]] — Sage is the policy enforcement layer; containment-by-design is the structural layer underneath

## Sources

- [Gen-Sage 2026]: Gen Digital, "Introducing Sage: Safety for Agents," gendigital.com, March 2026. 200+ detection rules, open-source.
- [HelpNet 2026]: Help Net Security, "Open-source tool Sage puts a security layer between AI agents and the OS," March 9, 2026
- Chapter: [Agent Runtime Safety Standards](../chapters/agent-runtime-safety-standards.md)
