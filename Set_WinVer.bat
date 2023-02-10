@Echo Off
SetLocal EnableExtensions DisableDelayedExpansion
for /F %%A in ('ver ^| cut -d "[" -f 2 ^| cut -d " " -f 2  ^| cut -d "." -f 1') do ((Set WinVer=%%A>Nul: 2>Nul:)& SetX /M WinVer %%A)
Echo WinVer=%WinVer%
If "%WinVer%" GEQ "10" ( Echo Win10+) Else (Echo Prior to Win10)

