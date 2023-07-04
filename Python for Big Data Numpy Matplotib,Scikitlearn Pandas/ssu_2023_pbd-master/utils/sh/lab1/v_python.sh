#!/usr/bin/env bash

set -u;
#set -x;
#set -e

S1="#"
S2="="

_run_cmd() {
    local cmd=$1
    echo "$cmd"
    _print_line "$S2"
    eval "$cmd"
}

_print_line() {
    local S=${1:-}
        printf "%0.s${S}" {1..80}
    echo
}

_print_msg() {
    local msg=$1
    local S1=${2:-""}
    local S2=${3:-""}

    echo
    [ -n "$S1" ] && _print_line "$S1"
    [ -n "$msg" ] && echo -e "$msg"
    [ -n "$S2" ] && _print_line "$S2"
}

_check() {
    _print_msg "Check Python version..." =
    _run_cmd "python3 --version"
    _print_msg "Check PIP version..." =
    _run_cmd "pip3 --version"
}

_install_check() {
    local V=$1
    echo
    _print_line "="
    if [ -z "$V" ]
    then
        _print_msg "System Version:" $S1 $S1
        _check
    else
        local DN_VENV=venv${V}
        local PYTHON3=python${V}

        _print_msg "Virtualenv $DN_VENV:" $S1 $S1

        _print_msg "Install ..." $S2
        _run_cmd "virtualenv ${DN_VENV} -p ${PYTHON3}"

        _print_msg "Activate ..." $S2
        _run_cmd "source ${DN_VENV}/bin/activate"

        _check

        _print_msg "Deactivate ..." $S2
        _run_cmd "deactivate"
    fi
}

_install_check ""
_install_check "3.8"
_install_check "3.10"
