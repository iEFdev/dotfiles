#
# ~/.bashrc
#
#
# Aliases (except 2) and Functions are kept in their own files:
# (~/.bash_aliases and ~/.bash_functions)
#
# This file is also sourced from ~/.bash_profile
# ------------------------------------------------------------------------------
#


# Fix for additional added manual path's...
# OS X ssems to forget/ignore som of the paths added
# to /etc/manpaths and /etc/manpaths.d/
export MANPATH=
if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
fi


# Paths
# ------------------------------------------------------------------------------

#export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
alias arch="uname -m"

# GCC 4.9.2 (symlink: /usr/gcc -> /usr/gcc-4.9.2)
_GCC="/usr/gcc/bin"

# Apache 2.4
_AP24="/usr/httpd/bin:/usr/httpd/sbin"

# PHP 5.6 (default), 5.4 in .bash_aliases
_PHP="/usr/local/php56/bin:/usr/local/php56/sbin"

# Git
_GIT="/usr/local/git/bin"

# MySql, PgSql
_SQL="/usr/local/mysql/bin:/usr/local/pgsql/bin"

# PATH for Python 3.3 + alias
_PY="/Library/Frameworks/Python.framework/Versions/3.3/bin"
alias python='/usr/local/bin/python3'

# Active Perl
_PERL="/usr/local/ActivePerl-5.16/bin"

# xbin for own custom scripts
_xbin="/usr/local/xbin"

# ShellScripts
_Sh="$HOME/ShellScripts"

# export PATH.
export PATH="$_GCC:$_AP24:$_PHP:$_GIT:$_SQL:$_PY:$_PERL:/usr/local/bin:/usr/local/sbin:$_xbin:$_Sh:$PATH"

# older version for php <_<
#export PATH="/usr/local/autoconf-2.5.9/bin:$PATH"

# Log "defaults ..." to separate file
PROMPT_COMMAND='echo "$(history 1 | grep -E "(sudo)? defaults ")" | sed '/^$/d' >> $HOME/ShellScripts/__defaultsLog.txt'

# No .DS_Store etc in "tar"
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true


# Colors
# ------------------------------------------------------------------------------

# Bash color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_COLOR='1;33'

# Colors in man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;75m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[0;38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;83m'


#
# Fix host issue (as superuser): "man scutil" + /etc/hostconfig (foobar.dev)
#
# Read                        |  Set new name
# ----------------------------|-------------------------------------------------
# scutil --get LocalHostName  |  sudo scutil --set LocalHostName Shortname
# scutil --get ComputerName   |  sudo scutil --set ComputerName "Shortname's Mac Pro"
# scutil --get HostName       |  sudo scutil --set HostName foobar.dev
#
# Example: - Hostname: `foobar.dev`
# ------------------------------------------------------------------------------
# Set with `scutil`:
#	sudo scutil --set HostName foobar.dev
#
# In `/etc/hostconfig`, add:
#	HOSTNAME=foobar.dev
# ------------------------------------------------------------------------------
#


# Bash name(s)
# ------------------------------------------------------------------------------

# colors used in PS1
_grn='\[\e[0;32m\]'    # green
_gry='\[\e[0;37m\]'    # grey
_red='\[\e[0;31m\]'    # red
_def='\[\e[m\]'        # default (clear)

# user & host
_user='\u'
#_host='\h'
_host='\H'

# Tmp names (to hide real names for screenshots/casts etc)
#_user='test'
#_host='fooBar'

# root is red
[ $UID == 0 ] && _grn=${_red} && _user='\u'

# PS 1-4
PS1="[${_grn}${_user}${_def}@${_host}] ${_gry}\W${_def}\$ "
PS2=' :» '
PS3=' :? '
PS4=' :+ '


# Load .bash_* files + Archey
# ------------------------------------------------------------------------------

# Load: .bash_aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Load: .bash_functions
[ -f ~/.bash_functions ] && . ~/.bash_functions

#Load: ~/.bash_git
[ -f ~/.bash_git ] && . ~/.bash_git

# Load archey (if installed)
[[ `which archey` && $UID != 0 ]] && archey


# Misc xtras
# ------------------------------------------------------------------------------

# Date & time to history
#export HISTTIMEFORMAT='%F %T '

export HISTFILESIZE=15000
export HISTSIZE=15000

export HISTIGNORE='&:[ ]*#'

# ignoreboth (= ignoredups + ignorespace)
export HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#PROMPT_COMMAND="$PROMPT_COMMAND;history -a"

# Set the default editor
export EDITOR=nano


# Misc set & shopt settings
# ------------------------------------------------------------------------------

# Correct dir spellings
shopt -q -s cdspell

# Turn on the extended pattern matching features
shopt -q -s extglob

# Get immediate notification of background job termination
set -o notify

# Disable [CTRL-D] which is used to exit (logout) the shell
set -o ignoreeof

# bash 4.3
[[ `$SHELL --version | grep 'version 4.3'` ]] && shopt -s globstar autocd