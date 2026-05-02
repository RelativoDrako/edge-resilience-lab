# Manual operativo — `deploy_clean.ps1`

## 1. Objetivo operativo

`deploy_clean.ps1` es el artefacto de publicación para repositorios editoriales o de superficie pública donde interesa dejar una historia **curada, sobria y defendible**.

Su propósito es:

- construir un snapshot canónico del contenido;
- crear una branch temporal limpia;
- permitir revisión local;
- aplicar localmente el resultado limpio;
- publicar reescribiendo `main` con control.

## 2. Cuándo usarlo

Usar `deploy_clean.ps1` en:

- repo de perfil GitHub;
- repo de GitHub Pages;
- repos editoriales públicos;
- superficies donde el historial de pruebas o ajustes menores no aporta valor público.

## 3. Cuándo no usarlo

No usar `deploy_clean.ps1` en:

- repos técnicos donde la historia sí es evidencia útil;
- prototipos donde los commits muestran evolución relevante;
- flujos normales de desarrollo diario.

En esos casos debe usarse `deploy_std.ps1`.

## 4. Modos operativos

### `CleanHistoryPublish`
Modo principal. Admite tres variantes:
- revisión local;
- aplicación local;
- publicación real.

### `ListBackupBranches`
Lista ramas backup `backup/pre-clean-*`.

### `DeleteBackupBranches`
Elimina ramas backup locales, remotas o ambas.

## 5. Parámetros principales

### `-ShowHelp`
Muestra ayuda rápida y ejemplos operativos.

### `-Branch`
Rama objetivo. Por defecto: `main`.

### `-Remote`
Remoto objetivo. Por defecto: `origin`.

### `-CommitMessage`
Mensaje del commit raíz limpio.

### `-AllowInit`
Permite inicializar repo si aún no existe `.git`.

### `-Push`
Publica el resultado limpio al remoto.

### `-DryRun`
Ejecuta validaciones reales y simula solo operaciones mutantes.

### `-NoBackup`
Evita crear branch backup antes de reescribir `main`.

### `-ApplyLocal`
Aplica localmente el resultado limpio sobre `main`, sin publicar.

### `-AllowDirtyWorktree`
Permite capturar cambios no committeados en el snapshot.

### `-DeleteRemoteBackups`
Habilita borrado de backups remotos.

### `-DeleteLocalBackups`
Habilita borrado de backups locales.

### `-PruneAfterDelete`
Hace prune de referencias después de borrar backups.

### `-AutoSetRemoteUrl`
Crea `origin` si no existe.

### `-RequiredPaths`
Archivos mínimos requeridos antes de operar.

## 6. Flujo lógico general

El flujo clean hace esto:

1. valida repo y requisitos mínimos;
2. valida working tree limpio, salvo permiso explícito;
3. obtiene snapshot del contenido actual;
4. crea una branch temporal limpia `__clean_publish_*`;
5. reconstruye el contenido;
6. crea un commit raíz canónico;
7. según parámetros:
   - deja branch de revisión,
   - reemplaza `main` local,
   - o reemplaza `main` y publica.

## 7. Comandos operativos y descripción

### 7.1 Mostrar ayuda

```powershell
.\\deploy_clean.ps1 -ShowHelp
```

Función:
- muestra propósito del script;
- muestra combinaciones frecuentes;
- explica el comportamiento de review, apply local y push.

### 7.2 Listar backups

```powershell
.\\deploy_clean.ps1 -Mode ListBackupBranches
```

Función:
- enumera ramas `backup/pre-clean-*`;
- permite saber si hay residuos de ciclos previos.

### 7.3 Eliminar backups locales

```powershell
.\\deploy_clean.ps1 -Mode DeleteBackupBranches -DeleteLocalBackups
```

Función:
- elimina ramas locales `backup/pre-clean-*`.

### 7.4 Eliminar backups remotos

```powershell
.\\deploy_clean.ps1 -Mode DeleteBackupBranches -DeleteRemoteBackups -PruneAfterDelete
```

