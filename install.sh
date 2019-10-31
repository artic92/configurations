#!/bin/bash

####################################################
#                  install.sh                      #
#           written by Antonio Riccio              #
#          antonio.riccio.27@gmail.com             #
#                                                  #
#  Installs the basic software required for a      #
#  Linux workstation                               #
#  ----------------------------------------------- #
#  Tested on Xubuntu-1804-LTS and macOS            #
#  ----------------------------------------------- #
####################################################

source library.sh

###################################################
#  manual settings
###################################################
CONFIGURE_GIT=1
CONFIGURE_VIM=1
CONFIGURE_BASH=1
CONFIGURE_SSH=1
CONFIGURE_GDB=1
CONFIGURE_TERMINATOR=1
CONFIGURE_FILEZILLA=1
CONFIGURE_GO=1
CONFIGURE_VSCODE=1
CONFIGURE_THIS_USER_AS_SUDO=0

####################################################
#  MAIN script starts here
####################################################

if [[ $CONFIGURE_GIT -eq 1 ]]; then
    $ECHO -n "configuring git..."
    setup_git > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_VIM -eq 1 ]]; then
    $ECHO -n "configuring vim..."
    setup_vim > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_BASH -eq 1 ]]; then
    $ECHO -n "configuring bash..."
    setup_bash > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_SSH -eq 1 ]]; then
    $ECHO -n "configuring ssh..."
    setup_ssh > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_GDB -eq 1 ]]; then
    $ECHO -n "configuring gdb..."
    setup_gdb > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_TERMINATOR -eq 1 ]]; then
    $ECHO -n "configuring terminator..."
    setup_terminator > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_FILEZILLA -eq 1 ]]; then
    $ECHO -n "configuring filezilla..."
    setup_filezilla > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_GO -eq 1 ]]; then
    $ECHO -n "configuring go..."
    setup_go > /dev/null &&
    $ECHO "DONE"
fi

if [[ $CONFIGURE_VSCODE -eq 1 ]]; then
    $ECHO -n "configuring visual studio..."
    $ECHO "DONE"
    setup_vscode
fi

if [[ $CONFIGURE_THIS_USER_AS_SUDO -eq 1 ]]; then
    $ECHO -n "configuring this user as sudo..."
    set_current_user_as_sudo > /dev/null &&
    $ECHO "DONE"
fi
