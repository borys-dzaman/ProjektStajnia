@echo off
SETLOCAL enabledelayedexpansion

REM ////////////////////////////////////////////////////////////
SET current_date_time=%date% %time%
call :IMPORTANT_ECHO "Time: %current_date_time%"

REM ////////////////////////////////////////////////////////////
for %%I in (.) do set current_dir_name=%%~nxI
call :IMPORTANT_ECHO "Directory: %current_dir_name%"

REM ////////////////////////////////////////////////////////////
CALL :NEW_LINE_ECHO
CALL :UNDERLINED_SECTION_ECHO "--- Current repository status... ---"
CALL :NEW_LINE_ECHO
CALL :BOLD_ECHO_AND_RUN "git status"
CALL :NEW_LINE_ECHO

REM ////////////////////////////////////////////////////////////
CALL :NEW_LINE_ECHO
CALL :UNDERLINED_SECTION_ECHO "--- Get the latest Github version of this repository... ---"
CALL :NEW_LINE_ECHO
git submodule init
git submodule update
git pull
git submodule foreach git pull origin HEAD:main
CALL :UNDERLINED_NOTE_ECHO "Doing git pull of the repository and all submodules"
CALL :NEW_LINE_ECHO


REM ////////////////////////////////////////////////////////////
CALL :NEW_LINE_ECHO
CALL :UNDERLINED_SECTION_ECHO "--- Current repository status... ---"
CALL :NEW_LINE_ECHO
CALL :BOLD_ECHO_AND_RUN "git status"
CALL :NEW_LINE_ECHO

