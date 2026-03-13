# Agent Identity and Delegation

The previous chapters established why agents break trust and introduced the PAC Framework. This chapter goes deep on the technical problem at the center of the Control pillar: how do you know who an agent is, who it acts for, and what authority it carries?

This is not an abstract design question. Every time an agent calls an API, sends a message, or makes a purchase, something needs to answer: who authorized this? Traditional identity systems were not built for that question. The standards landing now are.

## The Trust Inversion

Shane's framing of this is precise: humans are restricted in what they can't do, agents must be restricted to what they can.[^1]

In organizations, humans operate within broad boundaries. You trust employees with judgment, then add guardrails for specific risks: compliance training, approval workflows, separation of duties. The default is trust. Restrictions are exceptions.

Agents need the inverse. The default should be zero authority. Every capability must be explicitly granted, scoped to the task, time-bounded, and revocable. Not because agents are malicious, but because they have no judgment about whether an action is appropriate. An agent that can read all your email will read all your email if any part of its task touches email. It does not think "that seems excessive." It does what its credentials allow.

Teleport's 2026 State of AI in Enterprise Infrastructure Security report quantifies this precisely. Organizations that grant AI systems excessive permissions experience 4.5x more security incidents than those enforcing least-privilege: a 76% incident rate versus 17%.[^teleport] The finding that matters most: access scope, not AI sophistication, was the strongest predictor of outcomes. It does not matter how capable or well-designed the agent is. If its credentials are broader than its task requires, incidents follow. And 70% of organizations report granting AI systems higher levels of privileged access than humans would receive for the same task.

This inversion maps directly to the Control pillar of PAC. Policy says "agents should only access what they need." Architecture must say "agents can only access what they need." The gap between those two statements is where incidents happen.

## Why Traditional IAM Breaks Down

To understand what agents need, you have to understand what we have and where it fails.

### The Identity Stack We Inherited

Authentication and authorization for software evolved through several eras, each solving a real problem:[^2]

**Directory services (LDAP, 1993)** solved "where do I look up who this person is?" Centralized identity stores that every application could query.

**Single sign-on (Kerberos, 1988; SAML, 2005)** solved "how do I prove I'm the same person across systems?" Ticket-based and assertion-based protocols that let users authenticate once.

**Delegated authorization (OAuth, 2007)** solved "how do I let a third-party app access my data without giving it my password?" The user grants scoped access, the app gets a token.

**Federated identity (OIDC, 2014)** solved "how do I prove who I am to a new service?" Built identity (ID Tokens, JWTs) on top of OAuth's authorization layer.

**Workload identity (SPIFFE, 2017; WIMSE, 2023)** solved "how do I authenticate software to software?" Attestation-based identity for services, not people.

**Decentralized identity (DIDs, 2019; VCs, 2019)** solved "how do I prove claims about myself without relying on a central authority?" Cryptographic credentials the holder controls.

Every layer was a response to a real limitation of the previous one. But none of them were designed for an entity that receives a goal and decides how to accomplish it. They all assume either a human making decisions or software executing predetermined logic.

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

Shane identified this gap clearly: an agent usually acts on behalf of a user but creates its own intent. It is neither a human (who would use interactive OAuth) nor a traditional service (which would use Client Credentials). It is something new: a delegated entity with decision-making capability.[^2]

The numbers confirm how wide this gap is. According to the Gravitee State of AI Agent Security 2026 survey (900+ respondents): only 21.9% of teams treat AI agents as independent, identity-bearing entities. 45.6% still rely on shared API keys for agent-to-agent authentication. And 27.2% have reverted to custom, hardcoded authorization logic because existing tools do not fit the agent model.[^gravitee] Nearly half of organizations are authenticating agents the same way they authenticated batch scripts in 2005. Shared API keys cannot carry delegation semantics, enforce scope attenuation, or create auditable accountability chains. The identity stack described in the rest of this chapter exists to close that gap.

This gap is what the rest of this chapter addresses: the infrastructure emerging to close it.

## OAuth Extensions for Agents

The identity community is not starting from scratch. The first wave of solutions extends OAuth to handle agent-specific patterns.

### On-Behalf-Of (RFC 8693)

OAuth 2.0 Token Exchange (RFC 8693) enables an entity to exchange one token for another, explicitly tracking the delegation. The resulting token encodes two identities: the user (the resource owner who delegated) and the agent (the acting party).[^4]

