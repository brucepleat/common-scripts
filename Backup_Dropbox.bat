@Echo Off
If "%1" EQU "/?" Goto :Help
If "%1" EQU "-h" Goto :Help
If "%1" EQU "--help" Goto :Help
If "%1" EQU "" Goto :Help
Goto :Continue

:Help
Echo %0
Echo.
Echo This program automatically copies from %%Dropbox%% to the specified Drive(s)
Echo Parameters should be one or more drive letters (e.g., "D E F G")
Echo If folder exists off root (e.g., \Pictures), copy there, else copy to \Dropbox
Goto :EOF

:Continue
Cls
PushD %Dropbox%
"%Utils%\CygWin\bin\date.exe" +%%H:%%M:%%S

Echo ==== Cleaning Dropbox messes (desktop.ini and other junk files) ====
Call Cleanfast /Q >Nul: 2>Nul:

:Loop
REM Allows specifying multiple drive letters
If "%1" EQU "" Goto :Done
Echo.
Echo ==== %1
If Exist "%1:" (
  For /D %%A in ("%Dropbox%"\*) do (
    "%Utils%\CygWin\bin\date.exe" +%%H:%%M:%%S
    If Exist "%1:\%%~nxA" (
      Echo Call Robo to "%1:\%%~nxA"
      Call Robo "%Dropbox%\%%~nxA" "%1:\%%~nxA"
    ) Else (
      Echo Call Robo to "%1:\Dropbox\%%~nxA"
      Call Robo "%Dropbox%\%%~nxA" "%1:\Dropbox\%%~nxA"
    )
  )
) Else (
  Echo ==== **** %1 Does Not Exist **** ====
)
Shift
Goto :Loop

"%Utils%\CygWin\bin\date.exe" +%%H:%%M:%%S

:Done
PopD
:EOF
"%Utils%\CygWin\bin\date.exe" +%%H:%%M:%%S
Echo.
Echo ==== Don't forget to restart Dropbox ====
Echo.
Echo ==== Done ====

