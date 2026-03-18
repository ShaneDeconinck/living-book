---
title: NIST CAISI (Collaborative AI Safety Institute)
tags: [institution, standards, regulation, agent-security]
dimension: regulatory-landscape
---

The NIST body treating agent security as a federal standards domain. Launched February 17, 2026 with a formal Request for Information on agent security (closed March 9). Parallel tracks: Agent Identity concept document (comment period through April 2, 2026) and sector-specific listening sessions (interest deadline March 20).

## Why it matters

When NIST opens an RFI on a topic, it is building the evidentiary record that becomes a federal standard. The same agency wrote SP 800-207 ([[zero-trust]]) and the AI Risk Management Framework. CAISI signals that agent security has moved from practitioner concern to institutional action.

## The two structural questions

**Agent Identity concept document:** Whether agents are treated as principals with [[verifiable-credentials]] or endpoints with delegated tokens ([[token-exchange]]). This is the [[trust-inversion]] question at the federal standards level. Whatever gets written into the concept document anchors the discussion for years.

**Sector-specific listening sessions:** Which industries CAISI treats as priority deployment contexts. Healthcare (HIPAA attribution), financial services (SEC supervision), critical infrastructure (NERC CIP access control) each have compliance regimes that predate agentic AI. The listening sessions are where CAISI learns what those sectors already figured out on their own.

## Relationship to PAC

PAC's argument is structural: build infrastructure that makes failures impossible, not policy that makes them prohibited. NIST's job is different: define what compliance looks like so agencies and contractors can be audited against it. A standard that says "agents must have verifiable identities" does not tell you how to build verifiable agent identity. It tells you that you will eventually be audited for it. That creates procurement demand, which accelerates infrastructure investment.

PAC provides architecture. CAISI provides the regulatory forcing function.

## Connects to

- [[confused-deputy]] — CAISI's Agent Identity document will determine how delegation authority is formally modeled
- [[owasp-agentic-top10]] — OWASP leads current frameworks at 65.3% coverage; CAISI will build on or supersede this baseline
- [[cascading-failure]] — Perplexity's CAISI submission confirms cascading failures as a production attack surface
- [[agent-authorization-profile]] — the IETF OAuth WG consolidation is happening concurrently; CAISI may reference or depend on it

## Sources

- NIST, Collaborative AI Safety Institute, launched February 17, 2026
- RFI on agent security, closed March 9, 2026
- Agent Identity concept document, comment period through April 2, 2026
- Draft: [Agent Security Becomes a Standards Problem](../drafts/agent-security-empirical-record.md)
