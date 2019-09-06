@echo off

SET donutPath=C:\QaAutomation\Utilities\ReportFramework\
SET jsonReportsFolder=C:\QaAutomation\Applications\CMS\HSS\reports_json\
SET reportPath=C:\QaAutomation\Applications\CMS\HSS\reports_donut\

echo "java -jar %donutPath%\donut-0.0.1-one-jar.jar -s %jsonReportsFolder%"

java -jar %donutPath%\donut-0.0.1-one-jar.jar -o %reportPath% -s %jsonReportsFolder%


TIMEOUT 5
type NUL > %reportPath%\done.txt
call cd %reportPath%
call echo f | xcopy /f /y done.txt ..\inDir
DEL done.txt
exit





