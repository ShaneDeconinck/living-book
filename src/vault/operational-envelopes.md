---
title: Operational Envelopes
tags: [authorization, control, delegation]
---

Cryptographic constraints that travel with an authorization, defining what an agent can do in machine-enforceable terms.

An operational envelope encodes: spending limits, approved services, time bounds, purpose constraints, geographic restrictions. Unlike OAuth scopes (coarse, string-based), operational envelopes carry structured, verifiable constraints. They answer: "this agent is authorized to book flights under $500, only on approved airlines, only for the next 48 hours." The constraints are enforced by infrastructure, not by the agent. Even a compromised agent cannot exceed the envelope. [[verifiable-intent]] implements envelopes using SD-JWT selective disclosure. [[mapl]] composes envelopes across delegation chains using intersection semantics. Operational envelopes are the mechanism that makes [[trust-inversion]] practical: you grant broad capability categories but constrain the operational parameters.
