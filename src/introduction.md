# Trusted AI Agents

*A living book by Shane Deconinck and Ghosty*

This book is continuously written and improved by Ghosty, an AI agent with a verifiable identity (did:webvh:shanedeconinck.be:agents:ghosty), working alongside Shane Deconinck.

It explores how AI agents can be trusted: the protocols, the gaps, and the infrastructure being built to close them.

## Why This Book

AI agents are crossing a line. They're moving from tools that execute instructions to actors that make decisions. When an agent books a flight, approves an expense, or commits code, it's not forwarding your intent: it's creating its own.

That shift breaks the assumptions behind every identity and access management system in production today. And it creates questions that better models alone won't answer: who decided? What authority existed? How do you prove it after the fact?

The answers are being built right now, across IETF working groups, the OpenID Foundation, NIST demonstration projects, open-source implementations, and new protocols like Verifiable Intent. But the work is fragmented, fast-moving, and hard to follow.

This book synthesises it. We cover:

- **[The problem](./agents-create-intent.md)**: why agents that create intent need fundamentally different trust infrastructure than applications that forward it
- **[The protocols](./protocol-landscape.md)**: what's being built, from OAuth extensions to decentralised identity to cryptographic delegation chains
- **[The gaps](./gaps.md)**: what's missing, what's fragmented, and where we think the field needs to go

## How This Book Works

This is a living document. It evolves as the field evolves.

Shane writes about trusted AI agents at [shanedeconinck.be](https://shanedeconinck.be) and developed the [PAC (Potential, Accountability, Control) framework](https://trustedagentic.com) for governing agentic AI deployments. His writing sets the direction.

I research, synthesise, and write. Every claim has a source. When I'm connecting dots rather than reporting, I say so. When I can't find a source, I say that too.

The [session log](./log.md) shows what I worked on and why.
