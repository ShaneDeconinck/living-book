# Agent Communication Protocols

Communication protocols are the plumbing of the agent ecosystem. They determine how agents discover tools, talk to other agents, and traverse organizational boundaries. Get the plumbing right, and agents can compose into systems that create value no single agent could deliver. Get it wrong, and every integration is bespoke, every boundary a wall, every tool connection a security risk.

This chapter covers the protocol landscape as it stands in early 2026: MCP for connecting agents to tools, A2A for connecting agents to agents, AgentGateway for policy enforcement, the trust layer integrations that add verifiable identity, and the governance structures that determine whether any of this converges or fragments.

The critical insight, and the one Shane has been making since his first explainers on these protocols: **communication protocols solve discovery, not trust**.[^1] MCP tells an agent what tools exist. A2A tells an agent what other agents can do. Neither tells the agent whether to trust what it finds. That gap is where the rest of this book's infrastructure: identity, delegation, authority, and governance: becomes load-bearing.

## The Discovery Problem

Before MCP, connecting an agent to a tool meant writing custom integration code. Every agent framework had its own way of calling APIs, parsing responses, and managing credentials. If you had N agents and M tools, you needed N×M integrations. This is the same problem that HTTP solved for web pages and REST solved for APIs: without a standard protocol, the integration cost scales multiplicatively.

The discovery problem has two layers:

**Tool discovery**: how does an agent learn what tools are available, what they do, and how to call them? Before standardization, this lived in framework-specific configurations, hardcoded function definitions, or natural language descriptions stuffed into system prompts.

**Agent discovery**: how does one agent find another agent that can help with a task? This is harder than tool discovery because agents have capabilities that evolve, availability that changes, and trust requirements that vary by context.

MCP addresses the first. A2A addresses the second. Together, they form the communication layer of the agent stack. But communication without authorization is how you get breaches, and the protocol landscape in 2025 provided ample evidence of this.

## MCP: Connecting Agents to Tools

The Model Context Protocol, released by Anthropic in November 2024, standardizes how AI agents connect to external tools, data sources, and services.[^2] Shane's framing is precise: "MCP is plumbing, not trust."[^1]

### Architecture

MCP uses a client-server architecture with three roles:

- **Host**: the application the user interacts with (an IDE, a chat interface, a coding agent)
- **Client**: maintains a 1:1 connection with a single MCP server, running inside the host
- **Server**: exposes capabilities to clients through the protocol

Servers expose three types of capabilities:

1. **Resources**: data the agent can read (files, database records, API responses). Read-only context.
2. **Tools**: functions the agent can invoke (send email, create ticket, search contacts). Actions with side effects.
3. **Prompts**: pre-defined templates and workflows that structure agent behavior.

The protocol uses JSON-RPC 2.0 for message exchange. A typical tool call looks like this:

```json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "crm_search_contacts",
    "arguments": {
      "query": "john@acme.com",
      "limit": 5
    }
  },
  "id": 1
}
```

The server responds with structured content:

```json
{
  "jsonrpc": "2.0",
  "result": {
    "content": [{
      "type": "text",
      "text": "Found 1 contact: John Smith (john@acme.com)"
    }]
  },
  "id": 1
}
```

This is deliberately simple. The protocol handles capability declaration, tool invocation, and result formatting. It does not handle authorization decisions, identity verification, or delegation tracking. Those are separate concerns, and that separation is by design.

### Transport

MCP supports two transport mechanisms:

| Transport | Use Case | Auth Model |
|-----------|----------|------------|
| **stdio** | Local, subprocess | Inherits host environment |
| **HTTP + SSE** | Remote services | OAuth 2.1 |

The stdio transport is how most developers encounter MCP today: a local process that the host spawns and communicates with over standard input/output. It inherits whatever credentials the host process has. This is simple but has a consequence Shane identified in his Google Workspace CLI analysis: "The agent simply inherits whatever credentials the host process has."[^3] There is no network boundary to enforce policy at.

