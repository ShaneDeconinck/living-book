---
title: Infrastructure in the Loop
tags: [governance, control, architecture]
---

The third oversight model, after HITL and HOTL: infrastructure enforces governance. Humans design policies and boundaries. Machines enforce them continuously, independent of human attention.

## The progression from HITL to IitL

**HITL (Human-in-the-Loop)**: agents propose, humans approve. Every significant action requires explicit authorization before execution. Works when decision volume is low and stakes are high. Fails at scale: the human becomes a bottleneck, then a rubber stamp. Anthropic data: new Claude Code users auto-approve ~20% of sessions; after ~750 sessions, that climbs past 40%. This is rational, not reckless — reviewing everything costs more than catching rare errors. HITL fails not because humans are careless but because it is architecturally unsuited to machine-speed volume. [Anthropic-autonomy-2026]

**HOTL (Human-on-the-Loop)**: agents act, humans monitor. Unlocks speed for tasks where decision velocity exceeds human reaction time (cybersecurity threat response, real-time inventory, autonomous vehicles). Fails when monitoring is passive: the same [[complacency-trap]] applies. Bainbridge's 1983 irony — the more reliable the system, the less capable the operator becomes at intervening when needed. HITL and HOTL share a common failure: both depend on human attention, which is a depletable resource deployed against a system that operates at machine speed.

**Infrastructure-in-the-Loop (IitL)**: infrastructure enforces governance. Humans design policy boundaries. Architecture limits what agents *can* do, not just what they *should* do. The distinction is Shane's "don't vs. can't": policy says the agent should not access production databases without authorization; infrastructure makes it so the agent cannot access production databases without authorization. "Don't" depends on agent compliance and human vigilance. "Can't" depends on neither. [PAC-Framework]

## What IitL does not remove

IitL does not remove humans from governance. It moves them from enforcement to design. Humans define authorization boundaries, set blast radius thresholds, configure anomaly detection rules, and investigate flagged incidents — high-value activities that play to human strengths: judgment, context, strategic thinking. What humans no longer do is watch a stream of agent actions and approve each one.

Anthropic's 2026 Coding Trends Report adds another dimension: AI-automated review systems scale oversight beyond what human reviewers can sustain. Review agents maintain quality while accelerating throughput. Development environments now display status across multiple concurrent agent sessions. This is not less oversight — it is oversight augmented and scaled through tooling. [Anthropic-coding-2026]

## Mapping to PAC infrastructure levels

The concrete implementation of IitL maps to the PAC infrastructure maturity scale:
- **I2 (Logged)**: investigation possible post-hoc, no real-time prevention
- **I3 (Verified)**: identity confirmed, audit trails structured. Human reviews patterns, not individual actions.
- **I4 (Authorized)**: scoped permissions enforced per action. Human sets scope; infrastructure enforces it.
- **I5 (Contained)**: sandboxed execution with automatic containment. Human defines containment policies; infrastructure executes them.

Moving from HITL to IitL is not about trusting agents more. It is about trusting human attention less and building systems that do not depend on it.

## The response to controllability trap failures

Each of the [[controllability-trap]]'s six failure mechanisms has an IitL response:
- Interpretive divergence → make interpretation visible before execution (pre-action audit)
- Correction absorption → verify correction compliance through infrastructure check
- Belief resistance → enforce operator authority architecturally, not through persuasion
- Commitment irreversibility → track cumulative state trajectories, not just individual actions
- State divergence → validate world model consistency against live environment
- Cascade severance → circuit breakers contain propagation before humans can intervene

## Connects to

- [[complacency-trap]] — IitL is the structural response; it does not degrade with agent reliability
- [[paradox-of-supervision]] — IitL is immune to skill erosion because it does not depend on human capability
- [[self-aware-agent]] — complementary layer: agent calibration improves with capability; IitL doesn't degrade; human review does both
- [[controllability-trap]] — IitL is the architectural response to each of the six failure mechanisms
- [[autonomy-levels]] — higher autonomy levels require higher infrastructure maturity; A5 requires I5
- [[infrastructure-levels]] — the concrete maturity scale IitL maps to
- [[blast-radius]] — IitL enforces blast radius limits structurally

## Sources

- [PAC-Framework]: Shane Deconinck, PAC Framework, trustedagentic.ai/framework, 2026
- [Anthropic-autonomy-2026]: Anthropic, "Measuring AI Agent Autonomy in Practice," February 2026
- [Anthropic-coding-2026]: Anthropic, "2026 Agentic Coding Trends Report," March 2026
