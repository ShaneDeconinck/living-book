---
title: Amnesty Model
tags: [governance, shadow-agents, transition, pattern]
dimension: shadow-agents
---

A governance transition pattern for converting shadow agent deployments into governed ones: discover everything, classify by risk, offer a registration window without penalties, triage by blast radius, then enforce structurally after the window closes.

The alternative — blanket prohibition — fails because it drives adoption underground. Employees route to personal devices and external services the organization cannot monitor. The shadow gets deeper, not shallower.

## Six-step pattern

1. **Discover and inventory.** Deploy discovery tools (OAuth consent monitoring, network API analysis, low-code platform audits) to build a complete picture within 30 days.

2. **Classify by risk.** Apply the PAC [[blast-radius]] scale (B1-B5) and infrastructure requirements (I1-I5) to each discovered agent. Not all shadow agents are equally dangerous.

3. **Amnesty period (30-90 days).** Give agent creators a defined window to register. Provide clear guidance: what information is needed, how to assess blast radius, what permission adjustments are required. Make registration easy. If it takes longer to register an agent than to build one, registration will not happen.

4. **Triage registered agents.**
   - B1-B2 (Contained/Recoverable): fast-track approval with standard permissions scoping and basic audit logging
   - B3 (Exposed): require evaluation metrics, structured audit trails, monitoring
   - B4-B5 (Regulated/Irreversible): full compliance assessment, identity verification, scoped authorization, sandboxing, anomaly detection

5. **Enforce after amnesty.** Enable registry enforcement through infrastructure controls. Unregistered agents lose access to organizational resources.

6. **Maintain the path.** Keep registration frictionless. If employees need agents, they should be able to deploy governed agents faster than they could build shadow ones. The governed path must be the path of least resistance.

## Why it works

The amnesty model treats shadow agent creators as early adopters, not policy violators. Shadow agents exist because employees hit real bottlenecks, found a tool that solved the problem, and deployed it. Penalizing that behavior teaches employees to hide future deployments.

Shane's framing: "The governance system must enable agent autonomy within safe boundaries, not prevent it. Agents that need human approval for every action aren't agents: they're suggestion engines."

## What it requires

The amnesty model can only work if the governed path is genuinely faster than the shadow path. This means:
- Self-service registration for B1-B2 risk tiers
- Automated risk classification
- Infrastructure enforcement (not manual review) as the governance mechanism

The organizational models that scale: federated governance with central standards, and ultimately infrastructure-enforced governance where the registry is integrated with identity providers, agent gateways, and network controls so unregistered agents structurally cannot function.

## Connects to

- [[shadow-agents]] — the population this model is designed to govern
- [[agent-registry]] — the registration infrastructure the amnesty model feeds into; step 5 is registry enforcement
- [[blast-radius]] — the classification tool that determines the governance path for each agent
- [[infrastructure-levels]] — the target state (I5: unregistered agents structurally unable to operate)
- [[consent-theater]] — amnesty registration is the point where actual scope gets assessed vs. the inherited tokens the shadow agent was using
- [[guardian-agents]] — the runtime enforcement infrastructure the governed path deploys
- [[governance-ownership-models]] — the three organizational ownership models; amnesty works only within the infrastructure-enforced model where the governed path is faster than the shadow path

## Sources

- [Deconinck-boardroom 2026]: Shane Deconinck, "Agentic AI: Curated Questions for the Boardroom," February 8, 2026
- Chapter: [Shadow Agent Governance](../chapters/shadow-agent-governance.md)
