---
title: Silicon-Based Workforce
tags: [governance, human-agent, organizational, lifecycle]
---

Deloitte's framing of AI agents as workforce participants requiring the same HR-like governance structures as human employees: onboarding, authorization, performance monitoring, and offboarding. [Deloitte-2026]

The framing matters because most organizations treat agents as software deployments (managed by IT) rather than workforce additions (managed by people operations). The governance gaps follow from this mismatch.

## The organizational shift

Most organizations are not moving from "no agents" to "agents." They already have agents, many unsanctioned. The shift is from treating agents as software to treating them as workforce participants with roles, responsibilities, and accountability chains.

Production scale: Zapier reports 89% AI adoption across their organization with 800+ agents deployed internally. [Zapier-2026] Anthropic's Coding Trends Report documents engineers shifting from implementation to orchestration — more architecture and strategy, less routine code. 27% of AI-assisted work consists of tasks that would not have been done at all without agents: new work enabled, not old work automated. [Anthropic-coding-2026]

Organizations that succeed redesign processes around human-agent collaboration rather than automating existing processes. Deloitte's framing: "If you just take your existing workflow and try to apply advanced AI to it, you're going to weaponize inefficiency." [Deloitte-2026]

## Agent lifecycle as workforce management

**Onboarding**: defined role, scoped permissions, designated owner, initial [[autonomy-levels]] setting, documented escalation paths, evaluation criteria. Maps to the agent registry in [[shadow-agents]]: identity, owner, authority, permissions, [[blast-radius]] classification. If you cannot answer "who is responsible for this agent?" the agent should not be in production.

**Performance management**: ongoing evaluation against Potential metrics (does the agent complete tasks correctly?) and Accountability metrics (does it stay in scope? escalate appropriately? maintain audit trail integrity?). Autonomy levels adjust based on demonstrated reliability at the current blast radius.

**Escalation chains**: differentiated escalation, not a single "ask a human" fallback. Technical questions → engineering. Policy questions → compliance. Customer-facing decisions → service team. The agent must know not just when to escalate but to whom.

**Offboarding**: credentials revoked, outstanding authorizations cancelled, audit trails archived, delegated authorities reclaimed. The lifecycle management most organizations lack. Failure here creates the zombie identity problem: credentials outlasting the agent's purpose. See [[authorization-outlives-intent]].

## Governance state

Deloitte reports only 14% of organizations have deployable agentic solutions and 11% are using them in production (2026). The gap between deployment and governance is the [[shadow-agents]] problem: agents proliferating faster than governance structures form around them.

## Connects to

- [[shadow-agents]] — unsanctioned agents are the workforce without HR governance
- [[agent-provisioning]] — birth requirements (identity, owner, scope) are the onboarding checklist
- [[authorization-outlives-intent]] — offboarding failures create the zombie identity problem
- [[autonomy-levels]] — dial settings are performance management artifacts, adjusted as reliability is demonstrated
- [[blast-radius]] — governs the governance ceiling for each agent role

## Sources

- [Deloitte-2026]: Deloitte, "The agentic reality check: Preparing for a silicon-based workforce," Tech Trends 2026
- [Anthropic-coding-2026]: Anthropic, "2026 Agentic Coding Trends Report," March 2026
- [Zapier-2026]: Anthropic, "Zapier builds an AI-first remote culture with Claude for Enterprise," claude.com/customers/zapier, 2026
