---
title: Infrastructure Levels
tags: [scale, pac-framework, control, governance]
---

A five-level scale in the [[pac-framework]] measuring the guardrails an organization has actually built for agent governance, from open access to full containment. Part of the [[control-pillar]]. Infrastructure is a gate per [[autonomy-levels]], not a spectrum.

## The five levels

- **I1 Open**: no controls. Agent operates with whatever access it has.
- **I2 Logged**: actions are recorded, but not constrained.
- **I3 Verified**: agent identity is verified before access is granted.
- **I4 Authorized**: access is scoped by role, task, and [[delegation-chain]].
- **I5 Contained**: agent operates in a sandboxed environment with strict boundaries.

## Infrastructure as gate

Most organizations are at I1 or I2. Infrastructure is a gate, not a slider: you either have audit trails or you do not. You either verify agent identity or you do not. There is no "partial" containment that satisfies the requirements for the next autonomy level.

The gate relationship with [[autonomy-levels]]:
- A2 (Approve) → requires I2 minimum (logging + confirmation)
- A3 (Oversight) → requires I3 minimum (identity verification)
- A4 (Delegated) → requires I4 (scoped authorization + sandboxing)
- A5 (Autonomous) → requires I5 (anomaly detection + automated containment)

## Why most organizations stall at I1-I2

Gravitee's 2026 survey of 919 practitioners found only 14.4% of deployed agents went live with full security and IT approval, while 82% of executives feel confident their policies protect against misuse. The gap between policy confidence and infrastructure reality is precisely the gap between I2 and I4: policies exist, enforcement does not. [Gravitee 2026]

The Teleport finding: organizations with broadly scoped agent access (stuck at I1-I2) report 76% security incident rates; organizations with tightly scoped access (at I4) report 17%. Access scope, not AI sophistication, is the predictor. [Teleport 2026]

## Connects to

- [[autonomy-levels]] — gates each level; no autonomy above what infrastructure supports
- [[blast-radius]] — higher blast radius demands higher infrastructure
- [[delegation-chain]] — I4 infrastructure requires tracking authorization through every hop
- [[trust-inversion]] — I4+ implements the allowlist model structurally
- [[shadow-agents]] — agents that bypass infrastructure investment represent ungoverned I1 deployments

## Sources

- [Gravitee 2026]: Gravitee, "State of AI Agent Security 2026," February 2026
- [Teleport 2026]: Teleport, "State of AI in Enterprise Infrastructure Security," February 2026
