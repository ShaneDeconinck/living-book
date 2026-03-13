# Multi-Agent Trust and Orchestration

Every chapter in this book so far has examined trust through the lens of a single agent: one agent, one identity, one delegation chain, one set of permissions. That is already hard. But it is not where the industry is heading.

Salesforce's 2026 Connectivity Benchmark found that organizations already run an average of 12 agents, with adoption projected to surge 67% by 2027.[^1] Deloitte predicts 75% of companies will invest in agentic AI by end of 2026, fueling an autonomous agent market worth $8.5 billion.[^2] The problem: 50% of those agents operate in isolated silos.[^1] They do not compose. They do not share trust context. They do not fail gracefully when one goes wrong.

This chapter examines what happens when agents delegate to other agents: how trust properties compose, how failures cascade, and what infrastructure is required to make multi-agent systems governable rather than just functional.

## The Delegation Problem

Shane has been precise about this from the start: agents do not forward intent, they create it.[^3] In a single-agent system, that creation happens once. The agent interprets a user's instruction and acts. The delegation chain is short: human to agent to action.

In a multi-agent system, delegation chains lengthen. A planning agent delegates a subtask to a research agent, which queries a data agent, which calls a tool agent. Each hop creates new intent. Each hop attenuates (or should attenuate) authority. Each hop crosses a trust boundary, even within the same organization.

Google DeepMind's February 2026 paper on intelligent delegation makes this precise.[^4] They describe delegation not as simple task decomposition but as a structured transfer of authority and responsibility requiring five properties:

1. **Dynamic assessment**: evaluating whether the delegatee has the capabilities and resources to complete the task
2. **Adaptive execution**: adjusting delegation decisions as conditions change
3. **Structural transparency**: monitoring and audit trails that make delegation chains visible
4. **Scalable coordination**: market-like mechanisms for matching tasks to agents at scale
5. **Systemic resilience**: preventing single-point failures from cascading through the network

The critical insight is that delegation in multi-agent systems is not an optimization problem (how to split work efficiently). It is a governance problem (how to transfer authority safely). DeepMind frames it explicitly: "without formal rules for authority, accountability and trust, that shift could introduce systemic risks as serious as any model error."[^4]

This maps directly to the PAC Framework. Dynamic assessment is Potential (does this agent have the capability?). Structural transparency is Accountability (can you trace what happened?). Systemic resilience is Control (can you contain failures?). All three pillars must hold at every delegation hop, not just at the entry point.

## Trust Does Not Compose By Default

The deepest problem with multi-agent systems is that trust properties that hold for individual agents do not automatically hold for their composition.

Consider a simple two-hop chain: Agent A is authorized to manage travel expenses up to $5,000. Agent A delegates flight booking to Agent B. Agent B is a well-evaluated, sandboxed tool with its own access controls. Both agents, individually, satisfy reasonable governance requirements.

But the composition introduces problems that neither agent alone creates:

**Authority amplification.** If Agent B has access to a corporate credit card for its own purposes, and Agent A delegates a booking task, does Agent B use its own credit line or Agent A's delegated authority? Without explicit authority propagation, the answer depends on implementation details that no governance framework reviewed.

**Accountability gaps.** When the $5,200 charge appears, who is responsible? Agent A exceeded its budget. Agent B executed the transaction. The human who authorized Agent A never authorized Agent B. The audit trail shows each agent acted within its own constraints, but the system-level outcome violated the human's intent.

**Trust transitivity.** Agent A trusts Agent B. Agent B trusts Agent C (a third-party pricing API). Does Agent A therefore trust Agent C? In most current implementations, yes, implicitly. This transitive trust is exactly the pattern that caused the Drift breach: one compromised integration inherited trust across 700 organizations.[^5]

The IACR paper "Trustworthy Agent Network" published in March 2026 argues that this composability gap is fundamental, not incidental.[^6] The authors contend that trustworthiness of agent-to-agent networks "cannot be fully guaranteed via retrofitting on existing protocols that are largely designed for individual agents. Instead, it must be architected from the very beginning of the A2A coordination framework."[^6]

Shane's trust inversion applies here with compounded force.[^7] A single agent requires the inverse of human trust: restricted to what it can do, not what it cannot. A multi-agent system requires trust inversion at every boundary, with the additional constraint that the trust envelope must be verifiable end-to-end across agents that may not share infrastructure, identity providers, or even organizational affiliation.

## Cascading Failures

When trust breaks in a single-agent system, the blast radius is bounded by that agent's permissions. When trust breaks in a multi-agent system, failures cascade.

