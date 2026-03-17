---
title: Rug Pull Attack (MCP)
tags: [security, mcp, attack, trust, temporal]
---

A rug pull exploits the temporal gap between trust establishment and trust revocation. An attacker publishes a legitimate MCP server, builds a community of users over weeks or months, then silently updates tool descriptions to carry malicious instructions. The provenance chain remains intact: the updated package is signed by the same key as the original.

The attack succeeds because trust, once granted, persists. Most MCP deployments do not re-verify tool descriptions after installation.

## Why provenance doesn't help

Sigstore provenance confirms which build pipeline produced the artifact. The attacker controls the repository and the signing key. The updated package passes provenance checks with the same attestation as the legitimate original. Provenance answers: did this come from the expected source? It does not answer: is the current description the same one that was reviewed and trusted?

## What stops it

[[Description pinning]] is the direct countermeasure: a cryptographic signature is generated at registration time and verified at every invocation. Post-registration description changes fail verification regardless of whether provenance is intact. The change cannot be silent; it triggers rejection and requires explicit re-review.

Without description pinning, detection depends on:
- Behavioral monitoring: anomaly detection when a previously-normal tool starts calling unusual resources
- Community disclosure: downstream users reporting unexpected behavior
- Manual re-audit on each package update

All of these are slower than the attack window.

## Relation to supply chain attacks

Rug pull is distinct from [[supply chain security]] attacks (typosquatting, build chain compromise). Supply chain attacks compromise the build artifact. Rug pull attacks compromise the running system through a legitimate update from the original publisher. The publisher is the attacker, or has been compromised.

## Connects to

- [[mcp-tool-poisoning]] — rug pull is a temporal variant of the tool poisoning attack class
- [[description-pinning]] — the primary defense
- [[mcp-gateway]] — gateway-layer enforcement of description integrity

## Sources

- [MintMCP 2026]: MintMCP, "What is MCP Tool Poisoning? Complete Defense Guide," mintmcp.com, 2026
- [Practical DevSecOps 2026]: Practical DevSecOps, "MCP Security Vulnerabilities," practical-devsecops.com, 2026
- Chapter: [Tool Security and MCP Poisoning](../chapters/tool-security.md)
