@Echo Off
SetLocal EnableDelayedExpansion
Set _List=
If "%1" == "/L" (
  Set _List=/L
  Shift
)
If "%1" == "/?" Goto :Help
If "%1" == "-h" Goto :Help
If "%1" == "--help" Goto :Help
If NOT "%1" EQU "" Goto :CheckDrive

For %%A in (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) Do (
  Call :CheckDrive %%A:
  If "%ERRORLEVEL%" == "0" (
    Set _AllDrives=!_AllDrives!!_Drive!
    If "%_List%" == "/L" If Exist %%A: Echo %%A
  )
)
Set Drives=!_AllDrives:~1,99!
Set _AllDrives=
Set _Drive=
If NOT "%_List%" == "/L" %Utils%\CygWin\bin\Echo.exe !Drives!
Set Drives=!Drives!
Set _List=
Goto :EOF

:CheckDrive
Set ErrorLevel=
Set _Drive=
If Exist "%1" (
  Set _Drive=%1
  Set _Drive= !_Drive:~0,1!
  Set ERRORLEVEL=0
  Exit /B 0
) Else (
  Set ERRORLEVEL=1
  Set _Drive=
  Exit /B 1
)
Exit /B

:Help
Echo %0 [Drive]
Echo If no drive specified then check all (A-Z), else check drive
Echo If "/L" then break into lines
Echo Example:
Echo %0 C:

:EOF
Exit /B 0
