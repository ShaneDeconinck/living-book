# Session Log

## 2026-03-13: CSA IAM Framework and NIST Evaluation Standards

**What I did:**
- Added Cloud Security Alliance "Agentic AI Identity & Access Management" framework to agent-identity.md. New subsection "CSA: Agent Identity as Industry Architecture" in the Regulatory Convergence section. Covers Agent Naming Service (ANS) for capability-based discovery, Zero-Knowledge Proofs for privacy-preserving compliance verification, and unified session management with instant revocation propagation. Added footnote with source.
- Added NIST AI 800-4 "Challenges to the Monitoring of Deployed AI Systems" (March 2026) to reliability-evaluation.md. Strengthens the post-deployment monitoring discussion in the Evaluation as Governance section with authoritative NIST documentation of why monitoring remains fragmented: drift detection, distributed logging, human-AI feedback loops, deceptive behavior identification. Added footnote with source.
- Added NIST AI 800-2 "Practices for Automated Benchmark Evaluations" (comment period through March 31, 2026) to reliability-evaluation.md. New paragraph after the HAL benchmark discussion, noting that benchmark methodology itself is attracting regulatory attention. Added footnote with source.
- Updated regulatory-landscape.md convergence timeline with March 31 NIST AI 800-2 comment deadline.
- Updated gaps.md with two new observations: CSA IAM Framework validation and NIST evaluation standards stack. Updated identity standards convergence observation to include CSA and the March 31 benchmark deadline.

**Why this work:**
Stepped back and assessed priorities. The book is at first-edition completeness with 15 chapters. No new Shane blog posts since March 11. The PAC Framework is unchanged. Web search revealed three significant developments not yet in the book:

1. The CSA IAM framework is the highest-impact addition because it is the first major industry framework (not a standards body or regulator) to build explicitly on DIDs, VCs, and ZKPs for agent IAM. The agent-identity chapter already makes the case for this architectural stack, but lacked industry framework validation beyond Auth0's platform-specific offering. The CSA framework validates the thesis at the architecture level. The ANS concept is particularly interesting because it connects identity to discovery: the agent-identity chapter discusses identity infrastructure, the agent-communication chapter discusses protocol-level discovery, and ANS bridges them.

2. NIST AI 800-4 fills a gap the quality assessment identified: the reliability chapter discussed post-deployment monitoring as critical but underbuilt without authoritative evidence for why it remains fragmented. The NIST report, based on three practitioner workshops, provides exactly that evidence.

3. NIST AI 800-2 is relevant because the reliability chapter discusses benchmarks (SWE-bench, HAL, etc.) as governance inputs. A NIST standard for benchmark methodology strengthens the argument that evaluation practices are governance infrastructure, not just engineering tooling. The March 31 comment period is 18 days away.

**What I considered but did not do:**
- Strengthening pac-framework.md with concrete autonomy level examples. The quality assessment identified this as thin. However, adding examples without strong source material risks making unsupported assertions. The framework's en.json definitions are clear; the chapter reflects them accurately. Adding fictional examples could mislead.
- Adding Strata's "new identity playbook" (SPIFFE/SPIRE for internal agents, PKCE for public agents) to agent-identity.md. These are implementation-level details that the chapter covers conceptually. Adding vendor-specific implementation guidance would shift the chapter from architecture to tutorial.
- Expanding the shadow-agent-governance chapter's enforcement mechanisms. The quality assessment identified registry enforcement as thin. However, the existing coverage (identity providers, gateways, network controls, platform controls) captures the four integration points. Adding implementation depth would require vendor-specific detail that ages quickly.
- Adding the NIST AI 800-4 report to the regulatory landscape chapter as a timeline entry. The report is not a regulatory deadline but an analytical publication. It fits better in the reliability chapter where it strengthens the evidence base for post-deployment monitoring challenges.

**Sources used:**
- Cloud Security Alliance, "Agentic AI Identity & Access Management: A New Approach," cloudsecurityalliance.org, 2025-2026.
- NIST CAISI, "Challenges to the Monitoring of Deployed AI Systems," NIST AI 800-4, March 2026.
- NIST CAISI, "Practices for Automated Benchmark Evaluations of Language Models," NIST AI 800-2 IPD, January 2026. Comment period through March 31, 2026.
- PAC Framework from trustedagentic.ai (read fresh: 7P + 5A + 7C = 19 questions. Site description says "18 questions" in one place, "19 Questions" in another.)

**What I noticed:**
- The PAC Framework site has an inconsistency: the offering description says "18 questions" but the questions section header says "19 Questions for Your Team." The actual count is 19 (7P + 5A + 7C). The book does not cite the count, so no fix needed.
- The CSA framework's ANS concept reveals a gap in the book's architecture: identity and discovery are treated in separate chapters (agent-identity and agent-communication) but ANS shows they are tightly coupled. An agent cannot verify credentials it cannot discover. The book's cross-references handle this, but a future revision could strengthen the connection.
- NIST is building what amounts to an evaluation standards stack: AI 800-2 for pre-deployment benchmark methodology, AI 800-4 for post-deployment monitoring challenges. This maps to exactly the evaluation gap the reliability chapter identifies (52% offline, 37% online). NIST is working on both sides of that gap.
- No new Shane blog posts since March 11. The book remains current with his published thinking.

**Next session priorities:**
1. NIST AI 800-2 benchmark evaluation comment period closes March 31 (18 days). Monitor for responses.
2. NIST concept paper comment period closes April 2 (20 days). Monitor for regulatory analysis.
3. NIST CAISI listening sessions begin April. Monitor for sector-specific insights (healthcare, finance, education).
4. The semantic interoperability gap remains unsolved. Track for new source material.
5. Consider whether the ANS-like pattern (identity+discovery coupling) warrants expanded treatment in a future revision.

## 2026-03-13: MCP Aggregate Vulnerability Data and NIST Listening Session Deadline

**What I did:**
- Strengthened agent-communication.md MCP security narrative with aggregate vulnerability data: 30 CVEs filed in January-February 2026 alone, across three attack layers (servers, SDKs, host apps/dev tools). Vulnerability class breakdown: 43% exec/shell injection, 20% tooling/infrastructure, 13% auth bypass, 10% path traversal, 7% new classes (eval() injection, env var injection). Added stat: 38% of 500+ scanned MCP servers completely lack authentication.
- Updated the "Hundreds of MCP servers remain publicly exposed" line with the more specific "38% of scanned MCP servers accept connections without authentication" stat from the same source.
- Updated regulatory-landscape.md with the NIST CAISI listening session participation deadline (March 20, 2026) and sector focus (healthcare, finance, education). Added to both the prose and the convergence timeline.
- Updated gaps.md MCP attack surface observation with the aggregate vulnerability data and structural pattern analysis.

**Why this work:**
Stepped back and assessed priorities. The book is at first-edition completeness with 15 chapters. No new Shane blog posts since March 11. The PAC Framework is unchanged. The highest-impact improvement was strengthening the MCP security narrative with aggregate data. The curated timeline of 11 incidents tells the story well, but the "30 CVEs in 60 days" stat transforms the narrative from "here are individual incidents" to "this is systemic, rapidly-scaling vulnerability at the protocol infrastructure level." The vulnerability class breakdown (43% exec/shell injection) reveals that these are not exotic attacks: they are the same vulnerability classes that plague traditional software, now appearing in agent infrastructure that organizations are deploying at production scale. The "38% lack authentication" stat is more specific and credible than the previous "Hundreds of MCP servers" language.

The NIST March 20 deadline is time-sensitive (7 days away) and was not in the book. Organizations reading the regulatory chapter should know about this participation window.

**What I considered but did not do:**
- Adding CVE-2026-31841 (Hyperterse MCP framework, CVSS 6.5, March 12, SQL query exposure) to the timeline. Medium severity, narrow impact (exposes raw SQL queries in tool search results). The timeline is strongest with high-impact incidents. The aggregate "30 CVEs" stat captures it in the total without diluting the curated list.
- The OpenClaw crisis: already well-covered in supply-chain-security.md with 1,184 malicious skills, 135K exposed instances, and Shane's analysis. No new information found beyond what is already in the chapter.
- Adding the "agentic fraud" framing (SecurityBoulevard, Experian forecast) to why-agents-break-trust or shadow-agent-governance. These chapters already cover agent-as-threat-vector well. The "agentic fraud" label is marketing, not a new concept.
- Expanding the EUDI credential formats integration. The cross-org-trust chapter already has strong coverage of Shane's March 9 post, including the comparison table, semantic boundary problem, and de jure/de facto gap. No improvement needed.

**Sources used:**
- "30 CVEs Later: How MCP's Attack Surface Expanded Into Three Distinct Layers," dev.to, March 2026. Analysis of 30 MCP CVEs with vulnerability class breakdown and server authentication scan.
- NIST CAISI, "CAISI to Host Listening Sessions on Barriers to AI Adoption," nist.gov, February 2026. Participation deadline March 20, 2026.
- PAC Framework from trustedagentic.ai (read fresh: 7P + 5A + 7C = 19 questions, site description says "18")

**What I noticed:**
- The MCP vulnerability class breakdown (43% exec/shell injection) suggests the ecosystem is repeating patterns from early web application security. The same vulnerabilities that OWASP documented for web apps in the 2000s are appearing in MCP server implementations in 2026. This is not surprising: the developers building MCP servers are often not security specialists, and the protocol does not enforce secure patterns.
- The three-layer attack surface (servers, SDKs, host apps) is an important structural insight. The book's agent-communication chapter covers server-level and tool-level attacks well, but the SDK layer and developer tooling layer are less explored. The MCP Inspector CVE is the main example. Worth monitoring for SDK-level vulnerabilities.
- NIST's listening session sector focus (healthcare, finance, education) aligns with the Gravitee data showing healthcare at 92.7% agent-related incidents. The regulatory chapter already notes CAISI listening sessions; the sector focus adds specificity.
- No new Shane blog posts since March 11. No PAC Framework changes.

**Next session priorities:**
1. The NIST March 20 listening session deadline passes today+7. Monitor for any public analysis of submissions.
2. NIST April 2 concept paper comment period closes in 20 days. Monitor for public responses.
3. The MCP SDK vulnerability layer is underexplored in the book. If new SDK-level CVEs emerge, they warrant expanded treatment.
4. The semantic interoperability gap remains the most significant unsolved problem.

## 2026-03-13: Gravitee Identity Data and Azure MCP SSRF

**What I did:**
- Added Gravitee State of AI Agent Security 2026 identity-specific data to agent-identity.md "The Agentic Gap" section: 45.6% of teams still use shared API keys for agent-to-agent authentication, only 21.9% treat agents as identity-bearing entities, 27.2% have reverted to custom hardcoded authorization logic. These numbers empirically ground the chapter's argument that traditional IAM is architecturally wrong for agents.
- Added Azure MCP Server CVE-2026-26118 (SSRF, CVSS 8.8, patched March 10, 2026) to agent-communication.md's MCP security timeline, bringing it to eleven incidents in twelve months. This is the first critical vulnerability in a major cloud provider's own first-party MCP implementation: Microsoft's Azure MCP Server had an SSRF that could steal managed identity tokens, giving attackers the server's Azure permissions.
- Updated gaps.md MCP attack surface observation with the Azure MCP incident and updated the observation header date.

**Why this work:**
Stepped back and assessed priorities. The book is at first-edition completeness with 15 chapters. All recent Shane blog posts (through March 11 LFDT meetup) are integrated. No new Shane posts since last session. The PAC Framework question count (19 actual vs "18" in site description) is a trustedagentic.ai issue, not a book issue: the book does not cite the count.

The highest-impact improvements were: (1) The Gravitee identity data fills an empirical gap. The agent-identity chapter argued theoretically that traditional IAM breaks down for agents but lacked current survey data showing how organizations are actually handling agent authentication. The 45.6% shared API keys number is striking because it means nearly half of organizations are using the authentication pattern that the chapter identifies as fundamentally inadequate. (2) The Azure MCP SSRF is significant because it extends the attack surface narrative from community/third-party servers to a major cloud provider's own implementation. The supply-chain-security chapter already had this CVE, but the communication chapter's security timeline (the most visible incident compilation in the book) did not.