Función:
- elimina backups remotos;
- luego hace prune de referencias.

### 7.5 Eliminar backups locales y remotos

```powershell
.\\deploy_clean.ps1 -Mode DeleteBackupBranches -DeleteLocalBackups -DeleteRemoteBackups -PruneAfterDelete
```

Función:
- limpia ambas superficies en una sola operación.

### 7.6 Revisión local segura

```powershell
.\\deploy_clean.ps1
```

Función:
- crea un snapshot limpio;
- genera una branch temporal `__clean_publish_*`;
- crea un commit raíz canónico;
- deja el resultado para inspección;
- no reemplaza `main`;
- no publica.

Resultado esperado:
- aparece una branch temporal de review;
- se imprime una advertencia con la siguiente acción sugerida.

### 7.7 Revisión local con árbol sucio autorizado

```powershell
.\\deploy_clean.ps1 -AllowDirtyWorktree
```

Función:
- igual que revisión local;
- pero permite que el snapshot incluya cambios no committeados.

Advertencia:
- aumenta el riesgo de introducir cambios no controlados en el snapshot.

### 7.8 Aplicación local

```powershell
.\\deploy_clean.ps1 -ApplyLocal
```

Función:
- ejecuta el flujo clean;
- reemplaza `main` local;
- no publica.

Resultado esperado:
- `main` local queda reemplazada por el commit canónico limpio.

### 7.9 Aplicación local con árbol sucio autorizado

```powershell
.\\deploy_clean.ps1 -ApplyLocal -AllowDirtyWorktree
```

Función:
- aplica localmente un snapshot que incluye cambios no committeados.

### 7.10 Publicación real limpia

```powershell
.\\deploy_clean.ps1 -Push -NoBackup
```

Función:
- crea snapshot limpio;
- reemplaza `main` local;
- publica con `--force-with-lease`;
- evita crear rama backup adicional.

Resultado esperado:
- `HEAD -> main` y `origin/main` quedan alineadas;
- el repo queda limpio;
- la publicación queda visible en GitHub.

### 7.11 Publicación real limpia con backup

```powershell
.\\deploy_clean.ps1 -Push
```

Función:
- igual que el flujo anterior;
- además crea una rama backup local previa a la reescritura.

### 7.12 Revisión de contenido sin mutar usando `-DryRun`

```powershell
.\\deploy_clean.ps1 -DryRun
```

Función:
- ejecuta validaciones reales de lectura;
- simula las operaciones mutantes del flujo clean.

Valida:
- repo actual;
- remote;
- branch objetivo;
- working tree;
- lógica del snapshot;
- secuencia operativa.

No muta:
- no crea branch real;
- no crea commit real;
- no reemplaza `main`;
- no publica.

## 8. Combinaciones recomendadas

### 8.1 Ruta segura de inspección editorial

```powershell
.\\deploy_clean.ps1 -Mode ListBackupBranches
.\\deploy_clean.ps1
git branch --list
git log --oneline --decorate -n 5
git status
```

Objetivo: inspeccionar el snapshot limpio antes de mutar `main`.

### 8.2 Ruta segura de aplicación local

```powershell
.\\deploy_clean.ps1
.\\deploy_clean.ps1 -ApplyLocal
git status
git log --oneline --decorate -n 5
```

Objetivo: verificar el snapshot y luego aplicarlo localmente.

### 8.3 Ruta real de publicación editorial validada

```powershell
.\\deploy_clean.ps1 -Mode DeleteBackupBranches -DeleteLocalBackups
.\\deploy_clean.ps1 -Mode ListBackupBranches
git status
.\\deploy_clean.ps1 -Push -NoBackup
git status
git log --oneline --decorate -n 5
git branch --list
git remote -v
```

Objetivo: limpiar artefactos de prueba y publicar el estado canónico real.

### 8.4 Ruta de limpieza integral

