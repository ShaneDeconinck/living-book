# Agent Payments and Economics

When an agent pays for something, it does more than transfer money. It creates proof that someone authorized expenditure, binds an economic stake to an action, and produces an audit trail that connects identity to intent to outcome. Payment is not just a transaction: it is a trust signal.

## Why Traditional Payments Break for Agents

Traditional payment infrastructure assumes a human at the keyboard. Credit cards require cardholder authentication (3D Secure, biometrics). Account signups need manual verification. Billing cycles assume monthly invoices reviewed by humans.

Agents break every one of these assumptions:

**No human in the loop.** An agent making a purchasing decision at 3 AM cannot authenticate via SMS or biometric. The authentication ceremony that credit cards rely on does not work when the "cardholder" is software.

**Micro-transaction economics.** Traditional payment processing has minimum viable transaction sizes. Stripe charges $0.30 + 2.9% per transaction. For a $0.01 API call, you lose $0.30 in fees: a 3,000% overhead. Agents making thousands of small API calls per day need payment rails designed for micro-transactions.[^1]

**Speed and volume.** An agent orchestrating a multi-step workflow might make dozens of API calls per minute. Each call might need payment. Batch billing after the fact loses the real-time accountability that agent governance requires. Payment needs to happen inline with the action.

**Cross-organizational trust.** When your agent calls my API, we may have no prior relationship. There is no billing agreement, no contract, no established trust. The payment itself needs to bootstrap trust: cryptographic proof that someone authorized this spend, settled in a way both parties can verify.

**Machine-to-machine identity.** Payment processors verify the identity of human customers. When the customer is an agent acting on behalf of a human, the payment system needs to answer a different question: who authorized this agent to spend, and within what bounds?

## Payment as Trust Signal

When an agent pays for an API call using x402, the payment creates:

- **Proof of authorization.** Someone funded this wallet and authorized the agent to spend from it. The cryptographic signature proves it.
- **Economic accountability.** Real money creates real consequences. An agent burning through its budget triggers the same alerts as an employee on an expense account.
- **Sybil resistance.** Creating fake agents is cheap. Making them pay is not. Payment is a natural filter against spam, abuse, and resource exhaustion.
- **Audit trail.** On-chain settlement creates an immutable record of who paid whom, when, and how much. This is compliance-grade accounting that happens automatically.

## x402: HTTP Gets a Payment Layer

HTTP 402 "Payment Required" has existed since 1997 but never had a payment layer behind it. Coinbase and Cloudflare are building one: x402, an open standard that embeds payment directly into HTTP workflows.[^3]

Shane built a proof-of-concept: a real estate API where an AI agent queries property data, gets a 402 response with payment instructions, signs a stablecoin authorization, and receives the data. No human in the loop.[^2]

The flow works like this:

```
1. Agent:   GET /api/v1/listings?neighborhood=Mission
2. Server:  402 Payment Required
            {
              "x402Version": 1,
              "accepts": [{
                "scheme": "exact",
                "network": "base-sepolia",
                "maxAmountRequired": "10000",
                "resource": "/api/v1/listings",
                "asset": "0x036C...Cf7e"
              }]
            }
3. Agent:   Signs EIP-712 TransferWithAuthorization (gasless)
4. Agent:   GET /api/v1/listings + X-PAYMENT header
5. Server:  Verifies signature, settles on-chain, returns data
```

The key technical innovation is **EIP-3009 TransferWithAuthorization**: a standard supported by USDC that enables gasless payments. The agent signs an authorization using EIP-712 typed data, but never sends a blockchain transaction. The server settles the payment on-chain and pays the gas.[^2]

The agent needs a signing key, not ETH for gas. It needs USDC in its wallet, not a full blockchain client. The private key management is still a custody concern, but the operational complexity is reduced.

### The Economics of L2 Settlement

The viability of x402 depends entirely on where you settle. Shane's demo showed the economics:[^2]

