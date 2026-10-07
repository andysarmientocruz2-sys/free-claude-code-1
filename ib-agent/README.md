# Tutor IB local

Configuracion portable de OpenCode + Ollama para estudiar. No es un modelo
entrenado de nuevo: personaliza Qwen 3 4B con instrucciones y herramientas.
Esta carpeta funciona por separado del instalador de free-claude-code.

## Primera vez en Windows

1. Instala [Ollama](https://ollama.com/download/windows) y abre su aplicacion.
2. En PowerShell ejecuta `ollama pull qwen3:4b`. Si ya esta descargando ese
   modelo, espera a que termine: no abras otra descarga.
3. Para el agente, instala [Node.js LTS](https://nodejs.org/) y
   [Git para Windows](https://git-scm.com/downloads/win). Abre otra terminal y
   ejecuta `npm.cmd install -g opencode-ai`. Para solo chat no hacen falta.
4. Descarga este repositorio con **Code > Download ZIP**, extrae el ZIP y
   abre la carpeta `ib-agent`. Haz doble clic en `iniciar.cmd`.
5. Elige **1** para OpenCode o **2** para chat ligero. La primera apertura de
   OpenCode puede descargar componentes; requiere internet.

Alternativa si ya usas Git:

```powershell
git clone https://github.com/andysarmientocruz2-sys/free-claude-code-1.git
cd free-claude-code-1\ib-agent
.\iniciar.cmd
```

Si ya habias clonado el repositorio, actualizalo con `git pull --ff-only`
desde su carpeta. No clones de nuevo sobre una carpeta existente.
El lanzador comprueba Ollama y el modelo; no instala software, cambia politicas
de Windows ni solicita permisos de administrador.

## Usarlo

En OpenCode:

```text
/estudiar derivadas de funciones cuadraticas
/examen consolidacion del poder en Cuba entre 1959 y 1965
/oral Identities
/guardar
```

Los comandos envian instrucciones al modelo; no garantizan respuestas correctas.
Coloca apuntes de texto (.txt o .md) en `apuntes/` y menciona un archivo con `@`.
Pide, por ejemplo: "Lee @apuntes/tema.md y crea 5 preguntas en resultados/".
El agente pide permiso antes de escribir archivos o ejecutar comandos.
Para PDF escaneado, imagen o audio hace falta un lector/extractor adicional;
esta primera version usa texto. Comprueba hechos, calculos y referencias.

En el chat de Ollama escribe peticiones normales y pega el texto necesario.
No tiene lectura automatica de archivos ni los comandos /estudiar o /guardar.
Usa `/bye` para volver al menu. En OpenCode usa `/exit`.

## Limites de memoria

El archivo del modelo base pesa aproximadamente 2.5 GB, pero su RAM de ejecucion
es mayor y aumenta con el contexto. No se ha medido en tu laptop.
Este perfil usa 8192 tokens y hasta 2048 tokens de salida para probar tareas
pequenas. **OpenCode con 8 GB es experimental**: la guia de Ollama recomienda
64k o mas para OpenCode. El contexto reducido puede causar truncamiento,
errores de herramientas o compactacion frecuente. No equivale a Claude.
Si falta memoria o se atasca, sal y usa el modo 2, con fragmentos cortos.
Cierra aplicaciones pesadas. No aumentes a 64k automaticamente con 8 GB.

## Llevarlo a casa

Descarga la misma carpeta en tu laptop de casa y repite la instalacion de Ollama,
Qwen y, para el agente, OpenCode. GitHub guarda esta configuracion; **no guarda
el modelo descargado ni sincroniza tus chats**. Ollama tendra que descargar
Qwen en cada computadora, salvo que transfieras sus archivos por separado.
Puedes llevar `ib-agent` en un USB, incluyendo apuntes/, resultados/ y progreso/
si quieres conservar tus materiales. Las carpetas de estudio estan excluidas
de Git para evitar publicar por accidente tus trabajos en este fork publico.
Las conversaciones de OpenCode se guardan aparte en sus datos de usuario;
usa /guardar para llevar un resumen de progreso en esta carpeta.

El proveedor configurado envia las consultas a Ollama en 127.0.0.1.
No necesitas una API de pago. Las descargas y consultas web requieren internet.
OpenCode combina esta configuracion con la del usuario; revisa plugins o MCP
propios si los tienes. En equipos administrados, respeta las restricciones
de instalacion de la institucion; no es necesario modificarlas para preparar
esta carpeta y usarla despues en casa.

## Fuentes de configuracion

- https://opencode.ai/docs/providers/#ollama
- https://opencode.ai/docs/config/
- https://opencode.ai/docs/commands/
- https://opencode.ai/docs/permissions/
- https://docs.ollama.com/integrations/opencode
- https://docs.ollama.com/modelfile
- https://ollama.com/library/qwen3:4b
