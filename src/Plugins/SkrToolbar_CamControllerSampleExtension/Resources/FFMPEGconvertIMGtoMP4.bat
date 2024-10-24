@echo off
set "param1=%1"
cd %param1%
set "param2=%2"
start /wait cmd /c %param2%

if %ERRORLEVEL% equ 0 (
    del "*.png" /Q
	start explorer %param1%
) else (
    echo La commande a échoué. Aucune suppression des fichiers PNG.
	pause
)