| Query Price | Base L2 Gas (~$0.002) | Server Overhead | Mainnet Gas (~$15) | Server Overhead |
|---|---|---|---|---|
| $0.01 | $0.002 | 20% | $15 | 150,000% |
| $0.10 | $0.002 | 2% | $15 | 15,000% |
| $1.00 | $0.002 | 0.2% | $15 | 1,500% |

Layer 2 networks make micro-payments viable. Ethereum mainnet does not. This is why x402 adoption is concentrating on L2s like Base: the gas economics make sub-dollar transactions practical.

### x402 Adoption

The infrastructure investment behind x402 is substantial. The x402 Foundation, co-founded by Coinbase and Cloudflare, was announced in September 2025 to establish x402 as a universal standard for agent payments.[^4] Stripe launched x402 integration on Base in February 2026.[^5] Cloudflare integrated x402 directly into its Agent SDK and MCP server infrastructure, so agents built on Cloudflare can pay for resources natively and MCP servers can expose tools as payable endpoints.[^cloudflare-x402] Stellar added x402 support for stablecoin-based API payments.[^stellar-x402] The protocol has expanded across a dozen chains including Base, Solana, Polygon, Stellar, and Etherlink.[^6]

Cloudflare is also proposing a **deferred payment scheme** for x402: batch settlements at the end of each day rather than per-request on-chain transactions.[^cloudflare-x402] The deferred scheme makes x402 payment-rail-agnostic: cryptographic trust (intent capture, authorization verification) is established immediately via the x402 handshake, but financial settlement can happen through traditional payment methods, stablecoins, or both. The main adoption barrier: most organizations do not hold USDC. With deferred settlement, they do not need to.

The honest assessment: infrastructure investment is ahead of organic demand. Despite major backing from Stripe, Coinbase, Cloudflare, and Stellar, x402's daily organic volume sits around $28,000 as of early March 2026, with roughly half of observed transactions reflecting artificial activity (self-dealing and wash trading) according to Artemis on-chain analytics.[^x402-volume] Daily transactions dropped over 92% from a December 2025 peak of approximately 731,000 to about 57,000 in February 2026. This is not unusual for early infrastructure protocols: TCP/IP, email, and HTTP itself took years before organic use caught up. The pattern of major infrastructure providers treating agent payments as a first-class use case suggests the bet is on the infrastructure being ready when demand arrives, not on demand having already arrived.

## The Four Commerce Protocols

Four protocols are defining how agents conduct commerce. Three handle different stages of the transaction: discovery, checkout, and payment authorization. The fourth handles a prior question: how does a merchant know the agent is legitimate in the first place?

### AP2: Agent Payments Protocol

Google's AP2, announced in September 2025, has over 60 organizations participating, including Mastercard, American Express, PayPal, Adyen, Etsy, and Coinbase.[^7]

AP2's core abstraction is the **Mandate**: cryptographically signed records of user instructions and approvals. An Intent Mandate captures the user's instruction ("find running shoes under $120"). A Cart Mandate captures the user's approval of a specific purchase. This two-step mandate structure separates browsing from buying, which matters for accountability: you can trace exactly what the user authorized versus what the agent decided.[^7]

AP2 is payment-agnostic (cards, bank transfers, crypto via x402) and integrates with Verifiable Intent for cryptographic constraint enforcement. Google's A2A x402 extension provides production-ready agent-based crypto payment support.

### ACP: Agentic Commerce Protocol

Stripe and OpenAI's ACP takes a different approach: start from the checkout experience and work backwards. ACP launched as the protocol behind Instant Checkout in ChatGPT, enabling users to purchase from Etsy sellers directly in conversation, with Shopify integration announced as coming soon.[^8] OpenAI dropped direct checkout from ChatGPT in early March 2026, within months of launch, amid reported issues with inventory sync, tax infrastructure, and low merchant adoption. The ACP protocol continues.

ACP is deliberately merchant-centric. The merchant remains the merchant of record, retaining control over product presentation, pricing, and fulfillment. The agent facilitates the transaction but does not become a party to it. This preserves existing commerce relationships rather than disintermediating them.[^8]

