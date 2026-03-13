# The Regulatory Landscape

Regulation is catching up to agents. Not all the way, and not evenly, but faster than most teams expect. The White House released a national cybersecurity strategy naming agentic AI as a strategic priority in March 2026. Singapore launched the world's first agentic AI governance framework in January 2026. The EU AI Act's high-risk obligations take effect August 2, 2026. NIST published a concept paper on AI agent identity and authorization in February 2026. ISO 42001 is becoming the enterprise baseline for AI management systems. The Colorado AI Act goes live in June 2026. And the standards bodies shaping agent protocols (IETF, OpenID Foundation, Linux Foundation Decentralized Trust) are all moving simultaneously.

This chapter maps the regulatory landscape to the PAC Framework. The thesis: organizations that build agent trust infrastructure for engineering reasons will find compliance falls out naturally. Organizations that treat regulation as a paperwork exercise will find themselves retrofitting infrastructure under pressure.

## The EU AI Act: Risk That Won't Sit Still

The EU AI Act is the world's first comprehensive AI regulation. It entered into force in August 2024, with provisions rolling out in phases through 2027. Like GDPR, its reach is extraterritorial: if your AI system's output is used in the European Union, you are in scope.[^euaiact]

The Act takes a risk-based approach. The higher the risk of your AI system, the stricter the obligations. It sorts AI systems into four tiers:

- **Prohibited**: violates fundamental rights. Social scoring, subliminal manipulation, real-time biometric surveillance. In effect since February 2025.
- **High-risk**: impacts people's safety or rights. Employment, education, credit scoring, law enforcement, critical infrastructure. Full obligations from August 2, 2026.
- **Limited risk**: risk of deception. Chatbots, deepfakes, emotion recognition. Transparency obligations from August 2026.
- **Minimal risk**: everything else. No obligations.

Annex III lists the high-risk categories. "Putting into service" includes internal use: deploying AI for your own processes does not make you exempt.[^annexiii]

Here is the critical insight from Shane's analysis: the Act does not mention agents.[^shaneeuai] It regulates use cases, not technology. General-purpose models got a last-minute chapter. Agents, which use those models to autonomously plan and act, are a layer the regulation did not anticipate.

### The Classification Problem

Traditional AI fits the Act's model well. An HR screening tool is high-risk from day one. Classify it, file the conformity assessment, move on. Some agents work the same way: single clear goal, known risk tier.

But not all of them. Give a general-purpose office assistant "handle my inbox" and it decides to draft an email (minimal risk), screen a job application (high-risk), then assess a customer complaint (potentially high-risk). The risk tier depends on how open-ended the prompt is. You can classify a tool at build time. You cannot classify an agent whose use case emerges at runtime.

This is what The Future Society calls the "multi-purpose problem": generic agents default to high-risk classification unless you explicitly exclude high-risk uses.[^futuresociety] The Act is permissive by design. But agents need closer attention precisely because they are general-purpose.

### Provider, Distributor, Deployer

The Act distinguishes three roles: provider (builds or substantially modifies an AI system), distributor (makes it available without substantial modification), and deployer (uses it under their own authority). Where you fall matters.

For agent builders using commercial LLMs, the GPAI provider obligations sit with the model provider, not with you. RAG, prompt engineering, orchestration, and tool-calling frameworks do not trigger provider obligations. The July 2025 guidelines clarify that only significant modifications to model weights (at least one-third of original training compute) cross that line.[^gpaiguidelines] If you are building agents with context engineering, you are a deployer, not a provider.

One wrinkle worth noting: open-weight models that cross the systemic risk threshold (10^25+ FLOPs) carry the full GPAI with systemic risk obligations. If the original provider has no EU presence and has not complied, that risk may flow down to the first entity in the EU value chain.[^shaneeuai]

### Shadow Agents and Article 4

Low-code platforms create a governance blind spot. When employees build agents on Power Platform or Copilot Studio, the company is still the deployer. An employee builds an HR screening agent without a compliance assessment, and the company is non-compliant without knowing the system exists.

This is why Article 4 (AI literacy) matters. It requires organizations to ensure adequate AI literacy among staff and contractors operating AI systems. This provision took effect in February 2025: it is already enforceable.[^article4] Staff need to understand what makes something high-risk, because the company is liable regardless of who built the system.

