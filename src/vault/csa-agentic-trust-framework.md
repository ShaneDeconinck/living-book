---
title: CSA Agentic Trust Framework (ATF)
tags: [governance, zero-trust, standards, security]
---

An open governance specification published by the Cloud Security Alliance (CSA) in February 2026 that applies Zero Trust principles to AI agents. Published under Creative Commons; designed for implementation with existing open-source tools.

Core premise: "No AI agent should be trusted by default, regardless of purpose or claimed capability. Trust must be earned through demonstrated behavior and continuously verified through monitoring."

## Five elements

Each addresses a governance question:

1. **Identity** ("Who are you?"): authentication, authorization, and session management for agents. Connects to [[non-human-identity]] and [[dids]].

2. **Behavior** ("What are you doing?"): observability, anomaly detection, and intent analysis. Connects to [[observability-stack]] and [[fleet-behavioral-aggregation]].

3. **Data Governance** ("What are you consuming? What are you producing?"): input validation, PII protection, output governance. The consumption side connects to [[context-poisoning]]; the production side to [[semantic-gap]].

4. **Segmentation** ("Where can you go?"): access controls, resource boundaries, policy enforcement. The structural version of [[operational-envelopes]].

5. **Incident Response** ("What if you go rogue?"): circuit breakers, kill switches, containment mechanisms. Connects to [[agent-incident-response]] and [[coordinated-revocation]].

## Progressive autonomy model

Agents must pass five gates to advance to the next autonomy level:
1. Accuracy (performance benchmarks met)
2. Security audits (no open vulnerabilities)
3. Measurable impact (value demonstrated)
4. Clean operational history (no incidents in production)
5. Explicit stakeholder approval (governance sign-off)

This mirrors the [[infrastructure-in-the-loop]] principle: autonomy expands as trust is demonstrated, not as capability grows. The gates are governance checkpoints, not just technical ones.

## Standards alignment

ATF aligns with OWASP Top 10 for Agentic Applications and CoSAI recommendations. It is cross-referenced with NIST CSF 2.0 and ISO 42001 where applicable.

## Connects to

- [[autonomy-levels]] — ATF's progressive autonomy model maps to A1-A5 with governance gates between levels
- [[infrastructure-in-the-loop]] — "trust must be earned through demonstrated behavior" is the governance statement of IitL
- [[non-human-identity]] — Element 1 requires agent identity before trust can be evaluated
- [[observability-stack]] — Element 2 requires the full stack to detect behavioral anomalies
- [[operational-envelopes]] — Element 4 (Segmentation) formalizes envelopes as zero-trust boundaries
- [[coordinated-revocation]] — Element 5's kill switches require fleet-level revocation mechanisms
- [[regulatory-classification-gap]] — ATF's behavioral gates are a practical answer to the classification problem: classify by demonstrated behavior, not intended use

## Appears in

- **The Regulatory Landscape** (`chapters/regulatory-landscape.md`) — Standards Convergence section

## Sources

- Cloud Security Alliance, "The Agentic Trust Framework: Zero Trust Governance for AI Agents," February 2, 2026
- github.com/CSA-AI/ATF
