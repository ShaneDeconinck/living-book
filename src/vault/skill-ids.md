---
title: Skill IDs
tags: [integrity, supply-chain, content-addressable, control]
dimension: supply-chain
---

Content-addressable fingerprints for agent skills, introduced alongside [[aarts]] in AARTS v0.1 (Gen Digital, March 2026). A deterministic identifier derived from skill content: the same skill always produces the same ID; a modified skill produces a different ID.

## How it works

A Skill ID is computed from the content of a skill, not from its source location or version label. This means:

- An organization audits a skill, records its Skill ID
- Any subsequent deployment can verify the running version matches the audited version
- Verification is independent of where the skill was downloaded — the ID is in the content, not the registry

The pattern is identical to checking a package hash against a lock file, applied to agent skills.

## Why it matters

[[skill-supply-chain]] covers SBOMs (Software Bills of Materials): what an agent is made of, with provenance per component. Skill IDs operate at a finer grain: not just "this skill came from this package" but "this skill has this exact content."

This closes a gap SBOMs leave open: a package can be the right version and the wrong content if the registry was compromised between audit and deployment.

## Relation to Sigstore

[[sigstore-a2a]] provides complementary coverage:

- **Sigstore-a2a answers:** this skill was built from commit X in repository Y through pipeline Z (build provenance)
- **Skill ID answers:** this skill's content has not changed since I audited it (content integrity)

Used together: provenance tells you where it came from; the Skill ID tells you it has not been modified since.

## Practical use

Skill IDs can be implemented today without waiting for AARTS adoption: compute the hash of any skill or plugin before deployment, record it, verify it at load time. No standards body required.

## Connections

- [[aarts]] — Skill IDs are introduced as part of the AARTS standard
- [[sigstore-a2a]] — complementary supply chain control (provenance vs. content integrity)
- [[skill-supply-chain]] — broader agent supply chain context
- [[description-pinning]] — another content-integrity pattern, for MCP tool descriptions
- [[control-pillar]] — structural enforcement of what skills are allowed to run