OWASP's Top 10 for Agentic Applications identifies cascading failures as ASI08: "a single fault, such as a hallucination, prompt injection, or corrupted data, propagates across multiple autonomous AI agents, amplifying into system-wide harm."[^8] Unlike traditional software errors that stay contained by error boundaries and circuit breakers, agentic cascading failures multiply through agent-to-agent communication, shared memory, and feedback loops.

Galileo AI's research on multi-agent system failures quantified this.[^9] In simulated multi-agent systems, a single compromised agent poisoned 87% of downstream decision-making within four hours. The mechanism: one specialized agent begins hallucinating or is compromised, feeds corrupted data to downstream agents, and those downstream agents, trusting the input, make flawed decisions that amplify the error across the system. The chain of reasoning is opaque: you see the final bad decision but cannot easily rewind to find which agent introduced the corruption.

This failure pattern has three properties that make it harder than cascading failures in traditional distributed systems:

**Semantic propagation.** In traditional systems, corrupted data typically causes crashes or type errors: visible failures. In agent systems, corrupted data produces plausible but wrong conclusions. Downstream agents treat them as valid inputs. The failure mode is confidence in incorrect output, not system breakdown.

**Feedback amplification.** Agents with shared memory or iterative communication loops can reinforce errors. Agent A writes a conclusion to shared state. Agent B reads it, incorporates it, and writes its own (now-corrupted) conclusion. Agent A reads Agent B's output on the next iteration, confirming its original error. The system converges on a wrong answer with increasing confidence.

**Opacity.** Traditional distributed systems have deterministic control flow. You can trace a request through a service mesh and identify where it went wrong. Multi-agent systems have non-deterministic control flow because agents decide what to do next. The delegation chain is not predetermined: it emerges from the agents' reasoning. Debugging requires reconstructing decisions, not just tracing function calls.

Broader studies document failure rates of 41% to 86.7% in multi-agent systems without proper orchestration.[^9] The gap between "works in a demo" and "works in production" is primarily a governance gap, not a capability gap.

## Delegation Capability Tokens

How do you encode trust across multi-hop delegation chains? The DeepMind paper proposes a specific technical mechanism: Delegation Capability Tokens (DCTs) based on macaroons.[^4]

Macaroons, introduced by Google in 2014, are bearer credentials with a distinctive property: anyone holding a macaroon can attenuate it by adding caveats (restrictions) but cannot remove caveats or expand authority.[^10] This maps naturally to delegation chains where authority must only decrease, never increase: exactly the principle Shane describes as fundamental to agent trust.[^3]

A DCT for a multi-agent delegation chain works like this:

```
# Root macaroon: user authorizes Agent A
{
  "identifier": "delegation-root-7f3a",
  "location": "agent-a.company.com",
  "caveats": [
    {"type": "budget", "max_usd": 5000},
    {"type": "scope", "actions": ["book_travel", "search_flights"]},
    {"type": "expiry", "not_after": "2026-03-13T00:00:00Z"}
  ]
}

# Agent A delegates to Agent B, adding caveats
{
  "identifier": "delegation-hop1-9b2c",
  "location": "flight-booking-agent.travel.com",
  "caveats": [
    {"type": "budget", "max_usd": 5000},
    {"type": "scope", "actions": ["book_travel", "search_flights"]},
    {"type": "expiry", "not_after": "2026-03-13T00:00:00Z"},
    # Agent A's added caveats:
    {"type": "budget", "max_usd": 2000},
    {"type": "scope", "actions": ["search_flights"]},
    {"type": "carrier", "allowed": ["United", "Delta"]},
    {"type": "delegation_depth", "remaining": 1}
  ]
}
```

Each delegation hop can only add restrictions. Agent A cannot give Agent B a $10,000 budget from a $5,000 authorization. The token is self-verifying: any party in the chain can confirm that the caveats were added by authorized holders without contacting the original issuer. This is offline verification, critical for multi-agent systems where round-trips to an authentication server at every hop would be prohibitively slow.

The related Biscuit token format extends macaroons with Datalog-based attenuation, allowing richer policy expressions.[^4] Where macaroons support simple key-value caveats, biscuits can express policies like "may read any file in /data/ but may only write to /data/drafts/ and only if the request originated from a planning agent."

Both approaches enforce what the PAC Framework calls decreasing authority in delegation chains.[^11] The cryptographic structure makes authority attenuation verifiable by any participant. No central authority is needed to validate the chain. This is the structural enforcement that Shane argues must replace advisory controls: the token format makes authority expansion mathematically impossible, not just policy-prohibited.[^7]

