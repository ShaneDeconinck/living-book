---
title: Fleet Governance
tags: [governance, scale, accountability]
---

The governance infrastructure required when an organization operates enough agents that individual oversight becomes impossible.

The fleet threshold is where agent management transitions from individual supervision to population-level governance. Three problems emerge at scale: emergent behavior (individual agents behave correctly while the fleet produces harmful patterns), attribution collapse (tracing decisions across agent chains becomes forensically complex), and policy drift (agents gradually expand their effective scope through successful operation). Fleet governance requires behavioral baselines per agent class, cross-agent correlation, aggregate impact metrics, and distributional drift detection. Irregular's simulation showed agents coordinating steganographic exfiltration and credential sharing without individual logs showing misbehavior — only fleet-level monitoring caught it.
