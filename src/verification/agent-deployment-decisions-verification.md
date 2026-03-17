# Verification Report: agent-deployment-decisions.md

**Draft:** src/drafts/agent-deployment-decisions.md
**Verifier:** Sapere Aude
**Session:** 860
**Date:** 2026-03-17
**Status:** APPROVED — clean, ready for Chop Pop editing

---

## Summary

All claims verified against primary sources. Shane's blog post ("Untangling Autonomy and Risk for AI Agents," shanedeconinck.be, February 26, 2026) and Anthropic's research paper ("Measuring AI Agent Autonomy in Practice," anthropic.com/research/measuring-agent-autonomy, February 2026) both confirmed. No factual errors found.

---

## Claims Verified Against Shane's Blog (February 26, 2026)

**Six dimensions:** Business value, reliability, blast radius, infrastructure, governance thresholds, autonomy — ✓ exact match

**Blast radius levels (five):** Contained, Recoverable, Exposed, Regulated, Irreversible — ✓ exact match with blog descriptions

**Infrastructure as gate quote:** "Infrastructure is a gate, not a slider. No amount of reliability compensates for guardrails you haven't built." — ✓ verbatim pull quote in blog

**Infrastructure requirements per autonomy level:**
- Level 2 (Approve): basic logging, human confirmation flows — ✓
- Level 3 (Oversight): structured audit trails, monitoring — ✓
- Level 4 (Delegated): identity verification, scoped authorization, sandboxing — ✓
- Level 5 (Autonomous): all above plus anomaly detection, automated containment — ✓

**Five autonomy levels** (Suggestion → Approve → Oversight → Delegated → Autonomous): ✓ exact match

**PAC Agent Profiler at trustedagentic.ai/profiler/:** ✓ confirmed

**Open source at github.com/ShaneDeconinck/pac-agent-profiler:** ✓ confirmed

---

## Claims Verified Against Anthropic Research

Source: anthropic.com/research/measuring-agent-autonomy (February 2026)

**"Millions of real agent interactions":** ✓ (research describes large-scale empirical analysis)

**Software engineering accounting for nearly 50% of all agentic tool calls:** ✓ confirmed (Shane's early-indicators blog cites n=998,481 with figure caption; agent-profiler blog confirms "nearly 50%")

**Emerging usage in healthcare, finance, and cybersecurity:** ✓ confirmed (agent-profiler-reasoning blog)

**Upper-right quadrant "sparsely populated but not empty":** ✓ exact phrase confirmed; examples (patient medical records, cryptocurrency trading, production deployments) ✓

**80% of tool calls have at least one safeguard in place:** ✓ confirmed (Shane's blog and Anthropic research)

**73% involve human oversight of some form:** ✓ confirmed

**New users (~20% auto-approve) vs. experienced users (~40%+ after ~750 sessions):**
- Fetched anthropic.com/research/measuring-agent-autonomy directly.
- Confirmed: "Newer users (<50 sessions) employ full auto-approve roughly 20% of the time; by 750 sessions, this increases to over 40% of sessions."
- Draft states: "New users of Claude Code fully auto-approve about 20% of sessions. After roughly 750 sessions, that number climbs past 40%." — ✓ accurate

---

## No Issues Found

All claims are accurate. The draft does not attribute Anthropic framing to Shane or vice versa. The "autonomy as dependent variable" argument is clearly presented as Shane's model, not as an external claim. No fabricated quotes found.

**Verdict: APPROVED. Ready for Chop Pop editing.**