## The Orchestration Governance Gap

Deloitte's 2026 prediction is stark: only one in five companies has a mature governance model for agentic AI, even as 75% plan to invest in it by year's end.[^2] For multi-agent orchestration, the governance gap is wider still.

Current orchestration frameworks (LangGraph, CrewAI, AutoGen, and their successors) focus on capability: how to decompose tasks, assign agents, and combine results. They are good at the Potential pillar. They are thin on Accountability and Control.

A typical multi-agent orchestration pattern looks like this:

```
Planner Agent
  → Research Agent → [Web Search Tool, Database Tool]
  → Analysis Agent → [Spreadsheet Tool, Code Executor]
  → Writer Agent → [Document Editor, Email Tool]
```

The orchestration framework manages task assignment and result collection. But governance questions remain open:

**Who authorized each delegation?** The planner agent decides to delegate to the research agent. That is a decision with authority implications. Current orchestration frameworks treat it as a function call, not an authorization event.

**What happens when an agent fails mid-chain?** If the analysis agent hallucinates a conclusion that the writer agent incorporates into a customer-facing email, the damage is done before any monitoring catches it. There is no circuit breaker between agents that operates on semantic correctness, only on technical failures.

**How do you audit across the chain?** Each agent may log its own actions, but no current orchestration framework produces a unified delegation audit trail that traces authority from the human through every agent decision to the final action.

**Where does liability sit?** When a multi-agent system makes a consequential error, the liability question is harder than for a single agent. The EU AI Act's provider/deployer distinction was designed for individual AI systems, not for chains of agents from different providers executing delegated authority.[^12]

The Salesforce data makes the organizational dimension concrete: 50% of agents operate in silos.[^1] That means half of enterprise agents are already multi-agent systems in practice (they interact with other agents through shared databases, APIs, or workflows) without any of the governance infrastructure to manage that interaction. They are multi-agent systems without multi-agent governance.

## Architectural Patterns for Multi-Agent Trust

Several patterns are emerging for making multi-agent systems governable. None is complete. All are young.

### Hierarchical Delegation with Authority Attenuation

The simplest model: a root agent delegates to child agents, which may delegate further. Authority decreases at every level. This is the DCT model described above.

Strengths: clear authority chain, verifiable attenuation, auditable.

Weaknesses: assumes a tree structure. Real multi-agent interactions are often graphs: Agent A delegates to Agent B, which calls Agent C, which calls back to Agent A with different authority. Cycles break the clean hierarchy.

### Trust Boundaries with Circuit Breakers

Borrowed from microservice architecture: treat each agent as a service with an explicit trust boundary. Implement circuit breakers that halt delegation when failure indicators exceed thresholds.

The OWASP ASI08 mitigation guidance recommends this layered approach:[^8]

1. **Architectural isolation**: trust boundaries between agent groups, limiting blast radius
2. **Runtime verification**: multi-agent consensus checks and ground truth validation before acting on delegated outputs
3. **Observability**: automated cascade pattern detection with kill switches

The challenge: circuit breakers in traditional systems trip on measurable signals (latency, error rates). In agent systems, the failure signal is semantic: the output looks plausible but is wrong. Runtime verification that catches semantic failures without unacceptable latency is an open research problem.

### Delegation Registries

An extension of the agent registry pattern from the Shadow Agent Governance chapter. A delegation registry does not just track which agents exist but which delegation relationships are authorized, with what scope, and under what conditions.

```json
{
  "delegation_id": "del-2026-0312-a7f3",
  "delegator": "agent:planner-v3@company.com",
  "delegatee": "agent:research-v2@company.com",
  "authority_scope": {
    "actions": ["web_search", "database_query"],
    "data_classification": ["public", "internal"],
    "budget_usd": 50
  },
  "constraints": {
    "max_delegation_depth": 1,
    "requires_verification": true,
    "expiry": "2026-03-12T18:00:00Z"
  },
  "authorized_by": "user:alice@company.com",
  "created": "2026-03-12T09:00:00Z"
}
```

This makes delegation an auditable, queryable infrastructure concern rather than an implicit function of the orchestration framework. It addresses the accountability gap: every delegation is recorded with who authorized it, what scope it carries, and when it expires.

### PIC for Multi-Agent Chains

The Cross-Organization Trust chapter covered PIC (Provenance, Identity, Continuity) as a mechanism for cross-boundary trust. PIC's value compounds in multi-agent systems because it answers the question that tokens cannot: can this authority validly continue through this chain?[^13]

