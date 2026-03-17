# Agentic Sovereignty

In 2023, MakerDAO's DAI Savings Rate was adjusted by a governance vote encoded as a smart contract execution. No human executed the rate change directly. The protocol ran the governance logic, verified the quorum, and updated the rate. The change was irreversible the moment the transaction confirmed. No administrator could roll it back. The organization that built the protocol could not override it. The users who voted for it could not undo it. The protocol was the authority.[^maker]

This is agentic sovereignty in its current form: not a future scenario, but an operational pattern that millions of dollars move through today. The PAC Framework's accountability architecture assumes that someone in the delegation chain can be identified, held responsible, and stopped. Sovereign agents are designed so that no one can do any of those things. Not as a failure mode. As the point.

## What Sovereignty Means

Sovereignty here has three meanings, often conflated.

**Technical sovereignty** means the agent's execution is opaque and non-modifiable even to the infrastructure it runs on. A Trusted Execution Environment (TEE) like Intel SGX or AWS Nitro Enclaves creates an encrypted enclave where neither the host operating system, the hypervisor, nor the cloud provider can inspect or alter what runs inside.[^tee] The hardware operator has no more access to the enclave than anyone else. The guarantee is architectural: the host cannot compromise what it cannot read.

**Operational sovereignty** means the agent was designed to run without human intervention as a governance guarantee, not a convenience. DeFi protocols use this pattern: the system is trustworthy precisely because no administrator can modify it mid-execution. The absence of an override is the feature. Any organization that could intervene creates a point of corruption, coercion, or compromise.

**Protocol sovereignty** means the agent persists as long as the underlying protocol operates, regardless of what any individual party does. A smart contract on Ethereum runs until every node stops running Ethereum. Its authors can deprecate the interface, but they cannot stop the contract. The execution environment provides continuity that no single actor controls.

Hu and Rong's framework positions infrastructural sovereignty as the core property: the agent's non-overrideability is not a feature it carries but a condition the execution environment provides. Unilateral termination is structurally impossible.[^sovereign-agents] For TEE deployments, non-overrideability is hardware-enforced. For blockchain deployments, it is consensus-enforced. For protocol-mediated deployments, it is multi-party-enforced: no single party can stop the system because no single party controls it.

## Where PAC Breaks Down

The PAC Framework's accountability architecture rests on a chain of responsible parties. Delegation flows from a human principal through authorization layers to the agent. Every action the agent takes is traceable to a specific authorization by a specific person.

Sovereign agents sever this chain by design.

**No authoritative principal.** When the MakerDAO protocol adjusts the DAI Savings Rate, the responsible party is "the outcome of the governance vote." Not a specific person. Not an organization. A process. The governance process can be inspected, audited, challenged in future votes. But no individual authorized the action or can be held responsible for its consequences.

**No revocation path.** PAC's accountability infrastructure assumes actions can be revoked, agents can be stopped, and delegations can be cancelled. The EU AI Act's corrective action requirements assume a human can intervene.[^euaia] TEE-based agents can be designed with no external kill switch. On-chain agents have no kill switch by definition.

**No audit trail the principal controls.** Blockchain transactions are publicly auditable but immutably recorded in an environment controlled by the protocol, not by any organization subject to regulatory jurisdiction. TEE attestation logs prove what code ran but reveal nothing about what data it processed.

These are not defects of poorly-designed systems. They are properties that sovereign environments provide intentionally.

## Where Sovereign Agents Already Operate

