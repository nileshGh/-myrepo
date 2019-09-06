@echo off

setlocal ENABLEDELAYEDEXPANSION
set appdir=C:\QaAutomation\Applications\CMS\HSS
set utils=C:\QaAutomation\Utilities
set zipdir=%utils%\zip
set data=%appdir%\data
set outDir=%appdir%\outDir
set runcomparison=%appdir%\run_comparison

cd %appdir%

for /f "tokens=2 delims=," %%a in (' tasklist /fi "imagename eq cmd.exe" /v /fo:csv /nh ^| findstr /r /c:".*Allure[^,]*$"') do taskkill /pid %%a
for /d %%i in (reports_*) do (
  @if exist "%%i" (
    @set _variable=%%i
    %zipdir%\zip -r %appdir%\AllReports.zip !_variable!
    )
  )

REM Zipping Data
%zipdir%\zip -r %appdir%\data.zip %data%
%zipdir%\zip -r %appdir%\run_comparison.zip %runcomparison%

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

mkdir %appdir%\old_logs\%fullstamp%

move %appdir%\AllReports.zip %appdir%\old_logs\%fullstamp%

move %appdir%\data.zip %appdir%\old_logs\%fullstamp%

move %appdir%\run_comparison.zip %appdir%\old_logs\%fullstamp%

REM Deleting current reports
rmdir /S /Q %runcomparison%\currentrun
rmdir /S /Q %runcomparison%\run_comparison_report
del /s /f /q %outDir%\*

for /d %%i in (reports*) do (
  @if exist "%%i" (
    @set _variable=%%i
    rmdir /S /Q !_variable!
    )
  )
rmdir /S /Q  data
mkdir %runcomparison%\currentrun
mkdir %runcomparison%\run_comparison_report
mkdir data

xcopy /e /v test_setup\data\* data
type NUL > %appdir%\inDir\BACKUP.Done
endlocal
exit
