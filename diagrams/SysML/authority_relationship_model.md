# SysML — Authority Relationship Model

These diagrams express formal operational states and transitions.

## Authority Relationship Model

```mermaid
flowchart LR

HumanAuthority((Human Authority))
ControlPlane[Control Plane]
AISubsystems[AI / ML Subsystems]
DataSources[(Real + Synthetic Data)]

DataSources --> AISubsystems
AISubsystems --> ControlPlane
HumanAuthority --> ControlPlane
ControlPlane --> AISubsystems
ControlPlane --> DataSources
```
---
### note right of AISubsystems : Advisory only. No authority transfer.
---