@Echo Off
If "%1"=="D" Goto :D
SFC /ScanNow
:D
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
Call Beep
