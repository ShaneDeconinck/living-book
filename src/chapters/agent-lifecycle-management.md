# Agent Lifecycle Management

An agent gets created in minutes. A developer spins up a service account, grabs an API key, connects it to a model, and ships it. The provisioning is fast because the tools make it fast. Low-code platforms, agent frameworks, and cloud-hosted model APIs have collapsed the time from "idea" to "running agent" to hours or less.

Decommissioning that agent takes indefinitely, because nobody planned for it.

## The Scale of What Is Unmanaged

Machine identities outnumber human identities by more than 80 to 1 in the average enterprise, according to CyberArk's 2025 Identity Security Landscape report.[^cyberark-82] In financial services, the ratio reaches 96 to 1.[^cyberark-96] These numbers predate the current wave of agentic AI. As organizations deploy agents that each require their own credentials, tokens, and service accounts, the ratio accelerates.

The problem is not just volume. It is governance coverage. CyberArk found that 42% of machine identities have privileged or sensitive access, yet 88% of organizations define "privileged user" as applying solely to human identities.[^cyberark-82] Machine identities with admin tokens are invisible to the governance processes designed for human users.

Okta identified the root cause: authorization outlives intent.[^okta-outlives] Every lingering token tied to an AI agent opens the door to unintended access, long after the task is done, the employee is gone, or the integration has shifted. The credential was issued for a purpose. The purpose ended. The credential did not.

## Birth: How Agents Get Provisioned

A governed agent lifecycle starts before the first line of code runs. Three things need to happen at provisioning time: the agent gets an identity, an owner, and a scope.

### Identity issuance

The Agent Identity chapter covered the protocols: SPIFFE/WIMSE for workload-level identity, OAuth extensions for application-level authorization, DIDs for cross-organizational trust. At the lifecycle level, the question is simpler: does this agent exist in a system of record?

Saviynt's lifecycle framework requires a globally unique ID bound to the agent and its accountable owner at the time of registration.[^saviynt] The ID prevents impersonation, eliminates shadow agents at the source, and establishes the root of trust required for every subsequent governance action. Without it, you cannot rotate credentials (you do not know which credentials belong to the agent), you cannot audit actions (you cannot link actions to a specific agent), and you cannot decommission (you do not know the agent exists).

The IETF's March 2026 draft on AI Agent Authentication and Authorization (draft-klrc-aiagent-auth) consolidates the identity layer: the agent is a workload that needs an identifier and credentials for authentication by tools, services, resources, and large language models.[^klrc] The draft does not invent new protocols. It maps existing standards (WIMSE, SPIFFE, OAuth) to agent scenarios and identifies where gaps remain. The most significant architectural decision: mutually-authenticated TLS (mTLS) with short-lived workload identities from SPIFFE or WIMSE as the primary authentication mechanism for agent-to-service communication.[^klrc]

### Ownership assignment

Every agent needs a named, accountable human owner from day one. Not a team. Not a department. A person.

This is the lesson from shadow agent governance: when agents have no owner, nobody notices when they drift, break, or get compromised. Saviynt's framework requires structured capture of the accountable owner alongside the agent's model version, hosting environment, and declared purpose.[^saviynt] Okta's AI Agent Lifecycle Management framework enforces ownership as part of identity creation, before the agent receives any credentials.[^okta-lcm]

Ownership is not permanent. It must transfer when people change roles, leave the organization, or when the agent's purpose shifts. The decommissioning section below covers what happens when ownership transfer fails.

### Initial scoping

The agent's initial permissions should reflect its declared purpose and nothing more. Shane's trust inversion applies here: agents start from zero authority and receive explicit grants for what they can do.[^trust-inversion]

In practice, this fails at provisioning time more often than anywhere else. Teleport's 2026 report found that 70% of organizations grant AI systems higher levels of privileged access than humans would receive for the same task.[^teleport] The reason is structural: provisioning agents through existing IAM tools means choosing from permission sets designed for human roles. An agent that needs to read one database table gets a "data analyst" role that includes read access to every table in the schema.

Token Security's approach inverts this: intent-aware least-privilege ensures agents have only the permissions needed for their purpose, and only for the time required.[^token-security] The permission is derived from the agent's declared intent, not from a pre-existing role.[^profiler]

## Life: Runtime Governance

### Credential rotation

Long-lived credentials are the most common lifecycle failure. An agent provisioned with an API key in January is still using that same key in December, long after the task that justified it has changed, the person who created it has moved on, and the security posture has shifted.

SPIFFE addresses this architecturally: workload identities are short-lived certificates (hours or days, not months) with automatic rotation managed by the SPIRE runtime environment.[^spiffe] The agent never handles its own key material. The infrastructure issues, rotates, and revokes credentials transparently.