**Decentralized finance.** Automated market makers (Uniswap's liquidity pool contracts, Compound's interest rate models, Aave's liquidation engines) execute financial actions continuously, at machine speed, without human authorization per transaction.[^defi] Aave's v3 liquidation engine processed liquidations continuously throughout the March 2023 USDC de-pegging event without a single human-initiated transaction.[^aave] The liquidations were correct by protocol design, and irreversible.

**Confidential AI inference.** Organizations handling sensitive data deploy inference workloads in TEEs: legal discovery agents, medical record summarization, financial analysis.[^confidential-ai] The hospital that deploys a diagnostic agent in an SGX enclave provides a privacy guarantee: even the cloud provider cannot observe the patient data being analyzed. The enclave's non-modifiability is the privacy property. The same design makes the agent difficult to stop, patch, or audit from outside.

**Autonomous vehicle fleets.** Real-time navigation and safety systems cannot wait for human authorization. An agent deciding to brake, merge, or swerve executes in milliseconds, within a closed control loop no external system can override while the vehicle is in motion. The accountability model shifts from "who authorized this action" to "who designed and certified the system that took this action."

**AI agents with protocol continuity.** Research prototypes are testing agents that store state on decentralized storage networks (IPFS, Filecoin, Arweave) and execute logic through smart contracts, creating agents that persist and act without depending on any single operator's infrastructure.[^sovereign-agents] This is early work. The deployment pattern is coming.

## What Breaks, and What Does Not

Sovereign execution does not eliminate accountability. It relocates it.

When a DeFi liquidation engine processes liquidations at machine speed across a market crisis, the accountable parties are the organizations and individuals who designed the protocol, wrote the code, and deployed it. Their accountability is pre-execution, not concurrent. The question is not "who authorized this liquidation?" but "who designed a system that would execute this liquidation under these conditions, and were they authorized to deploy such a system?"

This is not weaker accountability. It is earlier accountability.

**Pre-execution audit.** In sovereign environments, the audit happens before deployment, not after execution. The code is the commitment. Formal verification, third-party audit, and governance votes over protocol parameters are the accountability mechanisms. After deployment, the code does what it was designed to do. The accountability question has already been answered.

**Attestation as accountability.** TEE attestation generates cryptographic proof that specific code ran in a specific environment at a specific time.[^tee] This is not post-hoc audit: it is execution-time accountability evidence. The agent cannot have run different code than what the attestation signed. The accountability question "did this agent do what it was authorized to do?" can be answered from the attestation, even though no human observed the execution.

**Protocol governance.** On-chain agents can be governed through protocol governance mechanisms: parameter adjustments, upgrade proposals, deprecation votes. The governance process is the accountability infrastructure. Who participates, how votes are weighted, what thresholds trigger change: these are the accountability decisions. The smart contract governing agent parameters becomes an accountability layer.

**Liability through deployment.** Organizations deploying sovereign agents in regulated industries carry liability for the outcomes, regardless of whether they can modify the agent post-deployment. The EU AI Act's high-risk deployment obligations apply to deployers, not just developers, and those obligations persist even when the deployed system operates autonomously.[^euaia] Sovereignty does not transfer liability to the protocol.

## The Sovereignty Spectrum and PAC

Sovereign agents do not sit outside the PAC Framework. They reconfigure it.

PAC's Accountability pillar does not require concurrent human oversight of every action. It requires that actions be traceable to authorized principals, that evidence of authorization exists, and that responsible parties exist when things go wrong. Sovereign execution changes the form and timing of that evidence, but not the requirement.

Organizations building sovereign agent systems need to design accountability infrastructure that frontloads the commitments that post-execution accountability normally provides.

- **Pre-deployment specification**: document what the agent will do, under what conditions, with what outcomes, in sufficient detail to constitute a binding accountability record.
- **Attestation infrastructure**: record execution-time evidence that the deployed code ran as specified.
- **Governance mechanisms**: for agents whose parameters can be adjusted, design the governance process as the accountability layer.
- **Liability assignment**: identify who carries regulatory and legal liability for agent outcomes before deployment, not after incidents.

## Infrastructure Maturity

**I1-I2 (Visibility):** Traditional agent registries and audit logs may not capture sovereign agent deployments. An organization that deploys confidential inference workloads in TEEs needs to extend its agent registry to include those deployments, record attestation metadata, and inventory what data flows through sovereign execution environments.

**I2-I3 (Enforcement):** Standard identity and permission infrastructure does not apply to on-chain agents. The equivalent is smart contract access control, multisig governance, and time-lock mechanisms that delay parameter changes to allow community review.

**I3-I4 (Governance):** Governance for sovereign agents requires pre-deployment review processes, formal specification of permitted behavior, and protocol governance mechanisms that provide post-deployment corrective options within the constraints of non-overrideability.

**I4-I5 (Architecture):** Mature sovereign agent deployments incorporate formal verification of critical execution paths, attestation-based audit infrastructure, and graduated sovereignty (TEE-constrained agents that can still be halted by the operator, in contrast to fully on-chain agents that cannot).

## What to Do Now

For organizations outside blockchain-native use cases, agentic sovereignty is not today's deployment problem. It becomes relevant when:

- You are deploying AI agents that handle sensitive data in cloud environments and need hardware-backed privacy guarantees.
- You are evaluating third-party AI services where the provider's non-modifiability claim is a selling point.
- You operate in industries (financial services, healthcare) where AI agents may eventually be deployed with protocol-enforced autonomy for speed and integrity reasons.
- You are assessing the accountability structure of AI systems you depend on, including vendor-operated agents whose execution you cannot inspect.

Three actions are worth taking now regardless of your current deployment profile:

**Classify sovereign execution in your AI inventory.** If your organization uses AI systems where the vendor provides a non-modifiability guarantee, including confidential compute environments, record that in your agent registry. The accountability model for those systems is different from standard deployments, and your incident response playbook needs to reflect that.

**Separate pre-execution and concurrent accountability.** For sovereign-by-design deployments, stop asking "who can we contact to stop this?" and start asking "what did we commit to when we deployed this?" The accountability record is the specification, the audit, and the governance approval. If those do not exist before deployment, no amount of monitoring after deployment provides the accountability that regulated industries require.

**Track the sovereignty spectrum.** The line between "agent that humans can stop" and "agent that operates autonomously within governed parameters" is already blurring in enterprise deployments. Organizations that have not thought through where their agents sit on that spectrum will discover the boundary during an incident. Map it now.

The sovereign agent pattern is not a failure of the accountability architecture. It is an accountability architecture with different properties: front-loaded instead of concurrent, structural instead of supervisory, protocol-enforced instead of administratively-enforced. Understanding the difference is what makes it governable.

---

[^maker]: MakerDAO governance documentation, stability fee and DSR adjustment records, 2023. Governance votes are recorded on-chain and publicly verifiable at vote.makerdao.com.

[^tee]: Intel SGX Developer Guide; AWS Nitro Enclaves documentation. TEE attestation provides cryptographic proof of code identity at execution time without revealing execution contents.

[^sovereign-agents]: Hu, B. and Rong, H., "Sovereign Agents: Towards Infrastructural Sovereignty and Diffused Accountability in Decentralized AI," arXiv:2602.14951, February 2026 (FAccT 2026). Framework for agents whose continuity and accountability properties are inherited from decentralized execution environments.

[^euaia]: EU AI Act, Regulation (EU) 2024/1689, Articles 9 and 16. High-risk AI system deployers carry obligations for risk management, transparency, and corrective action that persist post-deployment.

[^defi]: DeFi protocol mechanics are documented in respective protocol whitepapers. Uniswap v3 whitepaper; Compound Protocol Specification; Aave v3 Technical Paper.

[^aave]: Aave protocol liquidation activity during the March 2023 USDC de-pegging event. On-chain records are publicly verifiable via Etherscan and Aave analytics dashboards. Specific aggregate figures vary by methodology; the point is the protocol's automated execution without human intervention.

[^confidential-ai]: Confidential computing use cases for AI: Intel Project Amber; Azure Confidential Computing; AMD SEV-SNP documentation. Adoption is concentrated in healthcare, legal, and financial services.
