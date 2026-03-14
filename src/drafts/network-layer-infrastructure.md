# Network-Layer Agent Infrastructure

An agent calls a Gmail tool. The request travels across the enterprise network. Every firewall, proxy, and SASE platform along the path sees: HTTPS to port 443. No tool name. No MCP message content. No delegation chain. No indication that an AI system is operating autonomously rather than a human clicking a browser. The infrastructure that enforces security policy for every other type of traffic is blind to agent traffic.

This is the enforcement gap. Agent protocols (MCP, A2A) operate at the application layer. Enterprise security operates at the network layer. These two perspectives were built by different communities, for different threat models, and they do not yet speak the same language. The result: organizations can deploy sophisticated application-layer agent gateways while their network layer remains oblivious to the agent traffic passing through it.

That gap is beginning to close. This chapter covers the infrastructure emerging at the layer below agent protocols: network-layer enforcement that understands agent traffic, naming systems that govern how agents discover tools, and routing systems that understand semantic intent rather than destination IPs.

## The Two-Layer Problem

The application-layer approach to agent security, covered in [Agent Communication Protocols](agent-communication.md), is mature and accelerating. AgentGateway (Solo.io/Linux Foundation) federates MCP servers, enforces Cedar policies, and provides governance-grade observability for agent-tool interactions. Microsoft's MCP Gateway adds session-aware stateful routing in Kubernetes. Traefik Hub adds centralized auth, rate limiting, and logging per tool invocation. Lasso performs deep packet inspection on MCP traffic to detect prompt injection and sensitive data exposure.[^agentgateway-dev][^microsoft-mcp-gw][^traefik-hub][^lasso-mcp]

All of these operate at Layer 7: they understand the application protocol, inspect message content, and enforce policies on individual tool calls. They are inside the agent runtime, or adjacent to it.

The network layer (Layers 3-4) sees none of this. Traditional security infrastructure — SASE platforms, next-generation firewalls, DLP proxies, network detection and response systems — classifies traffic by IP, port, protocol, and TLS SNI. An MCP session over HTTPS looks identical to a human browsing a web application. The tool calls inside the TLS tunnel are invisible.

This creates a structural gap in enterprise security coverage. When an agent invokes a tool, two enforcement points exist:

1. **Application layer**: the gateway, if one is deployed, enforces policy on the tool call itself — what tool, what parameters, under what authorization.
2. **Network layer**: the SASE or firewall enforces policy on the IP connection — destination allowed, traffic volume within baseline, TLS certificate valid.

Neither layer alone is sufficient. The application-layer gateway can be bypassed if agents are deployed without one. The network layer cannot enforce what it cannot see. Defense-in-depth for agent traffic requires both layers to understand agent semantics.

## What the Network Layer Can Now See

Cisco's AI-Aware SASE, announced in February 2026 as the largest expansion of its AI Defense platform since its January 2025 launch, is the first major evidence that the network-security industry is addressing this gap.[^cisco-sase-2026]

Four capabilities are relevant:

**MCP Visibility and Policy Control.** Cisco's AI-Aware SASE can now discover and govern MCP communications with in-path controls and inspection outcomes, managing agent-to-tool connectivity at the network layer. An agent connecting to a Gmail MCP server is no longer just HTTPS traffic: the SASE platform can see the protocol, identify the tool, and apply policy to the connection.

**Intent-Aware Inspection.** The platform combines rapid detection with cloud-based analysis to evaluate the intent behind agentic messages and actions. This is a materially different capability than signature-based inspection: instead of matching known-bad patterns, it reasons about what the agent is attempting to do. A request to read emails is different from a request to delete emails, even if both use the same API endpoint and OAuth scope.

**AI Bill of Materials and MCP Catalog.** The platform provides centralized visibility and governance for MCP servers and third-party dependencies. An AI BOM at the network layer means the security team can inventory which MCP servers agents are connecting to, assess their supply chain risk, and enforce allowlists — independent of how the application layer is configured. The MCP Catalog discovers and manages risk across MCP servers on both public and private platforms.[^cisco-sase-2026]

**AI Traffic Optimization.** The platform detects AI traffic and applies packet duplication techniques to maintain reliable, low-latency interactions during agentic workload bursts. Agent traffic has different characteristics than human web traffic: bursty, latency-sensitive, and often long-lived. Network infrastructure that cannot distinguish AI traffic from browser traffic cannot optimize for it.

The significance of Cisco's approach is architectural, not just commercial. When the leading network security platform adds MCP-specific controls, the application-layer protocol and the network-layer enforcement plane are no longer separate stacks. The separation that characterized agent security in 2025 — application developers building gateways, network teams enforcing generic HTTPS policies — is beginning to collapse. Whether other SASE vendors (Zscaler, Palo Alto Prisma) follow with similar capabilities in 2026 will determine whether this is a product feature or an architectural shift.

