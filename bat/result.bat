@echo off
setlocal

set "first="
set "last="

for /f "skip=1 usebackq delims=\q" %%I in ("C:\QaAutomation\Applications\CMS\HSS\reports\CompareSheets_Report.csv") do (
    if not defined first set "first=%%~I"
    set "last=%%~I"
)

echo %last%