```powershell
.\\deploy_clean.ps1 -Mode DeleteBackupBranches -DeleteLocalBackups -DeleteRemoteBackups -PruneAfterDelete
.\\deploy_clean.ps1 -Mode ListBackupBranches
```

Objetivo: eliminar residuos de publicación anteriores.

### 8.5 Ruta de operación con cambios locales deliberados

```powershell
git status
.\\deploy_clean.ps1 -AllowDirtyWorktree
```

Objetivo: capturar conscientemente cambios no committeados.

Advertencia: no usar esta ruta como normalidad.

## 9. Relación correcta con `deploy_std.ps1`

Regla principal:

Si usaste:

```powershell
.\\deploy_clean.ps1 -ApplyLocal
```

y eso reescribió `main` local, **no debes publicar después con**:

```powershell
.\\deploy_std.ps1 -Push
```

### Por qué
Porque `main` local ya diverge intencionalmente de `origin/main`, y el push estándar debe bloquearse.

### Qué hacer en cambio
Publicar con:

```powershell
.\\deploy_clean.ps1 -Push -NoBackup
```

## 10. Errores esperados y respuesta correcta

### `Working tree is dirty`
Significa: existen cambios no committeados y el script no permitirá crear snapshot limpio.  
Acción:
- hacer commit o stash;
- o usar `-AllowDirtyWorktree` si realmente quieres capturarlos.

### `Another deploy process seems active`
Significa: existe un lock residual o una ejecución paralela.  
Acción:
- verificar que no exista otra corrida real;
- limpiar el lock si procede.

### `Remote changed during execution`
Significa: la rama remota cambió entre fetch y push.  
Acción:
- revisar el remoto;
- repetir el flujo si todavía es necesario.

### `DeleteBackupBranches requires ...`
Significa: no se especificó qué tipo de backup debe borrarse.  
Acción: usar uno o ambos:
- `-DeleteLocalBackups`
- `-DeleteRemoteBackups`

### Divergencia al intentar usar `deploy_std.ps1 -Push`
Significa: la historia local y remota ya no es compatible con push estándar.  
Acción correcta: usar el publish clean si esa divergencia fue resultado del flujo editorial.

## 11. Buenas prácticas de operación

- revisar backups antes y después de publicar;
- limpiar backups locales al cerrar pruebas;
- no usar `-AllowDirtyWorktree` salvo intención explícita;
- usar `-NoBackup` para publicación final sobria;
- eliminar ramas `__clean_publish_*` al cerrar el ciclo;
- confirmar `git status` limpio antes y después de publicar;
- validar `HEAD -> main, origin/main` alineadas al final.

## 12. Secuencia validada en entorno real

### 12.1 Estado inicial limpio
```powershell
git status
git log --oneline --decorate -n 10
git branch --list
```

### 12.2 Limpieza de backups locales
```powershell
.\\deploy_clean.ps1 -Mode DeleteBackupBranches -DeleteLocalBackups
.\\deploy_clean.ps1 -Mode ListBackupBranches
```

### 12.3 Verificación de árbol limpio
```powershell
git status
```

### 12.4 Publicación real
```powershell
.\\deploy_clean.ps1 -Push -NoBackup
```

### 12.5 Validación posterior
```powershell
git status
git log --oneline --decorate -n 5
git branch --list
git remote -v
```

### 12.6 Limpieza de ramas temporales de review
```powershell
git branch -D __clean_publish_YYYYMMDD_HHMMSS
```

Repetir por cada rama temporal sobrante.

### 12.7 Estado final esperado
```powershell
git branch --list
git status
```

Resultado esperado:
- solo `main`;
- working tree limpio.

## 13. Criterio de cierre exitoso

Se considera publicación clean correcta cuando:

- el script termina sin excepción;
- `git status` queda limpio;
- `HEAD -> main` y `origin/main` quedan en el mismo commit;
- el remote es el esperado;
- no quedan backups ni ramas temporales innecesarias;
- la superficie pública refleja el contenido canónico aprobado.