As Shane puts it: just like shadow IT before it, shadow agents will be one of the harder governance challenges to solve.[^shaneeuai] You cannot govern what you cannot see. The [Shadow Agent Governance](shadow-agent-governance.md) chapter covers the practical path: discovery, registration, the amnesty model, and infrastructure enforcement.

### What High-Risk Requires

For systems that fall into the high-risk category, the Act demands:

- **Risk management** throughout the lifecycle (Article 9): not a one-time assessment, but continuous identification and mitigation of risks.
- **Data governance** (Article 10): training, validation, and testing data must be relevant, representative, and as free of errors as practicable.
- **Technical documentation** (Article 11): sufficient to demonstrate compliance and enable authority assessment.
- **Record-keeping and traceability** (Article 12): automatic logging of events relevant to identifying risks and substantial modifications.
- **Human oversight by design** (Article 14): not as an afterthought. The system must allow deployers to implement meaningful human oversight.
- **Accuracy, robustness, and cybersecurity** (Article 15): appropriate safeguards throughout the system's lifecycle.
- **Incident reporting** (Article 73): 72-hour initial notification and 15-day detailed report to authorities.

Penalties for non-compliance reach 35 million euros or 7% of global annual turnover, whichever is higher.[^penalties]

### The Multi-Agent Incident Gap

Article 73's incident reporting guidelines, which become binding in August 2026, have a structural blind spot: they assume single-agent, single-occurrence failures.[^article73gap] When an incident results from the interaction of multiple AI systems, the current framework provides no mechanism to attribute accountability across the chain.

This matters for three reasons. First, multi-agent incidents often involve emergent behavior that no single provider caused or could have predicted. Algorithmic collusion in fuel markets, where prices rose without explicit coordination, illustrates the pattern: the harm emerged from interaction, not from any individual system.[^article73gap] Second, cascading failures compound across agent chains. The [Multi-Agent Trust and Orchestration](multi-agent-trust.md) chapter documents the evidence: 87% downstream decision poisoning within four hours from a single compromised agent.[^galileo] Third, the draft guidelines provide no structured pathways for third-party reporting: users, civil society, and researchers who detect multi-agent harms have no formal reporting mechanism.

The recommended fixes are specific: recognize incidents arising from AI-to-AI interactions, include cumulative and systemic harms across networks, and establish third-party and whistleblower reporting channels.[^article73gap] For organizations building multi-agent systems, the practical implication is clear: even if the regulation does not yet require multi-agent incident tracing, your infrastructure should support it, because the regulatory gap will close.

None of these are abstract requirements. They map directly to infrastructure you either have or do not have. Risk management means knowing which use cases your agent can reach at runtime and having governance thresholds to constrain them. Traceability means audit trails that capture the agent's decision chain, not just its output. Human oversight means delegation models where authority flows downward and can be revoked.

### The Commission's February 2026 Guidelines

The Commission was required to publish, by February 2, 2026, guidelines specifying practical implementation of Article 6 alongside a comprehensive list of practical examples of use cases that are and are not high-risk.[^commissionguidelines] These guidelines are significant for agent builders because they operationalize the classification rules, but they were written with traditional AI in mind. The multi-purpose problem, where an agent's use case is not fixed at deployment, remains an open interpretation challenge.

As of March 2026, fifteen months after the AI Act entered force, the European AI Office has published no guidance specifically addressing AI agents, autonomous tool use, or runtime behavior.[^futuresociety] The Act applies to agents, but the operational details of how to classify, monitor, and report on autonomous agent behavior remain unspecified. This creates a compliance gap: organizations must meet August 2026 obligations for high-risk systems, but the guidance assumes human decision-making timescales and single-system architectures. Agent builders should not wait for agent-specific guidance to build the infrastructure. The requirements (risk management, traceability, human oversight) are clear. How to implement them for agents is an engineering problem, not a regulatory ambiguity.

## NIST: Agent Identity and Authorization

While the EU focuses on risk classification and compliance obligations, NIST is working on the technical foundations. In February 2026, the National Cybersecurity Center of Excellence (NCCoE) published a concept paper: "Accelerating the Adoption of Software and AI Agent Identity and Authorization."[^nistpaper]

The paper asks a straightforward question: how should organizations identify, authenticate, and control software and AI agents that access enterprise systems and take actions with limited human supervision? Existing identity frameworks must evolve to address this shift, because systems that autonomously access tools, query databases, and execute operations on behalf of users require clear mechanisms for identification, authentication, and authorization.

