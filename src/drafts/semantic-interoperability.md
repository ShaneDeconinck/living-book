# Semantic Interoperability for Agents

An agent authorized to "close a deal" crosses an organizational boundary. On the sending side, the authorization means: sign, reject, or renegotiate. On the receiving side, "close a deal" means only: sign or reject. The agent renegotiates. The counterparty's system rejects the action as unauthorized. Neither agent is operating outside its granted authority. Both are operating under valid delegations with incompatible interpretations of what those delegations mean.

This is the semantic interoperability problem. Identity infrastructure tells you *who* the agent is. Authorization infrastructure tells you *what* the agent is allowed to do. Semantic interoperability tells you what the allowed actions actually *mean* when they cross an organizational boundary. Without it, identity and authorization solve the transport problem while leaving the interpretation problem untouched.

## Identity Is Solved. Authority Is Advancing. Semantics Are Not.

The agent identity landscape has moved substantially. DIDs give agents verifiable identifiers. TSP provides authenticated, encrypted channels across organizational boundaries. Verifiable credentials let delegations travel with cryptographic proof. WIMSE, ID-JAG, and the competing IETF drafts address how workload identity propagates through multi-hop chains. The field disagrees on architecture but agrees on the problem.

Authorization is advancing. PIC's monotonic property — authority can only decrease through a delegation chain — gives cross-organizational authority propagation a mathematical foundation. Cryptographic authorization patterns from MACAW and MAPL make policy enforcement provable rather than advisory. Ghost tokens bind authority to specific agent instances. The infrastructure is nascent but directional.

Semantic interoperability has no equivalent trajectory. There is no active standards effort, no funded vendor ecosystem, and no agreed vocabulary for agent actions across organizational boundaries.

Nicola Gallo flagged this at the LFDT Belgium meetup as a layer that neither TSP nor PIC claims to fully solve.[^lfdt-meetup] "Solving this requires not just identity and authority, but shared understanding of what actions mean across boundaries." The observation has not generated a concrete standards proposal.

## Why Credentials Solved It and Actions Have Not

The W3C Verifiable Credentials data model has a mechanism for semantic interoperability: JSON-LD `@context`. A credential asserting `age_over_18` can include a context URI that resolves to a canonical definition. Two issuers in different jurisdictions using the same context URI mean the same thing. The vocabulary problem is solved by making every attribute resolvable to a shared definition.[^w3c-vc]

This works for credentials because the attribute space is bounded. "Date of birth," "nationality," "professional license status" — these can be enumerated, agreed upon, and published as vocabularies. W3C, ETSI, and sector-specific bodies have done this work. The EUDI wallet framework relies on it.

Agent actions are not bounded. An agent authorized to "manage supplier relationships" might create contracts, initiate payments, schedule deliveries, request credit terms, and flag compliance issues. None of these were enumerated when the agent was authorized. The action space is discovered at runtime, scoped by what the agent encounters, and interpreted against organizational semantics that were never documented because they did not need to be: the humans handling these interactions share enough context.

The EDI parallel is instructive. Electronic Data Interchange spent four decades solving a structurally similar problem: how do you exchange business documents — purchase orders, invoices, shipping notices — when the sender and receiver use different systems with different data models? The solution was schema standards (X12, EDIFACT) agreed by industry consortia, sector by sector, document type by document type. Those standards work, but the scope is narrow: bounded document types, predictable field structure, pre-negotiated trading partner relationships.

Agent actions are none of these things. The combination of dynamic intent, runtime discovery, and open-ended action space means no pre-agreed schema will cover the semantic surface.

## The "Close a Deal" Problem in Practice

The Gallo scenario is not a hypothetical edge case. It is the default condition for any agent operating across enterprise boundaries without prior semantic agreement.[^lfdt-meetup]

Consider procurement. Vendor A deploys an agent authorized to "negotiate purchase terms." Vendor B deploys an agent authorized to "manage supplier relationships." Both agents have cryptographically verified delegations. TSP gives them authenticated channels. PIC guarantees neither can exceed its granted authority. But "negotiate" means different things:

- Vendor A's procurement department defines negotiation as: propose, counter, accept, or escalate to a human.
- Vendor B's supplier relations system defines it as: accept, reject, or request clarification.

The agents exchange proposals. Vendor A's agent counters. Vendor B's agent receives an action type its vocabulary does not recognize. Does it reject? Accept by default? Flag for human review? Escalate?

Each choice produces a different outcome. None of them was the intended behavior of either system. The authorization infrastructure worked correctly throughout.

The problem scales with action complexity. "Book travel" has fewer semantic variants than "restructure a contract." "Request a quote" is more bounded than "approve a payment." But even simple actions carry organizational semantics that are invisible until they cross a boundary.

## What Makes This Hard

Three properties of agent action semantics distinguish this from the credential vocabulary problem.

**Runtime discovery.** Agents discover what actions are available by querying the services they encounter. MCP gives every server the ability to describe its own tools. The agent decides which tools to call based on its authorization, the server's description, and runtime context. This is the capability that makes agents useful: they are not limited to pre-enumerated actions. It is also why pre-agreed vocabularies cannot cover the space.

**Organizational embeddedness.** Action semantics are encoded in organizational practice, not in schemas. What "approve" means in a financial services firm differs from what it means in a construction company, differs from what it means in a hospital. These meanings live in internal documentation, tacit knowledge, and established workflows. They are not documented as machine-readable definitions because humans in those organizations share enough context to interpret them without documentation.

**The cross-domain gap.** Within a single organization, misinterpretations are recoverable. The agent operates in an environment where the organization can observe, intervene, and correct. Across organizational boundaries, the agent has acted by the time the misinterpretation is discoverable. The counterparty's system has recorded the action. Reversibility depends on whether both sides agree on what happened — which they may not, because they did not agree on what the action meant.

