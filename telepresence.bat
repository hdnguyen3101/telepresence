@echo OFF
title Telepresence
:MainMenu
cls
echo.=============================================
echo   1 ... Connect Telepresence
echo   2 ... Show intercept list
echo   3 ... Show intercept status
echo   4 ... Set intercept personal
echo   5 ... Set intercept global
echo   6 ... Remove intercept
echo   7 ... Show kubernetes service and port
echo   E ... Exit
echo.=============================================
echo.

CHOICE /C 1234567E /M "Enter your choice: "
if errorlevel 8 exit /B
if errorlevel 7 goto ShowKubernetesService
if errorlevel 6 goto RemoveIntercept
if errorlevel 5 goto SetInterceptGlobal
if errorlevel 4 goto SetInterceptPersonal
if errorlevel 3 goto ShowInterceptStatus
if errorlevel 2 goto ShowInterceptList
if errorlevel 1 goto ConnectTelepresence

:ConnectTelepresence
color 0A
telepresence connect 
echo. Connect successfully!
echo Press any key to go back main menu
pause >nul
goto MainMenu

:ShowInterceptList
color 0E
telepresence list -i
echo.
echo Press any key to go back main menu
pause >nul
goto MainMenu

:ShowInterceptStatus
color 0E
telepresence status
echo.
echo Press any key to go back main menu
pause >nul
goto MainMenu

:SetInterceptPersonal
color 0B
set /P intercept-name=Enter intercept name: 
set /P service=Enter Service name: 
set /P port-local=Enter Local port: 
set /P port-remote=Enter Remote port (default 8080): 
set /P http-header=Enter HTTP Header: 
set /P http-value=Enter HTTP Value: 
telepresence intercept %intercept-name% --service=%service% --port %port-local%:%port-remote% --http-header=%http-header%=%http-value% --mount=false
echo Press any key to go back main menu
pause >nul
goto MainMenu

:SetInterceptGlobal
color 0A
set /P intercept-name=Enter intercept name: 
set /P service=Enter Service name: 
set /P port-local=Enter Local port: 
set /P port-remote=Enter Remote port: 
telepresence intercept %intercept-name% --service=%service% --port %port-local%:%port-remote%
echo Press any key to go back main menu
pause >nul
goto MainMenu

:RemoveIntercept
color 0C
set /P intercept-name=Enter intercept name: 
telepresence leave %intercept-name%
echo Press any key to go back main menu
pause >nul
goto MainMenu

:ShowKubernetesService
color 09
set /P service=Enter Service name: 
kubectl get svc %service% --output yaml
echo.
echo Press any key to go back main menu
pause >nul
goto MainMenu
