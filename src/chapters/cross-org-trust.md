# Cross-Organization Trust

Within a single organization, extending existing IAM to handle agents is tractable. You control the identity provider, the authorization server, the policy engine, and the audit system. You can add OBO token exchange, scope your OAuth grants tighter, build agent registries, and enforce sandboxing, as the [Agent Identity and Delegation](agent-identity.md) chapter covers in depth. It is hard, but it is one team's hard problem.

The hard problem starts when agents cross trust boundaries. Your agent calls my API. My agent delegates to a third party's service. A customer's agent negotiates with a supplier's agent, neither of which existed when the business relationship was established. Every assumption that makes intra-organization agent governance tractable (shared identity provider, centralized policy enforcement, common audit infrastructure) disappears at the organizational boundary.

The PAC Framework's Control pillar question is direct: "When agents cross organisational boundaries, how do you authenticate, pass authority, and keep someone accountable?"

## The Problem Is Structural

Cross-organization trust for agents is not a new version of API federation. It is a different problem because agents create intent rather than forwarding it.

When traditional software integrates across organizations, the interaction pattern is predictable: API A calls API B with predetermined parameters. The trust model is static: mutual TLS, shared API keys, OAuth client credentials. Both sides know in advance what calls will be made and what data will flow.

Agents break this model in three ways.

**Dynamic intent.** An agent authorized to "manage travel expenses" might call a booking API, a payment processor, and a currency conversion service. None of these interactions were enumerated when the agent was authorized. The action space is open-ended.

**Multi-hop delegation.** Agent A delegates to Agent B, which delegates to Agent C. Each hop crosses a trust boundary. The original user's authorization needs to travel through a chain of entities that may not trust each other and may never have interacted before.

**Semantic divergence.** Shane described a scenario from the LFDT meetup where an agent authorized to "close a deal" at one company means: sign, reject, or renegotiate. At the counterparty, "close a deal" means only sign or reject. The agent might negotiate when it was only expected to accept or reject.[^1] The same words carry different authority in different domains.

### What the Drift Breach Revealed

The Salesloft Drift AI chat agent breach exposed over 700 companies in ten days via stolen OAuth tokens.[^2] When Drift's OAuth integration was compromised, attackers inherited access across more than 700 independent trust domains: Google Workspace, Cloudflare, Heap, and hundreds more.

The deeper failure was not the token theft itself. It was that each domain validated credentials in isolation. No domain knew what the agent was authorized to do in other domains. No domain could revoke access across the others. No domain could detect that the same compromised credential was being exercised simultaneously across 700 organizations.

The CSA identified three requirements that current infrastructure lacks:[^2]

- **Delegation proof**: tokens that explicitly differentiate user identity from agent identity and carry verifiable proof of the delegation chain
- **Operational envelopes**: cryptographic constraints that travel with the token and define what an agent can do, not just what resources it can access
- **Coordinated revocation**: shared, real-time risk signals between providers so revocation in one domain invalidates access in others

These requirements map to the Control pillar. Verifiable delegation is agent identity infrastructure. Operational envelopes are authorization infrastructure. Coordinated revocation is containment infrastructure. None of them work in isolation; all three must function across organizational boundaries.

## The Token Model's Structural Limit

Nicola Gallo, co-chair of the Trusted AI Agents working group at the Decentralized Identity Foundation, framed this at the LFDT Belgium meetup: we treat authority as an object.[^1] We create tokens, store them, transfer them, consume them. Whoever holds the token can exercise the authority. A stolen token works. A replayed token works. A token used in an unintended context works. Possession equals authority.

This works within a perimeter. Within a single organization, you control the token issuer, the token validator, and the enforcement points between them. You can add short expiry, audience restrictions, DPoP binding. The token model's weaknesses are mitigated by the infrastructure around it.

Agents removed the perimeter. And in distributed systems with asynchronous operations and messaging, the token model has specific failure modes:

- How do you pass tokens when you do not know the next worker?
- How do you scope tokens when the agent might not come alive before the token expires?
- How do you enforce audience restrictions when the agent dynamically discovers which services to call?