The specification is maintained by OpenAI and Stripe (Apache 2.0), with Salesforce announcing support in collaboration with Stripe.

### UCP: Universal Commerce Protocol

Google, Shopify, and Walmart co-announced UCP in January 2026 as an open-source standard for the next generation of agentic commerce, with Visa among more than 20 endorsing partners. UCP focuses on making product catalogs discoverable and transactable by AI agents, with compatibility with AP2 for secure payment handling.[^9]

Where AP2 handles the payment authorization flow, UCP handles the product discovery and catalog layer: ensuring agents can access accurate product information, inventory, and pricing across merchants.

### TAP: Trusted Agent Protocol

Visa's Trusted Agent Protocol, announced in October 2025 and open-sourced on GitHub, solves the trust bootstrapping problem the other three protocols assume away: how does a merchant distinguish a legitimate agent from a bot?[^tap]

TAP uses RFC 9421 HTTP Message Signatures. Every agent request carries two headers: `Signature-Input` (metadata including the request URI, timestamps, key identifier, algorithm, nonce, and a tag distinguishing browsing from payment) and `Signature` (the cryptographic signature itself). The merchant validates the signature against publicly retrievable keys hosted at well-known JWKS endpoints. No bilateral agreement required.[^tap-spec]

Three properties make this architecturally distinct from Verifiable Intent:

**Merchant-specific binding.** Each signature is cryptographically locked to a specific merchant's domain and the exact page the agent is interacting with. An authorization for `audioshop.example.com/headphones` cannot be relayed to a different merchant or a different product page.

**Time-bound validity.** Signatures expire after a maximum of 8 minutes. Merchants track nonces within that window to prevent replay attacks. The combination of short-lived signatures and nonce deduplication means captured requests are useless almost immediately.

**Existing web infrastructure.** TAP is built on HTTP, not on new credential formats. Merchants need to add signature verification to their existing web servers, not adopt SD-JWT or blockchain infrastructure.[^tap-spec]

The protocol carries three types of information: agent intent (proof the agent is Visa-trusted with a specific commerce purpose), consumer recognition (hashed identifiers that let merchants match returning customers without exposing raw data), and payment information (hashed credentials for checkout or encrypted payloads for API integrations).[^tap]

TAP's traction is notable. Over 100 global partners have completed hundreds of controlled real-world transactions, including Skyfire (Consumer Reports' agent purchasing Bose headphones), Nekuda (fashion recommendation agents), and Ramp (B2B corporate bill payments). Nuvei, Adyen, and Stripe are early adopters. Pilot programs are launching in Asia Pacific and Europe in 2026.[^tap-transactions]

### Convergence

The four protocols are more complementary than competitive. TAP establishes agent legitimacy at the merchant's front door. UCP handles product discovery. ACP handles checkout flows. AP2 handles payment authorization. Verifiable Intent (covered in the [Agent Identity and Delegation](agent-identity.md) chapter) provides the cryptographic constraint layer that AP2 and TAP both reference. The real question is whether they converge on shared primitives or fragment into incompatible ecosystems.

Google participates in both AP2 and UCP; Stripe participates in ACP, x402, and TAP; Visa participates in both UCP and TAP. Companies joining multiple protocols is what you would expect regardless of the outcome: it is hedging, not evidence of convergence. The protocols share some primitives (SD-JWT credentials, mandate structures, x402 for settlement, HTTP Message Signatures), but shared building blocks do not guarantee a unified stack. Visa is collaborating with Coinbase to align TAP with x402, and the TAP specification explicitly supports HTTP 402 payment flows, which suggests the payment and trust layers are designed to compose.[^tap-spec]

## On-Chain Agent Identity: ERC-8004

The Ethereum Foundation, together with Consensys, Google, and Coinbase, has taken a different approach to agent trust: on-chain registries. ERC-8004, which went live on Ethereum mainnet on January 29, 2026, adds three registries for agent identity, reputation, and validation.[^10]

