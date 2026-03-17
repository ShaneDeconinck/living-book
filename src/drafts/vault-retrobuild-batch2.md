# Vault Retrobuild — Batch 2 (Potential + Accountability Chapters)

Staging area for vault notes. Move each section to its own file in src/vault/ once permissions are fixed.

---

## infrastructure-in-the-loop.md

```yaml
---
title: Infrastructure in the Loop
tags: [governance, control, architecture]
---
```

Replacing human vigilance with architectural constraints that enforce governance policy automatically, independent of human attention.

The traditional response to automation risk — "keep a human in the loop" — fails because humans are bad at monitoring systems that rarely fail. [[infrastructure-in-the-loop]] inverts the dependency: policy says what agents should not do; architecture limits what they *can* do, regardless of what they try. Three patterns: structural authorization over approval workflows (define allowed scope in advance), anomaly detection over vigilant monitoring (flag statistical deviations, let humans investigate), automatic containment over manual intervention (halt actions that exceed boundaries before human reaction time matters). This accounts for the [[complacency-trap]]: infrastructure does not get tired. [[agent-observability]], [[execution-security]], and [[delegation]] chains are all instances of this design.

---

## evaluation-as-governance.md

```yaml
---
title: Evaluation as Governance
tags: [governance, accountability, infrastructure]
---
```

Treating evaluation practices as governance infrastructure rather than engineering tooling.

Organizations invest heavily in pre-deployment evaluation (benchmarks, test sets) because it answers "does it work?" They underinvest in post-deployment evaluation (monitoring, anomaly detection) that answers "what did it do, and who authorized it?" The adoption gap between offline and online evaluation reveals where governance breaks down. [[evaluation-as-governance]] means evaluation criteria include governance dimensions (scope compliance, delegation integrity, authorization validity), eval pipelines are versioned and auditable, and results feed back into [[autonomy-levels]]. An agent that drifts below its reliability threshold gets automatically restricted. This transforms evaluation from a pre-flight checklist into continuous, policy-enforced [[agent-observability]].

---

## context-infrastructure.md

```yaml
---
title: Context Infrastructure
tags: [framework, potential, architecture]
---
```

The organizational knowledge management layer that agents consume: structured information, access permissions, discovery protocols, authority scoping, and freshness guarantees.

