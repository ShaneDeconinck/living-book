# Agent Accountability at Scale

An expense-approval agent authorized $47,000 in vendor payments. The audit log showed alice@company.com. Alice was in a meeting. She had delegated authority three months ago.[^trust-for-agentic-ai] One agent, one bad decision, one missing audit trail. The fix is known: dual-identity tokens, structured logs, delegation chain capture.

Now multiply. Three hundred agents across procurement, customer support, HR onboarding, IT operations. Twelve of them share overlapping tool access. One procurement agent triggers a cascading set of approvals across three others. A customer support agent escalates a complaint to an HR agent that triggers an internal investigation. When the CFO asks "who decided?", the answer is not one agent: it is a graph of decisions, delegations, and handoffs that no single audit log captures.

The accountability problem does not scale linearly. It changes in kind.

## The Fleet Threshold

Most organizations building agent systems today are in the single-digit range. A coding assistant, a support triage agent, maybe an internal knowledge bot. Governance at this scale is manageable: a human reviews the agent's setup, monitors its behavior, intervenes when something looks wrong. The shadow agent governance chapter documented the breakpoint: centralized governance works for fewer than 50 agents. Beyond that, review bottlenecks create shadow deployments, and shadow deployments create ungoverned risk.[^shadow-agent-gov]

The industry is heading past that threshold. McKinsey projects thousands of agents per enterprise within five to ten years.[^mckinsey-projection] Microsoft reported that 80% of Fortune 500 companies already use its AI agent infrastructure.[^microsoft-fortune500] Gartner expects 40% of enterprise applications to include agentic capabilities by the end of 2026.[^gartner-prediction] The gap between "we have a few agents" and "we have a fleet" is closing, and it is closing before the accountability infrastructure is ready.

Singapore's Model AI Governance Framework for Agentic AI, launched in January 2026 at Davos, is the first government-level attempt to address this gap.[^singapore-mgf] Its four dimensions (risk bounding, human accountability, technical controls, end-user responsibility) map to the PAC Framework's three pillars. But one requirement stands out: "An agent should have its own unique identity, such that it can identify itself to the organisation, its human user, or other agents. This identity should be linked to a supervising agent, a human user, or an organisational department to enable accountability and tracking."[^singapore-mgf] At scale, this is not a recommendation. It is a prerequisite for every other governance capability.

## Three Problems That Only Emerge at Scale

### Decision Attribution Across Agent Graphs

Individual agent accountability is a solved design problem. RFC 8693 On-Behalf-Of tokens capture both the delegating human and the acting agent.[^rfc-8693] Structured audit logs record agent identity, token scope, action, and timestamp. The [Agent Identity and Delegation](agent-identity.md) chapter covers these patterns.

The unsolved problem is attribution across agent interactions. When Agent A delegates to Agent B, which delegates to Agent C, the delegation chain is traceable if each step uses OBO or equivalent. But agents do not only delegate. They also coordinate: Agent A reads a recommendation from Agent B's output and acts on it, without any formal delegation. Agent C queries a shared data store that Agent D populated an hour earlier. The causal graph of a decision may span agents that never directly communicated.

Individual audit trails do not compose into organizational accountability. Each agent's log tells you what that agent did. No log tells you what the organization's agents collectively decided. The CFO's question, "who decided?", becomes "what sequence of agent interactions led to this outcome, and which human authorizations are in the causal chain?"

Building this requires two capabilities that most agent deployments lack:

**Correlation identifiers that span agent boundaries.** Every action in a multi-agent workflow needs a shared trace ID that connects upstream causes to downstream effects. OpenTelemetry provides the infrastructure pattern: distributed traces that span service boundaries.[^opentelemetry] Agent orchestration frameworks need the same, but for decision provenance rather than request latency. The trace must capture not just "Agent C called API X" but "Agent C called API X because Agent B's output indicated Y, based on data Agent A retrieved under authorization Z."

**Causal graphs, not just event logs.** Event logs are append-only records of what happened. Causal graphs capture why. The difference matters for accountability: an event log shows that a payment was executed; a causal graph shows that the payment was triggered by a recommendation, which was triggered by a data retrieval, which was authorized by a delegation three months old. When something goes wrong, the causal graph is what you trace. Without it, incident response at scale is archaeology: piecing together what happened from fragments scattered across dozens of agent-specific logs.

### Aggregate Behavior and Emergent Risk

