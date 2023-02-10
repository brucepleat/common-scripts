:: Check recursively for whether each file has a "*conflicted copy*"
:: If so, delete the "*conflicted copy*"

@For /R %%A in (*.*) Do @If Exist "%%~dpnA (*conflicted copy*)%%~xA" ( Echo %%~dpnA%%~xA & Del /f/q/a "%%~dpnA (*conflicted copy*)%%~xA" )

