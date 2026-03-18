# Verifiable Intent: Cryptographic Authorization for Agentic Commerce

When an agent buys something on your behalf, several questions become evidence questions. Did you authorize this? Within what bounds? Can the payment network verify those bounds without seeing your shopping list? Can the merchant confirm your approval without seeing your payment instrument?

OAuth and delegation frameworks answer identity questions: who is this agent, and what resources can it access? They do not answer what the user actually authorized for this specific action. The gap matters because authorization scope ("the agent can access my purchasing account") is not the same as intent ("I authorized it to buy wireless headphones under $300 from these two merchants, once, this week"). OAuth cannot carry the second set of constraints in a machine-enforceable way.

Verifiable Intent (VI), open-sourced by Mastercard and Google in early 2026 and backed by IBM, Fiserv, Checkout.com, and the major commerce protocols, closes that gap. It turns user intent into a cryptographic object that can be verified by any party in a commerce chain without prior coordination.[^vi-mastercard]

## The Three-Layer Architecture

VI is built on SD-JWT (Selective Disclosure JSON Web Tokens, RFC 9901). Three layers, each signed by the entity that controls that level of authority:

**L1: Identity.** The issuer (e.g., a card network) signs a credential binding the user's identity to a public key. This credential lasts up to a year. It is the root of the chain.

**L2: Intent.** The user signs a mandate using their L1 key. The mandate specifies what the agent is authorized to do and within what bounds: which merchants, which amounts, what recurrence, which specific items. L2 includes the agent's public key, authorizing only that key to generate L3 credentials. L2 carries a hash of the full L1 credential, binding intent to identity.

**L3: Action.** The agent signs what it intends to do, using the key L2 authorized. L3 carries a hash of the specific L2 disclosures it was generated against, binding action to intent. The chain stops at L3: the agent cannot sub-delegate to another agent.

L2 runs in two modes. In immediate mode, the user confirms the transaction directly. In autonomous mode, the user sets constraints in advance and authorizes a specific agent. The agent can then act within those constraints without interrupting the user for each transaction. The lifetime difference reflects the trust difference: immediate mode credentials expire in roughly 15 minutes; autonomous mode credentials can last 24 hours to 30 days depending on the mandate type.[^vi-mastercard]

L3 splits into two credentials:

- **L3a** goes to the payment network. It contains payment details: amount, payee, transaction ID.
- **L3b** goes to the merchant. It contains checkout details: line items, merchant identity, checkout hash.

Both halves are bound by `transaction_id == checkout_hash`. The payment network verifies L3a against L2's payment constraints. The merchant verifies L3b against L2's checkout constraints. Neither party sees the other's data. Both parties can independently verify that the agent acted within the bounds the user set. The two halves only come together during dispute resolution, where the full chain becomes the evidentiary record.[^vi-mastercard]

## Machine-Enforceable Constraints

The constraint system is what makes VI different from a general-purpose credential format. Eight constraint types define the scope of what an agent can do:[^vi-mastercard]

| Constraint | What it bounds |
|---|---|
| `mandate.checkout.allowed_merchant` | Which merchants the agent can transact with |
| `mandate.checkout.line_items` | What the agent can buy, with quantities |
| `payment.allowed_payee` | Which payees the agent can send to |
| `payment.amount` | Acceptable range per transaction (min/max, currency) |
| `payment.budget` | Cumulative spend cap across transactions |
| `payment.recurrence` | Subscription setup (frequency, start/end) |
| `payment.agent_recurrence` | Multi-transaction authorization within bounds |
| `payment.reference` | Binds payment to a conditional transaction ID |

Budget, recurrence, and agent recurrence require the payment network to maintain state across transactions. That infrastructure requirement buys something: constraint enforcement happens at the network level, not at the agent level. An agent operating within a budget mandate cannot exceed it by signing additional L3 credentials: the network is the enforcement point, not the agent's own configuration.

An agent's self-imposed limits can be removed or bypassed. Network-level constraints cannot be removed by the agent. The same logic that motivates hardware security modules for key management (take the sensitive operation out of software) applies here: take constraint enforcement out of the agent.

## Selective Disclosure: Privacy by Architecture

The sd_hash mechanism is what makes selective disclosure work across parties with different visibility requirements:

- L2 hashes the full serialized L1 credential
- L3a hashes the L2 base credential plus only the payment disclosures it needs to reveal
- L3b hashes the L2 base credential plus only the checkout disclosures it needs to reveal

Tampering with any disclosure breaks the hash in the next layer. Each L3 credential is cryptographically bound to its own selective view of L2. The payment network sees only what it needs to verify the payment. The merchant sees only what it needs to confirm the purchase. Neither can see beyond their own scope, and neither can fabricate claims about what the other received.[^vi-mastercard]

The constraint on disclosure is in the data structure, not in a policy statement or a trust relationship. A party that cannot see the other's disclosures is not being politely excluded. It literally cannot reconstruct the excluded claims from what it received.

## Where VI Sits in the Stack

VI does not replace OAuth, delegation frameworks, or DIDs. It extends them.

The L1 credential establishes identity, grounded in an issuer relationship (a card network, an identity provider). The existing identity infrastructure determines who can be an L1 issuer and how the public key binding is established. VI does not specify how agent keys are discovered or verified across organizations: the `kid` format is left to implementations. That gap is where A2A, TSP, and standards like DIDs apply.[^vi-mastercard]