The WIMSE draft for agents introduces an Identity Proxy that manages credential rotation, scope verification, and credential augmentation as agents move between tasks.[^wimse-agents] Agents do not handle their own credential lifecycle. The proxy does. An agent that manages its own credentials can be compromised into extending its own authority.

For agents using OAuth tokens, Auth0's Token Vault manages the refresh lifecycle: handling consent flows, storing tokens, and refreshing them automatically.[^auth0-vault] The pattern is consistent across implementations: credential lifecycle is infrastructure, not application logic.

Okta's four design principles for lifecycle-aware authorization capture the full requirement:[^okta-outlives]

1. **Durable delegated identity.** Every agent has its own identity, separate from users, governed and auditable.
2. **Continuously renewable authorization.** Access adjusts automatically as the task, user, or environment changes.
3. **Instant cross-system de-provisioning.** Revoking access in one place shuts it down everywhere.
4. **Real-time authorization validation.** Actions get re-checked against current policies at the moment they happen, not just when credentials were issued.

### Scope drift

An agent provisioned with read access to a CRM does not stay a CRM reader. It gets connected to email. Then to a calendar API. Then to a payment system. Each connection happens incrementally, each makes sense in isolation, and the cumulative effect is an agent with far broader authority than anyone intended.

SailPoint's adaptive identity framework (March 2026) addresses this with continuous, automated governance: detecting, preventing, and remediating risk the moment it appears, rather than waiting for periodic access reviews.[^sailpoint] The shift from quarterly certification campaigns to real-time policy enforcement is the difference between discovering scope drift after a breach and preventing it before the drift accumulates.

The Gravitee 2026 survey found that only 47.1% of an organization's AI agents are actively monitored or secured.[^gravitee] More than half operate without any security oversight or logging. Scope drift in unmonitored agents is invisible until it produces an incident.

### Continuous authorization

Traditional authorization is a point-in-time decision: the agent presents a token, the resource server checks it, access is granted or denied. For agents that operate autonomously over extended periods, point-in-time authorization is insufficient.

Re-evaluate authorization at execution time, not just at token issuance time. Has the user who delegated authority revoked it? Has the agent's context changed? Has the policy changed? Has the risk level of the action changed?

The Cryptographic Authorization chapter's CAAM pattern implements this: every tool call passes through a sidecar that evaluates the agent's session context, the requested action, and the current policy before permitting execution. The lifecycle dimension adds temporal context: how long has this agent been running? When were its credentials last rotated? Is the delegating user still active?

## Death: Decommissioning

Agents are easy to create and hard to kill.

### Why agents do not die

Three forces keep agents alive past their usefulness:

**Nobody knows they exist.** Shadow agents, by definition, were never registered. You cannot decommission what you cannot find. Token Security's platform addresses this first: automatic discovery of every AI agent, custom GPT, and coding agent using MCP servers across hybrid multi-cloud environments.[^token-security]

**Nobody owns them anymore.** The developer who created the agent left the company. The team that used it reorganized. The project it supported ended. The agent keeps running because nobody has the authority (or the knowledge) to shut it down. CyberArk found that 45% of financial services organizations have unsanctioned AI agents creating identity silos outside formal governance programs.[^cyberark-96]

**Nobody knows the dependencies.** Shutting down an agent might break a workflow that another team depends on. Without a dependency map, decommissioning is risky. The safe default becomes "leave it running," which means the credential lives forever.

### What decommissioning requires

Token Security's lifecycle management framework defines four phases of agent decommissioning:[^token-security]

1. **Identification.** Confirm the agent is a candidate for retirement: its task is complete, its owner has approved shutdown, or its credentials have exceeded their maximum lifetime.
2. **Dependency analysis.** Map what depends on this agent. Which workflows call it? Which data sources does it access? Which other agents interact with it?
3. **Credential revocation.** Revoke all active sessions, rotate and then delete the API keys associated with the agent, and propagate the revocation across every system the agent had access to.
4. **Audit preservation.** The agent's activity log, credential history, and authorization decisions must survive the agent itself. Compliance and incident response require the ability to reconstruct what a decommissioned agent did, potentially years after it stopped running.

Saviynt adds a governance gate: retirement requires an approved request, validated by the accountable owner and business sponsor, to prevent accidental shutdown of active workflows.[^saviynt]

### The orphan problem

An orphan agent is one whose owner is gone, whose purpose has ended, or whose credentials have not been rotated within policy. Orphans are the most dangerous category because they combine broad historical permissions with zero ongoing governance.

Token Security's approach: assign clear human and departmental ownership to each discovered agent, enforce authentication hygiene protocols, and retire or deprovision dormant agents before they become long-term risks.[^token-security]

Microsoft's March 2026 Entra Agent ID creates a dedicated identity type for agents within the identity provider itself, with lifecycle management (creation, rotation, and decommissioning) governed by the same entitlement management processes used for human identities.[^entra-agent-id] The architectural decision to put agents in the same identity directory as humans means orphan detection uses the same processes: if a human identity is deactivated, every agent identity they own gets flagged for review.

