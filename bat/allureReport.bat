@echo off

title Allure

SET allurePath=C:\QaAutomation\Utilities\ReportFramework\allure-2.5.0\bin
SET junitReportsFolder=C:\QaAutomation\Applications\CMS\HSS\reports_junit\
SET reportPath=C:\QaAutomation\Applications\CMS\HSS\reports_allure\

rem taskkill /fi "Allure"

echo %allurePath%
call cd %allurePath%

call %allurePath%\allure.bat generate --clean -o %reportPath%  %junitReportsFolder%

timeout 10
type NUL > %reportPath%\done.txt
call cd %reportPath%
call echo f | xcopy /f /y done.txt ..\inDir
DEL done.txt

rem call %allurePath%\allure.bat serve %reportPath%
call %allurePath%\allure.bat open -p 54999 %reportPath% 


exit






