# Agent Identity and Delegation

Every time an agent calls an API, sends a message, or makes a purchase, something needs to answer: who authorized this? Traditional identity systems were not built for that question. The standards landing now are.

## The Trust Inversion

Shane's framing: humans are restricted in what they can't do, agents must be restricted to what they can.[^1]

In organizations, humans operate within broad boundaries. You trust employees with judgment, then add guardrails for specific risks: compliance training, approval workflows, separation of duties. The default is trust. Restrictions are exceptions.

Agents need the inverse. The default should be zero authority. Every capability must be explicitly granted, scoped to the task, time-bounded, and revocable. Not because agents are malicious, but because they have no judgment about whether an action is appropriate. An agent that can read all your email will read all your email if any part of its task touches email. It does not think "that seems excessive." It does what its credentials allow.

Teleport's 2026 State of AI in Enterprise Infrastructure Security report quantifies this. Organizations that grant AI systems excessive permissions experience 4.5x more security incidents than those enforcing least-privilege: a 76% incident rate versus 17%.[^teleport] The finding that matters most: access scope, not AI sophistication, was the strongest predictor of outcomes. It does not matter how capable or well-designed the agent is. If its credentials are broader than its task requires, incidents follow. And 70% of organizations report granting AI systems higher levels of privileged access than humans would receive for the same task.

Policy says "agents should only access what they need." Architecture must say "agents can only access what they need." The gap between those two statements is where incidents happen.

## Why Traditional IAM Breaks Down

### The Identity Stack We Inherited

Authentication and authorization for software evolved through several eras, each solving a real problem:[^2]

**Directory services (LDAP, 1993)** solved "where do I look up who this person is?" Centralized identity stores that every application could query.

**Single sign-on (Kerberos, 1988; SAML, 2005)** solved "how do I prove I'm the same person across systems?" Ticket-based and assertion-based protocols that let users authenticate once.

**Delegated authorization (OAuth, 2007)** solved "how do I let a third-party app access my data without giving it my password?" The user grants scoped access, the app gets a token.

**Federated identity (OIDC, 2014)** solved "how do I prove who I am to a new service?" Built identity (ID Tokens, JWTs) on top of OAuth's authorization layer.

**Workload identity (SPIFFE, 2017; WIMSE, 2023)** solved "how do I authenticate software to software?" Attestation-based identity for services, not people. (WIMSE is now being extended for agents specifically: see the WIMSE section later in this chapter.)

**Decentralized identity (DIDs, 2019; VCs, 2019)** solved "how do I prove claims about myself without relying on a central authority?" Cryptographic credentials the holder controls.

Every layer was a response to a real limitation of the previous one. Most were not designed for an entity that receives a goal and decides how to accomplish it. They assume either a human making decisions or software executing predetermined logic. The standards community is now adapting several of these layers for agents: OAuth extensions, WIMSE, SCIM, and DIDs are all being reworked.

### Where OAuth Falls Short

OAuth is the backbone of modern API authorization, and its limitations with agents are instructive.

OAuth is possession-based. If you have a valid token, you can act. This was fine when a human initiated every session and the token lived for minutes. With agents, the token might live for months (via refresh tokens), the human is long gone, and the agent is making autonomous decisions about which scopes to exercise.

Shane's example of Google Workspace illustrates the gap precisely: a user intends "help me find one email from last week" but the OAuth scope grants `gmail.readonly`, which means access to every email since account creation. The user's mental model of what they authorized and what the agent can actually do diverge wildly. Shane calls this consent theater.[^3]

The problems compound with agents:

**Scope granularity.** OAuth scopes are coarse by design. `repo` on GitHub means full access to every repository. You cannot express "read this one file in this one repo for the next ten minutes" with standard scopes.

**No purpose encoding.** A token says what the bearer can access, not why. Two agents with identical tokens, one summarizing emails and one exfiltrating data, look the same to the authorization server.

**No delegation tracking.** When Agent A calls Agent B, the original user's token gets forwarded or exchanged, but the chain of who decided what is lost. OAuth was not designed to track multi-hop agent delegation.

**Session assumptions.** OAuth flows assume interactive users who can respond to consent screens. Agents operate autonomously, often for extended periods. The "human in the loop" that OAuth relies on is simply not there.

### The Agentic Gap

Shane identified this gap: an agent usually acts on behalf of a user but creates its own intent. It is neither a human (who would use interactive OAuth) nor a traditional service (which would use Client Credentials). It is something new: a delegated entity with decision-making capability.[^2]

The numbers confirm how wide this gap is. According to the Gravitee State of AI Agent Security 2026 survey (900+ respondents): only 21.9% of teams treat AI agents as independent, identity-bearing entities. 45.6% still rely on shared API keys for agent-to-agent authentication. And 27.2% have reverted to custom, hardcoded authorization logic because existing tools do not fit the agent model.[^gravitee] A second independent survey by the Cloud Security Alliance and Strata Identity (285 IT and security professionals) corroborates the same picture: 44% use static API keys, 43% use username and password combinations, and 35% rely on shared service accounts for agent authentication. Only 18% say they are "highly confident" their current IAM systems can manage agent identities effectively.[^csa-strata-auth] Two independent surveys, different respondent pools, same finding: nearly half of organizations are authenticating agents the same way they authenticated batch scripts in 2005.

## OAuth Extensions for Agents

The first wave of solutions extends OAuth to handle agent-specific patterns.

### On-Behalf-Of (RFC 8693)

OAuth 2.0 Token Exchange (RFC 8693) enables an entity to exchange one token for another, explicitly tracking the delegation. The resulting token encodes two identities: the user (the resource owner who delegated) and the agent (the acting party).[^4] This preserves the delegation chain. When Agent A uses OBO to get a token for calling Service X, the token says: "User Alice authorized Agent A to act on her behalf, with these specific scopes." If Agent A then delegates to Agent B, a second exchange can capture that hop too.

In practice, the token request includes:

- A `subject_token` representing the human user
- An `actor_token` authenticating the agent
- The requested scope for the downstream operation

The IETF has a draft specifically for AI agents: "OAuth 2.0 Extension: On-Behalf-Of User Authorization for AI Agents" (draft-oauth-ai-agents-on-behalf-of-user), which introduces a `requested_actor` parameter in authorization requests to identify the specific agent requiring delegation.[^5]

But OBO alone does not solve purpose encoding or constraint enforcement. The token says who delegated and who acts, but not what the user actually intended.

### Agent Authorization Profile (AAP)

The Agent Authorization Profile (draft-aap-oauth-profile, February 2026) addresses this gap. AAP extends OAuth 2.0 and JWT with structured claims that encode what OBO leaves out: task context, operational constraints, delegation depth, and human oversight requirements.[^aap]

The key addition is structured capabilities rather than flat scopes. Where a standard OAuth scope says "write:email," an AAP capability claim specifies: write email, to these recipients, for this task, within this time window, in this network zone, with these rate limits. The `context` claim binds tokens to specific operational constraints (network zones, time windows, geographic restrictions) that resource servers validate at runtime.