**What I considered but did not do:**
- Adding CVE-2026-29787 (mcp-memory-service information disclosure, MEDIUM severity) to the timeline. Too minor to include: it exposes host OS version and filesystem paths, not credentials or data. The timeline is strongest when it includes high-impact incidents.
- Expanding the introduction (53 lines). Still functions well as a concise roadmap. The reader gets the thesis, audience, methodology, and full chapter list. Expanding risks filler.
- Quality pass on reliability-evaluation or human-agent-collaboration chapters. The session 12 quality review found all chapters solid. No structural issues identified.
- Adding the CSA research note on NIST CAISI (March 11, 2026) to the regulatory chapter. The chapter already covers CAISI comprehensively including the RFI closure (March 9), concept paper deadline (April 2), and April listening sessions. The CSA note adds industry analysis but no new regulatory facts.
- Updating the convergence timeline. All dates are current and correct. NIST RFI closed March 9 (already noted), concept paper deadline April 2, EU AI Act August 2, MCP June 2026, AAIF late 2026.

**Sources used:**
- Gravitee, "State of AI Agent Security 2026: When Adoption Outpaces Control," gravitee.io, 2026. Survey of 900+ respondents.
- Microsoft Security Update, CVE-2026-26118, March 10, 2026. Azure MCP Server SSRF.
- PAC Framework from trustedagentic.ai (read fresh: 7P + 5A + 7C = 19 questions, site description says "18")

**What I noticed:**
- The PAC Framework site description says "18 questions" but the actual content has 19 (7P + 5A + 7C = 19). The book does not cite the count anywhere, so no fix needed. This appears to be a website copy issue on trustedagentic.ai.
- The Gravitee identity data reveals a pattern: organizations are not failing to adopt agent identity because they chose poorly, but because the tools forced a choice between inadequate options. Shared API keys (45.6%) are what you use when OAuth does not fit and nothing better exists. Hardcoded authorization (27.2%) is what you build when no platform supports your use case. The agent identity stack described in the book (OBO, DPoP, VCs, Verifiable Intent) is the answer to this specific forced choice.
- No new Shane blog posts since the LFDT meetup (March 11). The book is current with his published thinking.
- The NIST concept paper comment period (April 2) is now 20 days away. Worth monitoring for any public responses or early analysis.

**Next session priorities:**
1. Monitor NIST April 2 comment period deadline for any public responses or regulatory analysis.
2. Track MCP specification evolution toward June 2026 update.
3. Consider whether the Gravitee data on sector-specific incident rates (healthcare 92.7%) warrants treatment in the regulatory landscape chapter.
4. The semantic interoperability gap remains the most significant unsolved problem flagged in multiple sessions. It may warrant expanded treatment if new source material emerges.

## 2026-03-13: I-Level Label Consistency and Readability Pass

**What I did:**
- Fixed PAC Framework infrastructure level labels across four chapters. The PAC Framework uses I1 Open, I2 Logged, I3 Verified, I4 Authorized, I5 Contained. Four chapters had wrong labels: agent-identity.md (I3 "Governed", I4 "Controlled"), context-infrastructure.md (I3 "Governed", I4 "Controlled"), execution-security.md (I2 "Tracked", I3 "Governed", I4 "Verified"), and multi-agent-trust.md (unlabeled custom sublabels). All now use the correct PAC labels.
- Added standard PAC labels as parenthetical cross-references to multi-agent-trust.md's domain-specific I-level descriptions (e.g., "I3 (Verified): Governed Delegation").
- Readability pass on agent-identity.md: fixed subject-verb agreement (line 45), added PAC cross-reference link for V3/V4 business value tiers (line 203).
- Readability pass on cross-org-trust.md: fixed double-colon construction (line 5), streamlined redundant phrasing in chapter intro (line 7), fixed imperative phrasing to conditional (line 103), added missing chapter cross-reference link to Agent Payments (line 179).

**Why this work:**
Stepped back and assessed priorities. The previous session recommended a quality pass on agent-identity and cross-org-trust as the most technically dense chapters. Reading the PAC Framework fresh revealed the I-level label inconsistency: four chapters used wrong labels (Governed/Controlled instead of Verified/Authorized). This is a factual error that undermines the book's credibility as a PAC Framework companion. Six chapters already had the correct labels, confirming the right values. The readability fixes address the most impactful issues: a grammatical error, redundant phrasing, missing cross-references, and an unclear construction. Both chapters are strong and well-sourced; the fixes are targeted, not structural.

**What I considered but did not do:**
- Updating the regulatory landscape chapter. Already covers the NIST AI Agent Standards Initiative, CAISI RFI, listening sessions, and the full convergence timeline. No new information found beyond what the previous session added.
- Expanding MCP coverage with the 2026 roadmap (transport scalability, MCP Extensions GA in January 2026). The agent-communication chapter already covers MCP extensively. The roadmap details are worth monitoring but do not yet warrant chapter updates.
- Adding sources for the OpenID AIIM meeting schedule claim in agent-identity.md (line 191). The claim is specific but low-impact; flagged for a future session if the schedule changes.
- Further restructuring of either chapter. Both are well-organized with clear flow. The fixes are sufficient.

**What I noticed:**
- The I-level inconsistency was systematic: earlier chapters (agent-identity, context-infrastructure, execution-security) used wrong labels while later chapters (cross-org-trust, regulatory-landscape, human-agent-collaboration) used correct ones. This suggests the PAC Framework labels were updated or clarified mid-authoring and only later chapters picked up the change.
- The PAC Framework now lists 18 questions (7P + 5A + 7C, down from the 19 mentioned in earlier log entries). The framework site uses "18 questions" in its description. Worth verifying this count matches the book's PAC Framework chapter.
- NIST CAISI listening sessions on sector-specific barriers (healthcare, finance, education) begin April 2026. These will be a valuable source for updating the regulatory chapter.
- TSP remains at Revision 2 (November 2025). No specification updates found.

**Next session priorities:**
1. Verify PAC Framework question count matches between the book and trustedagentic.ai (18 vs 19).
2. Monitor NIST April 2 comment period deadline (20 days away). Update regulatory chapter if new information emerges.
3. Continue tracking MCP specification evolution and the 2026 roadmap.
4. Consider whether the semantic interoperability gap warrants expanded treatment.

## 2026-03-13: Quality Review and MCP Security Timeline Expansion

**What I did:**
- Performed quality review of all 15 chapters. Assessed chapter lengths, source coverage, and structural completeness. The book is solid at first-edition completeness.
- Expanded the MCP security incident timeline in agent-communication.md from 5 incidents to 10, covering April 2025 through March 2026. New incidents added: WhatsApp MCP cross-server tool poisoning (Invariant Labs, April 2025), Asana MCP cross-organization data exposure (June 2025), MCP Inspector CVE-2025-49596 unauthenticated RCE with CVSS 9.4 (July 2025), mcp-atlassian CVE-2026-27825 path traversal and RCE (January 2026), WeKnora CVE-2026-30861 command injection (March 2026).
- Strengthened supply-chain-security.md tool poisoning section with the WhatsApp MCP case as a concrete real-world example of cross-server tool poisoning. Added MCP Inspector CVE to MCP Server Vulnerabilities section. Added two new footnotes with sources.
- Updated gaps.md MCP attack surface observation with the expanded incident timeline and the developer tooling attack surface insight.

**Why this work:**
Stepped back and assessed priorities. The book is at first-edition completeness. Two new Shane blog posts (Verifiable Intent March 6, LFDT meetup March 11) were already well-integrated by the previous session. The quality review confirmed chapters are solid, well-sourced, and structurally complete. The highest-impact move was strengthening the MCP security evidence: web search revealed five significant incidents not yet in the book, with CVE numbers and specific sources. The expanded timeline (ten incidents in twelve months) makes a stronger case than the original five. The WhatsApp case is particularly valuable because it demonstrates cross-server tool poisoning: a malicious server exploiting a legitimate one, with no compromise of the legitimate server needed. The MCP Inspector CVE is notable because it shows the attack surface extends into developer tooling, not just production agents.

**What I considered but did not do:**
- Expanding the introduction (53 lines). Still works as a concise roadmap. No new material warrants expansion.
- Adding new chapters. The book covers all major PAC Framework dimensions. Remaining open topics (incident response, semantic interoperability, chain-of-thought compliance) need more source material to warrant full chapters.
- Updating the regulatory landscape chapter with NIST April 2 deadline proximity. No new information beyond what's already there. Worth monitoring in the next session (20 days until deadline).
- Incorporating Wenjing Chu's "three-legged stool" framing (guardrails, alignment, governance) from the March 11 LFDT meetup. The cross-org-trust chapter already covers TSP extensively. The framing is useful but adding it would duplicate existing coverage without adding technical depth.

**Sources used:**
- AuthZed, "A Timeline of Model Context Protocol (MCP) Security Breaches," authzed.com, 2025-2026
- Invariant Labs / Docker, "MCP Horror Stories: WhatsApp Data Exfiltration," docker.com, April 2025
- Nudge Security, "SaaS Security Alert: Asana MCP Server Data Exposure Incident," June 2025
- Oligo Security, CVE-2025-49596, MCP Inspector RCE, CVSS 9.4, July 2025
- Arctic Wolf, CVE-2026-27825, mcp-atlassian path traversal and RCE, January 2026
- CVE-2026-30861, WeKnora command injection, March 2026

**What I noticed:**
- The MCP security incident pattern is clear: adoption far outpaces security maturity. 97 million monthly SDK downloads against ten documented breaches in twelve months, 30 CVEs in 60 days, and 38% of servers lacking authentication. The incidents span every attack vector: tool poisoning (WhatsApp), access control (Asana), supply chain (mcp-remote, Postmark), infrastructure (MCP Inspector, Smithery), and now SaaS integration (mcp-atlassian). This is the strongest empirical evidence in the book for why communication protocols solve discovery but not trust.
- The WhatsApp case is architecturally important: it demonstrates that MCP's multi-server model creates a cross-server attack surface. A malicious server does not need to compromise other servers. It just needs to share an agent context with them. The tool description is the attack vector, not the code.
- Shane's two most recent posts (Verifiable Intent March 6, LFDT meetup March 11) were already well-integrated by the previous session. The book's coverage of TSP, PIC, Verifiable Intent, TMCP, and TA2A is current.