The industry workaround is service accounts and access keys that create authority under their own identity. And that is exactly where the confused deputy is guaranteed. The agent acts with its own credentials, the original user's authorization is severed, and the audit trail shows only "service-account-agent-47 accessed customer-database," not "Alice authorized her travel agent to look up her frequent flyer number."

## From Possession to Continuity: PIC

Gallo reframes the structural elements of authorization:[^1][^3]

- **Identity**: represents a subject
- **Intent**: the desired action of that subject
- **Authority**: identity + intent (created when an identity expresses a will)
- **Workload**: the executor that continues or creates authority
- **Governance**: can stop, restrict, or leave authority unchanged, but never expand it

Authority exists only when execution preserves the origin. This is PIC: Provenance, Identity, Continuity. The new primitive is proof of continuity instead of proof of possession.

Each execution step forms a virtual chain. The workload proves it can continue under the received authority, satisfying the guardrails (department membership, company affiliation, spending limit). The trust plane validates this at each step and creates the next link. Authority can only be restricted or maintained, never expanded.

To continue authority, a workload does not need its own identity. It just needs to prove it can operate within the received authority's constraints. But to create authority, you need an identity and an expressed intent. That distinction is what makes the model work for agents.

Under this model, the confused deputy is not detected or mitigated. It is eliminated. If Alice asks an agent to summarize a file she does not have access to, the agent cannot execute under its own authority: the continuity chain carries Alice's original permissions. The only way to access that file is to create new authority, which is a deliberate act with its own accountability, not an accidental confused deputy.

This maps to the PAC Framework's Control pillar: "Can authority only decrease?" PIC answers yes, and proves it mathematically. The monotonic property (authority can only decrease through a delegation chain) is not a policy aspiration but a structural guarantee.

Gallo also demonstrated that performance is not a blocker: executing a continuity chain takes microseconds, comparable to a token exchange call.[^1] The overhead is a deployment concern, not an architectural one.

## Trust Spanning Protocol: Identity Across Boundaries

While PIC solves authority propagation within a system, a different problem exists at the boundary: how do two parties that have never met verify each other without a shared authority?

The Trust Spanning Protocol (TSP), developed by the Trust over IP Foundation under Linux Foundation Decentralized Trust, addresses this.[^4][^5] TSP does exactly three things: encrypt, sign, and address messages using verifiable identifiers. It is deliberately minimal.

### How TSP Works

Instead of reusing the human's credentials or relying on pre-established OAuth relationships, the agent gets its own verifiable identifier (typically a DID). It presents itself as: "I am agent of so-and-so, here is the authorization I got from them." That authorization can be verified, scoped, and made accountable.

The protocol flow:

1. **VID Resolution.** Both endpoints fetch each other's DID documents to obtain public keys. No shared identity provider required.
2. **Registry Verification.** Check trust registries (or verifiable credentials) to confirm legitimacy of the counterparty.
3. **Cryptographic Operations.** Sign messages with private keys (authentication) and encrypt with recipient's public key (confidentiality).
4. **TSP Envelope.** Messages travel in a signed and encrypted container. Who said what to whom is preserved for accountability, while content and metadata stay protected.

The verifiable identifiers are long-term and durable, supporting key rotation with pre-commits so agents can build verifiable history over time. This enables something like reputation: an agent's track record becomes a verifiable property rather than just a database entry.[^1]

### The Thin Waist Architecture

TSP is designed as a spanning layer, analogous to IP in networking. It does not care about transport (HTTPS, WebSocket, Bluetooth), identifiers (DIDs, KERI, X.509), or encoding (JSON, CBOR). This makes it composable with existing infrastructure rather than a replacement for it.

Agent protocols like MCP and A2A can run on top of TSP (the [Agent Communication Protocols](agent-communication.md) chapter covers MCP and A2A architecture in detail):[^5]

- **TA2A (A2A over TSP)**: the Agent-to-Agent Protocol handles discovery and task semantics, while TSP handles identity verification and message encryption.
- **TMCP (MCP over TSP)**: the Model Context Protocol runs over TSP's trust layer, enabling agents to connect to previously unknown tool servers with cryptographic verification instead of pre-established API keys.

