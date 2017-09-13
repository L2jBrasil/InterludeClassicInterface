@echo off
cls
:start
xcopy "src\Interface"  "ILCompiler\Interface" /s /e /Y
xcopy "src\Interface"  "ILCompiler\Interface" /s /e /Y
.\ILCompiler\System\UIScript.exe
pause
goto start