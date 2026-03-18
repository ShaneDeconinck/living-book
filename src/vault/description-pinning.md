---
title: Description Pinning
tags: [security, mcp, defense, integrity, tool-security]
dimension: supply-chain
---

At MCP tool registration, generate a cryptographic signature over each tool description. At every invocation, verify the signature before presenting the description to the LLM. If the description has changed since registration, reject the tool call and alert.

This is the primary defense against rug pull attacks. It does not prevent poisoning at initial registration — a malicious description submitted at registration will pass pinning checks. But it eliminates post-registration modifications: silent updates fail signature verification regardless of whether provenance is intact.

## How it works

1. **Registration**: gateway or client generates hash of the tool description at first install and stores it in a trusted catalog alongside the tool's metadata and signing key
2. **Session start**: client fetches current tool descriptions from MCP server; verifies each against stored hash
3. **Invocation**: gateway re-verifies description hash before forwarding the tool call; hash mismatch triggers rejection and alert, not silent acceptance
4. **Description change**: any update requires explicit re-registration, human review, and new signature — the update cannot be silent

Solo.io's registration workflow implements this at the MCP gateway layer. The portal generates a cryptographic signature for each tool and description at registration; the gateway compares signatures against the trusted catalog at runtime. [Solo.io 2026]

## What it protects against

- **Rug pull attacks**: post-installation description changes fail verification. The attacker's update, signed with their own key, does not match the registration-time signature.
- **In-transit modification**: a MITM that modifies descriptions between server and LLM is detected at verification.

## What it does not protect against

- **Poisoning at registration**: if the initial description is malicious, pinning preserves that malicious description faithfully.
- **Sampling injection**: the attack injects instructions into sampling requests, not description fields.
- **Behavioral deviation**: a description that passes static analysis may still instruct the LLM to call tools in unusual patterns.

These gaps are addressed by [[mcp-gateway]] (static analysis before LLM sees descriptions) and behavioral monitoring (anomaly detection on call patterns).

## Practical deployment

Two deployment points:
- **At the agent**: the agent runtime verifies description hashes before tool calls. Straightforward; does not require infrastructure changes. Gap: depends on the agent implementation honoring the check.
- **At the gateway** (preferred): an [[mcp-gateway]] performs verification as infrastructure, independent of the agent. The agent cannot bypass the check.

## Connects to

- [[mcp-tool-poisoning]] — the attack this defense addresses
- [[rug-pull-attack]] — the specific variant description pinning eliminates
- [[mcp-gateway]] — the infrastructure layer where pinning is most robustly enforced
- [[delegation-chain]] — pinning ensures the tool the LLM uses matches the tool that was authorized at registration

## Sources

- [Solo.io 2026]: Solo.io, "Prevent MCP Tool Poisoning With a Registration Workflow," solo.io blog, 2026
- [Schneider 2026]: Christian Schneider, "Securing MCP: a defense-first architecture guide," christian-schneider.net, 2026
- Chapter: [Tool Security and MCP Poisoning](../chapters/tool-security.md)
