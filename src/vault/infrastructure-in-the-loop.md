---
title: Infrastructure in the Loop
tags: [governance, control, architecture, human-agent, oversight]
dimension: infrastructure-as-gate
---

The oversight model this book advocates: infrastructure enforces governance policy automatically, independent of human attention. Policy says what agents should not do; architecture makes it so they *cannot* do it, regardless of what they try.

Shane's framing: the difference between "don't" and "can't." Policy says the agent should not access production databases without authorization. Infrastructure makes it so the agent *cannot* access production databases without authorization. "Don't" depends on the agent's compliance and the human's vigilance. "Can't" depends on neither. [Deconinck-2026]

## Why the prior models fail

**HITL (Human-in-the-Loop)**: agents propose, humans approve. Fails at scale — approval rates climb as volume increases, review quality drops, oversight becomes a checkbox. Anthropic data: new Claude Code users fully auto-approve ~20% of sessions; after 750 sessions, that climbs past 40%. Not recklessness — rational response to a system that is almost always right. This is the [[complacency-trap]] at the authorization layer.

**HOTL (Human-on-the-Loop)**: agents act, humans monitor. Fails when monitoring is passive. The same complacency dynamics apply. [[ironies-of-automation]]: the operator becomes a monitor who no longer has the contextual understanding to intervene effectively when intervention is needed. And the [[controllability-trap]] adds a second failure: even an attentive human may not be able to correct an agent that partially absorbs corrections, resists contrary evidence, or propagates errors faster than human reaction time.

Both models share the same load-bearing assumption: that human attention is available, sustained, and sufficient. Infrastructure-in-the-loop removes that assumption entirely.

## What it changes

The human role shifts from enforcement to design. Humans define authorization boundaries, set blast-radius thresholds, configure anomaly detection rules, investigate flagged incidents. These play to human strengths: judgment, context, strategic thinking.

What humans no longer do is watch a stream of agent actions and approve each one. That was the task they were failing at.

Anthropic's 2026 Agentic Coding Trends Report identifies a complementary scaling mechanism: AI-automated review systems. Instead of adding human reviewers as agent output grows, organizations deploy review agents that maintain quality at scale. The oversight isn't diminished — it's augmented through intelligent tooling. [Anthropic-coding-2026]

## Infrastructure levels and collaboration capability

The [[infrastructure-levels]] scale defines what infrastructure-in-the-loop looks like at each maturity level:

- **I2 (Logged)**: post-hoc review possible; no real-time enforcement.
- **I3 (Verified)**: agent identity confirmed, structured audit trails. Human reviews patterns, not individual actions.
- **I4 (Authorized)**: scoped permissions enforced before each action. Human sets scope; infrastructure enforces it.
- **I5 (Contained)**: sandboxed execution with automatic containment. Human defines containment policies; infrastructure executes them.

HITL is an I2-I3 pattern. HOTL is an I3 pattern. Infrastructure-in-the-loop becomes fully operational at I4-I5: the autonomy dial settings A4-A5 require these levels to be safe.

## Three structural mechanisms

1. **Structural authorization over approval workflows**: define allowed scope in advance; infrastructure checks it per action, not per human decision.
2. **Anomaly detection over vigilant monitoring**: flag statistical deviations; let humans investigate exceptions rather than watch the stream.
3. **Automatic containment over manual intervention**: halt actions that exceed boundaries before human reaction time matters.

Infrastructure does not get tired. [[complacency-trap]] cannot affect it. [[controllability-trap]] failures — correction absorption, belief resistance, cascade severance — are all addressed at the architectural level, not through attentiveness.

## Connects to

- [[complacency-trap]] — the human-side failure that makes HITL and HOTL unreliable over time
- [[controllability-trap]] — the agent-side failure mechanisms that infrastructure-level responses address
- [[autonomy-levels]] — A4-A5 require I4-I5 infrastructure; the autonomy ceiling is an infrastructure gate
- [[agentic-ux-patterns]] — UX patterns operationalize infrastructure-in-the-loop for humans; scope indicators make enforcement boundaries visible
- [[permission-intersection]] — audience-side authorization is an infrastructure-in-the-loop problem, not a vigilance problem
- [[blast-radius]] — containment infrastructure limits blast radius regardless of what the agent attempts
- [[self-aware-agent]] — agent-initiated oversight complements infrastructure enforcement; together they form a dual redundancy

## Sources

- [Deconinck-2026]: Shane Deconinck, PAC Framework, trustedagentic.ai/framework, 2026. "Don't" vs "can't" framing.
- [Anthropic-coding-2026]: Anthropic, "2026 Agentic Coding Trends Report," March 2026. AI-automated review scaling.
- [Bainbridge-1983]: Lisanne Bainbridge, "Ironies of Automation," Automatica, 1983. Cited in [[ironies-of-automation]] and [Human-Agent Collaboration Patterns](../chapters/human-agent-collaboration.md).
