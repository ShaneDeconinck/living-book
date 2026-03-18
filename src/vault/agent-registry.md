---
title: Agent Registry
tags: [governance, identity, control, infrastructure]
---

A centralized catalog where every agent operating in an organization must be registered before it can access organizational resources. The enforcement mechanism that turns shadow agent discovery into shadow agent prevention.

The distinction between a registry and a wish list: "A registry that depends on voluntary compliance is not a registry." [Deconinck 2026 Boardroom] Enforcement is what separates I2 (inventory) from I4 (governed).

## What a registry contains

For each registered agent:

- **Identity** — unique identifier, platform, relationship to other agents
- **Owner** — who deployed it, who maintains it, who is accountable for its actions
- **Authority** — what delegated it the right to act; the human or system that authorized it; the scope of that authorization
- **Permissions** — specific data sources, APIs, tools, and granularity of access (read/write/execute, per-resource, time-bounded)
- **Blast radius** — worst-case impact of failure; determines governance threshold and required infrastructure level
- **Evaluation status** — reliability metrics, error margin, evaluation scope
- **Regulatory classification** — EU AI Act risk tier, NIST guidelines, other applicable regulation

## How enforcement works

A registry entry alone does not govern an agent. Enforcement requires integration with the infrastructure the agent depends on:

**Identity providers** — agent credentials issuable only through the registry. If an agent cannot obtain OAuth tokens, API keys, or service credentials without registration, unregistered agents cannot authenticate to organizational resources.

**API gateways and agent gateways** — Cedar policies and similar controls check registration status on every MCP server connection, every A2A task request, every API call. See [[mcp-gateway]].

**Network controls** — agents that cannot reach external services without passing through a governed proxy cannot exfiltrate data or connect to unauthorized APIs. [[sandboxing]] at the organizational level.

**Platform controls** — low-code platforms (Copilot Studio, Agentforce) configured to require registration as a deployment prerequisite. Where platforms cannot enforce this natively, the gateway layer provides the enforcement point.

## Two registry models

**Vendor registry** — a platform-specific registry. Microsoft Agent 365 is the reference implementation: each agent gets an Entra Agent ID with lifecycle management, a centralized catalog spanning sanctioned and shadow agents, and enforcement through the Microsoft identity stack. Scope limitation: governs agents within the Microsoft ecosystem. For Fortune 500 organizations where 80% of agents run on Microsoft platforms, this is a significant step from I1 to I3. [Microsoft 2026]

**Consortium registry** — an industry-operated registry with no single vendor in control. The IAB Tech Lab Agent Registry (February 26, 2026) is the first example: free registration, open to members and non-members, each entry tied to existing compliance identifiers (GPP ID, IAB TCF GVL ID). Within two weeks of launch, ten agents registered from Amazon, PubMatic, Equativ, Optable, and others. All ten use MCP as the protocol standard. [IAB Tech Lab 2026]

The architectural distinction matters: a vendor registry scales within a platform. A consortium registry scales across an ecosystem. The advertising industry reached this point because it already had compliance infrastructure (GPP, TCF) to build on. Other sectors need equivalent foundations before consortium registries become viable.

## Infrastructure maturity mapping

| Level | Registry Capability |
|---|---|
| I1 | No registry. Shadow agents operate freely. |
| I2 | Discovery tools deployed. Inventory exists but is periodically updated, not continuously enforced. |
| I3 | Registry operational. Registration required for access. Identity verification. Structured audit trails. |
| I4 | Registry enforcement through infrastructure (identity providers, gateways, network controls). Delegation chains captured and auditable. |
| I5 | Unregistered agents structurally unable to operate. Full delegation chains. Anomaly detection. Cryptographic proof of authorization at every step. |

## Sector implementations

Healthcare (Imprivata Agentic Identity Management, March 2026): agents as managed identities, short-lived tokens brokered with continuous identity verification, least-privilege enforcement, designed for PHI/HIPAA constraints. [Imprivata 2026]

Microsoft internal validation: 500,000+ agents governed across the organization through the same platform shipped to customers. Research, coding, sales intelligence, customer triage, HR self-service as the highest-volume categories. [Microsoft 2026]

## Connects to

- [[shadow-agents]] — the population registries exist to govern; the transition via [[amnesty-model]]
- [[guardian-agents]] — the runtime enforcement infrastructure a registry anchors
- [[infrastructure-levels]] — the maturity model that defines what each registry capability level provides
- [[delegation-chain]] — the registry captures the authorization chain that [[accountability-pillar]] requires
- [[blast-radius]] — determines governance tier and required infrastructure level for each registered agent
- [[non-human-identity]] — agent registry is the lifecycle governance layer NHIs have historically lacked

## Sources

- [Deconinck 2026 Boardroom]: Shane Deconinck, "Agentic AI: Curated Questions for the Boardroom," February 8, 2026
- [Microsoft 2026]: Microsoft, "Microsoft Agent 365: The Control Plane for Agents," March 9, 2026. Generally available May 1, 2026. $15/user/month standalone.
- [IAB Tech Lab 2026]: IAB Tech Lab, "Introducing the IAB Tech Lab Agent Registry," February 26, 2026. Part of the Agentic Advertising Management Protocols (AAMP) framework.
- [Imprivata 2026]: Imprivata, "Imprivata Introduces Agentic Identity Management," HIMSS 2026, March 10, 2026
- Chapter: [Shadow Agent Governance](../chapters/shadow-agent-governance.md)
