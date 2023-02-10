@Echo Off

For /F "tokens=* usebackq" %%V in ( ` wmic os get version ^| find "." ^| cut -f 1 -d "." ` ) do Set WinVer=%%V
