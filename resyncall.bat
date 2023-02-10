@Echo Off


:: Assumes authoritiative: P: for these, and does NOT update S
For %%F in (Pictures Music) Do For %%D in ( D E F G H I J K L M N O Q R S T U V W X Y Z ) Do If Exist "%%D:\%%~F" (
  If "%%1" NEQ "/S" (
    Call Robo "P:\%%~F" "%%D:\%%~F" & Flush_NT_Cache -R %%D
  ) Else (
    Start ( Call Robo "P:\%%~F" "%%D:\%%~F" & Flush_NT_Cache -R %%D )
  )
)
:: Assumes authoritiative: S: for these, and does NOT update P
For %%F in (Movies "TV series" "Latest Music" "Latest Movies" "Latest TV Series" _TooBigToDropbox) Do For %%D in ( D E F G H I J K L M N O Q R T U V W X Y Z ) Do If Exist "%%D:\%%~F" (
  If "%%1" NEQ "/S" (
    Call Robo "S:\%%~F" "%%D:\%%~F" & Flush_NT_Cache -R %%D
  ) Else (
    Start ( Call Robo "S:\%%~F" "%%D:\%%~F" & Flush_NT_Cache -R %%D )
 )
)
:: Future:
:: Sync to P (why?) and then from P to another drive (doing it now?), then from that drive to other drives
:: Decide how to handle Software, Dropbox, RPi, and other key folders
Flush_NT_Cache -R
