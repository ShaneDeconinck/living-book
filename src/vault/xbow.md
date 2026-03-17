---
title: XBOW
tags: [agent, security, offensive, autonomous, pentesting]
---

A fully autonomous AI penetration testing agent that reached #1 on HackerOne's bug bounty leaderboard. As of March 2026, XBOW has submitted 1,060+ vulnerabilities through HackerOne, executed 48-step exploit chains, and completed assessments in minutes that take skilled human pentesters hours.

## The capability threshold

XBOW discovered CVE-2026-21536 (Microsoft Devices Pricing Program RCE, CVSS 9.8) without source code access in 28 minutes. This marks a quantitative threshold: autonomous agents matching and exceeding top human security practitioners in specific dimensions.

The relevant dimension is scale over time. A human pentester executes complex exploit chains. XBOW executes the same chains in parallel across hundreds of targets, continuously, at a cost profile that does not scale with hours worked.

## Rate asymmetry

XBOW demonstrates the offensive side of rate asymmetry: vulnerability discovery and exploitation accelerating faster than defense cycles. Patching cadence (monthly Patch Tuesday) has not changed. Discovery rate has.

Organizations that assume vulnerability windows are measured in days need to update that assumption. Automated attackers with XBOW-class capabilities can find and weaponize vulnerabilities within hours of disclosure.

## Connects to

- [[blast-radius]] — autonomous discovery expands the window during which blast radius is fully exposed
- [[autonomy-levels]] — XBOW operates at A5 for offensive security; the same capability applied defensively requires I4+ infrastructure
- [[agentic-collapse]] — XBOW-class agents can find agentic collapse paths in agent-connected legacy systems
- [[infrastructure-levels]] — I4/I5 infrastructure shrinks the attack surface autonomous adversaries can probe

## Sources

- XBOW, xbow.com, 2026. "We Ran 1,060 Autonomous Attacks."
- CVE-2026-21536, Microsoft Devices Pricing Program RCE, CVSS 9.8, March 2026
- src/drafts/autonomous-security-agents.md
