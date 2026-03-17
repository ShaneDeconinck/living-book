---
title: Model Context Protocol (MCP)
tags: [protocol, tools, infrastructure]
---

An open standard protocol for connecting AI agents to tools and data sources via a JSON-RPC interface.

MCP defines three primitives: **tools** (callable functions with typed inputs/outputs), **resources** (data the agent can read), and **prompts** (reusable interaction templates). It standardizes what was previously a mess of custom integrations. Every AI platform now supports MCP. The authorization gap: MCP authenticates users but not servers. A client connecting to an MCP server cannot verify the server's identity or confirm it actually has claimed capabilities. This gap is addressed by [[mcp-i]] (identity layer), [[mcp-gateway]] (enforcement layer), and [[tmcp]] (TSP transport). The [[mcp-tool-poisoning]] threat exploits MCP's trust model: tool descriptions are behavioral instructions to the LLM, not documentation.
