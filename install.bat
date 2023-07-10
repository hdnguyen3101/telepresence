echo OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
   echo.
) ELSE (
   echo.-------------------------------------------------------------
   echo ERROR: YOU ARE NOT RUNNING THIS WITH ADMINISTRATOR PRIVILEGES.
   echo.-------------------------------------------------------------
   pause
   echo.
   echo. You will need to restart this program with Administrator privileges by right-clicking and select "Run As Administrator"
   pause 
    echo.
   echo Press any key to leave this program. Make sure to Run As Administrator next time!
   pause
   EXIT /B 1
)

powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n=allowGlobalConfirmation
echo Chocolatey is ready to begin installing packages!
echo. Install Kubectl packages

@REM ----[ Whatever you want to install, place it below this point, each item on its own line (to make it easier to find later on. ] ----
choco install kubernetes-cli
choco install curl
choco install jq

echo.
echo Your installation is complete. Next step config profile Kubernetes!

echo Configure profile Kubernetes for User Dev
powershell -Command "Invoke-WebRequest https://drive.google.com/u/0/uc?id=1gYZHPNK0fjSHRJ0F-7kDeQIyre_-v4cn -OutFile data-telepresence.zip"
powershell Expand-Archive -Path data-telepresence.zip
powershell Remove-Item data-telepresence.zip
cd data-telepresence
mkdir "%USERPROFILE%/.kube"
copy config "%USERPROFILE%/.kube/config"
echo Done! Final step to Install & config Telepresence

echo. Download the latest windows zip telepresence.exe and dependencies (~50 MB):
powershell -Command "Invoke-WebRequest https://app.getambassador.io/download/tel2/windows/amd64/2.7.6/telepresence.zip -OutFile telepresence.zip"
@REM curl -LO https://app.getambassador.io/download/tel2/windows/amd64/2.7.6/telepresence.zip

echo. Unzip the zip file to a suitable directory + cleanup zip
powershell Expand-Archive -Path telepresence.zip
cd telepresence

echo It will install telepresence to C:\telepresence by default
powershell -ExecutionPolicy Bypass -File "install-telepresence.ps1"
@REM powershell .\install-telepresence.ps1

echo Cleanup Installer
cd ..
set TELE=C:\telepresence
copy telepresence.bat %TELE%
copy data.json %TELE%
cd ..
powershell Remove-Item data-telepresence
echo All requirement setup done. Press any key to leave this program!
pause >nul