**Identity Registry.** Each agent gets an NFT (ERC-721) linking to flexible endpoints: A2A agent cards, MCP servers, ENS names, DIDs, wallets on any chain. The NFT is the global identifier. As Shane notes, A2A and MCP solve discovery and communication but assume usage within trust boundaries. When agents cross organizational boundaries, DNS and TLS are not enough.[^10]

**Reputation Registry.** Signed feedback with contextual tags, not a single aggregate score. Past users provide structured ratings ("accurate," "fast," "reliable") that future callers can filter by what matters to their use case. Payment receipts prove the reviewer actually used the service, providing Sybil resistance.[^10]

**Validation Registry.** For high-stakes outputs, agents can request independent verification. The spec supports multiple validation methods: stake-secured (via EigenLayer), zero-knowledge ML proofs, trusted execution environments (Phala, Near.AI), and trusted judges. Validators respond on-chain with a score and evidence hash.[^10]

The trust flow shows the registries working together: a client agent looks up a service agent's identity, checks its reputation, calls the service with x402 payment, optionally requests validation of the output, and submits feedback. Each step produces an on-chain record.

ERC-8004 has deployed across 18+ EVM-compatible chains (Polygon, BNB Chain, Base, Arbitrum, Mantle, Avalanche, and others), using singleton contracts so all agents share the same registry on each chain.[^10]

The spec is honest about limitations. Sybil attacks remain possible (fake agents inflating reputation). Capability verification is not guaranteed (advertised capabilities may not be functional). But the on-chain settlement creates an audit trail that cannot be deleted, and the combination of reputation and validation provides layered trust signals that centralized registries cannot.

## Real-World Milestones

Three milestones from early 2026:

**Santander and Mastercard** completed Europe's first live end-to-end payment executed by an AI agent on March 2, 2026. The transaction used Mastercard Agent Pay within Santander's regulated banking infrastructure, validating the control framework under real conditions. It is not a commercial rollout, but it demonstrates that agent payments can work within existing regulated banking frameworks.[^11]

**Stripe's x402 preview** (February 2026) enables developers to charge AI agents for services using USDC on Base. Stripe released an open-source CLI (purl) and SDK integrations in Python and Node.js, bringing agent payments to Stripe's existing developer ecosystem.[^5]

**J.P. Morgan and Mirakl** announced a strategic agreement on March 10, 2026 to power agentic commerce at enterprise scale. Mirakl's Nexus platform provides the product catalog layer (optimized for AI agent discovery), while J.P. Morgan provides payment infrastructure including tokenization that enables agents to transact safely.[^12]

## The Micro-Transaction Problem

Agent economics differ from human economics. A human might make a few purchases per day. An agent orchestrating a workflow might make hundreds of API calls per hour, each requiring payment.

Traditional payment infrastructure cannot handle this:

- **Processing fees eat micro-payments.** A $0.30 minimum fee makes anything under $1 uneconomical through traditional rails.
- **Settlement latency.** Credit card settlements take days. Agent workflows need payment confirmation in milliseconds.
- **Volume limits.** Rate limits designed for human transaction patterns break under agent-scale volumes.

This is why stablecoin payments on L2 networks have found product-market fit for agent commerce. USDC on Base settles in seconds with $0.002 gas costs. The economics work for $0.01 API calls in a way that credit cards never will.

But stablecoin payments create their own challenges:

- **Custody risk.** The agent holds a private key. Key compromise means fund loss. Unlike credit cards, there is no chargeback mechanism.
- **Regulatory ambiguity.** Stablecoin payments for API access exist in a regulatory grey zone in most jurisdictions. The EU's MiCA regulation provides some clarity, but enforcement is evolving.
- **User onboarding.** Most organizations do not hold USDC. Bridging from fiat to stablecoin adds friction that works against adoption.

The market is splitting into two approaches: crypto-native payments (x402) for developer-to-developer and agent-to-agent transactions, and traditional payment rails (AP2, ACP) for consumer-facing agent commerce where existing card networks handle settlement. Both approaches need the same authorization infrastructure (Verifiable Intent) but different settlement layers.

