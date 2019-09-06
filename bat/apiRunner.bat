@echo off
call cd C:\QaAutomation\Applications\CMS\HSS\API
call C:\QaAutomation\Utilities\apache-maven-3.5.4\bin\mvn test -Dtest=TestParallel

type NUL > done.txt
call echo f | xcopy /f /y done.txt C:\QaAutomation\Applications\CMS\HSS\inDir

exit