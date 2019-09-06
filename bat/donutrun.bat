@echo off

setlocal ENABLEDELAYEDEXPANSION
set appdir=C:\QaAutomation\Applications\CMS\HSS
set utils=C:\QaAutomation\Utilities
set zipdir=%utils%\zip
call cd %appdir%
%zipdir%\zip -r %appdir%\reports_junit.zip reports_junit
%zipdir%\zip -r %appdir%\reports_json.zip reports_json
TIMEOUT 5
call echo f | xcopy /f /y reports_junit.zip inDir
call echo f | xcopy /f /y reports_json.zip inDir
TIMEOUT 5
DEL reports_json.zip
DEL reports_junit.zip
TIMEOUT 5
type NUL > %appdir%\done.txt
call cd %appdir%
call echo f | xcopy /f /y done.txt inDir
DEL done.txt

endlocal
exit