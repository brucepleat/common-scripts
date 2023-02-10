@Echo Off

Log=%desktop%\PingLog

If Not Exist %Log% Md %Log%

setlocal enableextensions enabledelayedexpansion
  If Exist "%Log%\*.txt" del /F "%Log%\*.txt"

For %%N in (86 87) do ( 

  If Exist "%Log%\%%N.txt" del /F "%Log%\%%N.txt"
  If Exist "%Log%\%%N_Up.txt" del /F "%Log%\%%N_Up.txt"
  If Exist "%Log%\%%N_Down.txt" del /F "%Log%\%%N_Down.txt"

  for /L %%A in (1,1,254) do (
    set ipaddr=192.168.%%N.%%A
    if exist "%temp%\pinglog.tmp" del /f "%temp%\pinglog.tmp"
    ping -n 1 !ipaddr! >nul: 2>nul:
    ping -n 1 !ipaddr! | find "!ipaddr!" | find "TTL" | wc -l > "%temp%\pinglog.tmp"
    for /F %%E in (%temp%\pinglog.tmp) do If "%%E" == "1" (
      Echo !ipaddr! ++Up++
      Echo !ipaddr! ++Up++ >> "%Log%\%%N.txt"
      Echo !ipaddr! >> "%Log%\%%N_Up.txt"
    ) Else (
      Echo !ipaddr! --Down--
      Echo !ipaddr! --Down-- >> "%Log%\%%N.txt"
      Echo !ipaddr! >> "%Log%\%%N_Down.txt"
    )
  )
)
Goto :EOF

:EOF
EndLocal
