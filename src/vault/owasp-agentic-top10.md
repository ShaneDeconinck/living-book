---
title: OWASP Top 10 for Agentic Applications
tags: [security, taxonomy, owasp, risk]
dimension: standards
---

A peer-reviewed framework identifying the ten most critical security risks for autonomous AI systems. Published December 2025 by OWASP with input from over 100 security researchers and practitioners. [OWASP 2025]

## The ten risks

| ID | Name | Description |
|---|---|---|
| ASI01 | Agent Goal Hijack | Attackers modify agent objectives through malicious content in emails, documents, or web pages. Agents cannot reliably separate instructions from data. |
| ASI02 | Tool Misuse | Agents misuse legitimate tools due to ambiguous prompts, misaligned behavior, or poisoned input. |
| ASI03 | Identity and Privilege Abuse | Agents inherit user credentials and high-privilege access that are unintentionally reused, escalated, or passed across agents. Maps to the [[confused-deputy]] problem. |
| ASI04 | Supply Chain Vulnerabilities | Compromised tools, plugins, prompt templates, MCP servers, or other agents alter behavior or expose data. |
| ASI05 | Unexpected Code Execution | Agents generate or execute untrusted code, shell commands, or scripts triggered through generated output. |
| ASI06 | Memory and Context Poisoning | Attackers poison agent memory systems, embeddings, or RAG databases to influence future decisions. |
| ASI07 | Insecure Inter-Agent Communication | Multi-agent message exchanges lack authentication, encryption, or semantic validation. |
| ASI08 | Cascading Failures | Errors in one agent propagate across planning, execution, and downstream systems. |
| ASI09 | Human-Agent Trust Exploitation | Users over-trust agent recommendations, leading to unsafe approvals or exposures. The [[complacency-trap]] classified as a security risk. |
| ASI10 | Rogue Agents | Compromised or misaligned agents act harmfully while appearing legitimate. |

## Coverage by defense layer

**[[sandboxing]] covers ASI02, ASI03, ASI04, ASI05, ASI10** (strong), and **ASI01, ASI08** (partial). Execution-layer containment limits blast radius but cannot prevent goal hijack or cascading failures structurally.

**Not addressed by sandboxing:**
- ASI06 (Memory/Context Poisoning): model-level problem; requires context validation infrastructure
- ASI07 (Insecure Inter-Agent Communication): protocol-level problem; requires authentication and semantic validation at the message layer. See agent-communication.md
- ASI09 (Human-Agent Trust Exploitation): organizational and design problem; requires UX friction and mandatory oversight checkpoints

## PAC mapping

- **Potential**: ASI09 (complacency erodes human oversight capacity over time)
- **Accountability**: ASI01, ASI03, ASI08 (hijacked/escalated/cascading agents break audit trails)
- **Control**: ASI02, ASI04, ASI05, ASI06, ASI07, ASI10 (primary domain)

## Connects to

- [[confused-deputy]] — structural cause behind ASI03
- [[complacency-trap]] — same phenomenon as ASI09
- [[sandboxing]] — covers 5/10 risks directly
- [[prompt-injection]] — the dominant attack technique for ASI01, ASI02
- [[trust-inversion]] — the architectural response to ASI03
- [[delegation-chain]] — the authorization response to ASI03 and ASI08

## Sources

- [OWASP 2025]: OWASP, "Top 10 for Agentic Applications for 2026," genai.owasp.org, December 2025
- Chapter: [Sandboxing and Execution Security](../chapters/execution-security.md#the-owasp-top-10-for-agentic-applications)