The HTTP transport enables remote MCP servers, which is where production deployments live. The 2025-11-25 specification requires OAuth 2.1 with PKCE (S256 mandatory), RFC 9728 for Protected Resource Metadata, and RFC 8707 for Resource Indicators.[^4] Remote servers expose a `.well-known/oauth-protected-resource` endpoint for authorization server discovery.

### The 2026 Roadmap

Running MCP at scale has surfaced gaps. Stateful sessions conflict with load balancers. Horizontal scaling requires workarounds. There is no standard way for a registry or crawler to discover what a server does without connecting to it.[^5]

The 2026 roadmap, announced March 9, 2026, identifies four priority areas where Spec Enhancement Proposals (SEPs) receive expedited review:[^5]

1. **Streamable HTTP transport improvements**: making MCP servers viable as remote services at scale by resolving conflicts between stateful sessions, load balancers, and horizontal scaling.
2. **Server discovery via `.well-known`**: MCP Server Cards, a standardized metadata format served at `.well-known/mcp.json`, would let browsers, crawlers, and registries discover server capabilities, available transports, authentication requirements, and protocol versions without establishing a connection.[^6]
3. **Tasks primitive refinements**: improving retry semantics and expiry policies based on early production use of long-running operations.
4. **Enterprise deployment needs**: audit trails, SSO-integrated auth, gateway behavior, and configuration portability for production environments.

These are infrastructure maturity improvements. They move MCP from "works in development" to "works in production at scale." The specification updates are targeted for the next release, tentatively slated for June 2026.[^5]

### Adoption

The adoption numbers are striking. By February 2026, MCP crossed 97 million monthly SDK downloads (Python and TypeScript combined).[^7] Every major AI provider has adopted it: Anthropic, OpenAI, Google, Microsoft, and Amazon. This is not a protocol war. MCP won the tool-connection layer.

### Security: MCP Is Plumbing, Not Trust

The adoption speed has outpaced security maturity. A timeline of MCP security incidents illustrates the pattern:[^8]

| Date | Incident | Impact |
|------|----------|--------|
| April 2025 | WhatsApp MCP exfiltration | Tool poisoning: malicious server silently exfiltrated entire WhatsApp history via legitimate whatsapp-mcp[^24] |
| May 2025 | GitHub MCP prompt injection | Private repos, salary data leaked to public PR via overprivileged PAT |
| June 2025 | Asana MCP data exposure | Cross-organization data leak: one org's data visible to other orgs due to access control flaw[^25] |
| July 2025 | mcp-remote CVE-2025-6514 | Command injection in OAuth proxy, 437k+ downloads, supply-chain backdoor |
| July 2025 | MCP Inspector CVE-2025-49596 | Unauthenticated RCE in Anthropic's official developer tool, CVSS 9.4[^26] |
| August 2025 | Anthropic Filesystem MCP | Sandbox escape, symlink bypass enabling arbitrary file access |
| September 2025 | Fake Postmark MCP package | Supply-chain attack, BCC'd all emails to attacker |
| October 2025 | Smithery path traversal | Leaked Fly.io token controlling 3,000+ MCP servers |
| January 2026 | mcp-atlassian CVE-2026-27825 | Path traversal enabling arbitrary file write and RCE via Confluence attachments[^27] |
| March 2026 | WeKnora CVE-2026-30861 | Command injection in MCP stdio configuration validation[^28] |
| March 2026 | Azure MCP Server CVE-2026-26118 | SSRF enabling managed identity token theft and privilege escalation, CVSS 8.8[^29] |

Eleven incidents in twelve months, and the pace is accelerating. The Azure MCP vulnerability is notable: Microsoft's own first-party MCP server implementation had a critical SSRF that could steal the server's managed identity token, giving an attacker whatever permissions the MCP server held in the Azure environment. Patched on March 10, 2026. These are not edge cases. They represent the three primary attack vectors that MCP creates:[^1]

1. **Overprivileged tokens**: a single powerful token serving all users. The GitHub breach happened because a personal access token with broad repository access was used for an MCP integration. The confused deputy problem in action.
2. **Tool schema manipulation**: the server lies about what a tool does. The user thinks they are searching contacts; the tool is exfiltrating data. Tool descriptions are visible to the LLM but not typically shown to users.
3. **Resource poisoning**: malicious content in resources fed to the LLM. Indirect prompt injection via tool responses: an email contains instructions that the agent follows as if they were user commands.

