# The Authorization Standards Race

Four competing proposals in three weeks. One Working Group adoption. A side meeting called to rationalize the overlap. Two international standards bodies now engaged.

The agent authorization standards race is not over, but it has moved from open field to a recognizable track. The question for anyone building agent infrastructure right now is not "should we wait for a standard?" — you cannot wait; agents are in production — but "how do we read the signals, and which bet is defensible?"

## Why There Are Four Proposals

The IETF OAuth Working Group received four distinct drafts on agent identity and authorization within a three-week span in early 2026:

**draft-klrc-aiagent-auth-00** (Kasselman et al., March 2, 2026) proposes a general AI agent authentication and authorization framework. The authors come from Defakto, AWS, Zscaler, and Ping Identity — a cross-vendor coalition that reflects the enterprise security industry's interest in a generalized solution. The draft introduces the Agent Identity Management System (AIMS) conceptual model, consolidating how SPIFFE, WIMSE, OAuth, and OpenID SSF apply to agents.[^klrc]

**draft-barney-caam-00** (Jonathan Barney, February 24, 2026) implements the Contextual Agent Authorization Mesh. Its architectural principle is token isolation: raw delegation tokens never reach the agent directly. They are held in an authorization sidecar and synthesized into short-lived, request-scoped credentials at action time. This is the ghost token pattern — the agent can only act with the permissions the current context warrants, and the token materializes and expires for that action.[^caam]

**AgentID** (Warren Parad et al., March 15, 2026) adds an explicit identity layer that the others address only implicitly. The draft is specifically about who the agent is, not only what it can do — an identity protocol for autonomous AI agents within the OAuth ecosystem.[^agentid]

**A2A OAuth Transaction Token Profile** (March 16, 2026) specializes for the Agent-to-Agent communication protocol. It is an OAuth profile shaped to A2A's interaction patterns — which raises a question the field has not yet answered: will per-protocol OAuth profiles proliferate as agent communication protocols multiply?[^a2a-profile]

Each proposal addresses a different failure mode. CAAM addresses what happens when delegation tokens are too powerful and too portable. ID-JAG addresses interoperability with existing OAuth infrastructure. AIMS addresses the system-level question of how identity, access control, and attestation fit together. AgentID addresses what the others assume: that "who the agent is" is already solved.

The four proposals are not competing for the same design space. They are competing to define which part of the design space matters most.

## The First Winner

Before these four appeared, another draft was already on a different trajectory.

**draft-ietf-oauth-identity-assertion-authz-grant-02** — ID-JAG — was formally adopted by the IETF OAuth Working Group in September 2025.[^idjag] It is now a Working Group document, not an individual submission. That distinction matters in IETF process terms: WG adoption means the Working Group has agreed to invest effort in developing the draft toward an RFC. Individual submissions may gain attention or fade; WG items have institutional momentum.

ID-JAG builds on JWT assertions and is designed to interoperate with existing OAuth infrastructure. It does not require new token formats or new authorization servers. An organization with existing OAuth infrastructure can add ID-JAG support incrementally. Keycloak v26.5 implemented ID-JAG in early 2026 — the first production implementation of the approach in a widely-deployed enterprise identity platform.[^keycloak] Production deployments exist.

ID-JAG winning WG adoption first is not the same as ID-JAG being the best technical approach. It means ID-JAG was most compatible with the working group's existing body of work, had the strongest co-author coalition, and reached the adoption threshold first. Whether the four newer proposals challenge that status is the question the next twelve months will answer.

## The Consolidation Moment

On March 16, 2026, a thread titled "Overlap of AI related proposals" appeared on the IETF OAuth WG mailing list.[^overlap-thread] The subject names the problem directly. Dick Hardt, Bjorn Hjelm, and Alex Babeanu — experienced OAuth architects with WG standing — were among the participants.

Two days later, on March 18, a message titled "AI Agent Security Side Meeting Friendly Reminder" was posted: a formal side meeting on AI agent security is being organized within the OAuth WG.[^side-meeting]

A mailing list thread is discussion. A side meeting is logistics: someone books a room, sets an agenda, and gets WG participants to commit time. The IETF process moves through specific stages — mailing list, side meeting, working group item, Internet Draft, RFC — and a side meeting is a qualitative step beyond a thread.

The Overlap thread establishes that the WG is explicitly working to rationalize competing approaches. The side meeting establishes that this rationalization has moved from conversation to organized coordination. Whether that coordination produces a single standard, a family of composable extensions, or a provisional winner among competing approaches is not yet determinable.

(I am reporting the moment, not the outcome. The side meeting outcome will be the signal to watch.)

## The Decentralized Case

The IETF OAuth WG is one track. The Decentralized Identity Foundation is pursuing a parallel argument.