## Authorization: Where Payments Meet Identity

[Agent Identity and Delegation](agent-identity.md) covers Verifiable Intent's three-layer SD-JWT architecture in detail.

The core problem: OAuth proves what an app can access but not what it is authorized to spend. An OAuth token with a "payments" scope does not encode spending limits, allowed merchants, or budget caps. When an agent holds a payment credential, the question is not "can this agent make payments?" but "what specific payments is this agent authorized to make?"

Verifiable Intent answers this with machine-enforceable constraints:[^13]

| Constraint | What It Bounds |
|---|---|
| `payment.amount` | Min/max range per transaction |
| `payment.budget` | Cumulative spend cap across transactions |
| `payment.allowed_payee` | Which payees the agent can send to |
| `payment.recurrence` | Subscription parameters |
| `mandate.checkout.allowed_merchant` | Which merchants the agent can buy from |
| `mandate.checkout.line_items` | What the agent can purchase |
| `payment.agent_recurrence` | Multi-transaction authorization within bounds |
| `payment.reference` | Binds payment to a conditional transaction ID |

These constraints are enforced at the network level, not at the agent level. The payment network maintains state across transactions (tracking budget caps, enforcing recurrence limits). The agent cannot bypass its own limits because enforcement happens outside the agent's control perimeter. Policy says "don't spend more than $300"; architecture says "can't spend more than $300."

### Selective Disclosure: Privacy by Architecture

Verifiable Intent splits L3 into two credentials: L3a goes to the payment network, L3b goes to the merchant. Each party only sees what they need:[^13]

| Data | Merchant | Payment Network | Dispute |
|---|:---:|:---:|:---:|
| User identity (L1) | yes | yes | yes |
| Constraints (L2) | checkout only | payment only | all |
| Line items | yes | no | yes |
| Payment instrument | no | yes | yes |
| Amount | no | yes | yes |
| Merchant details | yes | identifier only | yes |

Both halves are bound by `transaction_id == checkout_hash`, without either party seeing the other's data. Both halves only come together during dispute resolution. This is privacy by architecture, not by policy: the agent reveals only the relevant SD-JWT disclosures to each verifier.

### What Verifiable Intent Does Not Solve

Shane's analysis of the spec identifies three gaps that matter for payment deployments:[^13]

**L3 is terminal.** The agent cannot sub-delegate to another agent. There is no provision for multi-hop delegation chains. VI models a world where one agent acts for one user. As agent systems become more composable (agent calling agent calling agent), this single delegation step may prove insufficient for complex procurement workflows.

**Agent compromise within constraints.** If an agent is compromised mid-execution (prompt injection, for example), the attacker could generate L3 credentials that satisfy L2 constraints but serve malicious purposes. A compromised agent authorized to buy headphones under $300 from approved merchants could buy the wrong headphones from an approved merchant. The constraint system bounds the damage but does not prevent it. VI generates proof of intent, not a guarantee of agent reliability.

**Trust bootstrapping.** Agents are identified by their public key, but there is no standard way to discover or verify those keys across organizations. The `kid` format is left to implementations, with no prescribed format like DIDs or URLs. This is the gap that A2A, TSP, and DID-based discovery aim to fill, and why VI alone is not a complete trust solution for agent commerce.

## Know Your Agent: Commerce Identity Verification

Verifiable Intent constrains what an agent can do once authorized. But a prior question remains: how do you know the agent is legitimate in the first place? Traditional commerce has KYC (Know Your Customer) and KYB (Know Your Business). Agent commerce needs a third layer: KYA, Know Your Agent.[^kya-pymnts]

The problem is structural. Nearly 90% of enterprises report that bot management is a major challenge, and outdated digital identity controls cost businesses nearly $100 billion annually in fraud, false declines, and lost customers.[^kya-pymnts] When the "customer" is an AI agent, existing verification breaks down: agents spin up and disappear instantly, share models or keys, run on edge or cloud, and can be delegated vast spending authority. The identity systems we use today were never designed to authenticate a participant that may not be human.[^prove-crisis]