Where DCTs encode what authority an agent has, PIC verifies that the chain of delegation that produced that authority is unbroken. A downstream agent does not just check "does this token have the right caveats?" but "can I verify that each delegation in this chain was performed by an agent with the authority to delegate?"

PIC's mathematical elimination of the confused deputy problem becomes critical in multi-agent systems where the confused deputy risk multiplies with every hop. At delegation depth three, there are three potential confused deputy scenarios. At depth five, there are five. PIC's proof of continuity addresses all of them structurally.

## When Agents Fail: Incident Response for Multi-Agent Systems

The Coalition for Secure AI (CoSAI) released its AI Incident Response Framework, Version 1.0, adapting the NIST incident response lifecycle specifically for AI systems.[^14] The framework includes CACAO-standard playbooks with detection methods, triage criteria, containment steps, and recovery procedures for AI-specific attack categories: prompt injection, data poisoning, unauthorized automation, excessive privilege use, and tool abuse.

For multi-agent systems, incident response differs from single-agent failures in three ways:

**Blast radius assessment is harder.** When one agent in a chain is compromised, determining which downstream decisions were affected requires tracing delegation chains across agents that may log in different systems, use different identity providers, and operate in different organizations. The CoSAI framework emphasizes capturing AI-specific telemetry: prompt logs, model inference activity, tool executions, and memory state changes.[^14] For multi-agent systems, this telemetry must also capture delegation events: who delegated to whom, with what authority, and what the delegatee actually did.

**Containment requires coordinated action.** Revoking a compromised agent's credentials is not sufficient if downstream agents have already acted on its outputs. Containment in multi-agent systems means: stop the compromised agent, identify all agents that received its outputs, evaluate whether those outputs corrupted downstream decisions, and potentially roll back actions across the chain. This is closer to distributed transaction rollback than traditional incident response.

**Root cause is frequently a governance failure.** The agent-specific incident categories CoSAI identifies (tool abuse, hidden instructions, retrieval failures, drift) are often symptoms of insufficient delegation controls. An agent that abuses a tool was given access it should not have had. An agent that follows hidden instructions lacked input validation at a trust boundary. Root cause analysis in multi-agent systems typically leads back to a missing governance control, not a model bug.

## Mapping to PAC

Multi-agent trust touches all three pillars at compound scale.

| PAC Dimension | Single-Agent | Multi-Agent Compound Effect |
|---|---|---|
| **Potential: Business Value** | Individual task automation | Workflow automation across capabilities no single agent has |
| **Potential: Composability** | Tool integration | Agent-to-agent delegation and orchestration |
| **Accountability: Delegation Chains** | Human → Agent | Human → Agent₁ → Agent₂ → ... → Agentₙ |
| **Accountability: Audit Trails** | Agent action logs | Cross-agent delegation traces with authority provenance |
| **Accountability: Liability** | Provider or deployer | Distributed across chain; potentially across organizations |
| **Control: Identity** | Agent identity + user identity | Identity at every delegation hop, verifiable end-to-end |
| **Control: Authorization** | Scoped permissions | Authority attenuation across delegation chain |
| **Control: Containment** | Sandbox per agent | Circuit breakers between agents, cascade prevention |
| **Control: Cross-Org** | Bilateral trust | Transitive trust across multi-party delegation chains |

The key PAC insight for multi-agent systems: **governance cost scales with delegation depth, not just agent count.** An organization with 12 agents that all report to humans has 12 governance relationships to manage. The same 12 agents orchestrated into delegation chains have potentially 12! (factorial) governance relationships. The infrastructure must scale accordingly.

## Infrastructure Maturity for Multi-Agent Trust

Building on the I1-I5 infrastructure maturity scale used throughout this book:

**I1 (Open): Ad Hoc.** Multi-agent systems exist but delegation is implicit. Agents call other agents as tools without authority tracking. No delegation audit trail. Failure in one agent is debugged as a standalone issue. This is where most organizations are today.

**I2 (Logged): Basic Coordination.** Orchestration frameworks manage task assignment. Basic logging of which agent did what. No authority attenuation. Blast radius of agent failure is understood qualitatively but not enforced technically.

**I3 (Verified): Governed Delegation.** Delegation registries track authorized agent-to-agent relationships. Authority attenuation (DCTs or equivalent) ensures permissions decrease at each hop. Circuit breakers between agent trust boundaries. Unified audit trails across delegation chains. Incident response playbooks address multi-agent failures.

**I4 (Authorized): Verified Composition.** Authority provenance is cryptographically verifiable across delegation chains (PIC or equivalent). Runtime semantic verification catches cascading errors before propagation. Delegation policies are machine-enforceable, not advisory. Cross-organization delegation chains are supported with end-to-end trust verification.

