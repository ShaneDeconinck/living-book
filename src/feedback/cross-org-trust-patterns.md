# Feedback Patterns: cross-org-trust.md

Observed in src/drafts/cross-org-trust.md. Written for Ghosty by Chop Pop, 2026-03-13.

---

## Pattern 1 — POSITIVE: The category error opener

**From the chapter:**
> "Cross-organization trust for agents is not a new version of API federation. It is a fundamentally different problem because agents create intent rather than forwarding it."

**The pattern:**
Open a chapter by naming what the problem is NOT, then naming what it IS, then naming the single fact that makes it different. Three moves: displace the wrong frame, replace it, prove the replacement in one clause. This is among the best chapter openers in the book.

**Why it works:**
The reader arrives with a frame: cross-org trust is a federation problem, like OAuth scope sharing or mutual TLS. Two sentences dissolve that frame and install the correct one. "Create intent rather than forwarding it" is the pivot — it names the thing agents do that software before them did not. The chapter earns its length because the first sentence tells you why the old solutions do not apply.

**Use this structure when** the reader's default mental model will lead them to the wrong solution. Name the bad model first (briefly), then name the right one, then state the distinguishing fact in a single clause.

---

## Pattern 2 — POSITIVE: Incident to structural requirements to framework mapping

**From the chapter:**
> The Drift breach section extracts three named requirements from a single incident:
> - Verifiable delegation
> - Operational envelopes
> - Coordinated revocation
>
> Then maps each requirement to a PAC pillar.

**The pattern:**
Use an incident to prove a structural point. The sequence: describe the breach (briefly) → identify the structural failure that enabled it → name the requirements that would have prevented it → map requirements to the framework. The incident becomes evidence, not atmosphere.

**Why it works:**
The Drift section does not describe the breach to make readers afraid. It describes it to prove that each of the three requirements is real and non-optional. Every chapter that uses an incident should ask: what structural requirement does this prove? If the answer is "none — it just illustrates the threat," the incident is atmosphere. Cut it or find the structural claim it supports.

**Compare to what breaks this pattern:**
Incidents cited as vibes ("as the CodeWall breach showed, agents can expose sensitive data") without extracting requirements, without mapping to framework pillars, without earning the space they take. The incident should do work. Drift does work.

---

## Pattern 3 — POSITIVE: Name an infrastructure level by its chapter exemplar

**From the chapter:**
> "**I1 (Open).** Agents cross boundaries using static API keys or shared service accounts. No delegation tracking. No identity verification. The Drift scenario."

**The pattern:**
Close the description of an infrastructure maturity level with a reference to an incident or example already established in the chapter. Do not introduce new material — call back to what the reader has already seen.

**Why it works:**
"The Drift scenario" is three words that replace a paragraph. The reader has already spent time with the Drift breach. They do not need the failure mode re-described at I1. The callback gives them the concrete referent instantly. It also creates structural coherence: the chapter's opening incident becomes the floor of the maturity scale. The reader can place themselves on the scale because the scale is calibrated to a real case they understand.

**Use this when** the infrastructure scale (I1-I5 or B1-B5 or A1-A5) risks becoming abstract. Ground each level in either a named deployment, a named organization, or a named incident from the chapter. If no such referent exists, consider whether the level description is specific enough.

---

## Pattern 4 — NEGATIVE: Product blog citation for a structural generalization

**From the chapter:**
> "A pattern appearing across multiple implementations separates agent credential delegation into three layers..."
> [^8]: Para, "Agent Identity: How AI Wallets Inherit Human Credentials," 2026.

**The pattern:**
A structural claim ("a pattern appearing across multiple implementations") is cited to a single product blog post from a company named "Para." The footnote gives no publisher domain, no date precision, no indication of whether Para is a vendor with a stake in the pattern's adoption.

**The problem:**
"A pattern appearing across multiple implementations" is a strong claim. It implies cross-industry convergence. One vendor blog does not establish convergence. If the pattern is genuinely cross-industry, cite at least two independent implementations. If it comes primarily from Para's product design, say that: "Para's architecture separates agent credential delegation into three layers..." The reader can evaluate a named vendor's proposal. They cannot evaluate an anonymous "multiple implementations."

**This is the fourth recurrence of this citation pattern** in the book:
- [^shadow-ai] pac-framework: Programs.com aggregate for shadow AI statistics
- [^6] context-infrastructure: TDS/Medium aggregate for deployment patterns
- [^cosais] regulatory-landscape: Zenity vendor blog for NIST COSAiS
- [^8] cross-org-trust: Para product blog for a structural three-layer pattern

**Fix:** Either name the multiple implementations separately, or attribute the pattern explicitly to Para and treat it as one vendor's proposed architecture (not industry convergence).

---

## Pattern 5 — NEGATIVE: Definition-mode landing in a demonstration chapter

**From the chapter:**
> "The protocols above establish how to communicate trust across boundaries. Verifiable Credentials (VCs) are the format for carrying it.
>
> A VC is a cryptographic statement by an issuer about a subject: 'this agent is authorized to act on behalf of Alice, with these constraints, until this date.' The holder (the agent or its wallet) can present the VC to any verifier, who can check the signature without contacting the issuer. No phone-home. No shared infrastructure."

**The pattern:**
The chapter has been in demonstration mode for 140 lines — showing TSP and PIC in action, walking through protocol flows, naming failure modes. Then it pivots to "here is what a VC is." Definition-mode in the middle of a demonstration chapter signals either that the concept was used before it was explained, or that the explanation belongs in an earlier chapter.

**The problem:**
By the time the reader reaches this section, they have already encountered VCs in the TSP section ("verifiable credentials," line 92), the MCP-I section ("delegation credential," line 111), and the CAAM section ("attestation evidence," line 133). If VCs were not explained before those appearances, the reader has already lost the thread. If the reader understood them earlier, they do not need the definition here.

**What to do instead:**
Start the Verifiable Credentials section from its specific cross-org trust angle, not from first principles. The format comparison table (SD-JWT VC vs. W3C VC) is new and useful — that is the section's real contribution. Lead with it: "For cross-org trust, credential format determines what can travel across boundaries." Then the table. Then the analysis. Skip the orientation paragraph. Readers who need the VC definition can find it in an earlier chapter (agent-identity.md covers this ground).

---

## Summary

| # | Type | Pattern |
|---|---|---|
| 1 | Positive | Category error opener: name wrong frame, replace, state distinguishing fact |
| 2 | Positive | Incident → structural requirements → PAC mapping |
| 3 | Positive | Name infrastructure levels by their chapter exemplars |
| 4 | Negative | Product blog for cross-industry structural claim |
| 5 | Negative | Definition-mode landing in a demonstration chapter |

The chapter is structurally strong. The opening, the Drift section, and the infrastructure scale are the best-executed parts. The two recurring issues (vendor citations, mid-chapter definition pivots) are now present in enough chapters to be described as habits rather than one-off errors.
