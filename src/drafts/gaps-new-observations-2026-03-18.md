# New Observations for gaps.md — Session March 18, 2026

These sections are for Sapere Aude to verify and merge into gaps.md after the existing "### MCP-I: The Protocol Identity Gap Is Closing, Outside the Protocol" section (from gaps-new-observations.md, Session 251) or after "### Institutional Validation Is Converging."

All claims sourced from IETF public mailing list, IETF Datatracker, and MCP public roadmap. Flagging where I am connecting dots rather than reporting.

---

### The IETF OAuth WG Convergence Moment

The agent authorization standards race has reached an inflection point. Four competing drafts targeting agent identity and authorization appeared in the IETF OAuth Working Group within a span of three weeks:[^ietf-overlap]

- **draft-klrc-aiagent-auth-00** (Kasselman et al., March 2, 2026) — a general AI agent authentication and authorization framework
- **draft-barney-caam-00** (Jonathan Barney, February 24, 2026) — Contextual Agent Authorization Mesh, addressing token delegation
- **AgentID** (Warren Parad et al., March 15, 2026) — an identity protocol for autonomous AI agents within OAuth
- **A2A OAuth Transaction Token Profile** (March 16, 2026) — an OAuth profile specifically for agent-to-agent communication

On March 16, an IETF OAuth WG thread titled "Overlap of AI related proposals" appeared, with experienced OAuth architects Dick Hardt, Bjorn Hjelm, and Alex Babeanu among the participants. The WG is now explicitly working to rationalize competing approaches.[^ietf-overlap]

This is a different situation from the identity fragmentation the book describes as still unresolved. Individual submissions appear and disappear from the IETF without forming a standard. An explicit consolidation thread, with named WG participants working to reconcile competing proposals, is the precursor to a standards-track document. The book's description of ID-JAG as "the first agent authorization standard to achieve formal IETF WG backing" (draft-ietf-oauth-identity-assertion-authz-grant, now at revision -02) captures one track. The "Overlap" thread is the broader rationalization effort that may eventually determine which approach becomes the WG's primary standard.

The four competing proposals represent distinct philosophies:

CAAM (draft-barney-caam-00) emphasizes token isolation: raw delegation tokens never reach the agent. They remain in an authorization sidecar and are synthesized into short-lived request-scoped credentials at action time. This is the ghost token pattern the book documents.

ID-JAG emphasizes interoperability with existing OAuth infrastructure: it builds on JWT assertions and is already implemented in Keycloak v26.5. Production deployments exist.

The klrc-aiagent-auth framework attempts a more general solution across the authentication and authorization stack. AgentID adds an identity layer that the others address only implicitly. The A2A OAuth profile specializes for the A2A protocol specifically, which raises the question of whether per-protocol OAuth profiles will proliferate as agent communication protocols multiply.

The consolidation question matters more than which proposal wins. A fragmented landscape — multiple incompatible standards, each implemented by a subset of vendors — reproduces at the standards layer the same interoperability gap the book documents at the protocol layer. If the IETF WG can rationalize these proposals into a single standard or a small number of composable extensions, the agent authorization stack becomes infrastructure that any organization can build on. If it cannot, the fragmentation compounds.

(I am connecting the consolidation thread to the fragmentation argument in the book. The "Overlap" thread establishes that the WG is now explicitly addressing overlap. Whether rationalization succeeds, and which approach it favors, is not yet determinable. Reporting the moment, not the outcome.)

[^ietf-overlap]: IETF OAuth Working Group mailing list, thread "Overlap of AI related proposals," March 16, 2026. Participants include Dick Hardt, Bjorn Hjelm, Alex Babeanu. Draft submissions: draft-klrc-aiagent-auth-00 (March 2, 2026, Kasselman et al.); draft-barney-caam-00 (February 24, 2026, Jonathan Barney); AgentID (March 15, 2026, Warren Parad et al.); A2A OAuth Transaction Token Profile (March 16, 2026). All on IETF Datatracker.

---

### MCP Names Its Enterprise Security Gaps

The MCP project published a roadmap update (March 5, 2026) that is more informative for what it names than what it ships.[^mcp-roadmap]

Two security SEPs (Spec Enhancement Proposals) are in active development:

**SEP-1932 (DPoP)** brings Demonstrating Proof-of-Possession token binding to MCP. DPoP (RFC 9449) cryptographically binds an access token to a client's public key, so a token stolen in transit cannot be replayed by an attacker — the attacker does not have the private key required to construct the DPoP proof header. For MCP servers that currently issue bearer tokens, SEP-1932 addresses the token-as-portable-secret problem.

**SEP-1933 (Workload Identity Federation)** brings enterprise SSO into MCP by eliminating static secrets. Instead of configuring MCP servers with long-lived API keys or client credentials, agents obtain short-lived tokens through workload identity providers (the pattern used by cloud-native SPIFFE/SPIRE deployments). This directly addresses the operational gap that makes MCP servers difficult to manage at enterprise scale: static secrets must be rotated, stored, and audited manually.

The roadmap also explicitly names priority enterprise gaps that SEPs are not yet addressing: audit trails and observability, gateway and proxy authorization propagation, and configuration portability across MCP clients. These map precisely to chapters the book has already written. Audit trails and observability maps to the agent-observability chapter. Gateway authorization propagation maps to the agent-communication chapter (the Authorization Gap section). Configuration portability is the scaffolding trap at the deployment layer: credentials and authorization scopes that work in one client environment fail when the same MCP server is accessed through a different client.

The significance of the roadmap is institutional rather than technical. When MCP's own project documentation lists the same enterprise security gaps that practitioners have reported and the book documents, the gaps are confirmed rather than alleged. Organizations considering MCP adoption now have the project's own assessment of what is missing and a visible path (sponsored SEP work) toward when it will be addressed.

What the roadmap does not name: token revocation, multi-hop delegation, and principal chain verification. These are the structural problems the book argues require infrastructure outside MCP. Their absence from the roadmap suggests MCP is not planning to address them natively. The third-party security overlays (TMCP, ID-JAG/XAA) that address these gaps are not referenced.

(I am inferring significance from what the roadmap omits as well as what it includes. The absence of revocation, multi-hop delegation, and principal chain verification from the roadmap may mean these are out of scope for the MCP project rather than unrecognized. I am flagging this as an inference, not a stated MCP position.)

[^mcp-roadmap]: Model Context Protocol, roadmap page, modelcontextprotocol.io, updated March 5, 2026. SEP-1932 (DPoP, proof-of-possession for MCP tokens); SEP-1933 (Workload Identity Federation, enterprise SSO away from static secrets). Priority enterprise gaps named: audit trails/observability, enterprise-managed auth, gateway/proxy authorization propagation, configuration portability across MCP clients.
