#!/bin/bash

# if set, the functions-under-test are actually called inside each test_* function
SELF_CONTAINED_TESTS=0

test_passed=0
test_failed=0

function test_setup_git()
{
    source "$HOME"/configurations/library.sh
    local file_to_test="$HOME"/.gitconfig

    $ECHO -n "test setup_git..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_git &> /dev/null
    fi

    if [[ ! -L $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    elif [[ ! -s $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    else
        $ECHO "PASSED"
        ((++test_passed))
    fi
}

function test_setup_vim()
{
    source "$HOME"/configurations/library.sh
    local file_to_test="$HOME"/.vimrc

    $ECHO -n "test setup_vim..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_vim &> /dev/null
    fi

    if [[ ! -L $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    elif [[ ! -s $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    else
        $ECHO "PASSED"
        ((++test_passed))
    fi
}

function test_setup_bash
{
    local bash_link_name=bashrc

    source "$HOME"/configurations/library.sh

    $ECHO -n "test setup_bash..."

    if [[ "$OSTYPE" == "darwin"* ]]
    then
        bash_link_name=bash_profile
    fi

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_bash &> /dev/null
    fi

    if [[ -a $HOME/".$bash_link_name" ]]
    then
        $ECHO "PASSED"
        ((++test_passed))
    else
        $ECHO "FAILED"
        ((++test_failed))
    fi
}

function test_setup_ssh()
{
    source "$HOME"/configurations/library.sh
    local file_to_test="$SSH_DIR"/config

    $ECHO -n "test setup_ssh..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_ssh &> /dev/null
    fi

    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ ! -L $file_to_test ]]; then
            $ECHO "FAILED"
            ((test_failed++))
        elif [[ ! -s $file_to_test ]]; then
            $ECHO "FAILED"
            ((test_failed++))
        else
            $ECHO "PASSED"
            ((++test_passed))
        fi
    else
        $ECHO "PASSED"
        ((++test_passed))
    fi
}

function test_setup_gdb()
{
    source "$HOME"/configurations/library.sh
    local file_to_test="$HOME"/.gdbinit

    $ECHO -n "test setup_gdb..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_gdb &> /dev/null
    fi

    if [[ ! -L $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    elif [[ ! -s $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    else
        $ECHO "PASSED"
        ((++test_passed))
    fi
}

function test_setup_terminator()
{
    source "$HOME"/configurations/library.sh
    local file_to_test="$HOME"/.config/terminator/config

    $ECHO -n "test setup_terminator..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_terminator &> /dev/null
    fi

    if [[ ! -L $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    elif [[ ! -s $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    else
        $ECHO "PASSED"
        ((++test_passed))
    fi
}

function test_setup_filezilla
{
    source "$HOME"/configurations/library.sh

    $ECHO -n "test setup_filezilla..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_filezilla &> /dev/null
    fi

    if [[ -a $HOME/.config/filezilla/filezilla.xml && -a $HOME/.config/filezilla/sitemanager.xml ]]
    then
        $ECHO "PASSED"
        ((test_passed++))
    else
        $ECHO "FAILED"
        ((test_failed++))
    fi
}

function test_setup_go()
{
    source "$HOME"/configurations/library.sh
    local file_to_test="$HOME"/.go/

    $ECHO -n "test setup_go..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_go &> /dev/null
    fi

    if [[ ! -d $file_to_test ]]; then
        $ECHO "FAILED"
        ((test_failed++))
    else
        $ECHO "PASSED"
        ((++test_passed))
    fi
}

function test_set_current_user_as_sudo()
{
    $ECHO -n "test set_current_user_as_sudo..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        set_current_user_as_sudo &> /dev/null
    fi

    if groups | grep "\<sudo\>" &> /dev/null; then
        $ECHO "PASSED"
        ((++test_passed))
    else
        $ECHO "FAILED"
        ((test_failed++))
    fi
}

function test_setup_xfce()
{
    local xfce4_config_folder=$HOME/.config/xfce4
    local xfce4_cache_folder=$HOME/.cache/xfce4
    local folders=("$xfce4_config_folder"/panel "$xfce4_config_folder"/terminal "$xfce4_config_folder"/xfconf "$xfce4_cache_folder"/xfce4-appfinder)
    local size=${#folders[@]}

    $ECHO -n "test setup_xfce..."

    if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
        setup_xfce &> /dev/null
    fi

    for (( i = 0; i < size; i++ )); do
        if [ ! -d "${folders[i]}" ]; then
            $ECHO "FAILED"
            ((test_failed++))
            return
        fi
    done

    $ECHO "PASSED"
    ((++test_passed))
}

###################################################
#  MAIN script starts here
###################################################

if [[ $SELF_CONTAINED_TESTS -eq 1 ]]; then
 echo -e "tests in stand-alone mode...\n"
fi

test_setup_git
test_setup_vim
test_setup_bash
test_setup_gdb
test_setup_ssh
test_setup_terminator
test_setup_filezilla
test_setup_go
test_set_current_user_as_sudo
test_setup_xfce

echo -e "\nSUMMARY"
echo -e "\ttests passed: $test_passed"
echo -e "\ttests failed: $test_failed"