For delegation chains, AAP uses token exchange with mandatory privilege reduction: each delegation hop produces a new token with a subset of the parent's capabilities, tracked through parent-token linkage. Delegation depth is explicit in the token, not implicit in a chain of trust relationships.

The `oversight.requires_human_approval_for` claim embeds human oversight requirements into the authorization token. Instead of the agent deciding when to ask for approval (which the [Human-Agent Collaboration](human-agent-collaboration.md) chapter shows agents resist), the token itself declares which actions require human sign-off. The resource server enforces this, not the agent. The agent cannot bypass oversight requirements because they are encoded in the credential, not in the agent's instructions.

A complementary draft from China Mobile (draft-chen-agent-decoupled-authorization-model, February 2026) takes a different angle: it decouples authorization decisions from business logic through separate Authorization Decision and Execution Points, enabling just-in-time permissions based on specific agent intent rather than static role assignments.[^decoupled-auth] Where AAP enriches the token, the Decoupled model restructures the authorization architecture itself.

Both drafts are individual submissions, not IETF-endorsed standards. But together with the AI Agent Authentication draft (draft-klrc-aiagent-auth), the On-Behalf-Of extension, the Transaction Tokens for Agents extension (below), and AAuth (below), they represent a dozen or more concurrent IETF efforts specifically targeting agent identity and authorization in Q1 2026 alone, including extensions for workload identity (WIMSE), lifecycle provisioning (SCIM), selective disclosure (SD-JWT for agents), and agent identity requirements. The standards ecosystem is responding to the same gap the products are: agents need richer authorization than OAuth was built to provide.

### Rich Authorization Requests (RFC 9396)

The scope granularity problem identified earlier has a published standard solution. Rich Authorization Requests (RAR, RFC 9396) replaces coarse OAuth scopes with structured JSON objects in the `authorization_details` parameter. Where a scope says `repo`, a RAR request specifies: this repository, read-only access, to files under this path, tagged with these attributes, for the next ten days.[^rar]

The difference is structural. Scopes are flat strings negotiated at registration time. RAR objects carry typed fields: `locations` (the resources), `actions` (what the client may do), `datatypes` (what information is requested), `identifier` (which specific resource), and `privileges` (what level of access). Authorization servers evaluate these fields against policy at request time, not at client registration.

For agents, RAR solves the gap between what a user intends and what a token permits. The MCP specification is already feeling this: issue #1670 in the MCP repository requests RAR support specifically because traditional scopes cannot express authorization constraints like "assume role X, access files under directory Y tagged with Z, for N days."[^mcp-rar] That request describes the kind of fine-grained, context-dependent authorization that agents operating within MCP need and that flat scopes cannot carry.

RAR is complementary to AAP. AAP adds agent-specific claims (task context, delegation depth, human oversight requirements) to the token itself. RAR structures the authorization request: it is how the agent asks for the access it needs, rather than accepting whatever pre-defined scopes are available. An agent using both sends a structured RAR request to the authorization server, receives a token with AAP claims encoding the granted constraints, and the resource server enforces both.

### Transaction Tokens for Agents

OBO tracks who delegated. AAP encodes what was authorized. But neither solves a practical problem in distributed architectures: how does agent identity propagate through a chain of backend services without forwarding the original access token?

