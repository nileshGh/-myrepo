@echo off
setlocal

set comparesheetname=%1
set "first="
set "last="

If Not Exist "C:\QaAutomation\Applications\CMS\HSS\reports\%comparesheetname%.csv" (
	timeout 5
)
If Not Exist "C:\QaAutomation\Applications\CMS\HSS\reports\%comparesheetname%.csv" (
	timeout 5
)

for /f "skip=1 usebackq delims=\q" %%I in ("C:\QaAutomation\Applications\CMS\HSS\reports\%comparesheetname%.csv") do (
    if not defined first set "first=%%~I"
    set "last=%%~I"
)

echo %last%
