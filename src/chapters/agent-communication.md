# Agent Communication Protocols

Communication protocols are the plumbing of the agent ecosystem. They determine how agents discover tools, talk to other agents, and traverse organizational boundaries. Get the plumbing right, and agents can compose into systems that create value no single agent could deliver. Get it wrong, and every integration is bespoke, every boundary a wall, every tool connection a security risk.

The critical insight: **communication protocols solve discovery, not trust**.[^1] MCP tells an agent what tools exist. A2A tells an agent what other agents can do. Neither tells the agent whether to trust what it finds. That gap is where the rest of this book's infrastructure: identity, delegation, authority, and governance: becomes load-bearing.

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

A fourth capability, **sampling**, inverts the direction: it allows the server to request LLM completions from the client. Instead of the client calling the server's tools, the server calls back to the client's model. This is designed for legitimate use cases (a server that needs the LLM to interpret unstructured data before processing it), but it opens an attack surface that the other three capabilities do not: the server can influence the agent's reasoning directly, not just its inputs.

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

The stdio transport is how most developers encounter MCP today: a local process that the host spawns and communicates with over standard input/output. Shane identified the consequence in his Google Workspace CLI analysis: "The agent simply inherits whatever credentials the host process has."[^3] There is no network boundary to enforce policy at.

The HTTP transport enables remote MCP servers, which is where production deployments live. The 2025-11-25 specification requires OAuth 2.1 with PKCE (S256 mandatory), RFC 9728 for Protected Resource Metadata, and RFC 8707 for Resource Indicators.[^4] Remote servers expose a `.well-known/oauth-protected-resource` endpoint for authorization server discovery.

### The 2026 Roadmap

Running MCP at scale has surfaced gaps. Stateful sessions conflict with load balancers. Horizontal scaling requires workarounds. There is no standard way for a registry or crawler to discover what a server does without connecting to it.[^5]

The 2026 roadmap, announced March 9, 2026 (updated March 5), identifies four priority areas where Spec Enhancement Proposals (SEPs) receive expedited review:[^5]

1. **Transport Evolution and Scalability**: making MCP servers viable as remote services at scale by resolving conflicts between stateful sessions, load balancers, and horizontal scaling. This includes evolving Streamable HTTP for stateless operation across multiple server instances and defining session creation, resumption, and migration. It also covers MCP Server Cards: a standardized metadata format served at `.well-known/mcp.json`, letting browsers, crawlers, and registries discover server capabilities without establishing a connection.[^6]
2. **Agent Communication**: iterating on the Tasks primitive (improving retry semantics and expiry policies based on early production use), and defining agent-to-agent interaction patterns within MCP.
3. **Governance Maturation**: establishing a Contributor Ladder SEP, delegation models for Working Groups, and charter templates for transparent community governance.
4. **Enterprise Readiness**: audit trails and observability, enterprise-managed auth moving away from static secrets toward SSO-integrated flows, gateway and proxy patterns, and configuration portability for production environments.

These are infrastructure maturity improvements. They move MCP from "works in development" to "works in production at scale." The specification updates are targeted for the next release, tentatively slated for June 2026.[^5]

Beyond the four priority areas, the roadmap lists security and authorization as "on the horizon": not yet a top priority, but with sponsored work already underway. Two SEPs are notable. SEP-1932 brings DPoP (Demonstration of Proof-of-Possession) to MCP, binding tokens to cryptographic keys so stolen tokens are useless without the private key.[^mcp-dpop] SEP-1933 adds Workload Identity Federation, enabling agents to authenticate using platform-issued identities (cloud workload credentials) rather than static client secrets.[^mcp-wif] Both are pull requests in the MCP specification repository, not proposals waiting for attention. The roadmap also targets finer-grained least-privilege scopes, OAuth mix-up attack guidance, and a community-driven vulnerability disclosure program routed through the Linux Foundation.

DPoP is already covered in the [Agent Identity and Delegation](agent-identity.md) chapter as critical infrastructure for preventing token theft. Workload Identity Federation connects to the WIMSE (Workload Identity in Multi-System Environments) work discussed in the same chapter. MCP adopting both confirms the trajectory: the identity layer and the communication layer are converging.

### Adoption

The adoption numbers are striking. By February 2026, MCP crossed 98.6 million monthly SDK downloads (Python and TypeScript combined).[^7] Every major AI provider has adopted it: Anthropic, OpenAI, Google, Microsoft, and Amazon. This is not a protocol war. MCP won the tool-connection layer.

### Security: MCP Is Plumbing, Not Trust

The adoption speed has outpaced security maturity. A timeline of MCP security incidents illustrates the pattern:[^8]

| Date | Incident | Impact |
|------|----------|--------|
| April 2025 | WhatsApp MCP exfiltration | Tool poisoning: malicious server silently exfiltrated entire WhatsApp history via legitimate whatsapp-mcp[^24] |
| May 2025 | GitHub MCP prompt injection | Private repos, salary data leaked to public PR via overprivileged PAT |
| June 2025 | Asana MCP data exposure | Cross-organization data leak: one org's data visible to other orgs due to access control flaw[^25] |
| July 2025 | mcp-remote CVE-2025-6514 | Command injection in OAuth proxy, 437k+ downloads, supply-chain attack surface |
| June 2025 | MCP Inspector CVE-2025-49596 | Unauthenticated RCE in Anthropic's official developer tool, CVSS 9.4[^26] |
| August 2025 | Anthropic Filesystem MCP | Sandbox escape, symlink bypass enabling arbitrary file access |
| September 2025 | Fake Postmark MCP package | Supply-chain attack, BCC'd all emails to attacker |
| October 2025 | Smithery path traversal | Leaked Fly.io token controlling 3,000+ MCP servers |
| February 2026 | mcp-atlassian CVE-2026-27825 | Path traversal enabling arbitrary file write and RCE via Confluence attachments[^27] |
| March 2026 | WeKnora CVE-2026-30861 | Command injection in MCP stdio configuration validation[^28] |
| March 2026 | Azure MCP Server CVE-2026-26118 | SSRF enabling managed identity token theft and privilege escalation, CVSS 8.8[^29] |

