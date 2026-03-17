---
title: Containment by Design
tags: [control, execution-security, architecture]
---

Security controls that make dangerous operations structurally impossible through OS-level isolation, rather than relying on permission prompts or policy enforcement.

Permission prompts fail because humans click "allow" habitually and agents operate too fast for meaningful review. Containment by design inverts this: instead of asking "should this agent do X?", the architecture ensures the agent *cannot* do X unless explicitly permitted. The [[isolation-spectrum]] ranges from native OS sandboxing (Apple's App Sandbox, Landlock) through containers (namespaces + cgroups) to microVMs (Firecracker) — each trading performance for stronger isolation. Defense in depth means layering these: filesystem restrictions prevent data access, network policies prevent exfiltration, resource limits prevent denial of service. This is [[infrastructure-in-the-loop]] applied to execution.
