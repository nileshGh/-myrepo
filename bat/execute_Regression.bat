@echo off
call cd C:\QaAutomation\Applications\CMS\HSS
setlocal enabledelayedexpansion
echo %1
SET _test=%1%
SET runParallel=%3%
SET tag=%_test::=,%
set JUnitReportsFolder=reports_junit
set JasonReportsFolder=reports_json
echo %tag% %runParallel%
set y=
echo %2
set data=%2%
set x=
set reportfolder=
set result=0
set newdata=!%data::=,!
 echo !%data::=,!
 echo %newdata%
 for /f "tokens=1-5 delims=:" %%d in ("%time%") do set var=%date:~10,0%%date:~0,4%%date:~4,2%%date:~6,2%%date:~8,2%-%%d%%e%time:~-2%
		set datetimestr=%var: =0%
		set datetimestr=!%datetimestr:/=!
		echo %datetimestr%
for  %%i in (%newdata%) do (

  set  result=!x! BDD\features\%%i.feature
	set x=!result!
  rem echo !result!
  rem echo !x!
)
echo !x!
IF %runParallel% == true (
	IF %tag% == @all (
			echo "inside if"
			echo " ..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b --parallel -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties" !x!"
			call ..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b --parallel -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties" !x!
		) ELSE (
			echo "..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b --parallel -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties" -t %tag% !x!"
			call ..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b --parallel -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties" -t "%tag%" !x!*
		)		
		set reportfolder=%datetimestr%
	) ELSE (
		IF %tag% == @all (
			echo "inside if"
			echo " ..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b  -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties"  BDD\features\*%2*"
			call ..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b  -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties"  BDD\features\*%2*
		) ELSE (
			echo "..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b  -r reports -f "junit,json,tml"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties" -t %tag% BDD\features\*%2*"
			call ..\..\..\Utilities\GwenSetup\gwen-web-2.22.0\bin\gwen -b  -r reports -f "junit,json,html"  -p ".\BDD\properties\application.properties,.\BDD\properties\gwen.properties" -t "%tag%" BDD\features\*%2*
		)
		set reportfolder=%2
	)

IF NOT EXIST "%JUnitReportsFolder%" md "%JUnitReportsFolder%"
echo "here"
echo %reportfolder%
echo "here"
xcopy reports\junit\TEST-BDD* reports_junit
TIMEOUT 5
call cd reports_junit
FOR /R . %%F in (*.*) do call ..\bat\JREPL.BAT "timestamp" "timestmp2" /f "%%~nxF" /o -
call cd ..

IF NOT EXIST "%JasonReportsFolder%" md "%JasonReportsFolder%"

xcopy reports\json\BDD-* reports_json
TIMEOUT 5
move reports reports_%reportfolder%
TIMEOUT 5

REM trigger run compare : takes dir as an argument under which all json report should be present
call C:\QaAutomation\Applications\CMS\HSS\bat\TriggerRunCompare.bat C:\QaAutomation\Applications\CMS\HSS\reports_json

call cd C:\QaAutomation\Applications\CMS\HSS

call echo f | xcopy /f /y reports_%reportfolder%\junit\* inDir
call echo f | xcopy /f /y reports_%reportfolder%\*csv inDir
type NUL > reports_%reportfolder%\done.txt
call echo f | xcopy /f /y reports_%reportfolder%\done.txt inDir
rem call cd reports_%2
rem DEL done.txt
endlocal
exit