Eleven incidents in twelve months, and the pace is accelerating. But this curated timeline understates the scale. Between January and February 2026 alone, 30 MCP-related CVEs were filed across three distinct attack layers: MCP servers themselves, protocol implementation libraries (the official TypeScript, Python, and Go SDKs), and host applications and development tools.[^30] The breakdown by vulnerability class: 43% exec()/shell injection, 20% tooling and infrastructure, 13% authentication bypass, 10% path traversal, 7% new classes like eval() injection and environment variable injection. Scanning of over 500 MCP servers found that 38% completely lack authentication: no API key, no OAuth, no access control of any kind.[^30]

The Azure MCP vulnerability is notable: Microsoft's own first-party MCP server implementation had a critical SSRF that could steal the server's managed identity token, giving an attacker whatever permissions the MCP server held in the Azure environment. Patched on March 10, 2026. These are not edge cases. They represent the three primary attack vectors that MCP creates:[^1]

1. **Overprivileged tokens**: a single powerful token serving all users. The GitHub breach happened because a personal access token with broad repository access was used for an MCP integration. The confused deputy problem in action.
2. **Tool schema manipulation**: the server lies about what a tool does. The user thinks they are searching contacts; the tool is exfiltrating data. Tool descriptions are visible to the LLM but not typically shown to users.
3. **Resource poisoning**: malicious content in resources fed to the LLM. Indirect prompt injection via tool responses: an email contains instructions that the agent follows as if they were user commands.

A fourth attack vector exploits MCP's sampling capability: the reverse direction. Palo Alto's Unit 42 demonstrated three proof-of-concept attacks on a widely-used coding copilot through MCP sampling requests.[^unit42-sampling] Because sampling allows servers to request LLM completions from the client, a compromised server can inject hidden instructions into sampling requests that the user never sees. The three attacks: **resource theft**, where injected instructions cause the LLM to generate unauthorized content while consuming API credits without user awareness; **conversation hijacking**, where the server injects persistent instructions that affect the entire conversation session, not just a single tool call; and **prompt manipulation**, where the server modifies prompts and responses while appearing to function normally. The sampling attack is distinct from tool poisoning because it operates in the reverse direction: instead of the client calling a malicious tool, the server calls back to the client's LLM with malicious intent. The client's LLM processes the sampling request with its full context and credentials, making the injection more powerful than a tool description alone.

Research from the MCPTox benchmark tested 20 prominent LLM agents against tool poisoning using 45 real-world MCP servers and 353 tools. The results are counterintuitive: more capable models were often more vulnerable, because the attacks exploit superior instruction-following abilities.[^9]

A fifth attack vector targets the agent's compute budget rather than its data or permissions. Lee et al. demonstrated that malicious MCP tool servers can induce cyclic "overthinking loops": a small set of cycle-inducing tools, when co-registered alongside legitimate tools in a shared registry, force the agent into repetitive reasoning steps that amplify token consumption up to 142.4x.[^overthinking-loops] The attack is subtle: no single tool call looks abnormal. The damage emerges from composition: individually plausible calls chain into cycles that drain API budgets. This is a denial-of-wallet attack, and it exploits the same property that makes MCP powerful: open tool registries where any server can offer tools. The defense requires what the [Sandboxing and Execution Security](execution-security.md) chapter argues for: resource budgets and cost controls enforced at the infrastructure level, not left to the agent's judgment.

The MCP specification explicitly forbids two anti-patterns: token passthrough (forwarding tokens without validation) and admin tokens for multi-user deployments (a single powerful token). But specification requirements and production practice diverge: a community scan of 518 servers in the official MCP registry found that 38% accept connections from any client without authentication.[^30]

Shane identifies three trust gaps that MCP does not address:[^1]

1. **Server identity**: OAuth authenticates the user, not the server. How does the client verify the server is who it claims?
2. **Capability proof**: the server says it can access Salesforce. Can it prove that?
3. **Delegation chains**: User → Agent → MCP Server → API. Who authorized what at each step?

These gaps are precisely what the identity infrastructure from [Agent Identity and Delegation](agent-identity.md) and the trust layer integrations later in this chapter are designed to fill. One concrete response: Okta's Cross App Access (XAA) protocol has been incorporated into the MCP specification as the "Enterprise-Managed Authorization" extension. Built on the IETF Identity Assertion JWT Authorization Grant (ID-JAG) draft, XAA routes agent-to-MCP-server connections through the enterprise identity provider, which enforces policy over which agents can connect to which servers with what scopes. This directly addresses the delegation chain gap: the IdP mediates the connection and logs who authorized what. The identity layer for this is covered in [Agent Identity and Delegation](agent-identity.md).[^xaa-mcp]

### Systematic Protocol Threat Modeling

A February 2026 paper by Anbiaee et al. provides the first systematic security threat model across four agent communication protocols: MCP, A2A, Agora, and ANP (Agent Network Protocol).[^protocol-threats] The analysis identifies twelve protocol-level risks across three domains and evaluates security posture across creation, operation, and update lifecycle phases.

The twelve risks cluster into three categories:

**Authentication and access control risks**: replay attacks, token scope escalation, privilege escalation, identity forgery and impersonation, Sybil attacks, and cross-vendor trust boundary exploitation. These are familiar from traditional API security but amplified by agents' autonomous decision-making: a replayed token in an agent context triggers autonomous actions, not just data access.

