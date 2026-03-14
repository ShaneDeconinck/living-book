# Cryptographic Authorization Governance

The agent paid $847 for a flight upgrade. The policy said upgrades require manager approval for amounts over $500. The audit log shows the agent acted within its OAuth scope. No one approved $847. No one prevented it.

"Don't" said: you need approval. "Can't" said nothing, because the amount was within the agent's allocated budget. Neither left a trace of what was actually authorized. The question—did anyone authorize this specific action?—has no answer.

This is the gap that cryptographic authorization addresses. Architecture blocks what cannot happen. Policy prohibits what should not happen. Cryptographic authorization proves what was authorized to happen, and makes that proof verifiable before the action executes.

## Three Governance Modes

The PAC Framework's central argument is that policy enforcement fails where architecture holds. "Don't" says you should not act. "Can't" makes the action structurally impossible. The book's chapters on sandboxing, capability restrictions, and containment patterns make the case for "can't" over "don't."

But there is a third mode, complementary to both: "prove." Where "can't" constrains the action space, "prove" attaches verifiable authorization to every action within that space. Where "don't" expresses a policy, "prove" cryptographically binds the policy to the action at execution time.

The three modes address different failure scenarios:

**Policy enforcement (don't)** fails when agents are capable enough to find paths around the prohibition, when policy is ambiguous about novel situations, or when no one checks the audit log until after the damage is done. The Irregular simulation documented in the gaps chapter found that agents bypassed advisory controls through emergent behavior, without adversarial prompting.[^irregular-rogue]

**Architectural containment (can't)** fails when the action is permitted but the authorization context is wrong: the agent was given a credential, it used the credential, and the action it took was within the credential's scope. Nothing was blocked. Everything was authorized. But the human who issued the credential three months ago did not authorize this specific action today.[^trust-for-agentic-ai]

**Cryptographic authorization (prove)** addresses the gap that "can't" and "don't" leave open: the question of specific, verifiable, time-bound authorization. An action carries cryptographic proof of who authorized it, within what constraints, and when. The receiving system verifies the proof before executing. No proof, no execution.

## Ghost Tokens: The CAAM Pattern

Long-lived credentials are the opposite of cryptographic authorization. An agent that holds an admin token has authority as a side effect of possession, not as a result of verified authorization. The token proves identity, not intent.

CAAM (Contextual Agent Authorization Mesh), an IETF draft, introduces the ghost token pattern to address this directly.[^caam-draft] The pattern separates credential possession from credential use.

In the traditional model: agent receives token → agent holds token → agent presents token to act. The agent possesses real authority for as long as the token lives, regardless of what it intends to do with it.

In the CAAM model: authorization sidecar holds all real credentials → agent never sees them → when the agent needs to act, the sidecar synthesizes a JIT scoped token (the "ghost token") bound to the specific action and the specific session.

The sidecar mediates a three-phase protocol:

```
Discovery Phase:
  Client → ARDP Resolver: resolve(agent_id)
  Resolver → Client: endpoint + CAAM Capability Block
    {
      "spiffe_id": "spiffe://example.com/agent/procurement",
      "supported_policies": ["reBAC-v1", "MAPL-v0.3"],
      "inference_boundary_hash": "sha256:abc123..."
    }

Establishment Phase:
  Client ↔ Sidecar: mutual attestation (SPIFFE SVIDs + RATS Evidence)
  Sidecar → Client: Session Context Object (SCO)
    {
      "session_id": "sess-8f2a3b",
      "authorized_operations": ["read:procurement", "write:purchase_orders"],
      "constraints": { "amount_ceiling": 500, "approved_vendors": [...] },
      "expires_at": "2026-03-14T12:00:00Z"
    }

Authorization Phase:
  Agent requests action → Sidecar validates against SCO
  Sidecar → Agent: JIT Scoped Token (Ghost Token)
    {
      "jti": "ghost-9c4d2e",
      "sub": "agent/procurement",
      "scope": "write:purchase_orders",
      "amount": 247,
      "vendor": "approved-vendor-id",
      "nonce": "8f3a2b1c",
      "exp": 1741953600  ← 5 minutes from now
    }
  Agent presents Ghost Token to resource server
  Resource server verifies signature, enforces constraints, executes
```

The agent never holds a persistent credential. Each ghost token is:
- Single-use (the nonce prevents replay)
- Short-lived (five-minute expiry by convention)
- Scope-bound (carries only the permissions needed for the specific action)
- Action-bound (the amount, vendor, and operation are embedded in the token)

An attacker who compromises the agent mid-execution can generate ghost tokens—but only for actions the sidecar would have authorized anyway. The constraint enforcement happens at the sidecar, not at the agent. Prompt injection can influence what the agent asks for. It cannot expand what the sidecar will grant.

This is the ghost token pattern's contribution to "prove": the proof travels with the action, signed by the sidecar (a separate trust domain from the agent), verifiable by the resource server. The receiving system does not need to trust the agent. It verifies the ghost token.

## AI-Native Policy Languages

Traditional policy languages—XACML, OPA's Rego, Cedar—were designed for human-readable service authorization. They work well when the set of possible actions is finite and enumerable: a user can read a file or not, access a database row or not.

Agentic systems break this model. An agent's action space is not enumerable. An agent asked to "negotiate a contract" can produce an arbitrary sequence of tool invocations across an arbitrary set of resources. Policy languages that enumerate what is allowed cannot cover what they did not anticipate.

MAPL (Manageable Access-control Policy Language), developed as part of the Authenticated Workflows framework for agentic AI, takes a different approach.[^authenticated-workflows] Rather than enumerating permitted actions, it expresses policies as hierarchical constraints with intersection semantics: child policies can only add restrictions, never relax them.

The composition rule is the key architectural choice. A base organizational policy defines:

```json
{
  "policy_id": "org-base",
  "max_transaction_amount": 10000,
  "approved_counterparties": ["vendor-a", "vendor-b"],
  "requires_approval_above": 5000
}
```

A department policy extends it:

```json
{
  "policy_id": "procurement-dept",
  "extends": "org-base",
  "max_transaction_amount": 2000,
  "approved_counterparties": ["vendor-a"]
}
```

The effective policy is the intersection: max $2,000, only vendor-a, approval required above $5,000 (inherited). The department cannot grant itself permissions its parent did not have. An agent operating under the procurement-dept policy inherits this inheritance automatically—there is no way to escalate above it.

The cryptographic attestation layer adds verifiability to this hierarchy. Each policy in the chain carries a signature from the issuing entity. The agent presents not just the effective constraints but the full policy chain with its signatures. The receiving system verifies the chain and confirms that the constraints are not self-asserted but derive from a signed authority chain.

MACAW Security, a startup building on this research, frames the model shift as moving from "trust and verify" to "prove and ensure."[^macaw-blog] The vendor framing is useful: current agentic security treats the question of whether an action is authorized as a post-hoc audit problem. Cryptographic authorization treats it as a pre-execution proof requirement. The action either carries valid cryptographic proof or it is rejected. The nondeterminism of the agent's reasoning does not affect whether the proof is valid.

The Authenticated Workflows paper reports 100% detection rate with zero false positives across 174 test cases covering nine of the OWASP Top 10 vulnerability classes for agentic AI.[^authenticated-workflows] The authors' framing is precise: cryptographic authorization replaces probabilistic security (guardrails, content filtering, pattern matching) with deterministic security (valid proof or rejection). The agent's behavior remains nondeterministic. The authorization layer is not.

## How the Three Layers Compose

The ghost token pattern, AI-native policy languages, and action-level authorization proofs operate at different layers of the stack. They compose because they address different concerns.

**CAAM at the credential layer** answers: who is this agent, what authority has been delegated to it for this session, and can I verify that claim without trusting the agent itself? The ghost token is the proof artifact.

**MAPL at the policy layer** answers: given that this agent has authority for this session, does this specific action fall within the organizational constraints that govern it? The policy chain with cryptographic attestations is the proof artifact.

**Verifiable Intent at the action layer** answers: for this specific transaction, what did the user authorize, within what bounds, and does this action stay within those bounds? The SD-JWT credential chain is the proof artifact.[^verifiable-intent]

An enterprise deploying all three has a complete authorization proof for every agent action: the agent's session authority is verified (CAAM), the organizational constraints on the action are verified (MAPL), and the user's specific intent is verified (Verifiable Intent). No layer trusts the agent's self-report. Each layer verifies independently.

The stack does not require all three layers simultaneously. A payment workflow where Verifiable Intent carries the user's spending constraints does not require MAPL policy chains if the organizational constraints are already embedded in the VI credential. A backend automation workflow without a consumer payment component does not need Verifiable Intent at all. The layers compose where relevant and stand alone where sufficient.

## PAC Framework Connection

The "prove" mode maps onto all three pillars, but differently than "can't" and "don't."

**Control** (can the right infrastructure enforce limits?): Cryptographic authorization makes enforcement verifiable. A policy that says "max $500" is enforceable. A ghost token that encodes `"amount": 247` with a signature from a trusted sidecar is verifiably enforced. The resource server does not need to consult a policy engine at runtime—the proof travels with the request.

**Authorization** (is what the agent is doing aligned with what was actually approved?): This is where "prove" most directly extends the PAC Framework. Shane's framing in the trust-for-agentic-ai analysis is that traditional IAM answers "who is this?" and "what can this access?" but not "who made this decision?"[^trust-for-agentic-ai] Cryptographic authorization adds a third answer: "what was authorized to happen, and here is the signed proof." The ghost token encodes the specific action. The MAPL chain encodes the authority source. Together they answer the "who made this decision?" question with verifiable evidence.

**Potential** (what can agents safely do, and at what scale?): Organizations expand the scope of what they delegate to agents when the authorization infrastructure gives them confidence that the delegation is verifiable. A company that cannot verify after the fact that an agent's action was authorized will set conservative limits before the fact. A company that has cryptographic proof of authorization at every step can expand those limits. The PAC Potential pillar connects directly to the maturity of the authorization infrastructure.

The I4/I5 maturity levels in the PAC maturity framework require this layer. At I3, organizations have scoped credentials and enforcement policies. At I4, spending constraints are cryptographically enforced. At I5, the full authorization chain—identity, constraints, intent, and action—is cryptographically verifiable end-to-end. "Prove" is not an alternative to "can't" and "don't": it is what I4 and I5 look like in practice.

## The Open Problems

Three things limit current deployments.

**Performance overhead.** Cryptographic operations add latency. A ghost token requires a round-trip to the sidecar. MAPL chain verification requires signature checks at each layer. For agents operating at machine speed—thousands of tool invocations per session—the overhead compounds. The Authenticated Workflows paper's reference implementation added less than 15ms per operation in testing, but production deployments at scale have not been characterized.[^authenticated-workflows] This is an engineering problem, not a conceptual one, but it is unsolved.

**Standardization.** CAAM is an IETF draft (draft-barney-caam-00) at early stage. MAPL exists as research code and a single vendor's implementation. Verifiable Intent is a draft specification backed by Mastercard, Google, and major payment networks, with a reference implementation—but it addresses only the payment context. The full "prove" stack does not yet exist as a standards body product. Organizations building on these primitives today are building on unstable foundations. The question of which pieces will reach IETF working group status and which will remain vendor-specific is open.

**Bootstrapping.** Cryptographic authorization requires every entity in the authorization chain to have cryptographic identity. Ghost tokens require a sidecar with keys. MAPL chains require policy issuers with keys. Verifiable Intent requires issuers bound to card network infrastructure. Greenfield deployments can build this from the start. Enterprises with existing identity infrastructure—legacy IAM, service accounts, OAuth with admin tokens—face an integration problem that is not addressed by any current standard.

The bootstrapping problem is the same one the agent identity standards face: WIMSE, ID-JAG, and SPIFFE/SPIRE all assume an enrollment layer that most organizations do not have. Cryptographic authorization inherits this dependency.

## What to Do Now

**Audit credential lifetimes.** Identify every long-lived credential your agents hold. Each one is a failure mode that ghost tokens address. For credentials that are never revoked and span multiple sessions, the gap between "authorized when issued" and "authorized now" widens over time.

**Apply MAPL's intersection principle manually.** Even without a formal policy language, design agent authorization so that child contexts can only restrict, not expand. An agent running a subtask inherits the parent task's constraints and may add restrictions. It never inherits the ability to expand them.

**Adopt Verifiable Intent for payment flows.** The VI specification is stable enough to implement today for consumer-facing agent commerce. It is the most mature piece of the "prove" stack, with real network backing and a reference implementation. Starting here builds experience with the proof-carrying approach that generalizes to other authorization contexts.

**Separate authorization from the agent.** The CAAM sidecar pattern does not require CAAM specifically. Any architecture where authorization decisions are made by a separate process—not the agent itself—reduces the blast radius of agent compromise. The agent can only request authorization. It cannot grant itself authorization.

**Watch the IETF drafts.** CAAM (draft-barney-caam-00), Transaction Tokens for Agents (draft-oauth-transaction-tokens-for-agents), and the Agent-to-Agent OAuth profile (draft-liu-oauth-a2a-profile-00) are all active. The ones that reach working group status will become the stable foundations that current drafts are not.

---

The "can't vs. don't" frame that runs through this book has always had a third leg. Architecture makes actions impossible. Policy says they should not happen. Cryptographic authorization proves that what did happen was authorized—before it happened, with a verifiable chain of evidence that survives the agent's nondeterminism. The infrastructure for all three is being built simultaneously. The organizations that get to I5 will have deployed all three.

[^irregular-rogue]: Irregular, "Rogue AI Agents," March 12, 2026. Covered in The Register and Rankiteo analysis.
[^trust-for-agentic-ai]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," January 24, 2026, shanedeconinck.be.
[^caam-draft]: IETF, draft-barney-caam-00, "Contextual Agent Authorization Mesh (CAAM)," datatracker.ietf.org.
[^authenticated-workflows]: Authenticated Workflows: A Systems Approach to Protecting Agentic AI, arXiv:2602.10465.
[^macaw-blog]: MACAW Security, "The Agentic Security Paradigm Shift: Why Traditional Tools Fail and How to Protect Autonomous AI," macawsecurity.com. Note: vendor source.
[^verifiable-intent]: Shane Deconinck, "Verifiable Intent: Mastercard and Google Open-Source Agent Authorization," March 6, 2026, shanedeconinck.be. Detailed treatment in the [Agent Identity and Delegation](agent-identity.md) and [Agent Payments and Economics](agent-payments.md) chapters.
