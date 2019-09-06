@echo off

set runCompareHome=C:\QaAutomation\Utilities\RunCompare
set AppDir=C:\QaAutomation\Applications\CMS\HSS

echo.
echo #########################################
echo deleting old copies of current run in %runCompareHome%
rd /s /q %runCompareHome%\report\currentrun\
mkdir %runCompareHome%\report\currentrun\

echo.
echo #########################################
echo copying current run module wise report to %runCompareHome%\report\currentrun\
xcopy /s /Y %AppDir%\run_comparison\currentrun %runCompareHome%\report\currentrun

echo.
echo #########################################
echo Executing consolidate run compare
cd %runCompareHome%
call RunConsolidateReport.bat

echo.
echo #########################################
echo Copying generated report in %AppDir%\run_comparison\run_comparison_report
del %AppDir%\run_comparison\run_comparison_report\*.csv
copy %runCompareHome%\report\consolidated\*.csv %AppDir%\run_comparison\run_comparison_report

echo.
echo #########################################
echo Copying generated report and sending it to linux driver machine
cd %runCompareHome%\report\consolidated
copy *.csv %AppDir%\inDir

echo.
echo #########################################
echo Sending notification to linux machine of completion
echo > Consolidated_Run_Compare.Done
move Consolidated_Run_Compare.Done %AppDir%\inDir

type NUL > C:\QaAutomation\Applications\CMS\HSS\inDir\done.txt
echo.
echo #########################################
echo Completed

exit