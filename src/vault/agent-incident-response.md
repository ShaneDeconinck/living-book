---
title: Agent Incident Response
tags: [governance, accountability, security, operations]
dimension: audit-trails
---

Agent incidents are decision failures, not execution failures. This structural difference changes what the response looks like.

Traditional software incidents trace to code that behaved incorrectly — a race condition, an off-by-one error. The fix is a patch. Agent incidents trace to a decision the agent made within its technical authority but outside the intent of whoever delegated that authority. The root cause is not correctable by patching the model. It requires revisiting what was delegated, to whom, and under what conditions.

## Three structural differences from traditional IR

1. **Decision failure, not execution failure.** The agent did not malfunction. It acted on an instruction it was technically permitted to carry out. Governance failed — the delegation scope was wrong for the context, not the code.

2. **Blast radius traces the delegation chain.** In software incidents, blast radius is bounded by data access. In agent incidents, it is bounded by delegated authority across multiple systems, tool integrations, and downstream agents. Requires [[delegation-chain-forensics]], not log scanning.

3. **Containment requires [[coordinated-revocation]].** Revoking the compromised agent's credentials stops that agent. It does not stop downstream agents that already acted on its outputs. Multi-agent containment is closer to distributed transaction rollback than account suspension.

## The governance root cause pattern

Most IR processes stop at "what did the agent do?" The governance root cause is: what delegation failure made this possible?

Three questions frame it:
- Was the [[liability-chain]] documented before the incident?
- Was the delegation recorded at the point of grant (scope, duration, constraints)?
- What did architecture enforce vs. what did policy only advise?

A policy that said "do not run destructive commands during a freeze" is advisory. Architecture that made those commands structurally impossible (scoped credentials excluding write operations, freeze flag reducing authorization scope automatically) is structural. Root cause must identify which layer failed.

## Framework references

- **CoSAI AI Incident Response Framework** (OASIS, October 2025): NIST lifecycle adapted for AI-specific categories with CACAO-standard playbooks. Open-source at cosai-oasis/ws2-defenders.
- **OWASP GenAI IR Guide 1.0**: agentic-specific threats, companion to OWASP Top 10 for Agentic Applications.
- **NIST IR 8596 (Cyber AI Profile)**: conditions for disabling AI autonomy during risk response.

## Connects to

- [[delegation-chain-forensics]] — blast radius assessment requires structured audit logs
- [[coordinated-revocation]] — containment across multi-agent chains
- [[blast-radius]] — blast radius is set at deployment, not during incident response
- [[delegation-chain]] — tracing what the agent was authorized to do
- [[liability-chain]] — A2: the chain must exist before the incident to be usable during one
- [[ghost-token]] — ephemeral credentials reduce containment scope by design
- [[infrastructure-levels]] — I3 is the minimum for tractable blast radius assessment; I1-I2 makes response guesswork