REM ////////////////////////////////////////////////////////////
SET commit_message= :hammer: Update %current_dir_name% - %current_date_time%
SET /P commit_message=Enter your commit message:
echo  [104mCommit message set to: "%commit_message%"[0m
CALL :NEW_LINE_ECHO

@echo off

REM ////////////////////////////////////////////////////////////
CALL :NEW_LINE_ECHO
CALL :UNDERLINED_SECTION_ECHO "--- Push all changes from this repository to Github... ---"
CALL :NEW_LINE_ECHO

REM ////////////////////////////////////////////////////////
SETLOCAL
CALL :NEXT_COMMAND_ACTION_ECHO "Changing current directory to Documentation/Features"
cd Documentation/Features

CALL :BOLD_ECHO " - Pushing all changes from this directory to Github"
git add --all
git commit -m "%commit_message%"
git push origin HEAD:main

ENDLOCAL

REM ////////////////////////////////////////////////////////
SETLOCAL
CALL :NEXT_COMMAND_ACTION_ECHO "Changing current directory to Documentation/Models"
cd Documentation/Models

CALL :BOLD_ECHO " - Pushing all changes from this directory to Github"
CALL :BOLD_ECHO_AND_RUN "    git add --all"
echo [1m      git commit -m "%commit_message%"[0m  
git commit -m "%commit_message%"
CALL :BOLD_ECHO_AND_RUN "    git push origin HEAD:main"

ENDLOCAL

REM ////////////////////////////////////////////////////////

REM ////////////////////////////////////////////////////////

CALL :NEXT_COMMAND_ACTION_ECHO "Changing current directory to %current_dir_name%"
CALL :BOLD_ECHO " - Pushing all changes from this directory to Github"
CALL :BOLD_ECHO_AND_RUN "    git add --all"
echo [1m      git commit -m "%commit_message%"[0m  
git commit -m "%commit_message%"
CALL :BOLD_ECHO_AND_RUN "    git push origin HEAD:main"

REM Wait until key is pressed is the file was double clicked
REM ////////////////////////////////////////////////////////////
CALL :PAUSE_SCRIPT_IF_DOUBLE_CLICKED

REM ////////////////////////////////////////////////////////////

REM Set functions we are going to use
REM ////////////////////////////////////////////////////////////

REM Function BOLD_ECHO_AND_RUN display param 1 and run it
REM Use it like this: 
REM CALL :BOLD_ECHO_AND_RUN "COMMAND_TO_RUN"
REM %~1 means the first argument passes to the functions
REM [1m and other are ANSI Escape Sequences
REM ////////////////////////////////////////////////////////////
:BOLD_ECHO_AND_RUN
    echo [1m  %~1 [0m
    %~1
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:BOLD_ECHO
    echo [1m  %~1 [0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:GREEN_ECHO
    echo [92m  %~1 [0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:MAGENTA_ECHO
    echo [95m  %~1 [0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:UNDERLINED_SECTION_ECHO
    echo  [4m[92m%~1[0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:UNDERLINED_NOTE_ECHO
    echo   [4m[93m^^%~1[0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:NEW_LINE_ECHO
    echo.
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:NEXT_COMMAND_ACTION_ECHO
    echo   [96m^> %~1[0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:CYAN_ECHO
    echo [96m  %~1[0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:NEXT_COMMAND_EXPLANATION_ECHO
    echo   [0m - %~1[0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:IMPORTANT_ECHO
    echo   [7m%~1[0m
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:OPEN_PANEL_HELP_PAGE
    start "" %HELP_PAGE_URL%
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:IS_GITHUB_USER_EMAIL_SET
    SET github_user_email_value=
    git config user.email > git_config_check
    SET /p github_user_email_value= < git_config_check
    DEL git_config_check
    REM echo github_user_email_value: %github_user_email_value%
    IF DEFINED github_user_email_value (
        REM echo github_user_email_value is DEFINED
        SET %~1=TRUE
    ) ELSE (
        REM echo github_user_email_value is NOT DEFINED
        SET %~1=FALSE
    )
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:GET_GITHUB_USER_EMAIL_VALUE
    SET github_user_email_value=
    git config user.email > git_config_check
    SET /p github_user_email_value= < git_config_check
    DEL git_config_check
    CALL :MAKE_VARIABLE_SAFE github_user_email_value "%github_user_email_value%"
    REM echo github_user_email_value: %github_user_email_value%
    SET %~1=%github_user_email_value%
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:SET_GITHUB_USER_EMAIL
    REM It's a strange fact that you can commit from another persons name https://superuser.com/questions/816341/github-lets-me-commit-as-another-user/1234339. Please don't do this here
    SET /p github_user_email=What is your Github Email?:
    CALL :MAKE_VARIABLE_SAFE github_user_email "%github_user_email%"
    echo [1m  git config --global --replace-all user.email %github_user_email%[0m
    CALL :UNDERLINED_NOTE_ECHO "This is the user email we commit from"
    git config --global --replace-all user.email %github_user_email%
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:IS_GITHUB_USER_NAME_SET
    SET github_user_name_value=
    git config user.name > git_config_check
    SET /p github_user_name_value= < git_config_check
    DEL git_config_check
    REM echo github_user_name_value: %github_user_name_value%
    IF DEFINED github_user_name_value (
        REM echo github_user_name_value is DEFINED
        SET %~1=TRUE
    ) ELSE (
        REM echo github_user_name_value is NOT DEFINED
        SET %~1=FALSE
    )
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:GET_GITHUB_USER_NAME_VALUE
    SET github_user_name_value=
    git config user.name > git_config_check
    SET /p github_user_name_value= < git_config_check
    DEL git_config_check
    CALL :MAKE_VARIABLE_SAFE github_user_name_value "%github_user_name_value%"
    REM echo github_user_email_value: %github_user_name_value%
    SET %~1=%github_user_name_value%
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:SET_GITHUB_USER_NAME
    REM It's a strange fact that you can commit from another persons name https://superuser.com/questions/816341/github-lets-me-commit-as-another-user/1234339. Please don't do this here
    SET /p github_user_name=What is your Github Username?:
    CALL :MAKE_VARIABLE_SAFE github_user_name "%github_user_name%"
    echo [1m  git config --global --replace-all user.name %github_user_name%[0m
    CALL :UNDERLINED_NOTE_ECHO "This is the user name we commit from"
    git config --global --replace-all user.name %github_user_name%
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:PAUSE_SCRIPT_IF_DOUBLE_CLICKED
    SETLOCAL enabledelayedexpansion
        set current_call_line=%cmdcmdline:"=%
        REM echo current_call_line: %current_call_line%
        REM echo Current file is: %~nx0
        set current_call_line_without_file_name=!current_call_line:%~nx0=!
        REM echo current_call_line_without_file_name: %current_call_line_without_file_name%
        if not "%current_call_line%" == "%current_call_line_without_file_name%" pause
    ENDLOCAL
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:ASK_IF_USER_WANTS_HELP
    SET display_help=
    SET /p display_help=Skip help page with more info?(Y/N):
    IF NOT DEFINED display_help SET "display_help=y"
    REM echo You typed: %display_help%
    if /i %display_help%==n CALL :OPEN_PANEL_HELP_PAGE
EXIT /B 0

:MAKE_VARIABLE_SAFE
    SET variable_to_make_safe="%~2"
    REM echo variable_to_make_safe: %variable_to_make_safe%
    SET variable_to_make_safe_without_spaces=%variable_to_make_safe: =%
    REM echo variable_to_make_safe_without_spaces: %variable_to_make_safe_without_spaces%
    IF NOT %variable_to_make_safe%==%variable_to_make_safe_without_spaces% (
        REM echo variable HAVE spaces
        SET %~1="%~2"
    ) ELSE (
        REM echo variable DOESN'T HAVE spaces
        SET %~1=%~2
    )
EXIT /B 0

REM ////////////////////////////////////////////////////////////
:DISPLAY_IMAGE
    for /f "delims=: tokens=1*" %%A in ('findstr /b ":::%~1:::" "%~f0"') do (echo.%%B)
EXIT /B 0