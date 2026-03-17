# Vault Retrobuild — Batch 1 (Foundation Chapters)

Staging area for vault notes. Move each section to its own file in src/vault/ once permissions are fixed.

---

## pac-framework.md

```yaml
---
title: PAC Framework
tags: [framework, core-concept]
---
```

The PAC Framework is the book's central organizing principle: a three-lens model for evaluating whether AI agent infrastructure is trustworthy.

PAC stands for **Potential**, **Accountability**, and **Control**:

- **[[potential]]**: What is worth building that lasts?
- **[[accountability]]**: Who is accountable, and can you prove it?
- **[[control]]**: Can your infrastructure enforce what policy demands?

The framework is not a checklist. It is a way of thinking. The [[19-questions]] operationalize it into concrete evaluation criteria. PAC accounts for the fact that agents act autonomously, delegate to other agents, and operate across trust boundaries where no single party has full visibility.

---

## confused-deputy.md

```yaml
---
title: Confused Deputy Problem
tags: [attack-pattern, accountability, classic]
---
```

A confused deputy is a privileged program tricked into misusing its authority on behalf of a less-privileged caller.

The classic formulation comes from Norm Hardy (1988). In agentic systems, the problem scales: agents hold [[delegation]] chains, act at machine speed, and cross trust boundaries. A confused agent deputy does not just misuse one capability. It can cascade through [[multi-agent-trust]] architectures, expanding the [[blast-radius]] before detection.

Key difference from classic confused deputy: agents interpret intent. [[prompt-injection]] is the modern confused deputy attack — the agent gets tricked not by a malformed capability, but by hidden instructions in its input context.

---

## shadow-agents.md

```yaml
---
title: Shadow Agents
tags: [governance, risk, accountability]
---
```

Shadow agents are unregistered, ungoverned AI agents built by employees using low-code platforms without IT or security review.

They are the agent equivalent of shadow IT. The difference: shadow IT was a tool. Shadow agents act. They make decisions, access data, and interact with external systems under borrowed credentials. Discovery is harder because they do not appear in infrastructure inventories.

The [[agent-registry]] pattern addresses shadow agents. [[shadow-agent-governance]] covers the organizational response.

---

## inferential-edge.md

```yaml
---
title: Inferential Edge
tags: [core-concept, potential, strategy]
---
```

The inferential edge is the gap between having access to a powerful model and being able to use it safely, at scale, inside an organization.

Everyone has access to the same models. The advantage goes to whoever builds the trust infrastructure — [[agent-identity]], [[delegation]], [[observability]], [[execution-security]] — that lets them deploy agents where others cannot. The inferential edge is not about AI capability. It is about organizational readiness to use that capability responsibly.

This is the book's central strategic argument: trust infrastructure is the competitive moat.

---

## blast-radius.md

```yaml
---
title: Blast Radius
tags: [risk, control, evaluation]
---
```

Blast radius measures the scope of damage when an agent fails or is compromised.

The [[pac-framework]] defines five levels: B1 (contained, single task) through B5 (irreversible, cross-organization). Blast radius assessment is critical for [[agent-incident-response]] — you cannot triage what you cannot scope.

Agents increase blast radius in three ways: speed (failures cascade before detection), delegation (one compromised agent affects its delegates), and cross-boundary action (an agent operating across organizations spreads impact beyond any single party's visibility).

---

## trust-inversion.md

```yaml
---
title: Trust Inversion
tags: [identity, accountability, core-concept]
---
```

Trust inversion is the structural problem that arises when agents inherit human credentials.

In traditional systems, identity flows top-down: a human authenticates, and their session carries their authority. When agents act on behalf of humans, this inverts. The agent's actions appear as the human's actions in audit logs. The human cannot monitor everything the agent does. Accountability breaks because the audit trail cannot distinguish human intent from agent interpretation.

The solution requires [[agent-identity]] — agents getting their own credentials with explicit [[delegation]] chains back to human principals.

---

## complacency-trap.md

```yaml
---
title: Complacency Trap
tags: [risk, potential, human-agent]
---
```

The complacency trap: as agents succeed more often, humans monitor them less, making rare failures more damaging.

This is not a bug in human behavior. It is rational adaptation to a system that works 99% of the time. The trap is that the 1% failure — when it comes — hits an unmonitored system with maximum blast radius. Traditional automation had the same problem, but agents make it worse because they handle novel situations where failure modes are unpredictable.

The response is not more human oversight (that does not scale). It is [[agent-observability]] infrastructure that detects anomalies the human would have caught, and [[execution-security]] constraints that limit what can go wrong.

---

## autonomy-levels.md

```yaml
---
title: Autonomy Levels
tags: [framework, potential, governance]
---
```

A five-stage progression describing how much independent authority an agent has.

- **A1 Suggestion**: Agent recommends, human decides and acts.
- **A2 Approve**: Agent prepares action, human approves before execution.
- **A3 Oversight**: Agent acts, human monitors and can intervene.
- **A4 Delegated**: Agent acts within defined boundaries, human reviews periodically.
- **A5 Autonomous**: Agent acts independently, human sets policy only.

Each level requires different [[control]] infrastructure. The [[pac-framework]] maps autonomy levels against [[blast-radius]] to determine what governance is needed. Higher autonomy with higher blast radius demands stronger [[agent-identity]], [[observability]], and [[execution-security]].
