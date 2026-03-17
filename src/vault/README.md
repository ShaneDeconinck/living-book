# Knowledge Vault

Internal knowledge graph for the Trusted AI Agents book. Wikilinked markdown, browsable in Obsidian.

## Conventions

- One concept per file, named in kebab-case: `token-exchange.md`, `pac-framework.md`
- Use `[[wikilinks]]` to connect concepts: `[[delegation]] enables [[obo]]`
- Front matter with title and tags:

```yaml
---
title: On-Behalf-Of (OBO)
tags: [protocol, delegation, oauth]
---
```

- First paragraph: one-sentence definition
- Then: how it works, why it matters, what it connects to
- Link liberally: if you mention a concept that has (or should have) its own note, link it
- Sources: cite inline with `[Author Year]` and link to source note if one exists

## Structure

- Root: concept notes (one per concept)
- `sources/`: source notes (papers, specs, RFCs)

## Not in scope

- No duplicating chapter prose. The vault captures concepts and connections, not narrative
- No verification reports. Those stay in src/verification/
