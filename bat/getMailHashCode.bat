@echo off
set test="TCA1,Fail,397442,0,Account Name: <b>HPFGBPAC2</b>,"
set test1=%1%
for /f "tokens=4 delims=," %%F in (%test1%) do @echo %%F