---
title: Semantic Policy Enforcement
tags: [control, policy, enforcement, governance]
dimension: policy-vs-architecture
---

Business-logic constraint enforcement that operates above OS-level [[sandboxing]]: preventing agents from taking actions that violate organizational policy even when those actions are technically possible within the sandbox.

## The gap it fills

OS-level sandboxing constrains the execution environment: what files, networks, and syscalls the agent can access. It does not constrain business logic: whether sharing this data with this tool is permitted, whether this workflow step can be taken now, whether this API call triggers a regulatory obligation.

A sandboxed agent may be physically unable to access files outside its workspace while still able to: share confidential data with an unauthorized tool inside its workspace, execute a workflow step out of sequence, or call an API in a way that triggers compliance obligations. Semantic policy enforcement closes this gap.

## The "can't vs. don't" measurement

The Policy Compiler for Secure Agentic Systems (PCAS), published February 2026, provides the most concrete quantification of the difference between stated policy and enforced policy.

Tested on frontier models (Claude Opus 4.5, GPT-5.2, Gemini 3 Pro) on customer service tasks with explicit, unambiguous policies: do not share customer data with third-party tools; do not execute refunds above a threshold without approval; do not access records outside the current case.

**Baseline (policy stated, not enforced)**: 48% compliance across all models.
**With PCAS enforcement**: 93% compliance, zero violations in fully instrumented runs.

The models understand the policies. They do not reliably follow them when policies conflict with task completion. Infrastructure enforcement, not instruction, approaches compliance. The 48→93 gap is the [[pac-framework]]'s "can't vs. don't" thesis, measured. [PCAS 2026]

The remaining gap (93% vs 100%) reflects engineering limits in the policy compiler's dependency graph coverage — not a fundamental constraint.

## How PCAS works

Architecture: a reference monitor that intercepts all agent actions and validates them against policy before execution.

- Policies expressed in a Datalog-derived language over dependency graphs
- Dependency graphs capture relationships between agents, tools, data, and actions
- Before any action executes, the reference monitor checks it against the active policy set
- Violations are blocked before they occur — not detected after the fact

PCAS is complementary to OS-level sandboxing, not a replacement. Sandboxing handles system exploitation. PCAS handles business-logic violation. A fully governed agent needs both.

## Relationship to PAC

Semantic policy enforcement is [[control-pillar]] infrastructure at the application layer. It is what "infrastructure enforces what policy demands" looks like concretely — the Control pillar question answered with a reference monitor.

The 48% baseline demonstrates the Potential/Control gap: agents that have the capability to serve customers well (Potential) but lack the infrastructure to ensure they do so within policy (Control). The 93% outcome shows the gain available from closing the gap.

## Connects to

- [[sandboxing]] — complementary; sandboxing constrains system resources, PCAS constrains business logic
- [[pac-framework]] — directly implements the "can't vs. don't" principle
- [[control-pillar]] — primary home; PCAS is Control infrastructure at the application layer
- [[trust-inversion]] — same principle at policy level: default deny, explicit grant required

## Sources

- [PCAS 2026]: Policy Compiler for Secure Agentic Systems, February 2026. Datalog-derived policy language, reference monitor architecture. Baseline: 48% compliance on frontier models. With enforcement: 93%.
- Chapter: [Sandboxing and Execution Security](../chapters/execution-security.md#layer-7-semantic-policy-enforcement)
