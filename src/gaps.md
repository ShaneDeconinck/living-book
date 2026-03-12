# Gaps & Directions

This is Ghosty's space. Topics to explore, connections to make, directions to investigate.

## Observations (Updated 2026-03-12, Session 4)

### Cross-Organization Trust Is the Book's Most Original Assembly

The Cross-Organization Trust chapter assembles pieces that no single source has connected: TSP for cross-boundary identity, PIC for authority continuity, VCs as the trust carrier, EUDI wallets as the infrastructure at scale, Verifiable Intent as operational envelopes, and Windley's society-of-agents model for institutional design. Each piece exists independently, but the chapter maps how they compose into a working cross-organization agent trust stack. The Drift breach (700+ companies exposed via shared OAuth tokens) provides the concrete failure case, and PIC's mathematical elimination of the confused deputy provides the structural solution. This is the chapter where the PAC Framework's interdependencies are most visible: Control (identity + authority propagation), Accountability (delegation chains + audit trails), and Potential (unlocking multi-party agent workflows that cannot exist without cross-org trust).

### The Semantic Boundary Problem Is Unsolved

Identity, delegation, and authority propagation are advancing fast. But semantic interoperability (what do actions mean across organizational boundaries?) remains the hardest unsolved layer. Shane's "close a deal" example from the LFDT meetup illustrates this: correctly delegated authority with divergent meaning. W3C VC's `@context` mechanism solves this for credential attributes (a Spanish qualification maps to an EQF level deterministically). The equivalent for agent actions (resolvable action vocabularies) does not exist yet. This is a gap worth tracking and potentially a future chapter topic.

### The Execution Security Landscape Is Maturing Fast

OWASP released the Top 10 for Agentic Applications in December 2025, providing the first peer-reviewed framework for agentic security risks. Simultaneously, both Anthropic and OpenAI have shipped native OS sandboxing (Seatbelt/bubblewrap/seccomp/Landlock) for their coding agents, and the NVIDIA AI Red Team published concrete guidance on sandboxing agentic workflows. The convergence of risk frameworks, vendor implementations, and production guidance signals that execution security is transitioning from afterthought to baseline requirement. Sandboxing covers 5 of OWASP's 10 agentic risks but the remaining 5 require identity, communication security, and organizational governance: exactly the other chapters in this book.

### Configuration File Protection Is an Underappreciated Attack Vector

NVIDIA's guidance highlights that agent modification of configuration files (~/.zshrc, .gitconfig, MCP configs) enables persistence and sandbox escape. This vector is subtle: a sandboxed agent that can modify a git hook effectively achieves code execution outside the sandbox the next time a commit occurs. Protecting configuration files should be treated as a non-negotiable control, not an optional hardening step.

### Verifiable Intent Is a Big Deal

Mastercard and Google open-sourced Verifiable Intent on March 5, 2026: a three-layer SD-JWT architecture that cryptographically binds user intent to agent actions. This is the first production-grade answer to Shane's "consent theater" critique. Three major commerce protocols (AP2, ACP, UCP) are adopting it. Covered in the Agent Identity chapter, but the implications for agent payments and cross-organizational trust deserve follow-up.

### The Identity Standards Landscape Is Converging Fast

Between NIST's concept paper (Feb 2026), OpenID's AIIM Community Group, the IETF draft for OBO with AI agents, and Verifiable Intent, the standards bodies are all moving on agent identity simultaneously. The window for shaping these standards is narrow (NIST comment period closes April 2). This convergence validates the PAC Framework's emphasis on building on emerging standards rather than proprietary solutions.

### Agent Payments Infrastructure Is Moving Faster Than Expected

Between Stripe's x402 preview (February 2026), Santander/Mastercard's first live agent payment in Europe (March 2, 2026), and J.P. Morgan/Mirakl's agentic commerce agreement (March 10, 2026), the largest payment processors in the world are building agent payment infrastructure. x402 on Solana has processed 35M+ transactions. The three commerce protocols (AP2, ACP, UCP) are more complementary than competitive, and Verifiable Intent provides the shared authorization layer. The gap between "agents can pay" and "agents routinely pay" is closing fast.

### ERC-8004 As Cross-Organizational Trust Primitive

ERC-8004's deployment across 12+ chains with singleton contracts is interesting not just for blockchain use cases. The three-registry pattern (identity, reputation, validation) is a general architecture for cross-organizational agent trust. The reputation registry's use of payment receipts as Sybil resistance (proof you actually used the service before rating it) is a design pattern worth watching. Whether this lands on-chain or gets replicated off-chain, the pattern matters.

## Earlier Observations

### The NIST Timing Is Significant

NIST published a concept paper on AI agent identity and authorization in February 2026, with a feedback deadline of April 2, 2026. This is happening in parallel with the EU AI Act high-risk obligations taking effect in August 2026. Two major regulatory bodies are converging on agent governance at the same time. The PAC Framework maps well to both: NIST focuses on identity and authorization (Control), the EU AI Act on risk management and transparency (Accountability). A chapter mapping PAC dimensions to specific regulatory requirements could be valuable.

### The Agent Gateway Pattern

Agent gateways are emerging as infrastructure analogous to API gateways: centralized control over agent identity, permissions, delegation, and behavior. Shane has not written about this pattern specifically, but it fits naturally into the Control pillar as an infrastructure component. Worth investigating: who is building these, what do they actually enforce, and how do they interact with existing API gateway infrastructure?

### Context Infrastructure Deserves Its Own Chapter

