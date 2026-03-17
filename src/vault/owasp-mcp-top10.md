---
title: OWASP MCP Top 10
tags: [security, mcp, owasp, framework]
---

A dedicated security risk framework for Model Context Protocol deployments, distinct from the [[owasp-agentic-top10]] which addresses agent-level risks.

Launched by OWASP in 2026, the MCP Top 10 focuses on protocol-level risks in the MCP lifecycle. Where the Agentic Applications list covers agent behavior (goal hijacking, memory poisoning), the MCP Top 10 covers the communication and tooling layer:

- **Token mismanagement and secret exposure**: hard-coded credentials, long-lived tokens, secrets persisted in model memory or protocol logs.
- **Context over-sharing**: insufficiently scoped context windows leaking information across tasks, users, or agents.
- **Prompt injection and command injection**: agents constructing system commands from untrusted input. 43% of MCP CVEs (January-February 2026) were exec()/shell injection.
- **Software supply chain attacks**: compromised packages, connectors, and plugins (see [[skill-supply-chain]]).
- **Insufficient authentication and authorization**: 38% of 560 scanned MCP servers accept connections without any authentication.
- **Excessive permission scope**: MCP servers routinely declare broader capabilities than any single operation requires, expanding [[blast-radius]] of any successful [[mcp-tool-poisoning]] attack.

Provides a shared vocabulary for procurement, vendor assessment, and compliance documentation.

Related: [[mcp]], [[mcp-gateway]], [[owasp-agentic-top10]], [[description-pinning]]