## Interim Approaches

The field does not have a general solution. It has three partial responses.

**Natural language constraints with explicit interpretation rules.** Rather than relying on shared vocabulary, agents operating across boundaries can carry explicit prose descriptions of what their authorizations mean. "Close a deal" becomes: "Close a deal, where closing means signing an agreement at or below the offered price, or rejecting the offer. Renegotiation requires escalation to the authorizing human." This is bureaucratic but precise. It shifts the semantic agreement problem from vocabulary standards to delegation documentation. The failure mode is the contract problem: precise prose still requires shared interpretation of the precise prose.

**Human checkpoints at semantic boundaries.** If an agent encounters an action type it has not seen before, or an action whose semantics it cannot verify, pause for human confirmation. This is the HITL pattern applied to semantic uncertainty rather than risk level. It is conservative, but recoverable. An agent that pauses creates an opportunity to resolve the ambiguity. An agent that proceeds creates a fact.

**Domain-specific vocabulary agreements.** For sectors where cross-organizational agent interaction is predictable and high-volume — financial settlement, healthcare referrals, logistics — industry consortia can agree on action vocabularies the way they agreed on EDI schemas. This requires the same slow, negotiated standards process that produced X12 and EDIFACT. The first sector-specific agent vocabularies will likely emerge from industries where the business case for automation is strongest and the organizational relationships are most structured.

None of these is a general solution. Natural language constraints require trust in the interpretation. Human checkpoints limit the autonomy that makes agents valuable. Domain vocabularies require multi-year standards processes. The general case — arbitrary agents, arbitrary organizations, arbitrary action types — remains open.

## Mapping to PAC

| Dimension | The Gap | Implication |
|-----------|---------|-------------|
| **Potential** | Action vocabularies do not exist; agent capabilities are discovered at runtime but interpreted locally | Cross-organizational agents can only be deployed safely where humans validate semantic boundaries |
| **Accountability** | When an agent acts on a misinterpreted authorization, the audit trail shows authorized actions but not misaligned intentions | Accountability requires tracing not just what the agent was authorized to do, but what both parties understood the authorization to mean |
| **Control** | No infrastructure can enforce semantic consistency across organizational boundaries that do not share a vocabulary | Control at the cross-boundary level is currently limited to coarse-grained authorization; fine-grained intent cannot be guaranteed |

## Infrastructure Maturity for Semantic Interoperability

| Level | Potential | Accountability | Control |
|-------|-----------|---------------|---------|
| **I1 (Exposed)** | Agent actions undocumented; cross-org semantics entirely implicit | No mechanism to detect semantic divergence; incidents reconstructed after the fact | No semantic constraints on cross-org actions |
| **I2 (Managed)** | Action types categorized per agent; authorization prose included in delegation documentation | Incidents trigger review of delegation language | Human checkpoints at major semantic boundaries |
| **I3 (Defined)** | Domain-specific action vocabularies for highest-volume cross-org workflows | Semantic disputes logged; retrospective analysis identifies recurring misalignments | Coarse-grained semantic gates block unrecognized action types |
| **I4 (Measured)** | Vocabulary coverage metrics; divergence incidents tracked against open action categories | Audit trails include both sides' interpretation of shared actions | Automated validation for covered vocabulary; human escalation for uncovered types |
| **I5 (Contained)** | Machine-readable action vocabularies shared with counterparties; automated negotiation of vocabulary gaps | Real-time semantic verification with cryptographic proof of vocabulary agreement | Full authorization chain carries semantic constraints; misaligned actions blocked before execution |

Most organizations operating cross-organizational agent workflows are at I1. I3 is achievable today with process investment. I5 requires standards infrastructure that does not yet exist.

## What to Do Now

**Document what your agents mean.** Before deploying agents across organizational boundaries, write explicit prose definitions of every authorization type. "Approve a payment" should specify: up to what amount, through which channels, with what counterparty confirmation required. This documentation is for humans as much as agents — it forces the semantic work that organizations have not had to do before.

**Start with bounded domains.** Identify cross-organizational workflows with the narrowest action vocabularies: scheduling, quote requests, status updates. Deploy agents in these domains first. The semantic surface is small enough to manage manually, and the operational learning will inform how you approach more complex actions.

**Build semantic checkpoints into cross-boundary architectures.** Any agent authorized to take actions across organizational boundaries should have explicit escalation logic for action types it has not encountered before. An agent that pauses is recoverable. An agent that proceeds under semantic ambiguity may not be.

**Track misalignments, not just errors.** Standard incident tracking captures failures: the agent took an unauthorized action, the system rejected the request, the transaction failed. Semantic misalignment produces different signals: the transaction succeeded but produced an unexpected outcome, the counterparty disputed what was agreed, the intent was correct but the execution diverged. Track these separately. They are the evidence base for where vocabulary agreements are most urgently needed.

[^lfdt-meetup]: Shane De Coninck, "Trusted AI Agents by Design: From Trust Ecosystems to Authority Continuity," shanedeconinck.be, March 11, 2026. Reflects on the LFDT Belgium meetup of March 3, 2026. Nicola Gallo's "close a deal" scenario and the conclusion that the semantic layer "remains tractable" once identity and authority are solved are both from this post.
[^w3c-vc]: W3C, "Verifiable Credentials Data Model 2.0," w3.org/TR/vc-data-model-2.0/, February 2025. The JSON-LD `@context` mechanism and its role in semantic interoperability for credential attributes is specified in Section 4.1 and Appendix A.
