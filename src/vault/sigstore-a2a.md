---
title: Sigstore-a2a
tags: [supply-chain, provenance, signing, transparency]
---

An extension of the Sigstore keyless signing framework applied to AI agents and agent-to-agent (A2A) interactions. Provides build provenance attestation for agent skills and components through the Rekor transparency log.

## How it works

Sigstore's core mechanism: keyless signing via Fulcio (a certificate authority that issues short-lived certificates tied to OIDC identity), with all signing events recorded in the Rekor transparency append-only log. No long-lived private keys to manage or leak.

Applied to agents (sigstore-a2a):

- Agent skills are signed at build time, with the signing event recorded in Rekor
- SLSA provenance attestations link the skill artifact back to its source repository and build pipeline
- Any downstream consumer can verify: this skill came from commit X in repository Y, built through pipeline Z

## What it answers

Sigstore-a2a answers the provenance question: where did this skill come from, and through what pipeline?

This is distinct from [[skill-ids]], which answer the content integrity question: has this skill's content changed since I audited it?

Used together, they close the supply chain trust gap end-to-end: provenance at build time + content integrity at deployment.

## Relation to broader supply chain security

[[skill-supply-chain]] covers the agent supply chain threat model (typosquatting, compromised packages, rug pulls). Sigstore-a2a is one of the signing infrastructure options for establishing provenance claims that a [[skill-ids]] check or SBOM can reference.

The Rekor transparency log provides a property analogous to [[tamper-evident-logging]] for skill provenance: once recorded, build events cannot be silently removed or altered.

## Connections

- [[skill-ids]] — content integrity complement to provenance
- [[skill-supply-chain]] — the threat model this addresses
- [[aarts]] — PreSkillLoad hook can check provenance via sigstore-a2a before loading
- [[tamper-evident-logging]] — analogous transparency property for audit logs
- [[control-pillar]] — provenance attestation as a structural control on what agents run