**Supply chain and ecosystem risks**: supply-chain compromise, protocol document spoofing and repository poisoning, protocol fragmentation, version rollback attacks, and onboarding exploitation. Version rollback is worth highlighting: an attacker forces a downgrade to an older protocol version with known vulnerabilities. Agent protocols evolve fast, and not all implementations track the latest security patches. The MCP ecosystem's 30 CVEs in 60 days illustrate the attack surface that version fragmentation creates.

**Operational integrity risks**: cross-protocol interaction risks, cross-protocol confusion attacks, context explosion and resource exhaustion, intent deception, collusion and free-riding, and semantic drift exploitation. Cross-protocol confusion is the most novel finding: when agents compose MCP and A2A (as described later in this chapter), an attacker can exploit the boundary between protocols. A malicious A2A agent can direct a client to invoke an MCP tool at the wrong provider, exploiting the lack of unified identity across the protocol stack. The paper calls this "wrong-provider tool execution": the agent thinks it is calling Tool X at Provider A, but the request is routed to Provider B. Without end-to-end identity verification across protocol boundaries, the composition itself is an attack surface.

The comparative security assessment is instructive. ANP, which builds on W3C Decentralized Identifiers with end-to-end encryption, has the strongest security posture. A2A, with OAuth 2.0 mutual authentication and JWT signing, is second. MCP and Agora are weakest: MCP lacks authentication in its core design (relying on transport-layer OAuth that 38% of servers do not implement), and Agora's trustless validation model lacks strong cryptographic binding.[^protocol-threats]

The paper's central conclusion aligns with this chapter's thesis: no single protocol fully addresses all twelve risks, and the most dangerous vulnerabilities emerge at protocol boundaries during composition. This is why the trust layer integrations (TMCP, TA2A) described later in this chapter matter: they provide the unified identity and verification layer that individual protocols lack.

### OWASP MCP Top 10

OWASP launched the MCP Top 10 project in 2026: a dedicated security framework for Model Context Protocol risks, distinct from the OWASP Top 10 for Agentic Applications.[^owasp-mcp] Where the Agentic Applications list addresses agent-level risks (goal hijacking, excessive agency, memory poisoning), the MCP Top 10 focuses specifically on protocol-level risks in the MCP lifecycle.

The MCP Top 10 identifies risks across the full interaction surface:

- **Token mismanagement and secret exposure**: hard-coded credentials, long-lived tokens, and secrets persisted in model memory or protocol logs. The Azure MCP SSRF (CVE-2026-26118) is a concrete example: the server's managed identity token leaked through an SSRF because input validation did not prevent the server from sending authenticated requests to attacker-controlled URLs.
- **Context over-sharing**: shared, persistent, or insufficiently scoped context windows that leak sensitive information across tasks, users, or agents. This is the protocol-level instantiation of the context integrity problem the [Context Infrastructure](context-infrastructure.md) chapter identifies.
- **Prompt injection and command injection**: agents constructing system commands or API calls from untrusted input without validation. The 43% exec()/shell injection rate in the 30-CVE analysis confirms this is the dominant vulnerability class.
- **Software supply chain attacks and dependency tampering**: compromised packages, connectors, and plugins altering agent behavior or introducing backdoors. The [Agent Supply Chain Security](supply-chain-security.md) chapter covers this attack surface in depth.
- **Insufficient authentication and authorization**: MCP servers, tools, or agents failing to verify identities or enforce access controls. The 38% of servers accepting unauthenticated connections is the baseline measurement.

The OWASP MCP Top 10 matters for two reasons. First, it provides a shared vocabulary for MCP security risks that organizations can reference in procurement, vendor assessment, and compliance documentation. Second, it confirms that MCP's security challenges are now recognized at the same standards level as the OWASP Top 10 for web applications: not niche, not temporary, but a permanent feature of the protocol's attack surface that requires ongoing attention.

[^owasp-mcp]: OWASP, "OWASP MCP Top 10," owasp.org/www-project-mcp-top-10, 2026. Developed through industry collaboration with researchers and practitioners. Designed as a living document evolving alongside MCP capabilities.

### MCP Governance in Production

Microsoft's internal MCP deployment provides the first documented production governance blueprint at enterprise scale.[^ms-mcp-governance]

Microsoft organizes MCP risk into four layers: **applications and agents** (the top, where business logic and tool calls originate), **AI platform** (the orchestration and model layer), **data** (what agents access and produce), and **infrastructure** (the compute, network, and identity substrate). Each layer has distinct failure modes and distinct controls. Mapping mitigations to where failures actually happen, rather than applying a single security model across the stack, is the practical insight.

Three governance patterns stand out:

**Context minimization.** MCP servers are designed to expose the minimum context an agent needs, not everything the server has access to. This is the protocol-level application of least privilege: the server's tool definitions, resource scopes, and response structures are designed to limit what enters the agent's context window. Combined with egress controls that pin outbound traffic to approved hosts via private endpoints and firewall rules, the architecture constrains both what goes in (context minimization) and what goes out (egress pinning). A compromised MCP server cannot "call anywhere."

**Pre-publication review gates.** No MCP server is published to the organization until it passes security, privacy, and responsible AI reviews. This is a registry enforcement pattern: the MCP server catalog acts as a governance checkpoint, not just a discovery mechanism. It connects directly to the [Shadow Agent Governance](shadow-agent-governance.md) chapter's registry argument: if MCP servers can only be discovered through the governed catalog, ungoverned servers cannot be connected to.

**End-to-end observability.** Every tool call carries a correlation ID from client through gateway to server and back. This creates the audit trail that incident response requires: when something goes wrong, the full call chain is reconstructable. The four operational motions (observe, inventory, evaluate, contain) parallel the [Reliability, Evaluation](reliability-evaluation.md) chapter's argument that governance-grade observability means monitoring the full communication surface, not just outputs.

