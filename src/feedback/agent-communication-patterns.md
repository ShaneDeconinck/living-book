# Feedback Patterns: agent-communication.md

Pre-read as part of Chop Pop Session 132. Five patterns.

---

## Pattern 1 (Positive): The consent theater table

**From the chapter:**
> | You ask the agent to... | What you intended | What you granted |
> |---|---|---|
> | "Check my support inbox from last 3 days" | Emails from support customers, last 3 days | Every email, every sender, since account creation |
> | "Reply to that customer thread" | One reply, to one thread | Send as you, to anyone, about anything |
> | "Find the Q4 report in Drive" | One specific file | Read every file in your Drive |

**The pattern:**
Three columns: the natural-language request (what the user said), the user's actual intent (what they meant), the token scope (what the system actually granted). The third column is always worse than the second. The gap between columns two and three is the entire argument.

**Why it works:**
The reader does not need explanation. The table is the argument. "Reply to that customer thread" → "Send as you, to anyone, about anything" — that progression lands harder than any paragraph explaining OAuth scope granularity. The three-column asymmetry works because it is precise: not "scopes are too broad" (abstract) but "you said reply to one thread, the token grants sending to anyone" (concrete).

**Use this structure when** explaining any gap between user intent and system behavior. The columns are: what you asked for / what you actually intended / what the system actually permits. The reader fills in the risk themselves. Do not add a column explaining the risk.

---

## Pattern 2 (Positive): Capability explanation sequence

**From the chapter:**
> A fourth capability, **sampling**, inverts the direction: it allows the server to request LLM completions from the client. Instead of the client calling the server's tools, the server calls back to the client's model. This is designed for legitimate use cases (a server that needs the LLM to interpret unstructured data before processing it), but it opens an attack surface that the other three capabilities do not: the server can influence the agent's reasoning directly, not just its inputs.

**The pattern:**
Name the capability → state what it does (mechanically) → name the legitimate use case → name why it creates attack surface that the legitimate framing does not remove. All in one paragraph, in that order.

**Why it works:**
The reader cannot dismiss the attack surface by thinking "that's just for legitimate use." The legitimate use is already acknowledged. The attack surface is in the mechanism, not the intent. The paragraph structure forces the reader through the full logic: here is what it does, here is why it exists, here is why the existence is the problem. No hedging, no "could be misused" — just: this is what the capability enables, by design.

**Use this sequence when** describing any protocol capability that has dual-use risk. Do not start with the security concern (the reader will defend against it). Start with the capability, validate the legitimate use, then name the attack surface. The sequence makes the risk unavoidable.

---

## Pattern 3 (Negative): Footnote forward-reference

**From the chapter:**
> [^14]: Auth0 A2A authentication partnership, referenced in Context Infrastructure chapter.
> [^15]: Mastercard and Google, "Verifiable Intent," March 2026. Covered in Agent Identity chapter.
> [^19]: Gartner prediction on API gateway vendors adding MCP capabilities, referenced in Context Infrastructure chapter.

**The pattern:**
A footnote that does not cite a source — it points to another chapter. "Referenced in Context Infrastructure chapter" is not a citation. It tells the reader to go find a different chapter to find the source. It is a redirect, not a reference.

**The problem:**
Footnotes are supposed to close the citation loop for the reader at the point of reading. "Referenced in [X] chapter" means: I have not cited this, but the citation exists somewhere else. This is worse than no footnote — it implies the claim is sourced while providing nothing a reader can verify. And if the reader follows the pointer to the other chapter, they may find the citation is sourced to a blog post (as with the cross-org-trust Para citation).

There are four instances in this draft: [^14], [^15], [^19], [^20].

**Fix for Ghosty:** Every footnote must stand alone. If the source is a real publication, cite it: publisher, title, URL, date. If the source is coverage in another chapter, that is not a footnote — remove the footnote entirely and add a cross-reference inline: "covered in [Agent Identity and Delegation](agent-identity.md)." If there is no source, flag the claim for verification or remove it.

**How to apply:** Before finalizing any chapter, scan all footnotes for entries that contain "referenced in," "covered in," or "see [X] chapter." Each one is either a missing citation or a misfiled cross-reference. Resolve before sending to Sapere Aude.

---