## The Emerging Infrastructure

The lifecycle management tooling landscape consolidated in early 2026.

**Token Security** (RSAC 2026 Innovation Sandbox finalist) provides continuous discovery, lifecycle governance, and intent-based access controls for AI agents. Their platform correlates AI agents, humans, secrets, permissions, and data in a unified identity graph, revealing the blast radius and enabling remediation at scale.[^token-security] Token's selection as an RSAC finalist, alongside Geordie AI (agent governance platform), signals that investor and industry attention has shifted from "can agents work?" to "can agents be governed?"[^rsac-finalists]

**Okta for AI Agents** (early 2026) integrates agents into Okta's identity security fabric: discovery, provisioning, authorization, and governance for non-human identities at scale. The platform extends existing identity governance processes to AI agents, applying the same lifecycle management used for human identities to agent credentials and entitlements.[^okta-lcm]

**SailPoint** (March 2026) extended its adaptive identity framework with connectors that discover and govern AI agents from platforms including Microsoft 365 Co-Pilot, Databricks, Amazon Bedrock, Google Vertex AI, Microsoft Foundry, Salesforce Agentforce, ServiceNow AI Platform, and Snowflake Cortex AI.[^sailpoint]

**Saviynt** provides a six-phase framework covering registration, ownership management, entitlement assignment, lifecycle governance, retirement, and integration with access gateways and IGA systems. Their approach emphasizes that agents follow the same lifecycle as human identities, only faster and at a scale human identities never could.[^saviynt]

The pattern across all four platforms: agents are treated as first-class identities with the same lifecycle governance as human users, but with shorter credential lifetimes, continuous authorization, and automated decommissioning. The distinction from human identity governance is operational tempo, not governance model.

## The Standards Consolidation

The IETF draft-klrc-aiagent-auth (March 2026) represents the first attempt to consolidate the agent lifecycle from the standards perspective.[^klrc] Co-authored by engineers from Defakto Security, AWS, Zscaler, and Ping Identity, the draft maps existing standards to agent scenarios:

- **Identity:** WIMSE/SPIFFE for workload-level, OAuth/OIDC for application-level
- **Authentication:** mTLS with short-lived workload identities as the primary mechanism
- **Authorization:** OAuth 2.0 token exchange (RFC 8693) for delegation, with the Agent Authorization Profile (AAP) for structured capabilities
- **Lifecycle:** SCIM for cross-application provisioning and deprovisioning

The draft's value is not in new protocol design. It is in consolidation: showing practitioners which existing standards apply at each lifecycle phase and where new work is needed. The gap analysis identifies credential lifecycle management as the area with the least mature standardization: identity issuance and authentication have clear standards, but credential rotation coordination across trust domains, automated decommissioning triggers, and orphan detection remain implementation-specific.[^klrc]

## PAC Framework Mapping

Agent lifecycle management spans all three pillars:

**Potential.** Agents can only deliver value if they are properly provisioned. An agent without a clear identity, scope, and owner may function, but it accumulates risk with every action. Lifecycle management is the operational prerequisite for capturing agent value safely.

**Accountability.** Every lifecycle event creates an audit record: who provisioned this agent, what authority they granted, when credentials were rotated, who approved decommissioning. The lifecycle log is the accountability chain. Without it, incident response cannot reconstruct what happened.

**Control.** Credential rotation, scope enforcement, continuous authorization, and decommissioning are all control mechanisms. The lifecycle is the temporal dimension of control: it is not enough to enforce boundaries at a point in time. The boundaries must hold across the agent's entire operational lifetime.

| Level | Potential | Accountability | Control |
|-------|-----------|----------------|---------|
| I1: Ad hoc | Agents created on demand, no registration | No lifecycle records | Credentials set at creation, never rotated |
| I2: Aware | Agent registry exists, ownership assigned | Provisioning and decommissioning logged | Manual credential rotation on schedule |
| I3: Managed | Provisioning requires approval workflow | Full lifecycle audit trail | Automated rotation, decommissioning policy |
| I4: Integrated | Cross-platform discovery and provisioning | Lifecycle events feed SIEM/compliance | Continuous authorization, orphan detection |
| I5: Adaptive | Intent-aware provisioning, dynamic scoping | Real-time lifecycle analytics | Automated decommissioning, zero standing credentials |

## What to Do Now

1. **Inventory what exists.** Before governing lifecycles, you need to know which agents are running. Use discovery tooling (Token Security, SailPoint, Okta) to find agents across cloud platforms, low-code tools, and custom deployments.

2. **Assign owners.** Every agent needs a named human owner. Start with the agents that have privileged access. If the creator is gone, assign the owner of the data or system the agent accesses.