Transaction Tokens for Agents (draft-oauth-transaction-tokens-for-agents, January 2026, now at version 03) extends the OAuth Transaction Tokens framework (draft-ietf-oauth-transaction-tokens) with two new claims: `actor` (the agent performing the action) and `principal` (the human or system that initiated the agent's action).[^txn-tokens-agents]

The mechanism works like this: when an agent calls Service A, the first service exchanges the agent's access token for a Transaction Token (Txn-Token) at a dedicated Txn-Token Service. The Txn-Token is a short-lived, signed JWT that carries immutable actor and principal context. Service A then passes the Txn-Token (not the access token) to Service B, which passes it to Service C. At every hop, each service can verify who the agent is and who it acts for, but no service ever holds the original access token. If the Txn-Token needs replacement (for scope changes at a boundary), the Txn-Token Service issues a new one, but the actor and principal claims remain immutable: they cannot be altered through the chain.

First, credential containment: forwarding access tokens through a call chain exposes the token at every hop. Txn-Tokens replace the token with a verifiable identity assertion that carries no authorization power beyond the current transaction. Second, auditability: every service in the chain can log the actor and principal from the Txn-Token, producing a complete trace of which agent acted on behalf of which principal at each service boundary.

A companion draft, the A2A Profile for OAuth Transaction Tokens (draft-liu-oauth-a2a-profile), applies this pattern specifically to agent-to-agent scenarios where agents need to propagate delegation context across A2A protocol interactions.[^txn-tokens-a2a]

OBO establishes the delegation. AAP encodes the constraints. Transaction Tokens ensure that delegation context flows through the entire execution chain without credential leakage or identity loss.

### AAuth: Agent Authorization Through Non-Web Channels

The drafts above assume agents interact through web-based OAuth flows. AAuth (Agentic Authorization, draft-rosenberg-oauth-aauth, now at version 01) addresses a different deployment reality: agents that interact with users through voice calls, SMS, or messaging channels where traditional OAuth redirect flows are impossible.[^aauth]

AAuth defines an Agent Authorization Grant inspired by the OAuth Device Authorization Grant (RFC 8628). The agent collects identity information through natural-language conversation, then obtains a scoped access token through HTTP polling, Server-Sent Events, or WebSocket. The key security contribution is its treatment of LLM hallucination as an impersonation vector. The draft explicitly addresses the risk that an LLM could hallucinate or confuse identity information gathered during conversation, potentially obtaining tokens for the wrong user. The mitigations require out-of-band identity verification: the authorization server sends a confirmation challenge through a separate channel (SMS code, email link) that the LLM cannot fabricate.

AAuth identifies a threat class none of the other chapters address: the LLM itself, through hallucination rather than prompt injection, can become the confused deputy. The failure mode is internal: the model's own tendency to confuse or fabricate information during multi-turn conversations produces incorrect identity claims. The fix is architectural, not prompt-level: the authorization server never trusts identity information that passed through the LLM without independent verification.

### DPoP (Demonstration of Proof-of-Possession)

DPoP (RFC 9449) binds tokens to cryptographic keys. Instead of bearer tokens that anyone holding them can use, DPoP tokens require the presenter to prove they hold the private key the token was bound to.[^6]

For agents, stolen tokens become useless. If an agent's token is exfiltrated (through a compromised tool, a prompt injection attack, or a misconfigured logging pipeline), the attacker cannot use it without the agent's private key.

DPoP is complementary to OBO: use OBO to track delegation, use DPoP to prevent token theft.

### Cross App Access and Identity Assertion Grants

OBO and DPoP solve delegation tracking and token binding. But both assume the agent is operating within a system where it already has a relationship with the authorization server. The harder problem: how does an agent connect to a new application it has never interacted with, without forcing a human through an OAuth consent screen?

The Identity Assertion JWT Authorization Grant (ID-JAG), an IETF draft Okta has been contributing to with public and industry collaborators, addresses this. Instead of interactive consent, the enterprise identity provider issues a signed identity assertion: a short-lived, scoped JWT that cryptographically represents both the user and the requesting agent. The agent presents this assertion to the target application's authorization server to obtain an access token. No consent screen. No popup. No human in the loop at the moment of connection.[^xaa]

Instead of applications establishing direct trust with each other (the OAuth model), the enterprise IdP mediates every connection. IT and security teams pre-approve which agent-to-application integrations are allowed through policy, and the IdP issues tokens only when policy permits. This moves authorization decisions from runtime consent (which agents cannot do) to policy configuration (which governance teams can manage).

Okta's product implementation, Cross App Access (XAA), shipped in early access in January 2026 with industry support from AWS, Google Cloud, Salesforce, Box, Automation Anywhere, and others. A developer playground (xaa.dev) launched the same month for testing integrations.[^xaa]

XAA has been incorporated into the MCP specification as the "Enterprise-Managed Authorization" extension. This addresses one of the three trust gaps Shane identified in MCP (covered in [Agent Communication Protocols](agent-communication.md)): MCP defines how agents discover and call tools, but not how authorization travels with those calls. With XAA as the MCP authorization layer, the enterprise IdP can enforce policy over which agents connect to which MCP servers, with what scopes, and under whose authority. The delegation chain that was invisible in plain MCP becomes auditable through the IdP.[^xaa-mcp]

XAA is complementary to OBO and DPoP. OBO tracks the delegation chain (who authorized whom). DPoP binds tokens to keys (preventing theft). XAA handles the initial connection establishment (getting the agent a scoped token for a new application without interactive consent). Together, they cover the three critical phases of agent authorization: connection, delegation, and protection.

The critical question for ID-JAG was whether it would remain an Okta-only capability or become a genuine open standard. Keycloak 26.5 (January 2026) shipped JWT Authorization Grant support, implementing the ID-JAG draft alongside OAuth Token Exchange (RFC 8693) to enable full identity and authorization chaining across trust domains.[^keycloak-idjag] Keycloak is the most widely deployed open-source identity platform, used by Red Hat and millions of enterprise deployments. When Keycloak implements a standard, it becomes infrastructure that organizations can deploy without vendor lock-in.

The implementation also revealed an edge case the book's lifecycle coverage predicted. CVE-2026-1609: disabled user accounts could still obtain valid tokens through the JWT Authorization Grant flow, because the feature's validation path did not check user status. Fixed in Keycloak 26.5.3 (February 2026), but the vulnerability illustrates why SCIM-based agent lifecycle deprovisioning matters. If a human is offboarded but their agent identity persists in the identity provider, the agent becomes a zombie identity: technically disabled, still authorized. Agent identity lifecycle management is not just an administrative convenience; it is a security requirement at the protocol level.

### The Platform Response: Auth0 for AI Agents

Identity platforms are shipping agent-specific products. Auth0's Token Vault, generally available since November 2025, manages the OAuth lifecycle for agents: handling consent flows, storing tokens, refreshing them automatically, and scoping access across 30+ pre-integrated services.[^7]

This is pragmatic infrastructure. It does not solve the deeper problems of purpose encoding or delegation chains, but it eliminates a class of bugs where agents fail because tokens expired, refresh logic was wrong, or credentials were stored insecurely. For teams building agents today, managed token infrastructure reduces the blast radius of the credentials problem.

### Teleport Agentic Identity Framework

Teleport's Agentic Identity Framework, launched in January 2026, takes a different approach from Auth0: instead of managing tokens for cloud services, it extends Teleport's infrastructure access platform (SSH, Kubernetes, databases, internal applications) to treat AI agents as first-class identities.[^teleport]

The framework eliminates long-lived secrets entirely, replacing them with short-lived, cryptographic identities that are continuously validated. Every agent session gets ephemeral credentials scoped to the resources it needs, for the duration it needs them. When the task completes, the credentials expire. No refresh tokens, no standing access, no accumulated privilege.

This is the trust inversion made operational: zero authority by default, explicit grants per task, automatic revocation on completion. For infrastructure access (where compromised credentials give attackers lateral movement across production systems), the difference between standing access and ephemeral access is the difference between a contained incident and a breach.

### Microsoft Entra Agent ID

Microsoft took a more fundamental step in March 2026: creating a dedicated identity type for agents within the identity provider itself. Microsoft Entra Agent ID, part of the Agent 365 platform (generally available May 1, 2026), gives each AI agent its own identity in Entra with lifecycle management: creation, rotation, and decommissioning governed by the same entitlement management processes used for human identities.[^entra-agent-id]

Auth0 manages tokens for agents. Microsoft is making agents first-class identity objects in the enterprise directory, alongside users and service principals. Agents get their own entry in the identity provider, their own access packages, and their own governance workflows.

The platform includes an agent registry: a centralized catalog of both sanctioned and shadow agents operating within Microsoft environments. This bridges the gap between identity (covered here) and shadow agent governance (covered in the [Shadow Agent Governance](shadow-agent-governance.md) chapter): agents that exist in the registry get identities; agents that do not exist cannot authenticate.

Agent identity verification and scoped authorization through entitlement management are no longer custom infrastructure projects. They are platform features. The question shifts from "can we build agent identity infrastructure?" to "how quickly can we deploy it?"

### SCIM for Agents: Lifecycle Provisioning at the Protocol Level

Microsoft Entra creates agent identities in one directory. But agents, like human employees, need accounts provisioned across every application they interact with. That is what SCIM (System for Cross-domain Identity Management) does for humans: when you hire someone, SCIM automatically creates their accounts in Salesforce, Slack, Google Workspace, and dozens of other services. When they leave, SCIM deactivates them everywhere simultaneously.

Two IETF drafts submitted in late 2025 and early 2026 extend SCIM to agents. The SCIM Agents and Agentic Applications Extension (draft-abbey-scim-agent-extension, Macy Abbey at Okta) defines two new SCIM resource types: "Agent" and "AgenticApplication."[^scim-agents] An Agent is a workload with its own identifier, metadata, and privileges, separate from the application that hosts it. An AgenticApplication is a platform that exposes or hosts one or more agents. A second draft, the SCIM Agentic Identity Schema (draft-wahl-scim-agent-schema, Mark Wahl), takes a complementary approach to the same problem, defining schema attributes for agent identity lifecycle management.[^scim-agents]

The OAuth extensions earlier in this chapter solve authorization: what can an agent do? The platform implementations (Auth0, Teleport, Entra) solve identity: who is this agent? SCIM for agents solves provisioning: how do agent identities get created, updated, and deactivated across every application in the enterprise, automatically and consistently?

Without SCIM-level provisioning, agent lifecycle management is manual. An administrator creates the agent identity in Entra, then separately configures access in each connected application. When the agent is decommissioned, each application must be updated individually. This is the problem SCIM solved for human identities a decade ago, and agents inherit it. With SCIM agent extensions, the identity provider provisions agent identities across the entire application ecosystem through a single protocol, and decommissioning an agent revokes access everywhere simultaneously.

SCIM provisioning creates a structural enforcement point for shadow agent governance (covered in [Shadow Agent Governance](shadow-agent-governance.md)): if agent identities can only be provisioned through the SCIM lifecycle, then an agent that was not provisioned through governance channels cannot authenticate to SCIM-integrated applications.

That both drafts come from identity platform practitioners (Okta, Microsoft ecosystem) rather than academic researchers signals that agent lifecycle management is hitting production requirements, not theoretical design. The same pattern played out with human SCIM: the protocol emerged from the operational need to manage identities at scale across SaaS applications, not from standards committee design.

### WIMSE for Agents: Workload Identity Meets Agent Identity

SCIM handles lifecycle provisioning across applications. But there is a lower layer: how does an agent get an identity in the first place, at the infrastructure level, before it ever touches an application?

This is the problem workload identity was built for. SPIFFE (Secure Production Identity Framework for Everyone) assigns cryptographic identities to software workloads based on their runtime environment: which Kubernetes pod they run in, which cloud instance they occupy, what attestation they can provide. The identity comes from the infrastructure, not from a pre-shared secret. WIMSE (Workload Identity in Multi-System Environments) extends this across trust domains.

The IETF draft "WIMSE Applicability for AI Agents" (draft-ni-wimse-ai-agent-identity, now at revision 02) bridges workload identity to agent identity.[^wimse-agents] The draft identifies three requirements that make agents different from traditional workloads: automated credential management with reduced validity periods to minimize exposure windows, minimal privileged access tokens that are task-oriented with short lifespans, and explicit workflow management to prevent agents from accessing resources outside their assigned scope.

The key architectural contribution is the dual-identity credential: a credential that binds both the agent's identity and its owner's identity cryptographically. Where a standard SPIFFE SVID identifies only the workload, a WIMSE agent credential identifies the agent and the specific user or department it represents. An agent acting on behalf of Alice in the R&D department carries a credential that an authorization server can verify on both dimensions: this is a trusted agent, and it is specifically representing Alice's authority. This maps to the OBO pattern but at the infrastructure layer rather than the OAuth layer.

The draft also introduces an Identity Proxy: an intermediary that can request, inspect, replace, or augment agent identity credentials while exposing a local Agent API. Agents do not handle their own credential lifecycle. The proxy manages credential rotation, scope verification, and credential augmentation as agents move between tasks.

CyberArk's Secure AI Agents Solution, generally available since late 2025, validates this architecture in production. The approach uses SPIFFE Verifiable Identity Documents (SVIDs) as universal, short-lived identities for AI agents, with two-way trust established between authorization servers and SPIFFE roots of trust via SPIRE.[^cyberark-agents] CyberArk's Workload Identity Day Zero event framed the design principle: "AI agents are workloads that need narrowly scoped permissions, explicit authorization of actions, and confirmation of intent."

OAuth extensions (OBO, AAP, XAA) handle authorization at the application layer: what can this agent do? Entra Agent ID and SCIM handle identity lifecycle at the platform layer: who is this agent, and how does it get provisioned? WIMSE for agents handles identity bootstrapping at the infrastructure layer: how does this agent prove it exists, in this runtime environment, bound to this owner?

### Agent Identity Is Now a Product Category

Agent identity is converging into a product category across multiple market segments simultaneously.

At RSAC 2026's Innovation Sandbox (March 23), two of ten finalists are purpose-built for agent governance. Token Security provides continuous discovery, lifecycle governance, and intent-based access controls for autonomous agents: treating every AI agent and non-human identity as a managed identity with enforced constraints.[^token-security] Geordie AI provides real-time visibility into an organization's agentic footprint, with posture and behavior monitoring designed to identify and mitigate risk as agents scale.[^geordie] Both were selected from hundreds of submissions, and each finalist receives a $5 million investment.

Sector-specific solutions are emerging alongside the horizontal platforms. Imprivata launched Agentic Identity Management at HIMSS 2026 (March 10), purpose-built for healthcare environments where agents must access EHRs, clinical systems, and legacy infrastructure under strict regulatory requirements.[^imprivata] The approach mirrors the patterns from Teleport and Entra: agents do not store or handle static credentials. Instead, Imprivata brokers secure connections using short-lived tokens, continuously verifies agent identity, enforces least-privilege access, and maintains real-time audit logs of every action. If an agent behaves unexpectedly, security teams can revoke access instantly. The advantage is ecosystem scope: Imprivata already secures clinical access across healthcare environments that most identity providers cannot reach, so agent identity inherits that coverage.

The Huntress 2026 Cyber Threat Report confirms the pattern from the attacker's perspective: identity threats now dominate their incident data, with OAuth abuse more than doubling year-over-year (4.8% to 10.1%) as attackers exploit the gap between what credentials permit and what their holders intended.[^huntress]

The product category is not just forming. It is already consolidating through M&A. CrowdStrike announced the acquisition of SGNL for $740 million in January 2026, specifically to extend Falcon identity security to human, non-human, and AI agent identities with continuous, context-aware authorization.[^crowdstrike-sgnl] Kurtz: "AI agents operate with superhuman speed and access, making every agent a privileged identity that must be protected." Two months later, Delinea completed its acquisition of StrongDM to combine enterprise privileged access management with just-in-time runtime authorization for agents, creating what they describe as a "unified identity security control plane" for both human and non-human identities.[^delinea-strongdm] Two major acquisitions in Q1 2026, both explicitly positioned around agent identity authorization, confirm that the infrastructure gap described in this chapter is now priced as a strategic asset by the market, not just identified as a technical problem by practitioners.

The pattern: platform vendors (Microsoft Entra, Okta XAA), infrastructure providers (Teleport), horizontal startups (Token Security, Geordie AI, Noma), sector-specific providers (Imprivata), and security platform acquirers (CrowdStrike, Delinea) are all converging on agent identity governance at the same time. This is no longer an infrastructure gap for organizations to build around. It is a product category forming and consolidating in real time. The practical implication: organizations evaluating agent identity infrastructure should assess vendor coverage against their actual agent footprint. Microsoft Entra covers Microsoft environments. Imprivata covers healthcare systems. Teleport covers infrastructure access. CrowdStrike/SGNL covers SaaS and cloud authorization. None of them covers everything. The cross-provider and cross-organizational problem still requires the decentralized identity infrastructure described in the next section.

### GNAP: Authorization Without OAuth's Assumptions

The extensions above patch OAuth to handle agent patterns. GNAP (Grant Negotiation and Authorization Protocol, RFC 9635) starts from different assumptions entirely.[^gnap]

OAuth requires pre-registered clients. An application registers with the authorization server, receives a client ID and secret, and uses those in every token request. For agents that spin up dynamically, connect to services they have never seen, and may be ephemeral, pre-registration is a friction point that drives organizations toward shared credentials or static API keys: the anti-patterns the CSA/Strata survey found in 44% of deployments.

GNAP removes this requirement. A client presents a cryptographic key in its first interaction with the authorization server. That key becomes the client's identity for the duration of the grant. No pre-registration, no client secret, no out-of-band setup. The authorization server can evaluate the request based on the key, the requested access, and policy, without needing the client to exist in its database first.

Three GNAP design decisions matter for agents specifically:

**Key-bound from the start.** Every GNAP access token is bound to the client's key by default. There are no bearer tokens to steal. This is what DPoP (RFC 9449) retrofits onto OAuth; GNAP builds it in. A compromised token without the corresponding key is useless.

**Interaction-based, not grant-type-based.** OAuth has distinct grant types (authorization code, client credentials, device code) for different interaction patterns. GNAP separates what the client wants from how the user interacts: the client describes the access it needs, and the authorization server chooses the appropriate interaction mode (redirect, push notification, out-of-band verification). For agents operating across web, voice, and messaging channels, this flexibility avoids the awkward mapping between agent deployment context and OAuth grant type that AAuth addresses for the voice-specific case.

**Dynamic scope negotiation.** GNAP allows the authorization server to grant less than requested and the client to request modifications to an ongoing grant without starting a new flow. An agent can begin with narrow access, discover it needs additional capabilities mid-task, and request them without re-authenticating the user. This matches how agents actually work: they discover what they need as they execute, not before.

TwigBush, an early-stage open-source GNAP authorization server built in Go, targets AI agent delegation. It provides key-bound tokens, real-time grant updates, and policy hooks designed for multi-cloud and agent-driven workloads.[^twigbush] The project is early-stage, but its existence signals that practitioners are looking beyond OAuth patches to protocols designed for the agent model from the ground up.

The practical question is adoption. OAuth's ecosystem is enormous: every identity provider, every SaaS application, every mobile SDK speaks OAuth. GNAP has a published RFC but limited deployment. For most organizations today, the OAuth extensions described earlier in this chapter are the pragmatic path. But GNAP's design assumptions (dynamic clients, key-bound tokens, interaction flexibility) map more closely to the agent model than OAuth's. The gap between what OAuth assumes and what agents need is what the extensions earlier in this chapter are filling. GNAP fills that gap by removing the assumptions.

## Beyond OAuth: Verifiable Identity

The OAuth extensions and GNAP address authorization within systems where the authorization server has authority. But agents increasingly operate across organizational boundaries, where no single authorization server governs all parties.

### DIDs and Verifiable Credentials

Decentralized Identifiers (DIDs, W3C standard) and Verifiable Credentials (VCs, W3C standard) provide cryptographic identity without a central authority.

A DID is a URI that resolves to a DID Document containing public keys and service endpoints. The holder proves control by signing with the corresponding private key. No registration with a central server required.

A Verifiable Credential is a signed claim: "Entity X has property Y, attested by Issuer Z." The holder can present it to anyone, who can verify the signature without calling back to the issuer.

For agents, this infrastructure enables:

**Agent identity.** An agent gets its own DID, separate from its developer and deploying organization. Each entity in the chain (developer, organization, agent) can have verifiable credentials attesting to their properties and relationships.

**Content verification.** Shane demonstrated this practically by signing every blog post with his DID (`did:webvh`) using Ed25519 signatures and the `eddsa-jcs-2022` cryptosuite. An agent consuming his content can verify: this was written by Shane, the content has not been tampered with, and the DID resolves to a trust registry (in his case, GitHub). No central authority needed.[^8]

**Cross-organizational trust.** When your agent calls my API, VCs can prove claims without either of us trusting the same identity provider. Your agent presents a credential saying "I was deployed by Organization X, with capabilities Y and Z." My API verifies the credential against the issuer's public key.

The practical gap, as Shane notes, is discovery. If an agent can verify credentials when they are present, that is useful. But it becomes powerful when missing credentials are themselves a signal: when an unsigned API response or an unverifiable agent identity triggers caution by default.[^8]

### Trust Spanning Protocol

The Trust Spanning Protocol (TSP), developed under Linux Foundation Decentralized Trust, is the thin-waist protocol for trust: it connects many things above (apps, agents, wallets) to many things below (identifier types, key systems), the way IP connects networks.[^9]

When an agent connects to a service it has never seen, TSP handles the trust establishment:

1. Both sides resolve each other's DIDs to get public keys
2. They check relevant trust registries
3. An encrypted, authenticated channel is established
4. The application protocol (MCP, A2A, or whatever) operates on top

TSP is distinct from OAuth. OAuth assumes you pre-registered with the authorization server. TSP handles the stranger-to-stranger case: two agents from different organizations that need to verify each other without any prior relationship or shared authority.

The spec reached Revision 2 in November 2025; development continues.[^10]

### Authority Continuity: PIC

TSP handles identity across boundaries. But identity verification alone does not constrain what happens after authentication. An agent that proves who it is can still accumulate authority beyond what was delegated to it.

Nicola Gallo reframes this as a model problem, not a configuration problem. Current systems treat authority as an object: create a token, store it, transfer it, consume it. Whoever holds the token exercises the authority. A stolen token works. A replayed token works. A token used in an unintended context works. Possession equals authority.[^pic]

PIC (Provenance, Identity, Continuity) replaces proof of possession with proof of continuity. Each execution step forms a virtual chain where the workload proves it can continue under the received authority, satisfying the constraints (department membership, company affiliation, and similar guardrails). The trust plane validates this at each step and creates the next link. Authority can only be restricted or maintained, never expanded.

The confused deputy is not detected or mitigated under this model. It is eliminated. If Alice asks an agent to summarize a file she does not have access to, the agent cannot execute under its own authority: the continuity chain carries Alice's original permissions. The only way to access that file is to create new authority, which is a deliberate act with its own accountability.[^pic]

To continue authority, a workload does not need its own identity. It just needs to prove it can operate within the received authority's constraints. But to create authority, you need an identity and an expressed intent. That distinction is what makes the model work for agents, which are workloads that sometimes need to act autonomously and sometimes need to continue authority received from a human principal.

PIC is designed to work with existing infrastructure. It can use OAuth as a federated backbone, embedding causal authority in custom claims. Performance is not a blocker: executing a continuity chain takes microseconds, comparable to a token exchange call.[^pic]

The [Cross-Organization Trust](cross-org-trust.md) chapter covers how TSP and PIC compose into a full stack for cross-boundary agent governance.

## Verifiable Intent: Proving What Was Authorized

The biggest gap in the identity stack is not "who" but "what exactly." OAuth proves who has access. OBO proves who delegated. But neither proves what the user actually intended the agent to do.

Mastercard and Google addressed this with Verifiable Intent, open-sourced on March 5, 2026.[^11]

### The Three-Layer Architecture

Verifiable Intent uses a three-layer SD-JWT (Selective Disclosure JSON Web Token) architecture. Each layer adds specificity and each is signed by the appropriate party:

**Layer 1: Issuer Identity.** The credential issuer (payment network, identity provider) proves the identity of the user. The credential is bound to the user's public key.

**Layer 2: User Intent.** The user defines constraints on what the agent may do. These are signed by the user and cannot be modified by the agent:

- Merchant restrictions (only these merchants)
- Amount bounds (maximum per transaction, total budget)
- Line item constraints (only these product categories)
- Recurrence rules (one-time, weekly up to N times)
- Time bounds (valid for 24 hours)

**Layer 3: Agent Action.** The agent signs what it intends to do within the user's constraints. This layer splits into L3a (sent to the payment network) and L3b (sent to the merchant), each containing only the information that party needs.

### Solving Consent Theater

Verifiable Intent solves the consent theater problem Shane identified. Instead of a coarse OAuth scope ("can make payments"), the user's constraints are cryptographically bound to the authorization. The agent cannot exceed them. The merchant can verify them. The payment network can enforce them.

The selective disclosure is critical: each party sees only what it needs. The merchant sees the checkout details but not the payment instrument. The payment network sees the authorization but not the line items. Privacy is built into the protocol, not bolted on.

The agent cannot sub-delegate. Layer 3 is terminal. Authority can only decrease through the chain, never increase.[^12]

Three major commerce protocols are adopting Verifiable Intent: AP2 (Google), ACP (Stripe/OpenAI), and UCP (Google/Shopify/Walmart). The specification is built on established standards: SD-JWT, JWT, JWS, and ES256 from IETF, FIDO Alliance, EMVCo, and W3C.[^11]

## The Regulatory Convergence

Regulators are converging on the same questions.

### NIST: Agent Identity as National Priority

In February 2026, NIST released "Accelerating the Adoption of Software and Artificial Intelligence Agent Identity and Authorization," a concept paper proposing demonstrations of identity and authorization practices for AI agents in enterprise settings. The paper, authored by Ryan Galluzzo (who leads NIST's digital identity program) and colleagues, covers four focus areas:[^13]

- **Identification:** distinguishing AI agents from human users
- **Authorization:** applying standards like OAuth 2.0 to define agent rights
- **Access delegation:** linking user identities to AI agents
- **Logging and transparency:** linking agent actions to their non-human entity

The comment period runs through April 2, 2026, nearly the same window as the EU AI Act's high-risk obligations (originally August 2026, potentially December 2027 under the Digital Omnibus proposal).

### Industry Response: The Agent Transparency Label

Separately, NIST's CAISI issued a request for information on security considerations for AI agent systems, with a March 9 comment deadline. The Bank Policy Institute and the American Bankers Association submitted a joint response proposing what they call a "nutrition label" for AI agents: a risk-scaled, controlled-sharing profile that standardizes what organizations must disclose about their agents to counterparties.[^bpi-aba]

The proposal has two tiers. A foundational baseline covers every agent: purpose, data dependencies, operational boundaries, permission scope, human approval requirements, logging capabilities, and change notification requirements. An enhanced tier adds detail when risk or complexity is higher: deeper data dependency documentation, protective measures for high-risk actions, and operational validation evidence. The analogy to food nutrition labels is deliberate: a standard baseline set of information for due diligence, with added detail when the stakes are higher.

The specific mechanism they propose is a "Data Dependency Label": a structured document that maps an agent's data dependencies, helping counterparties determine what disclosure tier is appropriate. In financial services, agents increasingly interact across institutional boundaries (payment processing, fraud detection, lending decisions) and each counterparty needs to assess the other's agent before trusting it with sensitive data or authority.

The proposal connects three threads the book has covered separately. The NIST concept paper asks what identity and authorization standards agents need. KYA (covered in the [Agent Payments](agent-payments.md) chapter) answers who the agent is and whether it is legitimate. The transparency label answers what the agent does, what it accesses, and what safeguards constrain it. Together, they compose into a pre-interaction trust stack: verify the agent's identity (KYA), understand its capabilities and constraints (transparency label), then authorize specific actions (Verifiable Intent). The financial industry is proposing the middle layer.

The BPI/ABA proposal is deliberately technology-agnostic: it specifies what must be disclosed, not how. But the disclosure requirements map naturally to existing infrastructure: Agent Cards in A2A already carry machine-readable capability metadata. Verifiable Credentials can make transparency claims portable and verifiable. The transparency label concept does not require new technical standards. It requires agreement on what the existing standards should carry.

### OpenID Foundation: Standards Coordination

The OpenID Foundation established the Artificial Intelligence Identity Management Community Group, which produced a whitepaper: "Identity Management for Agentic AI: The new frontier of authorization, authentication, and security for an AI agent world."[^14]

The group identifies gaps that existing standards do not cover:

- How to assert the identity of an LLM and/or agent to external servers
- How to define token contents moving between multiple AI agents
- How to handle delegated authority across organizational boundaries

While the Community Group will not develop protocols directly, it is laying groundwork for standards development within OpenID or through liaison partnerships. The calls happen weekly (Thursdays, 9am Pacific) and are open to anyone.

### CSA: Agent Identity as Industry Architecture

The Cloud Security Alliance published "Agentic AI Identity & Access Management: A New Approach," proposing a purpose-built IAM framework for agent systems built explicitly on DIDs, VCs, and Zero Trust principles.[^csa] The framework validates the architectural direction described earlier in this chapter and introduces three elements worth noting.

**Agent Naming Service (ANS).** The framework specifies a discovery mechanism where agents query for specific capabilities, compliance requirements, and protocol preferences. The ANS returns cryptographically signed responses containing target agent DIDs, service endpoints, and relevant attestations (such as SOX compliance certifications). This connects agent identity to agent discovery: you cannot verify an agent's credentials if you cannot find the agent. ANS addresses the gap between identity infrastructure (covered here) and communication protocols (covered in [Agent Communication Protocols](agent-communication.md)).

**Zero-Knowledge Proofs for compliance.** The framework specifies ZKPs to enable privacy-preserving attribute disclosure: an agent can prove it meets specific compliance requirements or holds a particular certification without revealing the underlying data. For cross-organizational trust, agents can satisfy verification requirements without over-disclosing. A financial services agent can prove SOX compliance without revealing its internal audit documentation.

**Unified session management.** A global policy enforcement layer that propagates revocations instantly across heterogeneous multi-agent systems. When an agent's authority is revoked, the revocation takes effect at every interaction point simultaneously, not at the next token refresh. This addresses a practical gap in current implementations where revocation latency creates windows of unauthorized action.

The CSA framework, the NIST concept paper, and the OpenID AIIM group are converging on the same architectural conclusion: agents need identity infrastructure purpose-built for autonomy, ephemerality, and delegation. The building blocks (DIDs, VCs, scoped tokens) exist. The remaining work is integration and operational maturity.

### eIDAS 2.0 and EUDI Wallets

The European Digital Identity framework (eIDAS 2.0) is building the infrastructure for digital identity wallets that could extend to agents. EUDI wallets give citizens and businesses cryptographic credentials that work across the EU. The same infrastructure, DIDs, VCs, and trust registries, is applicable to agent identity.

When an agent operating in the EU needs to prove its organizational affiliation, its compliance status, or its authorization to act, EUDI wallet infrastructure provides the verification layer: the same infrastructure that proves identity also creates the audit trail regulators require.[^10]

## Connecting to PAC

Agent identity is where all three pillars of the PAC Framework intersect:

**Potential.** Identity infrastructure determines what agents can do. Without proper delegation, agents are limited to single-system, single-organization tasks. With verifiable identity and cross-organizational trust, agents can operate across boundaries, unlocking higher-value use cases (V3 Strategic and V4 Transformative in the PAC [business value scale](pac-framework.md)).

**Accountability.** Every identity decision creates or breaks an audit trail. OBO tokens track who delegated. Verifiable Intent proves what was authorized. DID-signed actions prove who acted. Without this infrastructure, the liability chain dissolves the moment an agent makes an autonomous decision.

**Control.** Identity is the enforcement mechanism. Scoped credentials, DPoP-bound tokens, monotonically decreasing authority through delegation chains, and infrastructure-level restrictions (I3 and above) all depend on the agent having a verifiable identity that carries explicit, bounded authority.

The infrastructure scale from the PAC Framework maps to identity maturity:

| Infrastructure Level | Identity Capability |
|---|---|
| I1 (Open) | No agent identity; acts under user credentials |
| I2 (Logged) | Agent actions logged but not identity-scoped |
| I3 (Verified) | OBO delegation, scoped credentials, audit trails |
| I4 (Authorized) | Verifiable identity, cross-org trust, PIC authority continuity |
| I5 (Contained) | Full delegation chains, verifiable intent, sandboxed execution |

Most organizations are between I1 and I2 today. The standards described in this chapter provide the path to I3 through I5.

## What to Do Now

The standards are landing but not yet universal. For teams deploying agents today:

**Start with OBO.** If your identity provider supports RFC 8693 token exchange, use it. Dual-identity tokens that track both user and agent are the minimum for accountable delegation.

**Bind tokens to keys.** DPoP is available now and prevents the most common credential theft scenarios. If your agents hold long-lived tokens, bind them.

**Scope aggressively.** Default to the narrowest permissions possible. If your authorization server supports Rich Authorization Requests (RFC 9396), use `authorization_details` instead of flat scopes. Every unnecessary permission is attack surface.

**Log the delegation chain.** Even before you have formal delegation infrastructure, log who authorized what at every hop. When the incident comes, this is what you will need.

**Watch the standards.** The NIST comment period (April 2, 2026), the OpenID AIIM Community Group, PIC, and the Verifiable Intent specification are all active. These will shape how agent identity works for the next decade.

The identity layer for agents is being built right now, in IETF drafts, W3C specifications, and open-source implementations. The organizations that adopt this infrastructure early will have accountable, auditable agent deployments. The ones that wait will be explaining to regulators why they cannot trace what their agents did.

---

[^1]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," February 3, 2026.
[^2]: Shane Deconinck, "Auth for Agent Builders: A Crash Course," January 26, 2026.
[^3]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," March 5, 2026.
[^4]: IETF RFC 8693, "OAuth 2.0 Token Exchange," January 2020.
[^5]: IETF, "OAuth 2.0 Extension: On-Behalf-Of User Authorization for AI Agents," draft-oauth-ai-agents-on-behalf-of-user-02.
[^6]: IETF RFC 9449, "OAuth 2.0 Demonstrating Proof of Possession (DPoP)," September 2023.
[^7]: Auth0, "Auth0 for AI Agents," generally available November 2025.
[^8]: Shane Deconinck, "My Content Comes with Verifiable Credentials. Your Agent Can Verify," February 22, 2026.
[^9]: Shane Deconinck, "Understanding TSP: The Trust Spanning Protocol Explained," shanedeconinck.be explainer.
[^10]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," January 24, 2026.
[^11]: Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," March 6, 2026.
[^12]: Mastercard, "How Verifiable Intent Builds Trust in Agentic AI Commerce," March 5, 2026.
[^13]: NIST NCCoE, "Accelerating the Adoption of Software and Artificial Intelligence Agent Identity and Authorization," February 5, 2026.
[^14]: OpenID Foundation, "Identity Management for Agentic AI," Artificial Intelligence Identity Management Community Group whitepaper, 2025.
[^gravitee]: Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control," gravitee.io, 2026. Survey of 919 executives and practitioners across industries.
[^csa]: Cloud Security Alliance, "Agentic AI Identity & Access Management: A New Approach," cloudsecurityalliance.org, 2025-2026. Framework proposing DID+VC+ZKP-based IAM for multi-agent systems.
[^entra-agent-id]: Microsoft, "What is Microsoft Entra Agent ID?," learn.microsoft.com, March 2026. Part of Microsoft Agent 365, generally available May 1, 2026. See also ConductorOne, "Future of Identity Report 2026," March 10, 2026.
[^teleport]: Teleport, "2026 State of AI in Enterprise Infrastructure Security," February 17, 2026. Survey of 205 senior infrastructure and security leaders. See also Teleport, "Agentic Identity Framework," goteleport.com, January 27, 2026.
[^token-security]: Token Security, "Token Security is a Top 10 Finalist for RSAC 2026 Innovation Sandbox Contest," globenewswire.com, February 10, 2026. Also named finalist in two categories of the 2026 SC Awards (Most Promising Early-Stage Startup and Best Emerging Technology).
[^geordie]: Geordie AI, "Geordie AI Selected as Top 10 Finalist for RSAC 2026 Conference Innovation Sandbox Contest," globenewswire.com, February 10, 2026.
[^imprivata]: Imprivata, "Imprivata Introduces Agentic Identity Management to Secure and Govern AI Agents in Healthcare," imprivata.com, March 10, 2026. Announced at HIMSS 2026.
[^huntress]: Huntress, "2026 Cyber Threat Report," huntress.com, February 2026. Identity threats dominate incident data; OAuth abuse doubled year-over-year from 4.8% to 10.1%. Analysis of 4.6 million endpoints and 9.4 million identities across 230,000+ organizations.
[^csa-strata-auth]: Cloud Security Alliance and Strata Identity, "Securing Autonomous AI Agents," CSA Survey Report, February 5, 2026. Survey of 285 IT and security professionals conducted September-October 2025. Authentication methods: 44% static API keys, 43% username/password, 35% shared service accounts. Only 18% highly confident in IAM for agents.
[^xaa]: Okta, "Cross App Access: Securing AI agent and app-to-app connections," okta.com, 2025-2026. Built on IETF Identity Assertion JWT Authorization Grant (ID-JAG) draft. Early access January 2026. Industry support from AWS, Google Cloud, Salesforce, Box, Automation Anywhere, Glean, Grammarly, Miro, WRITER. See also WorkOS, "Cross App Access (XAA): The enterprise way to govern AI app integrations," workos.com, 2026; Descope, "What is Cross-App Access (XAA) and How It Works," descope.com, 2026.
[^xaa-mcp]: Okta, "Cross App Access extends MCP to bring enterprise-grade security to AI agent interactions," okta.com, 2026. XAA incorporated into MCP specification as "Enterprise-Managed Authorization" extension.
[^crowdstrike-sgnl]: CrowdStrike, "CrowdStrike to Acquire SGNL to Transform Identity Security for the AI Era," crowdstrike.com, January 8, 2026. $740M acquisition. SGNL provides continuous identity authorization: real-time grant, deny, and revoke across SaaS and cloud based on Falcon platform risk signals.
[^delinea-strongdm]: Delinea, "Delinea Completes StrongDM Acquisition to Secure AI Agents with Continuous Identity Authorization," globenewswire.com, March 5, 2026. Combines enterprise PAM with just-in-time runtime authorization for human and non-human identities.
[^aap]: IETF, "Agent Authorization Profile (AAP) for OAuth 2.0," draft-aap-oauth-profile-01, February 7, 2026. Individual submission by Angel Cruz. Extends OAuth 2.0 and JWT with structured claims for agent identity, task context, operational constraints, delegation chains, and human oversight requirements.
[^decoupled-auth]: IETF, "A Decoupled Authorization Model for Agent2Agent," draft-chen-agent-decoupled-authorization-model-00, February 14, 2026. Authors: Meiling Chen and Li Su (China Mobile). Proposes just-in-time, intent-based permissions through decoupled Authorization Decision Points and Authorization Execution Points.
[^txn-tokens-agents]: IETF, "Transaction Tokens For Agents," draft-oauth-transaction-tokens-for-agents-03, January 20, 2026. Extends the OAuth Transaction Tokens framework (draft-ietf-oauth-transaction-tokens-08) with actor and principal claims for agent context propagation through distributed call chains. Txn-Tokens are short-lived, signed JWTs with immutable identity context that replace access token forwarding.
[^txn-tokens-a2a]: IETF, "Agent-to-Agent (A2A) Profile for OAuth Transaction Tokens," draft-liu-oauth-a2a-profile-00, 2026. Applies Transaction Tokens to A2A protocol interactions for agent delegation context propagation.
[^scim-agents]: IETF, "SCIM Agents and Agentic Applications Extension," draft-abbey-scim-agent-extension-00. Defines "Agent" and "AgenticApplication" SCIM resource types for cross-domain provisioning and lifecycle management. See also IETF, "SCIM Agentic Identity Schema," draft-wahl-scim-agent-schema-01 (complementary schema approach). WorkOS, "SCIM for AI: Inside the new IETF draft for agent and agentic application provisioning," workos.com, 2026. Microsoft, "Beyond OAuth: Why SCIM must evolve for the AI agent revolution," techcommunity.microsoft.com, 2026.
[^aauth]: IETF, "AAuth: Agentic Authorization OAuth 2.1 Extension," draft-rosenberg-oauth-aauth-01, 2026. Authors: Jonathan Rosenberg and Pat White. Defines the Agent Authorization Grant for non-web channel agent interactions (voice, SMS, messaging). Addresses LLM hallucination as impersonation vector through mandatory out-of-band identity verification.
[^wimse-agents]: IETF, "WIMSE Applicability for AI Agents," draft-ni-wimse-ai-agent-identity-02, 2026. Extends WIMSE architecture to AI agents with dual-identity credentials binding agent and owner identities, Identity Proxy for credential management, and requirements for automated credential management with reduced validity periods. See also IETF 122 WIMSE WG minutes, March 2026.
[^bpi-aba]: Bank Policy Institute and American Bankers Association, "BPI/ABA Comment on NIST's Security Considerations for AI Agent Systems," bpi.com, March 9, 2026. Joint comment to NIST CAISI proposing risk-scaled "nutrition label" controlled-sharing profile for agent transparency, with foundational and enhanced tiers, Data Dependency Labels, and NCCoE-style practice guides for financial services agent deployments.
[^cyberark-agents]: CyberArk, "CyberArk Introduces First Identity Security Solution Purpose-Built to Protect AI Agents with Privilege Controls," cyberark.com, November 2025. General availability late 2025. Uses SPIFFE SVIDs as short-lived agent identities. Palo Alto Networks acquired CyberArk for $25 billion in February 2026, the largest security industry deal in history, making agent identity security a core pillar of its platform. See also GitGuardian, "Workload And Agentic Identity at Scale: Insights From CyberArk's Workload Identity Day Zero," blog.gitguardian.com, November 2025.
[^keycloak-idjag]: Keycloak, "JWT Authorization Grant and Identity Chaining in Keycloak 26.5," keycloak.org, January 2026. Implements IETF Identity Assertion JWT Authorization Grant (ID-JAG) via RFC 7523 profile, combined with Token Exchange (RFC 8693) for cross-domain identity chaining. See also CVE-2026-1609: disabled users could obtain tokens via JWT Authorization Grant (fixed in 26.5.3, February 2026); CVE-2026-1486: logic bypass allowing authentication via disabled identity providers.
[^rar]: IETF RFC 9396, "OAuth 2.0 Rich Authorization Requests," May 2023. Authors: Torsten Lodderstedt, Justin Richer, Brian Campbell. Defines the `authorization_details` parameter for structured, fine-grained authorization beyond OAuth scopes. Fields include `locations`, `actions`, `datatypes`, `identifier`, and `privileges`.
[^mcp-rar]: GitHub, modelcontextprotocol/modelcontextprotocol, Issue #1670: "Support Rich Authorization Requests for OAuth - RFC 9396," October 17, 2025. Requests RAR support in MCP for fine-grained, time-bound, role-based agent authorization that traditional scopes cannot express.
[^gnap]: IETF RFC 9635, "Grant Negotiation and Authorization Protocol (GNAP)," October 2024. Authors: Justin Richer, Fabien Imbault. Defines a next-generation authorization protocol that removes OAuth's pre-registration requirement, makes key-bound tokens the default, and separates access requests from interaction modes. See also IETF RFC 9767, "GNAP Resource Server Connections," 2025.
[^twigbush]: TwigBush, "GNAP grant engine in Go, built for short-lived tokens that let AI agents delegate securely," github.com/TwigBush/TwigBush. Open-source implementation of RFC 9635 and RFC 9767 targeting AI agent delegation, multi-cloud environments, and ephemeral workloads. Early-stage.
[^pic]: Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," shanedeconinck.be, March 11, 2026. Reflections from the LFDT Belgium meetup featuring Nicola Gallo (Nitro Agility, co-chair of Trusted AI Agents working group at Decentralized Identity Foundation) on PIC. See also pic-protocol.org.