Replacing MCP's transport layer with TSP and introducing a wallet and identifiers gives you the same JSON-RPC calls, but now every interaction is authenticated, signed, and traceable. The higher layers become simpler because the foundation handles identity and trust.[^1]

This is a direct answer to the cross-organization problem. Today, if your agent needs to call a new API, someone has to register OAuth credentials, exchange secrets, establish mutual TLS, or add the endpoint to an allowlist. With TSP, the agent resolves the counterparty's DID, verifies their credentials, and establishes an authenticated channel at runtime. No pre-registration. No shared infrastructure. No manual onboarding.

### MCP-I: Protocol-Level Identity for MCP

TMCP wraps MCP in TSP's transport trust. A complementary approach works from the other direction: adding identity semantics directly to the protocol. MCP-I (Model Context Protocol - Identity), developed by Vouched and donated to the Decentralized Identity Foundation's Trusted AI Agents Working Group in March 2026, extends MCP with a complete identity and delegation layer using DIDs and Verifiable Credentials.[^12]

Where TMCP replaces the transport, MCP-I defines what agents must prove at the protocol level. An agent approaching a service presents three things: its own DID (agent identity), a VC from its human principal (user authorization), and a delegation credential scoping what the agent is permitted to do (not binary access, but structured policy). The verifier, typically an edge proxy, validates all three before the MCP call proceeds.

MCP-I defines three conformance levels. Level 1 bridges legacy: foundational support using existing identifiers (OIDC, JWT) for immediate implementation. Level 2 requires full DID verification, credential-based delegation, and revocation support. Level 3 adds enterprise-tier credential lifecycle management and immutable audit trails. This graduated approach is pragmatic: organizations can start at Level 1 without rebuilding their identity infrastructure, then tighten as their agent deployments mature.[^12]

MCP-I and TMCP are not competing. TMCP provides the trusted channel (how messages travel securely). MCP-I provides the identity semantics (what the agent must prove before acting). Together, they address all three of Shane's MCP trust gaps: server identity (DID verification), capability proof (delegation credentials with scoped permissions), and delegation chains (VC chain from human principal through agent to service).[^1]

## Where TSP and PIC Meet

**TSP solves the cross-domain trust problem.** How do you verify who you are dealing with across organizational boundaries? Verifiable identifiers, authenticated channels, delegation that travels with the request.

**PIC solves the authority propagation problem.** Once you are inside a system, how do you ensure that the permission scope does not expand as work passes between agents, APIs, and workloads?

Both share a conviction: existing web protocols (HTTP, OAuth, TLS) are mature and valuable, but insufficient for agents. Unlike human employees whose roles change occasionally, agents perform diverse, one-off tasks that cannot be pre-categorized into static permission sets. Authorization needs to be dynamic, fine-grained, and task-specific.

Both are designed to work with existing infrastructure, not replace it. PIC can use OAuth as a federated backbone, embedding its causal authority in custom claims. TSP is agnostic to identifier types, making it compatible with systems like EUDI wallets and verifiable credentials.

### CAAM: The Authorization Mesh

TSP establishes identity across boundaries. PIC ensures authority cannot expand through delegation chains. But what happens in between: after an agent is discovered but before it executes a tool call?

The Contextual Agent Authorization Mesh (CAAM, draft-barney-caam-00, February 2026) addresses this gap through a sidecar-based authorization mediator that intercepts tool calls outside the agent's reasoning loop.[^caam] The core mechanism is the Session Context Object (SCO): a cryptographically signed JWT or CWT carrying purpose constraints, scope ceiling, delegation depth, attestation evidence, and a contextual risk score. Every tool call passes through the sidecar, which evaluates the SCO against declared policies before the call proceeds.

Two architectural choices stand out.

