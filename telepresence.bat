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
cls
echo.=============================================
echo   1 ... Connect Telepresence
echo   2 ... Show intercept list
echo   3 ... Set intercept personal
echo   4 ... Remove intercept
echo   E ... Exit
echo.=============================================
echo.

CHOICE /C 1234E /M "Enter your choice: "
if errorlevel 5 exit /B
if errorlevel 4 goto RemoveIntercept
if errorlevel 3 goto SetInterceptPersonal
if errorlevel 2 goto ShowInterceptList
if errorlevel 1 goto ConnectTelepresence

:ConnectTelepresence
color 0A
telepresence connect
echo. Connect successfully!
echo Press any key to go back main menu...
pause>nul
goto MainMenu

:ShowInterceptList
color 0E
telepresence list
echo.
echo Press any key to go back main menu...
pause >nul
goto MainMenu

:SetInterceptPersonal
color 0B
REM - load a value from a json file without quotes
SETLOCAL EnableDelayedExpansion
set TELE=C:\telepresence\data.json
set service= 
jq -r .service "%TELE%" > out.tmp
set /p service=<out.tmp

set port_local=
jq -r .port_local "%TELE%" > out.tmp
set /p port_local=<out.tmp

set port_remote=
jq -r .port_remote "%TELE%" > out.tmp
set /p port_remote=<out.tmp

set http_header=
jq -r .http_header "%TELE%" > out.tmp
set /p http_header=<out.tmp

set http_value=
jq -r .http_value "%TELE%" > out.tmp
set /p http_value=<out.tmp

telepresence intercept %service% --port=%port_local%:%port_remote% --http-header=%http_header%=%http_value% --mount=false
echo Press any key to go back main menu...
pause >nul
goto MainMenu

:RemoveIntercept
color 0C
SETLOCAL EnableDelayedExpansion
set TELE=C:\telepresence\data.json
set service= 
jq -r .service "%TELE%" > out.tmp
set /p service=<out.tmp
telepresence leave %service%
echo.
echo Remove Intercept %service% successful. Press any key to go back main menu...
pause >nul
goto MainMenu

