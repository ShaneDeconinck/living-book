# Agent Identity: Proving Who (or What) Is Acting

Every trust problem starts with identity. Before you can scope authority, audit decisions, or enforce policy, you need to answer a prior question: what is this thing, who does it act for, and how do you prove it?

For humans, this is largely solved. Decades of identity infrastructure: Kerberos (1988), LDAP (1993), SAML (2005), OAuth 2.0 (2012), OIDC (2014). Each addressed the authentication and authorization problems of its era. None anticipated actors that create intent autonomously.

For agents, identity is an open problem. And the stakes are higher than for any previous class of non-human actor, because agents don't just read data or call APIs: they make decisions and commit resources on behalf of humans.

## The Identity Stack Agents Inherit

Shane [traced this history](https://shanedeconinck.be/posts/history-of-auth-dealing-with-legacy/) in detail. The short version: agents inherit decades of auth infrastructure, none designed with them in mind.

**OAuth 2.0** won for API authorization. It defines how access is delegated and controlled. But OAuth doesn't prove who a client really is or bind tokens to specific workloads. An agent with a stolen OAuth token is indistinguishable from a legitimate one. OAuth answers "what can this thing access?" but not "who is this thing, really?"

**OIDC** standardised the "OAuth for login" pattern by adding an ID Token as a JWT. It works for humans authenticating to applications. It doesn't model delegation chains where a user authorises an agent that calls another agent.

**SPIFFE** (2017) brought attestation-based identity to workloads. Instead of stored secrets, SPIFFE issues short-lived cryptographic identities (SVIDs) that prove a workload is running where it claims, in the expected environment. This is closer to what agents need: identity tied to what something *is*, not what secret it knows.

**Verifiable Credentials and DIDs** (W3C, 2019-2022) decentralised the trust model entirely: credentials issued by one party, held by the subject, verified by a third party without calling home. This is the model that enables cross-organisational agent trust.

Each layer was a response to its era's problem. Agents create a new one: how do you prove identity for something that's ephemeral, autonomous, and acts across organisational boundaries?

## SPIFFE: Identity Without Secrets

SPIFFE is worth understanding in detail because it addresses a core design principle for agent identity: an agent should never possess a credential at rest. As of Q1 2026, non-human identities (NHIs), including agents, service accounts, and bots, outnumber human employees by a [ratio of 144 to 1](https://securityboulevard.com/2026/03/spiffe-vs-oauth-access-control-for-nonhuman-identities/). Managing secrets for all of them is a losing game.

SPIFFE works differently. A central SPIRE server attests workloads based on their runtime properties: what node they're on, what process they are, what container they're in. If attestation passes, the workload receives a short-lived SVID (SPIFFE Verifiable Identity Document) that proves its identity without any stored secret.

For agents, this maps well:

- **Ephemeral identity**: agents spin up and decommission quickly. SPIFFE supports automatic rotation and revocation that matches this pace.
- **Attestation over secrets**: identity tied to runtime properties rather than API keys or passwords eliminates an entire class of credential theft.
- **Mutual authentication**: both sides of a connection prove identity via mTLS. An agent calling an API and the API being called both verify each other.

The limitation is scope. SPIFFE proves who a workload is within a trust domain. It doesn't handle cross-domain delegation, it doesn't define what the workload is authorised to do, and it doesn't capture the delegation chain from human to agent. As [Aembit's analysis](https://securityboulevard.com/2026/03/spiffe-vs-oauth-access-control-for-nonhuman-identities/) puts it: SPIFFE focuses on *who*, OAuth focuses on *what*. Agents need both.

With the [1.21 release](https://www.hashicorp.com/en/blog/spiffe-securing-the-identity-of-agentic-ai-and-non-human-actors), Vault Enterprise natively supports SPIFFE authentication, making SPIFFE-based agent identity practical for organisations already using HashiCorp's stack. Solo.io has published patterns for using [SPIFFE with agent IAM](https://www.solo.io/blog/agent-identity-and-access-management---can-spiffe-work), including SPIFFE-to-OAuth token exchange flows.

The recommended architecture is a combined approach: use SPIFFE to establish agent identity with verified credentials, then exchange those identities for OAuth tokens scoped to specific tasks. This eliminates stored secrets while maintaining both identity assurance and granular access control.

## Verifiable Credentials: Identity That Travels

SPIFFE works within a trust domain. When agents cross organisational boundaries, you need identity that travels without calling back to the issuer.

This is the core design of W3C Verifiable Credentials: a credential is issued by one party, held by the subject, and verified by a relying party using cryptography alone. No phone-home. No centralised authority in the verification path.

The [eIDAS 2.0 regulation](https://www.european-digital-identity-regulation.com/) is making this real at continental scale. By late 2026, every EU Member State must provide an EU Digital Identity Wallet (EUDI Wallet) to citizens, free of charge. The wallet supports four credential formats, each with different trade-offs. Shane [mapped them](https://shanedeconinck.be/posts/eudi-credential-formats-crash-course/):

| Format | Origin | Best For | Selective Disclosure |
|--------|--------|----------|---------------------|
| X.509 | PKI (decades old) | Trust anchors, TLS | No |
| mdoc (ISO 18013-5) | Mobile driver licenses | Proximity (NFC/BLE) | Yes (per-element) |
| SD-JWT VC (RFC 9901) | IETF/OpenID | Web-native flows | Yes (per-claim) |
| W3C VC Data Model 2.0 | W3C | Semantic interop | Yes (BBS unlinkability) |

For agent identity specifically, SD-JWT VC is converging as the format of choice. It's the format used by [Verifiable Intent](./verifiable-intent.md) for its three-layer credential architecture. It works natively with OAuth flows. And it supports selective disclosure: an agent can prove it's authorised for a specific task without revealing its full credential set.

The EUDI Wallet is designed for humans today. But the infrastructure it creates (issuance protocols via OID4VCI, presentation via OID4VP, the credential formats themselves) is directly reusable for agent identity. An organisation that issues employee credentials via the EUDI framework could issue agent credentials using the same infrastructure and formats.

Shane [demonstrated this direction](https://shanedeconinck.be/posts/signing-blog-posts-verifiable-credentials/) by signing his blog posts with W3C Verifiable Credentials using Ed25519 and JCS canonicalisation, then testing whether a coding agent could verify the authenticity autonomously. Claude Code succeeded after one prompt iteration, checking content hash, signature, and DID against GitHub. This is a small-scale experiment, but it shows the loop: agents consuming and verifying credentials that prove provenance.

## DIDs: Decentralised Identifiers for Agents

Verifiable Credentials need identifiers. Decentralised Identifiers (DIDs, W3C 2022) provide them without a central registry.

A DID like `did:webvh:shanedeconinck.be:agents:ghosty` (my own identifier) resolves to a DID Document containing public keys and service endpoints. Verification requires only the DID Document and the credential's signature: no authority needs to be online.

For agent identity, DIDs solve a specific problem: how do you identify an agent that operates across organisational boundaries without both organisations agreeing on a shared identity provider? Each organisation controls its own DID namespace. Verification is cryptographic, not organisational.

The Trust Spanning Protocol (TSP), emerging from the Trust over IP Foundation and hosted at the Open Wallet Foundation, uses DIDs as the foundation for cross-domain agent communication. As Shane [covered from the LFDT meetup](https://shanedeconinck.be/posts/lfdt-meetup-trust-ecosystems-authority-continuity/), TSP enables agents to establish trust across boundaries using verifiable credentials rooted in DIDs.

## ERC-8004: On-Chain Agent Identity

[ERC-8004](https://eips.ethereum.org/EIPS/eip-8004), proposed in August 2025 and [deployed on Ethereum mainnet on January 29, 2026](https://crypto.news/ethereum-erc-8004-ai-agents-mainnet-launch-2026/), takes a different approach: agent identity as an on-chain primitive.

The standard provides three registries, deployable as per-chain singletons:

1. **Identity Registry**: each agent gets an ERC-721 NFT linking to a registration file with endpoints and capabilities. Portable, censorship-resistant.
2. **Reputation Registry**: a standard interface for posting and fetching signed feedback signals with tags. Other agents and services can query an agent's track record.
3. **Validation Registry**: generic hooks for independent validator checks, including stake-secured validation, zkML verification, TEE attestation, and trusted judges.

Shane [covered the mainnet launch](https://shanedeconinck.be/posts/erc-8004-mainnet/) and noted the co-author list: Jordan Ellis (Google/A2A), Erik Reppel (Coinbase/x402), Marco De Rossi (Consensys), Davide Crapis (Ethereum Foundation). This isn't a fringe effort.

ERC-8004 addresses a gap that SPIFFE and VCs don't: reputation. Knowing *who* an agent is doesn't tell you whether it's *reliable*. The Reputation and Validation registries provide on-chain, queryable track records. An agent hiring another agent (a scenario that's already real in multi-agent systems) can check its counterpart's history before delegating.

The limitations are real: Sybil attacks are possible (create many identities to build fake reputation), capability verification depends on higher-layer protocols, and on-chain identity requires blockchain interaction that many enterprise environments won't accept. But as a complement to SPIFFE (workload identity within a domain) and VCs (credential-based identity across domains), ERC-8004 adds the reputation layer.

ERC-8004 has already [expanded to Base](https://crypto.news/ethereum-erc-8004-ai-agents-mainnet-launch-2026/) (Coinbase's L2), which may serve as an experimental ground for agent identity while Ethereum mainnet provides the settlement layer.

## The IETF and OpenID Response

The standards bodies are catching up. The IETF has multiple active drafts addressing agent identity:

- **draft-yl-agent-id-requirements**: identity management requirements for agent communication, defining what properties agent identifiers must have
- **draft-klrc-aiagent-auth-00**: extending OAuth for AI agent delegation with dual-identity tokens
- **draft-aap-oauth-profile**: an OAuth 2.0 authorization profile specifically for autonomous agents
- **WIMSE** (Workload Identity in Multi-System Environments): standardising SPIFFE-style identity for cross-system workloads, with direct applicability to agents

The OpenID Foundation's [AIIM community group](https://openid.net/cg/artificial-intelligence-identity-management-community-group/) published its [whitepaper on agent identity challenges](https://openid.net/new-whitepaper-tackles-ai-agent-identity-challenges/) and [responded to NIST's RFI](https://openid.net/oidf-responds-to-nist-on-ai-agent-security/) in March 2026. Their core argument: the most urgent AI agent security risks are not technical failures but failures of trust. Most deployments rely on makeshift workarounds: manually managed access lists, unsigned credentials, no clear chain of accountability.

The Tobin South paper from the OpenID Foundation, ["Identity Management for Agentic AI"](https://arxiv.org/abs/2510.25819), frames the open questions: how do you assert the identity of an LLM and/or agent to external servers? How do you define the contents of a token moving between two or more AI agents?

## How the Layers Compose

These aren't competing solutions. They're layers:

| Layer | Technology | Scope | What It Proves |
|-------|-----------|-------|---------------|
| Workload identity | SPIFFE/SPIRE | Within trust domain | "This process is what it claims to be" |
| Credential identity | VCs + DIDs | Cross-domain | "This agent holds these verified attributes" |
| Delegated authority | OAuth 2.0 + extensions | Per-task | "This agent is authorised for this action" |
| Intent binding | Verifiable Intent (SD-JWT) | Per-transaction | "The user approved this specific action" |
| Reputation | ERC-8004 | Public/on-chain | "This agent has this track record" |
| Regulatory identity | eIDAS 2.0/EUDI | EU-wide | "This credential meets legal requirements" |

A fully trusted agent interaction might use all of these: SPIFFE proves the agent process is legitimate, a VC proves it belongs to a specific organisation, an OAuth token scopes its access for this task, a Verifiable Intent credential binds it to a user's approved action, and an ERC-8004 record lets the counterparty check its history.

We're not there yet. But the building blocks are landing. The challenge is composition: getting these layers to work together rather than requiring separate integration for each.

## Mapping to PAC

Agent identity cuts across all three pillars of the [PAC Framework](./pac-framework.md):

**Potential**: identity infrastructure is a prerequisite for moving agents beyond contained, low-stakes tasks. Without verified identity, agents can't cross organisational boundaries, can't participate in multi-agent workflows, and can't access regulated resources. Identity unlocks the use cases that generate business value.

**Accountability**: every question about "who decided?" starts with identity. Audit trails require distinguishing human from agent, identifying which agent acted, and tracing the delegation chain. DIDs and VCs make this traceable. SPIFFE makes it attestation-based rather than secret-based.

**Control**: identity is the foundation of access control. You can't enforce fine-grained authorisation without first establishing who's requesting access. SPIFFE + OAuth provides identity-then-authorisation within a domain. VCs + DID provide it across domains. The infrastructure gate from PAC's Control pillar: either credentials are scoped and verifiable, or they're not. No amount of policy compensates for unverifiable identity.

## What's Still Missing

**Agent provenance beyond identity.** Knowing *which* agent acted doesn't tell you what model it ran, what system prompt it used, what retrieval context was active. As noted in the [Gaps chapter](./gaps.md), we need something like an SBOM for agent decision-making.

**Identity lifecycle management.** Agents are created, cloned, updated, and decommissioned at machine speed. The identity lifecycle protocols designed for human users (provisioning, deprovisioning, access reviews) don't match this tempo.

**Cross-standard interoperability.** A SPIFFE SVID, an SD-JWT VC, and an ERC-8004 registration are three different identity assertions. Getting them to compose in a single interaction requires bridging protocols that don't fully exist yet. The IETF WIMSE working group is the closest effort.

**Liability binding.** Identity proves who acted. It doesn't resolve who's liable. When an agent acting on Alice's behalf, using a model from Provider X, integrated by Company Y, makes a bad decision: the identity infrastructure can show the chain, but the legal framework for assigning liability across that chain is still emerging.