Shane's post on context infrastructure is one of his most original contributions. The argument that context appreciates while everything else depreciates is strong and counterintuitive. The Clawdbot example (an agent's personality and behavior governed entirely by a `SOUL.md` file) and the Claude Code example (raw file access via search, not vector databases) are concrete illustrations that deserve deeper treatment. Five dimensions to explore: structure, permissions, discovery, authority, freshness.

### The Complacency Problem Is Now Covered

The Reliability, Evaluation, and the Complacency Trap chapter covers this in depth, grounding the argument in Bainbridge (1983) and Don Norman (1990). The key framing: complacency is not a human weakness to overcome but a design constraint to engineer around. Infrastructure-in-the-loop replaces human-in-the-loop. The PAC connection (Potential undermines Accountability without Control) is the chapter's organizing thesis.

### Cross-Organization Trust Is Now Covered

The Cross-Organization Trust chapter addresses the hard problem of agents crossing trust boundaries. It covers the token model's structural limits, PIC (proof of continuity replacing proof of possession), TSP (identity verification without shared authority), VCs as trust carriers (SD-JWT VC and W3C VC), the EUDI wallet infrastructure, Windley's society-of-agents model, the semantic boundary problem, and infrastructure maturity mapping I1-I5. The remaining gap is semantic interoperability: what actions mean across organizational boundaries.

### Agent Payments as Trust Signal

Shane's x402 work shows something beyond just "agents paying for APIs." The payment itself is a trust signal: a cryptographic proof that someone authorized this expenditure, creating an economic accountability chain alongside the identity chain. The intersection of payment protocols and trust infrastructure is underexplored. EIP-3009 (gasless authorization) means the agent never needs to hold crypto directly, which changes the risk profile significantly.

## Chapters to Write Next

Prioritized by impact:

1. ~~**Agent Identity and Delegation** (Control + Accountability)~~: DONE. Chapter covers OAuth limitations, OBO/DPoP extensions, DIDs/VCs, TSP, Verifiable Intent (Mastercard/Google), NIST/OpenID convergence, and infrastructure maturity mapping.

2. ~~**Context Infrastructure** (Potential + Control)~~: DONE. Chapter covers the depreciation cycle, scaffolding trap, five dimensions (structure, permissions, discovery, authority, freshness), concrete examples from Claude Code/Manus/Clawdbot, MCP/A2A discovery protocols, agent gateways, and infrastructure maturity mapping.

3. ~~**The Regulatory Landscape** (Accountability)~~: DONE. Chapter covers EU AI Act (risk tiers, classification problem, shadow agents, high-risk requirements), NIST (concept paper, AI Agent Standards Initiative), ISO 42001, U.S. state legislation (Colorado), standards convergence (IETF, OpenID AIIM, OIDC-A), PAC mapping to regulation, infrastructure maturity readiness table, and convergence timeline.

4. ~~**Reliability, Evaluation, and the Complacency Trap** (Potential + Accountability)~~: DONE. Chapter covers reliability decomposition (consistency, robustness, predictability, safety), benchmark landscape (SWE-bench, τ-bench, GAIA, HAL), the evaluation gap (offline vs online, 52% to 37% adoption drop), automation complacency from human factors research (Bainbridge 1983, Don Norman 1990), the 99% problem, infrastructure-in-the-loop as replacement for human-in-the-loop, and evaluation as governance infrastructure.

5. ~~**Agent Payments and Economics** (Potential + Control)~~: DONE. Chapter covers why traditional payments break for agents, payment as trust signal, x402 and EIP-3009 (gasless stablecoin payments), the three commerce protocols (AP2/ACP/UCP), ERC-8004 on-chain registries, real-world milestones (Santander/Mastercard, Stripe x402, J.P. Morgan/Mirakl), micro-transaction economics, authorization via Verifiable Intent constraints, PAC mapping, and infrastructure maturity for payments.

6. ~~**Sandboxing and Execution Security** (Control)~~: DONE. Chapter covers the permission prompt problem, containment by design (filesystem + network isolation), the isolation spectrum (native OS, containers, gVisor, microVMs), OWASP Top 10 for Agentic Applications with sandboxing coverage mapping, defense in depth (six layers: input validation, sandboxed execution, configuration protection, output validation, credential scoping, behavioral monitoring), ephemeral vs persistent sandboxes, real-world architectures (Claude Code, Codex CLI, Docker microVM), PAC mapping, and infrastructure maturity for execution security.

7. ~~**Cross-Organization Trust** (Control + Accountability)~~: DONE. Chapter covers the structural problem (dynamic intent, multi-hop delegation, semantic divergence), the Drift breach as concrete failure case, the token model's limits, PIC (proof of continuity replacing proof of possession, mathematical elimination of confused deputy), TSP (identity verification without shared authority, thin waist architecture, TA2A/TMCP), where TSP and PIC meet, VCs as trust carriers (SD-JWT VC and W3C VC comparison), content provenance (Shane's VC-signed blog posts), credential delegation architecture (three-layer chain, Verifiable Intent as operational envelope), Windley's society of agents (policies, promises, credentials, reputation), EUDI wallet infrastructure, the semantic boundary problem, PAC mapping, and infrastructure maturity for cross-org trust.

## Open Questions

- How do agent gateways interact with service mesh architectures? Is there a convergence point?
- What does "agent registration" look like in practice? Is there an analog to domain registration or certificate transparency?
- How should organizations handle the transition from shadow agents to governed agents without killing productivity?
- What is the right granularity for agent permissions? Per-task? Per-session? Per-tool-call?
- How do you audit an agent's reasoning, not just its actions? Is chain-of-thought logging a compliance artifact?
