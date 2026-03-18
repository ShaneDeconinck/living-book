---
title: MCP-I (Model Context Protocol — Identity)
tags: [protocol, identity, mcp, decentralized, cross-org-trust]
dimension: cross-org-trust
---

An identity and delegation extension for the Model Context Protocol using DIDs and Verifiable Credentials, donated by Vouched to the Decentralized Identity Foundation in March 2026.

## The Problem MCP-I Solves

[[mcp|MCP]] deliberately deferred identity. It handles discovery and tool invocation; it does not specify who the agent is, who authorized it, or what it is permitted to do. MCP-I adds that layer: before an MCP call proceeds, an agent presents cryptographic proof of its identity, its principal's identity, and the delegation scope. The verifier — typically an edge proxy — validates all three.

## Three-Dimensional Identity

At every service interaction, MCP-I requires three proofs:

1. **Agent identity**: the agent's own DID — who is acting
2. **User authorization**: a Verifiable Credential from the human principal linking the human to this specific request — who authorized the action
3. **Delegation scope**: a machine-readable policy credential specifying what the agent is permitted to do — not binary access, but structured constraint

The edge proxy validates all three before the MCP JSON-RPC call proceeds. If any dimension is absent or invalid, the call is rejected.

## Three Conformance Levels

MCP-I's tiered adoption model provides a migration path without requiring organizations to rebuild identity infrastructure before they can deploy:

**Level 1 (Foundational)**: existing identifiers (OIDC, JWT) are acceptable. Immediate implementation without DID infrastructure. Organizations can validate the protocol's value before investing in DID tooling.

**Level 2 (Standard)**: full DID verification, credential-based delegation, and revocation support. The protocol's full security value.

**Level 3 (Enterprise)**: enterprise-tier credential lifecycle management, immutable audit trails, bilateral MCP-I awareness. The governance layer above the protocol.

Organizations can start at Level 1 and progress as their deployments mature.

## MCP-I vs TMCP

Two complementary approaches to MCP trust:

- **TMCP** (MCP over [[trust-spanning-protocol|TSP]]): replaces the transport. TSP handles encrypted, authenticated channels; MCP runs on top. Handles the *how messages travel* problem.
- **MCP-I**: adds identity semantics at the protocol level. Defines *what the agent must prove before acting*.

They are not competing. TMCP provides the trusted channel; MCP-I provides the identity semantics. Together, they address the three MCP trust gaps: server identity, capability proof, and delegation chains.

## Governance Structure

MCP-I is developed under DIF's Trusted AI Agents Working Group (TAIAWG) through a dedicated MCP-I task force. The same TAIAWG governs the Delegated Authorization Task Force and threat modeling work launched earlier in 2026. This creates open-standards governance infrastructure for agent identity that MCP's own roadmap deferred to "on the horizon."

## Connects to

- [[mcp]] — MCP-I extends MCP with the identity layer MCP chose not to ship
- [[trust-spanning-protocol]] — TMCP wraps MCP in TSP; MCP-I adds identity semantics; the two compose
- [[dids]] — agent identity in MCP-I is anchored as a DID
- [[verifiable-credentials]] — delegation scope and user authorization are VCs
- [[authority-continuity]] — MCP-I's delegation credential implements PIC's requirement that authority be explicitly scoped
- [[delegation-chain]] — MCP-I's three-dimensional proof captures the delegation chain at each service interaction

## Sources

- Vouched, "Vouched Donates MCP-I Identity Framework to the Decentralized Identity Foundation," businesswire.com, March 6, 2026
- Vouched / DIF, "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation, March 2026
- DIF Newsletter #58, blog.identity.foundation, February 16, 2026 (TAIAWG: Delegated Authorization Task Force, threat modeling, MCP-I introduced as candidate work item)
- src/chapters/cross-org-trust.md §MCP-I: Protocol-Level Identity for MCP
- src/chapters/gaps.md §MCP-I: The Protocol Identity Gap Is Closing, Outside the Protocol