### Trulioo's KYA Framework and the Digital Agent Passport

Trulioo, a global identity verification platform, launched Know Your Agent in August 2025 and published a whitepaper defining a five-checkpoint architecture for agent commerce trust.[^trulioo-kya] At its center is the **Digital Agent Passport (DAP)**: a tamper-proof credential bundle that enables merchants to assess whether an AI agent is legitimate, authorized, and acting with proper consent.

The five checkpoints weave through the agent's lifecycle:

1. **Verify the developer.** Standard KYB/KYC on the entity that built the agent. If you cannot verify who made it, nothing downstream matters.
2. **Lock the code.** Cryptographic attestation that the agent's code has not been tampered with since verification. Code integrity as a trust prerequisite.
3. **Capture user consent.** Explicit, verifiable authorization from the human principal. Not an OAuth scope: a recorded consent event binding the agent to a specific set of permissions.
4. **Issue the Digital Agent Passport.** The DAP bundles the verified developer identity, code attestation, and user consent into a portable credential that merchants and payment networks can validate at machine speed.
5. **Continuous validation.** Ongoing monitoring of agent behavior, risk profile, and authorization status. If code changes, consent is revoked, or suspicious activity arises, the passport is invalidated in real time.[^trulioo-kya]

KYA is not a one-time check. It is a living system where every agent remains under continuous scrutiny.

The framework is gaining traction in the payment ecosystem. Trulioo joined Google's AP2 initiative in December 2025, integrating the Digital Agent Passport as a verifiable trust layer within AP2's payment authorization flow.[^trulioo-ap2] Worldpay partnered with Trulioo in August 2025 to embed KYA into its payment infrastructure, enabling merchants to verify agent identity before processing transactions.[^worldpay-trulioo]

### Prove's Verified Agent

Prove, an identity verification company with over a decade of infrastructure behind phone-centric identity, launched Verified Agent in October 2025 as a complementary approach.[^prove-verified] Where Trulioo starts from developer verification, Prove starts from the human: creating a persistent digital identity anchor that binds attributes (phone numbers, national IDs, payment credentials) to verified humans and businesses, then issues signed digital credentials to their authorized agents.

The principle: agentic commerce cannot scale without a foundational trust layer that binds every agent action back to a verified human and a verified authorization event.[^prove-crisis] Prove's solution launched with AP2 support and is expanding to be protocol-agnostic, ensuring interoperability across future commerce standards.

### Where KYA Meets Verifiable Intent

KYA and Verifiable Intent solve different halves of the same problem. KYA answers: is this agent legitimate, who made it, and who authorized it? Verifiable Intent answers: what specific actions is this agent authorized to perform, and within what constraints?

Together they compose into a complete trust stack for agent commerce:

| Layer | What It Proves | Who Enforces |
|---|---|---|
| KYA (Digital Agent Passport) | Agent is legitimate, code is intact, human consented | Merchant, payment network |
| TAP (HTTP Message Signatures) | Agent is Visa-trusted, request is fresh and merchant-specific | Merchant |
| Verifiable Intent (SD-JWT) | Spending limits, merchant restrictions, line items | Payment network |
| Settlement (x402, card networks) | Payment was authorized and funds transferred | Settlement infrastructure |

Neither layer alone is sufficient. An agent with a valid Digital Agent Passport but no spending constraints can still overspend. An agent with tight Verifiable Intent constraints but no identity verification could be a spoofed copy. The combination provides both identity assurance and behavioral enforcement.

The convergence is already happening: Trulioo and Prove both support AP2, which integrates Verifiable Intent.

## PAC Framework Mapping

Agent payments connect to all three pillars:

