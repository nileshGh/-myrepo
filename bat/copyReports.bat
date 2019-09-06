@echo off
call cd C:\QaAutomation\Applications\CMS\HSS
call echo f | xcopy /f /y reports\junit\* inDir
type NUL > reports\done.txt
call echo f | xcopy /f /y reports\done.txt inDir
