@Echo Off

:: Can specify one drive letter to be skipped

For %%F in (
Movies
"TV series"
Music
Pictures
Software
"Latest Movies"
_TooBigToDropbox
Dropbox
) Do (
  Echo ======= %%~F =======
  for %%D in ( P S D E F G H I J K L M N O Q R T U V W X Y Z ) do (
    If "%%D" NEQ "%1" (
      If Exist "%%D:\%%~F" (
          ( If "%%D" == "P" (Del "%%D:\%%~F\desktop.ini" /f/q/s/a >Nul: 2>Nul: ) )
          ( Call DirTotal "%%D:\%%~F" |find "," )
      ) Else ( Shift )
    )
  )
  Echo.
)

Call Beep