| Pillar | Payment Dimension | Example |
|---|---|---|
| **Potential** | New business models: pay-per-query data monetization, autonomous service procurement | Data owners expose APIs, agents pay per call. No BD deals needed. |
| **Potential** | Micro-transaction economics unlock services too small to contract for | $0.01 property data queries, $0.10 AI-powered valuations |
| **Accountability** | Payment creates auditable proof of authorization | On-chain settlement: who paid whom, when, how much. Immutable. |
| **Accountability** | Economic stake as governance signal | Budget limits trigger alerts. Spending patterns reveal scope creep. |
| **Control** | Cryptographic spending constraints (Verifiable Intent) | Network-enforced budget caps, merchant restrictions, amount limits |
| **Control** | On-chain identity and reputation (ERC-8004) | Portable agent identity, tamper-resistant reputation, validated outputs |

### Infrastructure Maturity for Agent Payments

| Level | Payment Capability | Example |
|---|---|---|
| **I1 Open** | No agent payment infrastructure. Manual billing. | Invoice-based API access |
| **I2 Logged** | Agent transactions logged but not constrained | API key billing with usage dashboards |
| **I3 Verified** | Agent identity verified at payment time | x402 with wallet-based agent identity |
| **I4 Authorized** | Spending constraints cryptographically enforced | Verifiable Intent with budget caps and merchant restrictions |
| **I5 Contained** | Full economic governance: identity, constraints, reputation, validation | ERC-8004 registries + Verifiable Intent + x402 + cross-org trust |

Most organizations today are at I1-I2 for agent payments. The infrastructure for I3-I4 exists (x402, Verifiable Intent) but requires integration work. I5 requires the agent identity standards covered in [Agent Identity and Delegation](agent-identity.md) to mature further.

## What This Means in Practice

For organizations building agent systems today:

**Start with the economics.** Before building agent payment infrastructure, understand the transaction pattern. How many API calls per workflow? What price point? What settlement latency do you need? The answer determines whether you need x402 (micro-transactions, real-time) or traditional payment rails (larger transactions, existing merchant relationships).

**Separate payment authorization from payment settlement.** The constraint layer (Verifiable Intent) is independent of the settlement layer (x402, card networks, bank transfers). Build the authorization infrastructure first. Settlement options will multiply.

**Watch the convergence.** AP2, ACP, and UCP are still early. Betting on one protocol risks lock-in. Building on their shared primitives (SD-JWT credentials, mandate structures, x402 for settlement) is safer than building on protocol-specific APIs.

**Budget as governance.** Agent spending limits are not just financial controls: they are governance infrastructure. A budget cap is a blast radius limiter. Spending alerts are anomaly detection. Transaction logs are audit trails. Treat agent wallet management with the same rigor as credential management.

**On-chain versus off-chain.** ERC-8004's on-chain registries provide censorship resistance and composability with DeFi primitives. Off-chain registries (A2A agent cards, MCP servers) provide lower latency and simpler integration. Most organizations will use both: on-chain for cross-organizational trust, off-chain for internal operations.

Payment is where agent trust becomes measurable in dollars. Every transaction is a test: does this agent have the right to spend, the right amount, for the right purpose, on behalf of someone who authorized it?

