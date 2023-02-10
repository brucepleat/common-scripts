@Echo Off

REM Used to care about Win10 but not anymore

If "%~1"=="" Goto :Help
If "%~2"=="" Goto :Help
If "%~1"=="/?" Goto :Help
If "%~1"=="-h" Goto :Help
If "%~1"=="--help" Goto :Help
If NOT "%~3"=="" Goto :Help
Goto :Continue

:Help
Echo From: "%~1"
Echo Dest: "%~2"
Call Beep
Goto :EOF

:Continue
"%Utils%\CygWin\bin\date.exe" +%%H:%%M:%%S

REM Call WinVer.bat
:: /XO /XN /MT:128 
REM If "%WinVer%"=="10" (
  Echo Robocopy /J /ETA /DST /XJ /IT /NJH /Mir /R:3 /W:5 /TBD /COPY:DT /DCOPY:D /xo /xn "%~1" "%~2" /XF desktop.ini /W:1 /r:0
       Robocopy /J /ETA /DST /XJ /IT /NJH /Mir /R:3 /W:5 /TBD /COPY:DT /DCOPY:D /xo /xn "%~1" "%~2" /XF desktop.ini /W:1 /r:0 
REM ) Else (
REM  Echo Need to retune Robocopy for non-Win10
REM  Echo Robocopy /XN /J /ETA /DST /Purge /S /xo /xn "%~1" "%~2" /xo /xn
REM       Robocopy /XN /J /ETA /DST /Purge /S /xo /xn "%~1" "%~2" /xo /xn
)
"%Utils%\CygWin\bin\date.exe" +%%H:%%M:%%S
Call Beep
Goto :EOF

:EOF
