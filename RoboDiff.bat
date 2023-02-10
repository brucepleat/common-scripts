@Echo Off
:: Purpose: To compare and help break down two paths to determine any differences

If NOT "%~4"=="" Goto :ShowUsage
If "%~3"=="" Goto :Compare2
If "%~2"=="" Goto :ShowUsage
If "%~1"=="" Goto :ShowUsage


Echo Comparing "%1:%~3" to "%2:%~3":
Call DirTotal /R "%1:%~3" | tee %temp%\%1.txt
Call DirTotal /R "%2:%~3" | tee %temp%\%2.txt
Diff %temp%\%1.txt %temp%\%2.txt
Goto :Done

:Compare2
Set _D=%~d1
Set _D=%_D:~0,1%
Set _S=%~d2
Set _S=%_S:~0,1%
Echo Comparing %~1 to %~2
Call DirTotal /R "%~1" > %temp%\%_D%.txt
Call DirTotal /R "%~2" > %temp%\%_S%.txt
Diff %temp%\%_D%.txt %temp%\%_S%.txt
Goto :Done

:ShowUsage
Echo Usage is either:
Echo %0 (firstdrive) (seconddrive) (path)
Echo Example: %0 D E \Movies
Echo - or -
Echo %0 (firstfullpath) (secondfullpath)
Echo Example: %0 D:\Movies E:\Movies
Exit /B 1

:Done
Exit /B 0
