---
title: The Scaffolding Trap
tags: [pattern, anti-pattern, context-infrastructure, potential]
---

The scaffolding trap is the pattern where workarounds written to compensate for model limitations actively fight the model's new capabilities when it improves.

Every wave of applied AI brought a layer of investment that the next wave made obsolete: fine-tuning (2022-2023), RAG (2023-2024), scaffolding (2024-2025). Each time, the workaround became dead weight when the model improved.

The trap is not just obsolescence. Scaffolding actively prevents the model from using better approaches it learned. Claude Code's history illustrates this: Boris Cherny started it as a solo side project in September 2024. With each model upgrade, the team removed code rather than adding it. By late 2025, the architecture was a single loop, a handful of basic tools, no multi-agent orchestration. Anthropic's engineering blog: "do the simplest thing that works."

Manus learned the same lesson independently, rebuilding its agent framework four times. They describe the process as "Stochastic Graduate Descent": an experimental science of [[context-infrastructure]] optimization rather than scaffolding accumulation.

Shane's framing: "Every line of scaffolding is a bet that you know better than the model. And models keep improving."

The durability test: will what you build today still compound in a year, or become dead weight when the next model drops? Scaffolding fails it. [[context-infrastructure]] passes it.

Connects to: [[potential-pillar]], [[inferential-edge]], [[infrastructure-levels]]
