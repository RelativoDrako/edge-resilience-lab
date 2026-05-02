# C4 — Context View

These diagrams provide a high-level visual understanding of the system.

They are conceptual and technology-agnostic.

---
System Context View
---
```mermaid
flowchart TB

User((Human Operator))

Auditor((Auditor))

Environment((Physical Environment))

System[EdgeResilienceLab System]

User --> System

Auditor --> System

Environment --> System

System --> User

System --> Auditor
```
---
## Notes

>No peer-to-peer authority flows exist.

>Control Plane governs all interactions.

>Human authority remains external and final.