Individual agents can each behave correctly while the fleet behaves dangerously. This is the scale-specific version of the emergence pattern documented in the [Multi-Agent Trust and Orchestration](multi-agent-trust.md) chapter.

Consider a portfolio of customer-facing agents, each independently optimizing for customer satisfaction within its authorized scope. Individually, each agent's decisions are reasonable: offering a discount here, waiving a fee there, escalating a complaint to retain a customer. In aggregate, the fleet is systematically eroding margins or creating liability exposure that no individual agent's audit trail reveals.

This is not hypothetical. Irregular's March 2026 simulation documented agents developing collective strategies without adversarial prompting: bypassing DLP through steganography, forging credentials, and pressuring other agents to relax safety checks.[^irregular-rogue] Each agent acted within its reasoning context. The emergent behavior was visible only at the fleet level.

Monitoring individual agents catches individual failures. Catching fleet-level emergent behavior requires aggregate monitoring: statistical analysis across agent populations, anomaly detection on collective metrics, and alerts on distributional shifts that no single agent triggers. This is operationally similar to fraud detection in financial systems, where individual transactions are legitimate but patterns across transactions reveal abuse. The tooling exists in adjacent domains. It has not yet been adapted for agent fleets.

### Regulatory Compliance at Volume

The EU AI Act's Article 73 requires providers to report serious incidents to national authorities: within two days for widespread infringements or serious and irreversible disruption of critical infrastructure (Art 3(49)(b)), ten days for incidents resulting in death, fifteen days for other serious incidents.[^eu-ai-act-73] The [Regulatory Landscape](regulatory-landscape.md) chapter covers these timelines.

Article 73 was written for single AI systems. When an organization operates hundreds of agents, three assumptions break:

**Incident detection becomes statistical.** With one agent, anomalous behavior is visible to its human supervisor. With three hundred, anomalous behavior is noise unless you have automated detection infrastructure. The reporting timeline starts when the provider "becomes aware" of the incident. If awareness depends on a human reviewing an agent's log, and the log is one of three hundred, the effective detection window may exceed the reporting window.

**Incident attribution becomes forensic.** Article 73 requires reporting the "type of AI system involved" and "a description of the non-compliance." When the incident involves multiple interacting agents, the "type" is not a single system but a topology. The "non-compliance" may not be in any individual agent but in the interaction pattern. Regulators are not yet equipped to evaluate multi-agent incident reports, and organizations are not yet equipped to produce them.

**Incident frequency becomes continuous.** A single agent might produce a reportable incident once a quarter. Three hundred agents operating across high-risk domains will produce a steady stream of edge cases, near-misses, and anomalies. The regulatory framework assumes incident reporting is exceptional. At fleet scale, it becomes operational. Organizations need triage infrastructure that distinguishes reportable incidents from operational noise, and that triage itself becomes a governance function that must be auditable.

## Fleet Governance Infrastructure

The shadow agent governance chapter identified three organizational models: centralized review (breaks at 50 agents), federated governance with central standards (works for departments), and infrastructure-enforced governance (the target).[^shadow-agent-gov] The gap between the second and third is where most organizations currently sit, and it is where accountability at scale fails.

Infrastructure-enforced governance means that accountability requirements are not policies agents can ignore but architecture agents cannot bypass. Four capabilities make up the minimum viable fleet governance infrastructure:

### Agent Registry

Every agent in the organization has a registered identity linked to a human sponsor, a department, an authorization scope, and a lifecycle state (active, suspended, deprecated, retired). The registry is the single source of truth for "what agents are running and who is responsible for them."

SCIM for agents, covered in the [Agent Identity and Delegation](agent-identity.md) chapter, provides the provisioning protocol. Microsoft's Entra Agent ID and similar platforms provide the identity backend. The registry is not a spreadsheet: it is a system of record integrated with the organization's identity infrastructure, with the same lifecycle management discipline applied to human accounts. When a human sponsor leaves the organization, their agents are suspended, not orphaned.

Singapore's framework requires this explicitly: agent identity linked to a supervising entity.[^singapore-mgf] The EU AI Act does not require agent-level registration but does require that providers maintain records of high-risk AI systems deployed.[^eu-ai-act] For organizations operating hundreds of agents, a fleet registry satisfies both requirements simultaneously.

### Delegation Chain Forensics

When an incident occurs, the organization must reconstruct the chain of authorization from the human who initiated the delegation to the agent action that caused harm. At fleet scale, this reconstruction must be automated.

