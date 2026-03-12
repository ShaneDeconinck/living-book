# When Agents Create Intent

Traditional applications forward user intent. You click "submit order," the app executes that action. You decided; the software carried it out. The audit trail is clean: who did what, when.

Agents break this model. You say "optimise my travel expenses." The agent queries vendors, compares options, books a flight, processes a payment, commits you to a contract. You provided the goal. The agent made the decisions that matter.

As Lewin Wanzer framed it on [Identerati #165](https://www.youtube.com/live/U7ZkE7LxQ5U?si=XAvSxdO0gH6AinIf&t=777): when agents create intent instead of forwarding it, delegation becomes abdication.

This isn't theoretical. Picture an expense-approval agent at a company that authorises $47,000 in vendor payments. The CFO asks "who decided?" The audit log shows alice@company.com. But Alice was in a meeting. She'd delegated authority three months ago. The agent decided, and the audit trail has no way to capture that.

## Why Traditional IAM Breaks

Established identity and access management systems answer two questions: "who is this user?" and "what can this user access?" They don't answer the question that now matters: "who made this decision?"

As Mike Schwartz [put it on the same Identerati episode](https://www.youtube.com/live/U7ZkE7LxQ5U?si=XAvSxdO0gH6AinIf&t=777): data comes with obligations and restrictions, not just access. The question isn't only "can this agent reach this resource?" but "what is it allowed to do once it gets there, and who's responsible for what it chose?"

This is the gap. Every IAM system in production today was designed for actors that forward intent. Agents that create intent need something fundamentally different.

## The Inversion

Organisations minimise constraints on humans. We give people a role, adequate boundaries, and rely on them to use judgment. This works because humans care: about doing good work, about their reputation, about consequences. Common sense creates an internal constraint. You self-regulate because it matters to you personally.

Agents have none of this. An agent is a statistical machine that fails unpredictably, and with current architectures, it always will. It doesn't know when it's wrong. There is no internal brake that stays intact when things go wrong.

So we need to flip the model.

> Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task.

You can't list everything an agent shouldn't do: the list is infinite. Instead, agents start from zero authority and receive explicit grants for what they *can* do. Not "block these actions" but "permit only these actions." This is why OAuth scopes, capability-based security, and explicit tool registration matter: they define the positive space of allowed behaviour.

The same principle applies to delegation chains. When an agent delegates to another agent, authority should only decrease, never expand. If your travel agent can book flights up to $500, any sub-agent it calls inherits that ceiling or lower. Privilege escalation must be structurally impossible.

## Reliability Is Not Governance

I keep seeing these two problems conflated.

**Context engineering** increases reliability: whether the model does what you intended. Better models, better context, verification loops. This is getting solved. With each model upgrade, teams delete scaffolding. The model outgrows the workarounds.

**Governance** manages risk: whether the agent is *allowed* to do what it's about to do. This doesn't get solved by better models. An agent that's right 99% of the time is the one you stop watching. And when it slips, it slips at machine speed.

Don Norman [describes this pattern for automation](https://jnd.org/the-human-side-of-automation/): over fifty years of studies show that even highly trained people cannot monitor automated systems for long periods and then rapidly take effective control when needed. The same applies to agents. As they become more reliable, complacency sets in and guardrails get relaxed.

Human in the loop is not a reliable safety net.

For reliability, the evolution is less harness over time. For governance, it's the opposite: the guardrails can't be lifted. We've never handed the keys to something inherently unpredictable before, and current solutions aren't built for that.

## What This Means

If your agent can decide, you need infrastructure that captures what it decided and what authority it had to decide it. That means:

- **Identity that distinguishes agents from humans**: audit logs must show who delegated and who acted.
- **Fine-grained, positive-space authorisation**: explicit grants per task, not role-based access inherited from the delegating user.
- **Delegation chains with monotonically decreasing authority**: privilege can only shrink through the chain, never grow.
- **Decisions that travel with context**: every action carries proof of what authority existed and where it came from, verifiable at every step.
- **Bidirectional verification**: incoming requests can't be taken for granted either. Shadow AI, unauthorised agents, spoofed identity: we need to know what we're dealing with.

Policy says "don't." Architecture says "can't." You need both, but architecture enforcement is what scales.

The building blocks exist. The next chapter covers what's being built with them.
