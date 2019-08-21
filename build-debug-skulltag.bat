@echo off
if not exist "temp" mkdir temp
if not exist "temp\acs" mkdir temp\acs
if not exist "temp\acs\acs" mkdir temp\acs\acs
if not exist "output" mkdir output
utility\mcpp "ACS source\RGH_ACS.acs" -o temp\acs\processed.acs -D SKULLTAG -D IgnoreHash(x)=x -D DEBUG -P
echo ==============================================================
utility\zmp -d decorate -a "temp\acs\processed.acs" -o temp\acs\zmp_processed.acs -p data/decorate.txt -m skulltag -l RGH_ACS
if not errorlevel 0 (
	pause
	exit
)
echo ==============================================================
utility\acc temp\acs\zmp_processed.acs temp\acs\acs\RGH_ACS

if exist "temp\acs\acs.err" (
    echo ==============================================================
    move /y temp\acs\acs.err acs_errors.log	
    pause
) else (
    move /y temp\acs\acs\RGH_ACS.o temp\acs\acs\RGH_ACS

    cd data
    ..\utility\7z u ..\temp\RGH-debug-skulltag.pk3 * -xr!.svn  -mx0
    cd ..\temp\acs
    ..\..\utility\7z u ..\..\temp\RGH-debug-skulltag.pk3 acs\RGH_ACS -mx0
    cd ..\..
    skulltag temp/RGH-debug-skulltag.pk3
    exit
)
