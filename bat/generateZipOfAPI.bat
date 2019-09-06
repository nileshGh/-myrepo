@echo off

setlocal ENABLEDELAYEDEXPANSION
set appdir=C:\QaAutomation\Applications\CMS\HSS\API
set utils=C:\QaAutomation\Utilities
set zipdir=%utils%\zip
call cd %appdir%
%zipdir%\zip -r %appdir%\reports_json.zip target\surefire-reports
TIMEOUT 5
call echo f | xcopy /f /y reports_json.zip C:\QaAutomation\Applications\CMS\HSS\inDir
TIMEOUT 5
DEL reports_json.zip
TIMEOUT 5
type NUL > %appdir%\done.txt
call cd %appdir%
call echo f | xcopy /f /y done.txt C:\QaAutomation\Applications\CMS\HSS\inDir
DEL done.txt

endlocal
exit