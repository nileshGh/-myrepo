set reports_junit="C:\QaAutomation\Applications\CMS\HSS\reports_junit"

call cd %reports_junit%

FOR /R . %%F in (*.*) do call ..\bat\JREPL.BAT "timestamp" "timestmp2" /f "%%~nxF" /o -
call cd ..