Rather than proposing new frameworks from scratch, NIST focuses on adapting existing standards: OAuth 2.0/2.1 and OpenID Connect, widely deployed authentication and authorization protocols, alongside identity lifecycle management tools. This pragmatic approach validates the thesis from the Agent Identity chapter: the building blocks exist. The assembly is what is missing.

The public comment period closes April 2, 2026. For organizations shaping their agent infrastructure, this is the window for input.[^nistcomment]

### The AI Agent Standards Initiative

In the same month, NIST's Center for AI Standards and Innovation (CAISI) launched the AI Agent Standards Initiative, a broader effort organized around three pillars:[^caisi]

1. **Standards leadership**: facilitating industry-led development of agent standards and U.S. participation in international standards bodies.
2. **Open-source protocols**: fostering community-led development of interoperable agent protocols.
3. **Security and identity research**: advancing research in AI agent security, identity, and authorization.

The initiative's framing is telling: "absent confidence in the reliability of AI agents and interoperability among agents and digital resources, innovators may face a fragmented ecosystem and stunted adoption." This is a Potential argument, in PAC terms. NIST is not just worried about security. It is worried that without trust infrastructure, the economic value of agents will not materialize.

CAISI's Request for Information on AI Agent Security closed March 9, 2026. The NCCoE concept paper comment period closes April 2. Beginning in April, CAISI will hold listening sessions on sector-specific barriers to AI agent adoption, focused on healthcare, finance, and education. Participation is limited and requires submitting a one-page description of barriers to caisi-events@nist.gov by March 20, 2026.[^caisi]

## ISO 42001: The Management System Baseline

ISO/IEC 42001, published in December 2023, is the world's first AI-specific management system standard. It specifies requirements for establishing, implementing, maintaining, and continually improving an Artificial Intelligence Management System (AIMS).[^iso42001]

Where the EU AI Act tells you what to achieve and NIST focuses on technical identity infrastructure, ISO 42001 provides the organizational scaffolding: how to structure governance, risk assessment, and continuous improvement around AI systems. It is the only AI-specific management standard that is certifiable.

Major cloud providers (AWS, Google Cloud, Microsoft Azure) have achieved ISO 42001 certification. For enterprise buyers, it is becoming a procurement prerequisite: a signal that the vendor has formal AI governance processes in place.[^iso42001adoption]

For agent deployments specifically, ISO 42001 matters because it formalizes the governance loops that agents make necessary:

- **Risk assessment**: systematic identification of AI-specific risks, including the runtime classification problem.
- **AI system lifecycle management**: from design through deployment and monitoring, including version management as models improve.
- **Roles and responsibilities**: who approves deployment, who monitors performance, who handles incidents. This is where shadow agent governance gets formalized.
- **Continual improvement**: feedback loops that capture operational experience and feed it back into governance.

ISO 42001 does not solve the technical problems of agent identity or authorization. But it provides the management framework within which those technical solutions operate. An organization with ISO 42001 certification has the governance structure. What it needs is the infrastructure to enforce it.

## The U.S. Federal Response: Promote and Secure

On March 6, 2026, the White House released "President Trump's Cyber Strategy for America," a seven-page framework organized around six policy pillars. Pillar 5 ("Sustain Superiority in Critical and Emerging Technologies") explicitly names agentic AI as a strategic priority: securing the AI technology stack from data centers to models while "promoting agentic AI to scale network defense." An accompanying Executive Order on "Combating Cybercrime, Fraud, and Predatory Schemes Against American Citizens" was issued the same day.[^whitehousecyber]

This is the first national cybersecurity strategy globally to directly address agentic AI. But the framing is different from the EU's. Where the EU AI Act classifies and restricts AI systems by risk tier, the U.S. strategy promotes and secures: it treats agentic AI as a capability advantage to be deployed for autonomous threat detection and disruption, not a risk to be governed through classification.[^whitehousecyber]

The strategy's six pillars have implications for agent trust infrastructure:

