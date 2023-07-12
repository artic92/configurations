#!/bin/bash

###################################################
#  commands macro
###################################################
ECHO='echo -e'
CP='cp -r'
LN='ln -sf'
RM='rm -rf'
CD=cd
MKDIR='mkdir -p'
LS=ls
CHMOD=chmod
GIT=git
SUDO=sudo

###################################################
#  useful paths
###################################################
SSH_DIR="$HOME"/.ssh
CONFIGURATIONS_DIR="$HOME"/private/configurations

###################################################
#  error definitions
###################################################


###################################################
#  service functions library
###################################################

function git_set_global_info()
{
    $GIT config --global user.name "Antonio Riccio"
    $GIT config --global user.email "antonio.riccio.27@gmail.com"
}

function git_get_global_info()
{
    $ECHO "[GIT] global username: $($GIT config user.name)"
    $ECHO "[GIT] global email: $($GIT config user.email)"
}

function setup_git()
{
    $LN "$CONFIGURATIONS_DIR"/git/.gitconfig "$HOME"/.gitconfig
}

function setup_vim()
{
    $LN "$CONFIGURATIONS_DIR"/vim/.vimrc "$HOME"/.vimrc
}

function setup_bash()
{
    local bash_link_name=bashrc

    $LN "$CONFIGURATIONS_DIR"/bash/.bash_aliases "$HOME"/.bash_aliases

    if [[ "$OSTYPE" == "darwin"* ]]; then
        bash_link_name=bash_profile
    fi

    $LN "$CONFIGURATIONS_DIR"/bash/.bashrc "$HOME/.$bash_link_name"

    # shellcheck source=/dev/null
    source "$HOME/.$bash_link_name"
}

function setup_ssh()
{
    if [[ ! -d "$SSH_DIR" ]]; then
        $MKDIR "$SSH_DIR"
    fi

    if [[ "$OSTYPE" == "darwin"* ]]; then
        $LN "$CONFIGURATIONS_DIR"/ssh/macos/config "$SSH_DIR"/config
    fi
}

# ------------------------------------------------------------------- #
# setup_ssh_key()                                                     #
# Gives the right permissions to the SSH keys                         #
# Parameters: -                                                       #
# NOTE: it assumes the keys are already installed in $HOME/.ssh       #
# ------------------------------------------------------------------- #
function setup_ssh_keys()
{
    local ssh_key_name=id_rsa

    $CHMOD 700 "$SSH_DIR"
    $CHMOD 644 "$SSH_DIR"/$ssh_key_name.pub
    $CHMOD 600 "$SSH_DIR"/$ssh_key_name
}

function setup_gdb()
{
    $LN "$CONFIGURATIONS_DIR"/gdb/.gdbinit "$HOME"/.gdbinit
}

function setup_terminator()
{
    local terminator_target_dir="$HOME"/.config/terminator

    if [[ ! -d $terminator_target_dir ]]; then
        $MKDIR "$terminator_target_dir"
    fi

    $LN "$CONFIGURATIONS_DIR"/terminator/config "$terminator_target_dir"/
}

function setup_filezilla()
{
    local filezilla_targer_dir="$HOME"/.config/filezilla

    if [[ ! -d $filezilla_targer_dir ]]; then
        $MKDIR "$filezilla_targer_dir"
    fi

    $LN "$CONFIGURATIONS_DIR"/filezilla/filezilla.xml "$filezilla_targer_dir"/filezilla.xml
    $LN "$CONFIGURATIONS_DIR"/filezilla/sitemanager.xml "$filezilla_targer_dir"/sitemanager.xml
}

function setup_go()
{
    $LN "$CONFIGURATIONS_DIR"/go/.go "$HOME"
}

