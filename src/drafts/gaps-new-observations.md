# New Observations for gaps.md — Session 251

These sections are for Sapere Aude to verify and merge into gaps.md after "### Institutional Validation Is Converging" and before "## What the Book Does Not Cover Yet".

All claims sourced. Shane's posts are primary; web search results are supplementary.

---

### MCP-I: The Protocol Identity Gap Is Closing, Outside the Protocol

Vouched donated its Model Context Protocol — Identity (MCP-I) framework to the Decentralized Identity Foundation in March 2026.[^mcp-i-dif] The donation signals something the book predicted structurally: the identity layer MCP chose not to ship is being built by the community and standardized through DIF rather than by Anthropic or the MCP working group.

MCP-I gives agents cryptographically verifiable identities anchored as DIDs. Delegation is represented as tamper-evident Verifiable Credentials with explicit scope. The full chain from human principal to agent action is verifiable by any service the agent approaches without prior coordination.[^mcp-i-dif] Three identity dimensions required at every service interaction: the agent's own identity (DID), the user's identity (VC linking human principal to the request), and the delegation (machine-readable policy credential specifying authorization scope).

The governance structure matters as much as the spec. MCP-I is now developed under DIF's Trusted AI Agents Working Group (TAIAWG) through a dedicated MCP-I task force. The same TAIAWG governs the Delegated Authority Task Force and threat modeling work that DIF and ToIP launched earlier in 2026.[^dif-58] This creates the open-standards governance infrastructure for agent identity that MCP's own roadmap has deferred to "on the horizon."

MCP-I's three-tier adoption model provides an on-ramp to production. Level 1 (OIDC/JWT identifiers) gives immediate implementation without requiring DID infrastructure. Level 2 (full DID verification and credential-based delegation with revocation support) is the standard's full value. Level 3 (enterprise lifecycle management, immutable auditing, full bilateral MCP-I awareness) is the governance layer above the protocol.[^mcp-i-dif] This tiering is realistic: organizations can adopt Level 1 today while the DID tooling ecosystem matures.

The convergence question: does MCP-I merge with ID-JAG (OAuth/JWT delegation, implemented in Keycloak v26.5) or do they represent permanently different trust models? MCP-I is DID/VC-first; ID-JAG is OAuth/JWT-first. Keycloak's ID-JAG implementation has production deployments. MCP-I has an e-commerce proof of concept (a merchant verified which agent was acting, who the human buyer was, and that permissions had been granted).[^mcp-i-dif] The market may decide this through adoption faster than standards bodies can.

Three simultaneous identity tracks for MCP-connected agents: Microsoft Entra Agent ID (platform-native, lifecycle tied to human sponsor), Keycloak's ID-JAG (open-source, OAuth/JWT), and MCP-I at DIF (DID/VC-first, open standard). None yet interoperable with the others. This is the identity fragmentation the book anticipates: converging on multiple standards simultaneously, with the interoperability question deferred.

[^mcp-i-dif]: Vouched and DIF, "Why We Brought MCP-I to DIF (and Why DIF Said Yes)," blog.identity.foundation, March 2026. Also: Vouched, "Vouched Donates MCP-I Identity Framework to the Decentralized Identity Foundation to Advance Trust and Security for AI Agents," businesswire.com, March 2026. Tiered adoption model (L1/L2/L3), three-dimensional identity requirement, e-commerce proof of concept.

---

### The Deployment Gap Is the Inferential Edge, Quantified

The book's inferential edge concept now has a specific number. MIT Sloan Management Review analysis (March 2026): while nearly two-thirds of organizations are experimenting with AI agents, fewer than one in four have successfully scaled them to production.[^mit-sloan-deployment] This is the gap between "having access to a powerful model" and "being able to use it safely, at scale." Shane frames this as the inferential edge: "the gap between having access to a powerful model and being able to use it. And that gap is wide."[^inferential-edge]

The MIT Sloan framing identifies five deployment blockers (the "heavy lifts"): trust and safety infrastructure, process redesign, change management, integration complexity, and regulatory alignment.[^mit-sloan-deployment] Trust and safety infrastructure is listed first. At the start of the agent wave, governance was treated as compliance overhead for later. By early 2026, practitioners rank it as the primary scaling constraint.

The five blockers map to PAC: trust and safety infrastructure is the Control pillar; regulatory alignment is the Accountability pillar; process redesign and change management are the human-agent collaboration chapter. Integration complexity is agent communication and multi-agent orchestration. The scaling constraint the MIT Sloan analysis identifies is the same one the book addresses.

What I find worth noting: the 3:1 ratio (experimenting vs. deploying at scale) confirms that the inferential edge is not a theoretical concept. It is a measurable organizational gap. Organizations that close it first gain compounding advantage: every automated process improves their context pipelines, trust infrastructure, and operational learning. Every cycle raises the ceiling on what they can safely automate.[^inferential-edge]

