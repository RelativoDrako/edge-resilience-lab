# Manual operativo — `deploy_std.ps1`

## 1. Objetivo operativo

`deploy_std.ps1` es el artefacto de publicación estándar para repositorios donde la historia de commits **debe preservarse**.

Su propósito es:

- validar el estado del repositorio antes de publicar;
- detectar errores estructurales mínimos;
- crear commit solo cuando hay cambios reales;
- publicar con `push` estándar cuando la relación entre rama local y remota es segura;
- bloquear el `push` cuando la historia local y remota no es compatible.

## 2. Cuándo usarlo

Usar `deploy_std.ps1` cuando el repositorio:

- es técnico;
- necesita conservar trazabilidad natural de commits;
- no requiere reescritura de historial;
- debe usar `push` estándar, no `force push`.

### Casos típicos

- prototipos técnicos;
- repos de scripts y automatización con trazabilidad útil;
- repositorios de evidencia funcional;
- repos donde el historial de desarrollo sí aporta valor.

## 3. Cuándo no usarlo

No usar `deploy_std.ps1` cuando:

- el repositorio es principalmente editorial o de superficie pública;
- se desea limpiar historial antes de publicar;
- ya se aplicó un flujo `deploy_clean.ps1 -ApplyLocal`;
- la rama local diverge intencionalmente de `origin/main`;
- la publicación correcta requiere `--force-with-lease`.

En esos casos se debe usar `deploy_clean.ps1`.

## 4. Comportamiento general del script

El flujo estándar hace esto:

1. muestra ayuda operativa si se solicita;
2. valida que `git` exista;
3. valida que el directorio actual sea un repo o inicializa si se autorizó;
4. valida conflictos y archivos obligatorios;
5. asegura que la rama objetivo esté lista;
6. hace `git add -A`;
7. crea commit solo si hay cambios reales;
8. valida si el `push` es fast-forward seguro;
9. publica si corresponde.

## 5. Parámetros principales

### `-ShowHelp`
Muestra ayuda rápida del script.

### `-Branch`
Define la rama objetivo. Valor por defecto: `main`.

### `-Remote`
Define el remoto objetivo. Valor por defecto: `origin`.

### `-CommitMessage`
Define el mensaje del commit si se requiere crear uno.

### `-AllowInit`
Permite inicializar el directorio como repo git si aún no existe `.git`.

### `-Push`
Ejecuta publicación real después de validar el estado.

### `-DryRun`
Ejecuta validaciones reales de lectura y simula solo operaciones mutantes.

### `-CI`
Ajusta la salida para pipelines automatizados.

### `-AutoSetRemoteUrl`
Configura automáticamente el remoto si no existe.

### `-RequiredPaths`
Lista de archivos o rutas mínimas obligatorias. Por defecto: `README.md`.

## 6. Comandos operativos y descripción

### 6.1 Mostrar ayuda

```powershell
.\\deploy_std.ps1 -ShowHelp
```

Función:
- muestra el encabezado operativo;
- resume el propósito del script;
- muestra ejemplos rápidos de uso.

### 6.2 Simulación segura

```powershell
.\\deploy_std.ps1 -DryRun
```

Función:
- ejecuta validaciones reales de lectura;
- simula checkout, staging, commit y push;
- no modifica el repositorio.

### 6.3 Publicación estándar real

```powershell
.\\deploy_std.ps1 -Push
```

Función:
- ejecuta el flujo estándar completo;
- hace commit si hay cambios reales;
- valida si el push puede hacerse como fast-forward seguro;
- publica al remoto.

### 6.4 Inicializar repo y publicar

```powershell
.\\deploy_std.ps1 -AllowInit -Push
```

Función:
- inicializa repo si no existe `.git`;
- continúa el flujo normal;
- publica si la validación es correcta.

### 6.5 Configurar remoto automáticamente

```powershell
.\\deploy_std.ps1 -Push -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
```

Función:
- si `origin` no existe, lo crea;
- después continúa el flujo estándar.

### 6.6 Cambiar rama objetivo

```powershell
.\\deploy_std.ps1 -Branch dev -Push
```

Función:
- orienta toda la validación y publicación a la rama `dev`.

### 6.7 Personalizar mensaje de commit

```powershell
.\\deploy_std.ps1 -CommitMessage "Update operational docs and metadata" -Push
```

Función:
- usa un mensaje específico si se crea commit.

## 7. Combinaciones recomendadas

### 7.1 Ruta segura mínima

```powershell
.\\deploy_std.ps1 -ShowHelp
.\\deploy_std.ps1 -DryRun
.\\deploy_std.ps1 -Push
```

### 7.2 Ruta con remoto ausente

```powershell
.\\deploy_std.ps1 -DryRun -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
.\\deploy_std.ps1 -Push -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
```

### 7.3 Ruta con inicialización controlada

```powershell
.\\deploy_std.ps1 -AllowInit -DryRun
.\\deploy_std.ps1 -AllowInit -Push -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
```

### 7.4 Ruta con rama distinta

```powershell
.\\deploy_std.ps1 -Branch release -DryRun
.\\deploy_std.ps1 -Branch release -Push
```

## 8. Lógica de validación previa al push

Antes de hacer `push`, el script valida:

- si `origin/main` no existe, permite push inicial;
- si `main` local está ahead en fast-forward, permite push;
- si `main` local está behind, bloquea;
- si `main` local y `origin/main` divergen, bloquea.

## 9. Errores esperados y respuesta correcta

### `No git repository detected`
No existe `.git` en el directorio actual. Cambiar al repo correcto o usar `-AllowInit`.

### `Missing required files or folders`
Falta al menos una ruta obligatoria. Crear la ruta faltante o ajustar `-RequiredPaths`.

### `Unresolved merge conflicts detected`
Hay conflictos sin resolver. Resolver antes de repetir el flujo.

### `Local 'main' and 'origin/main' have diverged`
La historia local y remota ya no es compatible con push estándar. Reconciliar manualmente o usar `deploy_clean.ps1 -Push` si la divergencia proviene de una reescritura editorial.

## 10. Buenas prácticas de operación

- ejecutar `-DryRun` antes de publicar;
- no usar `deploy_std.ps1` para repos editoriales;
- no usar `deploy_std.ps1 -Push` después de `deploy_clean.ps1 -ApplyLocal`;
- mantener `README.md` y metadatos mínimos presentes;
- conservar mensajes de commit sobrios y profesionales.

## 11. Ruta operativa recomendada por tipo de repo

### Repos técnicos
```powershell
.\\deploy_std.ps1 -DryRun
.\\deploy_std.ps1 -Push
```

### Repos con remoto ausente
```powershell
.\\deploy_std.ps1 -DryRun -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
.\\deploy_std.ps1 -Push -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
```

### Repos recién inicializados
```powershell
.\\deploy_std.ps1 -AllowInit -DryRun
.\\deploy_std.ps1 -AllowInit -Push -AutoSetRemoteUrl "https://github.com/OWNER/REPO.git"
```

## 12. Criterio de cierre exitoso

Se considera publicación estándar correcta cuando:

- el script termina sin excepción;
- `git status` queda limpio;
- `git log --oneline --decorate -n 5` refleja el estado esperado;
- la rama local y remota quedan alineadas;
- no se detectan conflictos ni faltantes posteriores.

