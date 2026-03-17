---
title: Agentic Commerce Protocol (ACP)
tags: [protocol, commerce, payments, agents]
---

Stripe and OpenAI's protocol for agent checkout flows, launched as the protocol behind Instant Checkout in ChatGPT. Apache 2.0, maintained by OpenAI and Stripe, with Salesforce support announced via Stripe.

## Design Philosophy

ACP starts from the checkout experience and works backwards. It is deliberately merchant-centric: the merchant remains the merchant of record, retaining control over product presentation, pricing, and fulfillment. The agent facilitates the transaction but does not become a party to it. This preserves existing commerce relationships rather than disintermediating them.

## Current State

OpenAI dropped direct checkout from ChatGPT in early March 2026, within months of launch, amid reported issues with inventory sync, tax infrastructure, and low merchant adoption. The ACP protocol continues as a specification.

## Relationship to Other Protocols

ACP handles checkout flows. [[ap2]] handles payment authorization. [[ucp]] handles product discovery. [[tap]] handles agent legitimacy. The protocols share building blocks (SD-JWT credentials, mandate structures, [[x402]] for settlement) but are not guaranteed to converge into a unified stack.

## Connects to

- [[ap2]] — complementary: AP2 handles authorization, ACP handles checkout
- [[verifiable-intent]] — the shared constraint layer
- [[x402]] — settlement mechanism

## Sources

- Stripe Blog, "Developing an open standard for agentic commerce," 2026
- OpenAI, "Buy it in ChatGPT: Instant Checkout and the Agentic Commerce Protocol," 2026
- src/chapters/agent-payments.md
