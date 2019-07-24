#!/bin/bash

####################################################
#                  install.sh                      #
#           written by Antonio Riccio              #
#          antonio.riccio.27@gmail.com             #
#                                                  #
# Configures all the setting required by a basic   #
#      installing of Linux (git, vim, vscode, etc) #
# This script works for either Linux and MacOs     #
# Tested on Xubuntu-1904                           #
####################################################

source library.sh

###################################################
#  DEBUG CONFIGURATION
###################################################

set -x

# write debug output to command.txt
# exec 5> command.txt
# BASH_XTRACEFD="5"

###################################################
#  MAIN STARTS HERE
###################################################

$ECHO "\n[GIT] Installing git...\n"
git_install
$ECHO "\n[GIT] Configuring git...\n"
setup_git
$ECHO "\n[GIT] Installing repos\n"
git_clone_base_repos
# $ECHO "\n[GIT] Installing repos (SSH)\n"
# git_clone_base_repos_ssh
# $ECHO "\n[GIT] Removing all repos!\n"
#git_remove_repos

$ECHO "[VIM] Configuring vim...\n"
setup_vim
$ECHO "[BASH] Configuring bash...\n"
setup_bash
$ECHO "[SSH] Configuring ssh...\n"
setup_ssh
$ECHO "[GDB] Configuring gdb...\n"
setup_gdb
$ECHO "[TERMINATOR] Configuring terminator...\n"
setup_terminator
$ECHO "[FILEZILLA] Configuring filezilla...\n"
setup_filezilla configurations
$ECHO "[GO] Configuring go command...\n"
setup_go

setup_vscode
