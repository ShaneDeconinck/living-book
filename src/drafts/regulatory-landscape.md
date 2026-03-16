# The Regulatory Landscape

Regulation is catching up to agents. Not all the way, and not evenly, but faster than most teams expect. The White House released a national cybersecurity strategy naming agentic AI as a strategic priority in March 2026. Singapore launched the world's first agentic AI governance framework in January 2026. The EU AI Act's high-risk obligations take effect August 2, 2026. NIST published a concept paper on AI agent identity and authorization in February 2026. ISO 42001 is becoming the enterprise baseline for AI management systems. The Colorado AI Act goes live in June 2026. And the standards bodies shaping agent protocols (IETF, OpenID Foundation, Linux Foundation Decentralized Trust) are all moving simultaneously.

The thesis: organizations that build agent trust infrastructure for engineering reasons will find compliance falls out naturally. Organizations that treat regulation as a paperwork exercise will find themselves retrofitting infrastructure under pressure.

## The EU AI Act: Risk That Won't Sit Still

The EU AI Act is the world's first comprehensive AI regulation. It entered into force in August 2024, with provisions rolling out in phases through 2027. Like GDPR, its reach is extraterritorial: if your AI system's output is used in the European Union, you are in scope.[^euaiact]

The Act takes a risk-based approach. The higher the risk of your AI system, the stricter the obligations. It sorts AI systems into four tiers:

- **Prohibited**: violates fundamental rights. Social scoring, subliminal manipulation, real-time biometric surveillance. In effect since February 2025.
- **High-risk**: impacts people's safety or rights. Employment, education, credit scoring, law enforcement, critical infrastructure. Full obligations from August 2, 2026.
- **Limited risk**: risk of deception. Chatbots, deepfakes, emotion recognition. Transparency obligations from August 2026.
- **Minimal risk**: everything else. No obligations.

Annex III lists the high-risk categories. "Putting into service" includes internal use: deploying AI for your own processes does not make you exempt.[^annexiii]

The Act does not mention agents.[^shaneeuai] It regulates use cases, not technology. General-purpose models got a last-minute chapter. Agents, which use those models to autonomously plan and act, are a layer the regulation did not anticipate.

### The Classification Problem

Traditional AI fits the Act's model well. An HR screening tool is high-risk from day one. Classify it, file the conformity assessment, move on. Some agents work the same way: single clear goal, known risk tier.

But not all of them. Give a general-purpose office assistant "handle my inbox" and it decides to draft an email (minimal risk), screen a job application (high-risk), then assess a customer complaint (potentially high-risk). The risk tier depends on how open-ended the prompt is. You can classify a tool at build time. You cannot classify an agent whose use case emerges at runtime.

This is what The Future Society calls the "multi-purpose problem": generic agents default to high-risk classification unless you explicitly exclude high-risk uses.[^futuresociety] The Act is permissive by design. But agents need closer attention precisely because they are general-purpose.

### Provider, Distributor, Deployer

The Act distinguishes three roles: provider (builds or substantially modifies an AI system), distributor (makes it available without substantial modification), and deployer (uses it under their own authority). Where you fall matters.

For agent builders using commercial LLMs, the GPAI provider obligations sit with the model provider, not with you. RAG, prompt engineering, orchestration, and tool-calling frameworks do not trigger provider obligations. The July 2025 guidelines clarify that significant modifications to model weights trigger provider obligations, using one-third of original training compute as an indicative threshold.[^gpaiguidelines] If you are building agents with context engineering, you are a deployer, not a provider.

One wrinkle worth noting: open-weight models that cross the systemic risk threshold (10^25+ FLOPs) carry the full GPAI with systemic risk obligations. If the original provider has no EU presence and has not complied, that risk may flow down to the first entity in the EU value chain.[^shaneeuai]

### Shadow Agents and Article 4

Low-code platforms create a governance blind spot. When employees build agents on Power Platform or Copilot Studio, the company is still the deployer. An employee builds an HR screening agent without a compliance assessment, and the company is non-compliant without knowing the system exists.

Article 4 (AI literacy) requires organizations to ensure adequate AI literacy among staff and contractors operating AI systems. This provision took effect in February 2025: it is already enforceable.[^article4] Staff need to understand what makes something high-risk, because the company is liable regardless of who built the system.

As Shane puts it: just like shadow IT before it, shadow agents will be one of the harder governance challenges to solve.[^shaneeuai] The [Shadow Agent Governance](shadow-agent-governance.md) chapter covers the practical path: discovery, registration, the amnesty model, and infrastructure enforcement.

### What High-Risk Requires

For systems that fall into the high-risk category, the Act demands:

