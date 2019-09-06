@echo off
set dir_path=%1

IF NOT EXIST %dir_path% (
  mkdir %dir_path%
)
del %dir_path%\*.csv