The limitation is the same one the [Shadow Agent Governance](shadow-agent-governance.md) chapter identifies for Agent 365 more broadly: this governance model works within a single platform's ecosystem. Agents that span providers, use non-Microsoft MCP servers, or operate across organizational boundaries need the cross-organizational trust infrastructure described in [Cross-Organization Trust](cross-org-trust.md). But for organizations already running MCP within a managed environment, the pattern shows what I3-level governance (verified, policy-enforced communication) looks like in practice.

[^ms-mcp-governance]: Microsoft, "Protecting AI conversations at Microsoft with Model Context Protocol security and governance," Inside Track Blog, March 2026. See also Microsoft, "Riding the wave of agents washing over Microsoft with good governance," Inside Track Blog, March 2026.

## A2A: Connecting Agents to Agents

If MCP is how agents find tools, A2A (Agent-to-Agent) is how agents find each other. Created by Google in April 2025 and donated to the Linux Foundation in June 2025, A2A standardizes agent discovery, communication, and collaboration.[^10]

The distinction is important. MCP servers expose tools: functions with defined inputs and outputs. A2A agents have agency: they can negotiate, collaborate, and produce artifacts over time. An MCP tool call is a function invocation. An A2A interaction is a collaboration.

### Agent Cards

Discovery in A2A happens through Agent Cards: structured metadata documents that describe what an agent can do, how to reach it, and what authentication it requires. Think of Agent Cards as the agent equivalent of an OpenAPI specification, but for capabilities rather than endpoints.

```json
{
  "name": "travel-planner",
  "description": "Plans multi-city itineraries with budget optimization",
  "supportedInterfaces": [
    {
      "type": "jsonrpc-over-http",
      "url": "https://travel.example.com/a2a",
      "protocolVersions": ["1.0"]
    },
    {
      "type": "grpc",
      "url": "grpc://travel.example.com:443",
      "protocolVersions": ["1.0"]
    }
  ],
  "capabilities": {
    "streaming": true,
    "pushNotifications": true
  },
  "authentication": {
    "schemes": ["oauth2"],
    "pkce_required": true
  }
}
```

V1.0 restructured Agent Cards: protocol versions moved from a top-level field into per-interface declarations, enabling agents to support different spec versions on different transports. The `supportedInterfaces` array advertises the concrete endpoints and protocol bindings: JSON-RPC over HTTP is the default, with gRPC available for higher-performance deployments.[^11]

### Task Lifecycle

A2A interactions are organized around tasks. A client agent sends a task to a remote agent, which processes it and returns results. Tasks can be:

- **Immediate**: request-response, like a tool call
- **Long-running**: the remote agent works over time, sending progress updates via streaming
- **Collaborative**: multiple rounds of interaction, with the remote agent asking for clarification or sending partial results

This task model is what separates A2A from MCP. An MCP tool call is synchronous and stateless. An A2A task can be asynchronous, stateful, and multi-turn. That is the difference between "call this function" and "work with this agent."

### Adoption and Security

A2A reached 150+ participating organizations with v0.3, and v1.0 shipped in early 2026 with significant security hardening.[^12] Quarkus, the Java framework, released an A2A SDK at v0.3.0, and LangGraph v0.2 added A2A as a first-class protocol target in January 2026.[^13] Enterprise adoption is broadening: Amazon Bedrock AgentCore added native A2A support, and SAP, Salesforce, and ServiceNow are building A2A into their agent frameworks.

V1.0 addressed three security gaps that v0.3 left open. First, **Agent Card signing via JWS** (RFC 7515) with JSON Canonicalization Scheme (RFC 8785) for deterministic serialization. In v0.3, agent card signing was supported but not enforced: an unsigned card could be spoofed, and a malicious agent could advertise capabilities it did not have. V1.0 provides the cryptographic infrastructure to verify card authenticity before establishing communication. This is the agent-discovery equivalent of certificate verification in TLS: you can still choose not to verify, but the protocol gives you the tools to do so.[^11] [^a2a-v1]

Second, **OAuth 2.0 modernization**: v1.0 removed the deprecated Implicit and Password flows (security risks well-documented in OAuth 2.1) and added PKCE support with a `pkce_required` field for authorization code flows. It also added the Device Code flow (RFC 8628) for CLI and IoT agent scenarios where browser redirects are impractical.

Third, **mutual TLS support** in security scheme declarations, enabling bidirectional authentication between agents.

Auth0 partnering with Google Cloud to define A2A authentication specifications is a convergence point: the same identity infrastructure that governs human access is being extended to govern agent-to-agent communication.[^14]

### Sector-Specific Specialization: A2A-T

The A2A paradigm is already spawning domain-specific variants. At MWC 2026 (March 2), Huawei announced the open-source release of A2A-T (Agent-to-Agent for Telecom), a sector-specific protocol built on the TM Forum's IG1453 specification.[^a2a-t] The open-source project includes three components: a protocol SDK for standardized agent interaction, a Registry Center for agent authentication, addressing, and skill management, and an Orchestration Center for visual workflow composition with pre-built telecom solution packages.

A2A-T is architecturally significant for what it signals about protocol evolution. Telecom networks have requirements that the general-purpose A2A specification does not address: carrier-grade reliability, cross-vendor interoperability across network equipment from different manufacturers, and regulatory compliance for critical infrastructure. Rather than extending A2A itself, the telecom industry built a sector-specific layer on top. This is the same pattern that happened with HTTP (which spawned domain-specific profiles like FHIR for healthcare and OData for enterprise data): the base protocol provides the communication model, and sector-specific profiles add the constraints and extensions that the domain requires.