First, CAAM introduces what the authors call the Ghost Token Pattern. Raw delegation tokens never reach the agent. They remain in a vault managed by the sidecar. When the agent needs to act, the sidecar synthesizes a short-lived, single-use token bound to the specific request, the current SCO, and the contextual risk score. The agent operates with ephemeral credentials that cannot be replayed, exfiltrated, or used outside their intended context. This addresses the token-as-authority-object problem that PIC solves theoretically: CAAM solves it at the infrastructure layer through token isolation.

Second, CAAM requires AuthZ-at-Discovery: before a session is established, the agent must advertise its SPIFFE trust domain, supported attestation evidence types, inference boundary hash, and policy manifest URI. The receiving party evaluates this security posture before permitting any interaction. This operationalizes the transparency label concept at the protocol level: the agent's security properties are machine-verifiable preconditions, not post-hoc audit artifacts.

CAAM is an early individual draft, not yet adopted by an IETF working group. But the architecture it describes composes naturally with the rest of the stack: SPIFFE for workload identity, RATS (RFC 9334) for execution environment attestation, TSP for cross-boundary channels, and PIC for authority continuity. The sidecar model is the practical deployment pattern for "infrastructure in the loop": authorization decisions happen in a layer the agent cannot influence, even if it is compromised.

## Verifiable Credentials as the Trust Carrier

For cross-organization agent trust, credential format determines what can travel across boundaries.

Shane's EUDI credential formats crash course walks through the four formats the European Digital Identity Wallet supports: X.509, mdoc, SD-JWT VC, and W3C VC.[^6] Each has different strengths:

- **X.509** is the trust anchor: hierarchical CA chains, battle-tested, the backbone of TLS and eIDAS trust services. It binds a key to an identity but has no selective disclosure.
- **mdoc (ISO 18013-5)** excels at proximity: NFC, BLE, compact CBOR encoding. Selective disclosure through per-claim salted hashes. Designed for in-person verification.
- **SD-JWT VC** meets the web where it is: built on the OAuth/OIDC stack, JSON encoding, selective disclosure through salted hashes in JWTs. Mastercard and Google's Verifiable Intent uses SD-JWT credential chains for delegated agent payments.
- **W3C VC** carries meaning across borders: JSON-LD with resolvable vocabularies, so a German employer's system can interpret a Spanish diploma's qualification level deterministically, not by convention. With BBS signatures, it also provides unlinkability: each presentation generates a mathematically distinct proof.

| Requirement | SD-JWT VC | W3C VC |
|---|---|---|
| Selective disclosure | Yes (salted hashes) | Yes (ECDSA-SD or BBS) |
| Semantic interoperability | Type identifier (`vct`) | Resolvable vocabularies (`@context`) |
| Unlinkability | No | Yes (BBS, not yet EUDI-approved) |
| Web-native | Yes (JWT stack) | Requires JSON-LD processing |
| Agent commerce | Verifiable Intent (SD-JWT chains) | Not yet adopted |

The choice is not either/or. SD-JWT VC handles the common case: agent delegation within known credential types, web-native verification, integration with existing OAuth infrastructure. W3C VC handles the hard case: cross-border credentials where meaning must be machine-resolvable, and privacy-preserving presentations where unlinkability matters.

### Content Provenance: VCs in Practice

Shane demonstrated a practical application of VCs for cross-organization trust: signing blog posts with Verifiable Credentials so that agents can verify content authenticity before acting on it.[^7]

Every post on his blog carries a `vc.json`: a W3C Verifiable Credential binding the content hash (SHA-256 over JCS-canonicalized fields) to his DID (`did:webvh`), signed with an Ed25519 Data Integrity proof. A `<link rel="verifiable-credential">` tag makes the VC machine-discoverable.

He then tested whether a coding agent could verify the credential autonomously. Given only "verify" as a prompt, Claude Code:

1. Resolved his DID by fetching the DID document
2. Checked the content hash against the canonical content
3. Verified the Ed25519 signature using the `eddsa-jcs-2022` cryptosuite
4. Cross-referenced the DID against his GitHub profile

The agent hit two real problems (a trailing newline breaking the content hash, and an `@context` ambiguity in the proof options) and debugged both by reasoning through the standards.[^7]

