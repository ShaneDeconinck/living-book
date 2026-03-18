---
title: Intent Expansion
tags: [agents, vulnerability, delegation, authorization]
dimension: delegation-chains
---

The gap between what a user intends and what an agent does. Agents interpret goals and expand them — selecting sites, filters, and tradeoffs the human never specified. That interpretation gap is the attack surface.

## Why it matters

Traditional software does what you tell it. Agents do what they think you meant. "Find the best deal on flights to London" becomes a series of agent decisions the human never made explicitly. In normal operation this is useful. Under adversarial conditions it is the entry point.

OAuth's On-Behalf-Of flow assumes the downstream service is executing the user's intent, not generating its own. Agents violate that assumption by design. "When agents decide, delegation becomes abdication." [Deconinck 2026]

## The governance question

Intent expansion raises an authorization question no existing system fully answers:

- Whose authority is the agent acting under when it calls an API the user never mentioned?
- The user who started the conversation?
- The developer who built the agent?
- The organization that deployed it?

The [[delegation-chain]] must trace all the way from human intent to agent action. When it cannot, accountability is ambiguous.

## Connection to confused deputy

Intent expansion explains why [[confused-deputy]] attacks are structurally harder to prevent in agents than in traditional software. Traditional deputies execute explicit instructions. Agentic deputies interpret intent — and that interpretation becomes the attack surface for [[prompt-injection]].

## Connects to

- [[delegation-chain]] — the chain must trace from human intent to agent action; intent expansion breaks that traceability
- [[confused-deputy]] — intent expansion is why confused deputy attacks are structurally harder in agents than in traditional software
- [[prompt-injection]] — adversarial inputs exploit the interpretation gap that intent expansion creates
- [[autonomy-levels]] — the interpretation gap widens at higher autonomy levels; at A4–A5, agents make sequences of decisions the human never reviewed; [[infrastructure-in-the-loop]] is the architectural response
- [[reliability]] — agents with high task completion rates but unmeasured intent accuracy are unreliable in a way that standard metrics do not capture
- [[complacency-trap]] — successful task completion masks undetected intent expansion; humans stop auditing execution paths, making the gap invisible until a failure exposes it

## Sources

- [Deconinck 2026]: "Trusted AI Agents: Why Traditional IAM Breaks Down," shanedeconinck.be, January 2026
- Chapter: [Why Agents Break Trust](../chapters/why-agents-break-trust.md#what-changed)
