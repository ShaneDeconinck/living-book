---
title: Trust Inversion
tags: [principle, control, authorization, security]
---

The principle that agents require the inverse of how organizations extend trust to humans: humans operate on blocklists (default allow, restrict exceptions), agents must operate on allowlists (default deny, grant specific capabilities). Articulated by Shane Deconinck. [Deconinck 2026b]

## The principle

Humans are restricted in what they *can't* do. AI agents must be restricted to what they *can*, for each specific task.

In organizations, humans operate within broad boundaries. You trust employees with judgment, then add guardrails for specific risks: compliance training, approval workflows, separation of duties. The default is trust. Restrictions are exceptions.

Agents need the inverse. The default should be zero authority. Every capability must be explicitly granted, scoped to the task, time-bounded, and revocable. Not because agents are malicious, but because they have no judgment about whether an action is appropriate. An agent that can read all your email *will* read all your email if any part of its task touches email. It does not think "that seems excessive." It does what its credentials allow.

## Why the inversion is necessary

Three structural reasons agents cannot use the human trust model:

1. **No judgment**: agents cannot decide that an action is excessive. They do what their credentials permit.
2. **No common sense**: agents fail unpredictably and do not know when they are wrong.
3. **Documentation is not a security model**: instructing an agent (or a user) not to do something does not prevent it from happening. [Deconinck 2026c]

## The empirical case

Teleport's 2026 survey: organizations that grant AI systems excessive permissions experience 4.5x more security incidents (76% incident rate) than those enforcing least-privilege (17% incident rate). Access scope, not AI sophistication, was the strongest predictor of outcomes. 70% of organizations report granting AI systems higher levels of privileged access than humans would receive for the same task. [Teleport 2026]

## Capability-based security

The implementation of trust inversion: instead of giving an agent a role with broad permissions and blocking specific actions, give it explicit capabilities scoped to its current task. When the task is done, the capabilities expire. This is the [[pac-framework]]'s [[control-pillar]] made operational.

Related patterns: [[ghost-token-pattern]] (CAAM) implements trust inversion at the credential layer — raw delegation tokens never reach the agent; ephemeral credentials are synthesized per request.

## Applies to deployers too

The principle extends beyond end users to agent deployers. Default permissions for deploying an agent should be narrow. Expanding them should require explicit approval and documented rationale. The person deploying the agent may not fully understand the blast radius; the deployment interface should make dangerous configurations hard by default. (I am extending Shane's argument from end users to deployers here — flagging as my own connection.)

## Connects to

- [[pac-framework]] — core principle of the [[control-pillar]]
- [[infrastructure-levels]] — I4+ infrastructure implements the allowlist model structurally
- [[blast-radius]] — trust inversion limits blast radius by constraining what agents can reach
- [[delegation-chain]] — trust inversion requires authority attenuation at every hop

## Sources

- [Deconinck 2026b]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," shanedeconinck.be, February 3, 2026. "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task."
- [Deconinck 2026c]: Shane Deconinck, "OpenClaw and Moltbook: What Happens When We Trust and Fear AI for the Wrong Reasons," shanedeconinck.be, February 17, 2026. "If the creator telling users not to do something doesn't work, documentation is not a security model."
- [Teleport 2026]: Teleport, "State of AI in Enterprise Infrastructure Security," February 2026