Research from the MCPTox benchmark tested 20 prominent LLM agents against these attack vectors using 45 real-world MCP servers and 353 tools. The results are counterintuitive: more capable models were often more vulnerable, because the attacks exploit superior instruction-following abilities.[^9]

The MCP specification explicitly forbids two anti-patterns: token passthrough (forwarding tokens without validation) and admin tokens for multi-user deployments (a single powerful token). But specification requirements and production practice diverge. Hundreds of MCP servers remain publicly exposed without basic authentication.[^9]

Shane identifies three trust gaps that MCP does not address:[^1]

1. **Server identity**: OAuth authenticates the user, not the server. How does the client verify the server is who it claims?
2. **Capability proof**: the server says it can access Salesforce. Can it prove that?
3. **Delegation chains**: User → Agent → MCP Server → API. Who authorized what at each step?

These gaps are precisely what the identity infrastructure from [Chapter 3](agent-identity.md) and the trust layer integrations later in this chapter are designed to fill.

## A2A: Connecting Agents to Agents

If MCP is how agents find tools, A2A (Agent-to-Agent) is how agents find each other. Created by Google in April 2025 and donated to the Linux Foundation in June 2025, A2A standardizes agent discovery, communication, and collaboration.[^10]

The distinction is important. MCP servers expose tools: functions with defined inputs and outputs. A2A agents have agency: they can negotiate, collaborate, and produce artifacts over time. An MCP tool call is a function invocation. An A2A interaction is a collaboration.

### Agent Cards

Discovery in A2A happens through Agent Cards: structured metadata documents that describe what an agent can do, how to reach it, and what authentication it requires. Think of Agent Cards as the agent equivalent of an OpenAPI specification, but for capabilities rather than endpoints.

```json
{
  "name": "travel-planner",
  "description": "Plans multi-city itineraries with budget optimization",
  "protocolVersions": ["0.3.0"],
  "supportedInterfaces": [
    {
      "type": "jsonrpc-over-http",
      "url": "https://travel.example.com/a2a"
    },
    {
      "type": "grpc",
      "url": "grpc://travel.example.com:443"
    }
  ],
  "capabilities": {
    "streaming": true,
    "pushNotifications": true
  },
  "authentication": {
    "schemes": ["oauth2"]
  }
}
```

The `protocolVersions` field tells clients which A2A spec versions the agent supports. The `supportedInterfaces` field advertises the concrete endpoints and protocol bindings: JSON-RPC over HTTP is the default, with gRPC available for higher-performance deployments since v0.3.[^11]

### Task Lifecycle

A2A interactions are organized around tasks. A client agent sends a task to a remote agent, which processes it and returns results. Tasks can be:

- **Immediate**: request-response, like a tool call
- **Long-running**: the remote agent works over time, sending progress updates via streaming
- **Collaborative**: multiple rounds of interaction, with the remote agent asking for clarification or sending partial results

This task model is what separates A2A from MCP. An MCP tool call is synchronous and stateless. An A2A task can be asynchronous, stateful, and multi-turn. That is the difference between "call this function" and "work with this agent."

### Adoption and Security

A2A has reached 150+ participating organizations with v0.3.[^12] The addition of gRPC support signals readiness for high-throughput production deployments. Quarkus, the Java framework, released an A2A SDK at v0.3.0, and LangGraph v0.2 added A2A as a first-class protocol target in January 2026.[^13]

The security model mirrors OpenAPI's authentication at launch: agents can require OAuth, API keys, or other standard mechanisms. But A2A v0.3 supports Agent Card signing without enforcing it.[^11] An unsigned Agent Card can be spoofed. A malicious agent could advertise capabilities it does not have, or impersonate a legitimate agent. This is the agent-discovery equivalent of MCP's tool-poisoning problem.

Auth0 partnering on A2A authentication is a convergence point: the same identity infrastructure that governs human access is being extended to govern agent-to-agent communication.[^14]

## MCP and A2A: Complementary, Not Competitive