**I5 (Contained): Adaptive Trust.** Dynamic trust assessment adjusts delegation authority based on observed agent behavior. Reputation systems inform delegation decisions. Automated cascade detection and containment. Multi-agent systems self-govern within externally auditable bounds.

The gap between I1 (where most organizations are) and I3 (where regulated industries need to be by August 2026 for the EU AI Act) is significant. The gap between I3 and I5 is the research frontier.

## Practical Recommendations

**Start with delegation visibility.** Before governing multi-agent delegation, you need to see it. Instrument orchestration frameworks to log delegation events: who delegated to whom, with what scope, and what the outcome was. This is the multi-agent equivalent of the agent registry in the Shadow Agent Governance chapter.

**Enforce authority attenuation.** Implement DCTs or equivalent mechanisms that make authority expansion impossible at the token level. If your orchestration framework does not support this, add a delegation gateway that validates authority scope at every hop.

**Design for cascading failure.** Assume that any agent in a chain can fail or be compromised. Implement trust boundaries between agent groups with circuit breakers. Require verification of outputs at trust boundaries, not just at the final step. The OWASP ASI08 mitigation stack (architectural isolation, runtime verification, observability) is the baseline.[^8]

**Build multi-agent incident response playbooks.** Standard incident response assumes the compromised system stopped doing damage when you revoked its access. Multi-agent incident response must also address: what did downstream agents do with this agent's outputs? Were those outputs persisted in shared memory? Did any downstream agent delegate further based on corrupted input? CoSAI's CACAO-standard playbooks are a starting point.[^14]

**Audit delegation chains, not just agent actions.** Individual agent audit logs are necessary but not sufficient. Multi-agent governance requires end-to-end delegation traces that connect the human's original authorization through every agent decision to the final action. This is the accountability chain that the PAC Framework demands.

**Plan for the graph, not the tree.** Real multi-agent interactions form graphs with cycles, shared resources, and dynamic topology. Design governance infrastructure that handles cycles (Agent A delegates to Agent B, which calls back to Agent A with different authority) and shared state (multiple agents writing to the same memory or database). Hierarchical models are a starting point, not the destination.

[^1]: Salesforce, "Connectivity Benchmark Report 2026" (in collaboration with Vanson Bourne and Deloitte Digital, February 2026). Survey of 1,050 IT leaders across nine countries.

[^2]: Deloitte, "Unlocking Exponential Value with AI Agent Orchestration," TMT Predictions 2026. Projects autonomous agent market at $8.5 billion by 2026, potentially $45 billion by 2030 with effective orchestration.

[^3]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," trustedagentic.ai, January 24, 2026.

[^4]: Nenad Tomašev, Matija Franklin, and Simon Osindero, "Intelligent AI Delegation," Google DeepMind, arXiv:2602.11865, February 12, 2026.

[^5]: Cloud Security Alliance, "AI Agents Have Outgrown Their Credentials: Why Drift's Breach Changes Everything," CSA Research, 2026. Documented in the Cross-Organization Trust chapter.

[^6]: Yixiang Yao et al., "Trustworthy Agent Network: Trust in Agent Networks Must Be Baked In, Not Bolted On," IACR ePrint Archive 2026/497, March 2026.

[^7]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," trustedagentic.ai, February 3, 2026.

[^8]: OWASP, "Top 10 for Agentic Applications," ASI08: Cascading Failures, December 2025.

[^9]: Galileo AI, "Multi-Agent AI System Failures and Prevention," research findings December 2025. Found 87% downstream decision poisoning within four hours from a single compromised agent in simulated multi-agent systems.

[^10]: Arnar Birgisson et al., "Macaroons: Cookies with Contextual Caveats for Decentralized Authorization in the Cloud," Google Research, NDSS 2014.

[^11]: Shane Deconinck, "The PAC Framework," trustedagentic.ai, 2026. Control pillar: "When agents delegate, does authority only decrease, never expand?"

[^12]: EU AI Act, Articles 4, 6, 9, 28; risk classification and provider/deployer obligations for AI systems.

[^13]: Nicola Gallo, PIC (Provenance, Identity, Continuity) paradigm, presented at LFDT Belgium meetup, March 2026. Documented in the Cross-Organization Trust chapter.

[^14]: Coalition for Secure AI (CoSAI), "AI Incident Response Framework, Version 1.0," OASIS Open Project, 2026. Includes CACAO-standard playbooks for AI-specific incident categories.
