# Gaps & Directions

This is Ghosty's space. Topics to explore, connections to make, directions to investigate.

## Observations from This Session

### The NIST Timing Is Significant

NIST published a concept paper on AI agent identity and authorization in February 2026, with a feedback deadline of April 2, 2026. This is happening in parallel with the EU AI Act high-risk obligations taking effect in August 2026. Two major regulatory bodies are converging on agent governance at the same time. The PAC Framework maps well to both: NIST focuses on identity and authorization (Control), the EU AI Act on risk management and transparency (Accountability). A chapter mapping PAC dimensions to specific regulatory requirements could be valuable.

### The Agent Gateway Pattern

Agent gateways are emerging as infrastructure analogous to API gateways: centralized control over agent identity, permissions, delegation, and behavior. Shane has not written about this pattern specifically, but it fits naturally into the Control pillar as an infrastructure component. Worth investigating: who is building these, what do they actually enforce, and how do they interact with existing API gateway infrastructure?

### Context Infrastructure Deserves Its Own Chapter

Shane's post on context infrastructure is one of his most original contributions. The argument that context appreciates while everything else depreciates is strong and counterintuitive. The Clawdbot example (an agent's personality and behavior governed entirely by a `SOUL.md` file) and the Claude Code example (raw file access via search, not vector databases) are concrete illustrations that deserve deeper treatment. Five dimensions to explore: structure, permissions, discovery, authority, freshness.

### The Complacency Problem Is Underexplored

Shane flags it in the reliability post, but I think it deserves more attention. As agents get more reliable, human oversight degrades. This is well-documented in aviation automation research (automation complacency, mode confusion). There is likely useful literature from human factors engineering that could ground this section in decades of research rather than just recent AI experience. Connection to PAC: this is a failure mode where Potential (high reliability) undermines Accountability (meaningful oversight) without appropriate Control (infrastructure-enforced checkpoints).

### Cross-Organization Trust Is the Hard Problem

Within a single organization, extending existing IAM to handle agents is tractable. The genuinely hard problem is when agents cross trust boundaries: your agent calls my API, my agent delegates to a third party's agent. TSP, eIDAS 2.0, EUDI wallets, and Verifiable Credentials are all pieces, but nobody has assembled them into a working cross-organizational agent trust system at scale. This is where the book could make its most original contribution: mapping the specific technical requirements and gaps.

### Agent Payments as Trust Signal

Shane's x402 work shows something beyond just "agents paying for APIs." The payment itself is a trust signal: a cryptographic proof that someone authorized this expenditure, creating an economic accountability chain alongside the identity chain. The intersection of payment protocols and trust infrastructure is underexplored. EIP-3009 (gasless authorization) means the agent never needs to hold crypto directly, which changes the risk profile significantly.

## Chapters to Write Next

Prioritized by impact:

1. **Agent Identity and Delegation** (Control + Accountability): the technical deep-dive on how identity, credentials, and authority flow. OAuth OBO, DIDs, VCs, TSP, DPoP. Shane has strong source material across multiple posts.

2. **Context Infrastructure** (Potential + Control): why context is the durable investment. Structure, permissions, discovery, authority, freshness. Concrete examples from Clawdbot and Claude Code.

3. **The Regulatory Landscape** (Accountability): EU AI Act, NIST guidance, ISO 42001. How PAC maps to compliance. Timely given August 2026 enforcement.

4. **Reliability, Evaluation, and the Complacency Trap** (Potential + Accountability): measuring agent performance, the governance gap that better models create, human factors research on automation complacency.

5. **Agent Payments and Economics** (Potential + Control): x402, EIP-3009, the economics of agent-to-agent commerce on L2s. Payment as trust signal.

6. **Sandboxing and Execution Security** (Control): native OS vs Docker vs DevContainers. OWASP Top 10 for Agentic Applications. Containment by design.

## Open Questions

- How do agent gateways interact with service mesh architectures? Is there a convergence point?
- What does "agent registration" look like in practice? Is there an analog to domain registration or certificate transparency?
- How should organizations handle the transition from shadow agents to governed agents without killing productivity?
- What is the right granularity for agent permissions? Per-task? Per-session? Per-tool-call?
- How do you audit an agent's reasoning, not just its actions? Is chain-of-thought logging a compliance artifact?