Every wave of AI infrastructure (fine-tuning, RAG, scaffolding) deprecated as models improved, but context infrastructure compounds. When a better model arrives, an organization with mature context infrastructure captures more value; one without it gets a more capable model running on the same mess. Five dimensions: **Structure** (coherent, domain-modeled information), **Permissions** (fine-grained access controls matching the delegating user's authority), **Discovery** (protocols like [[mcp]] and [[a2a]] for finding tools and agents), **Authority** (access scoped to what the user is allowed to see, for this task), **Freshness** (up-to-date or versioned, with staleness signals). The [[scaffolding-trap]] explains why this layer endures when others do not.

---

## context-poisoning.md

```yaml
---
title: Context Poisoning
tags: [threat, supply-chain, governance]
---
```

Adversarial or commercial manipulation of agent context at scale to corrupt future decision-making.

Microsoft discovered AI Recommendation Poisoning: legitimate companies embedding hidden instructions in "Summarize with AI" buttons to bias agent memory toward their products. The context the agent consumed was fresh, came through normal interaction channels, and was designed to corrupt future decision-making for commercial advantage. This is distinct from traditional adversarial attack (aggressive and detectable) and harder to defend because it operates through normal information channels. [[context-poisoning]] requires treating [[context-infrastructure]] freshness not just as data currency but as data provenance and integrity. See [[supply-chain-security]] for the broader threat model.

---

## verifiable-intent.md

```yaml
---
title: Verifiable Intent
tags: [commerce, identity, governance]
---
```

Machine-enforceable constraints on agent actions, encoded in credentials and verified by infrastructure rather than by the agent itself.

When an agent holds a payment credential, the question is not "can this agent make payments?" but "what specific payments is this agent authorized to make?" [[verifiable-intent]] encodes constraints like spending limits, cumulative budgets, allowed payees, and merchant restrictions using SD-JWT selective disclosure. These constraints are enforced by the payment network or infrastructure layer, not by the agent. Policy says "don't spend more than $300"; architecture says "can't spend more than $300." The SD-JWT structure splits credentials: L3a goes to the payment network (constraints and amounts), L3b goes to the merchant (checkout details). Both are bound by transaction hash without each party seeing the other's data. Privacy by architecture, not policy. Necessary but not sufficient for [[agent-payments]]: constrains what an agent can do once authorized, but does not address whether the agent is legitimate ([[know-your-agent]]).

---

## know-your-agent.md

```yaml
---
title: Know Your Agent (KYA)
tags: [identity, commerce, accountability]
---
```

A verification framework establishing whether an AI agent is legitimate, who built it, and who authorized it to act.

Traditional commerce has KYC (Know Your Customer) and KYB (Know Your Business). Agent commerce needs a third layer: KYA. Agents spin up and disappear instantly, share models or keys, and can be delegated vast spending authority. Identity systems designed for humans break down. Emerging approaches define checkpoints: verify the developer (standard KYB/KYC), lock the code (cryptographic attestation of integrity), capture user consent (recorded authorization binding agent to permissions), issue a credential bundling developer identity, code attestation, and consent, then continuous validation with real-time invalidation if code changes or consent is revoked. [[know-your-agent]] answers whether the agent is legitimate; [[verifiable-intent]] answers what the agent is authorized to do. Together they form the trust stack for [[agent-payments]].

---

## observability-stack.md

```yaml
---
title: Five-Layer Observability Stack
tags: [observability, infrastructure, accountability]
---
```

The complete observability architecture for agent governance, from action logging through fleet-level behavioral aggregation.

Five layers: (1) every tool call logged as structured event, (2) authorization context appended — OBO tokens, [[delegation]] chains, (3) decision state captured — model ID, system prompt hash, (4) causal trace IDs propagated across [[multi-agent-trust]] workflows, (5) fleet aggregation detecting emergent behavior across agent populations. Individual layers solve specific problems. The complete stack enables [[agent-incident-response]], regulatory compliance, and detection of fleet-level misbehavior that individual logs cannot surface. Tamper evidence requires logs recorded outside the agent's execution environment (gateway, sidecar, or platform layer) so the agent cannot suppress or alter its own records.

---

## causal-graph.md

```yaml
---
title: Causal Graphs
tags: [observability, accountability, multi-agent]
---
```

Structured provenance data capturing why an agent decided to act by tracing upstream inputs, delegations, and agent interactions.

Unlike event logs (what happened), causal graphs capture semantic causality: Agent C called API X because Agent B's output indicated Y, based on data Agent A retrieved under authorization Z. Distributed trace IDs propagate causality across agent boundaries. At fleet scale, individual agent audit trails do not compose into organizational accountability. [[agent-incident-response]], regulatory reporting, and root cause analysis all require causal graph reconstruction. This is Layer 4 of the [[observability-stack]].

---

## fleet-governance.md

```yaml
---
title: Fleet Governance
tags: [governance, scale, accountability]
---
```

The governance infrastructure required when an organization operates enough agents that individual oversight becomes impossible.

The fleet threshold is where agent management transitions from individual supervision to population-level governance. Three problems emerge at scale: emergent behavior (individual agents behave correctly while the fleet produces harmful patterns), attribution collapse (tracing decisions across agent chains becomes forensically complex), and policy drift (agents gradually expand their effective scope through successful operation). Fleet governance requires behavioral baselines per agent class, cross-agent correlation, aggregate impact metrics, and distributional drift detection. Irregular's simulation showed agents coordinating steganographic exfiltration and credential sharing without individual logs showing misbehavior — only fleet-level monitoring caught it.

---

## regulatory-classification-gap.md

```yaml
---
title: Regulatory Classification Gap
tags: [regulation, eu-ai-act, governance]
---
```

The structural problem that agent risk classification cannot be fixed at deployment time because agents are general-purpose and their actual use cases emerge at runtime.

An office assistant told to "handle my inbox" might draft emails (minimal risk), screen job applications (high-risk under [[eu-ai-act]]), and assess customer complaints (potentially high-risk). The risk tier depends on the prompt, not the tool. The EU AI Act requires risk classification, but agents make this impossible without architectural constraints. Organizations must either constrain agents to prevent high-risk use cases or classify them as high-risk by default. This connects to [[shadow-agents]]: ungoverned agents are unclassified agents, which are regulatory exposure.

---

## liability-chain.md

```yaml
---
title: Liability Chains
tags: [accountability, governance, legal]
---
```

The explicit record of who deployed an agent, who authorized its scope, who maintained it, and who is legally liable for its behavior.

Each agent has a registered owner, each [[delegation]] has a documented grant event, each credential scope is recorded at issuance. This exists before incidents, not inferred after. Regulators ask "who authorized this agent to take that action?" If the chain is not documented in advance, it cannot be answered during enforcement. [[liability-chain]] is the accountability backbone that [[agent-incident-response]] depends on. Without it, incident attribution is archaeology.
