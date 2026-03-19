# Platform Governance and the Interoperability Bet

On March 9, 2026, Microsoft bundled agent governance into the enterprise security stack. Microsoft 365 E7 at $99 per user per month now includes Copilot, Agent 365 (previously $15 per user per month separately), and the full Entra, Defender, and Purview suite.[^ms-e7] Agent governance is no longer a standalone product decision. It is a line item in an enterprise security subscription.

When Microsoft packages agent governance alongside identity, endpoint, and data protection, it treats agent governance as baseline enterprise security infrastructure — the same category as zero trust and endpoint detection. Organizations that have been deferring the governance question because it feels like "future work" are now purchasing the primitives whether they configure them or not.

The question is no longer whether to adopt agent governance infrastructure. It is which governance infrastructure to bet on, and what that bet costs when it turns out to be incomplete.

## What Platform Governance Gives You

Microsoft's Entra Agent ID Governance preview, released March 2026, is the clearest example of what platform-native agent governance looks like at production maturity.[^entra-agent-gov]

The primitives are useful. Agent identities become first-class enterprise principals — the same identity infrastructure used for human employees and service accounts, but structured for agent lifecycle patterns. Each agent has a human sponsor: an accountable person whose job it is to review the agent's permissions, attest that access is still needed, and trigger decommissioning when the agent's role ends. Lifecycle Workflows automate the operational work: sponsor updates, access reviews, and deactivation run on policy rather than manual process. Access Packages bundle permissions into time-bound, auditable assignments that expire without renewal.

Agent 365 adds the operational layer on top: an Agent Registry that inventories all agents including third-party agents registered via API, behavioral and performance observability, and agent risk signals aggregated across the security stack.[^ms-e7]

This is real infrastructure. The shadow agent governance chapter describes the discovery problem — organizations cannot govern agents they cannot see. Agent 365's registry and third-party agent discovery addresses exactly that problem for agents deployed within the Microsoft ecosystem. The Lifecycle Workflows address the decommissioning problem the lifecycle management chapter identifies as the most commonly skipped governance step. The human sponsor model implements the accountability structure the book describes as necessary for agents with consequential action authority.

Platform governance deploys. That is its strongest argument. Organizations that have spent months debating governance architecture can configure Agent 365 in weeks against an existing Entra tenant. The primitives are familiar to enterprise identity teams. The procurement is already done.

## The Boundary Problem

The limitation is architectural, not incidental.

Entro Security's March 2026 analysis of Agent 365 names it directly: "Agent 365 gives each agent an Entra identity, but agents span Azure, AWS, GCP, SaaS, CI/CD, and internal frameworks. Single-platform governance creates silos."[^entro-agent365]

Most enterprise agent deployments are not single-platform. An agent that helps a sales team might query Salesforce (SaaS), retrieve from an internal data warehouse (on-premises), call a third-party enrichment API (external vendor), and update a Jira board (Atlassian cloud). The agent's identity is real inside Azure. The agent's authorization decisions are real inside Azure. Outside Azure — at the Salesforce API, at the enrichment vendor, at Atlassian — the Entra identity is not verifiable. Each external integration falls back to API keys, static credentials, or the platform's own identity model.

This is not a failure of Microsoft's implementation. It is the inherent limit of any platform-native governance model. Governance can only verify and enforce at surfaces the platform controls. For agents that cross platform boundaries — which describes most agents doing meaningful work — the governance perimeter is narrower than the agent's action surface.

The shadow agent governance chapter describes two discovery gaps: agents the organization doesn't know exist, and agents the organization knows exist but cannot govern. Platform governance solves the first gap within the platform. It does not solve the second gap for cross-boundary agents. An agent with an Entra identity operating in AWS is a shadow agent from AWS's perspective. An agent with an Entra identity calling an unmanaged API endpoint is ungoverned at that boundary.

## Sector-Specific Fragmentation

Platform governance is also fragmenting by vertical before cross-industry standards have converged.

