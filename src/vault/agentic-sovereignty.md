---
title: Agentic Sovereignty
tags: [governance, accountability, autonomy, defi, tee]
---

Agents designed so that no single party can inspect, modify, or stop their execution — not as a failure mode, but as the point.

Three forms: **technical sovereignty** (TEE enclaves make execution opaque to even the host), **operational sovereignty** (DeFi protocols are trustworthy precisely because no administrator can modify them mid-execution), **protocol sovereignty** (smart contracts persist as long as the underlying network runs, regardless of what any party does). Hu and Rong's framework positions non-overrideability as a condition the execution environment provides, not a feature the agent carries.

Sovereign agents sever the [[pac-framework]]'s accountability chain by design: no authoritative principal (the "responsible party" is a governance process, not a person), no revocation path (TEE agents can lack kill switches; on-chain agents have none by definition), no audit trail the principal controls. This is not weaker accountability — it is *earlier* accountability. The code is the commitment. Formal verification, third-party audit, and governance votes are the accountability mechanisms, all before deployment.

[[pre-execution-accountability]] replaces concurrent oversight. [[tee-attestation]] provides execution-time evidence. Protocol governance (parameter adjustments, upgrade proposals, deprecation votes) is the ongoing accountability layer. Liability through deployment persists: the EU AI Act's high-risk obligations apply to deployers regardless of post-deployment modifiability.

## Connects to

- [[pac-framework]] — sovereign agents reconfigure PAC rather than sitting outside it
- [[pre-execution-accountability]] — the relocated accountability model
- [[tee-attestation]] — cryptographic proof of what code ran
- [[autonomy-levels]] — A5 agents approach sovereignty; the distinction is whether override is possible
- [[infrastructure-levels]] — I4-I5 infrastructure adapts to sovereign execution patterns
- [[trust-inversion]] — sovereignty is trust inversion taken to its structural limit

## Sources

- [Hu & Rong 2026]: "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI," arXiv:2602.14951, FAccT 2026
