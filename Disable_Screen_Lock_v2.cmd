@Echo Off

:: Copy this file to the startup folder!
If Not Exist "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\%0" (
  Copy "%~dpnx0" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\%0" >Nul: 2>Nul:
)

:: Create the PS Script to run
If Exist "%Temp%\%0.ps1" Del /F "%Temp%\%0.ps1"

Echo Set-StrictMode -version 3.0>> "%Temp%\%0.ps1"
Echo $Signature = @'>> "%Temp%\%0.ps1"
Echo [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]>> "%Temp%\%0.ps1"
Echo public static extern uint SetThreadExecutionState(uint esFlags);>> "%Temp%\%0.ps1"
Echo '@>> "%Temp%\%0.ps1"
Echo.>> "%Temp%\%0.ps1"
Echo $ES_AWAYMODE_REQUIRED = 0x00000040L>> "%Temp%\%0.ps1"
Echo $ES_CONTINUOUS        = 0x80000000L>> "%Temp%\%0.ps1"
Echo $ES_DISPLAY_REQUIRED  = 0x00000002L>> "%Temp%\%0.ps1"
Echo $ES_SYSTEM_REQUIRED   = 0x00000001L>> "%Temp%\%0.ps1"
Echo.>> "%Temp%\%0.ps1"
Echo $Kernel32 = Add-Type -MemberDefinition $Signature -Name 'Kernel32' -Namespace 'Kernel32' -PassThru>> "%Temp%\%0.ps1"
Echo.>> "%Temp%\%0.ps1"
Echo echo "Close the window to allow sleep again.">> "%Temp%\%0.ps1"
Echo.>> "%Temp%\%0.ps1"
Echo $result = $Kernel32::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_DISPLAY_REQUIRED -bor $ES_SYSTEM_REQUIRED)>> "%Temp%\%0.ps1"
Echo.>> "%Temp%\%0.ps1"
Echo While ($true) {>> "%Temp%\%0.ps1"
Echo   Start-Sleep (60 * 60 * 24)  # 24 hours.>> "%Temp%\%0.ps1"
Echo }>> "%Temp%\%0.ps1"

:: Run it!
If Exist "%Temp%\%0.ps1" Start /MIN PowerShell "%Temp%\%0.ps1"

