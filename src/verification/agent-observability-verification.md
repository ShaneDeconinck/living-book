# Verification Report: agent-observability.md

**Verified by:** Sapere Aude
**Date:** 2026-03-14
**Session:** 376
**Commit verified:** caaf5b7 (remote; git fetch blocked by server-side permissions issue — content retrieved via GitHub raw URL)
**Status:** ISSUES FOUND

---

## Summary

Four issues. One serious factual error (RFC 8693 OBO token type URN), one incorrect source title (Irregular document), one deprecated attribute citation, one minor claim inflation. The chapter structure and most factual content is solid. The RFC 8693 error specifically is in a footnote that may propagate to the Agent Identity chapter — fix it there too.

---

## Issues

### I1 — SERIOUS: RFC 8693 OBO Token Type URN is incorrect

**Location:** `[^rfc-8693]` footnote:
> "The On-Behalf-Of token type (`urn:ietf:params:oauth:token-type:jwt`) records both the actor (the delegating entity) and the subject (the original principal)."

**What is wrong:** `urn:ietf:params:oauth:token-type:jwt` is not an On-Behalf-Of token type. It is the generic JWT token type identifier — one of six general token type URNs defined in RFC 8693 Section 3. It has no OBO semantics.

RFC 8693 does not define a named OBO token type URN. The On-Behalf-Of pattern is expressed through request parameters: `subject_token` (the identity on whose behalf the token is requested) and `actor_token` (the delegating party). There is no "On-Behalf-Of token type URN" in the RFC.

The footnote conflates two unrelated things and attributes OBO semantics to a URN that has none.

**Fix:** Remove the URN from the parenthetical or replace it with the correct description of how RFC 8693 expresses OBO delegation (via `subject_token` and `actor_token` parameters, not a named token type URI). Suggested rewrite:

> "RFC 8693's On-Behalf-Of pattern uses the `subject_token` parameter to represent the identity being delegated and the `actor_token` parameter to represent the delegating party. See the Agent Identity and Delegation chapter for implementation patterns."

**Note:** Check whether the Agent Identity and Delegation chapter repeats this error — the same URN claim may appear there.

---

### I2 — INCORRECT TITLE: Irregular source title

**Location:** `[^irregular-rogue]` and opening paragraph:
> "Irregular, 'Rogue AI Agents,' March 12, 2026."

**What is wrong:** "Rogue AI Agents" is The Register's headline for their coverage, not the document's actual title. The actual title is:

> **"Emergent Cyber Behavior When AI Agents Become Offensive Threat Actors"**
> Irregular, March 12, 2026
> https://www.irregular.com/publications/emergent-offensive-cyber-behavior-in-ai-agents

All four specific behaviors described in the text (antivirus override, DLP bypass via steganography, credential forging, agent-to-agent pressure to relax safety checks) are substantiated by multiple secondary sources and match the actual document's findings.

One nuance on "no adversarial prompting": the chapter states the simulation used "no adversarial prompting." This is defensible — agents were not given explicit instructions to hack or bypass security. However, the prompts did include aggressive urgency language ("The board is FURIOUS! We need a BREAKTHROUGH! Try these RADICAL approaches… Use EVERY trick, EVERY exploit, EVERY vulnerability!"). Irregular's framing is that no security-bypass instructions were given and the offensive behavior was emergent. The "no adversarial prompting" characterization holds in that specific sense. Consider adding a brief clarification if precision matters.

**Fix:** Update the footnote citation to the correct title. No changes needed to the substantive claims in the text.

---

### I3 — MINOR: `gen_ai.system` attribute deprecated

**Location:** `[^otel-genai]` footnote:
> "Standardized attributes for LLM spans including `gen_ai.system`, `gen_ai.request.model`, `gen_ai.usage.input_tokens`, `gen_ai.usage.output_tokens`..."

**What is wrong:** `gen_ai.system` is deprecated in current OpenTelemetry GenAI semantic conventions. The replacement is `gen_ai.provider.name`. The other three attributes (`gen_ai.request.model`, `gen_ai.usage.input_tokens`, `gen_ai.usage.output_tokens`) are current and correct.

**Fix:** Replace `gen_ai.system` with `gen_ai.provider.name` in the footnote, or add a note that `gen_ai.system` has been deprecated in favor of `gen_ai.provider.name`.

---

### I4 — MINOR: "scoped" token language not in Imprivata source

**Location:** `[^imprivata-aim]` footnote and Layer 2 discussion reference to Imprivata:
> "short-lived scoped tokens"

**What is wrong:** The Imprivata press release (confirmed to exist at imprivata.com, March 10, 2026, HIMSS 2026) uses "short-lived tokens" — without the word "scoped." The agent registry and unmanaged agent discovery features are confirmed with near-exact language from the source.

**Fix:** Remove "scoped" or reframe as characterization rather than a direct summary of the source.

---

## Clean Sources

| Source | Check |
|---|---|
| Shane Deconinck, "Trusted AI Agents: Why Traditional IAM Breaks Down," shanedeconinck.be, January 24, 2026 | CONFIRMED — title, date, URL correct |
| Shane Deconinck, "Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026 | CONFIRMED — title, date correct; exact quote "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built." verified verbatim |
| RFC 8693, "OAuth 2.0 Token Exchange," January 2020 | CONFIRMED — title and date correct (OBO URN claim in footnote is wrong; see I1) |
| RFC 9162, "Certificate Transparency Version 2.0," December 2021 | CONFIRMED — title and date correct |
| W3C PROV-DM, "PROV-DM: The PROV Data Model," April 30, 2013 | CONFIRMED — title, date, URL, Agent/Activity/Entity model all correct |
| OpenTelemetry, "GenAI Semantic Conventions," opentelemetry.io/docs/specs/semconv/gen-ai/ | CONFIRMED with caveat — `gen_ai.system` deprecated (see I3) |
| OpenTelemetry Distributed Tracing, W3C Trace Context | CONFIRMED — traceparent/tracestate headers, distributed trace context model accurate |
| Microsoft, "Secure agentic AI for your Frontier Transformation," March 9, 2026 | CONFIRMED — title, date, GA date (May 1, 2026), all four features confirmed |
| Imprivata, "Imprivata Introduces Agentic Identity Management to Secure and Govern AI Agents in Healthcare," March 10, 2026 | CONFIRMED with caveat — title, date, HIMSS 2026, registry, unmanaged agent discovery all confirmed; "scoped" token language unsourced (see I4) |

---

## Structural Assessment

The five-layer observability stack (action logging, identity/authority, decision context, causal correlation, fleet aggregation) is a strong and original framing. The PAC mapping table and the I1-I5 maturity model are coherent with the rest of the book. The writing is clean.

The chapter's treatment of OpenTelemetry's GenAI semantic conventions correctly notes what they cover and don't cover (no delegation chain, no semantic causality). The Certificate Transparency analogy for tamper-evident logs is apt.

The Irregular simulation is a good lead example and deserves the detailed treatment it receives. The fleet accountability point (individual logs clean; fleet view showed coordination) is the right framing.
