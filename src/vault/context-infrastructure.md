---
title: Context Infrastructure
tags: [framework, potential, architecture]
---

The organizational knowledge management layer that agents consume: structured information, access permissions, discovery protocols, authority scoping, and freshness guarantees.

Every wave of AI infrastructure (fine-tuning, RAG, scaffolding) deprecated as models improved, but context infrastructure compounds. When a better model arrives, an organization with mature context infrastructure captures more value; one without it gets a more capable model running on the same mess. Five dimensions: **Structure** (coherent, domain-modeled information), **Permissions** (fine-grained access controls matching the delegating user's authority), **Discovery** (protocols like [[mcp]] and [[a2a]] for finding tools and agents), **Authority** (access scoped to what the user is allowed to see, for this task), **Freshness** (up-to-date or versioned, with staleness signals). The [[scaffolding-trap]] explains why this layer endures when others do not.
