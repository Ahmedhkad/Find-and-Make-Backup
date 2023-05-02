@echo off&cls

@REM Files to backup
set sources[0]="..\secrets.ini"
set sources[1]="..\secret.h"
 
@REM loop 2 times from 0 to 1 (0,1,3) mean 4 times 
for /L %%a in (0,1,1) do (call echo %%sources[%%a]%%
    for /f "delims=" %%i in ('dir /s /b /a-d %%sources[%%a]%%') do (
        echo ORGINAL----------: %%i 
        mkdir -p "madedir%%~pi"
        copy "%%i" "madedir%%~pi"
    )
)

@REM get date and time to genrate file name
for /f "tokens=2 delims==" %%V in ('wmic OS Get localdatetime /value') do set "dt=%%V"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo fullstamp: "%fullstamp%"

tar.exe -a -c -f "Backup_%fullstamp%".zip madedir\*

RD /S /Q .\madedir
RD /S /Q .\-p