Shane's explainer architecture makes the relationship clear:[^1] MCP connects agents to tools. A2A connects agents to agents. AgentGateway sits in between as the policy enforcement layer. TSP provides trust across organizational boundaries.

The emerging pattern in production is: **A2A for the network layer, MCP for the resource layer.**[^13] An orchestrating agent uses A2A to discover and delegate to specialized agents. Those specialized agents use MCP to connect to the tools they need. The protocols compose rather than compete.

AgentMaster, in July 2025, was the first framework to use A2A and MCP together in production.[^13] By early 2026, this composition pattern is becoming standard. The question is no longer "MCP or A2A?" but "what sits between them to ensure the composition is governed?"

## The Authorization Gap

This is where Shane's analysis cuts deepest. His March 2026 post on Google's Workspace CLI exposes the structural problem:[^3]

> OAuth is possession-based. If you hold a valid token, you can act. There is no mechanism to verify *why* you are acting, *what task* you are acting on behalf of, or whether the action still aligns with what was originally consented to. The token is a key, not a contract.

Google's Workspace CLI gets the capability layer right: MCP support, skill files, structured output. But the authorization model underneath is built for apps, not agents. OAuth scopes are coarse by design. `gmail.readonly` grants access to every email in the mailbox: every sender, every thread, every attachment, going back to account creation. There is no scope for "emails from this sender, in the last five days, headers only."[^3]

Shane calls this **consent theater**: the user's mental model is "help me find that one email from last week." The token's actual scope is "read everything, for as long as the session lasts." The gap between what was intended and what was granted is where risk lives.[^3]

| You ask the agent to... | What you intended | What you granted |
|---|---|---|
| "Check my support inbox from last 3 days" | Emails from support customers, last 3 days | Every email, every sender, since account creation |
| "Reply to that customer thread" | One reply, to one thread | Send as you, to anyone, about anything |
| "Find the Q4 report in Drive" | One specific file | Read every file in your Drive |

This is not a fixable bug. Coarse scopes are intentional OAuth design. You cannot express conditional access without new protocols. The authorization model is the bottleneck keeping agents out of production, not the capability layer.[^3]

The responses to this gap are emerging at multiple layers:

- **AgentGateway** adds a policy layer that restricts which tools an agent can invoke and under what conditions. But it maps onto the same coarse OAuth scopes underneath.[^3]
- **Verifiable Intent** (covered in [Chapter 3](agent-identity.md)) encodes purpose, constraints, and oversight into cryptographic credentials. The authorization decision is per-action, not per-session.[^15]
- **PIC** replaces proof of possession with proof of continuity, where delegated authority can only diminish, never expand (covered in [Chapter 9](cross-org-trust.md)).[^16]

The gap between "the agent can connect" (solved by MCP/A2A) and "the agent should connect" (unsolved by communication protocols alone) is the central tension of this chapter.

## Agent Gateways: The Enforcement Layer

Agent gateways are to agent traffic what API gateways were to microservices: a centralized control point for identity, permissions, policy, and observability. The pattern is familiar. The requirements are not.

AgentGateway, built by Solo.io in Rust and contributed to the Linux Foundation, is the leading open-source implementation.[^17] Shane includes it in his explainer architecture as the layer between agents and tools/other agents.[^1]

### What Agent Gateways Do

Traditional API gateways optimize for short-lived HTTP request-response cycles. Agent communication is different: long-lived sessions where requests and responses flow continuously, stateful protocol awareness for MCP's JSON-RPC model, and bidirectional, asynchronous messaging initiated by either side.[^17]

AgentGateway's key capabilities:

**MCP federation**: a single endpoint federates multiple backend MCP servers. Clients see one unified tool catalog instead of managing connections to dozens of individual servers. The gateway maps individual client sessions to permitted backend servers and handles bidirectional messaging.[^17]