This is cross-organization trust at the content layer. No shared infrastructure between the blog and the agent. No pre-established relationship. The trust comes from the cryptographic proof: the DID resolves to a public key, the signature is valid, the content hash matches. The agent verified a stranger's content without phoning home to any authority.

It is also fragile. It only happened because the prompt said "verify." Without standardized conventions for where authors publish their DIDs and how agents discover VCs, this remains opt-in and manual. But the building blocks work.

## The Credential Delegation Architecture

For agents, the delegation chain needs to be carried in credentials, not just tokens.

### The Three-Layer Chain

Agent credential delegation is converging on a three-layer structure, visible independently in Para's AI wallet architecture, Verifiable Intent's SD-JWT chain, and Trulioo's Digital Agent Passport:[^8]

1. **User Identity Layer.** The human completes identity verification once, receiving a cryptographic attestation tied to their identifier (whether a DID, wallet address, or organizational credential).
2. **Delegation Layer.** The user cryptographically authorizes the agent with scoped permissions: spending limits, approved services, time bounds, purpose constraints. This delegation is a signed credential, not just a token.
3. **Transaction Layer.** The agent executes within delegated constraints, with every action traceable to the verified human through the credential chain.

This maps to the PAC Framework's accountability requirements: the delegation is verifiable (who authorized), scoped (what was authorized), and traceable (what happened). The credential chain survives across organizational boundaries because it is self-contained: the verifier does not need to contact the delegator to validate the chain.

### Verifiable Intent as Operational Envelope

Mastercard and Google's Verifiable Intent specification, discussed in the [Agent Payments](agent-payments.md) chapter, provides a concrete implementation of what the CSA calls "operational envelopes": cryptographic constraints that travel with the authorization.[^9]

The three-layer SD-JWT architecture binds user intent to agent actions:

- **Layer 1 (Identity)**: who authorized this?
- **Layer 2 (Intent)**: what constraints apply?
- **Layer 3 (Action)**: what was actually done?

Each layer is cryptographically chained. The agent cannot present Layer 3 (action proof) without a valid Layer 2 (intent constraints), which requires a valid Layer 1 (user identity). The constraints are not advisory: they are enforced by the cryptographic structure.

The operational envelope travels with the request. When Agent A calls Service B with a Verifiable Intent credential, Service B can verify not just "is this request authenticated?" but "what was this agent authorized to do, by whom, and does this specific action fall within those constraints?" Without contacting Agent A's organization.

## A Society of Agents

Phil Windley frames cross-domain delegation as a problem of institutional design, not just a technical challenge.[^10] His model introduces four complementary mechanisms:

**Policies** establish deterministic boundaries within each agent's domain. They function as technical guardrails that prevent violations regardless of an agent's intentions. Policies constrain what an agent is capable of doing, enforced locally.

**Promises** communicate behavioral commitments across boundaries. An agent making a promise articulates how delegated authority will be constrained: maintaining spending limits, restricting resource access, operating within defined parameters. Promises are declarations of intent, not enforcement mechanisms. Their credibility depends on grounding in the agent's actual policies.

**Credentials** carry delegated authority and provide evidence of that delegation. They serve dual roles: contextual inputs to policy engines and portable proof of authorization. Credentials can cross boundaries because they are self-contained.

**Reputation** provides distributed social memory. Rather than centralizing trust scoring, each agent maintains independent records of past interactions. Two agents may reach different conclusions about the same participant depending on their experiences. Trust emerges from the accumulation of many local observations, not from a single global authority.[^10]

The interaction sequence for cross-domain delegation:

1. The receiving agent declares bounded behavior intentions (promise)
2. The delegating agent evaluates promises using social memory (reputation)
3. The delegating agent issues a portable credential encoding the delegated capability and constraints
4. The receiving agent acts on the resource using the credential
5. The delegating agent observes outcomes through system signals or cryptographic receipts
6. The delegating agent updates reputation records based on observed behavior

Cross-domain delegation cannot rely on centralized enforcement. Windley's key insight: "Policies without promises cannot coordinate behavior across systems. Promises without enforcement are merely declarations of intent. Reputation without boundaries turns governance into little more than hindsight."[^10] Only their integration creates functioning agent ecosystems.

