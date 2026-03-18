---
title: SANDWORM_MODE
tags: [attack-pattern, supply-chain, mcp, typosquatting]
dimension: supply-chain
---

A supply chain attack targeting MCP server infrastructure through typosquatting npm packages. Documented in February 2026: 19 packages that steal credentials within seconds of installation, then harvest password managers, SSH keys, AWS credentials, and npm tokens.

## How it works

The attack does not require compromising the AI tool itself. It compromises the package the tool loads. A developer installing an MCP server dependency with a plausible but misspelled name gets a package that immediately exfiltrates credentials. The attack operates at installation time, before the tool even runs.

## Relationship to QUIETVAULT

[[quietvault]] uses an existing AI tool as the attack vector after compromise. SANDWORM_MODE compromises the tool's dependency tree directly. Both exploit the same structural gap: AI tool ecosystems inherit every supply chain vulnerability from their package registries, and the tools' broad system access amplifies the blast radius of each compromised dependency.

## Connects to

- [[quietvault]] — complementary attack vector: post-install tool exploitation vs. install-time credential theft
- [[supply-chain-security]] — typosquatting as a known attack pattern, now targeting AI infrastructure
- [[mcp]] — MCP server packages as the specific target
- [[infrastructure-levels]] — I1 organizations have no defense; package provenance verification is an I3+ capability

## Sources

- Research documentation, February 2026: 19 typosquatting npm packages targeting MCP server infrastructure
- src/chapters/supply-chain-security.md
- src/drafts/autonomous-security-agents.md