function setup_vscode()
{
    $ECHO
    $ECHO "###############################################################"
    $ECHO "From Visual Studio:"
    $ECHO "\t1) install the 'Settings Sync' extension"
    $ECHO "\t2) go to 'Settings Sync' settings"
    $ECHO "\t3) insert the Github Token ID"
    $ECHO -n "\t4) insert the Github Gist ID (HOME settings): "
    $ECHO "76cd25491e9973d3857ea8842302560e"
    $ECHO "\t5) type: 'alt' + 'shift' + 'u' to syncronise settings"
    $ECHO "###############################################################"
    $ECHO
}

function docker_install_useful_containers()
{
    docker pull jgiovaresco/texmaker
    docker pull linuxserver/transmission
    docker pull jerivas/popcorntime
    docker pull jess/tor-browser
}

function setup_dropbox_autostart()
{
    dropbox autostart y
}

function setup_minidlna()
{
    install -Dm644 /etc/minidlna.conf "$HOME"/.config/minidlna/minidlna.conf
    $LN "$CONFIGURATIONS_DIR"/minidlna/minidlna.conf "$HOME"/.config/minidlna/minidlna.conf

    $MKDIR "$HOME"/.config/minidlna/cache
    touch "$HOME"/.config/minidlna/minidlna.pid

    $ECHO "\n\nCheck the general_notes regarding managing inodes\n\n"
}

function start_minidlna_as_local_user()
{
    minidlnad -f "$HOME"/.config/minidlna/minidlna.conf -P "$HOME"/.config/minidlna/minidlna.pid
    #To autostart it at login, add the previous line to ~/.bash_profile
}

function set_current_user_as_sudo()
{
    $SUDO usermod -aG sudo "$USER"
}

function xfce_backup_config_files()
{
    local xfce4_config_folder=$HOME/.config/xfce4
    local xfce4_cache_folder=$HOME/.cache/xfce4
    local config_xfce_dir=$CONFIGURATIONS_DIR/xfce4

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # NOTE: cp command automatically creates the target if not existing
        $CP "$xfce4_config_folder"/panel/ "$config_xfce_dir"/
        $CP "$xfce4_config_folder"/terminal/ "$config_xfce_dir"/
        $CP "$xfce4_config_folder"/xfconf/ "$config_xfce_dir"/

        # using plain cp to skip folders (already copied by the previous commands)
        # using also unaliased version obtained by prefixing a \ to the command (option '-i' prompts for overwriting)
        # for more details: https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
        \cp -f "$xfce4_config_folder"/* "$config_xfce_dir"

        $CP "$xfce4_cache_folder"/xfce4-appfinder/ "$config_xfce_dir"/
    fi
}

function setup_xfce()
{
    local xfce4_config_folder=$HOME/.config/xfce4
    local xfce4_cache_folder=$HOME/.cache/xfce4
    local config_xfce_dir=$CONFIGURATIONS_DIR/xfce4

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        $RM "$xfce4_config_folder"/panel
        $RM "$xfce4_config_folder"/terminal
        $RM "$xfce4_config_folder"/xfconf
        $RM "$xfce4_cache_folder"/xfce4-appfinder

        $LN "$config_xfce_dir"/* "$xfce4_config_folder"/
        $LN "$config_xfce_dir"/xfce4-appfinder "$xfce4_cache_folder"/
    fi
}

function teamviewer_backup_conf_files()
{
    local teamviewer_config_dir=$HOME/.config/teamviewer
    local configurations_teamviewer_dir=$CONFIGURATIONS_DIR/teamviewer

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        $CP "$teamviewer_config_dir"/client.conf "$configurations_teamviewer_dir"
    fi
}

function setup_teamviewer()
{
    local teamviewer_config_dir=$HOME/.config/teamviewer
    local configurations_teamviewer_dir=$CONFIGURATIONS_DIR/teamviewer

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        $RM "$teamviewer_config_dir"/client.conf

        if [[ ! -d $teamviewer_config_dir ]]; then
            $MKDIR "$teamviewer_config_dir"
        fi

        $LN "$configurations_teamviewer_dir"/client.conf "$teamviewer_config_dir"/
    fi
}
