@echo off
call cd C:\QaAutomation\Applications\CMS\HSS

echo %1
call echo f | xcopy /f /y fromCashflows\*%1* cashFlow\inDir