This is significant because it preserves the delegation chain. When Agent A uses OBO to get a token for calling Service X, the token says: "User Alice authorized Agent A to act on her behalf, with these specific scopes." If Agent A then delegates to Agent B, a second exchange can capture that hop too.

In practice, the token request includes:

- A `subject_token` representing the human user
- An `actor_token` authenticating the agent
- The requested scope for the downstream operation

The IETF has a draft specifically for AI agents: "OAuth 2.0 Extension: On-Behalf-Of User Authorization for AI Agents" (draft-oauth-ai-agents-on-behalf-of-user), which introduces a `requested_actor` parameter in authorization requests to identify the specific agent requiring delegation.[^5]

This is real progress. But OBO alone does not solve purpose encoding or constraint enforcement. The token says who delegated and who acts, but not what the user actually intended.

### DPoP (Demonstration of Proof-of-Possession)

DPoP (RFC 9449) binds tokens to cryptographic keys. Instead of bearer tokens that anyone holding them can use, DPoP tokens require the presenter to prove they hold the private key the token was bound to.[^6]

For agents, this matters because stolen tokens become useless. If an agent's token is exfiltrated (through a compromised tool, a prompt injection attack, or a misconfigured logging pipeline), the attacker cannot use it without the agent's private key.

DPoP is complementary to OBO: use OBO to track delegation, use DPoP to prevent token theft.

### The Platform Response: Auth0 for AI Agents

Identity platforms are shipping agent-specific products. Auth0's Token Vault, generally available since November 2025, manages the OAuth lifecycle for agents: handling consent flows, storing tokens, refreshing them automatically, and scoping access across 30+ pre-integrated services.[^7]

This is pragmatic infrastructure. It does not solve the deeper problems of purpose encoding or delegation chains, but it eliminates a class of bugs where agents fail because tokens expired, refresh logic was wrong, or credentials were stored insecurely. For teams building agents today, managed token infrastructure reduces the blast radius of the credentials problem.

### Teleport Agentic Identity Framework

Teleport's Agentic Identity Framework, launched in January 2026, takes a different approach from Auth0: instead of managing tokens for cloud services, it extends Teleport's infrastructure access platform (SSH, Kubernetes, databases, internal applications) to treat AI agents as first-class identities.[^teleport]

The framework eliminates long-lived secrets entirely, replacing them with short-lived, cryptographic identities that are continuously validated. Every agent session gets ephemeral credentials scoped to exactly the resources it needs, for exactly the duration it needs them. When the task completes, the credentials expire. No refresh tokens, no standing access, no accumulated privilege.

This is the trust inversion made operational: zero authority by default, explicit grants per task, automatic revocation on completion. For infrastructure access (where compromised credentials give attackers lateral movement across production systems), the difference between standing access and ephemeral access is the difference between a contained incident and a breach.

### Microsoft Entra Agent ID

Microsoft took a more fundamental step in March 2026: creating a dedicated identity type for agents within the identity provider itself. Microsoft Entra Agent ID, part of the Agent 365 platform (generally available May 1, 2026), gives each AI agent its own identity in Entra with lifecycle management: creation, rotation, and decommissioning governed by the same entitlement management processes used for human identities.[^entra-agent-id]

This is architecturally significant. Auth0 manages tokens for agents. Microsoft is making agents first-class identity objects in the enterprise directory, alongside users and service principals. Agents get their own entry in the identity provider, their own access packages, and their own governance workflows.

The platform includes an agent registry: a centralized catalog of both sanctioned and shadow agents operating within Microsoft environments. This bridges the gap between identity (covered here) and shadow agent governance (covered in the [Shadow Agent Governance](shadow-agent-governance.md) chapter): agents that exist in the registry get identities; agents that do not exist cannot authenticate.

For the PAC Framework, Entra Agent ID represents the I3 to I4 transition becoming productized. Agent identity verification (I3) and scoped authorization through entitlement management (I4) are no longer custom infrastructure projects. They are platform features. The question shifts from "can we build agent identity infrastructure?" to "how quickly can we deploy it?"

## Beyond OAuth: Verifiable Identity

OAuth extensions address the "who" question within existing infrastructure. But agents increasingly operate across organizational boundaries, where no single OAuth provider has authority. This is where decentralized identity enters.

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

The spec reached Revision 2 in November 2025 and is actively developing. For the PAC Framework, TSP is the infrastructure that makes cross-organizational trust possible at the Control pillar level.[^10]

## Verifiable Intent: Proving What Was Authorized

