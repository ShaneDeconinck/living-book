# Agent Security Becomes a Standards Problem

On February 17, 2026, NIST launched the Collaborative AI Safety Institute (CAISI) and issued a formal Request for Information on agent security. The RFI closed March 9. Comment periods on the Agent Identity concept document run through April 2. Sector-specific listening sessions are now forming.

This is not a research exercise. When NIST opens an RFI on a topic, it is building the evidentiary record that becomes a federal standard. The agency that wrote NIST SP 800-207 (Zero Trust Architecture) and NIST AI RMF (AI Risk Management Framework) is now treating agent security as a standards domain, not an emerging concern to monitor.

That shift matters independent of what NIST ultimately produces. It means agent security has moved from "practitioners are worried" to "institutions are acting." The question the field was asking — is this real enough to standardize? — has been answered.

## What the Empirical Record Actually Shows

Before CAISI can write a standard, it needs an empirical baseline. The RFI response from Nguyen et al. (arXiv:2603.09002, March 9, 2026) is the most systematic attempt yet to build one.[^nguyen-taxonomy]

Their method: catalog every documented agentic AI security threat, classify it across a nine-category taxonomy, then score sixteen existing frameworks on how well they address each category. The result is 193 distinct threats and the first cross-framework coverage comparison for multi-agent system security.

The nine categories are the shape of the problem: identity and authentication, authorization and access control, data integrity, model behavior and reliability, tool and plugin security, communication and coordination, privacy, regulatory compliance, and non-determinism. Every chapter in this book maps to at least one.

What the coverage scores reveal is more interesting than the count.

**OWASP Agentic Security Initiative** leads all sixteen frameworks at 65.3% overall coverage. This is notable: OWASP has moved faster on agent security than NIST, ISO, or most enterprise security frameworks. The same organization that built the Web Application Top 10 and LLM Top 10 is now the most comprehensive reference for agentic threats — ahead of government standards bodies by a meaningful margin.

But even at 65.3%, OWASP is covering roughly two-thirds of the documented threat surface. A standard that covers two-thirds of known threats is not a standard that covers the problem.

The gaps matter more than the coverage. Two categories stand out as systematically under-addressed across all sixteen frameworks:

**Non-determinism** (mean coverage score: 1.231/5). Agentic systems are not deterministic. The same input, the same agent, the same tools can produce different outputs across runs. This is fundamental to how LLMs work. It means that security properties you verify at test time may not hold at runtime. It means that an agent behaving correctly in staging may behave incorrectly — or adversarially — in production under different context. The frameworks have largely not grappled with this. The threat models assume a more predictable adversary.

**Data leakage** (mean coverage score: 1.340/5). Agents aggregate context from multiple sources: conversation history, tool results, retrieved documents, prior session state. That aggregated context is a richer target than any individual data source. The pathways through which agents might leak sensitive context — through tool calls, through generated outputs, through reasoning traces stored for observability — are numerous and mostly undocumented in existing frameworks.

These two gaps are not minor edge cases. Non-determinism is intrinsic to the technology. Data leakage is a function of the thing that makes agents useful: their ability to hold and use rich context. Building standards that don't address either means building standards that don't cover what makes agentic AI different from prior AI deployments.

## What Production Scale Adds

The Nguyen et al. taxonomy is constructed from documented threats — what the research community has named and described. Perplexity's CAISI submission adds a different kind of evidence: what it looks like to run general-purpose agentic systems at scale and face these threats in production.[^perplexity-caisi]

Perplexity's submission (arXiv:2603.12230, Li et al., March 12, 2026) is unusual in a specific way: it is the first major AI company to make its CAISI response public. The submission draws on Perplexity's experience operating production agentic systems and maps the attack surfaces they actually encounter.

Three threats dominate their operational record: **indirect prompt injection**, **confused-deputy behavior**, and **cascading failures in long-running workflows**.

Indirect prompt injection is the attack surface that doesn't exist in traditional software. An agent retrieves a document, and that document contains instructions that redirect the agent. The injection point is not a form field or an API parameter — it is the agent's own tool call, the content it fetches to do its job. The attack surface is the agent's capability. The better the agent is at following complex instructions, the more effective the injection.

Confused-deputy behavior — the agent acting with authority it should not have for the current context — maps directly to the book's opening chapter. What Perplexity's submission adds is production scale: this is not a theoretical vulnerability. It is a recurring failure mode in systems where delegation chains are implicit rather than cryptographic.

Cascading failures in long-running workflows describe what happens when agent decisions compound. An early misclassification or incorrect tool call does not fail immediately; it propagates through subsequent steps, each of which builds on the previous output. By the time the failure is visible, the chain of causation is long and the blast radius has expanded. The incident response chapter describes this structurally. The Perplexity submission confirms it empirically: long-horizon tasks amplify small errors.

