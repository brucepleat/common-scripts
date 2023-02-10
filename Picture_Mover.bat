@Echo Off

PushD "%Dropbox%\Camera Uploads"
:: Best to start in "Camera Uploads" folder

:: To be done:
:: Check if already in Pictures folder, and abort!!!
:: In PS file
:: - need to recurse subdirectories
:: - need to rename ONLY pics, not directories
:: - need to not rename files without dated filenames (e.g., "fluffy.jpg")
:: - - eventually date-rename (e.g., "fluffy.jpg" to "2018-01-01 01.01.01 fluffy.jpg")


SetLocal
Set nowyear=%date:~0,4%
Set /A wasyear=%nowyear%-10

:: Call Renamer before moving
powershell "%dropbox%\utils\Picture_Renamer.ps1"

:LoopYear
:: Echo %wasyear%
:: echo %nowyear%
For /L %%Y in (%wasyear%,1,%nowyear%) do (
::   Echo %%Y
  Call :LoopMonth
)
EndLocal
Goto :Done

:LoopMonth
:: Echo In LoopMonth with %%Y
  For /L %%M in (1,1,12) do (
    if %%M GEQ 10 (
        Set Src=%%Y-%%M
        Set Dest=%%Y\%%Y%%M
        Call :Mover
      ) Else (
        Set Src=%%Y-0%%M
        Set Dest=%%Y\%%Y0%%M
        Call :Mover
      )
    )
  )
)
Goto :EOF

:Mover
If Exist %Src%-* (
Rem  Echo Moving %Src%-* to %Dest%
  Md "%dropbox%\Pictures\All\%Dest%" 2>Nul:
  Echo Moving %Src%-* to %dropbox%\Pictures\All\%Dest%
  Move %Src%-* "%dropbox%\Pictures\All\%Dest%"
) Else (
Rem  Echo No %Src%-* files to move to %Dest%
)
Goto :EOF

:Done
For %%D in (D E F G H I J K L M N O Q R S T U V W X Y Z) do (
  If Exist "%%D:\Pictures" (
    If Not Exist "%%D:\Camera Uploads" (
      Robo "%Dropbox%\Pictures" "%%D:\Pictures"
    )
  )
)
Goto :EOF

:EOF
PopD
