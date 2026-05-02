# How to Use This Repository

This repository is a **professional architectural reference** and **Work in Progress portfolio artifact**.

It is intended for reading, discussion, onboarding, audit preparation, RFP-style review, and architectural reasoning.  
It is not a production deployment package.

## Recommended Reading Order

1. [README.md](README.md) — Executive positioning, governing principle, and repository map
2. [README.non-technical.md](README.non-technical.md) — Plain-language explanation
3. [ROADMAP.md](ROADMAP.md) — Capability maturity and integration roadmap
4. [CHANGELOG.md](CHANGELOG.md) — Conceptual maturity progression and change policy
5. [RFP.md](RFP.md) — Simulated procurement and evaluation framing
6. [diagrams/C4/](diagrams/C4/) — System context and container-level views
7. [diagrams/SysML/](diagrams/SysML/) — Authority and state reasoning models
8. [governance/governed-ai-architecture/](governance/governed-ai-architecture/) — Governed AI reference case and authority flow
9. [automation/](automation/) — ERL automation and publication workflows
10. [automation/GH_CI-CD/](automation/GH_CI-CD/) — CI/CD scripts and manuals
11. [tooling/inventory-stream7-rescue/](tooling/inventory-stream7-rescue/) — Multiplatform inventory and evidence-first assessment tooling
12. [LEGAL_AND_IP.md](LEGAL_AND_IP.md) and [DISCLAIMER.md](DISCLAIMER.md) — Publication boundary and professional disclaimer

## Use by Audience

### Architects and Technical Leaders

Start with `README.md`, `RFP.md`, `ROADMAP.md`, and the C4/SysML diagrams.

### Governance, Risk, and Compliance Reviewers

Start with `CHANGELOG.md`, `LEGAL_AND_IP.md`, `DISCLAIMER.md`, and `governance/governed-ai-architecture/`.

### Platform / Automation Engineers

Start with `automation/`, `automation/GH_CI-CD/`, and `.github/workflows/`.

### Device / Edge Operations Reviewers

Start with `tooling/inventory-stream7-rescue/docs/`, then review the Linux and Windows lanes under `tooling/inventory-stream7-rescue/multiplatform/`.

## What Not to Do

- Do not treat this repository as deployable production software.
- Do not infer missing implementation details from conceptual diagrams.
- Do not weaken authority guarantees or AI advisory-only semantics.
- Do not publish private recovery internals or hardware-specific findings before validation.

## Contribution and Change Discipline

Changes should improve maturity, not complexity.  
Governance-altering changes should be accompanied by architectural rationale and, when appropriate, ADR-style documentation.
