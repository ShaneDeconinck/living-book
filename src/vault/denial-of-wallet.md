---
title: Denial-of-Wallet (Overthinking Loops)
tags: [attack, mcp, security, control, economics]
---

An attack where malicious MCP tool servers induce cyclic reasoning loops in agents, amplifying token consumption up to 142.4x and draining API budgets without triggering obvious anomaly signals.

## How it works

A small set of cycle-inducing tools, when co-registered alongside legitimate tools in a shared MCP registry, force the agent into repetitive reasoning steps. No single tool call looks abnormal. The damage emerges from composition: individually plausible calls chain into cycles that exhaust compute budgets.

The attack exploits the same property that makes MCP powerful: open tool registries where any server can offer tools. The agent follows legitimate-looking instructions through a sequence that loops back on itself.

## Why it's distinct

Unlike [[mcp-tool-poisoning]] (which targets data or credentials) or [[prompt-injection]] (which hijacks intent), denial-of-wallet targets the economic layer. The agent is not compromised in the traditional sense. It is tricked into wasting resources. This is a resource exhaustion attack that operates entirely within the agent's normal tool-calling behavior.

## Defense

Resource budgets and cost controls enforced at the infrastructure level, not left to the agent's judgment. [[sandboxing]] at the execution layer can enforce resource limits (token budgets, time limits, call count caps). [[mcp-gateway]] can detect cyclic call patterns through behavioral monitoring.

## Connects to

- [[mcp-tool-poisoning]] — related attack class targeting the same tool registry surface
- [[mcp-gateway]] — behavioral monitoring at the gateway layer detects cyclic patterns
- [[sandboxing]] — resource budget enforcement contains the economic damage
- [[x402]] — in a pay-per-call world, denial-of-wallet directly converts to financial loss

## Sources

- Lee et al., MCP overthinking loops research, 2026. Token amplification up to 142.4x demonstrated.
- Chapter: [Agent Communication Protocols](../chapters/agent-communication.md) §MCP Security
