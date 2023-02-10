@Echo Off
SetLocal

:: Clock in START_TIME
set START_TIME=%TIME%


:: Do process here!

:: Clock in END_TIME
set END_TIME=%TIME%

:: Now that the timestamps are recorded,
:: Fix possible bug where 08 and 09 are treated erroneously from octal conversion
:: Set START_TIMESTAMP as the number of seconds so far today
if %START_TIME:~0,1% EQU 0 (set /a START_TIMESTAMP=%START_TIME:~1,1%*3600) ELSE (set /a START_TIMESTAMP=%START_TIME:~0,2%*3600)
if %START_TIME:~3,1% EQU 0 (set /a START_TIMESTAMP=%START_TIMESTAMP%+%START_TIME:~4,1%*60) ELSE (set /a START_TIMESTAMP=%START_TIMESTAMP%+%START_TIME:~3,2%*60)
if %START_TIME:~6,1% EQU 0 (set /a START_TIMESTAMP=%START_TIMESTAMP%+%START_TIME:~7,1%) ELSE (set /a START_TIMESTAMP=%START_TIMESTAMP%+%START_TIME:~6,2%)
:: Set END_TIMESTAMP as the number of seconds so far today
if %END_TIME:~0,1% EQU 0 (set /a END_TIMESTAMP=%END_TIME:~1,1%*3600) ELSE (set /a END_TIMESTAMP=%END_TIME:~0,2%*3600)
if %END_TIME:~3,1% EQU 0 (set /a END_TIMESTAMP=%END_TIMESTAMP%+%END_TIME:~4,1%*60) ELSE (set /a END_TIMESTAMP=%END_TIMESTAMP%+%END_TIME:~3,2%*60)
if %END_TIME:~6,1% EQU 0 (set /a END_TIMESTAMP=%END_TIMESTAMP%+%END_TIME:~7,1%) ELSE (set /a END_TIMESTAMP=%END_TIMESTAMP%+%END_TIME:~6,2%)

:: Work out the elapsed time expressed in seconds
:: Do the correct calculation to account for roll-over
:: (assumes the whole elapsed time is always less than 24 hours)
IF %END_TIMESTAMP% GEQ %START_TIMESTAMP% (
SET /a ELAPSED_TIME=%END_TIMESTAMP% - %START_TIMESTAMP%
) ELSE (
:: ELSE IF %END_TIMESTAMP% LSS %START_TIMESTAMP% (
SET /a ELAPSED_TIME=%END_TIMESTAMP% + 86400 - %START_TIMESTAMP%
)

:: Split elapsed time into hours, minutes and seconds
SET /a ELAPSED_HOURS=%ELAPSED_TIME% / 3600
SET /a ELAPSED_MINUTES=(%ELAPSED_TIME% - (%ELAPSED_HOURS% * 3600)) / 60
SET /a ELAPSED_SECONDS=%ELAPSED_TIME% - (%ELAPSED_HOURS% * 3600) - (%ELAPSED_MINUTES% * 60)

:: The following could be piped to a log file, if required
echo.
ECHO Process took %ELAPSED_HOURS% hours, %ELAPSED_MINUTES% minutes, and %ELAPSED_SECONDS% seoonds.

:: Tidy up
SET START_TIME=
SET END_TIME=
SET START_TIMESTAMP=
SET END_TIMESTAMP=
SET ELAPSED_TIME=
SET ELAPSED_HOURS=
SET ELAPSED_MINUTES=
SET ELAPSED_SECONDS=

EndLocal