## Naming and Discovery Below the Application Layer

The [Agent Communication Protocols](agent-communication.md) chapter covers the discovery problem at the application layer: how agents find tools (MCP server URLs) and other agents (A2A Agent Cards). Both protocols rely on some form of known endpoint or out-of-band configuration. Neither provides a generalized naming system.

AgentDNS (draft-liang-agentdns-00), an active IETF Internet-Draft, proposes a root-domain naming system for LLM agents.[^agentdns-draft] The draft defines a unified namespace with the format:

```
agentdns://{organization}/{category}/{name}
```

Service discovery in AgentDNS uses natural-language queries processed by a root server using retrieval-augmented generation: an agent queries "find a tool that can search recent academic papers" and receives a resolved endpoint. A single authentication with AgentDNS replaces per-vendor registration, and the system is designed to be compatible with both MCP and A2A.

The governance implication: a root-domain naming system for agents creates a layer where discovery itself can be governed. Today, an agent discovers MCP servers through environment variables, hardcoded URLs, or MCP registries that each vendor maintains independently. AgentDNS would centralize this discovery — which also means centralizing the ability to revoke discovery for a compromised or deregistered server.

This connects directly to supply chain security. A malicious MCP server in the SANDWORM_MODE campaign (19 typosquatting npm packages documented in [Agent Supply Chain Security](supply-chain-security.md)) achieved reach by being installable and discoverable through package registries.[^sandworm-mode] A governance layer at the naming level — where discovering a server requires a verifiable identity claim — raises the bar for these attacks.

AgentDNS is an early-stage draft (filed with an expiry of April 12, 2026, indicating first-draft status). Its operational characteristics — governance of the root server, conflict resolution for namespace collisions, key rotation — are not yet specified. The proposal names a problem that is real. The solution has not yet been stress-tested.

## Semantic Routing

Conventional routing sends packets based on destination: IP address, port, protocol. Agent traffic has a property that conventional routing ignores: semantic intent. A request to summarize documents and a request to delete documents may be directed to the same endpoint, carry the same authorization header, and be indistinguishable at the network layer — but they have different risk profiles.

Two IETF drafts propose infrastructure to address this.

**SIRP** (Semantic Inference Routing Protocol, draft-chen-nmrg-semantic-inference-routing-00) was authored by H. Chen (Red Hat) and L. Jalil (Verizon) and proposes model-agnostic, content-driven classification and routing before backend invocation.[^sirp-draft] Rather than routing based on client metadata, SIRP routes based on the content of the request itself. The draft defines standardized header signaling for semantic routing decisions and a pluggable pipeline of Value-Added Routing (VAR) modules: cost optimization, urgency prioritization, domain specialization, privacy-aware handling. A request marked by SIRP as a destructive operation can be routed to a different enforcement path than a read-only request, even when both are directed to the same tool.

**Agent Communication Gateway** (draft-agent-gw-01) is a broader proposal for large-scale, heterogeneous, multi-agent collaboration across administrative and protocol boundaries.[^agent-gw-draft] Its core functions: semantic routing (dispatching tasks by agent capability), working memory (shared structured context across multi-step workflows), and automated protocol adaptation (normalizing heterogeneous interfaces into a unified agent-facing protocol). The draft explicitly integrates MCP and A2A: Agent-to-External-Resource-Service communication uses MCP, while agent-to-agent coordination uses A2A or deployment-specific interfaces.

Neither SIRP nor Agent-GW is a deployed standard. Both are -00 and -01 drafts, meaning they represent first or second proposals undergoing IETF review. The infrastructure they describe — semantic classification at routing time, shared working memory, intent-aware traffic handling — does not exist in production at scale as of March 2026.

What they signal: the network layer is beginning to treat agent semantics as a first-class routing concern. The separation between "what the agent is trying to do" (application-layer knowledge) and "how the traffic is routed" (network-layer decision) is the target these drafts are trying to collapse.

## Service Mesh: Community Projects, Not Standards

Service meshes (Istio, Envoy, Linkerd) provide the control plane for microservice traffic: mTLS between services, traffic shaping, circuit breaking, observability. They operate at Layer 7 within Kubernetes clusters and are the infrastructure most enterprises use to govern service-to-service communication.

As of March 2026, there is no native MCP or A2A awareness in Istio or Envoy core. The separation between microservice governance (service mesh) and agent governance (application-layer gateways) is complete. A community-maintained Istio MCP Server provides read-only MCP access to Istio service mesh resources — AI assistants can query Virtual Service configurations through an MCP interface — but this is an integration going the other direction: it makes the service mesh *queryable* by agents, not MCP-aware in its traffic enforcement.[^istio-mcp-server]

