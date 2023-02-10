@Echo Off
SetLocal DisableDelayedExpansion

:: Echo 0 %0 %*

:: Add any value to _D to debug
Set _D=

Set _R=
Set _T=
Set _P=

:: In the future, need to read a variable for default
:: Clear to the right of the equal to include hidden files/directories by default
:: Set _H=-H
Set _H=-H

:ParamLoop
If "%~1"=="" Goto :ExitParamLoop
If /I "%~1" EQU "/?" Goto :HelpMe
If /I "%~1" EQU "/R" (Set _R=/R) Else (
  If /I "%~1" EQU "/T" (
    Set _T=/T
  ) Else (
    Set _P=%~1
  )
)
If /I "%~1" EQU "/H" (Set _H=)
Shift
If "%~1" NEQ "" Goto :ParamLoop
:ExitParamLoop

:: ==== Main ====
If "!_P!"=="" (
  Set _P=%CD%
)

:: Echo Check: _R=%_R% // _T=%_T% // _P=%_P%
If "%_D%" NEQ "" Echo Check: _R=%_R% // _T=%_T% // _P=%_P%
Echo =="%_P%"==
If "%_P%" EQU "" (
  PushD "%CD%"
) Else (
  PushD "%_P%" >Nul: 2>Nul:
)
RD /s/q \$Recycle.Bin >Nul: 2>Nul:
If "%_D%" NEQ "" Echo 1

If "%_R%"=="/R" (

  If "%_D%" NEQ "" Echo 2

  If "%_D%" EQU "::" Echo Previous: For /D %%A in *
  If "%_D%" EQU "::" Echo Testing: For /F "delims=" %%A in 'dir /a%_H%/on/b'

  For /F "delims=" %%A in ('dir /ad%_H%/on/b') do (
    If "%_D%" NEQ "" Echo 3 / "%%A"
    If Not Exist "%%~A" (
      Echo Not Found: "%%~A"
    ) Else (
    PushD "%%A"
    For /F "tokens=1-4" %%B in ('Dir /a%_H%/s/on ^| tail -2 ^| head -1') do (
      Echo %%B	%%D	%%~A
    )
    )
    PopD
  )

  If "%_D%" NEQ "" Echo 4

  If "%_T%"=="/T" (
    If "%_D%" NEQ "" Echo 5

    For /F "tokens=1-4" %%B in ('Dir /a%_H%/s/on ^| tail -2 ^| head -1') do (
SETLOCAL enABLEDELAYEDEXPANSION
      Echo %%B	%%D	!CD!
SETLOCAL disABLEDELAYEDEXPANSION
    )
  )

  If "%_D%" NEQ "" Echo 6
) Else (
  If "%_R%" NEQ "/R" (
    If "%_D%" NEQ "" Echo 7 Not R
    If Not Exist "%CD%" (
      Echo Not Found: %CD%
    ) Else (

    For /F "tokens=1-4" %%B in ('Dir /a%_H%/s/on ^| tail -2 ^| head -1') do (
SETLOCAL enABLEDELAYEDEXPANSION
      Echo %%B	%%D	!CD!
SETLOCAL disABLEDELAYEDEXPANSION
    )
    )
  )
) 2>Nul:
If "%_D%" NEQ "" Echo 8
Goto :EOF

:HelpMe
Echo %0 [/R [/T] ] [folder]
Echo /R to run on each subdirectory
Echo /T to total (after running on a subdirectory)
Echo If no folder specified then run on current folder
Echo /H to Include Hidden Files
Goto :EOF


:EOF
PopD
EndLocal
