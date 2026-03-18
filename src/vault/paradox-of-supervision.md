---
title: Paradox of Supervision
tags: [human-agent, governance, synthesis]
dimension: policy-vs-architecture
---

The governance risk where the skills required to review delegated work atrophy through overuse of delegation, making human oversight less rigorous even when technically present.

This extends the [[complacency-trap]]: it is not just that humans monitor less as agents succeed more, but that humans become less *capable* of meaningful monitoring. A manager who delegates all code review to an agent gradually loses the ability to evaluate code quality. The oversight checkbox is checked, but the oversight is hollow.

## Empirical evidence

Anthropic studied 132 engineers over nine months (200,000 Claude Code transcripts, February vs. August 2025). Productivity gains were measurable: task complexity rose from 3.2 to 3.8, human turns per session fell 33%, consecutive autonomous tool calls increased 116%.

The paradox emerged in qualitative interviews: engineers reported that as they delegated more coding, the skills required to review that code began to atrophy. The authors' framing: "effectively using Claude requires supervision, and supervising Claude requires the very coding skills that may atrophy from AI overuse." [Anthropic-work-2025]

The skills needed to exercise oversight are the same skills that delegation erodes.

## The double failure

[[Complacency-trap]]: humans are capable of evaluating but stop doing so (attention problem).
Paradox of supervision: humans watch, review, and approve, but the evaluation is less rigorous because the underlying expertise is degrading (capability problem).

Both lead to approval that means less. A 100% review rate with declining correction frequency may indicate either a better agent or a less capable reviewer. Organizations should monitor not just whether reviews happen, but whether they are substantive — tracking review quality metrics (time per review, corrections made, escalation rates) alongside completion rates.

## Response

Not preventing delegation but ensuring critical skills are exercised independently of agent output. And using [[infrastructure-in-the-loop]] for the mechanical aspects of oversight — structural enforcement doesn't degrade with use.

## Connects to

- [[complacency-trap]] — the attention-degradation companion failure
- [[ironies-of-automation]] — the foundational research; skill degradation is one of Bainbridge's two compounding failures
- [[infrastructure-in-the-loop]] — the structural response that doesn't degrade
- [[autonomy-levels]] — review quality should factor into dial settings
- [[self-aware-agent]] — agent calibration doesn't degrade with delegation; the asymmetry that makes it a necessary complement to human review

## Sources

- [Anthropic-work-2025]: Anthropic, "How AI Is Transforming Work at Anthropic," December 2025. 132 engineers, 53 interviews, 200,000 transcripts.