- **Pillar 2 (Promote Common-Sense Regulation)** calls for streamlining cyber regulations and reducing compliance burdens. This signals a lighter regulatory touch than the EU, relying more on industry-led standards than mandatory compliance frameworks.
- **Pillar 3 (Modernize Federal Networks)** mandates zero-trust architectures, post-quantum cryptography, and AI-driven security tools. For agent deployments in federal environments, this establishes the baseline infrastructure.
- **Pillar 4 (Secure Critical Infrastructure)** strengthens supply chain resilience across energy, finance, telecom, water, and healthcare: the sectors where autonomous agents carry the highest blast radius.
- **Pillar 5 (Sustain Superiority)** is where agentic AI appears explicitly. Securing the AI technology stack and leveraging cyber diplomacy are both relevant to the cross-organizational trust infrastructure the book describes.

The practical regulatory work is happening through NIST. The strategy provides the policy umbrella; NIST's AI Agent Standards Initiative and NCCoE concept paper provide the technical substance. SP 800-53 COSAiS (Controls Overlay for Secure AI Systems) adapts the federal government's foundational security control catalog to both single-agent and multi-agent use cases.[^cosais] Together, these create a U.S. approach that is standards-driven rather than compliance-driven: build the right infrastructure and compliance follows, rather than comply with mandates and hope the infrastructure catches up.

The contrast with the EU is instructive. The EU AI Act creates compliance obligations that force infrastructure investment. The U.S. approach creates standards and guidelines that incentivize it. For organizations operating in both jurisdictions, building to the EU's requirements satisfies the U.S. standards. The reverse is not necessarily true.

## The U.S. State Landscape

In the absence of comprehensive federal AI regulation (the cyber strategy addresses security but not AI classification), U.S. states are filling the gap. The Colorado AI Act takes effect June 30, 2026, requiring risk management policies, impact assessments, and transparency for high-risk AI systems used in consequential decisions.[^colorado]

Colorado's approach shares the EU's risk-based framing but focuses specifically on consumer-facing decisions: employment, credit, insurance, housing. For organizations deploying agents in these domains, it creates domestic compliance obligations on a timeline that precedes the EU's by roughly a month.

Other states are considering similar legislation. The pattern is clear: state-level regulation is converging on risk-based frameworks while federal policy focuses on promotion and standards. For organizations operating across states, this creates a patchwork that increases the value of a unified governance framework.

## Singapore: The First Agentic AI Governance Framework

On January 22, 2026, Singapore's Infocomm Media Development Authority (IMDA) launched the Model AI Governance Framework for Agentic AI at the World Economic Forum. It is the world's first government-sponsored governance framework designed specifically for AI agents capable of autonomous planning, reasoning, and action.[^imda]

Where the EU AI Act regulates AI broadly and mentions agents only by implication, Singapore built a framework around agents from the start. The framework addresses four dimensions:

1. **Assessing and bounding risks upfront**: limit what agents can do by controlling tool access, permissions, operational environments, and the scope of actions they may take. These serve as the primary defense against unintended or harmful actions.
2. **Making humans meaningfully accountable**: organizational structures must allocate clear responsibilities across the AI lifecycle, covering developers, deployers, operators, and end users. Human oversight mechanisms must effectively override, intercept, or review agentic AI actions, especially for actions with real-world material impact.
3. **Implementing technical controls and processes**: baseline testing, access control to whitelisted services, and monitoring throughout the agent lifecycle.
4. **Enabling end-user responsibility**: users deploying agents bear responsibility for how they configure and use them.

Compliance is voluntary, but organizations remain legally accountable for their agents' behaviors and actions. IMDA describes the framework as a living document, inviting feedback and case studies demonstrating responsible agentic AI deployment.

The PAC mapping is direct. Risk bounding is Potential: assess blast radius, reliability, and autonomy level before deploying. Human accountability is Accountability: delegation chains, audit trails, clear ownership. Technical controls are Control: infrastructure as gate, policy enforced through architecture not just documentation. End-user responsibility connects to PAC's shadow agent problem: when employees deploy agents without governance review, accountability breaks down.

What makes Singapore's framework notable is not just that it was first, but that it starts from the right premise: agents are different from traditional AI systems. The EU AI Act's risk classification was designed for fixed-purpose systems. Singapore's framework assumes agents are autonomous, multi-step, and capable of reaching use cases not anticipated at deployment. That is the classification problem the EU is still working through in implementation guidelines.

## Standards Convergence

Beyond regulation, the standards bodies shaping agent protocols are converging on agent trust infrastructure simultaneously. This convergence is significant because it means the technical building blocks for compliance are being standardized, not proprietary.

### IETF and OAuth Extensions

