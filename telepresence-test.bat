@echo OFF
cls 
title Telepresence
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
   echo.
) ELSE (
   echo.-------------------------------------------------------------
   echo ERROR: YOU ARE NOT RUNNING THIS WITH ADMINISTRATOR PRIVILEGES.
   echo.-------------------------------------------------------------
   pause >nul
   echo.
   echo You will need to restart this program with Administrator privileges by right-clicking and select "Run As Administrator"
   echo.
   echo Press any key to leave this program. Make sure to Run As Administrator next time!
   pause >nul
   EXIT /B 1
)
:MainMenu
echo.=============================================
echo   1 ... Connect Telepresence
echo   2 ... Show intercept list
echo   3 ... Set intercept personal
echo   4 ... Set intercept global
echo   5 ... Remove intercept
echo   E ... Exit
echo.=============================================
echo.

CHOICE /C 12345E /M "Enter your choice: "
if errorlevel 6 exit /B
if errorlevel 5 goto RemoveIntercept
if errorlevel 4 goto SetInterceptGlobal
if errorlevel 3 goto SetInterceptPersonal
if errorlevel 2 goto ShowInterceptList
if errorlevel 1 goto ConnectTelepresence

:ConnectTelepresence
color 0A
telepresence login
echo. Connect successfully!
echo Press any key to go back main menu
pause>nul
goto MainMenu

:ShowInterceptList
color 0E
telepresence list
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

