for /f "tokens=2 delims=," %%a in (' tasklist /fi "imagename eq cmd.exe" /v /fo:csv /nh ^| findstr /r /c:".*Allure[^,]*$"') do taskkill /pid %%a