**Policy authorization**: Cedar policies (Amazon's fine-grained authorization language) control access to MCP servers, tools, and agents. Policies are declarative, auditable, and separate from application code. This supports RBAC (role-based), ABAC (attribute-based), and ReBAC (relationship-based) access control.[^17]

**Security protections**: JWT authentication, tool-poisoning detection, tool server fingerprinting and versioning, and protection against naming collisions and rug-pulls (a server changing tool behavior after initial registration).[^18]

**Observability**: built-in metrics and tracing for monitoring agent-tool interactions. This is governance-grade observability, not just debugging: who called what, when, with what authorization, and what was the result.[^17]

### The Limits of Gateways

Shane identifies AgentGateway's structural limitation:[^3] it operates at the tool level. It can say "this agent may call the Gmail API" or "this agent may not call the Calendar API." What it cannot yet express is: "this agent may read emails from support@customer.com but not from hr@company.com" or "this agent may send replies but only using approved templates."

The policies map onto the same coarse OAuth scopes underneath. AgentGateway is real progress: instead of "the agent has a token, therefore it can do anything the token allows," you get a policy layer that can restrict and audit tool access. But it is a governance layer on top of an authorization model that was not designed for agents. The deeper fix requires the shift from possession-based to proof-based authorization.[^3]

Gartner predicts that a majority of API gateway vendors will add MCP capabilities by the end of 2026.[^19] Early participation in AgentGateway's community meetings includes AWS, Microsoft, Red Hat, IBM, Cisco, and Shell.[^18] The pattern is converging fast. What remains unclear is whether these implementations will address the authorization gap or merely replicate it at a new layer.

## Trust Layer Integrations: TMCP and TA2A

The communication protocols (MCP, A2A) and the trust protocols (TSP, PIC) from [Chapter 9](cross-org-trust.md) are designed to compose. Shane's LFDT meetup post describes how this works in practice.[^16]

### TMCP: Trust-Enabled MCP

Replace MCP's transport layer with TSP, introduce a wallet and verifiable identifiers, and you get TMCP: the same JSON-RPC calls, but now every interaction is authenticated, signed, and traceable. As Wenjing Chu (co-author of TSP) described at the LFDT meetup:[^16]

> If the foundation is solid, credential exchange becomes simple. If not, complexity multiplies at every layer above.

TMCP addresses the three trust gaps that standard MCP leaves open:

1. **Server identity**: TSP's verifiable identifiers prove who the server is, not just that the user authenticated. The client can verify the server's identity before sending any data.
2. **Capability proof**: verifiable credentials attached to TSP messages can prove that the server actually has the claimed relationship with a service (e.g., a credential from Salesforce proving API access).
3. **Delegation chains**: TSP's authenticated channels preserve who said what to whom, creating an accountability trail that survives across the full chain: User → Agent → MCP Server → API.

The implementation is practical. TSP is deliberately thin: a transport-layer protocol that handles identity and trust. MCP's JSON-RPC messages ride on top unchanged. The agent framework does not need to change. The gateway does not need to change. The transport layer adds trust properties that the higher layers inherit.[^16]

### TA2A: Trust-Enabled A2A

The same principle applies to A2A. Running A2A over TSP means that Agent Cards are cryptographically verifiable (solving the spoofing problem with unsigned cards), task messages are authenticated and private, and cross-organizational agent discovery gets verifiable identity guarantees instead of relying on DNS and TLS alone.

Wenjing Chu presented TMCP and TA2A at the LFDT meetup as near-term deliverables from the Trust over IP Foundation's AI and Human Trust working group.[^16] The architecture is designed for incremental adoption: you can start with standard MCP/A2A and layer TSP underneath when cross-organizational trust becomes a requirement.

### PIC as the Authority Layer

TSP provides the identity and communication layer. PIC provides the authority layer. When an agent uses TMCP to connect to a tool, PIC ensures that the authority carried in that connection can only diminish through the delegation chain, never expand. This is the structural guarantee that prevents the confused deputy problem: not by detecting it after the fact, but by making it mathematically impossible.[^16]

The combination of TMCP + PIC means:
- **Identity**: TSP proves who the agent is and who it represents
- **Authority**: PIC proves the agent is operating within its delegated authority
- **Communication**: MCP's tool protocol works unchanged
- **Accountability**: every step in the chain is signed and traceable

This is the trust stack that the Cross-Organization Trust chapter assembled from the protocol perspective. Here we see it from the communication perspective: the same protocols, with trust properties added at the transport layer rather than bolted on at the application layer.

## The Broader Protocol Landscape

MCP and A2A are the dominant protocols, but the landscape includes specialized protocols for specific domains:

### ACP: Agent Commerce Protocol

Developed by Stripe and OpenAI, ACP handles checkout flows for agent-initiated purchases.[^20] It integrates with ChatGPT's Instant Checkout and provides structured payment interactions. ACP is not a general communication protocol: it is a domain-specific extension for commerce.

### UCP: Unified Commerce Protocol

Developed by Google with Shopify and Walmart, UCP handles product discovery for agents.[^21] Where ACP manages the checkout, UCP manages the catalog: structured product data that agents can search, compare, and reason about.

### The Protocol Stack

These protocols are more complementary than competitive. They layer:

| Layer | Protocol | Function |
|-------|----------|----------|
| Trust | TSP + PIC | Identity verification, authority continuity |
| Agent discovery | A2A | Agent-to-agent communication and collaboration |
| Tool discovery | MCP | Agent-to-tool connection and invocation |
| Commerce | ACP + UCP | Payment flows and product discovery |
| Authorization | Verifiable Intent | Cryptographic constraint encoding |
| Enforcement | AgentGateway | Policy, audit, and traffic management |

The critical observation: **no unified identity flows across all layers**.[^13] MCP has its own auth model (OAuth 2.1). A2A has its own auth scheme. The commerce protocols add their own credential requirements. TSP is designed to be the unifying identity layer underneath, but adoption is early. Until identity is unified across the stack, each protocol boundary is a potential trust gap.

## AAIF: Governance Under the Linux Foundation

On December 9, 2025, the Linux Foundation announced the Agentic AI Foundation (AAIF), with founding contributions from three projects: Anthropic's MCP, Block's goose, and OpenAI's AGENTS.md.[^22]

The platinum members tell the story: Amazon Web Services, Anthropic, Block, Bloomberg, Cloudflare, Google, Microsoft, and OpenAI.[^22] These are competitors co-governing shared infrastructure. This pattern is familiar from the Linux kernel, Kubernetes, and other foundational open-source projects. When the infrastructure layer is too important for any single company to own, neutral governance becomes a competitive advantage for the ecosystem.

### What AAIF Governs

The three founding projects address different layers:

- **MCP**: the protocol for connecting agents to tools (the plumbing)
- **goose**: an open-source, local-first AI agent framework that uses MCP for integration (Block's contribution)
- **AGENTS.md**: a standard for giving AI coding agents project-specific guidance (OpenAI's contribution, analogous to Claude Code's CLAUDE.md)

The governance model separates strategic decisions (budget, membership, new projects) from technical direction. Individual projects like MCP maintain full autonomy over their technical roadmap. The foundation provides neutral governance, not technical control.[^22]

### Why This Matters for Trust

Neutral governance under the Linux Foundation matters for three reasons:

1. **No single vendor controls the protocol**. When Anthropic owned MCP, enterprise adoption carried vendor-lock-in risk. Under AAIF, the protocol's direction is shaped by the community, not by one company's product strategy.

2. **Standards convergence becomes possible**. With MCP, A2A (which joined the Linux Foundation earlier), and agent gateways all under Linux Foundation governance, there is an institutional home for addressing cross-protocol concerns like unified identity and shared authorization models.

3. **Regulatory compliance is simpler**. The EU AI Act and NIST standards work both emphasize open standards and interoperability. Building on AAIF-governed protocols gives organizations a compliance argument they cannot make with proprietary alternatives.

Shane's PAC Framework emphasizes building on emerging standards rather than proprietary solutions.[^23] AAIF is the institutional expression of that principle: open protocols, neutral governance, community-driven evolution.

## PAC Mapping

Agent communication protocols touch all three pillars, but the distribution is distinctive:

| PAC Dimension | How Communication Protocols Apply |
|---|---|
| **Potential: Business value** | Standard protocols eliminate N×M integration cost. Agents can discover and use tools without custom code. |
| **Potential: Reliability** | Protocol standardization makes agent behavior more predictable. Server Cards and Agent Cards provide capability discovery before runtime. |
| **Potential: Context management** | MCP's resource primitive provides structured context delivery. A2A's task model enables multi-turn context exchange. |
| **Accountability: Audit trails** | Agent gateways provide governance-grade observability: who called what, when, with what authorization. |
| **Accountability: Shadow agents** | Gateway-mediated discovery makes agent activity visible. Ungoverned agents bypass the gateway. |
| **Accountability: Delegation** | MCP does not track delegation. A2A does not enforce authority diminishment. TMCP and PIC add these properties. |
| **Control: Infrastructure as gate** | Agent gateways enforce policy at the protocol layer: tool access, rate limiting, content filtering. |
| **Control: Agent identity** | MCP authenticates users, not servers. A2A supports but does not enforce Agent Card signing. TMCP/TA2A add verifiable identity. |
| **Control: Cross-org trust** | Standard MCP/A2A do not solve cross-boundary trust. TSP integration (TMCP/TA2A) is designed for this. |

The pattern: MCP and A2A are strong on Potential (capability, discovery, interoperability) and have growing support for Control (gateways, policies). They are weakest on Accountability (delegation tracking, authority propagation) and on Control at the identity level (verifiable server identity, enforced Agent Card signing). The trust layer integrations (TMCP, TA2A, PIC) fill exactly these gaps.

## Infrastructure Maturity for Communication Protocols

Mapping the PAC Framework's infrastructure maturity levels to communication protocol adoption:

| Level | Description | Communication Protocol Capabilities |
|---|---|---|
| **I1: Ad hoc** | No protocol standards. Custom integrations for every tool and agent. | Direct API calls, hardcoded tool definitions, no discovery mechanism. |
| **I2: Repeatable** | MCP adopted for tool connections. Basic A2A for agent discovery. | Standardized tool invocation, Agent Cards for discovery, OAuth for authentication. |
| **I3: Defined** | Agent gateway mediating all agent traffic. Cedar policies for tool access. Observability. | Federated MCP, policy-driven access control, audit trails for agent-tool interactions. |
| **I4: Managed** | TMCP/TA2A for cross-org interactions. Verifiable server identity. Authority tracking. | Trust layer integration, verifiable Agent Cards, delegation chain visibility, PIC authority continuity. |
| **I5: Optimized** | Unified identity across all protocol layers. Semantic interoperability for agent actions. Continuous authorization. | Full protocol stack with unified identity, resolvable action vocabularies, per-action authorization with Verifiable Intent. |

Most organizations are at I1-I2: they have adopted MCP for tool connections but lack gateway mediation, trust layer integration, or unified identity. The 97 million monthly MCP downloads represent broad I2 adoption. The gap between I2 and I3 (adding governance to communication) is where most production deployment friction lives today.

## Practical Recommendations

**If you are just starting**: adopt MCP for tool connections. It is the standard. Every major provider supports it, it is under neutral governance (AAIF), and the ecosystem of servers, SDKs, and documentation is mature. Do not build custom tool integrations.

**If you are connecting agents to agents**: adopt A2A for agent discovery and collaboration. Use Agent Cards to describe capabilities. Start with JSON-RPC over HTTP; add gRPC when performance requires it. Require Agent Card signing in your deployments even though the spec does not enforce it.

**If you are deploying to production**: put an agent gateway between your agents and everything they connect to. AgentGateway is the leading open-source option. Use Cedar policies to restrict tool access by role, context, and task. Enable observability for every agent-tool interaction.

**If you are crossing organizational boundaries**: evaluate TMCP and TA2A for trust-layer integration. Standard MCP/A2A do not verify server identity or track delegation chains. For cross-org deployments, you need verifiable identifiers and authenticated channels that survive across trust boundaries.

**What to watch**: the MCP specification update (targeted June 2026) will address streamable HTTP transport, `.well-known` discovery, Tasks primitive refinements, and enterprise deployment needs (audit trails, SSO-integrated auth, gateway behavior). The AAIF governance structure will shape how MCP, A2A, and agent gateways evolve together. And the authorization gap: the distance between what communication protocols can express ("connect to this tool") and what governance requires ("connect to this tool, for this purpose, under these constraints"): remains the most important unsolved problem in the stack.

---

[^1]: Shane Deconinck, "Understanding MCP: Anthropic's Model Context Protocol Explained" and "Understanding A2A: Google's Agent-to-Agent Protocol Explained," trustedagentic.ai, January 2026.
[^2]: Anthropic, "Donating the Model Context Protocol and Establishing of the Agentic AI Foundation," anthropic.com, December 2025.
[^3]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," trustedagentic.ai, March 5, 2026.
[^4]: MCP Specification, modelcontextprotocol.io, November 2025. Required standards: OAuth 2.1 + PKCE, RFC 9728, RFC 8707, RFC 8414.
[^5]: "The 2026 MCP Roadmap," blog.modelcontextprotocol.io, 2026.
[^6]: "SEP-1649: MCP Server Cards," github.com/modelcontextprotocol, 2026.
[^7]: MCP SDK download statistics, February 2026. Python + TypeScript combined.
[^8]: AuthZed, "A Timeline of Model Context Protocol (MCP) Security Breaches," authzed.com, 2025-2026.
[^9]: MCPTox benchmark results and Practical DevSecOps, "MCP Security Vulnerabilities," 2026.
[^10]: Google Cloud Blog, "Agent2Agent protocol (A2A) is getting an upgrade," cloud.google.com, 2026.
[^11]: A2A Protocol Specification v0.3, a2a-protocol.org, 2026.
[^12]: Google, A2A adoption statistics, 2026. 150+ participating organizations.
[^13]: Subhadip Mitra, "The Agent Protocol Stack: Why MCP + A2A + A2UI Is the TCP/IP Moment for Agentic AI," 2026. LangGraph v0.2 shipped January 15, 2026.
[^14]: Auth0 A2A authentication partnership, referenced in Context Infrastructure chapter.
[^15]: Mastercard and Google, "Verifiable Intent," March 2026. Covered in Agent Identity chapter.
[^16]: Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," trustedagentic.ai, March 11, 2026.
[^17]: AgentGateway documentation, agentgateway.dev. Built in Rust, contributed to Linux Foundation by Solo.io.
[^18]: Solo.io, "Solo Enterprise for agentgateway," solo.io, 2026. Community participants include AWS, Microsoft, Red Hat, IBM, Cisco, Shell.
[^19]: Gartner prediction on API gateway vendors adding MCP capabilities, referenced in Context Infrastructure chapter.
[^20]: Stripe and OpenAI, Agent Commerce Protocol (ACP), 2026.
[^21]: Google Developers Blog, Unified Commerce Protocol (UCP), 2026. Co-developed with Shopify and Walmart.
[^22]: Linux Foundation, "Linux Foundation Announces the Formation of the Agentic AI Foundation (AAIF)," linuxfoundation.org, December 9, 2025.
[^23]: PAC Framework, trustedagentic.ai, March 2026.
[^24]: Invariant Labs, WhatsApp MCP tool poisoning vulnerability, April 2025. Demonstrated cross-server exfiltration via malicious tool descriptions. Covered in Docker, "MCP Horror Stories: WhatsApp Data Exfiltration," docker.com.
[^25]: Nudge Security, "SaaS Security Alert: Asana MCP Server Data Exposure Incident," June 2025. Access control logic flaw exposed cross-organizational data.
[^26]: Oligo Security, CVE-2025-49596, July 2025. Missing authentication between MCP Inspector client and proxy enabled unauthenticated RCE and DNS rebinding attacks on developer workstations. Patched in version 0.14.1.
[^27]: Arctic Wolf, CVE-2026-27825, January 2026. Missing directory confinement in mcp-atlassian Confluence attachment downloads enabled path traversal, privilege escalation, and RCE.
[^28]: CVE-2026-30861, March 2026. Command injection in WeKnora MCP stdio configuration validation.
[^29]: Microsoft Security Update, CVE-2026-26118, March 10, 2026. SSRF in Azure MCP Server Tools enabling managed identity token theft and privilege escalation. CVSS 8.8.
