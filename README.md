# Introduction

This repo contains various configuration files I use to configure my workstations. This project is still in his first phases, therefore I apologise for eventual errors and problems which might arise.

## Description

So far, the repo contains configuration files for following software:

* git
* vim
* bash
* ssh
* gdb
* terminator
* filezilla
* go
* iterm2 (macOS)
* xfce environment

`go` is a simple utility which creates labeled shortcuts to most used filesystem paths. Use the command `gset` to store the actual folder as shortcut by assigning a label. You can later remove that shortcut with the `gunset` command.

## Usage

For *Linux* and *macOS* environments, just clone this repo and type the following:

```bash
./install.sh
```

Enjoy!

NOTE: the above command overwrites your existing configuration files. Type it only if you know what you are doing (in the next future, this behaviour is going to change).

### Configuration

The `install.sh` script is configurable through a set of variables. So far, the setting has to be manual inside the source of the script. However, it is programmed to do this from the command line interface in next releases.

`CONFIGURE_GIT`

* This variable controls configuration of `git`. A value of `0` means the configuration is not installed.

`CONFIGURE_VIM`

* This variable controls configuration of `vim`. A value of `0` means the configuration is not installed.

`CONFIGURE_BASH`

* This variable controls configuration of `bash`. A value of `0` means the configuration is not installed.

`CONFIGURE_SSH`

* This variable controls configuration of `ssh`. A value of `0` means the configuration is not installed.

`CONFIGURE_GDB`

* This variable controls configuration of `gdb`. A value of `0` means the configuration is not installed.

`CONFIGURE_TERMINATOR`

* This variable controls configuration of `terminator`. A value of `0` means the configuration is not installed.

`CONFIGURE_FILEZILLA`

* This variable controls configuration of `filezilla`. A value of `0` means the configuration is not installed.

`CONFIGURE_GO`

* This variable controls configuration of `go`. A value of `0` means the configuration is not installed.

`CONFIGURE_VSCODE`

* This variable controls configuration of `Microsoft Visual Studio Code`. A value of `0` means the configuration is not installed.

`CONFIGURE_THIS_USER_AS_SUDO`

* This variable controls allow the current user to use the `sudo` command. A value of `0` means the configuration is not applied.

`CONFIGURE_XFCE`

* This variable controls configuration of the `xfce` environment. A value of `0` means the configuration is not installed.

## Contributing

Please feel free to contribute, Bugfix and improvements are always more than wellcome.

## License

MIT © Antonio Riccio