The building blocks exist. OBO tokens capture dual identity. PIC (Provenance, Identity, Continuity) makes authority cryptographically traceable through delegation chains.[^pic] CAAM's ghost token pattern ensures agents never possess raw credentials, so every action is mediated through verifiable authorization.[^caam] The [Cryptographic Authorization Governance](cryptographic-authorization.md) chapter covers these patterns in depth.

What is missing is the forensic layer: tooling that takes these building blocks and produces, on demand, a human-readable reconstruction of who authorized what, through which agents, with what constraints, at what time. This is the "explain to a regulator" capability that PAC's Accountability pillar demands. At single-agent scale, a human can read the logs. At fleet scale, the reconstruction must be automated, and the automation itself must be auditable.

### Fleet-Level Monitoring

Individual agent monitoring catches individual failures. Fleet-level monitoring catches emergent behavior, distributional drift, and aggregate risk accumulation. Three monitoring layers compose:

**Behavioral baselines per agent class.** Agents performing similar functions (all customer support agents, all procurement agents) should exhibit similar behavioral distributions. A single agent deviating from its class baseline is an anomaly. A shift in the entire class baseline is a policy or model change that may need governance review.

**Cross-agent correlation.** When multiple agents interact, their combined behavior must be monitored as a system, not as independent units. Correlation identifiers (the distributed trace pattern described above) enable this. The monitoring system should alert when the causal graph of a decision exceeds expected depth (too many agents in the chain) or breadth (too many data sources contributing to a single decision).

**Aggregate impact metrics.** The total financial exposure, data access volume, customer impact, and error rate across the fleet. These are organizational metrics, not agent metrics. They answer the question that individual agent dashboards cannot: "What is my fleet doing to my business right now?"

### Incident Triage at Scale

With a fleet of agents operating in high-risk domains, the organization will generate a continuous stream of anomalies, edge cases, and potential incidents. Not all of them are Article 73 reportable. Not all of them are even problematic. But all of them need classification.

Triage infrastructure sits between fleet monitoring and incident response. It classifies events into operational noise (log and learn), governance review (human assessment needed), and reportable incident (regulatory notification required). The classification criteria must be defined in advance, documented, and themselves auditable, because a regulator may ask not just "what incidents did you report?" but "what incidents did you classify as non-reportable, and on what basis?"

This is where the Atos "Sovereign Agentic Studios" model is instructive, not as a specific product endorsement but as an architectural signal. Atos's March 2026 whitepaper frames the problem as one of "sovereign control at scale": runtime guardrails, revocation capabilities, and audit infrastructure that work when agents operate across ERP, CRM, and ITSM systems simultaneously.[^atos-sas] The word "sovereign" matters because it implies that the organization, not the model provider and not the platform vendor, retains control over accountability infrastructure. At fleet scale, delegating accountability infrastructure to a vendor is delegating accountability itself.

## The PAC Mapping

Accountability at scale sits primarily in the Accountability pillar but draws from all three.

**Potential.** The business case for fleet-scale deployment depends on accountability infrastructure being in place. Organizations that cannot attribute decisions, monitor aggregate behavior, or triage incidents will not be permitted (by regulators, by insurers, by their own risk functions) to scale beyond pilot deployments. Accountability infrastructure is not a cost center: it is the gate that unlocks fleet-scale value. Shane's framing: "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built."[^profiler-reasoning]

**Accountability.** The chapter's core domain. Decision attribution, regulatory compliance, incident classification. The question that every Accountability dimension asks: "Could you explain to a regulator what your agent did and why?"[^pac-framework] At fleet scale, this question becomes: "Could you explain to a regulator what your agents collectively did, which human authorizations were in the causal chain, and how you classified the outcome?"

**Control.** Fleet governance infrastructure (registry, delegation forensics, monitoring, triage) is Control infrastructure applied to the Accountability domain. These are not policies. They are systems that enforce accountability by making ungoverned agent operation structurally impossible: no registry entry, no identity; no identity, no credentials; no credentials, no action.

### Infrastructure Maturity Levels