The implications for the broader protocol landscape: if telecom, finance, and healthcare each develop domain-specific agent communication profiles, the interoperability story becomes more complex. An agent operating across sectors needs to bridge multiple protocol profiles, not just multiple protocol implementations. The governance question shifts from "which protocol wins?" to "how do sector-specific profiles compose?" AAIF's neutral governance role becomes more important as the protocol tree branches.

## MCP and A2A: Complementary, Not Competitive

MCP connects agents to tools. A2A connects agents to agents. AgentGateway sits in between as the policy enforcement layer. TSP provides trust across organizational boundaries.[^1]

The emerging pattern in production is: **A2A for the network layer, MCP for the resource layer.**[^13] An orchestrating agent uses A2A to discover and delegate to specialized agents. Those specialized agents use MCP to connect to the tools they need. The protocols compose rather than compete.

AgentMaster, in July 2025, was the first framework to use A2A and MCP together in production.[^13] By early 2026, this composition pattern is becoming standard. The question is no longer "MCP or A2A?" but "what sits between them to ensure the composition is governed?"

## The Authorization Gap

Shane's March 2026 post on Google's Workspace CLI exposes the structural problem:[^3]

> OAuth is possession-based. If you hold a valid token, you can act. There is no mechanism to verify *why* you are acting, *what task* you are acting on behalf of, or whether the action still aligns with what was originally consented to. The token is a key, not a contract.

Google's Workspace CLI gets the capability layer right: MCP support, skill files, structured output. But the authorization model underneath is built for apps, not agents. OAuth scopes are coarse by design. `gmail.readonly` grants access to every email in the mailbox: every sender, every thread, every attachment, going back to account creation. There is no scope for "emails from this sender, in the last five days, headers only."[^3]

Shane calls this **consent theater**: the user's mental model is "help me find that one email from last week." The token's actual scope is "read everything, for as long as the session lasts." The gap between what was intended and what was granted is where risk lives.[^3]

| You ask the agent to... | What you intended | What you granted |
|---|---|---|
| "Check my support inbox from last 3 days" | Emails from support customers, last 3 days | Every email, every sender, since account creation |
| "Reply to that customer thread" | One reply, to one thread | Send as you, to anyone, about anything |
| "Find the Q4 report in Drive" | One specific file | Read every file in your Drive |

This is not a fixable bug. Coarse scopes are intentional OAuth design. You cannot express conditional access without new protocols. The authorization model is the bottleneck keeping agents out of production, not the capability layer. The [Sandboxing and Execution Security](execution-security.md) chapter covers the containment side of this problem: what happens when an agent with broad credentials encounters untrusted input.[^3]

The responses to this gap are emerging at multiple layers:

- **AgentGateway** adds a policy layer that restricts which tools an agent can invoke and under what conditions. But it maps onto the same coarse OAuth scopes underneath.[^3]
- **Verifiable Intent** (covered in [Agent Identity and Delegation](agent-identity.md)) encodes purpose, constraints, and oversight into cryptographic credentials. The authorization decision is per-action, not per-session.[^15]
- **PIC** replaces proof of possession with proof of continuity, where delegated authority can only diminish, never expand (covered in [Cross-Organization Trust](cross-org-trust.md)).[^16]

The gap between "the agent can connect" (solved by MCP/A2A) and "the agent should connect" (unsolved by communication protocols alone) is the central tension of this chapter.

## Agent Gateways: The Enforcement Layer

Agent gateways are to agent traffic what API gateways were to microservices: a centralized control point for identity, permissions, policy, and observability. The pattern is familiar. The requirements are not.

AgentGateway, built by Solo.io in Rust and contributed to the Linux Foundation, is the leading open-source implementation.[^17] Shane includes it in his explainer architecture as the layer between agents and tools/other agents.[^1]

### What Agent Gateways Do

Traditional API gateways optimize for short-lived HTTP request-response cycles. Agent communication is different: long-lived sessions where requests and responses flow continuously, stateful protocol awareness for MCP's JSON-RPC model, and bidirectional, asynchronous messaging initiated by either side.[^17]

AgentGateway's key capabilities:

**MCP federation**: a single endpoint federates multiple backend MCP servers. Clients see one unified tool catalog instead of managing connections to dozens of individual servers. The gateway maps individual client sessions to permitted backend servers and handles bidirectional messaging.[^17]