The open question from the gaps chapter is whether agent gateways and service meshes converge. The evidence so far: they have not. Agent gateways (AgentGateway, Traefik Hub, Microsoft MCP Gateway) are deployed alongside service meshes, not integrated with them. The observability planes do not connect. The policy models do not share primitives. An enterprise running both Istio and AgentGateway has two separate governance layers for two types of service traffic, without a unified view.

Cisco AI-Aware SASE operating at the network layer may represent the convergence point the service mesh question was pointing toward — not merging gateways with meshes, but adding a network-layer enforcement plane that sits above both.

## The Composition Architecture

The architecture question for enterprise agent security is not "gateway or SASE?" The answer is both, for different threat models.

**Application-layer gateways** address the trust gap inside the agent runtime: which tools an agent can invoke, under what authorization, with what observability. They enforce policy on the content of MCP messages. Their limitation is deployment: agents that bypass the gateway — whether through misconfiguration, shadow deployment, or local execution — bypass the controls entirely. Shane's analysis of the Google Workspace CLI identifies the structural problem: local tools have no natural enforcement point, and even remote MCP servers can be accessed without going through a gateway if the agent is not configured to use one.[^google-workspace-blog]

**Network-layer enforcement** (SASE, proxies) addresses the connectivity gap: which services agents can reach, under what conditions, with what inspection. It cannot enforce what gateways enforce (the content and authorization of individual tool calls) but it operates for all traffic, regardless of how the agent runtime is configured. An agent that bypasses the application-layer gateway cannot bypass the SASE platform if the platform sits in the egress path.

The composition:

| Layer | What it enforces | What it cannot enforce |
|---|---|---|
| Application gateway | Tool-call authorization, content filtering, Cedar policies | Traffic that bypasses the gateway |
| Network SASE | Connectivity, destination allowlists, intent inspection | Tool-call authorization details inside TLS |
| Both composed | Enforcement without deployment gaps | — |

That convergence matters because enterprise security teams operate the network layer and security buyers fund the network layer. Agent security that exists only at the application layer must be funded and operated by the development teams building agents. Agent security at the network layer becomes part of the existing enterprise security stack.

The practical implication for architects: design both layers. Gateway at the application layer for authorization semantics. SASE or equivalent at the network layer for connectivity enforcement and intent inspection. The audit trails from both layers do not yet compose — Cisco AI-Aware SASE and AgentGateway have separate observability planes — but they should. A correlated view of "what the gateway authorized" and "what the network layer saw" is the observability architecture the [Agent Observability](agent-observability.md) chapter calls for at Layer 4 of the five-layer stack.

## Mapping to PAC

**Potential.** Agent infrastructure at the network layer enables what application-layer-only deployments cannot provide: reliable, optimized, and governed agent traffic at enterprise scale. Cisco's AI traffic optimization addresses the operational reality that agentic workloads have different traffic characteristics than human browsing: bursty, latency-sensitive, long-lived sessions. Network infrastructure that cannot distinguish and optimize for AI traffic introduces unpredictable performance degradation during workload spikes. The standard-setting activity (AgentDNS, SIRP) represents a bet on Potential: that the agent ecosystem is worth investing in dedicated naming and routing infrastructure.

**Accountability.** Intent-aware inspection at the network layer creates audit records that exist independent of application-layer configuration. If an application-layer gateway is misconfigured or bypassed, the network layer can still record what the agent connected to and what intent was inferred. The AI BOM and MCP Catalog capabilities provide an inventory of tool dependencies at a layer that developers cannot easily tamper with. Both properties support the traceability claims PAC's Accountability pillar requires.

**Control.** Network-layer enforcement gives security teams a control point that does not depend on developer adoption of application-layer gateways. An enterprise that mandates SASE egress controls can enforce agent traffic policies through standard network security operations, without requiring each development team to deploy and configure AgentGateway. This is "infrastructure in the loop" applied at the network layer: the control does not depend on the agent's cooperation.

The limitation: network-layer control is coarser than application-layer control. SASE can allow or deny an agent's connection to a Gmail MCP server. It cannot authorize a specific tool call within that connection. Fine-grained authorization (per-action, per-parameter, per-task) remains application-layer work. The PAC Control pillar's "can't" architecture requires both layers to compose.

## Infrastructure Maturity for Network-Layer Agent Infrastructure