Imprivata launched Agentic Identity Management at HIMSS 2026 on March 10, 2026 — the first healthcare-specific agent identity product.[^imprivata-aim] The architecture mirrors the book's arguments: agents as managed identities within the organization's identity framework, short-lived scoped tokens for each connection, an agent registry for visibility, and unmanaged agent discovery. The healthcare-specific rationale is HIPAA: every access to protected health information must be attributed to a responsible party. An agent accessing a patient record must carry an identity that maps back to the authorizing clinician or workflow. General-purpose enterprise identity products did not address this traceability requirement adequately.

Imprivata will not be the last sector-specific product. Financial services face similar attribution requirements under MiFID II and SOX. Legal and compliance workflows face attorney-client privilege considerations that affect what agents can access and log. Defense contractors face CMMC-level requirements for access to controlled unclassified information. Each sector will produce its own agent identity products calibrated to its compliance surface.

If sector-specific agent identity products proliferate before cross-industry standards converge, interoperability becomes structurally harder. A healthcare agent needs to call a billing SaaS provider governed under the financial services model. The two governance frameworks do not share an identity layer. The interoperability gap the book documents at the protocol layer — three simultaneous identity tracks for MCP-connected agents, none interoperable — recurs at the governance layer across industry verticals.

## The Open Standards Alternative

The open standards trajectory exists precisely because cross-platform, cross-industry interoperability requires a foundation that no single vendor controls.

The IETF OAuth Working Group has formally adopted draft-ietf-oauth-identity-assertion-authz-grant (ID-JAG) as the first agent authorization standard to reach Working Group backing.[^idjag-wg] ID-JAG is implemented in Keycloak v26.5 with production deployments — open-source, deployable on any infrastructure, not bounded by a single cloud provider's perimeter.

MCP-I, donated to the Decentralized Identity Foundation in March 2026, provides cryptographically verifiable agent identities anchored as DIDs with delegation represented as Verifiable Credentials.[^mcp-i-dif] DIF's Trusted AI Agents Working Group governs it alongside the Delegated Authorization Task Force that coordinates ID-JAG. The same governance structure that produced W3C Verifiable Credentials — interoperable across all major cloud platforms — is now building the equivalent for agent identity.

Open standards give you what platform governance cannot: an identity layer that crosses vendor, cloud, and sector boundaries. An agent with a DID and a verifiable credential chain can prove its identity and authorization to any service that implements the standard, regardless of which cloud that service runs on.

The tradeoff is deployment velocity. Keycloak requires infrastructure investment. DID tooling is maturing but not yet plug-and-play. The enterprise identity team comfortable configuring Entra will find the DID ecosystem less familiar. Open standards offer more interoperability at higher initial friction.

## Composition, Not Competition

The practical path is composition, not a binary choice.

Platform governance deploys quickly and solves the intra-platform problem well. For agents that operate within a single cloud ecosystem — Microsoft 365 workflows, Azure Copilot extensions, Azure OpenAI deployments — Agent 365 provides mature governance infrastructure that is already purchased and available. Configure it. The registry, lifecycle workflows, and human sponsor model are worth deploying even if you also invest in cross-boundary infrastructure.

For agents that cross cloud, vendor, or sector boundaries, open standards infrastructure is the only path to consistent governance coverage. Keycloak's ID-JAG implementation gives organizations an open-source, production-ready authorization layer that is not bounded by any platform perimeter. MCP-I's three-tier adoption model provides an on-ramp: Level 1 uses OIDC/JWT identifiers and deploys without DID infrastructure, giving immediate cross-boundary identity coverage while the DID ecosystem matures.

The governance debt compounds alongside the agent deployment surface. Organizations that build platform-only governance today will find that cross-boundary agents accumulate as their deployments expand. The cost of retrofitting cross-boundary governance later — when the agent estate is larger and the dependencies are more complex — is higher than investing in composable infrastructure now.

The book's thesis is that trust infrastructure compounds: every governed process produces better context pipelines, sharper authorization patterns, and operational learning that raises the ceiling on safe automation. That compounding effect is bounded by the governance perimeter. Platform governance compounds within the platform. Cross-boundary infrastructure compounds across everything.