**Policy authorization**: Cedar policies (Amazon's fine-grained authorization language) control access to MCP servers, tools, and agents. Policies are declarative, auditable, and separate from application code. This supports role-based access control (RBAC).[^17]

**Security protections**: JWT authentication, tool-poisoning detection, tool server fingerprinting and versioning, and protection against naming collisions and rug-pulls (a server changing tool behavior after initial registration).[^18]

**Observability**: built-in metrics and tracing for monitoring agent-tool interactions. This is governance-grade observability, not just debugging: who called what, when, with what authorization, and what was the result.[^17]

### The Limits of Gateways

Shane identifies AgentGateway's structural limitation:[^3] it operates at the tool level. It can say "this agent may call the Gmail API" or "this agent may not call the Calendar API." What it cannot yet express is: "this agent may read emails from support@customer.com but not from hr@company.com" or "this agent may send replies but only using approved templates."

The policies map onto the same coarse OAuth scopes underneath. AgentGateway is real progress: instead of "the agent has a token, therefore it can do anything the token allows," you get a policy layer that can restrict and audit tool access. But it is a governance layer on top of an authorization model that was not designed for agents. The deeper fix requires the shift from possession-based to proof-based authorization.[^3]

Gartner predicts that 75% of API gateway vendors will integrate MCP capabilities by the end of 2026.[^19] Early participation in AgentGateway's community meetings includes AWS, Microsoft, Red Hat, IBM, Cisco, and Shell.[^18] The pattern is converging fast. What remains unclear is whether these implementations will address the authorization gap or merely replicate it at a new layer.

## Trust Layer Integrations: TMCP and TA2A

The communication protocols (MCP, A2A) and the trust protocols (TSP, PIC) from [Cross-Organization Trust](cross-org-trust.md) are designed to compose. Shane's LFDT meetup post describes how this works in practice.[^16]

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

### WebMCP: Structured Tools in the Browser

WebMCP (Web Model Context Protocol) is a proposed web standard developed jointly by Google and Microsoft, incubated through the W3C's Web Machine Learning community group.[^webmcp] It shipped as an early preview in Chrome 146 Canary behind a feature flag. The premise: instead of agents scraping websites or clicking buttons through browser automation, websites expose structured, callable tools directly to in-browser AI agents.

WebMCP proposes two APIs:[^webmcp]

- **Declarative**: standard actions defined in HTML forms, exposing existing form elements as structured tools without JavaScript.
- **Imperative**: complex, dynamic interactions that require JavaScript execution, giving websites fine-grained control over what agents can do.

The trust implications are distinct from server-side MCP. WebMCP tools execute in the page's JavaScript context, sandboxed by the browser's existing security model: same-origin policy, Content Security Policy, permission APIs. This is architecturally different from MCP servers, which can run with full system access. The browser provides a containment boundary that MCP's protocol design does not.

But that containment cuts both ways. The browser sandbox constrains what a WebMCP tool can do (it cannot access the filesystem or arbitrary network resources). It does not constrain what the tool tells the agent. Tool poisoning, the attack where a tool description manipulates the agent's behavior, works the same way whether the tool runs in a browser tab or on a server. A malicious website could expose WebMCP tools designed to manipulate agent behavior rather than serve the user's intent.

The relationship to MCP is complementary, not competitive. WebMCP is not JSON-RPC. It does not follow the MCP specification. MCP operates as a backend protocol connecting AI platforms to hosted servers. WebMCP operates entirely client-side within the browser.[^webmcp] They address different parts of the tool discovery problem: MCP for services and APIs, WebMCP for web content and interactions. A full agent stack would use both.

The standard is transitioning from W3C community incubation to a formal draft, with formal browser announcements expected by mid-to-late 2026.[^webmcp] If adopted broadly, WebMCP turns every website into a potential tool provider for agents, which dramatically expands the tool discovery surface. The governance question is the same one this chapter keeps raising: discovery without trust is a liability. WebMCP tells the agent what tools a website offers. It does not tell the agent whether to trust the website offering them.

### AG-UI and A2UI: The Agent-User Layer

The protocol stack is also extending upward, toward the user.

AG-UI (Agent-User Interaction Protocol), created by CopilotKit and now compatible with Microsoft's Agent Framework, standardizes how agent backends stream events to frontend applications: messages, tool calls, state patches, and lifecycle signals over HTTP or binary channels.[^agui] Oracle, Google, and CopilotKit have jointly released integrations that standardize agent frontend connectivity.

A2UI (Agent-to-UI), an Apache 2.0 protocol created by Google with CopilotKit contributions, enables agents to generate rich, interactive UIs that render natively across web, mobile, and desktop without executing arbitrary code.[^a2ui]

AG-UI and A2UI formalize the boundary between agent reasoning and user oversight. The [Human-Agent Collaboration](human-agent-collaboration.md) chapter discusses oversight patterns: pre-action approval, confidence signals, escalation pathways. These two protocols provide the layer that makes those patterns implementable at scale: structured streaming from agent to UI, with standardized event types for tool calls that need approval, state changes that need visibility, and actions that need confirmation.

### The Protocol Stack

These protocols are more complementary than competitive. They layer:

| Layer | Protocol | Function |
|-------|----------|----------|
| Trust | TSP + PIC | Identity verification, authority continuity |
| Agent discovery | A2A | Agent-to-agent communication and collaboration |
| Tool discovery (backend) | MCP | Agent-to-tool connection and invocation |
| Tool discovery (browser) | WebMCP | Website-exposed structured tools for in-browser agents |
| Agent-user streaming | AG-UI | Real-time agent backend to frontend connectivity |
| Agent-driven UI | A2UI | Agent-generated interactive interfaces |
| Commerce | ACP + UCP + TAP | Payment flows, product discovery, and merchant trust |
| Authorization | Verifiable Intent | Cryptographic constraint encoding |
| Enforcement | AgentGateway | Policy, audit, and traffic management |

The stack has expanded from two core protocols (MCP + A2A) to six in under a year: MCP, A2A, WebMCP, AG-UI, A2UI, and the commerce protocols. Each addresses a distinct layer. Each introduces its own authentication model or inherits one from its transport layer. The critical observation remains: **no unified identity flows across all layers**.[^13] MCP has its own auth model (OAuth 2.1). A2A has its own auth scheme. WebMCP inherits the browser's origin-based security. AG-UI and A2UI rely on application-level authentication. The commerce protocols add their own credential requirements. TSP is designed to be the unifying identity layer underneath, but adoption is early. Until identity is unified across the stack, each protocol boundary is a potential trust gap.

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

Most organizations are at I1-I2: they have adopted MCP for tool connections but lack gateway mediation, trust layer integration, or unified identity. The 98.6 million monthly MCP downloads represent broad I2 adoption. The gap between I2 and I3 (adding governance to communication) is where most production deployment friction lives today.

## Practical Recommendations

**If you are just starting**: adopt MCP for tool connections. It is the standard. Every major provider supports it, it is under neutral governance (AAIF), and the ecosystem of servers, SDKs, and documentation is mature. Do not build custom tool integrations.

**If you are connecting agents to agents**: adopt A2A for agent discovery and collaboration. Use Agent Cards to describe capabilities. Start with JSON-RPC over HTTP; add gRPC when performance requires it. Require Agent Card signing in your deployments even though the spec does not enforce it.

**If you are deploying to production**: put an agent gateway between your agents and everything they connect to. AgentGateway is the leading open-source option. Use Cedar policies to restrict tool access by role, context, and task. Enable observability for every agent-tool interaction.

**If you are crossing organizational boundaries**: evaluate TMCP and TA2A for trust-layer integration. Standard MCP/A2A do not verify server identity or track delegation chains. For cross-org deployments, you need verifiable identifiers and authenticated channels that survive across trust boundaries.

**What to watch**: the MCP specification update (targeted June 2026) will address streamable HTTP transport, `.well-known` discovery, Tasks primitive refinements, and enterprise deployment needs (audit trails, SSO-integrated auth, gateway behavior). Beyond the core release, track the security SEPs: SEP-1932 (DPoP) and SEP-1933 (Workload Identity Federation) are already in progress and would close the gap between MCP's communication layer and the identity infrastructure this book argues is essential. WebMCP's progression from Chrome Canary to stable release and W3C formal draft will determine how quickly the browser becomes a first-class agent tool surface. The AAIF governance structure will shape how MCP, A2A, and agent gateways evolve together. And the authorization gap: the distance between what communication protocols can express ("connect to this tool") and what governance requires ("connect to this tool, for this purpose, under these constraints"): remains the most important unsolved problem in the stack.

[Agent Identity and Delegation](agent-identity.md) covers the identity infrastructure (OBO, DPoP, Verifiable Intent) that fills the authorization gap MCP and A2A leave open: communication protocols handle discovery and transport, identity protocols handle who agents are and what they are authorized to do. [Sandboxing and Execution Security](execution-security.md) provides the containment layer for what happens after an agent connects to a tool: filesystem isolation and network restrictions limit the blast radius of a compromised MCP server. [Agent Supply Chain Security](supply-chain-security.md) addresses the trust problem in the tool ecosystem itself: every MCP server is a dependency, and 38% of scanned servers lack authentication entirely. [Cross-Organization Trust](cross-org-trust.md) covers TSP and PIC, the trust layer that TMCP and TA2A run on top of when agent communication crosses organizational boundaries.

---

[^1]: Shane Deconinck, "Understanding MCP: Anthropic's Model Context Protocol Explained" and "Understanding A2A: Google's Agent-to-Agent Protocol Explained," shanedeconinck.be, January 2026.
[^2]: Anthropic, "Donating the Model Context Protocol and Establishing of the Agentic AI Foundation," anthropic.com, December 2025.
[^3]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," shanedeconinck.be, March 5, 2026.
[^4]: MCP Specification, modelcontextprotocol.io, November 2025. Required standards: OAuth 2.1 + PKCE, RFC 9728, RFC 8707, RFC 8414.
[^5]: "The 2026 MCP Roadmap," blog.modelcontextprotocol.io, 2026.
[^6]: "SEP-1649: MCP Server Cards," github.com/modelcontextprotocol, 2026.
[^7]: PyPI download statistics for the `mcp` package: pypistats.org/packages/mcp (98.6 million monthly downloads as of February 2026). Figure also cited in Anthropic, "Donating the Model Context Protocol and Establishing of the Agentic AI Foundation," anthropic.com, 2026.
[^8]: AuthZed, "A Timeline of Model Context Protocol (MCP) Security Breaches," authzed.com, 2025-2026.
[^9]: MCPTox benchmark results and Practical DevSecOps, "MCP Security Vulnerabilities," 2026.
[^10]: Google Cloud Blog, "Agent2Agent protocol (A2A) is getting an upgrade," cloud.google.com, 2026.
[^11]: A2A Protocol Specification v1.0, a2a-protocol.org, 2026.
[^a2a-v1]: A2A Protocol, "What's New in v1.0," a2a-protocol.org/latest/whats-new-v1/, 2026. Breaking changes from v0.3 include unified Part types, per-interface protocol versioning, cursor-based pagination, and google.rpc.Status error model.
[^12]: Google, A2A adoption statistics, 2026. 150+ participating organizations.
[^13]: Subhadip Mitra, "The Agent Protocol Stack: Why MCP + A2A + A2UI Is the TCP/IP Moment for Agentic AI," 2026. LangGraph v0.2 shipped January 15, 2026.
[^14]: Auth0, "Secure A2A Authentication with Auth0 and Google Cloud," auth0.com/blog/auth0-google-a2a/, 2026. Auth0 partnering with Google Cloud to define A2A authentication specifications and build SDKs showcasing A2A auth capabilities.
[^15]: Mastercard, "How Verifiable Intent builds trust in agentic AI commerce," mastercard.com, March 5, 2026. Standards-based framework co-developed with Google linking identity, intent, and action into a tamper-resistant record. Aligned with Google's AP2 and UCP protocols.
[^16]: Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," shanedeconinck.be, March 11, 2026.
[^17]: AgentGateway documentation, agentgateway.dev. Built in Rust, contributed to Linux Foundation by Solo.io.
[^18]: Solo.io, "Solo Enterprise for agentgateway," solo.io, 2026. Community participants include AWS, Microsoft, Red Hat, IBM, Cisco, Shell.
[^19]: Gartner, 2026 predictions: 75% of API gateway vendors will integrate MCP features by end of 2026; 40% of enterprise applications will embed autonomous AI agents. Gartner reports are paywalled; figure widely cited in industry coverage including K2View, "MCP Gartner insights," k2view.com, 2025.
[^20]: Stripe, "Developing an open standard for agentic commerce," stripe.com/blog/developing-an-open-standard-for-agentic-commerce, 2026. ACP specification at github.com/agentic-commerce-protocol. Apache 2.0 licensed. Powers Instant Checkout in ChatGPT.
[^21]: Google Developers Blog, Unified Commerce Protocol (UCP), 2026. Co-developed with Shopify and Walmart.
[^22]: Linux Foundation, "Linux Foundation Announces the Formation of the Agentic AI Foundation (AAIF)," linuxfoundation.org, December 9, 2025.
[^23]: PAC Framework, trustedagentic.ai, March 2026.
[^24]: Invariant Labs, WhatsApp MCP tool poisoning vulnerability, April 2025. Demonstrated cross-server exfiltration via malicious tool descriptions. Covered in Docker, "MCP Horror Stories: WhatsApp Data Exfiltration," docker.com.
[^25]: Nudge Security, "SaaS Security Alert: Asana MCP Server Data Exposure Incident," June 2025. Access control logic flaw exposed cross-organizational data.
[^26]: Oligo Security, CVE-2025-49596, July 2025. Missing authentication between MCP Inspector client and proxy enabled unauthenticated RCE and DNS rebinding attacks on developer workstations. Patched in version 0.14.1.
[^27]: Arctic Wolf, CVE-2026-27825, February 2026. Missing directory confinement in mcp-atlassian Confluence attachment downloads enabled path traversal, privilege escalation, and RCE. Fix released in version 0.17.0 on February 24, 2026.
[^28]: CVE-2026-30861, March 2026. Command injection in WeKnora MCP stdio configuration validation.
[^29]: Microsoft Security Update, CVE-2026-26118, March 10, 2026. SSRF in Azure MCP Server Tools enabling managed identity token theft and privilege escalation. CVSS 8.8.
[^30]: CVE categorization from kai_security_ai, "30 CVEs Later: How MCP's Attack Surface Expanded Into Three Distinct Layers," dev.to, March 2026. Individual CVEs are verifiable in NVD (nvd.nist.gov). The 38% unauthenticated figure comes from a separate scan of 518 servers in the official MCP registry by the same researcher: "I Scanned Every Server in the Official MCP Registry. Here's What I Found," dev.to, February 2026; initially reported as 41%, refined to 38% after excluding servers with schema-level access controls. Methodology described in post. Note: pseudonymous community research, not institutional.
[^a2a-t]: Huawei, "Huawei to Announce the Open Source Project of A2A-T Software," huawei.com, February 2026. Announced at MWC 2026 Global Autonomous Network Industry Summit, March 2, 2026. Based on TM Forum IG1453 (beta, February 6, 2026) and enhanced prompt meta-model IG1453A. Three open-source components: Protocol SDK, Registry Center, Orchestration Center.
[^unit42-sampling]: Palo Alto Networks Unit 42, "New Prompt Injection Attack Vectors Through MCP Sampling," unit42.paloaltonetworks.com, 2026. Demonstrates three proof-of-concept attacks exploiting MCP sampling's implicit trust model: resource theft via hidden instructions in sampling requests, conversation hijacking through persistent instruction injection, and prompt manipulation where servers modify prompts and responses while appearing normal. Defense requires request sanitization, response filtering, token limits by operation type, and explicit approval for tool execution.
[^protocol-threats]: Zeynab Anbiaee et al., "Security Threat Modeling for Emerging AI-Agent Protocols: A Comparative Analysis of MCP, A2A, Agora, and ANP," arXiv:2602.11327, February 2026. Identifies twelve protocol-level risks across authentication, supply chain, and operational integrity domains with qualitative risk assessment across protocol lifecycle phases.
[^webmcp]: "WebMCP is available for early preview," developer.chrome.com/blog/webmcp-epp, 2026. Developed jointly by Google and Microsoft, incubated through the W3C Web Machine Learning community group, shipped in Chrome 146 Canary behind a feature flag. Two APIs: declarative (HTML forms) and imperative (JavaScript). See also VentureBeat, "Google Chrome ships WebMCP in early preview, turning every website into a structured tool for AI agents," March 2026.
[^agui]: CopilotKit, "AG-UI: the Agent-User Interaction Protocol," ag-ui.com, 2026. Open, lightweight, event-based protocol for streaming agent events to frontend applications. Now compatible with Microsoft Agent Framework, Oracle, and Google integrations.
[^a2ui]: Google, "A2UI: Agent-to-UI Protocol," a2ui.org, 2026. Apache 2.0 licensed protocol for agent-generated interactive UIs across web, mobile, and desktop. Created by Google with CopilotKit contributions.
[^overthinking-loops]: Yohan Lee et al., "Overthinking Loops in Agents: A Structural Risk via MCP Tools," arXiv:2602.14798, February 2026. Demonstrates that 14 malicious tools across three servers can induce cyclic overthinking loops in MCP-based agents, amplifying token consumption up to 142.4x. The attack exploits standard MCP interfaces: no protocol violation required. Experiments restricted to open-source models for responsible disclosure.
[^xaa-mcp]: Okta, "Cross App Access extends MCP to bring enterprise-grade security to AI agent interactions," okta.com, 2026. XAA incorporated into MCP specification as "Enterprise-Managed Authorization" extension. Built on IETF Identity Assertion JWT Authorization Grant (ID-JAG) draft. See also [Agent Identity and Delegation](agent-identity.md) for full coverage of the XAA protocol.
[^mcp-dpop]: SEP-1932, "DPoP for MCP," github.com/modelcontextprotocol/modelcontextprotocol/pull/1932. Brings RFC 9449 DPoP token binding to MCP connections. Listed as sponsored work on the 2026 MCP Roadmap (updated March 5, 2026).
[^mcp-wif]: SEP-1933, "Workload Identity Federation for MCP," github.com/modelcontextprotocol/modelcontextprotocol/pull/1933. Enables agents to authenticate using platform-issued workload identities instead of static secrets. Listed as sponsored work on the 2026 MCP Roadmap (updated March 5, 2026).
