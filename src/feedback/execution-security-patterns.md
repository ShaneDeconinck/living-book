# Feedback Patterns: execution-security.md

Read as part of Chop Pop Session 129 pre-read. Five patterns.

---

## Pattern 1 (Positive): The book's argument, measured

**"The 48-to-93 gap is the core argument of this book, measured."**

The PCAS section (Layer 7: Semantic Policy Enforcement) does something no other chapter does: it turns the book's central claim into a number. "Without enforcement, frontier models comply with stated policies only 48% of the time... With PCAS active, compliance rises to 93%." Then: "Policy alone ('don't share customer data') fails more than half the time. Infrastructure enforcement ('the reference monitor blocks any action that would share customer data') approaches perfect compliance."

That is the whole book in two sentences. Every chapter has been building to this contrast. Here it is quantified, source-cited, and named "the core argument of this book."

This is how to deploy a key result: state the numbers, extract the principle, then name what they prove. Do not hedge. Do not say "suggests" or "indicates." If the evidence supports a claim, make the claim.

Note: the PCAS figures need clean verification (see Sapere Aude flags below). If the numbers check out, this section is the chapter's best moment.

---

## Pattern 2 (Positive): Structural shielding described precisely

**"The architectural detail matters: the Critic sees only action metadata, not raw web content."**

The Google Project Mariner section explains the User Alignment Critic: a separate model that reviews every proposed action. But the sentence that makes it worth explaining is this one: "the Critic cannot be poisoned through the same channel the agent operates in."

That sentence does two things at once. It tells you what the architectural separation achieves (isolation from the threat surface). And it tells you why the detail matters, not just what the detail is.

Compare to descriptions of sandboxing earlier in the chapter: "The agent can read and write within its working directory. Everything else is restricted." Same logic — explain the constraint, then explain what the constraint prevents. This is the correct sequence. Lead with the structural fact, follow with the security consequence.

When you describe an architecture, find the sentence that explains why the structure matters. That sentence is the paragraph's center.

---

## Pattern 3 (Negative): gVisor stranded in the table

**Location:** Isolation Spectrum table, line ~101

The comparison table lists four isolation levels: Native OS, Containers, gVisor, MicroVMs. Three of them appear in the preceding prose. gVisor does not. A reader hitting "User-space kernel, syscall interception" in the table has no prior context for what gVisor is, who makes it, or why it sits between containers and MicroVMs.

Tables do not substitute for explanation. They summarize what the prose has already established. When a row in a table cannot be traced to a paragraph in the preceding section, either add the paragraph or remove the row.

**How to apply:** Before finalizing any comparison table, check that every row has a corresponding prose explanation. gVisor needs two sentences — what it is, what problem it solves — before the table can use it as a comparison point.

---

## Pattern 4 (Negative): Model version names as verifiable claims

**Location:** PCAS paragraph, line ~195

"Without enforcement, frontier models (Claude Opus 4.5, GPT-5.2, Gemini 3 Pro) comply with stated policies only 48% of the time."

The 48% and 93% figures are from a citable research paper. The model names are specific version identifiers that will be verified against the actual PCAS paper. GPT-5.2 in particular is an unusual version pattern. If the paper uses different model names or versions, this sentence becomes a factual error embedded in the book's strongest paragraph.

When citing a paper's experimental results, use the model names exactly as the paper names them. Do not paraphrase version identifiers. "Claude Opus 4.5" is a specific claim, not a general reference.

**Note for Sapere Aude:** Please verify the exact model names from the PCAS paper against what appears in the draft. Also confirm: (a) paper title is "Policy Compiler for Secure Agentic Systems," (b) February 2026 date, (c) both the 48% and 93% compliance figures, (d) the "customer service tasks" framing.

---

## Pattern 5 (Negative): Two sources merged into one paragraph without a seam

**Location:** Layer 1: Input Validation, lines ~153-155

The paragraph cites two separate OpenAI publications: "Designing AI agents to resist prompt injection" (March 2026) and "Continuously hardening ChatGPT Atlas against prompt injection attacks" (December 2025). The March publication is about design principles. The December publication is about red-teaming methodology. Both are relevant. They are not the same argument.

The paragraph moves from the March guidance (Instruction Hierarchy, structured outputs, system-level containment) directly into the December red-team work (RL-trained automated attacker, multi-step vulnerable workflows) with no signal that these are different publications describing different work. The reader cannot tell where one source ends and the other begins.

Both sources are worth including. The fix is a seam: one sentence or a paragraph break that tells the reader "separately, OpenAI's December 2025 work on..." — which, notably, Ghosty wrote correctly in the footnote ([^openai-pi] separates the two) but not in the body text.

**How to apply:** When two sources from the same organization do different work, use their dates or publication names to separate them in prose. The reader should not have to go to the footnotes to understand that two separate documents are being summarized.

---

## Session 142 Update

**Pattern 3 is resolved.** Ghosty added a full "### gVisor: User-Space Kernel Interception" section between the Docker and "Choosing the Right Level" sections. gVisor now has prose before the table. Good.

**New pattern observed in this edit: Self-narrating chapter openers.**

The draft opened: "Every previous chapter in this book has dealt with a question of trust... This chapter deals with the question that comes after all of those: what happens when the agent actually runs?"

Cut. The second paragraph ("Execution security is the Control pillar made physical.") is the right opener. This is the same pattern as the introduction.md opener and the pac-framework.md opener. The chapter should open on content, not on a description of itself.

**New pattern observed: Block quotes that restate what was already said.**

The draft had a Shane block quote ("The answer isn't better prompts. It's containment...") three paragraphs after a plain prose sentence saying the same thing. Direct attribution belongs in footnotes. A block quote earns its place by saying something the surrounding prose cannot.

**New pattern observed: Closing summary quotes.**

"Anthropic's engineering team puts it simply: 'Effective sandboxing requires both filesystem and network isolation.'" — placed after a paragraph that just explained this in detail. The quote restated a point already made. Cut. If a quote only repeats what the preceding prose established, it is a drag, not a kicker.

**New pattern observed: Stage-direction sentence before content.**

"Shane has been direct about why this fails: permission prompts are the default safety mechanism... Three failure modes make them unreliable:" — the intro sentence before the list. The list should follow the setup paragraph directly. "Three failure modes make them unreliable:[^footnote]" as the transition is sufficient. No announcement needed.
