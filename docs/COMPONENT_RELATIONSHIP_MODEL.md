# Component Relationship Model

EdgeResilienceLab is organized as a public architecture package with complementary reference components.

## Relationship Summary

```mermaid
flowchart LR
    ERL[EdgeResilienceLab Core Architecture]
    GOV[Governed AI Architecture]
    CICD[GH CI/CD Automation]
    ISR[ISR Multiplatform Inventory]
    C4[C4 / SysML Diagrams]
    RFP[RFP and Roadmap]

    ERL --> C4
    ERL --> RFP
    ERL --> GOV
    ERL --> CICD
    ERL --> ISR

    GOV -->|authority and decision boundaries| ERL
    CICD -->|publication and reproducibility| ERL
    ISR -->|device discovery and evidence-first assessment| ERL
```

## Interpretation

- ERL provides the architecture and governance frame.
- Governed AI material reinforces authority, trust, and decision-boundary reasoning.
- GH_CI-CD contributes reproducible publication and deployment automation patterns.
- ISR multiplatform tooling contributes evidence-first device discovery and assessment discipline.

The relationship is complementary. The integrated components do not convert ERL into a finished implementation.
