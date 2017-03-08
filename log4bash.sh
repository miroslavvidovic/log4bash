#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      log4bash.sh
#   created:   14.08.2016.-11:13:42
#   revision:  08.03.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Forked from:
#     log4bash - Makes logging in Bash scripting suck less
#     http://github.com/fredpalmer/log4bash
# Requirements:
#   espeak, figlet
# Description:
#   Simple logger for bash scripts
# Usage:
#   Source the log4bash in your script and call the log functions
#
#   source "log4bash.sh"
#   log_error "Something bad happened"
#
# -----------------------------------------------------------------------------
# Script:

# Fail on first error
set -e

# Useful global variables that users may wish to reference
SCRIPT_ARGS="$@"
SCRIPT_NAME="$0"
SCRIPT_NAME="${SCRIPT_NAME#\./}"
SCRIPT_NAME="${SCRIPT_NAME##/*/}"
SCRIPT_BASE_DIR="$(cd "$( dirname "$0")" && pwd )"

# Determines if we print colors or not
if [ $(tty -s) ]; then
    readonly INTERACTIVE_MODE="off"
else
    readonly INTERACTIVE_MODE="on"
fi

if [[ "${INTERACTIVE_MODE}" == "off" ]]
then
    # Then we don't care about log colors
    declare -r LOG_DEFAULT_COLOR=""
    declare -r LOG_ERROR_COLOR=""
    declare -r LOG_INFO_COLOR=""
    declare -r LOG_SUCCESS_COLOR=""
    declare -r LOG_WARN_COLOR=""
    declare -r LOG_DEBUG_COLOR=""
else
    declare -r LOG_DEFAULT_COLOR="\033[0m"
    declare -r LOG_ERROR_COLOR="\033[1;31m"
    declare -r LOG_INFO_COLOR="\033[1m"
    declare -r LOG_SUCCESS_COLOR="\033[1;32m"
    declare -r LOG_WARN_COLOR="\033[1;33m"
    declare -r LOG_DEBUG_COLOR="\033[1;34m"
fi

# This function scrubs the output of any control characters used in colorized output
# It's designed to be piped through with text that needs scrubbing.  The scrubbed
# text will come out the other side!
prepare_log_for_nonterminal() {
    # Essentially this strips all the control characters for log colors
    sed "s/[[:cntrl:]]\[[0-9;]*m//g"
}

log() {
    local log_text="$1"
    local log_level="$2"
    local log_color="$3"

    # Default level to "info"
    [[ -z ${log_level} ]] && log_level="INFO"
    [[ -z ${log_color} ]] && log_color="${LOG_INFO_COLOR}"

    echo -e "${log_color}[$(date +"%Y-%m-%d %H:%M:%S %Z")] [${log_level}] ${log_text} ${LOG_DEFAULT_COLOR}"
    return 0;
}

log_info()      { log "$@"; }

# Using espeak on Linux
log_speak() {
    if type -P espeak >/dev/null
    then
        local easier_to_say="$1"
        espeak -ven+f3 -k5 -s150 "$1"
    fi
    return 0;
}

log_success()   { log "$1" "SUCCESS" "${LOG_SUCCESS_COLOR}"; }
log_error()     { log "$1" "ERROR" "${LOG_ERROR_COLOR}"; }
log_warning()   { log "$1" "WARNING" "${LOG_WARN_COLOR}"; }
log_debug()     { log "$1" "DEBUG" "${LOG_DEBUG_COLOR}"; }
log_captains()  {
    if type -P figlet >/dev/null;
    then
        figlet -f slant -w 120 "$1";
    else
        log "$1";
    fi

    log_speak "$1";

    return 0;
}