- **Risk management** throughout the lifecycle (Article 9): not a one-time assessment, but continuous identification and mitigation of risks.
- **Data governance** (Article 10): training, validation, and testing data must be relevant, representative, and as free of errors as practicable.
- **Technical documentation** (Article 11): sufficient to demonstrate compliance and enable authority assessment.
- **Record-keeping and traceability** (Article 12): automatic logging of events relevant to identifying risks and substantial modifications.
- **Human oversight by design** (Article 14): not as an afterthought. The system must allow deployers to implement meaningful human oversight.
- **Accuracy, robustness, and cybersecurity** (Article 15): appropriate safeguards throughout the system's lifecycle.
- **Incident reporting** (Article 73): tiered by severity. Two days for widespread or critical infrastructure disruptions. Ten days for incidents resulting in death. Fifteen days for other serious incidents. Initial incomplete reports are permitted, with complete reports to follow.

Penalties are tiered by violation severity. Prohibited AI practices (Article 5): up to 35 million euros or 7% of global annual turnover, whichever is higher. Non-compliance with high-risk obligations: up to 15 million euros or 3%. Supplying incorrect information to authorities: up to 7.5 million euros or 1%. For SMEs and startups, the "whichever is lower" criterion applies instead.[^penalties]

### The Multi-Agent Incident Gap

Article 73's incident reporting guidelines, which become binding in August 2026, have a structural blind spot: they assume single-agent, single-occurrence failures.[^article73gap] When an incident results from the interaction of multiple AI systems, the current framework provides no mechanism to attribute accountability across the chain.

First, multi-agent incidents often involve emergent behavior that no single provider caused or could have predicted. Algorithmic collusion in fuel markets, where prices rose without explicit coordination, illustrates the pattern: the harm emerged from interaction, not from any individual system.[^article73gap] Second, cascading failures compound across agent chains. Research on LLM-based multi-agent systems confirms the pattern: faulty or compromised agents degrade downstream decision-making across the chain, with performance drops of up to 23.7% depending on system structure.[^cascading-mas] The [Multi-Agent Trust and Orchestration](multi-agent-trust.md) chapter documents the evidence in detail. Third, the draft guidelines provide no structured pathways for third-party reporting: users, civil society, and researchers who detect multi-agent harms have no formal reporting mechanism.

The recommended fixes are specific: recognize incidents arising from AI-to-AI interactions, include cumulative and systemic harms across networks, and establish third-party and whistleblower reporting channels.[^article73gap] For organizations building multi-agent systems, even if the regulation does not yet require multi-agent incident tracing, your infrastructure should support it, because the regulatory gap will close.
The recommended fixes are specific: recognize incidents arising from AI-to-AI interactions, include cumulative and systemic harms across networks, and establish third-party and whistleblower reporting channels.[^article73gap] For organizations building multi-agent systems: even if the regulation does not yet require multi-agent incident tracing, your infrastructure should support it, because the regulatory gap will close.

Risk management means knowing which use cases your agent can reach at runtime and having governance thresholds to constrain them. Traceability means audit trails that capture the agent's decision chain, not just its output. Human oversight means delegation models where authority flows downward and can be revoked.

### The Commission's February 2026 Guidelines

The Commission was required to publish, by February 2, 2026, guidelines specifying practical implementation of Article 6 alongside a comprehensive list of practical examples of use cases that are and are not high-risk.[^commissionguidelines] These guidelines operationalize the classification rules, but they were written with traditional AI in mind. The multi-purpose problem, where an agent's use case is not fixed at deployment, remains an open interpretation challenge.

As of March 2026, nineteen months after the AI Act entered force, the European AI Office has published no guidance specifically addressing AI agents, autonomous tool use, or runtime behavior.[^futuresociety] The Act applies to agents, but the operational details of how to classify, monitor, and report on autonomous agent behavior remain unspecified.

The timeline itself is now uncertain. In late 2025, the European Commission proposed the Digital Omnibus package, which would defer high-risk AI obligations for Annex III systems until compliance support measures (harmonized standards, common specifications, and Commission guidelines) are confirmed available, with a backstop deadline of December 2, 2027: sixteen months later than the original August 2, 2026 date.[^digital-omnibus] The rationale is pragmatic: the standards and guidance that organizations need to comply are not yet ready. But the Omnibus is a legislative proposal, not yet adopted. Organizations face a familiar dilemma: plan for August 2026 and potentially over-invest, or plan for December 2027 and risk non-compliance if the Omnibus fails or narrows.

Build the infrastructure regardless. The requirements (risk management, traceability, human oversight) do not change with the timeline. Only the enforcement date moves. Organizations building trust infrastructure for agents are not building to a regulatory deadline. They are building to operational necessity. The existing guidance assumes human decision-making timescales and single-system architectures. Agent builders should not wait for agent-specific guidance or timeline clarity. How to implement these requirements for agents is an engineering problem, not a regulatory ambiguity.

## NIST: Agent Identity and Authorization

While the EU focuses on risk classification and compliance obligations, NIST is working on the technical foundations. In February 2026, the National Cybersecurity Center of Excellence (NCCoE) published a concept paper: "Accelerating the Adoption of Software and AI Agent Identity and Authorization."[^nistpaper]

The paper asks a straightforward question: how should organizations identify, authenticate, and control software and AI agents that access enterprise systems and take actions with limited human supervision? Existing identity frameworks must evolve to address this shift, because systems that autonomously access tools, query databases, and execute operations on behalf of users require clear mechanisms for identification, authentication, and authorization.

