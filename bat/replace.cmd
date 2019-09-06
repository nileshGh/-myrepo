@echo off
setlocal enabledelayedexpansion

if not exist "%1" (echo this file does not exist...)&goto :eof

set /p findthis=find this text string:
set /p replacewith=and replace it with this:


for /f "tokens=*" %%a in (%1) do (

   set write=%%a
   if %%a==%findthis% set write=%replacewith%

   echo !write! 
   echo !write! >>%~n1.replaced%~x1
)