| Level | State | Characteristics |
|---|---|---|
| **I1** Basic | No network visibility | Agent traffic indistinguishable from web traffic. All enforcement at application layer or none. Network team has no visibility into agent activity. |
| **I2** Monitored | Traffic logging | Agent traffic classified by TLS SNI or endpoint. Network logs record which MCP server domains agents connect to. No semantic inspection. No policy enforcement beyond destination allowlists. |
| **I3** Enforced | Protocol-aware inspection | SASE or proxy with MCP protocol awareness. Destination allowlists enforced at network layer. Basic intent inspection on outbound connections. AI BOM or equivalent inventories active MCP servers. |
| **I4** Governed | Semantic routing and naming | AgentDNS integration for tool discovery governance. SIRP or equivalent semantic routing active. Intent-aware inspection provides audit records correlated with application-layer gateway logs. Supply chain verification at naming layer. |
| **I5** Composed | Full defense-in-depth | Application-layer gateways and network-layer enforcement share policy models and audit trails. Semantic routing enforces PAC policies across both layers. Shadow agent detection at network layer. Network-layer revocation integrates with agent lifecycle management. |

Most organizations are at I1-I2 as of early 2026. The infrastructure for I3 exists (Cisco AI-Aware SASE, MCP-aware proxies). I4 requires IETF drafts (AgentDNS, SIRP) to mature to implementation. I5 requires both application and network observability planes to integrate — work that has not yet been built.

## What to Do Now

**Add agent traffic classification to your network visibility layer.** At minimum, your SASE or proxy logs should distinguish agent traffic from browser traffic. MCP sessions to known tool endpoints, A2A connections to agent registries, and long-lived JSON-RPC sessions have identifiable characteristics. Classifying them is the prerequisite for governing them.

**Enforce destination allowlists at the network layer.** Application-layer gateway coverage is incomplete by design: shadow agents and developer tools bypass it. A network-layer allowlist of permitted MCP server domains operates independently of application-layer configuration. Any agent connecting to an unknown MCP endpoint fails the network-layer check before reaching any application-layer policy.

**Evaluate MCP-aware SASE if you are deploying at scale.** Cisco AI-Aware SASE is the first production product with MCP visibility and intent-aware inspection. Evaluate whether its AI BOM, MCP Catalog, and intent inspection capabilities address your threat model. The product is February 2026 vintage; operational characteristics at enterprise scale are not yet well-documented.

**Track the IETF drafts but do not build on them yet.** AgentDNS, SIRP, and Agent-GW are -00 and -01 drafts with expiry dates in April 2026. They define real problems and plausible directions. Their operational security characteristics — governance of root servers, key management, namespace arbitration — are not yet specified. Watch, contribute if you can, do not architect around them as stable standards.

**Design observability to correlate both layers.** The application-layer gateway knows what tool call was made and whether it was authorized. The network layer knows what connection was made and what intent was inferred. A correlated audit trail is what the Accountability pillar requires. The two planes do not currently integrate; design your observability architecture for the integration you will need, even if you implement it in phases.

---

[^agentgateway-dev]: AgentGateway documentation, agentgateway.dev. Built in Rust by Solo.io, contributed to the Linux Foundation.
[^microsoft-mcp-gw]: Microsoft, "MCP Gateway," github.com/microsoft/mcp-gateway, 2026. Reverse proxy for MCP servers with session-aware stateful routing in Kubernetes.
[^traefik-hub]: Traefik Hub, "MCP Gateway Best Practices," doc.traefik.io/traefik-hub/mcp-gateway/guides/mcp-gateway-best-practices, 2026.
[^lasso-mcp]: Lasso Security, "Security for Agentic AI: Unveiling MCP Gateway and MCP Risk Assessment," prompt.security/blog, 2026.
[^cisco-sase-2026]: Cisco, "Cisco Redefines Security for the Agentic Era with AI Defense Expansion and AI-Aware SASE," newsroom.cisco.com, February 2026. Described as the largest expansion of Cisco AI Defense since its January 2025 launch.
[^agentdns-draft]: Liang et al., "AgentDNS: A Root Domain Naming System for LLM Agents," draft-liang-agentdns-00, datatracker.ietf.org. Filed 2026; expires April 12, 2026.
[^sandworm-mode]: SnailSploit, "MCP vs A2A Attack Surface: Every Trust Boundary Mapped," snailsploit.com, March 2026. Documents SANDWORM_MODE: 19 typosquatting npm packages targeting MCP server infrastructure.
[^sirp-draft]: H. Chen (Red Hat), L. Jalil (Verizon), "Semantic Inference Routing Protocol (SIRP)," draft-chen-nmrg-semantic-inference-routing-00, datatracker.ietf.org. Filed 2026; expires April 3, 2026.
[^agent-gw-draft]: "Agent Communication Gateway for Semantic Routing and Working Memory," draft-agent-gw-01, datatracker.ietf.org, 2026.
[^istio-mcp-server]: krutsko, "istio-mcp-server," github.com/krutsko/istio-mcp-server, 2026. Community project, not an official Istio or CNCF project. Provides read-only MCP access to Istio service mesh resources for AI assistants.
[^google-workspace-blog]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," shanedeconinck.be, March 5, 2026.
