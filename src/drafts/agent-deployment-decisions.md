# Agent Deployment Decisions: When Autonomy Is Earned

Most governance conversations ask the wrong question. "How risky is this agent?" bundles together four different questions: what does the agent do, what happens when it fails, how much freedom does it have, and have you built the infrastructure to contain it. Collapse those into one question and the answer will be wrong.

The alternative is to separate the dimensions and let autonomy fall out as a result — not as a starting assumption.

## What Anthropic's Data Shows

Anthropic published an empirical analysis of millions of real agent interactions in February 2026, scoring agent tasks on two axes: autonomy (is the agent following explicit instructions or operating independently?) and risk (what happens if something goes wrong?).[^anthropic-autonomy]

Today, most agent actions are low-risk and reversible. Software engineering accounts for nearly 50% of all agentic tool calls. The data also shows emerging usage in healthcare, finance, and cybersecurity. The upper-right quadrant — high autonomy combined with high risk — is "sparsely populated but not empty": patient medical records, cryptocurrency trading, production deployments are appearing. Anthropic expects this frontier to expand as agents move into domains where the stakes are higher than fixing a bug.[^anthropic-autonomy]

What the data also shows: 80% of tool calls in the wild have at least one safeguard in place, and 73% involve human oversight of some form. People are building infrastructure before granting autonomy, not after. The governance instinct is right. The frameworks to structure it are still developing.

## Six Dimensions, One Dependent Variable

Shane describes a model built from this empirical base and the PAC Framework — the PAC Agent Profiler — that structures the deployment decision across six dimensions. Five are independent inputs; the sixth, autonomy, is the output that follows from the others.[^pac-profiler]

**Business value** is why you would accept any risk at all. This agent could collapse a workflow from days to minutes, save millions, unlock something previously impossible. Without a clear answer here, there is nothing to discuss.

**Reliability** is the reality check. Better models, better prompts, better evals, better guardrails. Most teams focus here, and it matters. But reliability is only meaningful relative to what happens when the agent fails. An agent that fails 5% of the time is a different deployment decision depending on what those failures produce.

**Blast radius** is the worst-case impact of failure. Five levels:[^pac-profiler]

- **Contained**: errors caught before any external impact
- **Recoverable**: a small group affected, the situation reversible
- **Exposed**: public-facing impact, hard to recall
- **Regulated**: compliance or legal consequences
- **Irreversible**: money, contracts, safety — outcomes that cannot be undone

Shane's observation about blast radius is the one worth holding: it is fixed by the use case, not by engineering. You can build a more reliable agent. You cannot engineer your way to a smaller blast radius. The only way to reduce blast radius is to choose different use cases or scope what the agent can touch. This makes blast radius a deployment filter, not a dial.

**Infrastructure** is the guardrails you have actually built: audit trails, identity verification, authorization frameworks, sandboxing, monitoring. This is where the model gets opinionated.

**Governance thresholds** represent where the organization draws its lines. Regulatory requirements, internal policies, risk appetite. An agent might be technically capable of full autonomy, but if compliance requires human approval for anything touching customer data, that is the ceiling. The threshold is external to the agent and to engineering.

**Autonomy** is the output. Not an input you set, but a level the agent earns based on everything else.

## Infrastructure as a Gate

Most frameworks treat everything as a spectrum. Infrastructure does not work that way.

Shane: "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built."[^pac-profiler]

In the PAC Agent Profiler, infrastructure is binary per autonomy level. Each level requires a specific set of capabilities. If you have not built them, that level is locked — regardless of how reliable the agent is. A capable agent without audit trails cannot be trusted with delegated authority, because when something goes wrong you have no way to understand what happened.

This makes the framework actionable. Instead of "improve your governance posture," it says specifically: "you need identity verification and authorization scopes before this agent can move from human-approval to oversight mode."

The infrastructure requirements are cumulative:[^pac-profiler]

| Autonomy Level | Infrastructure Required |
|---|---|
| Level 1 — Suggestion | None mandatory; agent recommends, human decides |
| Level 2 — Approve | Basic logging, human confirmation flows |
| Level 3 — Oversight | Structured audit trails, monitoring |
| Level 4 — Delegated | Identity verification, scoped authorization, sandboxing |
| Level 5 — Autonomous | All above, plus anomaly detection, automated containment |

You cannot skip levels. An agent operating at Level 4 without identity verification is not "mostly governed." It is ungoverned in the dimension that matters most for that level: knowing which agent is acting and whether it is authorized to act.