Rather than proposing new frameworks from scratch, NIST focuses on adapting existing standards: OAuth 2.0/2.1 and OpenID Connect, widely deployed authentication and authorization protocols, alongside identity lifecycle management tools. This pragmatic approach validates the thesis from the [Agent Identity and Delegation](agent-identity.md) chapter: the building blocks exist. The assembly is what is missing.

The public comment period closes April 2, 2026. For organizations shaping their agent infrastructure, this is the window for input.[^nistcomment]

### The AI Agent Standards Initiative

In the same month, NIST's Center for AI Standards and Innovation (CAISI) launched the AI Agent Standards Initiative, a broader effort organized around three pillars:[^caisi]

1. **Standards leadership**: facilitating industry-led development of agent standards and U.S. participation in international standards bodies.
2. **Open-source protocols**: fostering community-led development of interoperable agent protocols.
3. **Security and identity research**: advancing research in AI agent security, identity, and authorization.

The initiative's framing is telling: "absent confidence in the reliability of AI agents and interoperability among agents and digital resources, innovators may face a fragmented ecosystem and stunted adoption." NIST is not just worried about security. It is worried that without trust infrastructure, the economic value of agents will not materialize.

CAISI's Request for Information on AI Agent Security closed March 9, 2026, drawing 932 public comments:[^caisi-comments] a measure of how urgently industry wants guidance on agent governance. Among the respondents, the OpenID Foundation's AIIM Threat Modeling Subgroup submitted concrete recommendations for agent identity standards,[^openidaiim] and the Software & Information Industry Association (SIIA) argued that many agentic AI risks can be addressed by extending established cybersecurity practices (secure-by-design, least-privilege, continuous monitoring) rather than creating entirely new frameworks.[^siia-rfi] The NCCoE concept paper comment period closes April 2. Beginning in April, CAISI will hold listening sessions on sector-specific barriers to AI agent adoption, focused on healthcare, finance, and education. Participation is limited and requires submitting a one-page description of barriers to caisi-events@nist.gov by March 20, 2026.[^caisi]

## ISO 42001: The Management System Baseline

ISO/IEC 42001, published in December 2023, is the world's first AI-specific management system standard. It specifies requirements for establishing, implementing, maintaining, and continually improving an Artificial Intelligence Management System (AIMS).[^iso42001]

Where the EU AI Act tells you what to achieve and NIST focuses on technical identity infrastructure, ISO 42001 provides the organizational scaffolding: how to structure governance, risk assessment, and continuous improvement around AI systems. It is the only AI-specific management standard that is certifiable.

Major cloud providers (AWS, Google Cloud, Microsoft Azure) have achieved ISO 42001 certification. For enterprise buyers, it is becoming a procurement prerequisite: a signal that the vendor has formal AI governance processes in place.[^iso42001adoption]

For agent deployments, ISO 42001 formalizes the governance loops that agents make necessary:

- **Risk assessment**: systematic identification of AI-specific risks, including the runtime classification problem.
- **AI system lifecycle management**: from design through deployment and monitoring, including version management as models improve.
- **Roles and responsibilities**: who approves deployment, who monitors performance, who handles incidents. This is where shadow agent governance gets formalized.
- **Continual improvement**: feedback loops that capture operational experience and feed it back into governance.

ISO 42001 does not solve the technical problems of agent identity or authorization. But it provides the management framework within which those technical solutions operate. An organization with ISO 42001 certification has the governance structure.

## The U.S. Federal Response: Promote and Secure

On March 6, 2026, the White House released "President Trump's Cyber Strategy for America," a seven-page framework organized around six policy pillars. Pillar 5 ("Sustain Superiority in Critical and Emerging Technologies") explicitly names agentic AI as a strategic priority: securing the AI technology stack from data centers to models while "promoting agentic AI to scale network defense." An accompanying Executive Order on "Combating Cybercrime, Fraud, and Predatory Schemes Against American Citizens" was issued the same day.[^whitehousecyber]

The framing differs from the EU's. Where the EU AI Act classifies and restricts AI systems by risk tier, the U.S. strategy promotes and secures: it treats agentic AI as a capability advantage to be deployed for autonomous threat detection and disruption, not a risk to be governed through classification.[^whitehousecyber]

The strategy's six pillars have implications for agent trust infrastructure:

- **Pillar 2 (Promote Common-Sense Regulation)** calls for streamlining cyber regulations and reducing compliance burdens. This signals a lighter regulatory touch than the EU, relying more on industry-led standards than mandatory compliance frameworks.
- **Pillar 3 (Modernize Federal Networks)** mandates zero-trust architectures, post-quantum cryptography, and AI-driven security tools. For agent deployments in federal environments, this establishes the baseline infrastructure.
- **Pillar 4 (Secure Critical Infrastructure)** strengthens supply chain resilience across energy, finance, telecom, water, and healthcare: the sectors where autonomous agents carry the highest blast radius.
- **Pillar 5 (Sustain Superiority)** is where agentic AI appears explicitly. Securing the AI technology stack and leveraging cyber diplomacy are both relevant to the cross-organizational trust infrastructure the book describes.

