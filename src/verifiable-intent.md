# Verifiable Intent: A Deep Dive

When an agent acts on your behalf, OAuth proves who you are and what an app can access. But it doesn't answer the question that matters in agentic commerce: what exactly did the user authorise, and within what bounds?

Mastercard and Google open-sourced [Verifiable Intent (VI)](https://verifiableintent.dev/) in March 2026 to answer that question. Google, IBM, Fiserv, Checkout.com, Basis Theory, and Getnet are backing it. The spec turns user intent into a first-class cryptographic object: not identity, not access scopes, but the specific constraints a user set for an agent's actions.

This chapter walks through the technical architecture, the actual credential structures, and what VI means for the broader trust infrastructure that agents need.

## The Three-Layer Architecture

VI builds on [SD-JWT](https://datatracker.ietf.org/doc/rfc9901/) (Selective Disclosure JSON Web Tokens, RFC 9901). Three layers, each signed by the entity that controls that level of authority:

- **L1 (Identity)**: Issuer proves who the user is
- **L2 (Intent)**: User defines what the agent may do
- **L3 (Action)**: Agent signs what it intends to do

```
┌─────────────────────────────────────────┐
│  L1: Issuer signs identity credential   │  ~1 year
│  (card network, identity provider)      │
└──────────────────┬──────────────────────┘
                   │ sd_hash binds L2 to L1
┌──────────────────▼──────────────────────┐
│  L2: User signs intent with constraints │  24h-30d (autonomous)
│  (merchants, amounts, budgets)          │  ~15 min (immediate)
└──────┬───────────────────────┬──────────┘
       │                       │
┌──────▼──────┐         ┌──────▼──────┐
│ L3a: Agent  │         │ L3b: Agent  │    ~5 min each
│ → payment   │         │ → merchant  │
│   network   │         │   checkout  │
└─────────────┘         └─────────────┘
```

The chain stops at L3. **The agent cannot delegate further.** This is a deliberate design choice: VI models a world where one agent acts for one user. Multi-hop delegation (agent calling agent calling agent) is out of scope.

L2 supports two modes:
- **Immediate**: the user confirms the transaction themselves. The chain stops at L2, no agent involved.
- **Autonomous**: the user sets constraints and authorises a specific agent via its public key. Only that agent can generate L3 credentials within those bounds.

Each layer includes an `sd_hash`: a hash of the previous layer's SD-JWT as presented, including the specific disclosures that were revealed. Tampering with any disclosure breaks the hash in the next layer. Each L3 is cryptographically bound to its own selective view of L2.

## Walking Through the Credentials

The best way to understand VI is to read the actual credential structures. The examples below are adapted from the [specification's credential format](https://github.com/agent-intent/verifiable-intent/blob/main/spec/credential-format.md).

### L1: Issuer Proves Identity

The issuer (a card network, for example) creates a credential binding the user's identity to a public key:

```json
{
  "iss": "https://issuer.mastercard.com",
  "sub": "user-8a3f9c21",
  "iat": 1700000000,
  "exp": 1731536000,
  "vct": "https://credentials.mastercard.com/card",
  "cnf": {
    "jwk": {
      "kty": "EC",
      "crv": "P-256",
      "x": "f83OJ3D2xF1Bg8vub9tLe1gHMzV76e8Tus9uPHvRVEU",
      "y": "x_FEzRu9m36HLN_tue659LNpXW6pCyStikYjKIWI5a0"
    }
  },
  "pan_last_four": "1234",
  "scheme": "mastercard",
  "card_id": "card-mc-8842",
  "_sd_alg": "sha-256",
  "_sd": ["<hash-of-email-disclosure>"]
}
```

The `cnf.jwk` (confirmation key) is the user's public key. Whoever holds the corresponding private key can sign L2 credentials. The `_sd` array holds hashed disclosures: data that can be selectively revealed. The user's email, for example, is only revealed when needed.

This credential lives for roughly a year. It's the anchor for everything that follows.

### L2: User Defines Intent

The user signs an L2 credential that specifies what the agent may do. L2 splits into two mandates: checkout constraints (what to buy) and payment constraints (how to pay). Both are bound to L1 via `sd_hash`.

The checkout mandate defines allowed merchants and line items:

```json
{
  "vct": "mandate.checkout.open",
  "cnf": {
    "kid": "agent-key-1",
    "jwk": {
      "kty": "EC",
      "crv": "P-256",
      "x": "agent-public-key-x-component",
      "y": "agent-public-key-y-component"
    }
  },
  "constraints": [
    {
      "type": "mandate.checkout.allowed_merchant",
      "allowed_merchants": [
        {"...": "<hash-of-audioshop-disclosure>"},
        {"...": "<hash-of-soundstore-disclosure>"}
      ]
    },
    {
      "type": "mandate.checkout.line_items",
      "items": [
        {"...": "<hash-of-headphones-item-disclosure>"}
      ]
    }
  ],
  "prompt_summary": "Buy wireless headphones under $300 from approved merchants"
}
```

Two things to notice. First, the `cnf` key here is the **agent's** public key, not the user's. This is how L2 authorises a specific agent: only the holder of `agent-key-1` can sign L3 credentials. Second, `prompt_summary` captures the user's original instruction in human-readable form. It's not machine-enforced, but it creates an evidence trail.

The payment mandate defines spending constraints:

```json
{
  "vct": "mandate.payment.open",
  "cnf": {
    "kid": "agent-key-1",
    "jwk": { "kty": "EC", "crv": "P-256", "...": "..." }
  },
  "payment_instrument": {
    "type": "mastercard.srcDigitalCard",
    "id": "f199c3dd-7106-478b-9b5f-7af9ca725170",
    "description": "Mastercard **** 1234"
  },
  "constraints": [
    {
      "type": "payment.amount",
      "currency": "USD",
      "min": 0,
      "max": 30000
    },
    {
      "type": "payment.allowed_payee",
      "allowed_payees": [
        { "name": "AudioShop Inc.", "website": "https://audioshop.example.com" },
        { "name": "SoundStore", "website": "https://soundstore.example.com" }
      ]
    },
    {
      "type": "payment.reference",
      "conditional_transaction_id": "checkout-ref-9f3a2b1c"
    }
  ]
}
```

The amount constraint caps each transaction at $300 (30000 in minor units). The payee constraint restricts who can receive payment. And the reference constraint binds the payment to a specific checkout flow.

### L3a: Agent Acts (Payment Network)

When the agent finds headphones and is ready to purchase, it signs an L3a credential for the payment network:

```json
{
  "alg": "ES256",
  "typ": "kb-sd-jwt",
  "kid": "agent-key-1"
}

{
  "nonce": "c9d1e2f3a4b5c6d7",
  "aud": "https://network.mastercard.com/vi/authorize",
  "iat": 1700200000,
  "exp": 1700200300,
  "sd_hash": "B64U(SHA-256(L2_base+payment_disclosure+merchant_disclosure))",
  "vct": "mandate.payment",
  "payment_instrument": {
    "type": "mastercard.srcDigitalCard",
    "id": "f199c3dd-7106-478b-9b5f-7af9ca725170"
  },
  "currency": "USD",
  "amount": 27999,
  "payee": {
    "name": "AudioShop Inc.",
    "website": "https://audioshop.example.com"
  },
  "transaction_id": "abc123def456..."
}
```

The payment network can verify the entire chain: L3a is signed by the agent key authorised in L2, L2 is signed by the user key confirmed in L1, and L1 is signed by the issuer. The `sd_hash` in each layer makes tampering detectable. The five-minute expiry on L3 means stolen credentials have minimal value.

### L3b: Agent Acts (Merchant)

Simultaneously, the agent sends an L3b credential to the merchant:

```json
{
  "vct": "mandate.checkout",
  "checkout_jwt": "<merchant-signed-jwt>",
  "checkout_hash": "abc123def456...",
  "line_items": [
    {
      "sku": "WH-1000XM5",
      "name": "Sony WH-1000XM5 Wireless Headphones",
      "quantity": 1,
      "unit_price": 27999,
      "currency": "USD"
    }
  ]
}
```

The merchant sees what was purchased. The payment network sees how much was charged. Neither sees the other's data. Both halves are bound by `transaction_id == checkout_hash`.

Both halves only come together during dispute resolution. VI provides the cryptographic evidence but does not define dispute procedures: liability assignment, chargebacks, and arbitration remain payment-network-specific.

## Selective Disclosure in Practice

This is what makes VI genuinely novel for commerce. Each party sees only what they need:

| Data | Merchant | Payment Network | Dispute |
|---|:---:|:---:|:---:|
| User identity (L1) | yes | yes | yes |
| Constraints (L2) | checkout only | payment only | all |
| Line items | yes | -- | yes |
| Payment instrument | -- | yes | yes |
| Amount | -- | yes | yes |
| Merchant details | yes | identifier only | yes |

Privacy by architecture, not by policy. The agent reveals only the relevant SD-JWT disclosures to each verifier. This maps directly to the [PAC Framework's](./pac-framework.md) distinction between Control pillar approaches: "policy says don't; architecture says can't." With selective disclosure, the payment network physically cannot see line items because those disclosures are never sent to it. No access control list. No trust-but-verify. The data simply isn't there.

## Eight Machine-Enforceable Constraints

The spec defines eight constraint types:

| Constraint | What It Bounds |
|---|---|
| `mandate.checkout.allowed_merchant` | Which merchants the agent can transact with |
| `mandate.checkout.line_items` | What the agent can buy, with quantities |
| `payment.allowed_payee` | Which payees the agent can send to |
| `payment.amount` | Acceptable range per transaction (min/max, currency) |
| `payment.budget` | Cumulative spend cap across transactions |
| `payment.recurrence` | Subscription setup (frequency, start/end) |
| `payment.agent_recurrence` | Multi-transaction authorisation within bounds |
| `payment.reference` | Binds payment to a conditional transaction ID |

Budget, recurrence, and agent recurrence require the payment network to maintain state across transactions. That's a significant infrastructure requirement, but it means constraint enforcement happens at the network level, not at the agent level. The agent can't bypass its own limits.

This is a concrete implementation of what [the opening chapter](./agents-create-intent.md) describes as positive-space authorisation: the agent starts from zero authority and receives explicit grants for what it can do. The constraints don't say "don't spend more than $300." They say "you may spend up to $300, at these merchants, for these items." Everything outside that space is impossible, not just forbidden.

## How VI Maps to PAC

Verifiable Intent touches all three pillars of the [PAC Framework](./pac-framework.md):

**Potential**: VI is designed for a specific, high-value use case: agentic commerce. This focus is intentional. Not every agent interaction needs this level of cryptographic ceremony. But financial transactions are high blast radius (B3-B5 in PAC terms) and require infrastructure that matches. The protocol interoperability with AP2, ACP, and UCP (covering Google, Mastercard, Stripe, OpenAI, Shopify, Walmart, Visa, and 60+ partners) signals real market pull.

**Accountability**: The three-layer chain creates an audit trail by construction. Every L3 action is cryptographically bound to the L2 intent that authorised it, which is bound to the L1 identity that anchored it. When something goes wrong, you can trace exactly what was authorised, by whom, and what the agent did within those bounds. The `prompt_summary` field preserves the human's original instruction alongside the machine-enforceable constraints.

**Control**: Constraint enforcement at the network level, not the agent level. Selective disclosure by architecture, not policy. Short-lived L3 credentials (five minutes). Agent bound by public key, not by trust. These are Control-pillar patterns: making the wrong thing impossible rather than relying on the agent to follow rules.

## Beyond Commerce: Agentic JWT

VI addresses agentic commerce specifically. But the same fundamental problem, the gap between what a user intended and what an agent does, exists in every domain where agents act autonomously.

The [Agentic JWT specification](https://datatracker.ietf.org/doc/draft-goswami-agentic-jwt/) (draft-goswami-agentic-jwt-00, published December 2025) takes a different approach to the same problem. Instead of building a new credential chain on SD-JWT, it extends OAuth 2.0 with four mechanisms:

1. **Cryptographic agent identity**: an agent checksum computed from the agent's system prompt, tools, and configuration. If anything changes, the checksum changes, and the token is no longer valid.
2. **Workflow-aware token binding**: links the user's original intent to the agent's execution context, so the authorisation server can verify that the agent is still operating within scope.
3. **New OAuth grant type** (`agent_checksum`): enables authorisation servers to issue tokens specifically for verified agent configurations.
4. **Proof-of-possession at the agent level**: prevents token replay by other agents in the same multi-agent workflow.

The approaches are complementary. VI creates a self-contained evidence chain for high-value commerce transactions. Agentic JWT extends the existing OAuth infrastructure to handle agent-specific authorisation challenges. Both converge on the same insight: when agents create intent, the authorisation system needs to capture what the user actually meant, not just who they are.

## What VI Doesn't Solve

Being clear about the boundaries of a specification is as important as understanding what it does.

**L3 is terminal.** The agent cannot sub-delegate to another agent. There's no provision for multi-hop delegation chains. As agent systems become more composable, with planning agents delegating to specialist sub-agents across organisational boundaries, this single-delegation model may prove insufficient. The [PIC protocol](./protocol-landscape.md) addresses delegation chains, but there's no integration between PIC and VI today.

**Agent compromise.** If an agent is compromised mid-execution (through prompt injection, for example), the attacker could generate L3 credentials that satisfy L2 constraints but serve malicious purposes. The constraint system bounds the damage: a compromised agent authorised to spend $300 at two merchants can't drain a bank account. But within those bounds, it can act freely. VI generates proof of intent, not guarantees of agent reliability. That remains the responsibility of the AI engineering behind the agent.

**Trust bootstrapping.** Agents are identified by their public key, but there's no standard way to discover or verify those keys across organisations. The `kid` format is left to implementations, with no prescribed format like DIDs or URLs. Trust starts at the L1 issuer, but agent-to-agent discovery is out of scope. That's the gap that A2A, TSP, and DID-based discovery aim to fill.

**Liability.** VI creates evidence chains for disputes. But who's liable when L3 satisfies L2 constraints and the user is still unhappy with the result? The agent bought the right headphones from the right merchant for the right price: exactly what was authorised. But the user meant a different model. The spec provides the evidence, not the answer.

## The Convergence Signal

The most significant aspect of Verifiable Intent isn't any single technical choice. It's the convergence signal. Mastercard, Google, IBM, and the payment networks are building on SD-JWT credential chains, not OAuth tokens, not API keys, not blockchain. The same format the EU Digital Identity Wallet uses ([SD-JWT VC](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/)). The same selective disclosure primitive.

VI is already using `vct` fields throughout its credentials (`"vct": "mandate.checkout.open"`, `"vct": "mandate.payment.open"`). The natural path forward is formally adopting the full SD-JWT VC profile, which would add issuer discovery, credential status checking, and type resolution. When that happens, the same verification infrastructure that checks a European digital identity credential could verify an agent's purchase authorisation.

That's not interoperability on paper. That's infrastructure convergence in practice.

---

**Sources:**
- [Verifiable Intent specification](https://verifiableintent.dev/) and [GitHub repository](https://github.com/agent-intent) (Draft v0.1, Apache 2.0)
- [Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization" (2026-03-06)](https://shanedeconinck.be/posts/mastercard-verifiable-intent-agents-can-prove-what-you-approved/)
- [Mastercard announcement: "How Verifiable Intent builds trust in agentic AI commerce"](https://www.mastercard.com/us/en/news-and-trends/stories/2026/verifiable-intent.html)
- [SD-JWT specification (RFC 9901)](https://datatracker.ietf.org/doc/rfc9901/)
- [SD-JWT VC specification (draft-ietf-oauth-sd-jwt-vc)](https://datatracker.ietf.org/doc/draft-ietf-oauth-sd-jwt-vc/)
- [Agentic JWT: Secure Intent Protocol (draft-goswami-agentic-jwt-00)](https://datatracker.ietf.org/doc/draft-goswami-agentic-jwt/)
- [Goswami, "Agentic JWT: A Secure Delegation Protocol for Autonomous AI Agents" (arXiv:2509.13597)](https://arxiv.org/abs/2509.13597)