The L2 mandate is the novel layer. Delegation frameworks like OAuth's RAR (Rich Authorization Requests) establish what resources an agent can access. L2 establishes what the user authorized for a specific engagement: not a scope, but a constrained mandate with a time limit, a set of permitted merchants, and a spending ceiling. RAR and L2 address different questions.

VI integrates with all three major commerce protocols. AP2 references Verifiable Intent as its cryptographic constraint layer. ACP handles checkout flows through a compatible mandate model. UCP handles product discovery and integrates with AP2 for secure payment handling.[^commerce-protocols] The shared primitives (SD-JWT credentials, mandate structures) give VI a path to relevance regardless of which commerce protocol wins.

## What VI Does Not Solve

**Single-hop delegation only.** L3 is terminal. An agent cannot sub-delegate to another agent using VI. Multi-agent architectures where one agent orchestrates several sub-agents cannot use VI for the inner delegation hops. As agent systems become more composable, this single-delegation constraint will surface as a structural limit.

**Agent compromise mid-execution.** If an agent is compromised after receiving L2 authorization (by prompt injection, for example), the attacker can generate L3 credentials that satisfy L2 constraints but serve malicious purposes. The constraint system bounds the damage, it does not prevent it. VI is a proof-of-intent mechanism, not an agent reliability mechanism. Agent reliability remains the responsibility of the engineering behind the agent.

**Trust bootstrapping for agent keys.** Agents are identified in L2 by their public key (`cnf.kid`). There is no standard way within VI to discover or verify those keys across organizations. An agent's key must be established through some prior trust relationship before it can receive L2 authorization. DID-based agent identity (as in MCP-I under DIF governance) is one path; enterprise-managed agent identities (as in Microsoft Entra Agent ID) are another.

**Liability assignment.** VI provides the evidentiary chain for disputes: cryptographic proof of what the user authorized, what the agent was bound to, and what it actually did. It does not define what happens when the chain is satisfied and the user is still unhappy. Dispute procedures, chargebacks, and liability assignment remain payment-network-specific. The spec provides the evidence, not the verdict.[^vi-mastercard]

## What to Do Now

**If you are building agentic commerce applications:**

Treat L2 mandates as the user authorization artifact, not OAuth tokens. The question "what exactly did the user approve?" should have a cryptographic answer. Mandate structure and constraint types are more precisely auditable than OAuth scope strings.

**If you are evaluating agent payment rails:**

Ask which rails support or integrate with VI-style mandate structures. AP2 integrates VI explicitly. ACP uses compatible mandate models. x402 handles settlement but not intent encoding. VI and x402 are complementary: VI carries the authorization chain, x402 carries the payment settlement.

**On multi-agent architectures:**

VI's L3-is-terminal design is a current constraint, not a permanent one. If your architecture requires one agent to authorize another to spend on its behalf, VI does not yet support that. Design for single-hop authorization now and monitor the spec as multi-agent delegation patterns emerge.

**On the convergence question:**

The three commerce protocols (AP2, ACP, UCP) and VI share enough primitives (SD-JWT credentials, mandate structures) that building on shared components rather than protocol-specific APIs is the lower-risk path. The protocols are still early. The standards are not.

## Infrastructure Maturity for Agentic Commerce

| Level | What exists | Authorization posture |
|---|---|---|
| **I1 Open** | No mandate structure | Agent purchasing authority is undefined; scope is whatever the agent assumes |
| **I2 Logged** | Purchase actions recorded after the fact | Post-hoc audit possible; no constraint enforcement at transaction time |
| **I3 Verified** | Agent identity confirmed, scoped OAuth tokens | Authorization scope is declared, but no machine-enforceable per-transaction constraints |
| **I4 Authorized** | VI mandate structure with network-level enforcement | Transaction constraints enforced at the payment network; the agent cannot exceed scope by intent or compromise |
| **I5 Contained** | Full L1-L2-L3 chain with automated dispute resolution | Intent-to-action chain cryptographically verifiable end-to-end; liability assignable to specific authorization events |

Most agentic commerce deployments today are operating at I2 or I3: OAuth tokens establish scope, but per-transaction constraints live in the application layer, not in the authorization artifact. The move from I3 to I4 is what VI enables. The mandate is not stored in the agent; it is enforced by infrastructure the agent cannot modify.

---

[^vi-mastercard]: Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," shanedeconinck.be, March 6, 2026. Primary source for all architectural details, constraint types, selective disclosure mechanism. L1/L2/L3 structure, lifetime parameters (15 min immediate, 24h-30d autonomous), eight constraint types, split L3a/L3b design, sd_hash binding mechanism, and stated limitations (L3 terminal, agent compromise, trust bootstrapping, liability) all from this source.

[^commerce-protocols]: Verifiable Intent specification (open-sourced by Mastercard and Google, 2026), section on protocol integrations; Agentic Payment Protocol v2 (AP2) specification. AP2's reference to VI as its cryptographic constraint layer, ACP's compatible mandate model, and UCP's AP2 integration for payment handling are described in the VI spec and AP2 protocol documentation, not Shane's blog summary.
