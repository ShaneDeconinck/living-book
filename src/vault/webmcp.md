---
title: WebMCP (Web Model Context Protocol)
tags: [protocol, discovery, browser, agents]
---

A proposed web standard, jointly developed by Google and Microsoft through the W3C Web Machine Learning community group, that lets websites expose structured, callable tools directly to in-browser AI agents instead of relying on scraping or browser automation.

## How It Works

Two APIs:
- **Declarative**: standard actions defined in HTML forms, exposing form elements as structured tools without JavaScript
- **Imperative**: complex, dynamic interactions requiring JavaScript, giving websites fine-grained control over what agents can do

Shipped as an early preview in Chrome 146 Canary behind a feature flag. Transitioning from W3C community incubation to formal draft; browser announcements expected mid-to-late 2026.

## Security Properties

WebMCP tools execute in the page's JavaScript context, sandboxed by the browser's existing security model: same-origin policy, Content Security Policy, permission APIs. This is architecturally different from [[mcp]] servers, which can run with full system access.

The browser sandbox constrains what a WebMCP tool can do (no filesystem or arbitrary network access). It does not constrain what the tool tells the agent. [[mcp-tool-poisoning|Tool poisoning]] works the same way whether the tool runs in a browser tab or on a server. A malicious website could expose WebMCP tools designed to manipulate agent behavior rather than serve the user's intent.

## Relationship to MCP

Complementary, not competitive. WebMCP is not JSON-RPC. It does not follow the MCP specification. MCP operates as a backend protocol connecting AI platforms to hosted servers. WebMCP operates entirely client-side within the browser. A full agent stack would use both: MCP for services and APIs, WebMCP for web content and interactions.

If adopted broadly, WebMCP turns every website into a potential tool provider for agents, expanding the tool discovery surface. The governance question is the same one the agent communication chapter raises: discovery without trust is a liability.

## Connects to

- [[mcp]] — backend complement; WebMCP handles the browser layer
- [[mcp-tool-poisoning]] — tool description attacks apply equally to WebMCP tools
- [[a2a]] — agent-level discovery; WebMCP adds website-level tool discovery

## Sources

- Google and Microsoft, WebMCP specification, W3C Web Machine Learning community group, 2026
- src/chapters/agent-communication.md