## Pattern 4 (Negative): Informal web source for significant statistics

**From the chapter:**
> Between January and February 2026 alone, 30 MCP-related CVEs were filed across three distinct attack layers... The breakdown by vulnerability class: 43% exec()/shell injection, 20% tooling and infrastructure, 13% authentication bypass... Scanning of over 500 MCP servers found that 38% completely lack authentication.[^30]
>
> [^30]: "30 CVEs Later: How MCP's Attack Surface Expanded Into Three Distinct Layers," dev.to, March 2026. Analysis of 30 MCP-related CVEs filed January-February 2026...

**The problem:**
The 38% unauthenticated servers figure and the 30-CVE breakdown are the most-cited security statistics in this chapter. They are sourced to an anonymous dev.to post. dev.to is a developer community blog where anyone can publish — there is no editorial process, no institutional affiliation, no peer review. The statistics may be accurate. But an anonymous community post cannot establish them as established facts.

The same issue appears with [^7]: MCP monthly download statistics ("97 million monthly SDK downloads") with no URL, no publisher, and no primary source attribution.

**This is a more specific version of the existing vendor-blog pattern** (see cross-org-trust Pattern 4), but worse: vendor blogs at least identify a named organization with a stake in accuracy. Anonymous community posts provide no accountability at all.

**Fix for Ghosty:** Find the primary source for these figures. For the CVE data: NVD (National Vulnerability Database) has public CVE records — if 30 MCP CVEs were filed in two months, they can be verified there. For the 38% authentication scan: find the researcher or organization that ran the scan. For download statistics: npm and PyPI publish download counts; the MCP blog or Anthropic's announcements likely reference the official figure.

**Note for Sapere Aude:** Please verify [^30] (dev.to anonymous post, 38% and 30-CVE figures) and [^7] (MCP download statistics, no URL). These are significant claims with weak sourcing.

---

## Pattern 5 (Negative): Self-narrating closer — fifth occurrence

**From the chapter:**
> This matters for the book's argument. DPoP is already covered in the Agent Identity and Delegation chapter as critical infrastructure for preventing token theft... The fact that MCP is now adopting both confirms the trajectory: the identity layer and the communication layer are converging.[^line 103]
>
> These protocols matter for the book's thesis because they formalize the boundary between agent reasoning and user oversight.[^line 405]

**The pattern:**
Two instances in the same chapter. One paragraph opens with "This matters for the book's argument." Another opens with "These protocols matter for the book's thesis because." Both are the same move: announcing that what follows is significant before stating what is significant.

**This is the fifth documented occurrence** across the book:
- agent-identity.md: "What makes this significant is that it moves agent authentication..."
- execution-security.md: "The 48-to-93 gap is the core argument of this book, measured."
- regulatory-landscape.md: compliance section closers
- multi-agent-trust.md: "This matters for the book's argument because it demonstrates..."
- agent-communication.md: two instances

**Fix for Ghosty:** The first sentence of each paragraph is noise. Cut it and read what follows. "DPoP is already covered in the Agent Identity chapter as critical infrastructure for preventing token theft. Workload Identity Federation connects to the WIMSE work... The fact that MCP is now adopting both confirms the trajectory: the identity layer and the communication layer are converging." That is the paragraph. The announcement added nothing.

**How to apply:** Search the full draft for "matters for the book" and "matters for the thesis." Every instance is a sentence to cut. The paragraph that follows will be stronger without it.

---

## Summary

| # | Type | Pattern |
|---|---|---|
| 1 | Positive | Consent theater table: asked for / intended / actually granted |
| 2 | Positive | Capability explanation sequence: name → legitimate use → attack surface |
| 3 | Negative | Footnote forward-reference: "referenced in [X] chapter" is not a citation |
| 4 | Negative | Anonymous community post for significant statistics |
| 5 | Negative | Self-narrating closer (fifth occurrence) |

The chapter is technically the most comprehensive in the book — MCP, A2A, gateways, trust layer integrations, and the full protocol stack mapped to PAC. The consent theater table and the sampling attack explanation are the best individual pieces of writing in any chapter to date. The recurring problems (self-narrating closers, weak citations) are fixable before verification. Pattern 3 (footnote forward-references) requires new discipline in footnote handling, not just this chapter.
