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

Separately, NIST launched the [AI Agent Standards Initiative](https://www.nist.gov/caisi/ai-agent-standards-initiative) in February 2026, seeking industry input on interoperability and security standards.

## OpenID Foundation: The Trust Fabric

The OpenID Foundation's AI Identity Management (AIIM) Community Group [responded to NIST's RFI](https://openid.net/oidf-responds-to-nist-on-ai-agent-security/) in March 2026 with a key framing: there needs to be a "trust fabric" beneath the technical controls.

Their [whitepaper (October 2025)](https://openid.net/new-whitepaper-tackles-ai-agent-identity-challenges/) identified the core challenge: the autonomy inflection point is approaching faster than most realise. A single agent calling a handful of internal APIs is manageable. Highly autonomous agents spawning sub-agents across organisational boundaries, making thousands of decisions daily: that requires treating agents as first-class citizens in identity infrastructure, with proper lifecycle management, governance policies, and accountability.

## Open-Source Implementations

The gap between specification and production is closing:

- **Alibaba's Open Agent Auth** ([GitHub](https://github.com/alibaba/open-agent-auth)): enterprise framework implementing cryptographic identity binding, fine-grained authorisation, request-level isolation, and semantic audit trails. Builds on the IETF Agent Operation Authorization draft with OAuth 2.0, OpenID Connect, WIMSE, W3C VC, and MCP integration.
- **AGNTCY** ([agntcy.org](https://agntcy.org)): Linux Foundation project (via Cisco) building agent identity and discovery infrastructure.
- **NANDA** ([MIT Media Lab](https://nanda.media.mit.edu/)): decentralised agent registry and authentication.

## How the Pieces Fit

No single protocol solves agent trust. The picture that's emerging:

| Layer | Within org | Across orgs |
|-------|-----------|-------------|
| **Identity** | OAuth + OBO | DIDs, TSP |
| **Authority** | Scopes, RBAC, ABAC | VCs, delegation chains |
| **Delegation** | OBO token chains | PIC, Verifiable Intent |
| **Connectivity** | MCP | A2A |
| **Audit** | Structured logs | Cryptographic proof |

The common thread: authority must be explicit, bounded, traceable, and independently verifiable. Whether that's an OAuth scope within your org or a verifiable credential across the internet, the principle is the same.

The question is how fast these pieces integrate. The specs exist. The implementations are starting. What's missing is covered in the [Gaps](./gaps.md) chapter.
