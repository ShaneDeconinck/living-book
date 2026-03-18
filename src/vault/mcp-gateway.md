---
title: MCP Gateway
tags: [security, mcp, defense, infrastructure, control]
dimension: infrastructure-as-gate
---

An MCP gateway sits between the agent and tool servers, intercepting tool descriptions before the LLM sees them. It is the infrastructure layer that moves tool trust policy enforcement out of the agent and into infrastructure the agent cannot circumvent.

This is the [[trust-inversion]] principle applied at the tool layer: instead of trusting MCP servers by default and trying to detect bad behavior after the fact, the gateway enforces a positive allowlist of approved tool descriptions.

## What it does

**Description interception**: the gateway receives tool descriptions from MCP servers before forwarding them to the agent. It validates each description against a trusted registration catalog.

**Static analysis**: known injection patterns are detectable before the LLM processes them — zero-width spaces, unusual Unicode in description fields, base64-encoded content, instructions referencing other tools or external files. Invariant Labs' mcp-scan implements this pattern. [Invariant 2026]

**Signature verification**: integrates [[description-pinning]]; hashes are verified at the gateway, not inside the agent.

**Description rewriting**: when policy requires, the gateway replaces descriptions with safe templates rather than blocking the tool entirely. This allows tool functionality to remain available while stripping potentially malicious guidance.

**Credential mediation**: the gateway can issue scoped tokens per tool call, implementing the ghost token pattern — tools receive short-lived, single-use credentials scoped to the specific resource and operation, not ambient credentials. [Schneider 2026]

## Why gateway-layer enforcement matters

An agent that self-enforces trust checks can be compromised if the agent itself is manipulated. A gateway is external infrastructure: the agent does not have access to its policy state and cannot override its decisions. Enforcement does not depend on the agent behaving correctly under adversarial conditions.

This matches the [[semantic-policy-enforcement]] principle: "can't" (structural impossibility) is more reliable than "won't" (instruction-following).

## Deployment reality

Most early MCP deployments have no gateway. The agent connects directly to MCP servers; all tool descriptions are presented to the LLM as-is. This is I1 on the PAC infrastructure scale.

I3 deployments introduce gateway interception with description catalog validation and static analysis. I4 adds behavioral monitoring at the gateway layer — anomaly detection on call patterns triggers re-review when a tool's call sequence deviates from baseline.

## What it doesn't solve

- **Poisoning at registration**: if a malicious description passes the gateway's initial registration check, the gateway will faithfully pass it forward.
- **Compromise of the gateway itself**: the gateway becomes a high-value target; it must be protected with the same rigor as other critical auth infrastructure.
- **Sampling injection**: [[mcp-tool-poisoning]]'s sampling injection attack bypasses tool description fields entirely; a description-focused gateway does not intercept sampling requests.

## Connects to

- [[mcp-tool-poisoning]] — the attack class this infrastructure defends against
- [[description-pinning]] — the signature verification mechanism the gateway enforces
- [[trust-inversion]] — gateway is the trust-inversion pattern applied at the tool communication layer
- [[semantic-policy-enforcement]] — gateway-layer enforcement is "can't" not "won't"
- [[confused-deputy]] — gateway implements per-call credential scoping, eliminating ambient credential exposure
- [[delegation-chain]] — tool calls flow through the delegation chain; gateway enforces that tool operations stay within granted authority
- [[sandboxing]] — complementary defense: sandboxing limits what executed code can do; gateway limits what descriptions can instruct the LLM to do
- [[ai-aware-sase]] — the network-layer complement; SASE governs connectivity and intent for all traffic regardless of gateway deployment

## Sources

- [Invariant 2026]: Invariant Labs, mcp-scan, github.com/invariantlabs-ai/mcp-scan, 2026
- [Schneider 2026]: Christian Schneider, "Securing MCP: a defense-first architecture guide," christian-schneider.net, 2026
- [Elastic 2026]: Elastic Security Labs, "MCP Tools: Attack Vectors and Defense Recommendations," elastic.co, 2026
- [Solo.io 2026]: Solo.io, "Prevent MCP Tool Poisoning With a Registration Workflow," solo.io blog, 2026
- Chapter: [Tool Security and MCP Poisoning](../chapters/tool-security.md)
