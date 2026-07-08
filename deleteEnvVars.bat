@echo off

rem ============================================
rem Delete the Environment Variable: ELDO
rem Note: If run from a network (UNC) path, Windows may show a warning.
rem This is harmless and can be ignored.
rem ============================================

echo.
echo Removing the env variable ELDO...

REG delete HKCU\Environment /F /V ELDO >nul 2>&1

REG query HKCU\Environment /V ELDO >nul 2>&1

if %errorlevel%==0 (
    echo Something went wrong: variable still exists.
) else (
    echo Done. ELDO has been removed.
)

echo.
echo Note: You may need to reopen terminals or dialogs to see the change.
echo.
pause
