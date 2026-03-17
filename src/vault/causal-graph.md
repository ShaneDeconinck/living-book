---
title: Causal Graphs
tags: [observability, accountability, multi-agent]
---

Structured provenance data capturing why an agent decided to act by tracing upstream inputs, delegations, and agent interactions.

Unlike event logs (what happened), causal graphs capture semantic causality: Agent C called API X because Agent B's output indicated Y, based on data Agent A retrieved under authorization Z. Distributed trace IDs propagate causality across agent boundaries. At fleet scale, individual agent audit trails do not compose into organizational accountability. [[agent-incident-response]], regulatory reporting, and root cause analysis all require causal graph reconstruction. This is Layer 4 of the [[observability-stack]].
