---
title: Prove Mode Authorization
tags: [governance, cryptographic, accountability]
dimension: audit-trails
---

The third governance mode beyond "don't" (policy) and "can't" (architecture), where actions carry cryptographic proof of who authorized them, what constraints apply, and when.

Policy says the agent should not exceed its scope. Architecture ensures the agent cannot exceed its scope. Prove mode adds: every action the agent takes carries a verifiable record of authorization. This closes the accountability gap — even if an action was within scope and structurally permitted, prove mode answers "who authorized this specific action?" [[ghost-token]] implements prove mode tactically. [[mapl]] implements it at the policy layer. Together they make the [[liability-chain]] reconstructible from cryptographic evidence rather than log archaeology.
