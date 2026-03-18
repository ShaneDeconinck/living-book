---
title: AI Bill of Materials (AI-BOM)
tags: [supply-chain, accountability, governance]
dimension: supply-chain
---

A structured inventory of every component an agent depends on: models, tools, plugins, prompt templates, configuration files, APIs, and data sources. The AI analog of software SBOMs (Software Bill of Materials).

An agent is not a single piece of software. It is an assembly where each component is a link in a trust chain. Compromise any link, and the agent does exactly what it is told to do: the wrong thing, with the right credentials. A compromised agent skill runs code with autonomous decision-making authority and access to credentials, tools, and organizational context, amplifying traditional supply chain risks.

The AI-BOM extends SBOM practices to cover agent-specific components:
- **Model provenance:** Which model, which version, which fine-tune
- **Tool inventory:** MCP servers, plugins, skills, and their sources
- **Prompt templates:** System prompts, few-shot examples, configuration
- **Data dependencies:** RAG sources, knowledge bases, context pipelines
- **API connections:** External services the agent calls

The ClawHavoc campaign (February 2026) demonstrated why AI-BOMs matter: 1,184 confirmed malicious skills in the ClawHub marketplace, with 335 traced to a single coordinated campaign. [[sigstore-a2a]] and [[skill-ids]] provide the provenance verification layer. The AI-BOM provides the inventory that makes verification possible.

Connects to: [[skill-supply-chain]], [[sigstore-a2a]], [[skill-ids]], [[accountability-pillar]]
