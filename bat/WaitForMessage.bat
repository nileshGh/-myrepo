@echo off
set filePath=%1
set fileName=%2
set modeOfOperation=%3
set timeOutInSec=%4
set newFileName=%5
set moveToPath=%6
set newest=
set counter=1
set /A retryTime=%timeOutInSec%/10

rem echo "File Path Is: %filePath%"
rem echo "File Name Is: %fileName%"
rem echo "File absoulte path Is: %filePath%\%fileName%"
rem echo "Mode of Operation is: %modeOfOperation%"


:loopStart
for /f "tokens=*" %%G in ('dir %filePath%\%fileName% /b /a-d /od') do (SET newest=%%G)
if "%newest%" == "" (
	echo "Waiting for the file...."
	set /A "counter=counter+1"
	waitfor SomethingThatIsNeverHappening /t %retryTime% 2>NUL
	if %counter% == 10 (
		echo "Timeout while waiting exit abruptly...."
		exit 2
	)
	goto loopStart
)

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

if "%modeOfOperation%" == "RENAME" (
	if "%newFileName%" == "APPEND_TS" (
		move %newest% %filePath%\%newest%_%fullstamp%
	) else (
		move %newest% %filePath%\%newFileName%
	)
)

if "%modeOfOperation%" == "MOVE" (
move %filePath%\%newest% %moveToPath%\%newest%
)

if "%modeOfOperation%" == "MOVE_THEN_RENAME" (
	if "%newFileName%" == "APPEND_TS" (
		move %filePath%\%newest% %moveToPath%\%newest%_%fullstamp%
	) else (
		move %filePath%\%newest% %moveToPath%\%newFileName%
	)
)

exit