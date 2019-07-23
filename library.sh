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
GIT=git
SUDO=sudo
PKT_MNGR=apt-get
PKT_MNGR_CMD=install
PKT_MGR_OPTS=-y
INSTALL="$SUDO $PKT_MNGR $PKT_MNGR_CMD $PKT_MGR_OPTS"

HOME=~

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
#   REPOs INSTALL
#   -------------------------------

git_clone_base_repos_ssh()
{
    $CD $HOME

    $GIT clone $GIT_REPO_SSH/configurations.git
    $GIT clone $GIT_REPO_SSH/bash_scripting.git
    $GIT clone $GIT_REPO_SSH/howtos.git
}

git_clone_base_repos()
{
    $CD $HOME

    $GIT clone $GIT_REPO_HTTPS/configurations.git
    $GIT clone $GIT_REPO_HTTPS/bash_scripting.git
    $GIT clone $GIT_REPO_HTTPS/howtos.git
}

git_remove_base_repos()
{
    $RM $HOME/configurations
    $RM $HOME/howtos
    $RM $HOME/bash_scripting
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
setup_bash_linux()
{
    $LN $HOME/configurations/bash/.bashrc $HOME/.bashrc
    $LN $HOME/configurations/bash/.bash_aliases $HOME/.bash_aliases
    source $HOME/.bashrc
}

# install bash_profile
setup_bash_macos()
{
    $LN $HOME/configurations/macos/.bash_profile $HOME/.bash_profile
    source $HOME/.bash_profile
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

# install vscode configuration
setup_vscode()
{
    $ECHO "\t- Install the 'Settings Sync' extension\n"
    $ECHO "\t- Insert the Github Token ID (find token ID in KeepPass DB)\n"
    $ECHO "\t- Insert the Github Gist ID:\n"
    $ECHO "\t\t 9dd6c13d536fe315e07155b55d82e39d\n"
    $ECHO "\t- Type: 'alt' + 'shift' + 'u'\n"
}

function setup_ssh()
{
    $LN $HOME/configurations/ssh/known_hosts $HOME/.ssh/known_hosts

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        $LN $HOME/configurations/ssh/macos/config $HOME/.ssh/config
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

# INPUT paramenters
# $1: name of the git repo where taking the files
setup_filezilla()
{
    $LN $HOME/$1/filezilla/filezilla.xml $HOME/.config/filezilla/filezilla.xml
    $LN $HOME/$1/filezilla/sitemanager.xml $HOME/.config/filezilla/sitemanager.xml
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

#   -------------------------------
#   INSTALL FUNCTIONS
#   -------------------------------

git_install()
{
    $INSTALL git
}