## The EUDI Wallet Infrastructure

The European Digital Identity Wallet, mandated by eIDAS 2.0, is building the credential infrastructure that cross-organization agent trust requires at continental scale.[^6][^11]

By December 2026, every EU Member State must offer an EUDI Wallet, interoperable across 27 countries and 450 million citizens. The wallet stores government-verified credentials (identity documents, professional qualifications, educational certificates) and enables selective presentation: share only what is needed for a specific interaction.

For agent trust, the EUDI infrastructure provides three things that do not exist at scale today:

**Trusted issuer infrastructure.** Governments, universities, professional bodies, and enterprises issue credentials into wallets. These issuers are registered in trusted lists maintained by EU Member States. An agent presenting a credential from a trusted issuer carries verifiable proof of its principal's identity and qualifications.

**Cross-border credential recognition.** A credential issued in Spain is verifiable in Germany because both countries participate in the same trust framework. The W3C VC format with resolvable vocabularies enables semantic interoperability: a machine can determine that a Spanish qualification maps to a specific EQF level without human interpretation.[^6]

**Business wallets.** Companies can authenticate themselves, sign contracts, and prove attributes required for various transactions. When combined with agent delegation credentials, business wallets become the infrastructure for proving that "this agent acts on behalf of Company X, authorized to negotiate contracts up to EUR 50,000."

The EUDI Wallet is not designed for agents specifically. But the infrastructure it creates: trusted issuers, cross-border verification, selective disclosure, business credentials: is the foundation that cross-organization agent trust needs. TSP is designed to interoperate with EUDI wallets. PIC can validate continuity chains anchored in EUDI-issued credentials.

The EU is starting to make this connection explicitly. In March 2026, the WE BUILD consortium, one of the EU's Large Scale Pilots for EUDI Wallets, issued three recommendations: develop a safe AI agent strategy built on the EUDI framework and Business Wallet infrastructure, establish standards working groups for interoperability between EUDI wallets and AI agents, and prioritize testing and pilots before regulation.[^we-build] The framing inverts the usual narrative: not "AI in wallets" (using AI to improve wallet UX) but "wallets for AI agents" (using wallet infrastructure to govern autonomous systems). The specific capabilities they identify map directly to the cross-org trust requirements: mutual authentication between agents and merchants, verification of the relationship between a human and their agent, confirmation of counterparty legitimacy, and digital signatures to distinguish authentic from AI-generated content. This is the first EU pilot consortium to explicitly recommend EUDI infrastructure as the substrate for AI agent governance.

Shane's analysis of the EUDI credential formats identified a significant gap: W3C VC, the format best suited for cross-border semantic interoperability, has de jure inclusion but de facto exclusion in the current implementing regulations.[^6] The operational scaffolding (PID encoding tables, presentation profiles, issuance protocol specifications) exists only for mdoc and SD-JWT VC. A significant share of substantive contributions to a recent public consultation converged on this diagnosis. Whether and when this gap closes will determine how effectively the EUDI infrastructure serves cross-border agent trust.

There is also a cryptographic contradiction. Article 5a(16)(b) of the regulation requires unlinkability where identification is not needed, but the only format that delivers it cryptographically (W3C VC with BBS signatures) uses a curve (BLS12-381) that is not on the SOG-IS/ECCG Agreed Cryptographic Mechanisms list.[^6] A legal obligation without a cryptographic mechanism. For agents operating across borders with privacy requirements, this is a constraint worth tracking.

## The Semantic Boundary Problem

Even with identity, delegation, and authority propagation solved, a fundamental problem remains: what do actions mean across boundaries?

Shane's example from the LFDT meetup makes this concrete.[^1] An agent authorized to "close a deal" at one company can sign, reject, or renegotiate. At the counterparty, "close a deal" means only sign or reject. The agent might negotiate when it was only expected to accept or reject. The authority was correctly delegated. The identity was correctly verified. The action fell within the delegated scope. But the semantic meaning of that scope differed across organizations.

