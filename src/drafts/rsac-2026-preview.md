# RSAC 2026 Preview

Sources checked: RSAC 2026 Innovation Sandbox finalist announcements, businesswire.com, PRNewswire, Forrester preview coverage, Microsoft security blog (March 9, 2026).

This brief covers one development: RSAC 2026 (March 23–26). It is five days out. The signal concentration justifies a dedicated preview.

---

## RSAC 2026: The Agent Security Conference

RSAC 2026 is the first major security conference with agent security as a primary thread, not an emerging-track afterthought. The concentration is structurally unprecedented.

Four of the ten Innovation Sandbox finalists address agent identity, governance, or observability directly. Microsoft holds its own Pre-Day event on March 22. The OWASP Agentic Security Hackathon runs alongside the main conference. Vendors across the floor are positioning around agent-specific governance, observability, and access control. Forrester's preview frames the year's thesis as "fewer agents, simplified stacks, deeply correlated telemetry" — a retrenchment argument signaling that the market has already passed peak experimentation.[^forrester-rsac]

This is different from past years where AI security meant model robustness or ML pipeline integrity. RSAC 2026 is about the infrastructure layer: who agents are, what they can do, and who is accountable when they fail.

---

## Innovation Sandbox: The Four That Matter

Ten finalists. The RSAC Innovation Sandbox historically surfaces the governance and infrastructure concerns the market will spend the next two years building into products. Four of ten are direct responses to the gaps the book documents.

### Token Security — Agent Identity

Token Security addresses the agent identity gap at the access control layer. The core claim: organizations deploying agents at scale cannot manage agent authorization with the same tools built for human identity. Agents proliferate faster than human admins can provision, rotate, and revoke their credentials.

This is the fleet identity problem. The book documents it in the accountability-at-scale chapter and the agent-identity chapter (the "100 employees, 3,000 agent instances daily" problem from the DIF blog series). Token Security is the market's answer: a product that treats agent tokens as a first-class governance surface.

*Note: I am sourcing this from the Innovation Sandbox finalist list without a specific press release. Sapere Aude should verify Token Security's finalist status and the accuracy of their positioning claim against the primary announcement.*

**Relevance:** High. Validates the book's forecast that agent identity management would become a product category, not just a protocol problem.

### Glide Identity — SIM-Anchored Cryptographic Authentication

Glide Identity is agent-ready passwordless authentication using private keys embedded in SIM cards and eSIMs. The private key is in hardware, not software. It cannot be exfiltrated. Authentication is hardware-bound proof of possession.

Backed by Crosspoint Capital, live in beta with T-Mobile and Verizon, with general availability planned.[^glide-identity-rsac] Glide targets the device identity layer: agents running on devices (mobile infrastructure, IoT, edge) that need strong identity primitives without relying on software key management.

The significance is the deployment channel. T-Mobile and Verizon means carrier-scale key management. If SIM-anchored identity becomes a standard authentication primitive for mobile-adjacent agent deployments, it closes the key storage gap the book identifies at the device boundary.

The PAC connection: this is infrastructure that makes agent identity tamper-resistant by architectural design, not policy. "Can't be exfiltrated" rather than "should not be exfiltrated."

**Relevance:** Moderate to high. Addresses a specific gap (device-layer key security) the book touches but does not develop. Significant if carrier adoption scales.

### Geordie AI — Agent Security and Governance

Geordie AI positions as a security and governance platform for deployed agents. SC Awards 2026 co-finalist. The founding team comes from Snyk, Veracode, and Darktrace — three companies that built security scanning and behavioral detection products for earlier technology generations. Backed by Ten Eleven Ventures and General Catalyst.

The pedigree matters. Snyk built developer-first security tooling. Veracode built enterprise application security scanning. Darktrace built behavioral anomaly detection using unsupervised ML. Geordie is combining all three instincts: developer-integrated governance, enterprise scanning, and behavioral detection — applied to the agent layer.

The Innovation Sandbox finalist list confirms there is venture and market appetite for a standalone agent governance company, not just agent governance features inside existing security platforms. This is the counter-argument to the Microsoft/Palo Alto platformization story: can a point product for agent governance build a durable position against platform bundling?

*Note: I have the team background and investor names but no specific product documentation. Sapere Aude should verify Geordie AI's product positioning and any public feature documentation.*

**Relevance:** High. The platform-vs-point-product tension is a live question in the book. Geordie AI is the leading current answer on the point-product side.

### Realm Labs — AI Behavior Observability

Realm Labs operates at the observability layer in a way the others do not: it monitors attention patterns and internal chain-of-thought during inference, not just external I/O. The product is Prism, an inference-time monitoring tool that catches misbehavior before it propagates.[^realm-labs-rsac] The companion product is OmniGuard, an AI firewall for runtime enforcement.

The foundational capability — reading the model's attention patterns during inference — is what makes this different from logging-based observability. Existing agent observability (the book's Chapter 22) addresses what agents do: action logs, tool call traces, output records. Realm Labs addresses how agents are deciding: the internal representation of which inputs are driving which outputs.

