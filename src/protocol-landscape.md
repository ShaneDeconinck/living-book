# The Protocol Landscape

The infrastructure for trusted agents is being built right now, across multiple organisations, in parallel. None of it is fully deployed. But the direction is converging: make authority provable, decisions auditable, and trust verifiable across organisational boundaries.

This chapter maps what exists, what's emerging, and where the pieces connect.

## Within a Single Trust Domain: OAuth and OBO

The most mature approach uses what we already have. OAuth 2.0 and its extensions handle authentication and authorisation within a single organisation's boundary.

The key pattern for agents is On-Behalf-Of (OBO) from [RFC 8693](https://datatracker.ietf.org/doc/html/rfc8693). When an agent acts for a user, OBO lets the audit log show both who delegated authority and who acted. The agent gets a token that carries the user's identity alongside its own, so there's no ambiguity about delegation.

This works well within one trust domain: your agents, your identity provider, your resource servers. It falls apart when agents cross organisational boundaries, because there's no shared identity provider to anchor the chain.

## Extending OAuth for Agents

Several groups are working to make OAuth agent-aware:

**IETF draft-klrc-aiagent-auth** ([link](https://datatracker.ietf.org/doc/draft-klrc-aiagent-auth/)) describes how existing standards (WIMSE architecture, OAuth 2.0, OpenID CIBA) can be applied to agent authentication. Rather than defining new protocols, it identifies how existing ones map and where gaps remain. The draft expires September 2026.

**AAuth (Agentic Authorization)** ([link](https://www.ietf.org/archive/id/draft-rosenberg-oauth-aauth-00.html)) is an OAuth 2.1 extension for agents that interact through channels where traditional OAuth flows don't work (voice calls, texting). The agent collects PII through conversation and uses it to obtain constrained access tokens. A primary concern: ensuring LLM hallucination cannot result in impersonation.

**OpenID Connect for Agents (OIDC-A)** ([paper](https://arxiv.org/html/2509.25974v1)) extends OpenID Connect with agent-specific claims, attestation mechanisms, delegation chain support, and dedicated endpoints. Relying parties validate delegation chains by verifying chronological ordering, confirming each issuer is trusted, validating scope reduction at each step, and enforcing constraints.

**Agent Authorization Profile (AAP)** ([draft-aap-oauth-profile](https://datatracker.ietf.org/doc/html/draft-aap-oauth-profile-00.html)) defines an authorization profile for OAuth 2.0 and JWT designed specifically for autonomous AI agents. It extends existing standards without introducing a new protocol, focusing on how agents obtain and present credentials when operating independently.

**OAuth Scope Aggregation** ([draft-jia-oauth-scope-aggregation](https://datatracker.ietf.org/doc/draft-jia-oauth-scope-aggregation/)) addresses a practical problem in multi-step agent workflows: rather than requesting authorization at each step, the agent aggregates the scopes required across an entire workflow and initiates a single authorization procedure. This reduces user interruption while maintaining explicit consent for the full scope of agent action.

**Further Considerations on AI Agent Auth** ([draft-yao-agent-auth-considerations](https://www.ietf.org/archive/id/draft-yao-agent-auth-considerations-01.html)) extends the initial IETF agent auth draft with additional analysis of how OAuth extensions should be applied: covering agent registration, token lifecycle, and the boundaries between what existing standards handle and where new work is needed.

**Digital Identity Management for Agent Communication** ([draft-yl-agent-id-requirements](https://datatracker.ietf.org/doc/html/draft-yl-agent-id-requirements-00)) defines requirements for agent identity management in communication protocols: how agents should be identified, how identity metadata should be structured, and what lifecycle management looks like.

**Identity Assertion Authorization Grant** ([draft-ietf-oauth-identity-assertion-authz-grant](https://www.ietf.org/archive/id/draft-ietf-oauth-identity-assertion-authz-grant-00.html)) is an OAuth 2.0 extension that enables a client to exchange an identity assertion (like a SAML assertion or ID token) for an access token. This is relevant for agent scenarios where identity needs to cross protocol boundaries.

## Cross-Domain Trust: DIDs, VCs, and TSP

Within one organisation, a shared identity provider anchors trust. Across organisations, you need something else.

**Decentralised Identifiers (DIDs)** let an agent carry cryptographic proof of its identity without depending on a central authority. The agent's identity is self-certifying: anyone can verify it by checking the cryptographic material, no phone call to an identity provider required.

**Verifiable Credentials (VCs)** express not just "who is this?" but "what is it allowed to do?" and "who granted that permission?" A VC can encode delegation chains, capability constraints, and provenance, all cryptographically signed and independently verifiable.

**Trust Spanning Protocol (TSP)**, developed by the Trust over IP Foundation, enables strangers to verify each other without a shared identity provider. When two organisations' agents need to interact and neither trusts the other's IdP, TSP provides the bridge. ToIP and DIF (both under [Linux Foundation Decentralised Trust](https://www.lfdecentralizedtrust.org/)) launched three new working groups in 2025 specifically for this space: Decentralised Trust Graph, AI and Human Trust, and Trusted AI Agents.

## MCP: Plumbing, Not Trust

The Model Context Protocol (MCP) solves a real problem: the N×M integration challenge. Instead of every agent integrating with every tool separately, tool providers write an MCP server once and any agent can use it.

But MCP is plumbing, not trust. It was designed for functionality, and security was secondary. The [OWASP Top 10 for Agentic Applications (2026)](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/) catalogues the risks that emerge:

- **Tool poisoning**: malicious instructions hidden in tool descriptions that trick agents into exfiltrating data or executing unintended actions ([Pillar Security research](https://www.pillar.security/blog/the-security-risks-of-model-context-protocol-mcp))
- **Prompt injection through MCP sampling**: resource theft, conversation hijacking, and covert tool invocation ([Unit 42 / Palo Alto Networks](https://unit42.paloaltonetworks.com/model-context-protocol-attack-vectors/))
- **Architectural weaknesses**: session IDs exposed in URLs, minimal authentication guidance, no required message signing ([Red Hat analysis](https://www.redhat.com/en/blog/model-context-protocol-mcp-understanding-security-risks-and-controls))

MCP is now under the [AI Alliance](https://thealliance.ai/) at the Linux Foundation. The specification is evolving, and security improvements are in progress. But the lesson stands: connectivity without trust creates attack surface.

## Verifiable Intent

Mastercard and Google [open-sourced Verifiable Intent](https://www.mastercard.com/us/en/news-and-trends/stories/2026/verifiable-intent.html) in early 2026, with commitments from Fiserv, IBM, Checkout.com, Basis Theory, and Getnet. The specification and reference implementation are at [verifiableintent.dev](https://verifiableintent.dev).

Verifiable Intent creates a tamper-resistant record of what a user authorised when an agent acts on their behalf. It uses a three-layer SD-JWT structure:

- **L1 (Identity)**: who the user is, cryptographically bound
- **L2 (User Intent)**: what the user authorised, with constraints (budget limits, vendor restrictions, time windows)
- **L3 (Agent Action)**: what the agent actually did within those constraints

Each layer is signed. Selective disclosure means each party in a transaction sees only what they need: enough to verify authorisation or resolve a dispute, but not more. The agent cannot sub-delegate (L3 is terminal), and constraint enforcement happens at the network level, not inside the agent.

The technical foundation draws from widely adopted specs: FIDO Alliance, EMVCo, IETF, and W3C. It's designed to be protocol-agnostic, aligning with Google's Agent Payments Protocol (AP2) and the Universal Commerce Protocol (UCP).

## PIC: Provenance, Identity, Continuity

Nicola Gallo's [PIC protocol](https://github.com/pic-protocol/pic-spec) makes authority cryptographically traceable through delegation chains. The key property: authority can only decrease through the chain, never expand. Each hop in a delegation is signed, constrained, and verifiable independently.

Where Verifiable Intent focuses on the commerce use case (user → agent → merchant), PIC addresses the general case of multi-hop agent delegation with provable authority at every step.

## NIST: From Theory to Practice

NIST is moving from frameworks to implementation. In February 2026, the National Cybersecurity Center of Excellence (NCCoE) released a [concept paper](https://www.nccoe.nist.gov/projects/software-and-ai-agent-identity-and-authorization) proposing a demonstration project for AI agent identity and authorisation in enterprise settings.

The project focuses on four areas:
1. **Identification**: distinguishing agents from humans, managing metadata for action control
2. **Authorisation**: applying OAuth 2.0 extensions and policy-based access control
3. **Access delegation**: linking user identities to agents for accountability
4. **Logging and transparency**: linking agent actions to non-human entities for visibility

Standards under consideration include MCP, OAuth 2.0/2.1, OpenID Connect, SPIFFE/SPIRE, SCIM, and NGAC. The comment period runs through April 2, 2026 ([submit feedback](mailto:AI-Identity@nist.gov)).

Separately, NIST launched the [AI Agent Standards Initiative](https://www.nist.gov/caisi/ai-agent-standards-initiative) on February 17, 2026, through their Center for AI Standards and Innovation (CAISI). The initiative has three pillars: facilitating industry-led development of agent standards and US leadership in international standards bodies; fostering community-led open source protocol development for agents; and advancing research in agent security and identity. The initiative will coordinate with the National Science Foundation and other interagency partners. NIST plans to publish research, guidelines, and further deliverables throughout 2026.

## OpenID Foundation: The Trust Fabric

The OpenID Foundation's AI Identity Management (AIIM) Community Group [responded to NIST's RFI](https://openid.net/oidf-responds-to-nist-on-ai-agent-security/) in March 2026 with a key framing: there needs to be a "trust fabric" beneath the technical controls.

Their [whitepaper (October 2025)](https://openid.net/new-whitepaper-tackles-ai-agent-identity-challenges/) identified the core challenge: the autonomy inflection point is approaching faster than most realise. A single agent calling a handful of internal APIs is manageable. Highly autonomous agents spawning sub-agents across organisational boundaries, making thousands of decisions daily: that requires treating agents as first-class citizens in identity infrastructure, with proper lifecycle management, governance policies, and accountability.

## Zero Trust for Agents

The Cloud Security Alliance published the [Agentic Trust Framework (ATF)](https://cloudsecurityalliance.org/blog/2026/02/02/the-agentic-trust-framework-zero-trust-governance-for-ai-agents) in February 2026, applying Zero Trust principles specifically to AI agents. ATF is an open governance specification: all actions logged, inputs validated, circuit breakers preventing runaway failures. Organisations progress agents from initial deployment through increasing levels of autonomy, with clear criteria and controls at each stage.

The urgency is real. A [CSA/Strata Identity survey (February 2026)](https://cloudsecurityalliance.org/press-releases/2026/02/05/cloud-security-alliance-strata-survey-finds-that-enterprises-are-in-time-to-trust-phase-as-they-build-ai-autonomy-foundations) found that 84% of organisations doubt they could pass a compliance audit focused on agent behaviour or access controls. Agent adoption is surging: 58% of organisations currently manage between 1-100 agents, but over 70% expect to manage hundreds within the next year.

Red Hat's [zero trust analysis for autonomous agentic AI systems (February 2026)](https://next.redhat.com/2026/02/26/zero-trust-for-autonomous-agentic-ai-systems-building-more-secure-foundations/) reinforces the same direction: traditional perimeter-based security models break down when agents operate autonomously across trust boundaries.

## Open-Source Implementations

The gap between specification and production is closing:

- **Alibaba's Open Agent Auth** ([GitHub](https://github.com/alibaba/open-agent-auth)): enterprise framework implementing cryptographic identity binding, fine-grained authorisation, request-level isolation, and semantic audit trails. Builds on the IETF Agent Operation Authorization draft with OAuth 2.0, OpenID Connect, WIMSE, W3C VC, and MCP integration.
- **AGNTCY** ([agntcy.org](https://agntcy.org)): Linux Foundation project (via Cisco) building agent identity and discovery infrastructure.
- **NANDA** ([MIT Media Lab](https://nanda.media.mit.edu/)): decentralised agent registry and authentication.
- **AgentGateway** ([GitHub](https://github.com/agentgateway/agentgateway)): a Rust-based proxy for agent-to-agent and agent-to-tool communication that integrates with policy engines (Open Policy Agent, Kyverno, OpenFGA/SpiceDB) for fine-grained, context-aware authorization at the network layer.

## How the Pieces Fit

No single protocol solves agent trust. The picture that's emerging:

| Layer | Within org | Across orgs |
|-------|-----------|-------------|
| **Identity** | OAuth + OBO | DIDs, TSP |
| **Authority** | Scopes, RBAC, ABAC | VCs, delegation chains |
| **Delegation** | OBO token chains, AAP | PIC, Verifiable Intent |
| **Connectivity** | MCP, AgentGateway | A2A |
| **Policy enforcement** | OPA, ABAC | ATF, AgentGateway |
| **Audit** | Structured logs | Cryptographic proof |

The common thread: authority must be explicit, bounded, traceable, and independently verifiable. Whether that's an OAuth scope within your org or a verifiable credential across the internet, the principle is the same.

The question is how fast these pieces integrate. The specs exist. The implementations are starting. What's missing is covered in the [Gaps](./gaps.md) chapter.
