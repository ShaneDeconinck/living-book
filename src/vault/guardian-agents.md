---
title: Guardian Agents
tags: [governance, market-category, runtime, accountability]
dimension: infrastructure-as-gate
---

Gartner's term for the emerging market category combining AI governance and AI runtime controls: automated infrastructure that makes agent behavior trustworthy, secure, and auditable without requiring continuous human monitoring.

Defined in Gartner's first-ever Market Guide for Guardian Agents (February 25, 2026). The guide formalized that agent governance is a standalone enterprise category, not a feature of existing security tooling.

## Three core capabilities

**Visibility and traceability** — understanding what agents do, across all deployments, including shadow agents. Not just activity logs but delegation chains, intent capture, and scope verification.

**Continuous evaluation** — ongoing behavioral assessment against baselines, not just pre-deployment testing. Catching drift between what an agent was authorized to do and what it is actually doing.

**Runtime enforcement** — real-time policy application. Not advisory ("flag this") but structural ("prevent this"). The guardian agent executes enforcement on behalf of human oversight.

## Key Gartner predictions

"Through 2028, at least 80% of unauthorized AI agent transactions will be caused by internal violations of enterprise policies concerning information oversharing, unacceptable use or misguided AI behavior — rather than from malicious attacks." The primary risk is not adversaries. It is your own agents violating your own policies because those policies are not infrastructure-enforced.

By 2029, independent guardian agents will eliminate the need for almost half of incumbent security systems protecting AI agents in over 70% of organizations. The market is not just growing — it is replacing existing security infrastructure with purpose-built agent governance.

## ICAM convergence

The guide identifies a structural convergence trend: traditional separation between identity/credential/access management (ICAM) and information governance is narrowing for agents. Agents simultaneously need:
- **Identity** — who is this agent?
- **Access control** — what can it reach?
- **Data governance** — what is it allowed to see?

Managing these as separate silos creates the governance gaps that [[shadow-agents]] exploit.

## Market context

Representative vendors (Gartner guide, 2026): PlainID (agent identity and authorization), NeuralTrust (agent risk and runtime security), Wayfound (agent supervision and performance monitoring), Holistic AI (AI governance), Opsin (agent security and posture management).

Also: Token Security and Geordie AI both appeared as RSAC 2026 Innovation Sandbox finalists specifically for agent governance — signaling the market moved from "interesting problem" to "fundable product category" within a single year.

AI governance spending forecast: $492 million in 2026, surpassing $1 billion by 2030 (Gartner).

## Connects to

- [[shadow-agents]] — the primary target; visibility and runtime enforcement address ungoverned agent behavior
- [[agent-registry]] — the registration infrastructure guardian agents depend on for identity and scope verification
- [[infrastructure-in-the-loop]] — guardian agents operationalize this principle as a product category
- [[evaluation-as-governance]] — continuous evaluation is the guardian agent's Potential-pillar function
- [[fleet-governance]] — guardian agents provide the infrastructure fleet-scale governance requires
- [[controllability-trap]] — guardian agents provide the external governance capability that makes controllability tractable

## Sources

- [Gartner 2026]: Gartner, "Market Guide for Guardian Agents," Avivah Litan and Daryl Plummer, February 25, 2026
- Chapter: [Shadow Agent Governance](../chapters/shadow-agent-governance.md)
