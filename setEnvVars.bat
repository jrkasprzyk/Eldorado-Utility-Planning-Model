@echo off

rem ============================================
rem Set Environment Variable ELDO to script directory
rem Note: If run from a network (UNC) path, Windows may show a warning.
rem This is harmless and can be ignored.
rem ============================================

rem Set the variable locally first
set "ELDO=%~dp0"

rem %~dp0 ends with a trailing backslash, which we strip off
set "ELDO=%ELDO:~0,-1%"

rem Now set the environment variable to persist after the batch script exits
setx ELDO "%ELDO%"

echo.
echo Now, the value of ELDO on your machine is:
reg query HKCU\Environment /V ELDO

pause