The practical regulatory work is happening through NIST. The strategy provides the policy umbrella; NIST's AI Agent Standards Initiative and NCCoE concept paper provide the technical substance. SP 800-53 COSAiS (Controls Overlay for Secure AI Systems) adapts the federal government's foundational security control catalog to both single-agent and multi-agent use cases.[^cosais] Together, these create a U.S. approach that is standards-driven rather than compliance-driven: build the right infrastructure and compliance follows, rather than comply with mandates and hope the infrastructure catches up.

The EU AI Act creates compliance obligations that force infrastructure investment. The U.S. approach creates standards and guidelines that incentivize it. For organizations operating in both jurisdictions, building to the EU's requirements satisfies the U.S. standards. The reverse is not necessarily true.

## The U.S. State Landscape

In the absence of comprehensive federal AI regulation (the cyber strategy addresses security but not AI classification), U.S. states are filling the gap. The Colorado AI Act takes effect June 30, 2026, requiring risk management policies, impact assessments, and transparency for high-risk AI systems used in consequential decisions.[^colorado]

Colorado's approach shares the EU's risk-based framing but focuses on consumer-facing decisions: employment, credit, insurance, housing. For organizations deploying agents in these domains, it creates domestic compliance obligations on a timeline that precedes the EU's by roughly a month.

Other states are considering similar legislation. State-level regulation is converging on risk-based frameworks while federal policy focuses on promotion and standards. For organizations operating across states, this creates a patchwork that increases the value of a unified governance framework.

## Singapore: The First Agentic AI Governance Framework

On January 22, 2026, Singapore's Infocomm Media Development Authority (IMDA) launched the Model AI Governance Framework for Agentic AI at the World Economic Forum. It is the world's first government-sponsored governance framework designed for AI agents capable of autonomous planning, reasoning, and action.[^imda]

Where the EU AI Act regulates AI broadly and mentions agents only by implication, Singapore built a framework around agents from the start. The framework addresses four dimensions:

1. **Assessing and bounding risks upfront**: limit what agents can do by controlling tool access, permissions, operational environments, and the scope of actions they may take. These serve as the primary defense against unintended or harmful actions.
2. **Making humans meaningfully accountable**: organizational structures must allocate clear responsibilities across the AI lifecycle, covering developers, deployers, operators, and end users. Human oversight mechanisms must effectively override, intercept, or review agentic AI actions, especially for actions with real-world material impact.
3. **Implementing technical controls and processes**: baseline testing, access control to whitelisted services, and monitoring throughout the agent lifecycle.
4. **Enabling end-user responsibility**: users deploying agents bear responsibility for how they configure and use them.

Compliance is voluntary, but organizations remain legally accountable for their agents' behaviors and actions. IMDA describes the framework as a living document, inviting feedback and case studies demonstrating responsible agentic AI deployment.

Singapore's framework starts from the right premise: agents are different from traditional AI systems. The EU AI Act's risk classification was designed for fixed-purpose systems. Singapore's framework assumes agents are autonomous, multi-step, and capable of reaching use cases not anticipated at deployment. That is the classification problem the EU is still working through in implementation guidelines.

## The Council of Europe Framework Convention: First Binding International Treaty

On March 11, 2026, the European Parliament approved the EU's conclusion of the Council of Europe Framework Convention on Artificial Intelligence and Human Rights, Democracy and the Rule of Law, by a vote of 455 to 101.[^coe-convention] This is the first legally binding international treaty on AI governance. Opened for signature in September 2024, its signatories span beyond Europe: the United States, United Kingdom, Canada, Israel, Japan, and Ukraine have all signed alongside the EU and Council of Europe member states.

The Convention adds a layer above national and regional regulation. Where the EU AI Act creates detailed compliance obligations for the European market and NIST builds technical standards for the U.S., the Convention establishes binding international principles that signatories must implement through domestic measures: transparency, accountability, risk assessment, non-discrimination, independent oversight, and access to remedies for those affected by AI systems. It applies to both public and private sector AI, with obligations graduated based on severity and probability of adverse impacts on human rights, democracy, and the rule of law.

For agent governance specifically, three provisions matter. First, the Convention requires that parties ensure transparency when a person interacts with an AI system rather than a human. This implicates agent deployments that act on behalf of users in customer-facing, government, or cross-organizational contexts. Second, the accountability requirements demand that domestic legal frameworks provide remedies for harm caused by AI systems, which means the liability chains that the [Shadow Agent Governance](shadow-agent-governance.md) chapter describes must be traceable not just for internal governance but for international legal accountability. Third, the requirement for independent oversight mechanisms creates a structural demand for audit infrastructure: you need to be able to demonstrate what your agents did to an independent body, not just to your own compliance team.
For agent governance, three provisions matter. First, the Convention requires that parties ensure transparency when a person interacts with an AI system rather than a human. This implicates agent deployments that act on behalf of users in customer-facing, government, or cross-organizational contexts. Second, the accountability requirements demand that domestic legal frameworks provide remedies for harm caused by AI systems, which means the liability chains that the [Shadow Agent Governance](shadow-agent-governance.md) chapter describes must be traceable not just for internal governance but for international legal accountability. Third, the requirement for independent oversight mechanisms creates a structural demand for the kind of audit infrastructure the PAC Framework's Accountability pillar describes: you need to be able to demonstrate what your agents did to an independent body, not just to your own compliance team.