The IETF has active work on agent authentication and authorization, including a draft leveraging the Workload Identity in Multi-System Environments (WIMSE) architecture and OAuth 2.0 extensions.[^ietfdraft] The draft for On-Behalf-Of with AI agents (draft-oauth-ai-agents-on-behalf-of-user) addresses the delegation tracking that OAuth was never designed for: encoding not just who authorized an action, but that an agent is acting on their behalf, with what constraints, and for how long.

### OpenID Foundation AIIM

The OpenID Foundation's AI Identity Management (AIIM) Community Group, active since October 2025, published a whitepaper identifying core challenges at the intersection of AI and digital identity. In March 2026, the group's Threat Modeling Subgroup filed a response to NIST's Request for Information on securing AI agent systems.[^openidaiim]

The AIIM work matters because OpenID Connect is the dominant identity layer for web applications. If agent identity standards emerge from this community, they will integrate with existing infrastructure rather than requiring greenfield deployment.

### OpenID Connect for Agents (OIDC-A)

A proposal for OpenID Connect for Agents (OIDC-A) 1.0 extends OpenID Connect Core to provide a framework for representing, authenticating, and authorizing LLM-based agents within the OAuth 2.0 ecosystem.[^oidca] This is still early, but it represents the kind of extension that could bridge the gap between existing identity infrastructure and agent-specific requirements.

### Industry Standards

The industry side is moving in parallel. Verifiable Intent (Mastercard and Google, open-sourced March 2026) provides cryptographic binding of user intent to agent actions through a three-layer SD-JWT architecture.[^verifiableintent] MCP is becoming the standard discovery protocol for agent context, with 97 million monthly SDK downloads and Linux Foundation governance.[^mcp] A2A has reached 150+ organizations with v0.3.[^a2a]

The window for shaping these standards is narrow. Most have open comment periods or community participation processes running through Q2 2026.

## How PAC Maps to Regulation

The PAC Framework was not designed as a compliance tool. But the mapping to regulatory requirements is direct, because both describe what well-governed agent deployments look like.

### Potential and Regulatory Classification

The Potential pillar's dimensions (business value, reliability, blast radius, autonomy) map to the regulatory classification problem. The EU AI Act asks: what risk tier does this system fall into? PAC asks the same question with more granularity:

- **Blast radius** (B1-B5) aligns with the Act's risk tiers. B4 (Regulated) and B5 (Irreversible) systems almost certainly trigger high-risk classification.
- **Autonomy levels** (A1-A5) map to the oversight requirements. A1-A2 systems (suggestion, approval) naturally satisfy human oversight requirements. A4-A5 systems (delegated, autonomous) require the infrastructure-enforced oversight that Article 14 demands.
- **Reliability** with its error margin connects to the accuracy and robustness requirements of Article 15. Knowing the error margin, not just the headline number, is the governance question that matters.

### Accountability and Compliance Obligations

The Accountability pillar maps most directly to the EU AI Act's operational requirements:

- **Shadow agents** are the Article 4 problem. You cannot comply with AI literacy requirements if you do not know what agents are running.
- **Delegation chains** are the Article 12 problem. Traceability requires capturing who authorized what, through which agents, with what constraints.
- **Audit trails** designed for compliance (not just debugging) are what Article 9 risk management and Article 12 record-keeping demand. NIST's concept paper asks the same question from the infrastructure side: how do you log what agents did and under whose authority?
- **Liability chains** matter when incidents occur. The EU AI Act defines provider, distributor, and deployer roles. PAC asks the same question at the technical level: when an agent causes harm, can you trace the authorization chain?

### Control and Technical Enforcement

The Control pillar provides the technical infrastructure that makes compliance enforceable:

- **Agent identity** satisfies NIST's central requirement: agents need identifiable, verifiable identities with scoped authorization.
- **Delegation chains where authority only decreases** implement the Act's human oversight requirement structurally, not through policy alone.
- **Infrastructure as gate** (you either have audit trails or you do not) matches the binary nature of compliance: you are compliant or you are not.
- **Cross-organizational trust** (TSP, eIDAS 2.0, EUDI wallets) matters because regulation does not stop at organizational boundaries. The EU AI Act's extraterritorial reach means agent interactions crossing borders need the same governance guarantees.

### The Infrastructure Maturity Connection

The PAC Framework's infrastructure scale (I1-I5) provides a practical readiness assessment against regulatory requirements:

| Infrastructure Level | Regulatory Readiness |
|---|---|
| I1 (Open) | Non-compliant for any high-risk use. No audit trail, no identity, no controls. |
| I2 (Logged) | Partial compliance. Audit trails exist but agent identity is not verified. Meets some Article 12 requirements. |
| I3 (Verified) | Agent identity is verified, delegation is tracked. Meets Article 12 and partial Article 14. Sufficient for most NIST recommendations. |
| I4 (Authorized) | Fine-grained, context-aware authorization. Meets Article 14 human oversight requirements. Satisfies ISO 42001 management system expectations. |
| I5 (Contained) | Full containment with cross-organizational trust. Compliant with EU AI Act, NIST, and ISO 42001 requirements. Ready for eIDAS 2.0 interoperability. |

Most organizations today operate at I1-I2 for their agent deployments. Regulatory timelines demand I3 or higher by August 2026 for any high-risk use cases.

## The Convergence Timeline

The regulatory and standards timelines are converging on a narrow window:

- **January 22, 2026**: Singapore IMDA launches Model AI Governance Framework for Agentic AI at WEF. World's first agentic AI governance framework.
- **February 2025**: EU AI Act Article 4 (AI literacy) already in effect.
- **March 6, 2026**: White House releases "President Trump's Cyber Strategy for America." First national cybersecurity strategy to explicitly name agentic AI as a strategic priority (Pillar 5).
- **March 9, 2026**: NIST CAISI Request for Information on AI Agent Security closed.
- **March 20, 2026**: NIST CAISI listening session participation requests due.
- **March 31, 2026**: NIST AI 800-2 (Practices for Automated Benchmark Evaluations) public comment period closes.
- **April 2, 2026**: NIST NCCoE concept paper comment period closes.
- **April 2026+**: NIST CAISI listening sessions on sector-specific barriers begin (healthcare, finance, education).
- **June 30, 2026**: Colorado AI Act takes effect.
- **August 2, 2026**: EU AI Act high-risk system obligations take effect.
- **2027**: EU AI Act full enforcement, including high-risk systems embedded in products listed in Annex I.

Shane's observation is worth restating: NIST and the EU are converging on agent governance simultaneously.[^shaneeuai] But the approaches differ. The EU classifies and restricts (Accountability pillar). The U.S. promotes and secures: the White House strategy treats agentic AI as a capability to deploy, with NIST providing the identity and authorization standards (Control pillar). Singapore governs by design, with a framework built for agents from the ground up across all three PAC pillars. None alone is sufficient. Together, they describe the full governance surface: the EU ensures accountability, the U.S. builds the technical standards, and Singapore provides the template for agent-native governance.

## What This Means in Practice

The regulatory landscape leads to practical conclusions:

**For teams building agents today**: map your agent deployments against the EU AI Act risk tiers. Any agent that could reach high-risk use cases at runtime (employment decisions, credit scoring, critical infrastructure) needs to be governed as high-risk unless you can technically constrain it to lower tiers. Architecture is cheaper than reclassification under pressure.

**For organizations with shadow agents**: Article 4 is already enforceable. AI literacy is not optional. If your employees are building agents on low-code platforms without governance review, you have a compliance exposure today, not in August.

**For infrastructure teams**: the NIST concept paper describes the agent identity infrastructure you should be building anyway. Start with I2 (logging everything) and work toward I3 (verified agent identity, tracked delegation). These investments satisfy regulatory requirements and improve engineering quality simultaneously.

**For organizations operating across jurisdictions**: a unified governance framework (like PAC) becomes more valuable as regulation fragments across the EU, U.S. states, and sector-specific requirements. Building to the highest common standard is simpler than maintaining jurisdiction-specific compliance.

The gap between what agents can do and what regulation requires is an infrastructure gap. Auth, identity, scoping, audit trails, guardrails. The organizations that close this gap for engineering reasons will find compliance is a byproduct. The ones that wait for enforcement will find themselves building under pressure.

---