This is not unique to agents. The same problem exists when federating OAuth scopes across identity providers. But agents amplify it because they operate dynamically across domains that cannot be anticipated. A human encountering an unfamiliar scope would ask for clarification. An agent interprets and acts.

Solving this requires not just identity and authority, but shared understanding of what actions mean across boundaries. W3C VC's `@context` mechanism provides one approach: every claim links to a resolvable vocabulary, so machines can determine meaning deterministically. The European Learning Model, for example, enables a German system to interpret a Spanish qualification level automatically.[^6]

For agent authorization, the equivalent would be resolvable action vocabularies: machine-readable definitions of what "close a deal" or "approve payment" means in a specific organizational context. Neither TSP nor PIC claims to fully solve this today. But by getting identity, communication, and authority propagation right at the foundation, the semantic layer above becomes tractable.[^1]

## Mapping to PAC

Cross-organization trust touches all three pillars.

| PAC Dimension | Cross-Organization Trust Requirement |
|---|---|
| **Potential: Business value** | Agent commerce, cross-border services, multi-party workflows that cannot exist without cross-org trust |
| **Potential: Durability** | TSP, PIC, VCs, EUDI wallets: built on open standards designed for longevity |
| **Accountability: Delegation tracking** | Credential chains that survive across organizational boundaries |
| **Accountability: Audit trails** | TSP's authenticated messaging preserves who-said-what-to-whom across domains |
| **Accountability: Liability chains** | PIC's provenance tracking connects every action to its origin across hops |
| **Control: Agent identity** | TSP verifiable identifiers, DID-based agent authentication |
| **Control: Delegation chains** | PIC's monotonic authority (can only decrease, never expand) |
| **Control: Cross-org trust** | TSP + PIC + VCs: the complete stack for cross-boundary agent governance |
| **Control: Confused deputy** | PIC eliminates it structurally; TSP prevents impersonation |
| **Control: Standards** | TSP (ToIP/LFDT), PIC (DIF), MCP-I (DIF), VCs (W3C), EUDI (eIDAS 2.0), Verifiable Intent (Mastercard/Google) |

The Control pillar carries the most weight here because cross-organization trust is primarily an infrastructure problem. But the Potential argument is what justifies the investment: without cross-org trust, agent value is capped at what a single organization can achieve internally. And the Accountability argument is what makes it governable: without verifiable delegation chains and audit trails that survive across boundaries, cross-org agent interactions are liability black holes.

## Infrastructure Maturity for Cross-Organization Trust

Mapping to the PAC Framework's infrastructure scale:

**I1 (Open).** Agents cross boundaries using static API keys or shared service accounts. No delegation tracking. No identity verification. The Drift scenario.

**I2 (Logged).** Agents cross boundaries with logged API calls. OBO token exchange provides basic delegation tracking within a single trust domain, but delegation chains break at organizational boundaries.

**I3 (Verified).** Agents carry verifiable credentials for cross-boundary authentication. TSP enables identity verification without shared infrastructure. Delegation chains are cryptographically verifiable but authority scoping is policy-based, not structural.

**I4 (Authorized).** PIC or equivalent provides structural authority containment. Delegation chains are monotonic (authority can only decrease). Operational envelopes (Verifiable Intent) encode constraints cryptographically. Coordinated revocation operates across domains.

**I5 (Contained).** Full stack: TSP for identity and communication, PIC for authority continuity, VCs for credential portability, reputation systems for distributed trust assessment, semantic interoperability for cross-domain action meaning. Anomaly detection operates across organizational boundaries.

Most cross-organization agent interactions today are at I1 or I2. The infrastructure described in this chapter enables I3-I5, but production deployments at scale are still emerging. TSP reached Revision 2 in November 2025. PIC is being developed with a formal model and growing community. EUDI wallets are mandated by December 2026. The standards are landing; the implementations are following.

## Practical Recommendations

**If you are building agent integrations across organizations today:**

Start with OBO token exchange (RFC 8693) for delegation tracking within federated OAuth domains. It does not solve cross-boundary trust, but it captures the delegation chain within your trust domain, which is prerequisite infrastructure for everything else.

