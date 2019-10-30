#!/bin/bash

#   -------------------------------
#   VARIABLES CONFIGURATION
#   -------------------------------

GIT_USER=artic92
GIT_REPO_HTTPS=https://github.com/$GIT_USER
GIT_REPO_SSH=git@github.com:$GIT_USER

ECHO='echo -e'
CP='cp -r'
LN='ln -sf'
RM='rm -rf'
CD=cd
MKDIR=mkdir
GIT=git
SUDO=sudo
PKT_MNGR=apt-get
PKT_MNGR_CMD=install
PKT_MGR_OPTS=-y
INSTALL="$SUDO $PKT_MNGR $PKT_MNGR_CMD $PKT_MGR_OPTS"

HOME=~
SSH_DIR=$HOME/.ssh
CONFIGURATIONS_DIR=$HOME/configurations
HOWTOS_DIR=$HOME/howtos
BASHSCRIPTING_DIR=$HOME/bash_scripting

DEBUG=true

#   -------------------------------
#   GIT CONFIGURATION
#   -------------------------------

# configure git global info
git_set_global_info()
{
    $GIT config --global user.name "Antonio Riccio"
    $GIT config --global user.email "antonio.riccio.27@gmail.com"
}

# get the git global config
git_get_global_info()
{
    $ECHO "[GIT] global username: $($GIT config user.name)"
    $ECHO "[GIT] global email: $($GIT config user.email)"
}

#   -------------------------------
#   SERVICE FUNCTIONS
#   -------------------------------

setup_git()
{
    $LN $HOME/configurations/git/.gitconfig $HOME/.gitconfig
}

# set the current user as sudo

# install bashrc
function setup_bash()
{
    local bash_link_name=bashrc

    $LN $HOME/configurations/bash/.bash_aliases $HOME/.bash_aliases

    if [[ "$OSTYPE" == "darwin"* ]]
    then
        bash_link_name=bash_profile
    fi

    $LN $HOME/configurations/bash/.bashrc $HOME/".$bash_link_name"
    source $HOME/".$bash_link_name"
}

# install vim configuration
setup_vim()
{
    $LN $HOME/configurations/vim/.vimrc $HOME/.vimrc
}

setup_terminator()
{
    $MKDIR $HOME/.config/terminator
    $LN $HOME/configurations/terminator/config $HOME/.config/terminator/
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

function setup_ssh()
{
    if [[ ! -d $SSH_DIR ]]
    then
        $MKDIR $SSH_DIR
    fi

    $LN $HOME/configurations/ssh/known_hosts $SSH_DIR/known_hosts

    if [[ "$OSTYPE" == "darwin"* ]]
    then
        # Mac OSX
        $LN $HOME/configurations/ssh/macos/config $SSH_DIR/config
    fi
}

setup_gdb()
{
    $LN $HOME/configurations/gdb/.gdbinit $HOME/.gdbinit
}

function setup_go()
{
    $LN $HOME/configurations/go/.go $HOME/
}

function setup_filezilla()
{
    local filezilla_dir="$HOME/.config/filezilla"

    if [[ ! -d $filezilla_dir ]]
    then
        $MKDIR "$filezilla_dir"
    fi

    $LN $CONFIGURATIONS_DIR/filezilla/filezilla.xml $HOME/.config/filezilla/filezilla.xml
    $LN $CONFIGURATIONS_DIR/filezilla/sitemanager.xml $HOME/.config/filezilla/sitemanager.xml
}

# install ssh keys
setup_ssh_keys()
{
    #COPY MANUALLY THE SSH KEYS!

    $CD $HOME/.ssh
    chmod 700 .ssh
    chmod 644 *.pub
    chmod 600 id_rsa
}

docker_install_useful_containers()
{
  docker pull jgiovaresco/texmaker
  docker pull linuxserver/transmission
  docker pull jerivas/popcorntime
  docker pull jess/tor-browser
}

setup_dropbox_autostart()
{
    dropbox autostart y
}

setup_minidlna()
{
    install -Dm644 /etc/minidlna.conf $HOME/.config/minidlna/minidlna.conf
    $LN $HOME/configurations/minidlna/minidlna.conf $HOME/.config/minidlna/minidlna.conf

    mkdir $HOME/.config/minidlna/cache
    touch $HOME/.config/minidlna/minidlna.pid

    $ECHO "\n\nCheck the general_notes regarding managing inodes\n\n"
}

start_minidlna_as_local_user()
{
    minidlnad -f $HOME/.config/minidlna/minidlna.conf -P $HOME/.config/minidlna/minidlna.pid
    #To autostart it at login, add the previous line to ~/.bash_profile
}