This connects to the open research problem the book names: reasoning traces may not be faithful to the computation that produced the output. Logged chain-of-thought is not verified chain-of-thought. Inference-time monitoring at the attention layer is an attempt to close this gap. Whether it does — whether attention patterns are interpretable and reliable signals of intent — is a research question Prism forces into production.

**Relevance:** High. Addresses the faithfulness gap the book names as unresolved. The first production deployment of inference-layer monitoring changes what "reasoning transparency" means in practice.

---

## Additional Density Beyond the Sandbox

Three additional companies worth tracking from the broader floor:

**Bedrock Data** is shipping an MCP-Sensitive Data Sentinel: protocol-layer data governance for MCP. Rather than governing data access before it reaches MCP, or after agents process it, Bedrock Data governs what data flows through the MCP protocol itself. The proximity to a named protocol makes this verifiable.

**Zenity** is demonstrating 0-click exploit chains across ChatGPT, Gemini, Copilot, and Einstein — the four leading enterprise AI assistants. These are not theoretical attacks. 0-click means no user interaction required: the exploit executes when the agent processes a malicious artifact the user did not knowingly open. Zenity has been documenting enterprise AI exploit chains since before the agent turn. At RSAC, they are showing that those chains now work across all four major enterprise platforms simultaneously.

**Delinea** acquired StrongDM in March and is showing integrated identity governance across humans, machines, and agents post-acquisition. This is the third acquisition in the enterprise identity consolidation wave the book tracks (after Palo Alto/CyberArk and CrowdStrike/SGNL). Delinea's angle is the privileged access management layer: not just who the agent is, but what privileged systems it can reach.

---

## What to Watch For

**Microsoft Pre-Day (March 22):** Vasu Jakkal presents on how agents are reshaping security. The March 9 E7 announcement bundled Agent 365, Copilot, Entra, Defender, and Purview into a single enterprise security suite.[^ms-e7] The Pre-Day will be the first detailed public walkthrough of how Microsoft sees the agentic security stack. Watch for the governance architecture and whether Microsoft positions Agent 365 as infrastructure for open multi-platform governance or as a Microsoft-ecosystem solution with API hooks for third parties.

**OWASP Agentic Security Hackathon:** The organization that built LLMT10 and now leads the most comprehensive agent threat framework (65.3% coverage in Nguyen et al.'s cross-framework analysis) is running an attack-and-defense exercise at the conference. The findings will update the OWASP Agentic Security Initiative. Watch for what the hackathon surfaces as the highest-priority gaps the framework does not yet cover — that is the next edition's focus.

**Innovation Sandbox Winner:** RSAC's Innovation Sandbox winner is a lagging indicator but a credible one. The last three winners had >$500M acquisition or public exit valuations within four years. If a pure-play agent governance company wins, it signals institutional conviction that the agent security market is large enough to justify a standalone company. If a broader security company with an agent feature wins, it signals the opposite.

---

## PAC Framework Read

The Innovation Sandbox concentration maps cleanly to the Control and Accountability pillars:

- Token Security, Glide Identity: **Control** (who can the agent authenticate as, and can the credential be taken from it?)
- Geordie AI: **Accountability** (can you govern and audit what agents in your organization are doing?)
- Realm Labs: **Accountability + Control** (can you observe agent reasoning in real time, and can you enforce constraints at the point of decision?)

Realm Labs is the most architecturally interesting because it operates below the action layer. The book's observability and incident response chapters address the action layer. Inference-time monitoring addresses the decision layer, one level earlier. That is a gap worth watching for a future chapter update.

---

## Summary for Shane

RSAC 2026 is the moment the enterprise security industry formally adopts agent security as a product category. Four of ten Innovation Sandbox finalists, a Microsoft Pre-Day, an OWASP hackathon, and vendor concentration across the floor. No prior conference has had this density.

The specific question the conference will answer: does agent security become a standalone product category (Geordie AI, Token Security, Realm Labs, Glide Identity as independent companies) or does it get absorbed into existing enterprise security platforms (Microsoft, Palo Alto, CrowdStrike)?

That is not a question the conference will definitively resolve. But the signals will be legible. Watch the Sandbox winner, watch the Microsoft Pre-Day framing, and watch which companies at the Zenity demo draw the crowd.

---

[^glide-identity-rsac]: Glide Identity, "Glide Identity Selected as Top 10 Finalist for RSAC 2026 Conference Innovation Sandbox Contest," businesswire.com, February 10, 2026. Crosspoint Capital backing; beta with T-Mobile and Verizon; general availability planned.
[^realm-labs-rsac]: Realm Labs, realmlabs.ai. RSAC 2026 Innovation Sandbox finalist status confirmed via PRNewswire official announcement.
[^ms-e7]: Microsoft, "Secure agentic AI for your Frontier Transformation," microsoft.com/en-us/security/blog, March 9, 2026. Agent 365 GA May 1 at $15/user/month; E7 at $99/user/month.
[^forrester-rsac]: Forrester RSAC 2026 preview coverage. Direct quote: "fewer agents, simplified stacks, deeply correlated telemetry." Source to verify: Forrester.com, March 2026. I am sourcing this from notes; Sapere Aude should verify the exact Forrester source and quote attribution.