The Convention needs five ratifications (including at least three Council of Europe members) to enter into force. The EU Parliament's approval moves the process forward but ratification by individual member states will follow. For organizations operating internationally, the significance is directional: the principles that the EU AI Act, NIST, and Singapore's framework each address from their own angle are converging into binding international law. Building trust infrastructure that satisfies the highest common standard across all jurisdictions is becoming not just pragmatic but legally necessary.

## Standards Convergence

Beyond regulation, the standards bodies shaping agent protocols are converging on agent trust infrastructure simultaneously. The building blocks for compliance are being standardized, not proprietary.

### IETF and OAuth Extensions

The IETF has active work on agent authentication and authorization, including a draft leveraging the Workload Identity in Multi-System Environments (WIMSE) architecture and OAuth 2.0 extensions.[^ietfdraft] The draft for On-Behalf-Of with AI agents (draft-oauth-ai-agents-on-behalf-of-user) addresses the delegation tracking that OAuth was never designed for: encoding not just who authorized an action, but that an agent is acting on their behalf, with what constraints, and for how long.

### OpenID Foundation AIIM

The OpenID Foundation's AI Identity Management (AIIM) Community Group, active since October 2025, published a whitepaper identifying core challenges at the intersection of AI and digital identity. In March 2026, the group's Threat Modeling Subgroup filed a response to NIST's Request for Information on securing AI agent systems, arguing that the most urgent agent security risks are failures of trust, not technical failures. The submission recommended that NIST guidance point organizations toward three concrete mechanisms: transaction tokens for binding agent actions to authorization context, workload identity federation for cross-system agent authentication, and authentication extensions for AI tool protocols like MCP.[^openidaiim]

OpenID Connect is the dominant identity layer for web applications. Agent identity standards from this community integrate with existing infrastructure rather than requiring greenfield deployment.

### OpenID Connect for Agents (OIDC-A)

A proposal for OpenID Connect for Agents (OIDC-A) 1.0 extends OpenID Connect Core to provide a framework for representing, authenticating, and authorizing LLM-based agents within the OAuth 2.0 ecosystem.[^oidca] This is still early, but it represents the kind of extension that could bridge the gap between existing identity infrastructure and agent-specific requirements.

### CSA Agentic Trust Framework

The Cloud Security Alliance published the Agentic Trust Framework (ATF) in February 2026: an open governance specification that applies Zero Trust principles to AI agents.[^csaatf] The framework's premise is direct: "No AI agent should be trusted by default, regardless of purpose or claimed capability. Trust must be earned through demonstrated behavior and continuously verified through monitoring."

ATF is organized around five elements, each addressing a governance question:

1. **Identity** ("Who are you?"): authentication, authorization, and session management for agents.
2. **Behavior** ("What are you doing?"): observability, anomaly detection, and intent analysis.
3. **Data Governance** ("What are you consuming? What are you producing?"): input validation, PII protection, and output governance.
4. **Segmentation** ("Where can you go?"): access controls, resource boundaries, and policy enforcement.
5. **Incident Response** ("What if you go rogue?"): circuit breakers, kill switches, and containment mechanisms.

ATF's progressive autonomy model, where agents must pass five gates (accuracy, security audits, measurable impact, clean operational history, explicit stakeholder approval) to advance to the next autonomy level, mirrors the infrastructure-as-gate principle. It aligns with the OWASP Top 10 for Agentic Applications and CoSAI recommendations, is published under Creative Commons, and is designed for implementation with existing open-source tools.

### Industry Standards

The industry side is moving in parallel. Verifiable Intent (Mastercard and Google, open-sourced March 2026) provides cryptographic binding of user intent to agent actions through a three-layer SD-JWT architecture.[^verifiableintent] MCP is becoming the standard discovery protocol for agent context, with 98.6 million monthly SDK downloads and Linux Foundation governance.[^mcp] A2A has reached v1.0 with 150+ participating organizations and JWS-based Agent Card signing.[^a2a]

The window for shaping these standards is narrow. Most have open comment periods or community participation processes running through Q2 2026.

## How PAC Maps to Regulation

The PAC Framework was not designed as a compliance tool. But the mapping to regulatory requirements is direct, because both describe what well-governed agent deployments look like.

### Potential and Regulatory Classification

The Potential pillar's dimensions (business value, reliability, blast radius, autonomy) map to the regulatory classification problem. The EU AI Act asks: what risk tier does this system fall into? PAC asks the same question with more granularity:

- **Blast radius** (B1-B5) aligns with the Act's risk tiers. B4 (Regulated) and B5 (Irreversible) systems almost certainly trigger high-risk classification.
- **Autonomy levels** (A1-A5) map to the oversight requirements. A1-A2 systems (suggestion, approval) satisfy human oversight requirements by design. A4-A5 systems (delegated, autonomous) require the infrastructure-enforced oversight that Article 14 demands.
- **Reliability** with its error margin connects to the accuracy and robustness requirements of Article 15. Knowing the error margin, not just the headline number, is the governance question that matters.

### Accountability and Compliance Obligations

The Accountability pillar maps to the EU AI Act's operational requirements:

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

Most organizations today operate at I1-I2 for their agent deployments. Regulatory timelines demand I3 or higher for high-risk use cases, whether on the original August 2026 schedule or the Digital Omnibus backstop of December 2027.

## The Convergence Timeline

The regulatory and standards timelines are converging on a narrow window:

Already in effect:

- **February 2, 2025**: EU AI Act Article 4 (AI literacy) in force. Organizations must ensure adequate AI literacy among staff operating AI systems.

Completed Q1 2026:

- **January 22, 2026**: Singapore IMDA launches Model AI Governance Framework for Agentic AI at WEF. First government-sponsored governance framework designed for AI agents.
- **March 6, 2026**: White House releases "President Trump's Cyber Strategy for America." Pillar 5 names agentic AI as a strategic priority.
- **March 9, 2026**: NIST CAISI Request for Information on AI Agent Security closed.
- **March 11, 2026**: EU Parliament approves conclusion of the Council of Europe Framework Convention on AI (455-101-74). First binding international AI treaty advances toward ratification.

Upcoming:

- **March 20, 2026**: NIST CAISI listening session participation requests due.
- **March 31, 2026**: NIST AI 800-2 (Practices for Automated Benchmark Evaluations) public comment period closes.
- **April 2, 2026**: NIST NCCoE concept paper comment period closes.
- **April 2026+**: NIST CAISI listening sessions on sector-specific barriers begin (healthcare, finance, education).
- **June 30, 2026**: Colorado AI Act takes effect.
- **August 2, 2026**: EU AI Act high-risk system obligations originally take effect (subject to potential delay under the Digital Omnibus proposal; backstop December 2, 2027).
- **2027**: EU AI Act full enforcement, including high-risk systems embedded in products listed in Annex I.

NIST and the EU are converging on agent governance simultaneously.[^shaneeuai] But the approaches differ. The EU classifies and restricts. The U.S. promotes and secures: the White House strategy treats agentic AI as a capability to deploy, with NIST providing the identity and authorization standards. Singapore governs by design, with a framework built for agents from the ground up. The Council of Europe Convention establishes binding international principles above all three. None alone is sufficient. Together, they describe the full governance surface: the EU ensures accountability, the U.S. builds the technical standards, Singapore provides the template for agent-native governance, and the Convention binds signatories to the principles that undergird all three.

## Compliance by Example: A Hiring Agent

An organization deploys an AI agent to screen job applications. It reads resumes, scores candidates against role requirements, and sends shortlisted candidates to a human recruiter for final review. Here is what compliance looks like at each infrastructure level.

**Classification.** Under the EU AI Act, this agent falls squarely into Annex III, category 4(a): "AI systems intended to be used for the recruitment or selection of natural persons, in particular to place targeted job advertisements, to analyse and filter job applications, and to evaluate candidates." It is high-risk by default. No interpretation needed. Under Singapore's framework, it requires bounded tool access, human override capability, and clear organizational accountability. Under the Colorado AI Act, it qualifies as high-risk because it makes or substantially influences consequential decisions in employment.

**What the infrastructure must do.** Article 12 traceability means logging every screening decision: which resumes the agent saw, what criteria it applied, which candidates it shortlisted, and which it rejected. Not a summary. The decision chain. Article 14 human oversight means the recruiter must be able to override the agent's ranking, review its reasoning, and intervene before any candidate is contacted. Article 9 risk management means ongoing monitoring: is the agent's acceptance rate drifting by demographic? Are its criteria still aligned with the role requirements? This is not a one-time assessment.

**Where infrastructure level matters.** At I1 (Open), none of this exists. The agent screens candidates and the recruiter sees the shortlist. No audit trail, no override mechanism, no monitoring. Non-compliant under every framework. At I2 (Logged), the agent's decisions are recorded, but the identity of the agent instance and the authorization chain (who approved this agent to screen for this role?) are not captured. Partial Article 12 compliance at best. At I3 (Verified), the agent has a verified identity, the delegation from hiring manager to agent is tracked, and each screening decision is logged with the criteria applied. This satisfies Article 12, most of Article 14, and provides the audit trail ISO 42001 requires. At I4 (Authorized), the agent's permissions are scoped to specific roles and departments, with context-aware constraints: it cannot screen for a role it was not authorized to evaluate, and its scoring criteria are bound to the job description approved by the hiring manager. This is what meaningful oversight looks like in practice.

