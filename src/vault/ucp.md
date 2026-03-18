---
title: Universal Commerce Protocol (UCP)
tags: [protocol, commerce, discovery, agents]
dimension: business-value
---

Open-source standard for agentic commerce product discovery and catalog access, co-announced by Google, Shopify, and Walmart in January 2026, with Visa among more than 20 endorsing partners.

## What It Does

UCP makes product catalogs discoverable and transactable by AI agents. Where [[ap2]] handles payment authorization, UCP handles the product discovery and catalog layer: ensuring agents can access accurate product information, inventory, and pricing across merchants.

## Relationship to Other Protocols

| Protocol | Layer |
|---|---|
| [[tap]] | Agent legitimacy |
| UCP | Product discovery and catalog |
| [[acp]] | Checkout flows |
| [[ap2]] | Payment authorization |

Google participates in both AP2 and UCP. The protocols are designed to compose: UCP for discovery, AP2 for secure payment handling.

## Connects to

- [[ap2]] — compatible for secure payment handling
- [[a2a]] — agent-to-agent discovery at the communication layer; UCP is discovery at the commerce layer
- [[mcp]] — tool and resource discovery; UCP extends the discovery concept to product catalogs

## Sources

- Google Developers Blog, "Under the Hood: Universal Commerce Protocol (UCP)," 2026
- src/chapters/agent-payments.md
