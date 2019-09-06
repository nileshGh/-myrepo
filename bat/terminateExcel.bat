@echo off
tasklist | find /i "EXCEL.exe" && taskkill /im EXCEL.exe /F || echo process "EXCEL.exe" not running.