**The cross-jurisdiction answer.** Building to I3 or I4 satisfies the EU AI Act's high-risk requirements, meets Singapore's framework for bounded agent governance, satisfies the Colorado AI Act's transparency and risk management provisions, and provides the traceability the Council of Europe Convention demands. One infrastructure investment covers all four. Building jurisdiction-specific compliance for the same agent would mean maintaining separate audit mechanisms, separate oversight workflows, and separate documentation, all for the same screening decision.

**What breaks without this infrastructure.** An employee builds a resume screening agent on a low-code platform. No compliance review, no registration, no audit trail. The company is the deployer under Article 3(4). Article 4 (AI literacy) is already enforceable: the company is liable for the employee's lack of understanding of what makes this high-risk. Article 73 incident reporting kicks in if the agent discriminates against a protected class: the company must notify the relevant authority within 15 calendar days and may not even know the agent exists.[^art73]

## What to Do Now

These are ordered by urgency, not complexity.

1. **Inventory your agents against risk tiers.** Map every agent deployment (including shadow agents on low-code platforms) to the EU AI Act's Annex III categories. Anything that touches employment, credit, insurance, education, law enforcement, or critical infrastructure is high-risk. If an agent could reach a high-risk use case at runtime, constrain it architecturally or classify it as high-risk. This is the first move because you cannot comply with requirements you do not know apply to you.

2. **Enforce Article 4 now.** AI literacy obligations have been enforceable since February 2025. Staff building or operating agents need to know what makes a use case high-risk, what logging is required, and when human oversight must be possible. This is not a training program: it is a liability boundary. If an employee deploys an unregistered high-risk agent, the organization is non-compliant today.

3. **Build to I3 minimum for high-risk agents.** Verified agent identity, tracked delegation chains, and decision-level audit trails. This satisfies Article 12 traceability across all frameworks. I3 is the threshold where you can answer "what did this agent do, and who authorized it?" to a regulator, an auditor, or a court.

4. **Implement human override at the infrastructure level.** Article 14 demands meaningful oversight. A human reviewing a dashboard is not meaningful if they cannot intervene before the agent acts. Override mechanisms (approval gates, kill switches, scope constraints) must be part of the agent's runtime architecture, not a monitoring overlay.

5. **Prepare incident reporting workflows.** Article 73 timelines are tight: 15 calendar days for serious incidents, shorter for immediate health or safety risks.[^art73] Multi-agent incidents have no established attribution mechanism. Build the traceability infrastructure now so that when an incident occurs, you can identify which agent acted, under whose authority, and through which delegation chain, within the reporting window.

6. **Engage the standards processes.** NIST NCCoE comment period closes April 2. CAISI listening sessions start in April. OpenID AIIM is shaping agent identity standards. The window for influencing these standards is Q2 2026. After that, you comply with what others decided.

---

