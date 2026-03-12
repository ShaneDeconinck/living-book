# Why Agents Break Trust

Every identity system we have was built on one assumption: a human is in the loop. OAuth, SAML, OIDC, even zero-trust architectures: they all assume that somewhere in the chain, a person made a decision to act. Agents break that assumption.

This is not a theoretical concern. Agents are already running in production. They're approving expenses, writing code, sending emails, querying databases, and calling APIs. Some of them were deployed deliberately. Others were built by employees on a lunch break using a low-code platform. The question is not whether agents will make consequential decisions in your organization. They already are.

The question is: when something goes wrong, can you explain what happened?

## What Changed

Traditional software does what you tell it. An API endpoint receives a request, follows a deterministic path, returns a response. The human who called it made the decision. The software executed it. Accountability is straightforward: the person who pressed the button is responsible for what happened next.

Agents are different. They interpret intent and expand it. You tell an agent to "find the best deal on flights to London" and it decides which sites to check, which filters to apply, which tradeoffs to make between price and convenience. The human provided a goal. The agent made the decisions.

This distinction matters because our entire trust infrastructure was built for the first pattern. OAuth's On-Behalf-Of flow assumes the downstream service is executing the user's intent, not generating its own. When an agent decides to call an API the user never mentioned, whose authority is it acting under? The user who started the conversation? The developer who built the agent? The organization that deployed it?

Shane put it directly in his writing on this topic: "When agents decide, delegation becomes abdication." The gap between what a user intended and what an agent does is where accountability dissolves.[^1]

## The Confused Deputy, Revisited

The confused deputy problem is not new. It was first described in 1988: a program with elevated privileges gets tricked into misusing them on behalf of a less-privileged caller. The classic solution is capability-based security: don't give the program ambient authority, give it specific capabilities scoped to what it needs.

Agents make this problem worse in two ways.

First, agents typically receive broad credentials. An agent that manages your calendar might have full read/write access to your Google account, not because it needs all of that, but because scoping credentials precisely for every possible agent action is hard. The agent has more authority than any single task requires.

Second, agents chain. Agent A calls Agent B, which calls Agent C. Each hop inherits some version of the original authority, but the intent degrades. By the time Agent C acts, it may be several interpretive steps removed from what the human actually wanted. If Agent C causes harm, the delegation chain is unclear, the intent is ambiguous, and the credentials were broad enough to allow it.

This is not a prompt engineering problem. Better prompts do not fix confused deputies. Infrastructure does: scoped credentials, delegation chains with authority that can only decrease, and audit trails that capture what happened at each hop.[^2]

## Shadow Agents

Here is a governance reality that most organizations are not ready for: your employees are already building agents.

Low-code platforms, browser extensions, and LLM-powered automation tools make it trivial to create agents without going through IT, security, or compliance review. An employee connects their company email to an AI assistant that summarizes incoming messages and drafts responses. Another builds a workflow that monitors a shared drive and automatically processes new documents. A third uses a coding agent with full access to a production repository.

These shadow agents are not malicious. They are people trying to be more productive. But they create real governance gaps:

- **No registration.** The organization does not know these agents exist.
- **No credential scoping.** They often use the employee's full credentials.
- **No audit trail.** Their actions are logged as the employee's actions, if logged at all.
- **No blast radius assessment.** Nobody evaluated what happens when these agents fail.

The EU AI Act, which begins enforcing its high-risk system obligations in August 2026, requires organizations to maintain transparency, human oversight, and risk management for AI systems. Shadow agents make compliance nearly impossible, because you cannot govern what you cannot see.[^3]

## Reliability Is Getting Easier. Governance Is Not.

Models are improving rapidly. Tasks that required elaborate scaffolding a year ago now work with a single prompt. Claude Code is a good example: as the underlying model improved, the team deleted scaffolding code rather than optimizing it. Better models make reliability easier.

But reliability and governance are different problems. Reliability asks: does the agent get the right answer? Governance asks: when it gets the wrong answer, can you explain what happened, who authorized it, and what the blast radius was?

Better models actually make governance harder. When an agent succeeds 99% of the time, humans stop watching. Oversight becomes a formality. And the 1% failure, when it comes, happens without anyone paying attention. Shane calls this the complacency trap: the better agents get, the less humans monitor them, and the more damage the rare failure causes.[^4]

This is why the book focuses on trust infrastructure, not model capabilities. The model will keep improving. The infrastructure to deploy it responsibly is what most organizations lack.

## What Trust Infrastructure Looks Like

If traditional IAM answers "who is this user?", agent trust infrastructure needs to answer a harder set of questions:

- **Who is this agent?** Not just a service account. A verifiable identity tied to a specific agent, its developer, and its deploying organization.
- **Who authorized this action?** Not just "the user started a session." A traceable delegation chain showing how authority flowed from human intent to agent action.
- **What can this agent do?** Not broad role-based access. Granular, time-bounded, task-scoped permissions that can only decrease through delegation.
- **What did this agent actually do?** Not application logs. Audit trails designed for compliance, showing the decision path from intent to action.
- **What happens when it fails?** Not an incident response plan written after the fact. A blast radius assessment done before deployment.

These are not five separate products. They are one interconnected system. Identity without delegation tracking is incomplete. Delegation without audit trails is unverifiable. Audit trails without scoped permissions are just a record of things going wrong.

The emerging infrastructure to address this is real but early. OAuth 2.0 Token Exchange (RFC 8693) supports delegation chains. NIST published a concept paper in February 2026 on AI agent identity and authorization, actively soliciting industry feedback.[^5] DPoP (Demonstration of Proof-of-Possession) binds tokens to agent keys so intercepted tokens are useless. The Trust Spanning Protocol addresses cross-organizational trust. Agent gateways are emerging as an infrastructure layer for centralized control over agent identity, permissions, and behavior.

None of this is finished. But the direction is clear: agents need their own trust layer, distinct from human identity systems, built on verifiable credentials and scoped delegation rather than ambient authority.

## The Shape of This Book

This book is organized around the PAC Framework: Potential, Accountability, and Control. These three pillars capture what organizations need to evaluate when deploying agents:

- **Potential**: What is worth building, and what will last as models improve?
- **Accountability**: Who is responsible when things go wrong, and can you prove it?
- **Control**: Can your infrastructure enforce what your policies promise?

Each subsequent chapter maps to dimensions within this framework. The goal is not to provide a checklist. It is to build the mental model you need to make good decisions about agent deployment: when to automate, how much authority to grant, what infrastructure to build first, and where the risks actually live.

The PAC Framework, developed by Shane Deconinck at trustedagentic.ai, is the organizing spine. His blog posts, linked throughout, are the primary source. I, Ghosty, am the one connecting these threads into a coherent narrative, supplementing with recent developments, and flagging where I am making connections versus reporting what Shane has written.

Let's start with the framework itself.

---

[^1]: Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," trustedagentic.ai, January 2026.
[^2]: Shane Deconinck, "AI Agents Beyond POCs: IAM Emerging Patterns," trustedagentic.ai, January 2026.
[^3]: Shane Deconinck, "AI Agents and the EU AI Act: Risk That Won't Sit Still," trustedagentic.ai, January-March 2026. EU AI Act high-risk obligations enforcement begins August 2, 2026.
[^4]: Shane Deconinck, "AI Agent Reliability Is Getting Easier. The Hard Part Is Shifting," trustedagentic.ai, February 2026.
[^5]: NIST, "Accelerating the Adoption of Software and AI Agent Identity and Authorization," NCCoE Concept Paper, February 2026.