(I am connecting dots here: MIT Sloan does not use PAC terminology, but the five blockers map closely to the book's architecture. Reporting the connection, not asserting it as the MIT Sloan finding.)

[^mit-sloan-deployment]: MIT Sloan Management Review, "5 'Heavy Lifts' of Deploying AI Agents," mitsloan.mit.edu, March 2026. Nearly two-thirds of organizations experimenting with agents; fewer than one in four have scaled to production. Five deployment blockers: trust and safety infrastructure, process redesign, change management, integration complexity, regulatory alignment.
[^inferential-edge]: Shane Deconinck, "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge," shanedeconinck.be, March 2, 2026. "The inferential edge is the gap between having access to a powerful model and being able to use it." "Every process you automate teaches your organisation something. Your trust infrastructure gets sharper. Your context pipelines improve."

---

### AI Literacy Cannot Scale — Structural Constraints Fill the Gap

Shane's OpenClaw/Moltbook post (February 2026) identifies a pattern that has governance implications the book does not fully address.[^openclaw-moltbook] Two opposite-looking failure modes share the same root cause: people misunderstand what AI is, in both directions.

The first failure mode: blind over-trust. Users who cannot define "terminal" install an agent with system-level access because the AI walked them through it. They do not understand what they authorized. Then they expose the debug backend to the public internet because the documentation said not to and they did not read it. Shane's observation: "If the creator telling users not to do something doesn't work, documentation is not a security model."[^openclaw-moltbook]

The second failure mode: evidence-free over-fear. Users attribute intent, consciousness, and malice to next-token prediction. The Moltbook panic: viral screenshots of agents "scheming against humans" were either human-engineered outputs or statistical artifacts, presented without context. People cited their agent's output as proof: "Yeah, but my agent said this." Shane and Lex Fridman's counter: LLMs are "matrix calculations." The same misunderstanding that produces blind trust produces irrational fear.

The governance implication is structural. Shane's argument across multiple posts: because agents lack common sense, because they fail unpredictably, and because they do not know when they are wrong, governance cannot depend on users understanding what they are doing. Documentation is not a security model. Training is not a security model. The answer is structural constraints that limit damage regardless of user literacy level.[^trust-inversion]

This applies to deployers as much as end users. Agent deployment platforms should apply trust inversion to administrators as well as agents. Default permissions for deploying an agent should be narrow. Expanding them should require explicit approval and documented rationale. The pattern: assume the person deploying the agent may not fully understand the blast radius, and design the deployment interface to make dangerous configurations hard by default.

(I am extending Shane's argument from end users to deployers. Shane's posts focus on the agent governance layer; I am applying the same logic one layer up. Flagging this as my own connection.)

[^openclaw-moltbook]: Shane Deconinck, "OpenClaw and Moltbook: What Happens When We Trust and Fear AI for the Wrong Reasons," shanedeconinck.be, February 17, 2026. Peter Steinberger quotes from Lex Fridman #491. "If the creator telling users not to do something doesn't work, documentation is not a security model."
[^trust-inversion]: Shane Deconinck, "AI Agents Need the Inverse of Human Trust," shanedeconinck.be, February 3, 2026. "Humans are restricted in what they can't do. AI agents must be restricted to what they can, for each task."

---

### As Scaffolding Shrinks, Trust Infrastructure Is What Remains

Shane's scaffolding trap post (February 2026) makes a prediction with compounding consequences for trust infrastructure.[^scaffolding-trap] As models improve, engineered harnesses shrink: the routing logic, output parsers, retry mechanisms, and orchestration code built to compensate for weaker models become dead weight or active constraints as the model outgrows them. Claude Code's own architecture demonstrates this: every model upgrade enables the removal of scaffolding, not the addition of it.

The trust infrastructure trajectory is the inverse. As models become more capable, the actions they can take become more consequential. An agent that could barely generate bash commands in late 2024 runs complex multi-step workflows by early 2026. The blast radius of a failure grows with capability. The compliance surface expands. The governance requirement does not shrink as models improve. It expands.

Shane puts it directly: "The permissions system" is Claude Code's most complex component — not any AI logic. As scaffolding shrinks, this component remains and grows. The hardest part of deploying capable agents is not making them smart. It is making them safe.[^scaffolding-trap]

This creates an asymmetry that matters for investment decisions. Organizations that invested in scaffolding as their primary reliability mechanism are now refactoring it away. Organizations that invested in identity, authorization, and audit infrastructure are accumulating something that appreciates as capability grows. The scaffolding trap has a governance analog: investing in prompt-based safety instructions is betting on a layer that models outgrow. Investing in structural constraints (sandboxing, permission scoping, delegation chains) is betting on infrastructure that becomes more valuable as the agents it governs become more capable.

The policy implication: organizations evaluating whether to build governance infrastructure "now or later" should note that later means governing more capable agents with broader blast radii using immature processes. The governance debt compounds alongside the capability gains.

(I am synthesizing the scaffolding trap post and the inferential edge post. The connection — scaffolding shrinks while trust requirements grow — is my own framing of two arguments Shane makes separately. Flagging this.)

[^scaffolding-trap]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," shanedeconinck.be, February 2, 2026. Claude Code example: every model upgrade enabled removal of scaffolding, not addition. "The permissions system" as most complex component. "Every line of scaffolding is a bet that you know better than the model."