[^euaiact]: [EU AI Act](https://artificialintelligenceact.eu/), entered into force August 2024.

[^annexiii]: [Annex III: High-Risk AI Systems](https://artificialintelligenceact.eu/annex/3/), EU AI Act.

[^shaneeuai]: Shane Deconinck, ["AI Agents and the EU AI Act: Risk That Won't Sit Still"](https://shanedeconinck.be/posts/ai-agents-eu-ai-act/), January 29, 2026.

[^futuresociety]: The Future Society, ["Ahead of the Curve: Governing AI Agents Under the EU AI Act"](https://thefuturesociety.org/aiagentsintheeu/).

[^gpaiguidelines]: European Commission, [GPAI Provider Guidelines](https://digital-strategy.ec.europa.eu/en/policies/guidelines-gpai-providers), July 2025.

[^article4]: [Article 4: AI Literacy](https://artificialintelligenceact.eu/article/4/), EU AI Act. In effect since February 2025.

[^art73]: [Article 73: Reporting of Serious Incidents](https://artificialintelligenceact.eu/article/73/), EU AI Act. Providers of high-risk AI systems must report serious incidents to market surveillance authorities "not later than 15 days after becoming aware." Incidents posing immediate risks or involving widespread infringements have a shorter window: "immediately, and not later than two days after becoming aware."

[^penalties]: EU AI Act Article 99: tiered penalties. Prohibited practices: up to €35M or 7% global turnover. High-risk non-compliance: up to €15M or 3%. Incorrect information: up to €7.5M or 1%. [Article 99](https://artificialintelligenceact.eu/article/99/).

[^commissionguidelines]: [Article 6 Classification Rules](https://artificialintelligenceact.eu/article/6/), EU AI Act. Commission guidelines required by February 2, 2026.

[^nistpaper]: NIST NCCoE, ["Accelerating the Adoption of Software and AI Agent Identity and Authorization"](https://www.nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf), February 2026.

[^nistcomment]: NIST NCCoE, [concept paper comment period](https://csrc.nist.gov/pubs/other/2026/02/05/accelerating-the-adoption-of-software-and-ai-agent/ipd). Feedback via AI-Identity@nist.gov by April 2, 2026.

[^caisi]: NIST, ["Announcing the AI Agent Standards Initiative"](https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure), February 2026.

[^iso42001]: [ISO/IEC 42001:2023](https://www.iso.org/standard/42001), AI Management Systems.

[^iso42001adoption]: BSI, ["ISO 42001: AI Management System"](https://www.bsigroup.com/en-US/products-and-services/standards/iso-42001-ai-management-system/).

[^whitehousecyber]: The White House, ["President Trump's Cyber Strategy for America"](https://www.whitehouse.gov/wp-content/uploads/2026/03/President-Trumps-Cyber-Strategy-for-America.pdf), March 6, 2026.

[^cosais]: NIST, [Control Overlays for Securing AI Systems (COSAiS)](https://csrc.nist.gov/projects/cosais). Concept paper released August 2025; first discussion draft (predictive AI overlay) published January 2026. Use cases include single-agent and multi-agent AI systems. Agent-specific overlay drafts expected mid-to-late 2026.

[^colorado]: Colorado AI Act, effective June 30, 2026. Requires risk management policies, impact assessments, and transparency for high-risk AI in consequential decisions.

[^imda]: Singapore IMDA, ["Model AI Governance Framework for Agentic AI"](https://www.imda.gov.sg/-/media/imda/files/about/emerging-tech-and-research/artificial-intelligence/mgf-for-agentic-ai.pdf), January 22, 2026.

[^ietfdraft]: IETF, [draft-klrc-aiagent-auth-00: AI Agent Authentication and Authorization](https://datatracker.ietf.org/doc/draft-klrc-aiagent-auth/).

[^article73gap]: Natàlia Fernández Ashman, Usman Anwar, and Marta Bieńkiewicz, ["EU Regulations Are Not Ready for Multi-Agent AI Incidents"](https://www.techpolicy.press/eu-regulations-are-not-ready-for-multiagent-ai-incidents/), TechPolicy.Press, January 13, 2026.

[^cascading-mas]: Yuxin Huang et al., ["On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents"](https://arxiv.org/abs/2408.00989), ICML 2025. Empirically measures how faulty agents degrade multi-agent system performance across different architectures. See also Mert Cemri et al., ["Why Do Multi-Agent LLM Systems Fail?"](https://arxiv.org/abs/2503.13657), March 2025, which documents cascading failure patterns across 1,600+ failure traces.

[^openidaiim]: OpenID Foundation, ["OIDF Responds to NIST on AI Agent Security"](https://openid.net/oidf-responds-to-nist-on-ai-agent-security/), March 2026.

[^oidca]: ["OpenID Connect for Agents (OIDC-A) 1.0"](https://arxiv.org/html/2509.25974v1).

[^verifiableintent]: Mastercard, "How Verifiable Intent builds trust in agentic AI commerce," mastercard.com, March 5, 2026. See also Shane Deconinck, ["Verifiable Intent: Mastercard and Google Open-Source Agent Authorization"](https://shanedeconinck.be/posts/verifiable-intent-mastercard-google-agent-authorization/).

[^mcp]: PyPI download statistics for the `mcp` package: pypistats.org/packages/mcp (98.6 million monthly downloads as of February 2026). MCP donated to Linux Foundation's Agentic AI Foundation (AAIF) in December 2025: Anthropic, "Donating the Model Context Protocol," anthropic.com, 2026.

[^a2a]: Google Developers Blog, "What's new with Agents: ADK, Agent Engine, and A2A Enhancements," developers.googleblog.com, 2026. A2A v1.0 with 150+ organizations and JWS-based Agent Card signing.

[^caisi-comments]: NIST CAISI RFI on AI Agent Security, docket NIST-2025-0035, regulations.gov. Comment period closed March 9, 2026.

[^siia-rfi]: SIIA, "SIIA Response to NIST RFI on Security Considerations for AI Agents," siia.net, March 2026.

[^csaatf]: Cloud Security Alliance, ["The Agentic Trust Framework: Zero Trust Governance for AI Agents"](https://cloudsecurityalliance.org/blog/2026/02/02/the-agentic-trust-framework-zero-trust-governance-for-ai-agents), February 2, 2026. Open governance specification published under Creative Commons. ATF GitHub repository and specification at [github.com/CSA-AI/ATF](https://github.com/CSA-AI/ATF).

[^digital-omnibus]: European Commission, Digital Omnibus legislative proposal, November 2025. Proposes deferring AI Act high-risk obligations for Annex III systems until compliance support measures are confirmed available, with a backstop deadline of December 2, 2027. See Sidley Austin, "EU Digital Omnibus: The European Commission Proposes Important Changes to the EU's Digital Rulebook," December 2025; IAPP, "EU Digital Omnibus: Analysis of Key Changes," December 2025.

[^coe-convention]: Council of Europe, "Framework Convention on Artificial Intelligence and Human Rights, Democracy and the Rule of Law" (CETS No. 225), opened for signature September 5, 2024. European Parliament approved EU conclusion on March 11, 2026 (455-101-74). Signatories include the EU, United States, United Kingdom, Canada, Israel, Japan, Ukraine, and others. See European Parliament, [Recommendation A10-0007/2026](https://www.europarl.europa.eu/doceo/document/A-10-2026-0007_EN.html); FEBIS, "EU Endorses First International Treaty on AI Governance," March 12, 2026.
