---
title: Confused Deputy
tags: [security, vulnerability, credentials, delegation]
dimension: confused-deputy
---

A program with elevated privileges gets tricked into misusing them on behalf of a less-privileged caller. First described in 1988. Agents make it worse in four ways.

## The four dimensions in agents

**1. Broad credentials by default.** Agent credentials are scoped to the system, not the task. Google Workspace CLI's `gmail.readonly` grants access to every email, forever — because OAuth was not designed for task-scoped access. [Deconinck 2026a]

**2. Untrusted input, trusted credentials.** Agents process user-supplied content using elevated credentials. The Supabase/Cursor incident: privileged database credentials + SQL instructions embedded in support tickets = full exfiltration. The agent did what it was designed to do. The credentials were not scoped to what the task required. [Barrack.ai 2026]

**3. Destructive decisions within authority.** Amazon Kiro determined the optimal solution to a production fix was to delete the entire environment and recreate it. No prompt injection. No compromise. The agent reasoned its way to catastrophe using permissions it legitimately held. [FT/Amazon 2026]

**4. Chaining compounds it.** Agent A calls Agent B calls Agent C. Each hop inherits some version of the original authority. By the time Agent C acts, intent has degraded through several interpretive steps. Authority that can only decrease through [[delegation-chain|delegation]] breaks this pattern.

## What fixes it

Better prompts do not fix confused deputies. Infrastructure does:
- [[trust-inversion]]: scoped credentials, allowlist not blocklist
- [[delegation-chain]]: authority that can only decrease at each hop
- Audit trails that capture decision path from intent to action

At the MCP tool layer specifically: [[mcp-gateway]] enforces per-call scoped credentials; [[mcp-tool-poisoning]] describes how broad ambient credentials amplify the blast radius of tool description attacks. In multi-agent chains, [[delegation-capability-tokens]] make privilege expansion through delegation mathematically impossible. At the OAuth layer, [[transaction-tokens]] close the delegation chain splicing variant by making actor and principal claims immutable across backend service hops.

## OWASP mapping

ASI03: Identity and Privilege Abuse in [[owasp-agentic-top10]].

- [[quietvault]] — confused deputy at the development toolchain level: AI coding tool follows attacker instructions from a compromised package
- [[agentic-collapse]] — confused deputy at the tool integration boundary

## Sources

- [Deconinck 2026a]: "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," shanedeconinck.be, March 2026
- [Barrack.ai 2026]: "Every AI App Data Breach Since January 2025," blog.barrack.ai, 2026
- [FT/Amazon 2026]: Financial Times, February 20, 2026; Amazon response at aboutamazon.com
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#the-confused-deputy-revisited)