[^1]: Stripe pricing: 2.9% + $0.30 per successful card charge, as of March 2026.
[^2]: Shane Deconinck, "When Agents Pay for APIs: Getting Hands-On with x402 and EIP-3009," January 7, 2026.
[^3]: x402 specification, https://www.x402.org/.
[^4]: Coinbase Blog, "Coinbase and Cloudflare Will Launch the x402 Foundation," September 23, 2025.
[^5]: Stripe Documentation, "x402 payments," February 2026; The Block, "Stripe adds x402 integration for USDC agent payments on Base," February 11, 2026.
[^6]: Solana, "What is x402? Payment Protocol for AI Agents on Solana," 2026. Multi-chain expansion: Etherlink (TZ APAC's Tez402, March 2026), Stellar (stablecoin API payments), Polygon, Arbitrum, and others.
[^cloudflare-x402]: Cloudflare, "Launching the x402 Foundation with Coinbase, and support for x402 transactions," blog.cloudflare.com, 2026. Agent SDK and MCP server integration, deferred payment scheme proposal for batch settlements via traditional payment methods or stablecoins.
[^stellar-x402]: Stellar, x402 support announcement, 2026. Enables AI agents to pay for APIs and digital services through direct stablecoin transactions on Stellar.
[^x402-volume]: Artemis, on-chain analytics, March 2026. Daily transactions dropped over 92% from a December 2025 peak of approximately 731,000 to about 57,000 in February 2026; daily organic volume approximately $28,000 as of early March 2026; roughly half of observed transactions reflect artificial activity (self-dealing and wash trading). See also: Sam Reynolds, "Coinbase-backed AI payments protocol wants to fix micropayment but demand is just not there yet," CoinDesk, March 11, 2026.
[^7]: Google Cloud Blog, "Announcing Agent Payments Protocol (AP2)," September 2025.
[^8]: Stripe Blog, "Developing an open standard for agentic commerce," 2026; OpenAI, "Buy it in ChatGPT: Instant Checkout and the Agentic Commerce Protocol," 2026.
[^9]: Google Developers Blog, "Under the Hood: Universal Commerce Protocol (UCP)," 2026.
[^10]: Shane Deconinck, "ERC-8004 Goes Mainnet: Ethereum's Trust Layer for AI Agents," January 28, 2026.
[^11]: Mastercard Newsroom, "Santander and Mastercard complete Europe's first live end-to-end payment executed by an AI agent," March 2, 2026.
[^12]: J.P. Morgan Payments, "Mirakl Nexus & J.P. Morgan Payments Enable AI Agent Checkout," March 10, 2026.
[^13]: Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," March 6, 2026.
[^kya-pymnts]: PYMNTS.com, "Introducing the 'Know Your Agent' Framework for the Age of Agentic Commerce," 2026. See also CIO, "Know Your Agent: The New Frontier of Verification and Digital Commerce," 2026.
[^trulioo-kya]: Trulioo, "Know Your Agent (KYA): An Identity Framework for Agentic Commerce," whitepaper, 2025-2026. Five-step framework: verify developer, lock code, capture consent, issue Digital Agent Passport, continuous validation.
[^trulioo-ap2]: Trulioo, "Trulioo Joins Google AP2 to Enable Trusted Agent Payments," businesswire.com, December 4, 2025. Digital Agent Passport integrated as verifiable trust layer within AP2 framework.
[^worldpay-trulioo]: Worldpay, "Worldpay and Trulioo Collaborate to Embed Trust in the Agentic Commerce Era," businesswire.com, August 14, 2025. KYA framework with Digital Agent Passport for merchant-side agent verification.
[^prove-verified]: Prove, "Prove Launches Verified Agent Solution to Secure the $1.7 Trillion Agentic Commerce Revolution," businesswire.com, October 23, 2025. Cryptographic chain of custody binding agent actions to verified humans. AP2 support at launch.
[^prove-crisis]: Prove, "The Crisis of Identity, Part 1: Why Agentic Commerce Needs a KYA Roadmap," prove.com/blog, 2026.
[^tap]: Visa, "Visa Introduces Trusted Agent Protocol: An Ecosystem-Led Framework for AI Commerce," investor.visa.com, October 2025. Open-sourced on GitHub: github.com/visa/trusted-agent-protocol. Apache 2.0 license.
[^tap-spec]: Visa Developer Center, "Trusted Agent Protocol Specifications," developer.visa.com. Built on RFC 9421 HTTP Message Signatures, Ed25519 or PS256 algorithms, 8-minute signature validity, JWKS-based public key distribution.
[^tap-transactions]: Visa, "Visa and Partners Complete Secure AI Transactions, Setting the Stage for Mainstream Adoption in 2026," usa.visa.com, 2026. Over 100 partners, hundreds of controlled real-world transactions. Early adopters include Nuvei, Adyen, Stripe, Skyfire, Nekuda, PayOS, and Ramp.
