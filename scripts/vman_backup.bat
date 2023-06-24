rem #######################################
rem VMan Backup/Restore Config v1.0 by Bilu
rem #######################################
rem Tool to retain VMan customizations through a RetroBat upgrade.

@echo off
set BASE=V:\RetroBat
set DRIVE=%~d0
if exist %BASE%\system\download\emulationstation.zip goto :quit
if exist %BASE%\system\download\EmulationStation-Win32.zip goto :quit
if not exist %BASE%\backup\vman\RetroBat\emulationstation\version.info goto :backup
FC %BASE%\emulationstation\version.info %BASE%\backup\vman\RetroBat\emulationstation\version.info >NUL && goto :backup || goto :restore

:backup
for %%I in (^ 
 %BASE%\emulationstation\version.info^
 %BASE%\system\padtokey\*.keys^
 %BASE%\emulationstation\.emulationstation\es_padtokey.cfg^
 %BASE%\emulationstation\.emulationstation\es_systems.cfg^
 %BASE%\emulationstation\.emulationstation\es_settings.cfg^
 %BASE%\emulators\supermodel\Config\supermodel.ini^
 %BASE%\system\es_menu\vman*.menu^
 %BASE%\system\es_menu\gamelist.xml^
 %BASE%\system\es_menu\media\vman*.png^
 ) do xcopy /Q /Y %%I %BASE%\backup\vman%%~pI > NUL
goto :quit

:restore
for %%I in (^ 
 %BASE%\emulationstation\version.info^
 %BASE%\system\padtokey\*.keys^
 %BASE%\emulationstation\.emulationstation\es_padtokey.cfg^
 %BASE%\emulationstation\.emulationstation\es_systems.cfg^
 %BASE%\emulationstation\.emulationstation\es_settings.cfg^
 %BASE%\emulators\supermodel\Config\supermodel.ini^
 %BASE%\system\es_menu\vman*.menu^
 %BASE%\system\es_menu\gamelist.xml^
 %BASE%\system\es_menu\media\vman*.png^
 ) do xcopy /Q /Y %%I %BASE%\backup\rb%%~pI > NUL

for %%I in (^ 
 %BASE%\emulationstation\version.info^
 ) do xcopy /Q /Y %%I %BASE%\backup\vman%%~pI > NUL
del /Q /F %BASE%\emulationstation\.emulationstation\video\retrobat-*.mp4 > NUL
rmdir /s /q %BASE%\emulationstation\.emulationstation\themes\es-theme-carbon > NUL
robocopy /NFL /NDL /NJH /NJS /nc /ns /np /S %BASE%\backup\vman %DRIVE%

:quit