In its March 2026 newsletter, DIF's Executive Director Grace Rachmany made the sharpest institutional statement yet of the book's thesis:

> "Agentic AI has an even stronger use case for decentralized AI than human identification."

Her reasoning is architectural: agents are ephemeral. They spin up for a task and are torn down. Centralized identity databases assume persistent entities that can be looked up, provisioned, and managed. Agents in production don't fit that model — at scale, the churn rate makes central provisioning a bottleneck. Decentralized identifiers (DIDs) assign identity at creation time without a central registration step. The ephemerality that makes agent identity hard in an OAuth world is exactly the condition for which DID was designed.[^dif-newsletter]

The DIF Trusted AI Agents Working Group (TAAWG) is developing the supporting infrastructure: a Delegated Authorization Task Force, a threat modeling exercise, and MCP-I (an identity framework donated to DIF by Vouched) as a candidate work item. Three DIF working groups — TAAWG, Hospitality & Travel, and Credentials and Authentication — are now coordinating on AI-affected identity solutions.[^taawg]

The OAuth track and the DID track are not mutually exclusive. ID-JAG operates within OAuth. DIDs can be used as identifiers within OAuth flows. CAAM's ghost token pattern is compatible with either identity carrier. But they represent different bets about where the foundational infrastructure will land: in the extension of existing enterprise identity systems, or in a new identity layer designed for the specific properties of agents.

The KYAPay draft (draft-skyfire-kyapayprofile-00, March 2, 2026) illustrates where the tracks meet.[^kyapay] It defines JWT profiles for both agent identity ("kya" tokens) and agent payments ("pay" tokens), with an Identity Token Issuer that conducts KYC/KYB verification and issues cryptographically signed tokens attesting to principal, agent, and platform identity. The design bridges the identity stack and the payment stack — two concerns the book treats separately — into a single credential infrastructure.

## The International Dimension

IETF and DIF are not the only institutions moving.

ITU-T Study Group 17 — the ITU's security study group — is hosting a workshop titled "Trustable and Interoperable Digital Identities for Human and Agentic AI" on March 30-31, 2026, in Geneva.[^itu-workshop] The ITU is the international telecommunications standards body. Its involvement means agent identity is entering the international standards track that governs interoperability across national regulatory regimes, not just the practitioner and vendor-community track that IETF and DIF represent.

The ITU timeline is longer than IETF or DIF. ITU standards move through national delegations and formal approval processes that take years. But ITU involvement matters for two reasons: first, it signals that governments are treating agent identity as a standards-track problem rather than a regulatory problem; second, ITU standards, once issued, carry implementation obligations in regulatory regimes that reference them.

Separately, the NIST Collaborative AI Safety Institute (CAISI) has an Agent Identity concept paper in comment (through April 2, 2026). NIST's eventual standard will govern how agents are treated within US federal information systems, and its procurement requirements will pull enterprise adoption. The CAISI process and the ITU process are running on different timelines toward different instruments — NIST produces guidance that becomes procurement requirements; ITU produces international standards that become interoperability baselines — but both are moving.

## What Fragmentation Costs

The Overlap thread would not exist if fragmentation were not a real risk.

If the field ends up with multiple incompatible agent authorization standards — each implemented by a subset of vendors, each requiring different identity infrastructure — the interoperability gap that the book documents at the protocol layer reproduces at the standards layer. An agent authorized for one vendor's stack cannot be authorized for another's without additional translation infrastructure. Every organizational boundary becomes a standards boundary as well as a trust boundary.

The specific fragmentation risk is not four proposals existing simultaneously. That is normal early-stage standards competition. The risk is four proposals each gaining production implementations before consolidation — at which point installed base creates path dependence that makes harmonization expensive.

CAAM and ID-JAG already have a meaningful technical difference in that regard: CAAM requires new authorization infrastructure (the sidecar), while ID-JAG extends existing OAuth. Organizations that deploy CAAM before a standard clarifies are committed to a specific architectural choice. Organizations that deploy ID-JAG are building on already-standardized infrastructure that extends incrementally.

The side meeting's outcome matters most in precisely this scenario: if it produces a summary document that establishes which aspects of each proposal are complementary versus competing, it can prevent the installed-base lock-in problem before it compounds.

## What to Do Now

**Build on ID-JAG now.** It is the only WG-adopted approach with production deployments. If your organization needs agent authorization infrastructure before the standards landscape clarifies, ID-JAG is the most defensible current bet: it is interoperable with existing OAuth infrastructure, it has a WG-backed RFC trajectory, and it is already implemented in Keycloak v26.5. What you build on ID-JAG today does not become dead weight if the consolidation thread produces a broader standard; it becomes the foundation that any broader standard will need to accommodate.

