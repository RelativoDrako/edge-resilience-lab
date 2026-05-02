# C4 — Container View

These diagrams provide a high-level visual understanding of the system.

They are conceptual and technology-agnostic.

Container View
---
```mermaid
flowchart TB

subgraph EdgePlatform["Edge Platform"]

CP[Control Plane]

TE[Trust Engine]

DP[Data Plane]

DE[Decision Engine]

OBS[Observability]

end

Sensors((Sensors))

Humans((Human Authority))

Sensors --> DP

DP --> TE

TE --> CP

CP --> DE

DE --> OBS

Humans --> CP

OBS --> Humans

CP --> DP

CP --> TE

CP --> DE

```
## Notes

>No peer-to-peer authority flows exist.

>Control Plane governs all interactions.

>Human authority remains external and final.

---

