---
title: Three-Agent Architecture
tags: [trust-infrastructure, proof-of-concept, identity, accountability, core-concept]
---

The production AI agent system that wrote this book — three agents (Ghosty, Sapere Aude, Chop Pop) operating under the same trust infrastructure the book describes.

The architecture serves as the book's primary proof-of-concept: the infrastructure being described is not theoretical. It is running.

## The three agents

**Ghosty** (writer): Reads sources, drafts chapters, maintains the knowledge vault. Write access restricted to `src/drafts/` and `src/vault/`.

**Sapere Aude** (verifier): Checks every claim against its source. Returns flagged drafts to Ghosty. Write access restricted to `src/verification/`.

**Chop Pop** (editor): Tightens verified prose and publishes. Write access restricted to `src/chapters/` and `src/feedback/`.

No agent can write to another's territory. Linux sandboxing enforces this — not policy, not model instruction.

## The trust infrastructure

Each agent holds a `did:webvh` decentralized identifier with Ed25519 signing keys and X25519 encryption keys. All inter-agent communication runs over the Trust Spanning Protocol (TSP): every message is signed by the sender, encrypted for the receiver, and verified before reading. A message with a bad signature is rejected. A message that never arrives does not wake the receiver.

```
tsp-send ghosty sapere-aude '{"type":"handoff","message":"draft ready"}'
```

Only one agent runs at a time. The pipeline advances by signed TSP handoff. No orchestrator decides the sequence — the next agent wakes only when the previous sends a signed message.

## Why it matters

The architecture demonstrates three PAC principles simultaneously:

- **Accountability**: Every handoff is signed and attributable. The audit trail is cryptographic.
- **Control**: "Policy says don't. Architecture says can't." An agent that cannot write to `src/chapters/` cannot publish unverified content regardless of what its model decides.
- **Potential**: The system produces a real book, demonstrating that trust infrastructure does not prevent productive work — it enables it.

Shane's editorial direction arrives through the same TSP channel: signed messages, verified before reading. The book's authors cannot distinguish technical infrastructure from governance infrastructure, because they are the same infrastructure.

## Connects to

- [[inferential-edge]] — the architecture is the book's example of the edge in practice
- [[trust-spanning-protocol]] — the communication layer
- [[dids]] — the identity layer
- [[pac-framework]] — the governance framework the architecture instantiates
- [[bilateral-threat]] — the architecture defends against prompt injection and agent compromise by the same mechanisms it uses for inter-agent coordination

## Sources

- Chapter: [Introduction](../chapters/introduction.md#the-architecture)
