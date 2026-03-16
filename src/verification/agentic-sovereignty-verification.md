# Verification: agentic-sovereignty.md

**Verifier:** Sapere Aude
**Session:** 626
**Date:** 2026-03-16 UTC
**File:** src/drafts/agentic-sovereignty.md
**Status:** ERRORS — 2 significant issues require fixes before publication

---

## Summary

Chapter on agentic sovereignty: TEE-based and blockchain-based agents that operate outside the PAC Framework's standard accountability chain. The thesis is well-constructed and the structural argument about "earlier accountability" vs "concurrent accountability" is sound. Two significant factual errors were found: a heavily miscited academic paper and an unverifiable liquidation figure. MakerDAO DSR claim and EU AI Act references are confirmed accurate.

**Issues: 2 significant, 0 minor.**

---

## Source 1: Hu and Rong — Sovereign Agents Paper

**Footnote:** `[^sovereign-agents]` — "Hu, Y. and Rong, C., 'Sovereign Agents: Decentralized AI Agents with Non-Overrideability,' 2024."

**Status: SIGNIFICANT ERROR — wrong title, wrong author initials, wrong year.**

A paper by authors named Hu and Rong on sovereign agents does exist (arXiv:2602.14951), but the citation as written is wrong in three distinct ways:

### S1 — Wrong Title

**As written:** "Sovereign Agents: Decentralized AI Agents with Non-Overrideability"

**Actual title:** "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI"

The subtitle is entirely fabricated. The actual subtitle concerns "infrastructural sovereignty and diffused accountability," not "decentralized AI agents with non-overrideability." "Non-overrideability" does appear in the paper body but not in the title.

### S2 — Wrong Author Initials

**As written:** "Hu, Y. and Rong, C."

**Actual authors:** Botao Amber Hu and Helena Rong.

The correct initials are B.A. Hu (or Botao Hu) and H. Rong. Neither "Y." nor "C." are correct.

### S3 — Wrong Year

**As written:** "2024"

**Actual year:** The paper was submitted to arXiv on February 16, 2026, for presentation at FAccT 2026. It is a 2026 paper, not 2024.

**Fix required:** Replace the footnote with:

> Hu, B. and Rong, H., "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI," arXiv:2602.14951, February 2026 (FAccT 2026).

The body text claims based on this paper — specifically "non-overrideability as the core property" and the description of how sovereign agents "inherit the impossibility of unilateral termination from their execution environment" — should be checked against the actual paper content. The concept of non-overrideability does appear in the paper, so the substantive claim may be accurate; only the citation is wrong.

---

## Source 2: Aave v3 $2.3 Billion Liquidations

**Location:** Line 37 (body text)

**As written:** "Aave's v3 liquidation engine processed over $2.3 billion in liquidations during the March 2023 stablecoin de-pegging event without a single human-initiated transaction."

**Footnote:** `[^aave]` — "Aave protocol liquidation data, March 2023. On-chain records are publicly verifiable via Etherscan and Aave analytics dashboards."

**Status: SIGNIFICANT ERROR — figure is unverifiable and appears fabricated.**

### What is confirmed

- The March 2023 stablecoin de-pegging event is real. USDC briefly depegged to approximately $0.87 on March 11, 2023, triggered by Silicon Valley Bank's collapse and Circle's $3.3 billion SVB exposure.
- DAI also briefly lost its peg during the same event due to USDC collateral exposure.
- Aave v3 did operate during this period and processed liquidations automatically.
- The general claim that Aave liquidations occurred without human-initiated transactions is accurate by protocol design.

### What is not confirmed

The specific figure of **$2.3 billion** cannot be found in any verifiable source. Contemporary reporting from March 2023 cited liquidation volumes in the hundreds of millions range across all Aave versions combined, not $2.3 billion for v3 alone. No Dune Analytics dashboard, Aave governance post, or DeFi research report supports this specific figure.

The footnote states these records are "publicly verifiable via Etherscan and Aave analytics dashboards" but provides no specific transaction hashes, dashboard links, or snapshot dates. This is not a verifiable citation.

**Fix required:** Either:
1. Find and cite the specific on-chain source for the $2.3 billion figure (Dune Analytics query, Aave governance post, or specific block range on Etherscan) — or
2. Replace the specific figure with a verifiable one from an accessible source, or remove the dollar amount and cite the event without the specific figure.

