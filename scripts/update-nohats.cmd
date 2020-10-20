@set @junk=1 /* BATCH FILE WITH EMBEDDED JSCRIPT

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

set "scriptPath=%~0"

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
for /f "tokens=*" %%a in ('cscript //nologo //E:jscript "%scriptPath%" %~1') do set "LastModified=%%a"
echo    downloaded: %LastModified%

:: Get last commit time.
for /f "tokens=*" %%a in ('curl -s "https://api.github.com/repos/Fedora31/no-hats-bgum/commits?path=%~1" ^| "%jq%" -r ".[0].commit.committer.date"') do set "LastCommit=%%a"
echo    lastest version: %LastCommit%

cscript //nologo //E:jscript "%scriptPath%" "%LastModified%" "%LastCommit%"
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

:: ------------------------------------------------
:: --- END OF BATCH --- */

// START OF JSCRIPT

if (WScript.Arguments.length == 1) {
	getLastModifiedTime(WScript.Arguments(0));
} else if (WScript.Arguments.length == 2) {
	compareDates(WScript.Arguments(0), WScript.Arguments(1));
} else {
	WScript.Quit(0);
}

function compareDates(d1, d2) {
	d1 = d1.substring(5, 10) + "-" + d1.substring(0, 4) + " " + d1.substring(11, 19)
	d1 = Date.parse(d1)

	d2 = d2.substring(5, 10) + "-" + d2.substring(0, 4) + " " + d2.substring(11, 19)
	d2 = Date.parse(d2)

	WScript.Quit(d2 > d1 ? 1 : 0)
	
	function parse(string, start, end) {
		return parseInt(
			string.substring(start, end));
	}
}

function getLastModifiedTime(file) {

	d = new Date(
		new ActiveXObject("Scripting.FileSystemObject")
			.GetFile(WScript.Arguments(0))
				.DateLastModified);	
	WScript.Echo(
		d.getFullYear() + "-" +
		pad(d.getMonth() + 1) + "-" + 
		pad(d.getDate()) + "T" + 
		pad(d.getHours()) + ":" +
		pad(d.getMinutes()) + ":" +
		pad(d.getSeconds()) + "Z"
	);

	function pad(i){
		return i.toString().length == 1 ? ("0" + i) : i.toString()
	}
}
