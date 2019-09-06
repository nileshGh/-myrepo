@echo off

set gwenjsonreportDir=%1
set runCompareHome=C:\QaAutomation\Utilities\RunCompare
set AppDir=C:\QaAutomation\Applications\CMS\HSS

echo.
echo #########################################
echo copy all gwen generated json report
del /F /Q %runCompareHome%\toolxmlreport\*
copy %gwenjsonreportDir%\*.json %runCompareHome%\toolxmlreport\

echo.
echo #########################################
echo copy baseline for delta report if exists
del %runCompareHome%\report\baseline\*.csv
copy %AppDir%\run_comparison\baseline\*.csv %runCompareHome%\report\baseline

echo.
echo #########################################
echo Trigger run compare
cd %runCompareHome%
call RunCompare_Gwen.bat

echo.
echo #########################################
echo copy the generated artifacts in current run folder
for /d %%i in (%runCompareHome%\report\currentrun\*) do (
	echo [Path : %%i] [Name : %%~ni]
	rd /s /q %AppDir%\run_comparison\currentrun\%%~ni
	mkdir %AppDir%\run_comparison\currentrun\%%~ni
	xcopy /s /Y %runCompareHome%\report\currentrun\%%~ni\* %AppDir%\run_comparison\currentrun\%%~ni
)
cd %AppDir%\bat