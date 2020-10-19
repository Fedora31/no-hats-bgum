<!-- : Batch file with embeded VBS (http://www.dostips.com/forum/viewtopic.php?p=33963#p33963)

:: NO HATS MOD UPDATE SCRIPT
:: for https://github.com/Fedora31/no-hats-bgum

:: Checks which VPKs you have installed,
:: compares their last modified date with the latest github commit,
:: and downloads ones that are out of date.

:: made by junior
:: ---------------------------------------------------

@echo off
setlocal
setlocal EnableDelayedExpansion
title No Hats Mod Update Script

call :setESC

echo %ESC%[7m No Hats Mod Update Script %ESC%[0m
echo https://github.com/Fedora31/no-hats-bgum
echo.

:: Check curl.
where /Q curl
IF NOT %ERRORLEVEL% EQU 0 (
	echo %ESC%[101;93m ERROR %ESC%[0m %ESC%[32mcurl%ESC%[0m not found
	goto :exit
)

:: Check jq.
where /Q jq
IF %ERRORLEVEL% EQU 0 (
	set jq=jq
	call :main
) else (
	echo %ESC%[32mjq%ESC%[0m not found, a temporary copy will be downloaded...%ESC%[90m
	curl -L "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe" ^
		-o "%TEMP%\jq.exe"
	echo.
	set "jq=%TEMP%\jq.exe"
	call :main
	del /q "%TEMP%\jq.exe"
)

goto :exit
:: ----------------------------------------------------

:setESC
:: https://gist.github.com/mlocati/fdabcaeb8071d5c75a2d51712db24011
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)

:main
set files[0]=no_hats_bgum.vpk
set files[1]=no_bugged_misc.vpk
set files[2]=no_hats_creatorstf.vpk
set files[3]=no_unusuals.vpk
set files[4]=no_christmas_lights.vpk
set files[5]=no_skins.vpk
set files[6]=no_botkiller.vpk

for /l %%i in (0,1,6) do (
	echo %ESC%[0m%ESC%[7m !files[%%i]! %ESC%[0m
	if exist !files[%%i]! (
		call :update !files[%%i]!
	) else (
		echo    Not found.
	)
)
exit /B 0

:update
:: Get last modified time.
for /f "tokens=*" %%a in ('cscript //nologo update-nohats.cmd?.wsf //job:GetLastModifiedTime %~1') do set "LastModified=%%a"
echo    downloaded: %LastModified%

:: Get last commit time.
for /f "tokens=*" %%a in ('curl -s "https://api.github.com/repos/Fedora31/no-hats-bgum/commits?path=%~1" ^| 	"%jq%" -r ".[0].commit.committer.date"') do set "LastCommit=%%a"
echo    lastest version: %LastCommit%

cscript //nologo update-nohats.cmd?.wsf //job:CompareDates "%LastModified%" "%LastCommit%"
IF %ERRORLEVEL% EQU 1 (
	echo    Downloading...%ESC%[90m
	curl "https://raw.githubusercontent.com/Fedora31/no-hats-bgum/master/%~1" -o %~1
	call :print_done
) else (
	echo    Up to date.
)
exit /B 0

:print_done
echo    %ESC%[0mDone.
exit /B 0

:exit
echo.
echo Press any key to exit...
pause > nul
exit /B 0

-- END OF BATCH -->

<package>
<job id="GetLastModifiedTime"><script language="VBScript">
Dim fso, f, d, r
Set fso = CreateObject("Scripting.FileSystemObject")
Set f = fso.GetFile(WScript.Arguments(0))
d = f.DateLastModified
WScript.Echo year(d) & "-" & Right(0 & month(d), 2) & "-" & Right(0 & day(d), 2) _
	& "T" & Right(0 & hour(d), 2) & ":" & Right(0 & minute(d), 2) _
	& ":" & Right(0 & second(d), 2) & "Z"
WScript.Quit
</script></job>

<job id="CompareDates"><script language="VBScript">

d1 = WScript.Arguments(0)
t1 = (CDbl(Mid(d1, 1, 4)) - 2010) * 31622400
t1 = t1 + CDbl(Mid(d1, 6, 2)) * 2678400
t1 = t1 + CDbl(Mid(d1, 9, 2)) * 86400
t1 = t1 + CDbl(Mid(d1, 12, 2)) * 3600
t1 = t1 + CDbl(Mid(d1, 15, 2)) * 60
t1 = t1 + CDbl(Mid(d1, 18, 2))

d2 = WScript.Arguments(1)
t2 = (CDbl(Mid(d2, 1, 4)) - 2010) * 31622400
t2 = t2 + CDbl(Mid(d2, 6, 2)) * 2678400
t2 = t2 + CDbl(Mid(d2, 9, 2)) * 86400
t2 = t2 + CDbl(Mid(d2, 12, 2)) * 3600
t2 = t2 + CDbl(Mid(d2, 15, 2)) * 60
t2 = t2 + CDbl(Mid(d2, 18, 2))

If t1 < t2 Then
	WScript.Quit 1
Else
	WScript.Quit 0
End If
</script></job>
</package>
