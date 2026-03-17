---
title: Shadow Agents
tags: [accountability, governance, risk]
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

## Sources

- [Varonis 2025]: Varonis, "Shadow AI: The Growing Risk of Unsanctioned AI in the Enterprise," 2025
- [Microsoft WorkLab 2024]: Microsoft, 2024 Work Trend Index, May 2024
- [IBM 2025]: IBM, Cost of a Data Breach Report, 2025
- [Gravitee 2026]: Gravitee, "State of AI Agent Security 2026," February 2026
