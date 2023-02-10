@Echo Off
Dir C:\ /a | find " free" | cut -c 24-999

Rem Delete many common cache folders
RD /s/q "%temp%" 2>Nul:
RD /s/q C:\Windows\Temp 2>Nul:
RD /s/q C:\Temp 2>Nul:
REM RD /s/q C:\$RECYCLE.BIN 2>Nul:
REM RD /s/q C:\Quarantine 2>Nul:
REM RD /s/q C:\Inet 2>Nul:
REM RD /s/q C:\AdaptivaCache 2>Nul:
RD /s/q "%ProgramData%\Temp" 2>Nul:
RD /s/q "%ProgramFiles%\Temp" 2>Nul:
RD /s/q "%ProgramFiles(x86)%\Temp" 2>Nul:
RD /s/q C:\Windows\assembly\NativeImages_v2.0.50727_32\Temp 2>Nul:
RD /s/q C:\Windows\assembly\NativeImages_v4.0.30319_32\Temp 2>Nul:
RD /s/q C:\Windows\assembly\Temp 2>Nul:
RD /s/q C:\Windows\assembly\Tmp 2>Nul:
REM RD /s/q C:\Dell 2>Nul:
REM RD /s/q C:\InetPub 2>Nul:
REM RD /s/q C:\Intel 2>Nul:
RD /s/q "%Dropbox%\Dell" 2>Nul:
RD /s/q "%Dropbox%\Custom Office Templates" 2>Nul:
RD /s/q "%Dropbox%\My Data Sources" 2>Nul:
RD /s/q "%Dropbox%\Videos" 2>Nul:
RD /s/q "%UserProfile%\temp" 2>Nul:
REM RD /s/q "%LOCALAPPDATA%\Google\Chrome\User Data\Crashpad" 2>Nul:
REM RD /s/q "%LOCALAPPDATA%\Google\Chrome\User Data\Default" 2>Nul:
REM RD /s/q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Service Worker" 2>Nul:
Rem Delete Temp folders for each user (if access permits, e.g., running as Admin)

PushD "%UserProfile%\.."
For /D %%A in (*) do ( rd /s/q "%%A\Appdata\local\temp" 2>Nul: )
PopD
If Exist "%Dropbox%\Quicken" (
  Del "%Dropbox%\Quicken\*.dat" 2>Nul:
)

Rem If Q then keep only most-recent Q backup
If "%1"=="/Q" (
  If Exist "%Dropbox%\Quicken" (
    Del "%Dropbox%\Quicken\*.dat" 2>Nul:
    RD /S/Q "%Dropbox%\Quicken\Logs" 2>Nul:
    For /F %%A in (' dir /a-d /b /o-d "%Dropbox%\Quicken\Backup" ^| tail --lines=+2 ') do Del "%Dropbox%\Quicken\Backup\%%A" >Nul: 2>Nul:
  )
)

Rem Delete Dropbox excess files (and Quicken excess)
If "%1"=="/D" (
  If Exist "%Dropbox%\Quicken" (
    Del "%Dropbox%\Quicken\*.dat" 2>Nul:
    For /F %%A in (' dir /a-d /b /o-d "%Dropbox%\Quicken\Backup" ^| tail --lines=+2 ') do Del "%Dropbox%\Quicken\Backup\%%A" >Nul: 2>Nul:
  )
REM  Del "%Dropbox%\.dropbox" /f/q/s/a-d >Nul: 2>Nul:
  Del "%Dropbox%\Desktop.ini" /f/q/s/a-d >Nul: 2>Nul:
) Else (
  Del "%Dropbox%\Desktop.ini" /f/q/s/a-d >Nul: 2>Nul:
)

Dir C:\ /a | find " free" | cut -c 24-999