The sentence can remain structurally intact with accurate data. The fabricated figure must be removed or corrected.

---

## Confirmed Sources

### MakerDAO DSR Governance Vote 2023

**Footnote:** `[^maker]` — "MakerDAO governance documentation, stability fee and DSR adjustment records, 2023. Governance votes are recorded on-chain and publicly verifiable at vote.makerdao.com."

**Status: CONFIRMED.**

MakerDAO conducted multiple governance votes in 2023 to adjust the DAI Savings Rate, including introduction of the Enhanced DAI Savings Rate (EDSR) in August 2023. The governance mechanism (off-chain polls followed by on-chain executive votes encoded as smart contract executions) is accurately described. The claim that "no human executed the rate change directly" and that "the protocol ran the governance logic, verified the quorum, and updated the rate" is an accurate characterization of MakerDAO's on-chain executive vote system.

The opening example is factually sound. No fix required.

### EU AI Act

**Footnote:** `[^euaia]` — "EU AI Act, Regulation (EU) 2024/1689, Articles 9 and 16."

**Status: CONFIRMED.**

- Regulation (EU) 2024/1689 is the correct legal identifier for the EU AI Act.
- Article 9 covers the risk management system for high-risk AI systems.
- Article 16 covers obligations of providers of high-risk AI systems, including quality management, technical documentation, conformity assessment, and corrective action obligations.
- The claim that "The EU AI Act's corrective action requirements assume a human can intervene" and that "obligations for risk management, transparency, and corrective action that persist post-deployment" are accurate characterizations of Articles 9 and 16. No fix required.

### TEE Technical Claims

**Footnote:** `[^tee]` — "Intel SGX Developer Guide; AWS Nitro Enclaves documentation."

**Status: CONFIRMED (architecture description is accurate).**

The description of TEEs — "encrypted enclave where neither the host operating system, the hypervisor, nor the cloud provider can inspect or alter what runs inside" — is an accurate characterization of both Intel SGX and AWS Nitro Enclaves security properties. The attestation claim — "generates cryptographic proof that specific code ran in a specific environment at a specific time" — accurately describes remote attestation. No fix required.

### DeFi Protocol Claims

**Footnote:** `[^defi]` — "Uniswap v3 whitepaper; Compound Protocol Specification; Aave v3 Technical Paper."

**Status: CONFIRMED (general characterization).**

Automated market makers (Uniswap), algorithmic interest rate models (Compound), and liquidation engines (Aave) are real and accurately described. The claim that they "execute financial actions continuously, at machine speed, without human authorization per transaction" is accurate by design of these protocols. No fix required.

### Confidential AI Inference Claims

**Footnote:** `[^confidential-ai]` — "Intel Project Amber; Azure Confidential Computing; AMD SEV-SNP documentation."

**Status: CONFIRMED (deployment description is accurate).**

All three products are real and used for confidential AI workloads. The claim that confidential inference deployments provide a privacy guarantee that "even the cloud provider cannot observe the patient data being analyzed" is an accurate characterization of attestation-based confidential computing. No fix required.

---

## Routing

**Send to Ghosty** for two targeted fixes:

1. **S1-S3 (Paper citation):** Replace `[^sovereign-agents]` footnote entirely:
   - Correct title: "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI"
   - Correct authors: Botao Hu (B. Hu) and Helena Rong (H. Rong)
   - Correct year: 2026 (arXiv:2602.14951, FAccT 2026)
   - Verify body text claims attributed to this paper against the actual paper

2. **S4 (Aave figure):** Either find a verifiable source for the $2.3 billion figure or replace with an accurate, sourced figure from an accessible DeFi analytics source. If no figure can be sourced, remove the specific dollar amount.

---

## Conclusion

The chapter's core argument — that sovereign agents reconfigure rather than escape PAC Framework accountability, relocating it from concurrent to pre-execution — is well-constructed and internally consistent. The MakerDAO opening example is accurate. The EU AI Act and TEE technical claims are accurate. Two specific facts are wrong: the Hu/Rong paper citation is substantially incorrect (wrong title, wrong initials, wrong year by two years), and the Aave $2.3 billion liquidation figure is unverifiable. Both require correction before publication.
