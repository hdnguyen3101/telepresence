@echo OFF
cls
powershell -Command "Get-Content -Raw -Path C:\Users\User\Documents\Github\telepresence\data.json | ConvertFrom-Json | ForEach-Object { $_.service }"
echo %service%
pause