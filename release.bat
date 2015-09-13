@echo off
rem --------------------------------------------------------------------
rem Release vims setting script in windows.
rem 
rem Version: 0.0.0
rem Author: Shohei Mukai
rem Licence: MIT Licence
rem --------------------------------------------------------------------
rem :: Remain works::
rem     * Set http request command.
rem     * If not exist http command request, not moving some
rem       NeoBundle.
rem --------------------------------------------------------------------

rem Set variable data.
set CUR_DIR=%~dp0
set HOME_DIR=%HOMEPATH%
set TODAY=%date:~0,4%%date:~5,2%%date:~8,2%
set NOW=%TODAY%%time:~0,2%%time:~3,2%%time:~6,2%

rem Backup vim files.
set BACKUP_DIR=%HOME_DIR%.vim-backup
if not exist %BACKUP_DIR% (
  cd %HOME_DIR%
  mkdir .vim-backup
  cd %CUR_DIR%
)

rem Backup vimrc script.
if exist %HOME_DIR%\_vimrc (
  copy %HOME_DIR%\_vimrc %HOME_DIR%\.vim-backup\_vimrc%NOW%
)

rem Backup gvimrc script.
if exist %HOME_DIR%\_vimrc (
  copy %HOME_DIR%\_gvimrc %HOME_DIR%\.vim-backup\_gvimrc%NOW%
)

rem Copy vimrc.
copy %CUR_DIR%vimrc %HOME_DIR%\_vimrc

rem Copy gvimrc.
copy %CUR_DIR%gvimrc %HOME_DIR%\_gvimrc

rem Copy vimrc.cnf(need confirm).
set /P IS_COPY="Copy cnf? [Y]: "
echo %IS_COPY%
if "%IS_COPY%"=="Y" (
  copy %CUR_DIR%vimrc.cnf %HOME_DIR%\.vimrc.cnf
)