The biggest gap in the identity stack is not "who" but "what exactly." OAuth proves who has access. OBO proves who delegated. But neither proves what the user actually intended the agent to do.

Mastercard and Google addressed this directly with Verifiable Intent, open-sourced on March 5, 2026.[^11]

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

### Why This Matters for Agent Identity

Verifiable Intent solves the consent theater problem Shane identified. Instead of a coarse OAuth scope ("can make payments"), the user's constraints are cryptographically bound to the authorization. The agent cannot exceed them. The merchant can verify them. The payment network can enforce them.

The selective disclosure is critical: each party sees only what it needs. The merchant sees the checkout details but not the payment instrument. The payment network sees the authorization but not the line items. Privacy is built into the protocol, not bolted on.

And critically: the agent cannot sub-delegate. Layer 3 is terminal. This enforces the PAC principle that authority must only decrease through delegation chains, never increase.[^12]

Three major commerce protocols are adopting Verifiable Intent: AP2 (Google/Mastercard), ACP (Stripe/OpenAI), and UCP (Google/Shopify/Walmart). The specification is built on established standards: SD-JWT, JWT, JWS, and ES256 from IETF, FIDO Alliance, EMVCo, and W3C.[^11]

## The Regulatory Convergence

These technical developments are not happening in isolation. Regulators are converging on the same questions.

### NIST: Agent Identity as National Priority

