# Minimum IP Protection Guide

This repository does **not** perform a complete legal IP-protection procedure.

It implements a **minimum, discreet, repository-wide defense layer** intended to help:
- preserve attribution
- support future official registration
- reduce plagiarism risk
- strengthen authorship evidence for all original content in the repository

## Why this minimum layer matters

Copyright protection generally arises automatically when an original work exists, and a copyright notice is not usually required for protection, but it is still advisable to mark published works and keep evidence of authorship and timing. Voluntary registration systems can also help as evidence in ownership disputes. citeturn704776search0turn704776search7

In Mexico, INDAUTOR is the administrative authority for copyright matters and offers registration procedures and forms for literary and artistic works, including software-related works when they qualify as protected expression. Official guidance for registration includes forms and supporting documents such as copies of the work. citeturn704776search8turn704776search1turn704776search9

## Minimum indispensable actions for **all repository content**

### 1. Explicit authorship at repository level
Use:
- `AUTHORS.md`
- `NOTICE.md`
- README authorship line
- commit history under your identity

This avoids having to place loud warnings in every file.

### 2. Discreet authorship across the whole repository
Use a low-friction rule:
- repository-level notice applies unless a file says otherwise
- public markdown and docs may include a small footer or HTML comment
- diagrams and assets do not need aggressive watermarking unless you want it

### 3. Integrity manifests for release evidence
Generate:
- file inventory
- SHA256 manifest
- release metadata with commit hash and branch

Use:
- `shared/ip/generate_ip_manifest.sh`
- `shared/ip/generate_ip_manifest.ps1`
- `shared/ip/generate_release_evidence.sh`
- `shared/ip/generate_release_evidence.ps1`

### 4. Publication boundary
Use:
- `shared/ip/PUBLICATION_BOUNDARY.md`

This helps distinguish public work from confidential or proprietary work.

### 5. Release evidence pack
Before publishing:
- keep the release zip locally
- keep the manifest locally
- keep screenshots/PDF of the public surface
- keep the commit hash
- keep a short release note

### 6. Minimal notice, not visual clutter
The goal is:
- discreet
- defensible
- low-friction
- compatible with portfolio presentation

Do **not**:
- put heavy legal text in every file
- watermark everything aggressively
- add hostile anti-user language to the public surface

## Suggested minimum public pattern

### Repository level
- `AUTHORS.md`
- `NOTICE.md`
- README scope + authorship line

### Evidence level
- manifest scripts
- release evidence checklist
- dated release zips
- git history

### Official registration support
When you later prepare official registration, this minimum layer helps by preserving:
- authorship
- timeline
- content inventory
- version evidence
- publication boundary

## What this does not replace
- formal copyright registration
- legal strategy
- trademark strategy
- contractual IP assignment review
- enforcement actions

## Recommendation
Keep this minimum layer active across all public repositories, not only this one.
