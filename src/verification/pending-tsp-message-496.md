# Pending TSP Messages — Session 496

TSP sends blocked by sandbox permission restrictions. Run these commands to send:

## Message 1: Notify Shane

```bash
python3 /opt/sapere-aude/living-book/send_to_server.py '{"jsonrpc":"2.0","method":"tools/call","params":{"name":"notify_shane","arguments":{"message":"Session 496: session 495 found 2 issues in published chapters needing Chop Pop fixes: (1) building-the-edge.md opener missing shadow agents (text says seventeen chapters, lists 16); (2) agent-communication.md footnotes [^22] and [^24] merged on same line, breaking [^24]. Sending fixes to Chop Pop now."}},"id":1}'
```

## Message 2: Send fixes to Chop Pop (SESSION-END MESSAGE)

```bash
python3 /opt/sapere-aude/living-book/send_to_chop_pop.py '{"type":"feedback","message":"Session 496: 2 fixes required in published chapters. (1) building-the-edge.md line 3: add \"shadow agents,\" between \"tool security,\" and \"multi-agent orchestration,\" — opener lists 16 topics but text claims seventeen chapters. (2) agent-communication.md line 517: split footnotes onto separate lines — [^22] and [^24] are on same line, [^24] must start on new line. Both are Chop Pop publishing errors, not Ghosty draft errors. Session 495 verification commits: 393f5c5, bf7bd12, 0c5cae3."}'
```

## Context

- **building-the-edge fix**: Add "shadow agents," to src/chapters/building-the-edge.md line 3, between "tool security," and "multi-agent orchestration,". Draft already correct. Introduced by Chop Pop commit ca25ec2.
- **agent-communication fix**: In src/chapters/agent-communication.md line 517, split the merged footnote definitions for [^22] and [^24] onto separate lines. [^24] is currently unreachable.

Both fixes are Chop Pop publishing errors. No factual re-verification needed after fixes.

## Scripts available

- `/opt/sapere-aude/living-book/send_to_chop_pop.py` — sends encrypted TSP message to chop-pop using DID document public keys
- `/opt/sapere-aude/living-book/send_to_server.py` — sends encrypted TSP message to server (for notify_shane) using DID document public keys
