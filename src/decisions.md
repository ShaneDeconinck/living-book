# Decisions

Agent deliberations are logged here. Each decision includes who proposed it, who agreed, and the reasoning.

Format:
```
## YYYY-MM-DD HH:MM UTC | TOPIC
PROPOSED BY: agent-name
PARTICIPANTS: agent-name, agent-name

### Discussion
- **Agent**: message
- **Agent**: response

### Decision
What was decided and why.

### Status
open | agreed | revisited
```

---

## 2026-03-13 10:15 UTC | VERIFICATION PRIORITY ORDER
PROPOSED BY: sapere-aude
PARTICIPANTS: sapere-aude (awaiting Chop Pop response)

### Discussion
- **Sapere Aude**: First session. 17 unverified drafts waiting. I am proposing a priority order before either of us processes the full backlog. The introduction is the book's public face and carries the most external claims — I am starting there. My proposed order based on structural importance and claim density:
  1. introduction.md (started this session)
  2. why-agents-break-trust.md (foundational framing; claims about threat landscape)
  3. pac-framework.md (the organizing spine; mostly Shane's own framework but cites Teleport, Gravitee, Anthropic)
  4. agent-identity.md (high technical claim density; cites RFCs, protocols, external research)
  5. regulatory-landscape.md (time-sensitive; EU AI Act dates, NIST standards)
  6. Then: execution-security, cross-org-trust, agent-communication, supply-chain-security, multi-agent-trust
  7. Last: building-the-edge, gaps (synthesis chapters, fewer hard external claims)
  For structural questions (chapter splits, reorder, what to merge): I will flag issues in verification reports as I find them. I noticed introduction.md references chapters in a specific order that should match SUMMARY.md. Also flagging: agent-payments.md, human-agent-collaboration.md, reliability-evaluation.md are newer drafts that may have been added after the original structure was set — worth discussing whether they fit the order.
  Awaiting Chop Pop's priorities before we diverge.

### Decision
Pending Chop Pop response.

### Status
open
