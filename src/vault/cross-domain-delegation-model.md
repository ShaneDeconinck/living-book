---
title: Cross-Domain Delegation Model (Windley)
tags: [delegation, cross-org-trust, governance, reputation]
dimension: cross-org-trust
---

Phil Windley's model for cross-domain delegation treats the problem as institutional design, not just a protocol engineering problem. Four complementary mechanisms: policies, promises, credentials, and reputation.

## The Four Mechanisms

**Policies** establish deterministic boundaries within each agent's domain. They function as technical guardrails that prevent violations regardless of the agent's intentions or reasoning. Policies constrain capability — what an agent is able to do — enforced locally. They are not advisory.

**Promises** communicate behavioral commitments across boundaries. An agent making a promise articulates how it will constrain the delegated authority it receives: maintaining spending limits, restricting resource access, operating within defined parameters. Promises are declarations of intent, not enforcement mechanisms. Their credibility depends on whether they are grounded in the agent's actual policies. A promise about behavior that the agent's own policies do not enforce is an ungrounded promise.

**Credentials** carry delegated authority and provide portable evidence of that delegation. They serve two roles simultaneously: contextual inputs to policy engines (the policy evaluates the credential to determine what is permitted) and portable proof of authorization across boundaries (the credential is self-contained, verifiable without contacting the issuer). [[verifiable-credentials|VCs]] are the primary implementation.

**Reputation** provides distributed social memory. Each agent maintains independent records of past interactions with other agents. Two agents may reach different conclusions about the same participant depending on their experiences. Trust emerges from accumulated local observations, not from a central authority assigning scores. This is explicitly not a centralized trust registry.

## The Interaction Sequence

Cross-domain delegation follows a six-step pattern:

1. Receiving agent declares behavioral intentions (promise)
2. Delegating agent evaluates promises against social memory (reputation)
3. Delegating agent issues a credential encoding the delegated capability and constraints
4. Receiving agent acts using the credential
5. Delegating agent observes outcomes through signals or cryptographic receipts
6. Delegating agent updates reputation records

## Why All Four Must Compose

Windley's formulation: "Policies without promises cannot coordinate behavior across systems. Promises without enforcement are merely declarations of intent. Reputation without boundaries turns governance into little more than hindsight."

Each mechanism fails alone. Policies without promises cannot cross boundaries — they only govern within the agent's domain. Promises without policies are unverifiable commitments — the delegating party cannot confirm the receiving agent has the policy infrastructure to keep them. Credentials without reputation enable first-interaction abuse — a new agent with no track record can carry credentials from an untrustworthy principal. Reputation without policies is reactive — you can update your social memory after an incident but cannot prevent it.

The combination creates the preconditions for cross-domain coordination without centralized enforcement.

## What This Cannot Solve

The model assumes behavioral commitments in promises are verifiable against actual policies. An agent that misrepresents its policies corrupts the promise layer. The model has no mechanism for verifying that a promise accurately describes the receiving agent's actual policy infrastructure before the credential is issued.

This is the bootstrapping problem of distributed trust: the first interaction with a previously unknown agent must rely on promises alone, before any reputation has accumulated. Credential chains (who issued the credential, their reputation) provide partial mitigation, but not elimination.

## Relationship to PIC and TSP

[[authority-continuity|PIC]] provides the structural enforcement that the credential mechanism in this model relies on: credentials can only attenuate authority, never expand it. [[trust-spanning-protocol|TSP]] provides the authenticated channel through which promises and credentials travel. Windley's model is the institutional layer above the cryptographic layer.

## Connects to

- [[verifiable-credentials]] — credentials are the cross-boundary trust carrier in this model
- [[authority-continuity]] — PIC provides the structural enforcement that credential-based delegation requires
- [[trust-spanning-protocol]] — TSP provides the channel; this model describes the institutional protocol
- [[delegation-chain]] — delegation chains are the cryptographic implementation of the promise-credential-reputation cycle
- [[eudi-wallet-agents]] — EUDI business wallets are the issuer infrastructure that makes credential-based cross-domain delegation tractable at continental scale

## Sources

- Phil Windley, "Cross-Domain Delegation in a Society of Agents," Technometria, 2026
- src/chapters/cross-org-trust.md §A Society of Agents
