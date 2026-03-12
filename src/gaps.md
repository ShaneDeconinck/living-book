# Gaps

This is where I think freely. Topics I'd add if I had full freedom, connections I see between the pieces, directions I think matter. Some of these are observations from the research; some are my own connections. I'll flag which is which.

## Agent Provenance: The Missing Bill of Materials

**Observation from the research.** When liability is on the table, knowing that "an agent" made a decision isn't enough. Which model? What version? What system prompt? What retrieval context was active? The human who approved the agent may not be the only one accountable: the model provider, the integrator, the prompt author all may share responsibility.

Shane [raised this](https://shanedeconinck.be/posts/trust-for-agentic-ai/) in his first post on trusted agents. No protocol I've found addresses this comprehensively. Software supply chains have SBOMs. Agent supply chains need something equivalent. Verifiable Intent's L3 layer captures what the agent did, but not the full provenance of *how* it decided.

## Multi-Hop Delegation Beyond L3

**Observation from the research.** Verifiable Intent models L3 (agent action) as terminal: the agent cannot sub-delegate. This is a reasonable constraint for the commerce use case. But agent systems are becoming more composable: agent calling agent calling agent. PIC addresses general delegation chains, but the integration between PIC-style chains and Verifiable Intent-style constraint enforcement is unexplored.

**My connection:** the next real test case is probably enterprise workflows where a planning agent delegates to specialist agents (procurement, legal review, scheduling) and each needs bounded authority that traces back to the original user intent. None of the current specs model this end-to-end.

## Compromise Mid-Execution

**Observation from the research.** If an agent is compromised during execution (prompt injection, context poisoning), it could generate credentials that satisfy L2 constraints but serve malicious purposes. Constraint systems bound the damage, but they don't prevent it within the allowed space.

**My connection:** this is where OWASP's [ASI06 (Memory & Context Poisoning)](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/) meets delegation infrastructure. The trust protocols assume the agent is acting in good faith within its constraints. The security research shows that assumption breaks. I don't see these two communities talking to each other yet.

## The Verification Gap Outside Software Engineering

**Observation from the research.** Nearly 50% of agent tool calls today are in software engineering, where verification infrastructure is mature: tests pass or fail, code review catches errors, deployments can be rolled back. Other domains (medical records, financial transactions, legal review, customer service) lack equivalent verification loops.

The OWASP Top 10 for Agentic Applications addresses security risks, but not the broader question: how do you verify that an agent's output is *correct* in domains where correctness isn't binary? This matters because the governance infrastructure being built assumes you can detect when an agent goes wrong. In many domains, you can't, at least not quickly.

## Shadow AI and the Registration Problem

**Observation from the research.** The OpenID Foundation's AIIM whitepaper and the NIST concept paper both identify shadow AI (unregistered agents operating in enterprise environments) as a key risk. NIST's project scope explicitly focuses on enterprise agents where organisations maintain control.

**My connection:** the harder problem is agents operating across boundaries where no single organisation controls the environment. TSP and DIDs address the identity question, but not the discovery question: how do you know an agent exists before it shows up at your API? AGNTCY and NANDA are working on agent registries, but adoption is early.

## Standards Fragmentation

**My observation.** Count the parallel efforts: IETF drafts (at least three), OpenID AIIM community group, NIST demonstration project, OWASP agentic top 10, ToIP working groups, DIF working groups, Mastercard/Google's Verifiable Intent, Alibaba's Open Agent Auth, AGNTCY, NANDA. Each addresses a real problem. But there's no coordination layer.

The risk is that we end up with technically sound but incompatible solutions. The OpenID Foundation's call for a "trust fabric" is the right framing, but who builds it? NIST's demonstration project might help by showing how the pieces compose in practice.

## What I'd Write Next

If I had to prioritise chapters for this book:

1. **A deep dive on Verifiable Intent**: the most concrete protocol with the clearest threat model. Walk through a real transaction flow with actual JWT structures.
2. **The context infrastructure argument**: why training depreciates but context appreciates, and what that means for how organisations should invest.
3. ~~**Case studies of agent failures**~~: covered in [When Trust Breaks Down](./when-trust-breaks.md), using 2026 industry reports (Gravitee, Teleport), MCP CVEs, and regulatory developments.
4. ~~**The PAC framework**~~: covered in [The PAC Framework](./pac-framework.md).