3. **Set credential lifetimes.** No credential should outlive its purpose. For agents using OAuth tokens, implement automated refresh via token management infrastructure (Auth0 Token Vault, Okta). For agents using service accounts, move to short-lived workload identities (SPIFFE/SPIRE). The target: no credential lives longer than 24 hours without automated renewal.

4. **Define decommissioning triggers.** An agent should be flagged for decommissioning when: its owner leaves the organization, its credentials have not been used in 30 days, its declared purpose has been fulfilled, or its credential lifetime has exceeded policy. Automate the flagging. Require human approval for the shutdown.

5. **Preserve the audit trail.** When an agent is decommissioned, its lifecycle records must survive it. Activity logs, credential history, authorization decisions, and the decommissioning approval chain are all compliance and incident response requirements.

[^cyberark-82]: CyberArk, "Machine Identities Outnumber Humans by More Than 80 to 1: New Report Exposes the Exponential Threats of Fragmented Identity Security," 2025. Machine identities outnumber human identities by more than 80 to 1 across organizations worldwide. 42% of machine identities have privileged or sensitive access; 88% of organizations define "privileged user" as applying solely to human identities.

[^cyberark-96]: CyberArk, "96 machines per human: The financial sector's agentic AI identity crisis," 2026. Financial services organizations report 96 machine identities per human. 45% admit unsanctioned AI agents are already creating identity silos outside formal governance programs.

[^okta-outlives]: Okta, "AI Security: When Authorization Outlives Intent," 2026. Four design principles for lifecycle-aware authorization: durable delegated identity, continuously renewable authorization, instant cross-system de-provisioning, real-time authorization validation.

[^saviynt]: Saviynt, "Managing AI Agent Lifecycles: Birth to Retirement," 2026. Six-phase framework for agent lifecycle governance. Requires globally unique ID and accountable owner at registration. Retirement requires approved request validated by owner and business sponsor.

[^klrc]: IETF, "AI Agent Authentication and Authorization," draft-klrc-aiagent-auth-00, March 2, 2026. Co-authored by Defakto Security, AWS, Zscaler, and Ping Identity. Maps existing standards (WIMSE, SPIFFE, OAuth) to agent authentication and authorization scenarios. Identifies credential lifecycle management as the least mature area.

[^trust-inversion]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," February 3, 2026. "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task."

[^profiler]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," February 26, 2026. "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built."

[^teleport]: Teleport, "2026 State of AI in Enterprise Infrastructure Security," 2026. 70% of organizations grant AI systems higher levels of privileged access than humans would receive for the same task. Organizations granting excessive permissions experience 4.5x more security incidents.

[^token-security]: Token Security, "AI Agent Identity Lifecycle Management," 2026. Continuous discovery, lifecycle governance, and intent-based access controls. Correlates AI agents, humans, secrets, permissions, and data in a unified identity graph. RSAC 2026 Innovation Sandbox finalist.

[^rsac-finalists]: RSAC Conference, "Finalists Announced for RSAC Innovation Sandbox Contest 2026," February 2026. Top 10 finalists include Token Security (agent identity security) and Geordie AI (agent governance platform). Each finalist awarded $5M investment.

[^okta-lcm]: Okta, "AI Agent Lifecycle Management: Identity-first Security," 2026. Okta for AI Agents integrates agents into identity security fabric: discovery, provisioning, authorization, and governance for non-human identities.

[^sailpoint]: SailPoint, "SailPoint redefines identity security with new adaptive identity innovations," March 9, 2026. Extends identity governance to AI agents with connectors for Microsoft 365 Co-Pilot, Databricks, Amazon Bedrock, Google Vertex AI, and others. Continuous automated governance replacing periodic reviews.

[^spiffe]: SPIFFE/SPIRE, spiffe.io. Short-lived cryptographic identities for workloads. Automatic credential rotation. Identity derived from runtime environment attestation, not pre-shared secrets.

[^wimse-agents]: IETF, "WIMSE Applicability for AI Agents," draft-ni-wimse-ai-agent-identity-02, 2026. Identity Proxy for credential management: rotation, scope verification, and credential augmentation. Agents do not handle their own credential lifecycle.

[^auth0-vault]: Auth0, "Auth0 for AI Agents," October 2025. Token Vault manages OAuth lifecycle for agents: consent flows, token storage, and automatic refresh.

[^gravitee]: Gravitee, "State of AI Agent Security 2026," 2026. Survey of 919 executives and practitioners. Only 47.1% of AI agents are actively monitored or secured. Only 21.9% of teams treat AI agents as independent, identity-bearing entities.

[^entra-agent-id]: Microsoft, "Entra Agent ID," March 2026. Dedicated identity type for agents within Entra. Lifecycle management (creation, rotation, decommissioning) governed by entitlement management processes.
