---
title: Policy Compiler for Secure Agentic Systems (PCAS)
tags: [security, control, policy-enforcement, research]
---

A reference monitor architecture that intercepts all agent actions and validates them against policy before execution. Published February 2026.

PCAS addresses the gap between OS-level [[sandboxing]] (constrains what files, network, syscalls the agent can access) and business-level governance (constrains what actions the agent is allowed to take given relationships between entities). Policies are expressed in a Datalog-derived language over dependency graphs capturing relationships between agents, tools, data, and actions.

The results quantify the "can't vs. don't" gap:

- **Without enforcement:** Frontier models (Claude Opus 4.5, GPT-5.2, Gemini 3 Pro) comply with stated policies only **48%** of the time on customer service tasks.
- **With PCAS active:** Compliance rises to **93%** across all tested models, with zero violations in fully instrumented runs.

The 48-to-93 gap is the core argument of the book, measured. Policy alone ("don't share customer data") fails more than half the time. Infrastructure enforcement ("the reference monitor blocks any action that would share customer data") approaches perfect compliance. The remaining gap (93% to 100%) comes from runs where the policy compiler's dependency graph did not fully cover the action space, an engineering problem, not a fundamental limitation.

PCAS is complementary to [[sandboxing]], not a replacement. Sandboxing constrains the execution environment. PCAS constrains the business logic. A fully governed agent needs both.

Connects to: [[semantic-policy-enforcement]], [[containment-by-design]], [[control-pillar]], [[operational-envelopes]]