| Level | What exists | What it enables |
|-------|-----------|-----------------|
| **I1: Ad hoc** | Individual agent logs. No fleet registry. Manual incident review. | Accountability for individual agents only. No cross-agent attribution. |
| **I2: Basic** | Fleet registry with agent-to-sponsor mapping. Centralized log aggregation. Manual triage. | Agent inventory and ownership tracking. Post-incident forensics possible but slow. |
| **I3: Structured** | Correlation identifiers across agent interactions. Automated behavioral baselines. Defined triage criteria. | Cross-agent decision attribution. Anomaly detection. Consistent incident classification. |
| **I4: Integrated** | Cryptographic delegation chains (OBO/PIC/CAAM). Automated causal graph reconstruction. Fleet-level impact dashboards. | On-demand regulatory reporting. Automated forensics. Aggregate risk visibility. |
| **I5: Adaptive** | Continuous aggregate monitoring with distributional drift detection. Self-auditing triage classification. Cross-organizational accountability spanning partner agent networks. | Proactive risk management. Regulatory readiness as steady state. Fleet-level governance as competitive advantage. |

## What to Do Now

1. **Build the registry.** Every agent gets a registered identity linked to a human sponsor and a department. If you are using SCIM for human identity provisioning, extend it to agents. If a human sponsor leaves, their agents are suspended automatically.

2. **Add correlation identifiers.** Every multi-agent workflow gets a shared trace ID. Start with OpenTelemetry's distributed tracing model and extend it to capture decision provenance, not just request flow.

3. **Define triage criteria before you need them.** Classify what constitutes operational noise, what requires governance review, and what triggers regulatory notification. Document the criteria. Make them auditable.

4. **Monitor the fleet, not just the agents.** Track aggregate metrics: total financial exposure, data access volume, error rates, delegation chain depth. Set alerts on distributional shifts, not just individual anomalies.

5. **Invest in delegation chain forensics.** If you cannot reconstruct, on demand, the chain of authorization from human to agent action, you cannot meet Article 73 reporting requirements at fleet scale. The building blocks (OBO, PIC, CAAM) exist. The integration layer does not: build or buy it before you need it.

[^trust-for-agentic-ai]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," shanedeconinck.be, January 24, 2026.

[^shadow-agent-gov]: See the [Shadow Agent Governance](shadow-agent-governance.md) chapter for the full analysis of organizational governance models and the centralized review breakpoint.

[^mckinsey-projection]: McKinsey, 2026 reporting on enterprise agent adoption trajectories. Cited as projection, not confirmed deployment figure.

[^microsoft-fortune500]: Microsoft, 2026 reporting on Copilot and agent platform adoption among Fortune 500 companies.

[^gartner-prediction]: Gartner prediction, 2025-2026. Market forecast, not confirmed deployment data.

[^singapore-mgf]: Singapore Infocomm Media Development Authority (IMDA), "Model AI Governance Framework for Agentic AI," launched January 22, 2026 at the World Economic Forum, Davos.

[^rfc-8693]: IETF RFC 8693, "OAuth 2.0 Token Exchange," January 2020. The On-Behalf-Of pattern for dual-identity tokens.

[^opentelemetry]: OpenTelemetry, "Distributed Tracing," opentelemetry.io. The correlation identifier and trace context propagation patterns apply directly to agent decision provenance.

[^irregular-rogue]: Irregular, "Rogue AI Agents," March 12, 2026. Agents developed collective bypass strategies without adversarial prompting.

[^eu-ai-act-73]: EU AI Act, Article 73, "Reporting of serious incidents." Tiered reporting timelines: 2 days (widespread infringements or serious and irreversible disruption of critical infrastructure, per Art 3(49)(b)), 10 days (death), 15 days (other serious). See the [Regulatory Landscape](regulatory-landscape.md) chapter for full treatment.

[^eu-ai-act]: EU AI Act, Articles 49 and 51. Registration and record-keeping obligations for providers and deployers of high-risk AI systems.

[^pic]: Nicola Gallo, PIC (Provenance, Identity, Continuity) protocol specification, github.com/pic-protocol/pic-spec. Authority can only decrease through delegation, never expand.

[^caam]: CAAM (Contextual Agent Authorization Mesh), IETF draft (draft-barney-caam-00). Ghost token pattern: agents never possess raw credentials.

[^profiler-reasoning]: Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026.

[^pac-framework]: PAC Framework, trustedagentic.ai. Question A4: "Could you explain to a regulator what your agent did and why?"

[^atos-sas]: Atos, "Enterprise-grade Agentic AI: Secure, Governed, and Sovereign by Design," whitepaper, March 2026. Launched alongside Atos Sovereign Agentic Studios, March 12, 2026.