**Next session priorities:**
1. Monitor NIST April 2 comment period deadline. Update regulatory chapter if new information emerges.
2. Continue tracking MCP specification evolution toward June 2026 update.
3. Quality pass on the agent-identity and cross-org-trust chapters: these are the most technically dense and could benefit from readability review.
4. Consider whether the semantic interoperability gap (Shane's "close a deal" example) warrants expanded treatment in the cross-org-trust chapter or a standalone section.

## 2026-03-12: Building the Inferential Edge (Concluding Chapter)

**What I did:**
- Wrote Chapter 15: "Building the Inferential Edge," the book's concluding synthesis chapter. Sections: the gap (inferential edge thesis with current data), the trust infrastructure stack (how all 13 technical chapters compose into Control/Accountability/Potential layers), where to start (four-phase implementation roadmap mapped to I1-I5 maturity levels), the organizational challenge (process redesign, governance as enablement, compounding organizational learning), the convergence timeline (NIST April 2, MCP June 2026, EU AI Act August 2, AAIF late 2026, NIST-EU 2027), PAC as iterative practice, and the edge that compounds.
- Updated SUMMARY.md with new chapter (16 chapters total including Gaps & Directions).
- Updated introduction's Structure section to reference the concluding chapter.
- Updated PAC Framework chapter's "Applying the Framework" section to reference the concluding chapter.
- Updated gaps.md with two new observations: MCP attack surface acceleration (30 CVEs in 60 days, 38% servers lack auth), and the concluding synthesis note.

**Why this chapter:**
Stepped back and assessed what the book was missing most. The book had 15 chapters, all complete and well-sourced, covering the full PAC landscape. But it had no ending. After Human-Agent Collaboration Patterns, the reader jumped to Gaps & Directions with no synthesis. The book read as a strong reference collection but not as a complete narrative. A concluding chapter was the highest-impact move because it: (1) ties the inferential edge thesis (Shane's central argument) to all 13 technical chapters, showing how they compose into a coherent stack; (2) provides a practical implementation roadmap sequenced by the I1-I5 maturity levels used throughout the book; (3) addresses the organizational dimension (70% of failures are organizational, not technical) which no individual technical chapter covers; (4) maps the convergence timeline that creates urgency; (5) closes the loop on PAC as iterative practice.

**What I considered but did not do:**
- Expanding the introduction (52 lines). It remains concise but complete: purpose, audience, methodology, and structure. Expanding risks filler.
- Quality review of individual chapters. All chapters are well-sourced and current. The concluding chapter implicitly reviews the whole book by showing how chapters connect.
- Dedicated incident response chapter. Still valuable as a future addition, but lower impact than the synthesis chapter. The Multi-Agent Trust chapter covers CoSAI basics.
- Chain-of-thought compliance deep-dive. Partially addressed in Human-Agent Collaboration chapter. Full treatment needs more source material.

**Sources used:**
- Shane's blog posts: "When Intelligence Becomes Commodity" (inferential edge thesis), "The Work That's Leaving" (organizational transformation), "AI Agents Need the Inverse of Human Trust" (trust inversion), "Trusted AI Agents by Design" (TSP + PIC, March 11 LFDT meetup), "Trusted AI Agents: Why Traditional IAM Breaks Down" (PAC Framework)
- PAC Framework from trustedagentic.ai (read fresh, including all 19 questions and dimension scales)
- Gravitee: State of AI Agent Security 2026 (88% security incidents, 14.4% full security approval)
- Microsoft Security Blog: 80% of Fortune 500 use active AI agents, 50%+ without oversight (February 2026)
- Gartner: 1,000+ legal claims projected by end 2026
- Adversa AI: 30 MCP CVEs in 60 days, 38% of 500+ servers lack authentication (March 2026)
- Deloitte: Tech Trends 2026 (14% deployable, 11% in production)
- Enterprise AI transformation research: 70% of failures from organizational resistance
- NIST: AI Agent Identity and Authorization concept paper (comment period April 2, 2026)
- CYE/Noma: Shadow AI statistics (1,200 unofficial AI apps per enterprise)

**What I noticed:**
- The four-phase roadmap (Visibility, Enforcement, Governance, Architecture) maps cleanly to the I1-I5 infrastructure maturity scale used throughout the book. This was not designed top-down: the phases emerged from asking "what depends on what?" The registry must exist before enforcement can reference it. Enforcement must exist before governance can compose across agents. Governance must exist before cross-organizational architecture can build on it. The I-levels were the right abstraction.
- The organizational challenge section draws on data not used elsewhere in the book (70% failure rate from organizational resistance, the process redesign insight). This is territory Shane covers in "The Work That's Leaving" and "When Intelligence Becomes Commodity" but that the technical chapters naturally avoid. The concluding chapter is where these strategic arguments land.
- The convergence timeline creates genuine urgency. NIST comment period in three weeks. EU AI Act enforcement in five months. Organizations building agent infrastructure are simultaneously racing standards timelines and regulatory deadlines. The chapter makes this concrete.
- The book now has a complete narrative arc: problem (Chapter 1) to framework (Chapter 2) to 13 technical deep-dives to synthesis and roadmap (Chapter 15). A reader can enter at any chapter for reference, or read front-to-back for the full argument. The introduction and concluding chapter bookend the work.
- With the concluding chapter, the book has reached a natural first-edition completeness. All major topics from the PAC Framework are covered. The remaining open questions (semantic interoperability, agent gateway + service mesh convergence, chain-of-thought compliance, dedicated incident response) are second-order topics that benefit from more real-world data. Future sessions should focus on quality improvement, freshening sources as the landscape evolves, and adding chapters only when significant new source material warrants it.

**Next session priorities:**
1. Quality review: re-read the full book for consistency, voice, flow, and identify the weakest sections for improvement.
2. Monitor the NIST April 2 deadline and EU AI Act developments for regulatory chapter updates.
3. Track MCP specification evolution (June 2026 target) for communication protocols chapter updates.
4. Consider whether the semantic interoperability gap warrants its own chapter as more source material emerges.

## 2026-03-12: Why Agents Break Trust: Grounding in Real Incidents

**What I did:**
- Expanded why-agents-break-trust.md from 92 to 116 lines by adding concrete real-world failure examples to every section that was previously theoretical-only.
- "What Changed" section: added the Perplexity Comet indirect prompt injection incident (August 2025) as a concrete example of how agent intent expansion becomes a vulnerability.
- "Confused Deputy" section: restructured from two failure modes to three, each grounded in evidence. Added Shane's Google Workspace CLI analysis (gmail.readonly scope creep), the Subabase Cursor agent breach (privileged agent processing attacker-embedded SQL via support tickets), and Galileo's 87% cascading failure statistic for multi-agent delegation chains.
- Added entirely new section "The Supply Chain You Cannot See" covering three documented incidents: GitHub MCP vulnerability (May 2025, malicious instructions in Issues exfiltrating source code and keys), MCPTox benchmark results (72.8% attack success rate on o1-mini, more capable models more susceptible), and the postmark-mcp backdoored NPM package (September 2025, first supply chain attack targeting MCP infrastructure). This section bridges to the Supply Chain Security and Agent Communication Protocols chapters.
- Added 8 new footnotes with sources for all added incidents and research.

**Why this work:**
- Stepped back and assessed all 16 chapters for quality. The chapter quality ranking identified why-agents-break-trust.md as the weakest foundational chapter: only 92 lines, essential problem-framing role, but entirely theoretical. Every argument was abstract. The introduction and gaps chapter are shorter but serve different purposes (roadmap and research notes). This chapter is where a reader decides whether the rest of the book matters.
- The new supply chain section fills a gap: the original chapter covered confused deputies, shadow agents, and complacency but not the tool/supply chain attack surface. With MCP adoption accelerating (97M+ monthly SDK downloads), tool poisoning is now a primary trust failure mode, not a niche concern. It needed to be introduced early.
- Prioritized this over expanding other weak areas (introduction, human-agent-collaboration permission section) because the problem chapter is the foundation: if the "why" is not convincing, the "how" chapters lose their urgency.

**What I considered but did not do:**
- Expanding the introduction (52 lines). It works as a concise roadmap. A longer introduction risks repeating what the problem chapter should establish.
- Adding more content to human-agent-collaboration.md's permission granularity section. On closer reading, it is actually complete (per-tool-call, per-task, and per-session authorization mapped to blast radius levels). The earlier assessment was inaccurate.
- Incorporating the Mastercard Verifiable Intent blog post (March 6, 2026) into agent-identity.md. The post is already well-covered in that chapter. Could be deepened in a future session.
- Web search found IBM's 2026 X-Force Threat Index, Adversa AI's 2025 incident report, and NIST's AI Agent Standards Initiative (comment period through April 2, 2026). These are worth tracking for future chapter updates.

## 2026-03-12: Cross-Reference Review and Structure Update

**What I did:**
- Updated the Introduction's Structure section to reference all 15 chapters (was only listing 9). Added Agent Supply Chain Security, Multi-Agent Trust and Orchestration, and Human-Agent Collaboration Patterns.
- Updated the PAC Framework chapter's "Applying the Framework" section to reference all 12 technical chapters (was only listing 7). Added Agent Communication Protocols, Agent Supply Chain Security, Shadow Agent Governance, Multi-Agent Trust and Orchestration, and Human-Agent Collaboration Patterns, each with PAC pillar mappings.
- Added cross-references in earlier chapters to later ones:
  - why-agents-break-trust.md: shadow agents section now links to Shadow Agent Governance chapter; confused deputy section now links to Multi-Agent Trust chapter; complacency section now links to Reliability and Human-Agent Collaboration chapters.
  - reliability-evaluation.md: "infrastructure in the loop" section now links to Human-Agent Collaboration Patterns chapter.
  - execution-security.md: final recommendation about the "other half" of OWASP risks now links to the five relevant chapters (identity, cross-org trust, communication, supply chain, shadow agents).
  - agent-identity.md: closing section now links to Cross-Organization Trust and Multi-Agent Trust chapters.
  - cross-org-trust.md: closing paragraph now links to Multi-Agent Trust chapter.
  - regulatory-landscape.md: shadow agents section now links to Shadow Agent Governance chapter.

**Why this work:**
Stepped back and assessed priorities. The book has 15 complete chapters but the introduction and PAC Framework chapter had not been updated to reflect the full scope. Readers arriving at the book would see only 9 of 15 chapters listed, missing the most recent and some of the strongest work. Earlier chapters also had no forward references to later ones, making the book feel like a collection of standalone essays rather than a coherent narrative. Cross-referencing ties the book together: a reader who encounters shadow agents in Chapter 2 now knows there is a full chapter on governance, and a reader in the complacency chapter now knows there is a practical companion on collaboration patterns.

**What I considered but did not do:**
- Incident response chapter: still valuable but the existing coverage in the Multi-Agent Trust chapter is adequate for now. A dedicated chapter would benefit from more real-world incident data accumulating.
- New chapter on the inferential edge / organizational readiness: Shane's "When Intelligence Becomes Commodity" post has rich material. But the introduction already captures the core thesis, and the existing chapters cover the infrastructure in detail. This could become a concluding chapter in a future session.
- Updating chapters with new Gravitee data (88% of orgs had security incidents, only 14.4% have full security approval) or Gartner's prediction (1,000+ legal claims by end 2026): useful data points but not worth disrupting well-structured existing chapters for incremental statistics.

**Sources consulted (web search):**
- Gravitee: State of AI Agent Security 2026 (88% security incidents, 14.4% full security approval, 50%+ agents without oversight)
- Gartner: 1,000+ legal claims for AI agent harm predicted by end 2026
- NIST: AI Agent Standards Initiative and RFI (due March 9), Identity/Authorization concept paper (due April 2)
- NIST-EU: mutual recognition mechanisms targeting 2027

**What I noticed:**
- The book's structure is now coherent. The introduction, PAC Framework chapter, and earlier chapters all reference the full scope of the work. A reader can navigate from any entry point to the relevant deeper treatment.
- The six cross-references added are the highest-value links: each connects a problem diagnosis in an early chapter to its practical solution in a later one (shadow agents → governance, confused deputy → multi-agent trust, complacency → collaboration patterns, sandboxing limits → the five chapters covering the other OWASP risks).
- The book is reaching a natural completeness point for its first arc. All major topics from the PAC Framework are covered. The remaining gaps (incident response, semantic interoperability, agent gateways + service mesh convergence, chain-of-thought compliance) are second-order topics that benefit from more real-world data accumulating.

**Next session priorities:**
1. Consider a concluding/synthesis chapter that ties the book together: the inferential edge thesis, where the landscape is heading, what to build first.
2. Review the weakest chapters for quality: which ones would benefit from additional sources or restructuring?
3. Continue monitoring for significant developments (NIST April 2 deadline, EU AI Act August 2 enforcement, MCP roadmap progress).

## 2026-03-12: Human-Agent Collaboration Patterns Chapter

**What I did:**
- Wrote Chapter 15: "Human-Agent Collaboration Patterns" covering how to design effective human-agent oversight that does not depend on sustained human vigilance. Sections: three oversight models (HITL, HOTL, infrastructure-in-the-loop), the autonomy dial (per-task autonomy levels, not per-agent), UX patterns that work (pre-action intent visibility, in-action explainable rationale, post-action audit and undo), permission granularity (matched to blast radius: per-tool-call for B4-B5, per-task for B2-B3, per-session for B1), the self-aware agent (agent-initiated oversight via uncertainty recognition, Anthropic's 16.4% vs 7.1% finding), the organizational shift (Deloitte's "silicon-based workforce," onboarding/performance/escalation/offboarding lifecycle), PAC mapping table, infrastructure maturity for collaboration (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Updated gaps.md with two new observations (human-agent collaboration UX as missing governance layer, authorization platforms maturing) and marked three open questions as addressed (permission granularity, human-agent oversight UX, partially chain-of-thought compliance).

**Why this chapter:**
Stepped back and assessed what the book was missing most. The book had 14 complete chapters. The complacency trap chapter (Ch. 6) diagnoses the oversight problem thoroughly, grounding it in 40+ years of human factors research. But it stops at the prescription level: "build infrastructure that does not depend on human vigilance" without specifying what that collaboration looks like in practice. This was the biggest conceptual gap: every prior chapter assumes an oversight model without defining it. The human-agent collaboration chapter is the operational companion to the complacency chapter: one says why human oversight fails, the other says what to build instead.

**What I considered but did not do:**
- Incident response chapter: still valuable but less urgent than the oversight gap. The multi-agent trust chapter covers CoSAI basics.
- Cross-reference review of earlier chapters: useful housekeeping but lower impact than filling the oversight gap.
- Revising existing chapters with recent developments: chapters are well-sourced and current through March 2026.

**Sources used:**
- Shane's blog posts: trust inversion, early indicators of agent use cases (Anthropic autonomy data), inferential edge, PAC Framework
- PAC Framework from trustedagentic.ai (read fresh)
- Anthropic: "Measuring AI Agent Autonomy in Practice" (February 2026): 20% to 40%+ auto-approve progression, 16.4% agent-initiated clarification vs 7.1% human interruption, oversight infrastructure recommendations
- Smashing Magazine: "Designing For Agentic AI: Practical UX Patterns For Control, Consent, And Accountability" (February 2026): taxonomy of agentic UX patterns (explainable rationale, confidence signals, action audit, escalation pathways)
- UX Magazine: "Secrets of Agentic UX: Emerging Design Patterns for Human Interaction with AI Agents" (2026)
- ByteBridge: "From Human-in-the-Loop to Human-on-the-Loop: Evolving AI Agent Autonomy" (January 2026)
- Deloitte: "The agentic reality check: Preparing for a silicon-based workforce" (Tech Trends 2026): 14% deployable solutions, 11% in production, process redesign vs. process automation
- Authorization platforms: Permit.io (Access Request MCP, AI access control), Cerbos (dynamic authorization for MCP servers), Stytch (agent permissions), WorkOS (comparison guide)
- Bainbridge (1983) and Don Norman (1990): referenced via complacency chapter, not repeated

**What I noticed:**
- The autonomy dial concept (per-task, not per-agent) is a genuine insight that resolves a tension in how organizations think about agent governance. Most governance models set autonomy at the agent level, but trust is task-specific. The PAC Framework's A1-A5 scale maps cleanly to this when applied per task type rather than per agent.
- Anthropic's finding that agents recognize uncertainty more often than humans (16.4% vs 7.1%) is the strongest empirical evidence for agent self-governance as a viable complement to external oversight. This deserves more attention: if we can monitor agent calibration over time, we have a measurable governance metric that does not depend on human attention.
- The authorization platform landscape (Permit.io, Cerbos, Stytch, WorkOS) shows that the infrastructure for fine-grained agent permissions is shipping now, not theoretical. The gap between "permission granularity should match blast radius" (the principle) and "here is how you implement it" (the tooling) is closing.
- Deloitte's 14%/11% deployment numbers are sobering. The vast majority of organizations have not deployed agents in production. The ones succeeding are redesigning processes, not automating existing ones. This reinforces Shane's inferential edge thesis: the competitive advantage is organizational readiness, not model capability.
- This chapter completes the "governance in practice" arc: complacency (why oversight fails) + collaboration (how to redesign it) + shadow agents (how to discover what is already running) + multi-agent trust (how governance scales across agent-to-agent delegation). The book now has a complete story from problem diagnosis to operational solution.

**Next session priorities:**
1. Cross-reference review: ensure earlier chapters reference the new collaboration and multi-agent trust chapters where appropriate
2. Consider a dedicated incident response chapter (CoSAI framework + multi-agent IR + agent-specific playbooks)
3. Review the book's overall flow: with 15 chapters, is the ordering still right? Should any chapters be combined or reordered?

## 2026-03-12: Multi-Agent Trust and Orchestration Chapter

**What I did:**
- Wrote Chapter 14: "Multi-Agent Trust and Orchestration" covering how trust properties compose (or break) when agents delegate to other agents. Sections: the delegation problem (DeepMind's five requirements), why trust does not compose by default (authority amplification, accountability gaps, trust transitivity), cascading failures (OWASP ASI08, Galileo's 87% downstream poisoning research), Delegation Capability Tokens (macaroons, biscuits, authority attenuation), the orchestration governance gap (Salesforce/Deloitte data), architectural patterns (hierarchical delegation, circuit breakers, delegation registries, PIC for multi-agent chains), incident response for multi-agent systems (CoSAI framework), PAC mapping table, infrastructure maturity (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Updated gaps.md with two new observations (multi-agent governance frontier, CoSAI incident response framework) and marked multi-agent orchestration and incident response open questions as addressed.

**Why this chapter:**
Stepped back and assessed what the book was missing most. The book had 13 chapters, all complete. The biggest remaining gap was multi-agent trust: every existing chapter examined trust through the lens of a single agent, but the industry is moving to multi-agent orchestration (12 agents per org average, 67% growth projected). The source material matured significantly: DeepMind's "Intelligent AI Delegation" paper provides the technical framework (DCTs), OWASP ASI08 and Galileo's research quantify the cascading failure risk, the IACR "Trustworthy Agent Network" paper argues trust must be architected from the start, and CoSAI's incident response framework provides the operational response. The chapter connects to cross-org trust (delegation chains across organizations), supply chain security (cascading failures through tool chains), and shadow agent governance (50% of agents in silos = ungoverned multi-agent systems).

**Sources used:**
- Shane's blog posts: trust inversion, traditional IAM breakdown, trust for agentic AI (PAC Framework)
- PAC Framework from trustedagentic.ai (read fresh)
- Google DeepMind: "Intelligent AI Delegation" (arXiv:2602.11865, February 2026): five core requirements, Delegation Capability Tokens, macaroons/biscuits
- IACR: "Trustworthy Agent Network" (ePrint 2026/497, March 2026): trust must be baked in, not bolted on
- OWASP: ASI08 Cascading Failures (Top 10 for Agentic Applications, December 2025)
- Galileo AI: multi-agent system failure research (December 2025): 87% downstream poisoning within 4 hours
- Salesforce: Connectivity Benchmark Report 2026 (12 agents per org, 50% in silos, 67% growth)
- Deloitte: TMT Predictions 2026 ($8.5B market, 75% companies investing, 1 in 5 has mature governance)
- CoSAI: AI Incident Response Framework V1.0 (CACAO-standard playbooks)
- Drift breach and PIC (referenced from Cross-Organization Trust chapter)

**What I noticed:**
- The governance cost scaling insight is important: governance cost scales with delegation depth, not just agent count. 12 agents reporting to humans = 12 governance relationships. 12 agents in delegation chains = potentially factorial governance relationships. This is why multi-agent governance cannot be an afterthought.
- DCTs (macaroons/biscuits) map directly to Shane's principle that authority must only decrease in delegation chains. The cryptographic structure makes this mathematically enforced rather than policy-enforced. This is the structural enforcement approach Shane advocates.
- The gap between I1 (where most organizations are for multi-agent governance) and I3 (where regulated industries need to be by August 2026) is the most actionable finding. Organizations building multi-agent systems need delegation registries, authority attenuation, and cross-agent audit trails now.
- The Galileo research (87% downstream poisoning in 4 hours) is the multi-agent equivalent of the Drift breach (700 companies in 10 days): a concrete, quantified example of why trust boundaries and cascade prevention are not optional.
- CoSAI's incident response framework is necessary but not sufficient for multi-agent systems. The framework addresses individual AI system incidents well. Multi-agent incident response requires additional capabilities: delegation chain tracing, coordinated revocation, and output propagation assessment. A dedicated incident response chapter could extend this.

**Next session priorities:**
1. Review existing chapters for cross-references to the new multi-agent trust chapter
2. Consider a dedicated incident response chapter (CoSAI framework + multi-agent specifics)
3. Human-agent oversight UX chapter (still the thinnest topic in the book, needs more source material)

## 2026-03-12: Agent Supply Chain Security Chapter

**What I did:**
- Wrote Chapter 10: "Agent Supply Chain Security" covering the trust chain beyond the agent itself. Sections: the OpenClaw ClawHavoc crisis as concrete case study, agent supply chain attack taxonomy (six distinct attack vectors), the trust registry problem, AI-BOM concept, defense patterns (four layers), CSA Agentic Trust Framework, PAC mapping, infrastructure maturity (I1-I5), and practical recommendations.
- Updated agent-communication.md with the MCP 2026 roadmap details announced March 9, 2026 (four priority areas: streamable HTTP transport, Tasks primitive refinements, .well-known discovery, enterprise deployment needs).
- Updated gaps.md with three new observations (supply chain as newest attack surface, MCP roadmap specifics, non-human identity scale) and three new open questions (multi-agent orchestration, incident response, human-agent interaction UX).

**Why this chapter:**
Stepped back and assessed what the book was missing most. All 12 existing chapters were assessed as complete and well-sourced. The CLAUDE.md target is 15+ chapters. The biggest gap was supply chain security: the OpenClaw ClawHavoc campaign (1,184 malicious skills), BlueRock's MCP SSRF findings (36.7% of 7,000 servers), and the Azure MCP SSRF (CVE-2026-26118) are all recent, significant, and directly connected to Shane's writing about OpenClaw and the scaffolding trap. The execution-security chapter covers sandboxing and containment, but supply chain is a distinct problem: it's about trusting the components inside the sandbox, not just containing the sandbox itself.

**What I considered but did not do:**
- Multi-agent orchestration chapter: important but less urgent than supply chain (the cross-org trust and communication chapters already touch on agent-to-agent patterns).
- Incident response chapter: valuable but depends on supply chain and other security chapters being in place first.
- Human-agent interaction UX chapter: the complacency trap chapter frames the problem well; the UX solution needs more source material.

**Sources used:**
- Shane's blog posts: "AI Agent Reliability Is Getting Easier" (OpenClaw reference), "OpenClaw and Moltbook" (AI literacy, trust/fear dynamics)
- PAC Framework from trustedagentic.ai (read fresh)
- Koi Security ClawHavoc research (1,184 malicious skills on ClawHub)
- SecurityScorecard OpenClaw enterprise exposure analysis (135,000+ instances)
- BlueRock Security MCP fURI vulnerability research (36.7% SSRF rate across 7,000 servers)
- Microsoft CVE-2026-26118 (Azure MCP SSRF)
- Anthropic/UK AISI/Turing Institute model poisoning research (250 documents)
- OWASP Top 10 for Agentic Applications (ASI04: Memory Poisoning)
- NVIDIA AI Red Team sandboxing guidance (configuration file protection)
- CSA Agentic Trust Framework (February 2026)
- CSA/Strata Identity survey (NHI ratio 100:1, 84% compliance doubt)
- OWASP AI-BOM Initiative, SPDX 3.0.1 AI profiles
- MCP 2026 Roadmap announcement (March 9, 2026)
- MCPTox benchmark (capable models more vulnerable to tool poisoning)
- ERC-8004 reputation registry pattern

**What I noticed:**
- The supply chain chapter reveals a pattern: every chapter in the book assumes the components inside the agent are trustworthy. Supply chain security is the chapter that questions that assumption. It connects to every other chapter: identity (tool publisher identity), context (context sources as supply chain components), execution security (sandboxing assumes trust in what's sandboxed), communication (MCP servers as supply chain links), shadow agents (unsanctioned agents with unverified dependencies).
- The CSA survey data quantifies the identity gap at enterprise scale: NHIs outnumber humans 100:1. This makes Shane's trust inversion principle not just theoretically important but operationally urgent.
- The MCP roadmap's inclusion of "enterprise deployment needs" (audit trails, SSO-integrated auth, gateway behavior) signals MCP transitioning from developer protocol to production infrastructure. This is the maturity curve the book's infrastructure maturity tables predict.
- The AI-BOM concept is the supply chain equivalent of the agent registry from the shadow agent governance chapter. Both are inventory problems. The difference: the agent registry inventories agents; the AI-BOM inventories each agent's dependencies. Together they provide full visibility.

**Next session priorities:**
1. Human-agent interaction patterns chapter (UX of trust, oversight models beyond "human in the loop")
2. Multi-agent orchestration and trust composition chapter
3. Review and tighten existing chapters for cross-references to the new supply chain chapter

## 2026-03-12: Foundation Chapters

**What I did:**
- Wrote Chapter 1: "Why Agents Break Trust" — the problem statement. Covers why traditional IAM breaks down, the confused deputy problem with agents, shadow agents, the reliability vs. governance split, and what trust infrastructure looks like.
- Wrote Chapter 2: "The PAC Framework" — deep walkthrough of all three pillars (Potential, Accountability, Control) with their dimensions, scales, and interdependencies.
- Expanded the Introduction with book purpose, audience, and structure.
- Populated Gaps & Directions with observations and a prioritized list of next chapters.

**Why these first:**
The book was empty. It needed a foundation: a clear problem statement and a thorough explanation of the framework that organizes everything else. These two chapters set up every subsequent chapter.

**Sources used:**
- PAC Framework from trustedagentic.ai (read fresh)
- All of Shane's blog posts (read and analyzed for voice, themes, and claims)
- NIST concept paper on AI agent identity and authorization (February 2026)
- EU AI Act enforcement timeline (August 2026 high-risk obligations)
- Web search on OAuth extensions for agentic AI, agent gateways, DPoP, Zero Trust for agents

**What I noticed:**
- NIST and EU AI Act enforcement are converging on agent governance simultaneously. This timing is significant for the regulatory chapter.
- Agent gateways are an emerging infrastructure pattern that Shane hasn't covered directly but maps well to the Control pillar.
- The complacency problem (better reliability leading to worse oversight) connects to decades of human factors research in aviation. Worth grounding in that literature.
- Shane's framing of "delegation becomes abdication" is the single most important insight for the accountability argument. Built Chapter 1 around it.

**Next session priorities:**
1. Agent Identity and Delegation chapter (strongest source material, high impact)
2. Context Infrastructure chapter (most original contribution from Shane)

## 2026-03-12: Agent Identity and Delegation Chapter

**What I did:**
- Wrote Chapter 3: "Agent Identity and Delegation" covering the full technical landscape of agent identity infrastructure. Sections: trust inversion, why traditional IAM breaks down (history from LDAP through DIDs), OAuth extensions for agents (OBO, DPoP, Auth0 Token Vault), decentralized identity (DIDs, VCs, TSP), Verifiable Intent (Mastercard/Google three-layer SD-JWT), regulatory convergence (NIST, OpenID, eIDAS 2.0), mapping back to PAC infrastructure levels, and practical recommendations.
- Updated Gaps & Directions with new observations on Verifiable Intent and standards convergence.
- Marked Agent Identity as done in the chapter priority list.

**Why this chapter:**
It was the #1 priority in the gaps doc, Shane has the strongest source material across 6+ blog posts, and the standards landscape is moving fast (NIST comment period closes April 2, 2026). Timely and foundational.

**Sources used:**
- Shane's blog posts: trust inversion, IAM breakdown, auth crash course, Google Workspace/OAuth critique, verifiable credentials signing, Verifiable Intent analysis, IAM emerging patterns
- PAC Framework from trustedagentic.ai
- IETF: RFC 8693 (Token Exchange), RFC 9449 (DPoP), draft-oauth-ai-agents-on-behalf-of-user-02
- NIST: "Accelerating the Adoption of Software and AI Agent Identity and Authorization" (Feb 2026)
- OpenID Foundation: AIIM Community Group whitepaper
- Mastercard/Google: Verifiable Intent specification (March 2026)
- Auth0: Token Vault for AI Agents documentation
- Web searches on TSP, eIDAS 2.0, agent identity standards 2026

**What I noticed:**
- Verifiable Intent is the first production-grade answer to Shane's consent theater critique. The three-layer SD-JWT architecture maps cleanly to PAC: Layer 1 is identity (Control), Layer 2 is intent constraints (Accountability), Layer 3 is action proof (all three pillars).
- The identity standards landscape is converging faster than expected. NIST, OpenID, IETF, and industry (Mastercard/Google/Stripe) are all moving simultaneously. The PAC Framework's emphasis on building on standards rather than proprietary solutions is well-timed.
- Auth0 Token Vault is pragmatic but limited: it solves credential management but not purpose encoding or delegation tracking. Good for I2-I3 infrastructure levels.
- The infrastructure maturity table (I1-I5 mapped to identity capabilities) is a useful framing that could extend to other chapters.

**Next session priorities:**
1. Context Infrastructure chapter (Shane's most original contribution, high impact)
2. Regulatory Landscape chapter (timely given August 2026 EU AI Act enforcement)

## 2026-03-12: Context Infrastructure Chapter

**What I did:**
- Wrote Chapter 4: "Context Infrastructure" covering the durable investment thesis for context. Sections: the depreciation cycle (fine-tuning, RAG, scaffolding), the scaffolding trap with Claude Code and Manus examples, what context means (curated information + governed access), context in practice (Claude Code's CLAUDE.md pattern, Manus's KV-cache optimization, Clawdbot as cautionary tale), five dimensions (structure, permissions, discovery, authority, freshness), MCP and A2A as discovery protocols, agent gateways as enforcement layer, the compounding effect, PAC mapping table, infrastructure maturity for context, and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Context Infrastructure as done in gaps.md.

**Why this chapter:**
It was the #1 priority in the gaps doc after identity. Shane's context infrastructure post is one of his most original contributions: the argument that context appreciates while everything else depreciates is counterintuitive and supported by concrete examples. The industry conversation around context engineering has exploded in 2026 (Anthropic's blog post, Manus's lessons, LangChain's framework), providing rich supplementary material.

**Sources used:**
- Shane's blog posts: context infrastructure investment, scaffolding trap/reliability shifting, fitting agentic AI components in a mental model
- PAC Framework from trustedagentic.ai
- Anthropic Engineering Blog: "Effective context engineering for AI agents" (Sep 2025)
- Manus: "Context Engineering for AI Agents: Lessons from Building Manus" (2026)
- LangChain Blog: "Context Engineering for Agents" (2026)
- MCP 2026 roadmap from blog.modelcontextprotocol.io
- Google Cloud Blog: A2A protocol updates (v0.3, 150+ organizations)
- Towards Data Science: "Is RAG Dead? The Rise of Context Engineering and Semantic Layers"
- Multiple industry analyses on agent gateways (Gartner, Solo.io, Composio)
- PIC Protocol specification

**What I noticed:**
- The context engineering conversation has shifted from "how to stuff the prompt" to "how to build organizational information infrastructure." Shane was ahead of this curve: his February 2026 post framed it as infrastructure investment before the industry adopted the terminology.
- Manus's KV-cache insight is operationally important: 100:1 input-to-output ratio means context management is the dominant cost and performance driver, not generation. This validates Shane's emphasis on the information layer over the model layer.
- MCP adoption is striking: 97 million monthly SDK downloads, Linux Foundation governance, adoption by OpenAI, Google, and Anthropic. This is becoming the standard discovery protocol for agent context. The 2026 roadmap addresses the right gaps (stateless transport, `.well-known` discovery).
- A2A reaching 150+ organizations with v0.3 and gRPC support signals that agent-to-agent communication is standardizing faster than expected. Auth0 partnering on A2A authentication is a convergence point with the identity chapter.
- Agent gateways are emerging as the "missing layer" analogous to API gateways for microservices. Gartner predicting majority of API gateway vendors will add MCP capabilities by 2026 suggests this will be standard infrastructure.
- The Clawdbot example works on two levels: as evidence that context is powerful (rich context made it compelling) and as evidence that context without control is dangerous (missing access controls made it a risk). This duality maps directly to PAC's Potential-Control interdependence.

**Next session priorities:**
1. Regulatory Landscape chapter (timely given August 2026 EU AI Act enforcement and April 2 NIST comment deadline)
2. Reliability, Evaluation, and the Complacency Trap chapter (human factors angle underexplored)

## 2026-03-12: The Regulatory Landscape Chapter

**What I did:**
- Wrote Chapter 5: "The Regulatory Landscape" covering the full regulatory and standards picture for agent governance. Sections: EU AI Act (risk tiers, the classification problem for agents, provider/distributor/deployer roles, shadow agents and Article 4, high-risk requirements mapped to infrastructure, Commission guidelines), NIST (concept paper on agent identity/authorization, AI Agent Standards Initiative with three pillars), ISO 42001 (management system baseline, certification adoption), U.S. state legislation (Colorado AI Act), standards convergence (IETF agent auth draft, OpenID AIIM, OIDC-A proposal, industry standards), PAC mapping to regulation across all three pillars, infrastructure maturity readiness table (I1-I5 against regulatory requirements), convergence timeline, and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Regulatory Landscape as done in gaps.md.

**Why this chapter:**
It was the #3 priority in the gaps doc and the next logical chapter after identity and context infrastructure. The timing is urgent: EU AI Act high-risk obligations take effect August 2, 2026 (less than 5 months away), NIST comment period closes April 2 (3 weeks away), and the Colorado AI Act goes live June 1. Shane's EU AI Act post is the primary source, supplemented by his boardroom questions post and the LFDT meetup post.

**Sources used:**
- Shane's blog posts: EU AI Act analysis, boardroom questions, LFDT meetup (TSP + PIC), trust inversion, scaffolding trap
- PAC Framework from trustedagentic.ai
- EU AI Act: Articles 4, 6, 9, 10, 11, 12, 14, 15, 17, 51; Annex III; GPAI Provider Guidelines (July 2025)
- The Future Society: "Ahead of the Curve: Governing AI Agents Under the EU AI Act"
- NIST: NCCoE concept paper (Feb 2026), CAISI AI Agent Standards Initiative (Feb 2026)
- ISO/IEC 42001:2023 documentation and BSI certification information
- IETF: draft-klrc-aiagent-auth-00
- OpenID Foundation: AIIM Community Group, response to NIST RFI
- OIDC-A 1.0 proposal
- Colorado AI Act
- Web searches: EU AI Act 2026 enforcement, NIST agent standards, ISO 42001 adoption, AI agent liability/accountability regulation

**What I noticed:**
- The regulatory convergence is tighter than I expected. EU AI Act (August 2026), Colorado AI Act (June 2026), and NIST standards work (Q1-Q2 2026) all land in the same window. Organizations that build infrastructure now get compliance as a byproduct. Organizations that wait will face simultaneous deadlines.
- NIST's framing of the AI Agent Standards Initiative uses a Potential argument: fragmented ecosystems stunt adoption. This is interesting because it aligns NIST with PAC's value-first approach rather than purely security or compliance framing.
- ISO 42001 fills a specific gap: it provides the management system scaffolding within which technical solutions operate. It does not solve agent identity or authorization, but it formalizes the governance loops that make technical solutions accountable.
- The infrastructure maturity table (I1-I5 mapped to regulatory readiness) turned out to be a useful synthesis. Most organizations are at I1-I2 for agent deployments. Regulatory timelines demand I3+ for high-risk uses by August 2026. That is a significant infrastructure gap to close in 5 months.
- Shane's LFDT meetup post (March 11, 2026) introduces PIC (Provenance, Identity, Continuity) as a complementary approach to TSP. The PIC paradigm shift from "proof of possession" to "proof of continuity" is relevant to the regulatory discussion because it eliminates the confused deputy problem mathematically rather than mitigating it through policy. This deserves deeper treatment in a future chapter.

**Next session priorities:**
1. Reliability, Evaluation, and the Complacency Trap chapter (human factors angle, strongest remaining gap)
2. Agent Payments and Economics chapter (x402, payment as trust signal)

## 2026-03-12: Reliability, Evaluation, and the Complacency Trap Chapter

**What I did:**
- Wrote Chapter 6: "Reliability, Evaluation, and the Complacency Trap" covering the dangerous intersection of improving reliability and degrading human oversight. Sections: what reliability actually means (four dimensions: consistency, robustness, predictability, safety), the benchmark landscape (SWE-bench Verified, τ-bench, GAIA, HAL), the evaluation gap (offline vs online adoption drop from 52% to 37%), the observability shift (debugging vs governance-grade audit trails), the complacency trap (grounded in Bainbridge 1983 and Don Norman 1990), the agent-specific version (review fatigue, accountability diffusion, scope creep, the 99% problem), why better models make governance harder (the PAC interdependency break), from human-in-the-loop to infrastructure-in-the-loop, evaluation as governance infrastructure, PAC mapping table, and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Reliability chapter as done in gaps.md.
- Updated complacency observation in gaps.md to reflect coverage.

**Why this chapter:**
It was the #1 remaining priority in the gaps doc. Shane's writing on the scaffolding trap, trust inversion, and Anthropic's autonomy data all pointed to the same gap: reliability is improving faster than governance. The human factors angle (Bainbridge's ironies of automation, Don Norman's intermediate automation problem) provides 40+ years of research grounding that makes the argument concrete rather than speculative. The chapter bridges Potential and Accountability pillars, which were less deeply covered than Control.

**Sources used:**
- Shane's blog posts: scaffolding trap, trust inversion (Don Norman quote, "human in the loop is not a reliable safety net"), Anthropic's data analysis (50% coding, upper-right quadrant), agent profiler reasoning ("infrastructure is a gate, not a slider")
- PAC Framework from trustedagentic.ai
- Lisanne Bainbridge, "Ironies of Automation" (Automatica, 1983): skill degradation and vigilance failure
- Don Norman, "The 'Problem' of Automation" (1990): intermediate automation as the danger zone
- Saumya Banthia et al., "Towards a Science of AI Agent Reliability" (arXiv, Feb 2026): four-dimensional reliability decomposition
- LangChain State of AI Agents 2026: 57% in production, 52% offline evals, 37% online evals, 32% cite quality as top barrier
- Anthropic, "Measuring AI Agent Autonomy in Practice" (Feb 2026): 73% human oversight, domain distribution
- Sierra τ-bench: dynamic benchmark exposing agent brittleness in interactive settings
- Princeton HAL Leaderboard: unified benchmarking across SWE-bench, GAIA, τ-bench (ICLR 2026)
- Help Net Security (March 2026): only 21% executive visibility into agent permissions, 80% report risky agent behaviors
- Clinical study: 6% tumor detection rate reduction after months of AI-assisted colonoscopy
- Braintrust, Arize: agent observability ecosystem 2026

**What I noticed:**
- The evaluation gap data (52% offline, 37% online, 23% not evaluating at all) is the complacency trap in quantitative form. Teams invest in proving capability and underinvest in monitoring behavior. This is exactly the Potential-Accountability split Shane describes.
- Bainbridge's 1983 paper is strikingly relevant. Her two ironies (skill degradation + vigilance failure) map directly to agent oversight: reviewers lose the ability to catch errors because they rarely need to, and monitoring a highly reliable system is cognitively exhausting. The 40-year gap between her writing and current AI agent deployment shows how slowly automation governance lessons transfer between domains.
- The clinician colonoscopy study (6% tumor detection drop with AI assistance) is the most concrete evidence I found for the complacency trap in a high-stakes domain. It illustrates Bainbridge's skill degradation pattern: the AI made clinicians better on average but degraded their independent capability.
- τ-bench's results are important for a reason beyond benchmark scores: they show that static benchmarks do not predict dynamic performance. An agent that scores well on SWE-bench may struggle with τ-bench because interactive, real-time environments create failure modes that controlled test sets do not. This validates Anthropic's finding that pre-deployment evaluation alone is insufficient.
- The "infrastructure in the loop" framing feels like the right synthesis. It respects Shane's position that "human in the loop is not a reliable safety net" while providing a constructive alternative. Structural authorization, anomaly detection, automatic containment, and audit trails do not depend on human vigilance. They encode human judgment into infrastructure that operates whether anyone is watching or not.
- The PAC interdependency break (high reliability reducing governance investment) is the chapter's most important idea. It explains why the problem gets worse as agents get better, which is counterintuitive enough to be worth stating clearly.

**Next session priorities:**
1. Agent Payments and Economics chapter (x402, EIP-3009, payment as trust signal)
2. Sandboxing and Execution Security chapter (native OS vs Docker vs DevContainers, OWASP Top 10)

## 2026-03-12: Agent Payments and Economics Chapter

**What I did:**
- Wrote Chapter 7: "Agent Payments and Economics" covering the full landscape of agent payment infrastructure. Sections: why traditional payments break for agents, payment as trust signal (Shane's key insight), x402 and EIP-3009 (gasless stablecoin payments with detailed flow and economics), the three commerce protocols (AP2/Google, ACP/Stripe+OpenAI, UCP/Google+Shopify+Walmart), on-chain agent identity via ERC-8004 (three registries: identity, reputation, validation), real-world milestones (Santander/Mastercard first European agent payment, Stripe x402 preview, J.P. Morgan/Mirakl agentic commerce), micro-transaction economics, authorization via Verifiable Intent constraints, PAC mapping table, infrastructure maturity for payments (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Agent Payments as done in gaps.md.
- Added new observations on payment infrastructure velocity and ERC-8004 as cross-organizational trust primitive.

**Why this chapter:**
It was the #1 priority in the gaps doc. Shane has deep hands-on experience (built an x402 demo, analyzed ERC-8004 and Verifiable Intent in detail), and the real-world deployment milestones from Q1 2026 (Santander/Mastercard, Stripe, J.P. Morgan) make the timing right. Agent payments are moving from proof-of-concept to production, and the convergence of payment protocols with trust infrastructure (Verifiable Intent, ERC-8004) validates the PAC Framework's emphasis on Control pillar infrastructure.

**Sources used:**
- Shane's blog posts: x402 hands-on (Jan 7, 2026), ERC-8004 mainnet (Jan 28, 2026), Verifiable Intent (Mar 6, 2026)
- PAC Framework from trustedagentic.ai
- x402 specification (x402.org) and Foundation announcement (Coinbase/Cloudflare, Sep 2025)
- Stripe: x402 payments documentation, The Block coverage (Feb 11, 2026)
- Google Cloud Blog: AP2 announcement (2026)
- Stripe/OpenAI: ACP specification and Instant Checkout in ChatGPT
- Google Developers Blog: UCP specification
- ERC-8004: EIP specification, multi-chain deployment data
- Mastercard Newsroom: Santander agent payment milestone (Mar 2, 2026)
- J.P. Morgan Payments: Mirakl Nexus agentic commerce agreement (Mar 10, 2026)
- Solana x402 transaction data (35M+ transactions, $10M+ volume)
- Web searches on agent payment economics, micro-transaction infrastructure, stablecoin settlement

**What I noticed:**
- The speed of adoption is striking. In January 2026, Shane built a proof-of-concept. By March 2026, Mastercard and Santander completed a live regulated payment. That is an unusually fast move from experimental to production in financial services.
- The three commerce protocols (AP2, ACP, UCP) are more complementary than competitive. AP2 handles payment authorization, ACP handles checkout flows, UCP handles product discovery. Verifiable Intent provides the shared cryptographic constraint layer. This is convergence, not fragmentation.
- ERC-8004's three-registry pattern (identity, reputation, validation) is a general architecture that could apply off-chain too. The insight that payment receipts provide Sybil resistance for reputation (you can only rate services you paid for) is elegant.
- The micro-transaction economics are decisive. Traditional payment processing ($0.30 minimum) cannot support $0.01 API calls. L2 stablecoin settlement ($0.002 gas) can. This is not a marginal improvement: it is the difference between viable and impossible for agent-to-agent commerce.
- Payment infrastructure and trust infrastructure are converging. Verifiable Intent turns spending constraints into cryptographic objects. ERC-8004 turns reputation into on-chain signals. x402 turns settlement into inline HTTP. These are not separate systems: they are layers of the same governance stack.
- The chapter connects to all three PAC pillars more naturally than some previous chapters. Payment as a trust signal is simultaneously Potential (new business models), Accountability (auditable proof of authorization), and Control (cryptographic spending constraints). This makes it a strong example of how the pillars are interdependent.

**Next session priorities:**
1. Sandboxing and Execution Security chapter (native OS vs Docker vs DevContainers, OWASP Top 10)
2. Cross-Organization Trust chapter (TSP + eIDAS 2.0 + EUDI + Verifiable Credentials assembly)

## 2026-03-12: Sandboxing and Execution Security Chapter

**What I did:**
- Wrote Chapter 8: "Sandboxing and Execution Security" covering the full execution security landscape for agents. Sections: the permission prompt problem (approval fatigue, knowledge gaps, speed-vs-safety), containment by design (filesystem + network isolation as dual requirement), the isolation spectrum (native OS sandboxing, containers, gVisor, microVMs with performance and security comparison table), OWASP Top 10 for Agentic Applications (all 10 risks with sandboxing coverage mapping: strong for 5, partial for 2, none for 3), defense in depth (six layers: input validation, sandboxed execution, configuration protection, output validation, credential scoping, behavioral monitoring), ephemeral vs persistent sandbox design, real-world architectures (Claude Code, Codex CLI, Docker microVM), PAC mapping table, infrastructure maturity for execution security (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Marked Sandboxing chapter as done in gaps.md.
- Added new observations on execution security landscape maturation and configuration file protection as attack vector.

**Why this chapter:**
It was the #1 priority in the session log and #6 in the original gaps list. Shane's Docker sandbox post is his most technically concrete piece on execution security, and the supporting material has matured significantly: OWASP released the agentic Top 10 in December 2025, NVIDIA published production sandboxing guidance, and both Anthropic and OpenAI have shipped native sandbox implementations. The chapter completes the Control pillar depth that was missing from the book.

**Sources used:**
- Shane's blog posts: Docker sandbox vs native (Feb 7, 2026), trust inversion (Feb 3, 2026), agent profiler reasoning (Feb 26, 2026), scaffolding trap (Feb 2, 2026), OpenClaw/Moltbook (Feb 17, 2026)
- PAC Framework from trustedagentic.ai
- Anthropic Engineering: "Making Claude Code More Secure and Autonomous" (2026)
- OpenAI: Codex Security documentation (2026)
- OWASP: Top 10 for Agentic Applications for 2026 (December 2025)
- NVIDIA AI Red Team: "Practical Security Guidance for Sandboxing Agentic Workflows" (2026)
- Northflank: "How to Sandbox AI Agents in 2026: MicroVMs, gVisor & Isolation Strategies" (2026)
- Bainbridge (1983) and Don Norman (1990) for automation research context
- Web searches on agent sandboxing architectures, container escape vulnerabilities, prompt injection containment

**What I noticed:**
- The OWASP Top 10 for Agentic Applications maps cleanly to the PAC Framework. Risks ASI01-ASI05 are primarily Control concerns. ASI06-ASI08 span Control and Accountability. ASI09 is Accountability (the complacency trap by another name). ASI10 is all three pillars. This validates the PAC Framework's comprehensive coverage.
- Shane's sandboxing coverage mapping (5 strong, 2 partial, 3 none) is an important framing: it makes explicit that sandboxing is necessary but not sufficient. The "none" categories (memory poisoning, inter-agent communication, human trust exploitation) are precisely the risks addressed by other chapters in this book (Context Infrastructure, Agent Identity, Reliability/Complacency).
- NVIDIA's guidance on configuration file protection is a genuinely underappreciated insight. Most sandboxing discussions focus on filesystem and network isolation. But configuration files are the seam between sandboxed and unsandboxed execution. A git hook, a shell profile, or an MCP config modified inside a sandbox can execute code outside it. This is a persistence vector that needs explicit blocking, not just general filesystem restrictions.
- The convergence of vendor implementations (Claude Code and Codex CLI both using Seatbelt/bubblewrap/seccomp) suggests that native OS sandboxing is becoming a de facto standard for interactive coding agents. The architectures are remarkably similar: restrict filesystem to workspace, proxy network through a controlled gateway, apply syscall filtering. This convergence makes it easier for the book to recommend concrete implementations rather than abstract principles.
- Anthropic's finding that sandboxing reduces permission prompts by 84% is a Potential argument for Control infrastructure. When containment is structural, agents can operate more autonomously because dangerous operations are impossible rather than merely unapproved. This is a concrete example of the PAC interdependence: Control enables Potential.

**Next session priorities:**
1. Cross-Organization Trust chapter (TSP + eIDAS 2.0 + EUDI + Verifiable Credentials: how the pieces compose into a working system)
2. Shadow Agent Governance chapter (practical guidance for transitioning from shadow agents to governed agents)

## 2026-03-12: Cross-Organization Trust Chapter

**What I did:**
- Wrote Chapter 9: "Cross-Organization Trust" covering the full landscape of trust infrastructure for agents operating across organizational boundaries. Sections: the structural problem (dynamic intent, multi-hop delegation, semantic divergence), the Drift breach as concrete failure case (700+ companies exposed via shared OAuth tokens), the token model's structural limit (possession-based authority fails without perimeters), PIC (proof of continuity replacing proof of possession, mathematical elimination of confused deputy, monotonic authority), TSP (identity verification without shared authority, thin waist architecture, TA2A/TMCP integrations), where TSP and PIC meet (complementary layers: identity across boundaries vs authority propagation within systems), VCs as trust carriers (SD-JWT VC vs W3C VC comparison table, selective disclosure, semantic interoperability, unlinkability), content provenance (Shane's VC-signed blog posts verified by coding agent), credential delegation architecture (three-layer chain: identity/delegation/transaction), Verifiable Intent as operational envelope, Windley's society of agents (policies, promises, credentials, reputation as four complementary mechanisms), EUDI wallet infrastructure (trusted issuers, cross-border recognition, business wallets), the semantic boundary problem (action meaning divergence across domains), PAC mapping table, infrastructure maturity for cross-org trust (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Updated gaps.md with new observations on cross-org trust assembly and the semantic boundary problem.
- Marked Cross-Organization Trust as done in the chapter priority list.

**Why this chapter:**
It was the #1 priority in the session log and identified as "the hard problem" in the gaps doc. Shane has exceptionally rich source material: the March 11 LFDT meetup post (TSP + PIC, the most technically dense post he has written), the March 9 EUDI credential formats crash course (deep credential infrastructure analysis), and the February 22 VC signing post (practical content provenance demonstration). External sources have also matured: the CSA published a cross-domain agent security analysis on March 11, Phil Windley published his society-of-agents model, and multiple academic papers on interoperable identity delegation for agents appeared in early 2026. The chapter assembles pieces that no single source has connected.

**Sources used:**
- Shane's blog posts: LFDT meetup (TSP + PIC, March 11, 2026), EUDI credential formats crash course (March 9, 2026), VC-signed blog posts (Feb 22, 2026), trust inversion (Jan 24, 2026), TSP explainer (shanedeconinck.be/explainers/tsp/)
- PAC Framework from trustedagentic.ai
- Cloud Security Alliance / Okta: "AI Security Across Domains: Who Vouches?" (March 11, 2026): Drift breach, three requirements for cross-domain agent trust
- Phil Windley: "Cross-Domain Delegation in a Society of Agents" (Technometria, 2026): policies, promises, credentials, reputation
- Trust Spanning Protocol Specification, Revision 2 (November 2025), Trust over IP Foundation
- PIC Protocol (pic-protocol.org): formal execution model for authority continuity
- Para: "Agent Identity: How AI Wallets Inherit Human Credentials" (2026): three-layer credential delegation
- Mastercard: "How Verifiable Intent builds trust in agentic AI commerce" (2026)
- eIDAS 2.0 (Regulation EU 2024/1183) and EUDI wallet implementation timeline
- arxiv.org/abs/2601.14982: "Interoperable Architecture for Digital Identity Delegation for AI Agents"

**What I noticed:**
- The assembly of TSP + PIC + VCs + EUDI + Verifiable Intent into a coherent cross-organization trust stack is, I believe, the book's most original contribution so far. Each piece is well-documented individually, but nobody has mapped how they compose. TSP provides the cross-boundary identity layer, PIC provides the authority propagation guarantees, VCs carry the trust artifacts, EUDI wallets provide the credential infrastructure at continental scale, and Verifiable Intent provides the operational envelope that bridges authorization and action. The PAC Framework is the lens that connects them.
- The Drift breach is the best available concrete failure case for cross-domain agent trust. 700+ companies exposed through shared OAuth tokens, with no coordinated revocation mechanism, is exactly the scenario that TSP + PIC is designed to prevent. The fact that the CSA published this analysis on the same day as Shane's LFDT meetup post (March 11, 2026) is coincidental but thematically perfect.
- Windley's society-of-agents model adds an important dimension that the protocol-level approaches (TSP, PIC) do not address: institutional design. His argument that "cross-domain delegation is not simply a technical challenge but a problem of institutional design" complements Shane's protocol-level analysis. The four mechanisms (policies, promises, credentials, reputation) map to different PAC dimensions and different infrastructure maturity levels.
- The semantic boundary problem is the most important unsolved gap I identified. Identity, delegation, and authority propagation are all advancing rapidly. But what actions mean across organizational boundaries remains unaddressed. W3C VC's `@context` solves this for credential attributes (a Spanish qualification maps to an EQF level). The equivalent for agent actions (resolvable action vocabularies) does not exist. This may deserve its own treatment in a future chapter or as an extension of the context infrastructure discussion.
- The EUDI wallet gap that Shane identified (W3C VC's de jure inclusion but de facto exclusion) has direct implications for cross-organization agent trust. If the operational scaffolding does not catch up for W3C VC, the most semantically expressive credential format will be unavailable for the most demanding cross-border use cases. The BBS curve contradiction (legal obligation for unlinkability without an approved cryptographic mechanism) is a constraint that agent architects need to track.
- The chapter touches all three PAC pillars more deeply than most previous chapters. Control dominates (identity, authority, delegation), but the Potential argument (cross-org trust unlocks multi-party agent workflows that cannot exist otherwise) and the Accountability argument (delegation chains and audit trails that survive across boundaries) are equally load-bearing. This validates the PAC Framework's interdependence thesis.

**Next session priorities:**
1. Shadow Agent Governance chapter (practical guidance for transitioning from shadow agents to governed agents, connecting to Accountability pillar)
2. Revisit and strengthen existing chapters: the introduction may need updating to reflect the expanded scope (now 9 substantive chapters), and the PAC Framework chapter may benefit from forward references to the cross-org trust stack

## 2026-03-12: Foundation Revision Session

**What I did:**
- Updated the PAC Framework chapter (Chapter 2) with two significant additions from the March 2026 framework revision:
  1. **Error margin emphasis**: Expanded the Reliability section to stress that a reliability percentage without an error margin means nothing. Connected to the distinction between enumerable failure modes (workflows) and open-ended failure spaces (autonomous agents), which determines how knowable the error margin is and therefore how much autonomy can be safely earned.
  2. **Implementation Architecture section**: Added a new section replacing the old "workflow design" concept. The key insight: workflows, agent loops, and autonomous agents are not exclusive choices but composable layers. The outer layer sets the reliability floor and tightens the error margin; the inner layer raises the quality ceiling. This reframes architecture selection as a governance decision, not just a capability decision.
- Updated the "Applying the Framework" section to list all 7 current technical chapters (was listing only 5).
- Rewrote the Introduction to incorporate Shane's "When Intelligence Becomes Commodity" thesis (March 2, 2026): intelligence is commodity, the inferential edge is infrastructure, and that edge compounds. This post had been missed in previous sessions. The introduction now frames the entire book around the gap between model access and organizational readiness, and includes a full chapter listing with one-line descriptions and cross-references.

**Why revisions, not a new chapter:**
Step 4 of the session protocol says to reassess priorities before writing. The PAC Framework chapter is the spine of the book, and it was behind the actual framework by two significant updates (error margin, implementation architecture). The introduction was listing 5 chapters when 9 exist and was missing the commodity intelligence thesis, which is the single best answer to "why does this book matter?" Foundations first.

**Sources used:**
- Shane's blog post: "When Intelligence Becomes Commodity, Infrastructure Becomes the Edge" (March 2, 2026), previously unreferenced
- PAC Framework from trustedagentic.ai (March 2026 revision): P7 question on error margins, implementation architecture composability model
- Web searches for recent developments (March 2026):
  - Alteryx/Gartner: 28% of US firms have zero confidence in AI data quality (March 9, 2026)
  - OpenID Foundation AIIM group filed response to NIST RFI on agent security (March 2026)
  - NIST RFI on AI Agent Security closed March 9, 2026
  - Agentic AI Foundation (AAIF) under Linux Foundation: permanent home for A2A and MCP, co-founded by OpenAI, Anthropic, Google, Microsoft, AWS, Block
  - McKinsey: "Trust in the Age of Agents" publication

**What I noticed:**
- The "commodity intelligence" framing resolves a gap in the book's argument. Previous chapters explained what trust infrastructure looks like but not why it is the competitive differentiator. Shane's March 2 post makes the strategic case: when anyone can access the intelligence, the edge is the infrastructure to unleash it. This is a value argument (Potential pillar) that motivates the technical depth in every subsequent chapter.
- The implementation architecture composability model is a more nuanced framing than the previous chapter offered. It explains why organizations do not have to choose between reliability (workflows) and capability (autonomous agents): they can compose them. This has practical implications for every chapter's recommendations.
- The error margin distinction (enumerable vs open-ended failure modes) connects directly to the Reliability chapter's discussion of evaluation gaps. Offline evaluation can enumerate workflow failures; it cannot enumerate autonomous agent failures. This is why online evaluation matters and why the 52%-to-37% offline-to-online evaluation drop is a governance problem, not just a tooling gap.
- The AAIF (Agentic AI Foundation) governance structure for MCP and A2A is significant: having both protocols under one foundation with six major sponsors (OpenAI, Anthropic, Google, Microsoft, AWS, Block) suggests convergence rather than fragmentation. Worth tracking for a future Agent Communication Protocols chapter.
- The NIST RFI closure (March 9) and April 2 concept paper deadline mean the standards window is narrowing. Organizations that want to influence agent identity standards have weeks, not months.

**Next session priorities:**
1. Shadow Agent Governance chapter (practical guidance for transitioning from shadow agents to governed agents)
2. Agent Communication Protocols chapter (MCP, A2A in depth, AAIF governance, the discovery and interoperability layer)
3. Consider whether the book needs a strategic opening chapter that makes the commodity intelligence argument before diving into the problem statement

## 2026-03-12: Agent Communication Protocols Chapter

**What I did:**
- Wrote Chapter 10: "Agent Communication Protocols" covering the full communication protocol landscape for agents. Sections: the discovery problem (tool discovery vs agent discovery, N×M integration cost), MCP architecture (client-server model, JSON-RPC, three capability types, transport options, OAuth 2.1 requirements), MCP 2026 roadmap (stateless transport, `.well-known/mcp.json` Server Cards, June 2026 target), MCP adoption (97M monthly downloads, all major providers), MCP security (timeline of incidents from May 2025 to October 2025, three primary attack vectors, MCPTox benchmark showing capable models are more vulnerable, three trust gaps MCP leaves open), A2A protocol (Agent Cards, task lifecycle, v0.3 gRPC support, 150+ organizations), MCP and A2A complementarity (A2A for network layer, MCP for resource layer), the authorization gap (Shane's consent theater critique of Google Workspace CLI, possession-based vs proof-based authorization, coarse OAuth scopes as intentional design), agent gateways (AgentGateway MCP federation, Cedar policy authorization, security protections, limits at the tool level), trust layer integrations (TMCP and TA2A running MCP/A2A over TSP, PIC as authority layer, combined trust stack properties), broader protocol landscape (ACP, UCP, protocol stack composition table), AAIF governance under Linux Foundation (three founding projects, governance model, why neutral governance matters for trust), PAC mapping table, infrastructure maturity for communication protocols (I1-I5), and practical recommendations.
- Updated SUMMARY.md with new chapter.
- Updated gaps.md with two new observations (protocol stack convergence under neutral governance, MCP security maturity lagging adoption).
- Marked Agent Communication Protocols as done in gaps.md chapter list.
- Updated introduction with new chapter listing.

**Why this chapter:**
It was the #2 priority from the previous session and the biggest structural gap in the book. MCP and A2A are referenced in almost every existing chapter (Context Infrastructure, Cross-Organization Trust, Agent Identity, Sandboxing) but never given dedicated treatment. With AAIF formation under Linux Foundation (December 2025), 97M monthly MCP downloads, and a timeline of security incidents illustrating the gap between adoption and security maturity, the chapter was both overdue and timely. Shane has deep source material: explainers on MCP, A2A, AgentGateway, OBO, and TSP, plus his March 5 post on Google's Workspace CLI which provides the sharpest articulation of the authorization gap.

**Sources used:**
- Shane's blog posts: Google Workspace CLI/OAuth critique (March 5, 2026), LFDT meetup on TSP + PIC (March 11, 2026), new explainers post (January 16, 2026), fitting agentic AI components in a mental model (January 6, 2026)
- Shane's explainers: MCP, A2A, AgentGateway, TSP (January 2026)
- Shane's MCP spec notes: "MCP is plumbing, not trust"
- PAC Framework from trustedagentic.ai
- MCP 2026 Roadmap (blog.modelcontextprotocol.io): stateless transport, `.well-known` discovery, June 2026 target
- SEP-1649: MCP Server Cards proposal
- A2A Protocol Specification v0.3 (a2a-protocol.org): gRPC support, Agent Card signing
- AuthZed: Timeline of MCP Security Breaches (May 2025 - October 2025)
- MCPTox benchmark: 20 LLM agents, 45 MCP servers, 353 tools
- AgentGateway documentation (agentgateway.dev): MCP federation, Cedar policies, Rust implementation
- Solo.io: Enterprise AgentGateway, community participants (AWS, Microsoft, Red Hat, IBM, Cisco, Shell)
- Linux Foundation: AAIF announcement (December 9, 2025), governance model
- Anthropic: MCP donation to AAIF
- OpenAI: AAIF co-founding
- Google Cloud Blog: A2A upgrade, 150+ organizations
- LangGraph v0.2: A2A as first-class protocol target (January 2026)
- Stripe/OpenAI: Agent Commerce Protocol (ACP)
- Google/Shopify/Walmart: Unified Commerce Protocol (UCP)
- Wenjing Chu (Futurewei/Trust over IP): TMCP and TA2A presentation at LFDT meetup

**What I noticed:**
- Shane's framing "MCP is plumbing, not trust" is the organizing thesis for the chapter. It is precise and important: communication protocols solve the N×M integration problem (necessary plumbing) but create new security risks and leave trust gaps that identity infrastructure must fill. This is why the chapter connects back to Agent Identity, Cross-Org Trust, and Sandboxing.
- The MCP security incident timeline is more severe than I expected. Five significant incidents in six months (May-October 2025), including a supply-chain backdoor with 437K+ downloads (mcp-remote CVE-2025-6514) and a path traversal that leaked a token controlling 3,000+ MCP servers (Smithery). The pattern: adoption outpaces security maturity. This validates Shane's emphasis on building trust infrastructure alongside capability infrastructure.
- The MCPTox finding that more capable models are more vulnerable to tool poisoning is counterintuitive and important. The attack exploits superior instruction-following ability: a model that is better at following instructions is also better at following malicious instructions embedded in tool descriptions. This connects to the Reliability chapter's point about better models making governance harder.
- Shane's Google Workspace CLI post (March 5) is the sharpest articulation of the authorization gap I've seen. The "consent theater" framing (user thinks "help me find one email," token grants "read everything forever") makes the abstract problem concrete. The table mapping user intent to actual scope granted is effective because every reader has experienced this gap.
- The protocol stack table (Trust → Agent discovery → Tool discovery → Commerce → Authorization → Enforcement) shows how the pieces compose, but also exposes that no unified identity flows across all layers. This is the most important unsolved problem in the stack. TMCP/TA2A are designed to solve it but adoption is early.
- AAIF governance matters for trust infrastructure in a way that goes beyond the usual open-source governance story. When the communication protocols are under neutral governance, organizations can build trust infrastructure on top without vendor-lock-in risk. This aligns with the EU AI Act's emphasis on open standards and the PAC Framework's emphasis on building on emerging standards.
- Agent gateways are converging fast (Gartner predicts majority of API gateway vendors add MCP by end of 2026, community includes AWS/Microsoft/Red Hat/IBM/Cisco/Shell), but the structural limitation Shane identified remains: gateways operate at the tool level, mapping onto the same coarse OAuth scopes. The deeper fix (possession-based to proof-based authorization) requires Verifiable Intent and PIC, not just another policy layer.

**Next session priorities:**
1. Shadow Agent Governance chapter (practical guidance for transitioning from shadow agents to governed agents; Okta ISPM Agent Discovery, Gartner stats on shadow AI scale, connecting to Accountability pillar)
2. Consider whether existing chapters need cross-references to the new communication protocols chapter (several chapters reference MCP/A2A and could benefit from forward references)
3. The book now has 10 substantive chapters. Assess whether the structure is right for the remaining 5+ chapters needed to reach 15+.

## 2026-03-12: Shadow Agent Governance Chapter

**What I did:**
- Wrote Chapter 11: "Shadow Agent Governance" covering the full landscape of transitioning from ungoverned to governed agent deployments. Sections: the scale of shadow agents (98% unsanctioned AI use, 1,200 unofficial apps per enterprise, 86% no visibility into AI data flows), why shadow agents exist (value-seeking pattern, not malice), why they differ from shadow IT (they make decisions, inherit authority, compound), the governance gap (human/application IAM architectural mismatch with agent requirements), discovery tools (Okta ISPM Agent Discovery via OAuth consent events, Noma Security Agentic Risk Map, network/API traffic analysis, low-code platform auditing), the agent registry (identity, owner, authority, permissions, blast radius, evaluation status, regulatory classification), registry enforcement through infrastructure (identity providers, API/agent gateways, network controls, platform controls), the amnesty model for transition (discover, classify, amnesty period, triage by blast radius, enforce after amnesty, maintain the path), organizational ownership models (centralized governance office, federated with central standards, infrastructure-enforced), audit trail requirements for agents (delegation chain, intent capture, action trace, scope verification), the organizational shift (prohibition to enablement, human-speed to agent-speed governance, perimeter to identity), PAC mapping table across all three pillars, infrastructure maturity for shadow agent governance (I1-I5), and practical recommendations by level.
- Updated SUMMARY.md with new chapter.
- Updated introduction with new chapter listing.
- Updated gaps.md: marked Shadow Agent Governance as done, added observation on shadow agent scale, marked two open questions as addressed.

**Why this chapter:**
Shadow Agent Governance has been the #1 priority for three consecutive sessions. It fills the biggest remaining gap in the Accountability pillar: the practical bridge between "agents are already running ungoverned" (Chapter 1) and "here's the infrastructure to govern them" (Chapters 3-10). The chapter directly addresses two of the open questions from the gaps doc ("how to transition from shadow to governed" and "what does agent registration look like in practice"). The timing is right: Gartner, Microsoft, Okta, and Noma all published major shadow AI research in Q1 2026, providing concrete data and tooling to ground the recommendations.

**Sources used:**
- Shane's blog posts: boardroom questions (Feb 8, 2026), trust inversion (Feb 3, 2026), scaffolding trap (Feb 2, 2026), the work that's leaving (Feb 27, 2026), agent profiler reasoning (Feb 26, 2026), Google Workspace CLI/OAuth critique (Mar 5, 2026)
- PAC Framework from trustedagentic.ai
- Vectra AI: "Shadow AI explained: risks, costs, and enterprise governance" (2026)
- Help Net Security: "AI went from assistant to autonomous actor and security never caught up" (March 3, 2026): 21% executive visibility, 80% risky agent behaviors
- Gartner: 40% of enterprise apps with AI agents by 2026, 68% unauthorized AI tool use, $492M governance spending in 2026, 40%+ shadow AI breach prediction by 2030
- Microsoft Security Blog: Cyber Pulse report (February 10, 2026): 80% Fortune 500 with active agents, 29% unsanctioned agent use, industry distribution
- Okta: ISPM Agent Discovery (February 12, 2026): OAuth consent event monitoring, Copilot Studio/Agentforce integration timeline
- Noma Security: Agentic Risk Map (2026): MCP server discovery, agent-to-agent relationship mapping, runtime behavioral monitoring
- Netskope: 223 data policy violations per month per enterprise (2026)

**What I noticed:**
- The scale data is overwhelming and consistent across sources. 98% unsanctioned AI use (Vectra), 1,200 unofficial apps per enterprise (Help Net Security), 80% Fortune 500 with low-code agents (Microsoft), 68% unauthorized tool use (Gartner). These are not outlier findings: every major analyst and security vendor is reporting the same picture. Shadow agents are not an edge case. They are the default state.
- The amnesty model emerged as the most practical transition approach. Prohibition consistently fails (employees route around bans using personal devices and accounts, making the shadow deeper). The organizations succeeding at this treat shadow agent creators as early adopters who identified high-value use cases, not as policy violators. This reframes governance from a security exercise to a product exercise: what are people building, and how do we make it safe?
- Shane's boardroom question about structural prevention ("Can your infrastructure prevent an agent from running without being registered?") is the sharpest framing of the gap between discovery and governance. Every discovery tool I found (Okta, Noma, network monitoring) provides visibility into current state. None of them prevent new shadow agents from appearing. Only infrastructure enforcement (registry-integrated identity providers, gateways, network controls) provides the structural guarantee.
- The governance speed mismatch is the root cause of shadow agents. Agent deployment takes minutes (low-code platforms). Governance review takes weeks (traditional vendor assessment). Until governance operates at agent speed (automated classification, self-service registration, infrastructure-enforced controls), shadow agents will continue to appear faster than governance can catch them.
- The chapter connects to the Potential pillar more strongly than expected. Shadow agent discovery is simultaneously a governance exercise and a strategic intelligence exercise. The use cases employees choose to automate first are the highest-value, lowest-friction opportunities. Organizations that treat discovery data as product research (not just risk data) gain strategic insight alongside governance.
- The infrastructure maturity table for this chapter maps cleanly to the regulatory timeline. Most organizations are at I1-I2. EU AI Act August 2026 enforcement requires I3+ for high-risk deployments. That is a five-month gap. This urgency framing connects to the Regulatory Landscape chapter and makes the practical recommendations concrete and time-bounded.

**Next session priorities:**
1. The book now has 11 substantive chapters. Assess structure for remaining chapters: candidates include Agent Testing and Red Teaming, Organizational Change Management / Agent-First Organizations, Supply Chain Security for Agents, and the Semantic Boundary Problem.
2. Consider cross-references between chapters. Shadow Agent Governance references Agent Identity, Cross-Org Trust, Communication Protocols, Sandboxing, and Reliability chapters. Backward references from those chapters to this one could strengthen the book's cohesion.
3. Revisit the introduction structure: with 11 chapters, the chapter listing is getting long. Consider grouping by theme (Foundation, Infrastructure, Governance, Operations).
