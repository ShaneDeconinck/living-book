---
title: WebMCP (Web Model Context Protocol)
tags: [protocol, browser, tools, infrastructure, security]
dimension: standards
---

A proposed W3C web standard that lets websites expose structured, callable tools directly to in-browser AI agents — instead of agents scraping pages or simulating clicks through browser automation. Developed jointly by Google and Microsoft, incubated through the W3C Web Machine Learning community group. Available in Chrome 146 Canary behind a feature flag as of early 2026.

## The problem it solves

Agents interacting with web content today either scrape HTML (fragile, lossy) or drive a browser through automation APIs like Playwright (brittle, slow, permissioned as the full browser). Neither approach gives the agent a structured, semantically correct view of what a page can do.

WebMCP turns pages into tool providers: an e-commerce site can expose a structured "add to cart" tool rather than a button the agent has to find and click. A documentation site can expose a "search" tool with defined parameters instead of a form the agent must parse.

## Two APIs

**Declarative**: standard actions defined via HTML forms. Existing form elements become structured tools without JavaScript. Low barrier to adoption for static sites.

**Imperative**: complex, dynamic interactions implemented in JavaScript. Fine-grained control over what agents can do. Required for stateful or multi-step interactions that forms cannot express.

## Trust model: distinct from server-side MCP

WebMCP tools execute in the page's JavaScript context, sandboxed by the browser's existing security model: same-origin policy, Content Security Policy, permission APIs.

This creates a different trust geometry than [[mcp]] servers:

**Containment by architecture**: browser-sandboxed tools cannot access the filesystem, arbitrary network resources, or other browser tabs (without explicit permissions). Server-side MCP has no equivalent built-in containment. The browser provides the boundary; developers do not have to build it.

**Poisoning risk remains unchanged**: the browser sandbox constrains *what a tool can do*, not *what a tool can tell the agent*. Tool descriptions that manipulate agent reasoning — the core [[mcp-tool-poisoning]] attack — work the same way whether the tool runs in a browser tab or on a server. A malicious website can expose WebMCP tools designed to manipulate behavior rather than serve intent.

**Origin-based trust instead of OAuth**: WebMCP inherits the browser's origin model. There is no OAuth 2.1 authorization server, no credential mediation, no token scope. Trust decisions are based on origin and browser permissions — a weaker authorization model than server-side MCP's OAuth requirements, but one that comes with structural containment the OAuth model lacks.

## Relationship to MCP

WebMCP and MCP are complementary, not competitive:

| | MCP | WebMCP |
|---|---|---|
| Scope | Backend services and APIs | Web content and browser interactions |
| Transport | JSON-RPC over stdio or HTTP | Browser API |
| Auth | OAuth 2.1 (required for remote) | Origin/browser permissions |
| Containment | None built-in | Browser sandbox |
| Poisoning risk | Yes | Yes |

A full agent stack uses both: MCP for connecting to external services, WebMCP for interacting with websites. The protocols address different parts of the tool discovery surface.

## Governance implications

WebMCP's adoption would turn every website into a potential tool provider for agents. Scale of discoverability matters: more providers means more surface for malicious tool descriptions, more opportunity for typosquatting (a site that looks like a legitimate tool provider), and more demand for the kind of naming-layer governance [[agentdns]] proposes.

Discovery without trust is still the structural problem. WebMCP tells an agent what tools a page offers. It does not tell the agent whether to trust the page offering them.

## Status

Transitioning from W3C community incubation to formal draft. Formal browser announcements expected by mid-to-late 2026. Not yet a ratified standard as of March 2026.

## Connects to

- [[mcp]] — complementary: backend protocol for services, WebMCP for web content
- [[mcp-tool-poisoning]] — poisoning attacks apply equally to WebMCP tool descriptions
- [[agentdns]] — naming-layer governance becomes more important as WebMCP expands the tool provider surface
- [[sandboxing]] — browser sandbox provides the containment that server-side MCP lacks
- [[consent-theater]] — WebMCP inherits the authorization gap: origin-based trust, no fine-grained intent encoding

## Appears in

- Chapter: [Agent Communication Protocols](../chapters/agent-communication.md)

## Sources

- Google Chrome Developers, "WebMCP is available for early preview," developer.chrome.com/blog/webmcp-epp, 2026
- VentureBeat, "Google Chrome ships WebMCP in early preview," March 2026