At I2 (Logged), the human can investigate after the fact but cannot prevent unauthorized actions in real time. At I4 (Authorized), scoped permissions are enforced before each action. The infrastructure level determines the maximum achievable autonomy level. They are not independent variables.

## Autonomy Is the Dependent Variable

The five autonomy levels map to decreasing human involvement:[^pac-profiler]

1. **Suggestion**: the agent recommends, the human decides and acts
2. **Approve**: the agent prepares, the human reviews and confirms
3. **Oversight**: the agent acts, the human monitors and can intervene
4. **Delegated**: the agent acts within defined boundaries, the human reviews periodically
5. **Autonomous**: the agent acts independently, the human is notified of exceptions

The starting point is not "this agent should be autonomous." The starting point is the other five dimensions. Assess business value, reliability, blast radius, infrastructure, and governance thresholds. The appropriate autonomy level follows.

This also means autonomy changes over time. As you build infrastructure, improve reliability, or as governance thresholds shift, the same agent can earn a higher level. It is a progression, not a one-time decision. New users of Claude Code fully auto-approve about 20% of sessions. After roughly 750 sessions, that number climbs past 40%.[^anthropic-autonomy] They are not becoming reckless. They are responding to accumulated evidence that the system is reliable enough for higher delegation. The infrastructure was always there. The operator's confidence in it grew through experience.

The progression also runs in reverse. If blast radius expands because the agent is granted access to additional systems, the required infrastructure level increases. If the organization's governance thresholds tighten due to regulatory change, the autonomy ceiling drops. The model is not a one-time classification. It is a governance state that requires ongoing maintenance.

## The Governance Trap in Practice

The common failure: organizations grant high-autonomy deployment to a high-reliability agent without building the corresponding infrastructure.

The agent performs well. The infrastructure gap is invisible until something goes wrong. When it does, there is no audit trail to investigate, no identity verification to establish what acted, no scoped authorization to understand what was permitted. The blast radius, which was always regulated or irreversible for this use case, is fully realized with no containment mechanism in place.

Reliability and autonomy are not the same thing. An agent can be highly reliable and still require full infrastructure build-out before being trusted at Level 4. The distinction matters because reliability is observable in advance. The infrastructure gap is not — it is invisible until it is needed.

This is the infrastructure-as-gate insight applied to deployment decisions: you do not discover the missing guardrail during normal operation. You discover it during the incident you were trying to prevent.

## What to Do Now

**Before authorizing any autonomous deployment:**

Map the use case against all six dimensions, not just reliability and business value. Blast radius in particular is often underweighted: it is easy to estimate optimistically because failures are rare. Estimate it adversarially — what is the worst credible outcome given the systems this agent can reach?

**Infrastructure first:**

Identify the target autonomy level, then audit the infrastructure requirements for that level. Build what is missing before deploying at that level. An agent deployed at Level 4 without identity verification and scoped authorization is a liability, not an asset.

**Treat autonomy as a governance state:**

Document the deployment decision: which autonomy level, what infrastructure is in place, what governance thresholds apply, who owns the periodic review. The deployment is not a one-time decision. It is a state with conditions that change as the agent's environment, blast radius, and infrastructure change.

**Use blast radius to filter use cases, not just to accept risk:**

If the blast radius for a proposed use case is Regulated or Irreversible, and the organization does not have the infrastructure or governance capacity to support Level 4 or Level 5 autonomy, the right answer is not to deploy with lower autonomy and hope for the best. It is to scope the use case to reduce blast radius, or to defer deployment until the infrastructure is in place.

---

[^anthropic-autonomy]: Anthropic, "Measuring AI Agent Autonomy in Practice," anthropic.com/research/measuring-agent-autonomy, February 2026. Risk vs. autonomy scatter plot; upper-right quadrant (high autonomy, high risk) "sparsely populated but not empty." 80% of tool calls have at least one safeguard; 73% involve human oversight. Software engineering accounts for nearly 50% of agentic tool calls. New-user auto-approval rate approximately 20%; climbs past 40% after ~750 sessions.
[^pac-profiler]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026. Six dimensions (business value, reliability, blast radius, infrastructure, governance thresholds, autonomy). Five blast radius levels (contained, recoverable, exposed, regulated, irreversible). Infrastructure as gate, not slider. Five autonomy levels (suggestion, approve, oversight, delegated, autonomous). Cumulative infrastructure requirements per level. PAC Agent Profiler at trustedagentic.ai/profiler/ and open source at github.com/ShaneDeconinck/pac-agent-profiler.
