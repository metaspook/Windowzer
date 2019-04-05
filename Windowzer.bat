:: Windowzer.
:: Version: 1.0
:: Written by Metaspook
:: License: <http://opensource.org/licenses/MIT>
:: Copyright (c) 2019 Metaspook.
:: 
@echo off

::
:: REQUESTING ADMINISTRATIVE PRIVILEGES
::
REM >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
>nul 2>&1 reg query "HKU\S-1-5-19\Environment"
if '%errorlevel%' NEQ '0' (
	(echo.Set UAC = CreateObject^("Shell.Application"^)&echo.UAC.ShellExecute "%~s0", "", "", "runas", 1)>"%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B
) else ( >nul 2>&1 del "%temp%\getadmin.vbs" )

::
:: MAIN SCRIPT STARTS BELOW
::
title "Windowzer" 
rem Winlisk
color 0B
pushd "%~dp0"
set APPVAR=1.0
mode con: cols=54 lines=12
call:BANNER
echo   Scanning....    Please Wait.
for /F "tokens=4" %%A in ('systeminfo 2^>nul^|find "Total Physical Memory"') do set /a tRAM=%%A

:CHOICE_MENU
mode con: cols=54 lines=24
call:BANNER
echo ^|======= OPTION MENU =======
echo ^|  
echo ^|  1. Junk Cleaner.
echo ^|  2. System Booster.
echo ^|  3. Internet Booster.
echo ^|  4. Windows Optimization.
echo ^|  5. Run CMD as Administrator.
echo ^|  6. Read Notes.
echo ^|  0. Exit.
echo.
echo       [Type a number and press Enter key]
echo.
set CMVAR=
set /p "CMVAR=Enter Option: "
if "%CMVAR%"=="1" (
	call:BANNER
	>nul 2>&1 rd /s /q "%temp%" && md "%temp%" >nul 2>&1
	>nul 2>&1 rd /s /q "%windir%\Temp" && md "%windir%\Temp" >nul 2>&1
	echo [DONE] Junk files cleaned.
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)
if "%CMVAR%"=="2" (
	call:BANNER
	REM for win 32bit.
	start %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
	REM for win 64bit.
	start %windir%\SysWOW64\rundll32.exe advapi32.dll,ProcessIdleTasks
	echo [OK] Clear Memory Cache.
	>nul 2>&1 rd /s /q "%windir%\Prefetch" && md "%windir%\Prefetch" >nul 2>&1
	echo [OK] Clear Prefetch Cache.
	echo [DONE] System Boosted.
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)
if "%CMVAR%"=="3" (
	call:BANNER
	>nul 2>&1 ipconfig /flushdns
	echo [OK] Clear DNS Cache.
	echo [DONE] Internet Boosted.
	>nul 2>&1 timeout /t 2
	goto:CHOICE_MENU
)
if "%CMVAR%"=="4" (
	set RRSTR1=
	set RRSTR2=
	set RRSTR3=
	call:BANNER
	if %tRAM% leq 4 (
		>nul 2>&1 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "3" /f
		>nul 2>&1 reg add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "0" /f
		>nul 2>&1 reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010020000" /f
		>nul 2>&1 reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
		>nul 2>&1 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f
		>nul 2>&1 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "0" /f
		>nul 2>&1 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_SZ /d "0" /f
		>nul 2>&1 reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
		set RRSTR1=[OK] Less RAM Detected! %tRAM% GB only.
		set RRSTR2=     Tweaks for %tRAM% GB RAM applied.
	)
	REM ; Boot, Shutdown, AutoEndTask Optimization.
	>nul 2>&1 reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
	>nul 2>&1 reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
	>nul 2>&1 reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
	>nul 2>&1 reg add "HKU\.DEFAULT\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
	>nul 2>&1 reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
	set RRSTR3=[DONE] Windows Optimization.
	goto:REBOOTREQ
)
if "%CMVAR%"=="5" start /i %windir%\System32\cmd.exe
if "%CMVAR%"=="6" (
	mode con: cols=54 lines=31
	call:BANNER
	echo ^| This script is not a heavy customizer and optimizer
	echo ^| program. It does only effective and essential
	echo ^| optimizations intelligently.
	echo ^|
	echo ^| ** Junk Cleaner **
	echo ^| Cleans various junk, temporary files and folders.
	echo ^|
	echo ^| ** System Booster **
	echo ^| Cleans RAM, Clears Memory and Prefetch cache.
	echo ^|
	echo ^| ** Internet Booster **
	echo ^| Various internet optimizations and clears DNS Cache.
	echo ^|
	echo ^| ** Windows Optimization **
	echo ^| To make Windows faster it intelligently optimizes
	echo ^| Boot, Shutdown, AutoEndTask and various, also
	echo ^| detects 4 GB or less RAM and applies extra tweaks.
	echo.
	echo             [Press any key to Main Menu]
	echo.
	pause>nul
	goto:CHOICE_MENU
)
if "%CMVAR%"=="0" exit
goto:CHOICE_MENU

:BANNER
cls                   
echo                              ____________________
echo               WINDOWZER v%APPVAR%                     \\  
echo  \\ An intelligent and minimal Windows optimizer. \\ 
echo   \\    Written by Metaspook  
echo    \\___________________________////////////////////
echo.&echo.&echo.&echo.&echo.
goto:eof

:REBOOTREQ
call:BANNER
if defined RRSTR1 echo %RRSTR1%
if defined RRSTR2 echo %RRSTR2%
if defined RRSTR3 echo %RRSTR3%
echo.
echo [NOTE!] This Optimization don't need to 
echo         re-apply again untill you face any 
echo         issue. 
echo.
echo ^|  Now it needs to Restart your PC.
echo ^|  
echo ^|  1. Reboot Now
echo ^|  2. Main Menu
echo.
set RRVAR=
set /p "RRVAR=Enter Option: "
if "%RRVAR%"=="1" shutdown /r /f /t 00
if "%RRVAR%"=="2" goto:CHOICE_MENU
goto:REBOOTREQ
