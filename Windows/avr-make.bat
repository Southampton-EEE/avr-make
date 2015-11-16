@echo off
REM avr-make.bat - Quick and dirty script for compiling C for the Il Matto
REM George Brown 2015/11/16. Tested on Windows 7 with tools added to %path%.
REM Version RC 1

REM Exit code for program termination.
REM 0 = OK, 1 = Error, 2 = Warning, 3 = Other failure.
set exit=0

:compile

echo [ :) ] Compiling with AVR-GCC.
REM First compile to check for warnings.
avr-gcc -mmcu=atmega644p -DF_CPU=12000000 -Wall -Werror -Os %* -o temp.elf^
 >nul 2>&1

if NOT %ERRORLEVEL% EQU 0 (
    set warnings=1
) ELSE (
    SET warnings=0
)

REM Compile again to see if there are also errors.
avr-gcc -mmcu=atmega644p -DF_CPU=12000000 -Wall -Os %* -o temp.elf^
 >gcc.tmp 2>&1

if NOT %ERRORLEVEL% EQU 0 (
    set errors=1
) ELSE (
    SET errors=0
)

REM Depending on the output, proceed on the right path.
if %errors% EQU 1 (
    echo [ :( ] There was an error during compilation. See output below:
    echo.
    type gcc.tmp
    echo.
    echo [ :( ] Cannot Proceed. Exiting.
    set exit=2
    goto tidy
) ELSE (
    if %warnings% EQU 1 (
        echo [ :( ] There were warnings during compilation. See output below:
        echo.
        type gcc.tmp
        echo.
    )
)

:link
echo [ :) ] Linking with AVR-objcopy.
REM Link, then see if we get an error.
avr-objcopy -O ihex temp.elf temp.hex > obj.tmp 2>&1
if NOT %ERRORLEVEL% EQU 0 (
    echo [ :( ]  Linking failed. See output below:
    echo.
    type obj.tmp
    echo.
    echo [ :( ] Cannot continue, exiting.
    set exit=3
    goto tidy
)

:program
set /p retry=[ :) ] Put Il Matto in bootloader mode to download program and ^
press enter.
REM Loop to allow retries for downloading.
:program_loop
REM Attempt to download. Output is printed so the user can see the progress
REM in real time.
echo.
avrdude -c usbasp -p m644p -U flash:w:temp.hex
echo.
REM If there was an error, let the user try again if they wish.
if NOT %ERRORLEVEL% EQU 0 (
    choice /c QR /N /m "[ :( ] Download failed. [R]etry or [Q]uit."
    REM Note choice is weird, we must always go through errorlevels in decending
    REM order to avoid issues, and we musn't escape ERRORLEVEL in this case...
    REM Microsoft, please make this work in a even remotley sane way...
    if ERRORLEVEL 2 (
        goto program_loop
    )
    REM Otherwise quit.
    set exit=3
    w
)

echo [ :) ] Il Matto programmed successfully!

:tidy
REM Clear out the temp files we've used.
del temp.elf temp.hex gcc.tmp obj.tmp >nul 2>&1
exit /b %exit%