[^euaiact]: [EU AI Act](https://artificialintelligenceact.eu/), entered into force August 2024.

[^annexiii]: [Annex III: High-Risk AI Systems](https://artificialintelligenceact.eu/annex/3/), EU AI Act.

[^shaneeuai]: Shane Deconinck, ["AI Agents and the EU AI Act: Risk That Won't Sit Still"](https://shanedeconinck.be/posts/ai-agents-eu-ai-act/), January 29, 2026.

[^futuresociety]: The Future Society, ["Ahead of the Curve: Governing AI Agents Under the EU AI Act"](https://thefuturesociety.org/aiagentsintheeu/).

[^gpaiguidelines]: European Commission, [GPAI Provider Guidelines](https://digital-strategy.ec.europa.eu/en/policies/guidelines-gpai-providers), July 2025.

[^article4]: [Article 4: AI Literacy](https://artificialintelligenceact.eu/article/4/), EU AI Act. In effect since February 2025.

[^penalties]: EU AI Act penalties: up to 35 million euros or 7% of total worldwide annual turnover. [AI Act Enforcement](https://digital-strategy.ec.europa.eu/en/policies/ai-act-governance-and-enforcement).

[^commissionguidelines]: [Article 6 Classification Rules](https://artificialintelligenceact.eu/article/6/), EU AI Act. Commission guidelines required by February 2, 2026.

[^nistpaper]: NIST NCCoE, ["Accelerating the Adoption of Software and AI Agent Identity and Authorization"](https://www.nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf), February 2026.

[^nistcomment]: NIST NCCoE, [concept paper comment period](https://csrc.nist.gov/pubs/other/2026/02/05/accelerating-the-adoption-of-software-and-ai-agent/ipd). Feedback via AI-Identity@nist.gov by April 2, 2026.

[^caisi]: NIST, ["Announcing the AI Agent Standards Initiative"](https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure), February 2026.

[^iso42001]: [ISO/IEC 42001:2023](https://www.iso.org/standard/42001), AI Management Systems.

[^iso42001adoption]: BSI, ["ISO 42001: AI Management System"](https://www.bsigroup.com/en-US/products-and-services/standards/iso-42001-ai-management-system/).

[^whitehousecyber]: The White House, ["President Trump's Cyber Strategy for America"](https://www.whitehouse.gov/wp-content/uploads/2026/03/President-Trumps-Cyber-Strategy-for-America.pdf), March 6, 2026.

[^cosais]: NIST SP 800-53 COSAiS (Controls Overlay for Secure AI Systems) adapts federal security controls for single-agent and multi-agent use cases. Referenced in Zenity, ["From Policy Planning to Agentic Action"](https://zenity.io/blog/current-events/from-policy-planning-to-agentic-action), March 2026.

[^colorado]: Colorado AI Act, effective June 30, 2026. Requires risk management policies, impact assessments, and transparency for high-risk AI in consequential decisions.

[^imda]: Singapore IMDA, ["Model AI Governance Framework for Agentic AI"](https://www.imda.gov.sg/-/media/imda/files/about/emerging-tech-and-research/artificial-intelligence/mgf-for-agentic-ai.pdf), January 22, 2026.

[^ietfdraft]: IETF, [draft-klrc-aiagent-auth-00: AI Agent Authentication and Authorization](https://datatracker.ietf.org/doc/draft-klrc-aiagent-auth/).

[^article73gap]: Natàlia Fernández Ashman, Usman Anwar, and Marta Bieńkiewicz, ["EU Regulations Are Not Ready for Multi-Agent AI Incidents"](https://www.techpolicy.press/eu-regulations-are-not-ready-for-multiagent-ai-incidents/), TechPolicy.Press, January 13, 2026.

[^galileo]: Galileo AI, "Multi-Agent AI System Failures and Prevention," research findings December 2025. 87% downstream decision poisoning within four hours from a single compromised agent.

[^openidaiim]: OpenID Foundation, ["OIDF Responds to NIST on AI Agent Security"](https://openid.net/oidf-responds-to-nist-on-ai-agent-security/), March 2026.

[^oidca]: ["OpenID Connect for Agents (OIDC-A) 1.0"](https://arxiv.org/html/2509.25974v1).

[^verifiableintent]: Covered in detail in the Agent Identity and Delegation chapter. See Shane Deconinck, ["Verifiable Intent: Mastercard and Google Open-Source Agent Authorization"](https://shanedeconinck.be/posts/verifiable-intent-mastercard-google-agent-authorization/).

[^mcp]: MCP adoption figures and governance as of March 2026. See the Context Infrastructure chapter for details.

[^a2a]: A2A v0.3 with 150+ organizations. See the Context Infrastructure chapter for details.
