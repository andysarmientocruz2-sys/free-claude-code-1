@echo off
setlocal
pushd "%~dp0"
if errorlevel 1 exit /b 1
title Tutor IB local
where ollama >nul 2>nul
if errorlevel 1 goto missing_ollama
ollama list >nul 2>nul
if errorlevel 1 goto server_error
ollama show qwen3:4b >nul 2>nul
if errorlevel 1 goto missing_model
echo Preparando ib-qwen con contexto de 8192 tokens...
ollama create ib-qwen -f Modelfile
if errorlevel 1 goto model_error
if not exist apuntes mkdir apuntes
if not exist resultados mkdir resultados
if not exist progreso mkdir progreso
:menu
echo.
echo [1] OpenCode - agente con archivos (experimental con 8 GB)
echo [2] Ollama - chat ligero, sin herramientas
echo [3] Diagnostico
echo [4] Salir
choice /c 1234 /n /m "Elige 1, 2, 3 o 4: "
if errorlevel 4 goto done
if errorlevel 3 goto diagnosis
if errorlevel 2 goto chat
if errorlevel 1 goto agent
goto done
:agent
where opencode >nul 2>nul
if errorlevel 1 goto missing_opencode
call opencode . --model ollama/ib-qwen:latest --agent tutor
if errorlevel 1 echo OpenCode fallo. Revisa el mensaje anterior; puedes probar el chat con 2.
goto menu
:chat
ollama run ib-qwen
goto menu
:diagnosis
ollama --version
ollama list
ollama ps
where opencode >nul 2>nul
if not errorlevel 1 call opencode --version
goto menu
:missing_ollama
echo Instala Ollama desde https://ollama.com/download/windows y abre una terminal nueva.
goto failed
:server_error
echo Abre Ollama desde Inicio. Si no responde, ejecuta ollama serve en otra terminal.
goto failed
:missing_model
echo Falta qwen3:4b o su descarga sigue en curso.
echo Cuando termine, comprueba ollama list. Para descargarlo: ollama pull qwen3:4b
goto failed
:missing_opencode
echo Falta OpenCode. Con Node.js LTS instalado, ejecuta: npm.cmd install -g opencode-ai
echo Despues cierra esta ventana y vuelve a abrir iniciar.cmd.
echo Puedes usar el chat mientras tanto.
goto menu
:model_error
echo No se pudo crear ib-qwen. Revisa el error anterior y actualiza Ollama si procede.
goto failed
:failed
pause
popd
exit /b 1
:done
popd
endlocal