**Treat CAAM's ghost token pattern as an architectural principle, not a standards bet.** The core design choice CAAM makes — tokens that never reach the agent, credentials synthesized at action time — is sound regardless of which standard eventually governs the token format. You can implement this pattern with existing infrastructure today. If CAAM achieves WG adoption, your architecture is already aligned. If ID-JAG absorbs the principle, your architecture still holds.

**Monitor the side meeting output.** The IETF side meeting on AI agent security is the consolidation inflection point. If it produces a summary document with named areas of overlap and proposed resolution, that document is more valuable than any individual draft: it is the WG's stated intention. Organizations that track it will know which stack to invest in months before that information becomes broadly legible.

**If you operate across national regulatory regimes,** watch the ITU-T workshop output (March 30-31). ITU standards carry implementation obligations in regulatory regimes that IETF does not directly reach. The gap between "IETF says X" and "your regulator requires Y" is navigable when you see it coming.

**On the DID/OAuth question:** the two tracks are converging, not competing. KYAPay is the clearest current example of how they fit together. If your identity infrastructure is OAuth-native today, that does not foreclose a DID-based agent identity layer tomorrow; they operate at different levels of the stack. The question to hold is not "which one wins" but "which level of my stack does each one address."

The agent authorization standards are converging. The consolidation is not complete. The practitioners who follow the Overlap thread — who understand what a side meeting means in IETF process terms, and what WG adoption means versus individual submission status — will see the inflection points before they become market moves.

---

[^klrc]: draft-klrc-aiagent-auth-00, "AI Agent Authentication and Authorization," datatracker.ietf.org, March 2, 2026. Authors: Kasselman et al. (Defakto, AWS, Zscaler, Ping Identity). Introduces the Agent Identity Management System (AIMS) conceptual model, addressing how SPIFFE, WIMSE, OAuth, and OpenID SSF apply to agents.

[^caam]: draft-barney-caam-00, "Contextual Agent Authorization Mesh," datatracker.ietf.org, February 24, 2026. Author: Jonathan Barney. Ghost token pattern: raw delegation tokens held in authorization sidecar, synthesized into short-lived request-scoped credentials at action time.

[^agentid]: AgentID, IETF OAuth WG, Warren Parad et al., March 15, 2026. Identity protocol for autonomous AI agents within OAuth. Addresses explicit agent identity as distinct from agent authorization.

[^a2a-profile]: A2A OAuth Transaction Token Profile, March 16, 2026. OAuth profile specialized for Agent-to-Agent communication protocol. Raises the per-protocol proliferation question: whether a separate OAuth profile is needed for each agent communication protocol.

[^idjag]: draft-ietf-oauth-identity-assertion-authz-grant-02, "Identity Assertion JWT Authorization Grant," datatracker.ietf.org. Authors: Aaron Parecki, Karl McGuinness, Brian Campbell. Adopted by IETF OAuth Working Group, call for adoption closed September 2025. Now at revision -02.

[^keycloak]: Keycloak v26.5 implementation of ID-JAG, 2026. First production implementation of the Identity Assertion JWT Authorization Grant in a widely-deployed enterprise identity platform.

[^overlap-thread]: IETF OAuth Working Group mailing list, thread "Overlap of AI related proposals," March 16, 2026. Participants include Dick Hardt, Bjorn Hjelm, Alex Babeanu.

[^side-meeting]: IETF OAuth WG, "AI Agent Security Side Meeting Friendly Reminder," March 18, 2026. Formal side meeting on AI agent security organized within the OAuth WG.

[^dif-newsletter]: DIF Newsletter #59, blog.identity.foundation, March 2026. Grace Rachmany (DIF Executive Director): "Agentic AI has an even stronger use case for decentralized AI than human identification." Reasoning: agents are ephemeral; centralized identity databases assume persistent entities.

[^taawg]: DIF Newsletter #59, March 2026. TAAWG updates: Delegated Authorization Task Force active; threat modeling exercise underway; MCP-I (donated by Vouched) as candidate DIF work item. Three working groups coordinating: TAAWG, Hospitality & Travel WG, Credentials and Authentication WG.

[^kyapay]: draft-skyfire-kyapayprofile-00, "KYAPay Profile," datatracker.ietf.org, March 2, 2026. JWT profiles for agent identity ("kya") and payment ("pay") tokens. Identity Token Issuer conducts KYC/KYB verification and issues cryptographically signed tokens. Also: Skyfire and Visa, "Secure Agentic Commerce Purchase Using the KYAPay Protocol and Visa Intelligent Commerce," businesswire.com, December 2025.

[^itu-workshop]: ITU-T Study Group 17, "Trustable and Interoperable Digital Identities for Human and Agentic AI," ITU-T Workshop, March 30-31, 2026, Geneva. itu.int/en/ITU-T/Workshops-and-Seminars/2026/0330.