The submission also identifies three standards gaps that the book addresses but that current frameworks leave open: **adaptive security benchmarks** (security properties should be testable in conditions that reflect production non-determinism, not just fixed test cases), **policy models for delegation and privilege control** (current standards offer no formal language for expressing delegation constraints across agent chains), and **guidance for secure multi-agent design** (the frameworks treat multi-agent architectures as a variation on single-agent systems; the interaction patterns create threat categories that single-agent frameworks don't cover).

## What CAISI Is Building Toward

CAISI's scope is not confined to a single document. The parallel tracks matter:

The **Agent Identity concept document** (comment period through April 2) will shape how agents are treated within federal information systems: whether they are principals with verifiable credentials or endpoints with delegated tokens. The comment period is short. Whatever gets written into that concept document will anchor the standards discussion for years.

The **sector-specific listening sessions** (interest deadline March 20) will determine which industries CAISI treats as priority deployment contexts. Healthcare, financial services, and critical infrastructure each have compliance regimes that predate agentic AI by decades. HIPAA's attribution requirements, the SEC's supervision obligations, NERC CIP's access control mandates — all of these will need interpretation in agent contexts. The listening sessions are where CAISI learns what those sectors have already figured out on their own.

The **RFI response record** is now public. Perplexity's submission is one data point. More will become visible as the CAISI process continues. This is the first time the field's empirical evidence — what companies actually observe in production, what researchers have taxonomized — is entering a formal standards process.

## How This Sits Against the PAC Framework

The CAISI process is not building the PAC Framework. It is building federal standards, which will reflect federal priorities: compliance verification, procurement requirements, risk management documentation. These are not the same as the infrastructure-first approach the book argues for.

The relationship is useful to name precisely. PAC's argument is structural: the reason agents break trust is architectural, and the solution is infrastructure that makes failures impossible rather than policy that makes them prohibited. NIST's job is different: to define what compliance looks like so agencies and contractors can be audited against it.

A standard that says "agents must have verifiable identities" does not tell you how to build verifiable agent identity. It tells you that you will eventually be audited for it. That creates procurement demand, which creates market pressure, which accelerates infrastructure investment. The PAC Framework provides the architecture; the CAISI standard provides the regulatory forcing function.

The two gaps the Nguyen taxonomy identifies — non-determinism and data leakage — deserve specific attention here. PAC's Control pillar addresses containment (what an agent can reach) and authorization (what it can do). It addresses non-determinism indirectly: if you scope an agent to the minimum necessary actions and audit every action it takes, non-deterministic behavior is bounded even if it cannot be eliminated. But the frameworks don't address this directly, and a standard built on those frameworks will inherit the gap.

Data leakage in agent context is a harder problem than traditional data leakage because the vector is the agent's own context aggregation. An agent that retrieves information from multiple sources, holds it in working context, and acts on it is a single point that can leak across multiple data sources simultaneously. The observability chapter addresses this: agent action logs and context logs are the audit record. But the threat model for agent context aggregation has not been formalized in any framework yet. It is a gap worth naming explicitly in CAISI comment submissions.

## What to Do Now

**If you are operating agentic systems in a regulated sector,** the CAISI listening sessions are the most direct input you have into how standards will be written. Organizations that participate in sector-specific sessions will see their operational constraints reflected in the output. Organizations that do not will be governed by the constraints of those that did.

**If you are building agent governance infrastructure,** the non-determinism and data leakage gaps in current frameworks are the most valuable areas to develop. Every framework evaluated covers identity and authorization reasonably well. None covers non-determinism above a 1.231 mean score. The organization that builds a credible approach to testing security properties under non-deterministic conditions is building infrastructure for which there is currently no good substitute.

**If you are writing comment letters on the Agent Identity concept document,** the principal chain is the structural question. An agent identity standard that treats agents as endpoints with delegated tokens (OAuth model) leaves the delegation chain implicit. A standard that treats agents as principals with verifiable credentials (DID/VC model) makes the chain auditable. The comment period runs through April 2. Both approaches have production deployments; the question is which the standard encodes as baseline.

**On the Perplexity submission:** the public record is thin. One major company made its submission visible. More companies are operating production agentic systems at scale. Their operational experience — the actual failure modes, the actual attack patterns, the actual governance gaps — is the most valuable input the CAISI process can receive. Keeping those submissions internal means the standard gets written from a narrower evidence base.

The empirical record on agent security is forming. The Nguyen taxonomy gives us 193 named threats and a coverage map. The Perplexity submission gives us a production view. The CAISI process gives us the institutional moment to shape what gets standardized.

The window is short. Comment periods close. Listening sessions form. Then the drafting begins, and the empirical record that got submitted becomes the baseline the drafters work from.

---

[^nguyen-taxonomy]: Nguyen et al., "A Taxonomy of Agentic AI Security Threats and Multi-Agent Framework Security Analysis," arXiv:2603.09002, March 9, 2026. 193 threats across nine categories; sixteen frameworks evaluated; OWASP Agentic Security Initiative leads at 65.3% overall coverage; non-determinism (mean 1.231/5) and data leakage (mean 1.340/5) are the most under-addressed threat domains. First empirical cross-framework comparison for multi-agent system security.

[^perplexity-caisi]: Li et al. (Perplexity AI), "Agentic AI Security: Operational Observations and Standards Gaps," arXiv:2603.12230, March 12, 2026. First major AI company to make its CAISI RFI response public. Principal attack surfaces mapped across tools, connectors, hosting boundaries, and multi-agent coordination. Standards gaps identified: adaptive security benchmarks, policy models for delegation and privilege control, guidance for secure multi-agent design.

[^nist-caisi]: NIST, Collaborative AI Safety Institute (CAISI), launched February 17, 2026. Request for Information on agent security closed March 9, 2026. Agent Identity concept document comment period open through April 2, 2026. Sector-specific listening sessions forming March 2026.
