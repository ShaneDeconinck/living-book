---
title: SPIFFE, SVIDs, and WIMSE (Infrastructure-Layer Workload Identity)
tags: [identity, protocol, infrastructure, agents, security]
---

Infrastructure-layer identity: how software processes prove who they are to other software processes, without static secrets, without a human in the loop, and without pre-registration. The answer is attestation-based identity bound to the runtime environment.

## SPIFFE and SVIDs

SPIFFE (Secure Production Identity Framework for Everyone, CNCF, 2017) was built for microservices but its model extends directly to agents. The core idea: a workload gets an identity tied to where it is running, not what credential it was handed at startup.

A SPIFFE Verifiable Identity Document (SVID) is the credential that carries this identity. Two formats:

- **X.509-SVID**: a short-lived TLS certificate with the SPIFFE ID embedded as a URI SAN (`spiffe://trust-domain/path`). Valid for minutes to hours. Rotated automatically by SPIRE (the runtime implementation).
- **JWT-SVID**: a signed JWT carrying the same SPIFFE ID, for contexts where X.509 is awkward (HTTP headers, API calls).

Both are short-lived by design. Rotation is automatic. There are no long-lived secrets to steal, rotate manually, or forget about. The runtime environment — not the developer, not the deployment script — is the trust anchor.

CyberArk's Secure AI Agents Solution (generally available late 2025) applies SPIFFE SVIDs directly to AI agents: each agent gets a short-lived SVID. Two-way trust is established between the authorization server and SPIFFE roots of trust via SPIRE. The design principle: "AI agents are workloads that need narrowly scoped permissions, explicit authorization of actions, and confirmation of intent."

## WIMSE: SPIFFE Extended for Multi-System Environments

WIMSE (Workload Identity in Multi-System Environments, IETF, 2023+) extends SPIFFE for distributed systems where workloads cross organizational and infrastructure boundaries.

The IETF WIMSE working group is now extending WIMSE specifically for AI agents (`draft-ni-wimse-ai-agent-identity-02`). Three key additions over base WIMSE:

**Dual-identity credentials.** A standard WIMSE token identifies the workload. For agents, the credential binds two identities: the agent's own identity and the owner's identity. An agent cannot present credentials that separate these — the pairing is cryptographic and tamper-evident. This closes the confused deputy pattern at the infrastructure layer: you cannot have an agent claiming to act for one principal while its credentials say otherwise.

**Identity Proxy.** Agents do not manage their own credential lifecycle. A proxy handles rotation, scope verification, and credential augmentation as agents move between tasks. The proxy exposes a local Agent API; agents request what they need, the proxy ensures they only get it if they have standing to ask.

**Reduced validity periods.** Agent credentials are shorter-lived than traditional service credentials. The principle: scope and time-bound at the infrastructure layer, not just at the application layer.

## Where this fits in the identity stack

The agent-identity chapter's three-layer architecture:

- **Application layer** (OAuth, OBO, AAP): what can this agent do?
- **Platform layer** (Entra Agent ID, SCIM): who is this agent, how is it provisioned and deprovisioned?
- **Infrastructure layer** (WIMSE, SPIFFE): how does this agent prove it exists in this runtime environment, bound to this owner?

WIMSE addresses the bootstrapping problem that the application layer assumes away. Before an agent can get an OAuth token, something has to authenticate it. Static API keys are the current answer (44% of organizations, CSA/Strata 2026). SPIFFE SVIDs and WIMSE are the structural alternative.

MCP's 2026 enterprise roadmap names this problem explicitly: SEP-1933 (Workload Identity Federation) addresses enterprise SSO away from static secrets. The mechanism is workload identity federation — exchanging WIMSE/SPIFFE credentials for OAuth tokens — which connects the infrastructure layer to the application layer without any static secret crossing the boundary.

## Connects to

- [[dpop]] — DPoP operates at the OAuth layer; WIMSE/SPIFFE operate at the infrastructure layer. MCP's SEP-1932 (DPoP) and SEP-1933 (Workload Identity Federation) converge on the same problem from different layers.
- [[delegation-chain]] — WIMSE dual-identity credentials ensure the agent-owner binding survives across hops
- [[non-human-identity]] — SPIFFE/WIMSE are the structural answer to long-lived static NHI credentials
- [[trust-inversion]] — infrastructure-layer identity is what makes trust inversion enforceable, not just policy

## Sources

- CNCF, "SPIFFE: Secure Production Identity Framework for Everyone," spiffe.io, 2017
- IETF WIMSE WG, "WIMSE Applicability for AI Agents," draft-ni-wimse-ai-agent-identity-02, 2026
- CyberArk, "CyberArk Introduces First Identity Security Solution Purpose-Built to Protect AI Agents," cyberark.com, November 2025
- GitGuardian, "Workload and Agentic Identity at Scale: Insights From CyberArk's Workload Identity Day Zero," November 2025
- MCP Roadmap, SEP-1933 (Workload Identity Federation), March 2026
- src/chapters/agent-identity.md §The Identity Stack We Inherited, §WIMSE for Agents