**If you are planning cross-organization agent capabilities:**

Track TSP, TA2A/TMCP, and MCP-I. When your agents need to interact with previously unknown counterparties, DID-based identity verification will replace manual OAuth credential registration. MCP-I's conformance levels provide a migration path: start with Level 1 (DIDs alongside existing OIDC) and progress as your agent deployments mature. Evaluate whether your credential infrastructure can issue and verify VCs.

**If you are in the EU:**

The EUDI Wallet timeline (December 2026) creates both an opportunity and an obligation. Business wallets will provide the credential infrastructure for agent delegation. Organizations that integrate with EUDI early get cross-border agent trust as a byproduct.

**For everyone:**

Design delegation as credentials, not just tokens. A token expires and is gone. A credential can be revoked, audited, and verified long after the interaction. Build your agent authorization to produce verifiable artifacts, because cross-organization trust requires proof that survives across boundaries.

Every agent that calls an external API, processes third-party data, or delegates to another organization's service is operating across trust boundaries. The question is not whether your agents will cross those boundaries, but whether they will do so with verifiable identity, bounded authority, and accountable delegation chains, or without.

[^1]: Shane Deconinck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," March 11, 2026. LFDT Belgium meetup reflections on TSP and PIC.
[^2]: Cloud Security Alliance / Okta, "AI Security Across Domains: Who Vouches?" March 11, 2026. Part of a seven-part series on identity security as AI security. Documents the Salesloft Drift breach and three requirements for cross-domain agent trust.
[^3]: PIC Protocol, pic-protocol.org. Provenance, Identity, Continuity: formal execution model for distributed systems.
[^4]: Trust Spanning Protocol Specification, trustoverip.github.io/tswg-tsp-specification/. Revision 2, November 2025.
[^5]: Shane Deconinck, "Understanding TSP: The Trust Spanning Protocol Explained," shanedeconinck.be/explainers/tsp/.
[^6]: Shane Deconinck, "EUDI Credential Formats Crash Course: X.509, mDL, SD-JWT VC, and W3C VC," March 9, 2026.
[^7]: Shane Deconinck, "My Content Comes with Verifiable Credentials. Your Agent Can Verify," February 22, 2026.
[^8]: The three-layer pattern appears independently in: Para, "Agent Identity: How AI Wallets Inherit Human Credentials," 2026 (user identity → delegation → presentation); Mastercard/Google Verifiable Intent (user identity → SD-JWT delegation → network enforcement); Trulioo KYA (developer/user verification → Digital Agent Passport → merchant validation). See also arxiv.org/abs/2601.14982 for academic treatment of interoperable identity delegation.
[^9]: Mastercard, "How Verifiable Intent builds trust in agentic AI commerce," 2026. See also the Agent Payments chapter of this book.
[^10]: Phil Windley, "Cross-Domain Delegation in a Society of Agents," Technometria, 2026.
[^11]: European Commission, European Digital Identity (eIDAS 2.0), Regulation (EU) 2024/1183. EUDI Wallet implementation timeline: December 2026 for Member State availability.
[^12]: Vouched, "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation, March 5, 2026. MCP-I specification at modelcontextprotocol-identity.io. Three conformance levels for graduated adoption.
[^we-build]: WE BUILD consortium, reported in BiometricUpdate.com, "EU can rein in AI agents with EUDI Wallets and business wallets: WE BUILD," March 9, 2026. WE BUILD is one of the EU's Large Scale Pilots for EUDI Wallet implementation. See also Thierry Thevenet, "From AI in Wallets to Wallet for AI Agents," Medium, March 2026.
[^caam]: IETF, "Contextual Agent Authorization Mesh (CAAM)," draft-barney-caam-00, February 24, 2026. Authors: Jonathan M. Barney, Roberto Pioli, Darron Watson. Individual draft, expires August 28, 2026. Defines sidecar-based authorization mediator for post-discovery, pre-execution authorization with Session Context Objects, Ghost Token Pattern, and Contextual Risk Scoring.
