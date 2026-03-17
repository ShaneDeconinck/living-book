---
title: Agent Supply Chain
tags: [supply-chain, security, control]
---

The unique attack surface where compromised agent components (skills, plugins, MCP servers) inherit the agent's autonomous decision-making authority and credential access.

Traditional software supply chain attacks compromise libraries that execute deterministic code. Agent supply chain attacks are worse: a compromised skill gains access to the LLM's reasoning loop, can influence decisions about other tools, and may hold delegated credentials. The OpenClaw scenario illustrates this — a typosquatted MCP server that exfiltrates data through the agent's normal tool-calling behavior. Defenses include [[sbom-for-agents]] (inventorying model version, tools, prompt templates, MCP servers with provenance), [[skill-id-content-addressability]] (cryptographic fingerprints for skill integrity), and Sigstore-style transparency logs for agent components.
