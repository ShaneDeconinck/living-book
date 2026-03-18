---
title: Shadow Agents
tags: [accountability, governance, risk]
dimension: shadow-agents
---

AI agents deployed by employees without going through organizational governance processes — using personal credentials, operating without audit trails, invisible to security teams. Part of the [[accountability-pillar]] of the [[pac-framework]].

## The problem

Shadow agents exist. Employees build them using low-code tools, browser extensions, and LLM APIs without compliance review. These agents use the employee's credentials, operate without [[delegation-chain]] tracing, and the organization does not know they exist.

The first accountability question is not "who is responsible for this agent?" It is: "do you know every agent running in your organization?" [Deconinck 2026 PAC Framework]

## Scale of the problem

- 98% of organizations report employees using unsanctioned apps [Varonis 2025]
- 78% of employees bring their own AI tools to work regardless of company policy [Microsoft WorkLab 2024]
- 1 in 5 organizations has experienced a breach tied to shadow AI [IBM 2025]
- Only 14.4% of deployed agents went live with full security and IT approval [Gravitee 2026]

## Why existing IAM fails for agents

Organizations have invested decades in identity and access management for humans and applications. Neither model works for agents.

**Human IAM assumes judgment.** Organizations give humans roles, adequate boundaries, and rely on them to exercise judgment within those. Agents cannot exercise judgment in the way humans do. They fail unpredictably and do not know when they are wrong.

**Application IAM assumes fixed behavior.** Traditional service accounts have fixed scopes: a payroll application accesses payroll data, a CRM accesses customer records. Agents are general-purpose. The same agent framework can be pointed at any task, any data source, any API. OAuth scopes designed for applications are too coarse for agents that need task-specific, time-bounded access.

**Neither model assumes autonomous decision-making.** Both human and application IAM assume that the entity follows instructions. Agents create intent — they decide what to do given a goal. This is the [[trust-inversion]]: "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task."

Quantified mismatch: 95% of enterprises run AI agents that autonomously perform IT or security tasks, and 47% of organizations report more non-human identities than human users, yet only 22% have full visibility into those identities. [ConductorOne 2026]

## The confidence gap

82% of executives feel confident their policies protect against unauthorized agent actions. That confidence rests on high-level policy documentation, not real-time enforcement at the API or identity layer. [Gravitee 2026]

Only 28% of organizations can reliably trace agent actions back to a human sponsor across all environments. Only 21% maintain a real-time inventory of active agents. Nearly 80% of organizations deploying autonomous AI cannot tell, in real time, what those systems are doing or who is responsible for them. [CSA/Strata 2026]

This is not an intent gap. 40% of those organizations are increasing identity and security budgets specifically for agent risks. It is an infrastructure gap. Policy confidence without infrastructure enforcement is the Accountability-Control gap the PAC Framework identifies.

## Why shadow agents persist

Shadow agents emerge when governance moves too slowly. The gap between "an employee needs an agent to work" and "governance approves that agent" creates the shadow. The solution is not tighter prohibition — that does not work, as the statistics show. It is governance at agent speed.

Shane's PAC question #10: "Can your infrastructure prevent an agent from running without being registered?" This separates discovery (knowing what agents exist) from structural enforcement (making unregistered agents unable to operate). Only [[infrastructure-levels]] I4+ provides the structural guarantee.

## Discovery approaches

1. **Network scanning**: identify agent-related traffic patterns, API calls to LLM providers, MCP connections
2. **Agent registry**: centralized catalog where agents must register to authenticate (Microsoft Entra Agent ID implements this)
3. **SCIM provisioning enforcement**: if agent identities can only be provisioned through governed channels, unregistered agents cannot authenticate to SCIM-integrated applications
4. **Credential audit**: map which service accounts and API keys are being used by agents vs. human users

See `src/chapters/shadow-agent-governance.md` for full treatment.

## Connects to

- [[accountability-pillar]] — shadow agents represent Accountability without visibility
- [[delegation-chain]] — shadow agents have no delegation chains; accountability is structurally impossible
- [[infrastructure-levels]] — I4+ structurally prevents shadow agents from authenticating
- [[agent-identity]] — shadow agents reuse human credentials rather than having their own identity
- [[trust-inversion]] — the IAM architecture mismatch is the structural argument for why trust must be inverted for agents
- [[agent-registry]] — the infrastructure that converts discovery into prevention
- [[amnesty-model]] — the transition pattern for governing discovered shadow agents
- [[guardian-agents]] — the runtime enforcement category that shadow agent governance requires
- [[governance-ownership-models]] — the three organizational models (centralized → federated → infrastructure-enforced) for closing the shadow agent gap

## Sources

- [Varonis 2025]: Varonis, "Shadow AI: The Growing Risk of Unsanctioned AI in the Enterprise," 2025
- [Microsoft WorkLab 2024]: Microsoft, 2024 Work Trend Index, May 2024
- [IBM 2025]: IBM, Cost of a Data Breach Report, 2025
- [Gravitee 2026]: Gravitee, "State of AI Agent Security 2026," February 2026
- [ConductorOne 2026]: ConductorOne, "Future of Identity Report 2026," March 10, 2026
- [CSA/Strata 2026]: Cloud Security Alliance and Strata Identity, "Securing Autonomous AI Agents," February 5, 2026
