# Manual operativo — `deploy.yml` (GitHub Actions Controlled Deploy)

## 1. Objetivo operativo

`deploy.yml` es el workflow de GitHub Actions que permite ejecutar una publicación controlada desde la interfaz de GitHub sin depender de una terminal local.

Su propósito es:

- exponer una ejecución manual y explícita mediante `workflow_dispatch`;
- estandarizar la operación de deploy sobre GitHub-hosted runners;
- reducir fricción operativa para flujos repetibles;
- demostrar una filosofía operativa reproducible, controlada e idempotente;
- proyectar una práctica real de GitOps y publication control en superficies públicas.

## 2. Cambio necesario para volverlo reusable

La versión anterior del manual documentaba un workflow que llamaba:

```powershell
./deploy.ps1 @args
```

Ese diseño ya no es canónico, porque el paquete reusable quedó dividido en:

- `deploy_std.ps1`
- `deploy_clean.ps1`

Por tanto, el workflow reusable debe **enrutar explícitamente al script correcto según `mode`** y no depender de `deploy.ps1`.

## 3. Diseño canónico actual

Reglas:

- `StandardPublish` -> `deploy_std.ps1`
- `CleanHistoryPublish` -> `deploy_clean.ps1`
- `ListBackupBranches` -> `deploy_clean.ps1`
- `DeleteBackupBranches` -> `deploy_clean.ps1`

La invocación debe hacerse con parámetros nombrados explícitos, no con arrays genéricos ambiguos.

## 4. Archivo `deploy.yml` recomendado

```yaml
name: Controlled Deploy

on:
  workflow_dispatch:
    inputs:
      mode:
        description: "Deploy mode"
        required: true
        default: "CleanHistoryPublish"
        type: choice
        options:
          - StandardPublish
          - CleanHistoryPublish
          - ListBackupBranches
          - DeleteBackupBranches
      branch:
        description: "Target branch"
        required: true
        default: "main"
        type: string
      delete_remote_backups:
        description: "Delete remote backup branches"
        required: false
        default: false
        type: boolean
      delete_local_backups:
        description: "Delete local backup branches"
        required: false
        default: false
        type: boolean

permissions:
  contents: write

concurrency:
  group: controlled-deploy-${{ github.repository }}
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: windows-latest
    timeout-minutes: 20

    defaults:
      run:
        shell: pwsh

    env:
      FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6
        with:
          fetch-depth: 0
          persist-credentials: true

      - name: Configure git identity
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

      - name: Validate deploy scripts exist
        run: |
          if (-not (Test-Path ".\deploy_std.ps1")) {
            throw "Missing deploy_std.ps1"
          }

          if (-not (Test-Path ".\deploy_clean.ps1")) {
            throw "Missing deploy_clean.ps1"
          }

      - name: Run controlled deploy
        run: |
          $mode = "${{ inputs.mode }}"
          $branch = "${{ inputs.branch }}"
          $remoteUrl = "https://github.com/${{ github.repository }}.git"

          Write-Host "Mode: $mode"
          Write-Host "Branch: $branch"
          Write-Host "Remote: $remoteUrl"

          if ($mode -eq "StandardPublish") {
            Write-Host "Executing deploy_std.ps1"
            .\deploy_std.ps1 `
              -Branch $branch `
              -CI `
              -Push `
              -AutoSetRemoteUrl $remoteUrl
          }
          elseif ($mode -eq "CleanHistoryPublish") {
            Write-Host "Executing deploy_clean.ps1"
            .\deploy_clean.ps1 `
              -Mode CleanHistoryPublish `
              -Branch $branch `
              -CI `
              -Push `
              -NoBackup `
              -AutoSetRemoteUrl $remoteUrl
          }
          elseif ($mode -eq "ListBackupBranches") {
            Write-Host "Executing deploy_clean.ps1 in ListBackupBranches mode"
            .\deploy_clean.ps1 `
              -Mode ListBackupBranches `
              -Branch $branch `
              -CI `
              -AutoSetRemoteUrl $remoteUrl
          }
          elseif ($mode -eq "DeleteBackupBranches") {
            Write-Host "Executing deploy_clean.ps1 in DeleteBackupBranches mode"

            $deleteRemote = "${{ inputs.delete_remote_backups }}" -eq "true"
            $deleteLocal = "${{ inputs.delete_local_backups }}" -eq "true"

            if (-not $deleteRemote -and -not $deleteLocal) {
              throw "DeleteBackupBranches requires at least one of delete_remote_backups or delete_local_backups to be true."
            }

            if ($deleteRemote -and $deleteLocal) {
              .\deploy_clean.ps1 `
                -Mode DeleteBackupBranches `
                -Branch $branch `
                -CI `
                -DeleteRemoteBackups `
                -DeleteLocalBackups `
                -PruneAfterDelete `
                -AutoSetRemoteUrl $remoteUrl
            }
            elseif ($deleteRemote) {
              .\deploy_clean.ps1 `
                -Mode DeleteBackupBranches `
                -Branch $branch `
                -CI `
                -DeleteRemoteBackups `
                -PruneAfterDelete `
                -AutoSetRemoteUrl $remoteUrl
            }
            elseif ($deleteLocal) {
              .\deploy_clean.ps1 `
                -Mode DeleteBackupBranches `
                -Branch $branch `
                -CI `
                -DeleteLocalBackups `
                -PruneAfterDelete `
                -AutoSetRemoteUrl $remoteUrl
            }
          }
          else {
            throw "Unsupported mode: $mode"
          }
```

## 5. Modos de uso desde GitHub Actions

### Publicación estándar
Inputs:
- `mode = StandardPublish`
- `branch = main`

### Publicación clean editorial
Inputs:
- `mode = CleanHistoryPublish`
- `branch = main`

### Listar backups
Inputs:
- `mode = ListBackupBranches`
- `branch = main`

Esta es la mejor primera corrida para validar que el workflow ya funciona y para cambiar el badge a verde.

### Borrar backups
Inputs:
- `mode = DeleteBackupBranches`
- `delete_remote_backups = true` cuando se quiera limpiar remoto;
- `delete_local_backups = true` cuando aplique.

## 6. Orden de validación recomendado

1. Ejecutar `ListBackupBranches`.
2. Si sale verde, ejecutar `CleanHistoryPublish`.
3. Solo después, si se desea validar flujo técnico, ejecutar `StandardPublish`.

## 7. Badge recomendado

```markdown
[![.github/workflows/deploy.yml](https://github.com/RelativoDrako/RelativoDrako/actions/workflows/deploy.yml/badge.svg)](https://github.com/RelativoDrako/RelativoDrako/actions/workflows/deploy.yml)
```

## 8. Criterio de cierre exitoso

Se considera el workflow reusable y cerrado cuando:

- existe en `.github/workflows/deploy.yml`;
- puede ejecutarse manualmente desde GitHub Actions;
- enruta correctamente a `deploy_std.ps1` o `deploy_clean.ps1`;
- sus inputs son comprensibles;
- una corrida segura como `ListBackupBranches` sale verde y permite que el badge refleje estado correcto.
