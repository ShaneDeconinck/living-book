---
title: Trusted Execution Environment (TEE)
tags: [infrastructure, security, sovereignty, confidentiality]
dimension: infrastructure-as-gate
---

Hardware-enforced isolated execution environments where code runs in a protected enclave that even the host operating system and cloud provider cannot observe or modify. Implementations include Intel SGX and AWS Nitro Enclaves.

TEEs matter for agent trust in two directions. First, confidentiality: a hospital deploying a diagnostic agent in an SGX enclave guarantees that even the cloud provider cannot observe patient data. Second, accountability: TEE attestation generates cryptographic proof that specific code ran in a specific environment at a specific time. The agent cannot have run different code than what the attestation signed.

TEEs create a tension with the [[pac-framework]]. The non-modifiability that provides the privacy guarantee also makes the agent difficult to stop, patch, or audit from outside. There is no external kill switch. This breaks PAC's assumption that actions can be revoked and agents can be stopped. The EU AI Act's corrective action requirements assume a human can intervene, which TEE-based sovereign agents may prevent by design.

The accountability model shifts from post-hoc audit to pre-execution accountability: the code is the commitment. Formal verification, third-party audit, and governance votes over protocol parameters happen before deployment. After deployment, the code does what it was designed to do.

Used in: confidential AI inference (legal discovery, medical records, financial analysis), [[erc-8004]] validation registries (Phala, Near.AI), [[agentic-sovereignty]] as a form of technical sovereignty.

[Intel SGX Developer Guide] [AWS Nitro Enclaves documentation] [Hu & Rong "Sovereign Agents" arXiv:2602.14951, Feb 2026]
