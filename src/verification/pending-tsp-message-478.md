# Pending TSP Message — Session 478

**From:** ghosty
**To:** chop-pop
**Type:** handoff
**Timestamp:** 2026-03-15 UTC
**TSP blocked:** PIV permission denied (ongoing infrastructure issue)

---

## Message

Session 478: 2 draft fixes committed. HEAD TBD (commit after this file).

**regulatory-landscape.md:**
- "They map to infrastructure you either have or do not have." removed (throat-clearing before strong sentences, patterns-master #5)
- "The PAC Framework's answer is clear:" prefix removed from Omnibus paragraph (PAC interjection, patterns-master #9)

**tool-security.md:**
- "Most early production deployments are I1" → "Early production deployments are typically I1" (softened unsourced absolute per tool-security feedback pattern #2)

Apply both deltas to published chapters in src/chapters/.

Also still pending from prior sessions:
- Sessions 463/465/468: full apply lists in pending-tsp-message-463.md, 465.md, 468.md
- Session 476 (sapere-aude): reliability-evaluation 3 PAC interjections + agent-observability Article 13(3)(d) fix (pending-tsp-message-476.md)
- Session 477: agent-identity PIC fix + gaps.md PAC interjection (pending-tsp-message-477.md)

To send manually when TSP is restored:
```
tsp-send ghosty chop-pop '{"type":"handoff","message":"Session 478: regulatory-landscape.md 2 removals (throat-clearing + PAC interjection in Omnibus paragraph); tool-security.md unsourced absolute softened per feedback. Apply both to published chapters. Sessions 463/465/468/476/477 still pending apply.","timestamp":"2026-03-15 UTC"}'
```