## Infrastructure Maturity: I3 → I4

Platform governance marks an infrastructure maturity threshold (I3: repeatable governance primitives deployed at scale in a major vendor's enterprise stack). The agent registry, lifecycle workflows, and human sponsor model are now standard enterprise security inventory, not custom implementation.

Cross-boundary governance — verifiable identity across cloud and sector boundaries, cryptographic delegation chains verifiable by any conforming service — reads as I2: ad hoc implementations, not yet systematized. The open standards work (ID-JAG, MCP-I, DIF TAIAWG) is the I3 path for cross-boundary governance. It exists. The deployment patterns are forming. The production implementations are early but real.

The gap between I3 platform governance and I2 cross-boundary governance is the interoperability bet: whether the open standards trajectory produces deployable, interoperable infrastructure before the platform governance silos become too entrenched to bridge.

## What to Do Now

**For agents within a single cloud ecosystem:** Configure the platform governance primitives. If you are in the Microsoft stack, the Agent Registry, Lifecycle Workflows, and human sponsor model are available and worth deploying. Do not defer this because cross-boundary governance is not yet solved.

**For agents that cross cloud or vendor boundaries:** Evaluate ID-JAG via Keycloak v26.5. This is the most production-ready open standard for cross-boundary agent authorization currently available. MCP-I Level 1 (OIDC/JWT, no DID infrastructure required) provides cross-boundary identity for MCP-connected agents without requiring DIF adoption.

**For sector-specific deployments:** Check whether sector-specific products (Imprivata for healthcare, likely equivalent products for finance and legal) provide the compliance traceability your sector requires that general-purpose platforms may not. Prefer products that expose their identity layer through open standards rather than proprietary APIs — the sector-specific product should be a configuration of standard identity infrastructure, not a parallel silo.

**For infrastructure decisions with multi-year horizons:** Invest in the open standards layer alongside platform governance. Platform governance gives you operational coverage today. Open standards infrastructure gives you cross-boundary coverage as your deployment surface grows. Composition is more expensive than a single platform decision, but it is the only architecture that does not require refactoring as your agent estate crosses cloud and sector boundaries.

The governance platform question has a non-answer that looks like an answer: "wait for the platforms to solve interoperability." They will not. Interoperability requires a foundation that no single platform controls. That foundation is being built by the IETF, DIF, and W3C. It is worth investing in now, alongside the platform governance that already deploys.

---

[^ms-e7]: Microsoft, Microsoft 365 E7 announcement, March 9, 2026. $99/user/month includes Copilot, Agent 365 ($15/user/month separately), and the full Entra/Defender/Purview suite. Agent 365 core primitives: Agent Registry (inventory including third-party agents via API), behavior and performance observability, agent risk signals across the security stack.

[^entra-agent-gov]: Microsoft, Entra Agent ID Governance preview, March 2026. Agent identities as first-class enterprise principals with human sponsors accountable for lifecycle decisions; Lifecycle Workflows automating sponsor updates and deactivation; Access Packages bundling permissions into time-bound, auditable assignments.

[^entro-agent365]: Entro Security, "Microsoft Agent 365 Boosts AI Identity, Yet Governance Gaps Remain," entro.security, March 2026.

[^imprivata-aim]: Imprivata, Agentic Identity Management, launched at HIMSS 2026, March 10, 2026. Agents as managed identities within the organization's identity framework; short-lived token brokering; agent registry; unmanaged agent discovery.

[^idjag-wg]: IETF OAuth Working Group, draft-ietf-oauth-identity-assertion-authz-grant, now at revision -02. First agent authorization standard to achieve formal IETF Working Group backing. Implemented in Keycloak v26.5.

[^mcp-i-dif]: Vouched and DIF, "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation, March 2026. Three-tier adoption model: Level 1 (OIDC/JWT, no DID infrastructure required), Level 2 (full DID verification and credential-based delegation with revocation), Level 3 (enterprise lifecycle management and immutable auditing).
