---
title: Infrastructure in the Loop
tags: [governance, control, architecture]
---

Replacing human vigilance with architectural constraints that enforce governance policy automatically, independent of human attention.

The traditional response to automation risk — "keep a human in the loop" — fails because humans are bad at monitoring systems that rarely fail. [[infrastructure-in-the-loop]] inverts the dependency: policy says what agents should not do; architecture limits what they *can* do, regardless of what they try. Three patterns: structural authorization over approval workflows (define allowed scope in advance), anomaly detection over vigilant monitoring (flag statistical deviations, let humans investigate), automatic containment over manual intervention (halt actions that exceed boundaries before human reaction time matters). This accounts for the [[complacency-trap]]: infrastructure does not get tired. [[agent-observability]], [[execution-security]], and [[delegation]] chains are all instances of this design.
