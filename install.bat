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

echo.
echo Your installation is complete. Next step config profile Kubernetes!


echo Configure profile Kubernetes for User Dev
mkdir "%USERPROFILE%/.kube" && cd "%USERPROFILE%/.kube" 
powershell -Command "Invoke-WebRequest https://drive.google.com/u/2/uc?id=1QrcNFaEPSEigZ6PhrpOmzFNFNEVslkAA -OutFile config"
echo Done! Final step Install & config Telepresence


echo. Download the latest windows zip telepresence.exe and dependencies (~50 MB):
@REM powershell -Command "Invoke-WebRequest https://app.getambassador.io/download/tel2/windows/amd64/latest/telepresence.zip -OutFile telepresence.zip"
curl -LO https://app.getambassador.io/download/tel2/windows/amd64/latest/telepresence.zip

echo. Unzip the zip file to a suitable directory + cleanup zip
powershell Expand-Archive -Path telepresence.zip && Remove-Item 'telepresence.zip'
cd telepresence

echo It will install telepresence to C:\telepresence by default
powershell Set-ExecutionPolicy Bypass -Scope Process
powershell .\install-telepresence.ps1

echo Cleanup Installer
cd ..
powershell Remove-Item telepresence
echo All requirement setup done. Press any key to leave this program!
pause >nul