# SysML — System State Model

These diagrams express formal operational states and transitions.

## System State Model

```mermaid
stateDiagram-v2

[*] --> Reinforced
Reinforced --> Optimal : Redundancy stable
Optimal --> Normal : Stable sensing
Normal --> Degraded : Confidence drops
Degraded --> DegradedCritical : Self-distrust triggered
DegradedCritical --> Critical : Emergency continuity
Critical --> DegradedCritical : Partial recovery
DegradedCritical --> Degraded : Confidence improves
Degraded --> Normal : Stability restored
Normal --> Optimal : Homogeneous sensing
Optimal --> Reinforced : Reinforcement engaged

note right of Reinforced : Maximum redundancy
note right of Optimal : Stable homogeneous sensing
note right of Normal : Mixed sensing
note right of Degraded : Data confidence compromised
note right of DegradedCritical : Strict policies, synthetic support
note right of Critical : Minimum safe availability
```
---
### note right of AISubsystems : Advisory only. No authority transfer.
---