In February 2026, NIST released "Accelerating the Adoption of Software and Artificial Intelligence Agent Identity and Authorization," a concept paper proposing demonstrations of identity and authorization practices for AI agents in enterprise settings. The paper, authored by Ryan Galluzzo (who leads NIST's digital identity program) and colleagues, covers four focus areas:[^13]

- **Identification:** distinguishing AI agents from human users
- **Authorization:** applying standards like OAuth 2.0 to define agent rights
- **Access delegation:** linking user identities to AI agents
- **Logging and transparency:** linking agent actions to their non-human entity

The comment period runs through April 2, 2026, nearly the same time as the EU AI Act's high-risk obligations begin enforcement (August 2026). This is not a coincidence. Both the US and EU regulatory apparatus are recognizing that agent identity is a foundational governance requirement.

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

**Zero-Knowledge Proofs for compliance.** The framework specifies ZKPs to enable privacy-preserving attribute disclosure: an agent can prove it meets specific compliance requirements or holds a particular certification without revealing the underlying data. This matters for cross-organizational trust because it allows agents to satisfy verification requirements without over-disclosing. A financial services agent can prove SOX compliance without revealing its internal audit documentation.

**Unified session management.** A global policy enforcement layer that propagates revocations instantly across heterogeneous multi-agent systems. When an agent's authority is revoked, the revocation takes effect at every interaction point simultaneously, not at the next token refresh. This addresses a practical gap in current implementations where revocation latency creates windows of unauthorized action.

The CSA framework, the NIST concept paper, and the OpenID AIIM group are converging on the same architectural conclusion: agents need identity infrastructure purpose-built for autonomy, ephemerality, and delegation. The building blocks (DIDs, VCs, scoped tokens) exist. The remaining work is integration and operational maturity.

### eIDAS 2.0 and EUDI Wallets

The European Digital Identity framework (eIDAS 2.0) is building the infrastructure for digital identity wallets that could extend to agents. EUDI wallets give citizens and businesses cryptographic credentials that work across the EU. The same infrastructure, DIDs, VCs, and trust registries, is directly applicable to agent identity.

When an agent operating in the EU needs to prove its organizational affiliation, its compliance status, or its authorization to act, EUDI wallet infrastructure provides the verification layer. This connects the Control pillar to the Accountability pillar: the same infrastructure that proves identity also creates the audit trail regulators require.[^10]

## Connecting to PAC

Agent identity is where all three pillars of the PAC Framework intersect:

**Potential.** Identity infrastructure determines what agents can do. Without proper delegation, agents are limited to single-system, single-organization tasks. With verifiable identity and cross-organizational trust, agents can operate across boundaries, unlocking higher-value use cases (V3 Strategic and V4 Transformative in the PAC [business value scale](pac-framework.md)).

**Accountability.** Every identity decision creates or breaks an audit trail. OBO tokens track who delegated. Verifiable Intent proves what was authorized. DID-signed actions prove who acted. Without this infrastructure, the liability chain dissolves the moment an agent makes an autonomous decision.

**Control.** Identity is the enforcement mechanism. Scoped credentials, DPoP-bound tokens, monotonically decreasing authority through delegation chains, and infrastructure-level restrictions (I3 and above) all depend on the agent having a verifiable identity that carries explicit, bounded authority.

The infrastructure scale from the PAC Framework maps directly to identity maturity:

| Infrastructure Level | Identity Capability |
|---|---|
| I1 (Open) | No agent identity; acts under user credentials |
| I2 (Logged) | Agent actions logged but not identity-scoped |
| I3 (Verified) | OBO delegation, scoped credentials, audit trails |
| I4 (Authorized) | Verifiable identity, cross-org trust, purpose encoding |
| I5 (Contained) | Full delegation chains, verifiable intent, sandboxed execution |

Most organizations are between I1 and I2 today. The standards described in this chapter provide the path to I3 through I5.

## What to Do Now

The standards are landing but not yet universal. For teams deploying agents today:

**Start with OBO.** If your identity provider supports RFC 8693 token exchange, use it. Dual-identity tokens that track both user and agent are the minimum for accountable delegation.

**Bind tokens to keys.** DPoP is available now and prevents the most common credential theft scenarios. If your agents hold long-lived tokens, bind them.

**Scope aggressively.** Default to the narrowest permissions possible. Resist the temptation to grant broad scopes "for flexibility." Every unnecessary permission is attack surface.

**Log the delegation chain.** Even before you have formal delegation infrastructure, log who authorized what at every hop. When the incident comes, this is what you will need.

**Watch the standards.** The NIST comment period (April 2, 2026), the OpenID AIIM Community Group, and the Verifiable Intent specification are all active. These will shape how agent identity works for the next decade.

The identity layer for agents is being built right now, in IETF drafts, W3C specifications, and open-source implementations. The organizations that adopt this infrastructure early will have accountable, auditable agent deployments. The ones that wait will be explaining to regulators why they cannot trace what their agents did.

For how identity extends across organizational boundaries, see [Cross-Organization Trust](cross-org-trust.md). For how delegation chains compose (and break) in multi-agent systems, see [Multi-Agent Trust and Orchestration](multi-agent-trust.md).

---

[^1]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," February 3, 2026.
[^2]: Shane Deconinck, "Auth for Agent Builders: A Crash Course," January 26, 2026.
[^3]: Shane Deconinck, "Google's New Workspace CLI Is Agent-First. OAuth Is Still App-First," March 5, 2026.
[^4]: IETF RFC 8693, "OAuth 2.0 Token Exchange," January 2020.
[^5]: IETF, "OAuth 2.0 Extension: On-Behalf-Of User Authorization for AI Agents," draft-oauth-ai-agents-on-behalf-of-user-02.
[^6]: IETF RFC 9449, "OAuth 2.0 Demonstrating Proof of Possession (DPoP)," September 2023.
[^7]: Auth0, "Auth0 for AI Agents," generally available November 2025.
[^8]: Shane Deconinck, "My Content Comes with Verifiable Credentials. Your Agent Can Verify," February 22, 2026.
[^9]: Shane Deconinck, "Understanding TSP: The Trust Spanning Protocol Explained," trustedagentic.ai explainer.
[^10]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," January 24, 2026.
[^11]: Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," March 6, 2026.
[^12]: Mastercard, "How Verifiable Intent Builds Trust in Agentic AI Commerce," March 5, 2026.
[^13]: NIST NCCoE, "Accelerating the Adoption of Software and Artificial Intelligence Agent Identity and Authorization," February 5, 2026.
[^14]: OpenID Foundation, "Identity Management for Agentic AI," Artificial Intelligence Identity Management Community Group whitepaper, 2025.
[^gravitee]: Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control," gravitee.io, 2026. Survey of 900+ executives and technical practitioners.
[^csa]: Cloud Security Alliance, "Agentic AI Identity & Access Management: A New Approach," cloudsecurityalliance.org, 2025-2026. Framework proposing DID+VC+ZKP-based IAM for multi-agent systems.
[^entra-agent-id]: Microsoft, "What is Microsoft Entra Agent ID?," learn.microsoft.com, March 2026. Part of Microsoft Agent 365, generally available May 1, 2026. See also ConductorOne, "Future of Identity Report 2026," March 10, 2026.
[^teleport]: Teleport, "2026 State of AI in Enterprise Infrastructure Security," February 17, 2026. Survey of 205 senior infrastructure and security leaders. See also Teleport, "Agentic Identity Framework," goteleport.com, January 27, 2026.
