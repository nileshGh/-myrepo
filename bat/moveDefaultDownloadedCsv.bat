@echo off
set data_folder=%1
set module_name=%2
set exportname=%3
set newest=
set counter=0


if not exist "%data_folder%\%module_name%\download_dir" (
	waitfor SomethingThatIsNeverHappening /t 5 5>NUL
)

cd %data_folder%\%module_name%\download_dir

:loopStart
for /f "tokens=*" %%G in ('dir *.csv /b /a-d /od') do (SET newest=%%G)
if "%newest%" == "" (
	set /A "counter=counter+1"
	rem echo "%counter%"
	rem timeout /t 2
	waitfor SomethingThatIsNeverHappening /t 2 2>NUL
	if %counter% == 5 (
		goto break
	)
	goto loopStart
)
:break

rename "%newest%" %exportname%
move %exportname% %data_folder%\%module_name%\actual
