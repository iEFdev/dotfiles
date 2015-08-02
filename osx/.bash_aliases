#
# ~/.bash_aliases
#
#
# Description: Separate file for alias
#
# Load it in ~/.bashrc with:
# ------------------------------------------------------------------------------
#   # Load: ~/.bash_aliases
#   [ -f ~/.bash_aliases ] && . ~/.bash_aliases
# ------------------------------------------------------------------------------
#


# File & folders
# ------------------------------------------------------------------------------

# Alias to cd the folder:
alias cdD='cd ~/Desktop'
alias cdS='cd ~/ShellScripts'
alias cdR='cd ~/Repos'
alias cdT='cd ~/.Trash'
alias cdL='cd /usr/local'
alias www='cd ~/Sites'
alias srv='cd /srv'
alias srw='cd /srv/www'
alias ..='cd ..'

alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'

# alt cp with rsync (testing)
alias cpa='rsync -avhP'

alias c='clear'
alias cx='clear && archey'
alias cxH='cd && clear && archey'

alias h='history'
alias j='jobs -l'
alias x='exit'
alias q='exit'

# top, show cpu and memory. 20 processes. (exit with: q)
alias top20='top -o cpu -O +rsize -s 5 -n 20'

# show 10 largest files/dirs in current directory
alias lsTop10='du -cks * | sort -rn | head -11'

# show the largest one
alias lsTop='du -ks * | sort -n'

# Prevents errors when path is not created.
alias mkdir='mkdir -pv'
alias rmdir='rm -rv'
alias rm='rm -v'
alias ls='ls -G'
alias ls.='ls -d .*'
alias lsal='ls -Ahl'
alias lsless='ls -Ahl | less'

alias grep='grep -n --color=auto'
alias egrep='egrep -n --color=auto'
alias fgrep='fgrep -n --color=auto'

alias forceTrash='rm -rv ~/.Trash/{.*,*}'

# Echo PATH on separate lines
alias lPath="echo $PATH | tr ':' '\n'"

# locate home dir (llocate)
alias llocate='locate -d $HOME/Library/Locate/llocate.database'

# manually update (l)locate
alias locateupd='sudo /usr/libexec/locate.updatedb'
alias llocateupd='$HOME/Library/Locate/llocate.updatedb'

# Get external IP
alias myIP='dig +short myip.opendns.com @resolver1.opendns.com'

# qip netstat info
alias qip='netstat -rn | grep default'	# ip + interface
alias whatPorts='netstat -tulanp'	# open ports ($: whatPorts tcp)

# 3 ping is ok..
alias ping='ping -c 3'

# Do not wait interval 1 second, go fast #
alias fastping='ping -c 20 -s.2'

# Alias for web2png.sh
alias web2png='~/ShellScripts/web2png.sh'

# Pwd+copy
alias cwd='pwd | pbcopy'

# Mimic su
alias su='sudo bash'

# Admin Nano
alias suno='sudo nano'

# Fuck
alias fuck='sudo $(history -p \!\!)'

# Need this one for: sudo <alias>
alias sudo='sudo '

# Open here...
alias oh='open .'

# .bash_xxxxxxx
alias openBashrc='open ~/.bashrc'
alias openProfile='open ~/.bash_profile'
alias openAliases='open ~/.bash_aliases'
alias openFunc='open ~/.bash_functions'
alias openGit='open ~/.bash_git'
alias openHistory='open ~/.bash_history'
alias openLogout='open ~/.bash_logout'
alias openInputrc='open ~/.inputrc'

# nano .bash_xxxxxx
alias nanoBashrc='nano ~/.bashrc'
alias nanoProfile='nano ~/.bash_profile'
alias nanoAliases='nano ~/.bash_aliases'
alias nanoFunc='nano ~/.bash_functions'
alias nanoGit='nano ~/.bash_git'
alias nanoHistory='nano ~/.bash_history'
alias nanoLogout='nano ~/.bash_logout'
alias nanoInputrc='nano ~/.inputrc'
alias nanoNanorc='sudo nano /etc/nanorc'

# Reload .bash_xxx
alias reBash='. ~/.bashrc'
alias reProfile='. ~/.bash_profile'
alias reAlias='. ~/.bash_aliases'
alias reFunc='. ~/.bash_functions'
alias reGit='. ~/.bash_git'
alias reLogout='. ~/.bash_logout'
alias reInput='. ~/.inputrc'
alias reNano='. /etc/nanorc'


## Cleaning up stuff...

# .DS_Store and ._files
alias rmDS='find ./ -name ".DS_Store" -delete'
alias rmDF='find ./ -name "._*" -delete'

# Kill/Flush (DNS)cache (10.7/8/9)
alias flushDNS='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;'

# Kill/Flush (DNS)cache (10.10)
# Read more: http://osxdaily.com/2008/03/21/how-to-flush-your-dns-cache-in-mac-os-x/
alias flushdns='sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches;'

# Read the "hidden" download history
alias readDL="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | uniq | more"

# Delete the "hidden" download history
alias cleanDL="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Read/Delete the Dropbox cache folder (= more space).
alias readDBC='ls -Alh ~/Dropbox/.dropbox.cache/'
alias cleanDBC='rm -rf ~/Dropbox/.dropbox.cache/*'

# Clean Out LaunchPad
alias cleanLPad="sqlite3 ~/Library/Application\ Support/Dock/*.db \"DELETE from apps; DELETE from groups WHERE title <> ''; DELETE from items WHERE rowid > 2;\"; killall Dock"

# Reset LaunchPad
alias resetLPad='rm ~/Library/Application\ Support/Dock/*.db && killall Dock'

# Reset LaunchServises
alias resetOpenWith='cd /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/ && ./lsregister -kill -domain local -domain system -domain user'

# Fix broken "open with" menu
alias fixOW='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'


## ShellScripts

# Usage: cleanDisk "Name of Disk"
alias cleanDisk='~/ShellScripts/cleanDisk.sh'

# Dropbox Uploader
alias dbUpload='~/ShellScripts/dropbox_uploader.sh'


## Misc stuff

# Check why it doesn't go to sleep
alias whatsOpen='pmset -g assertions'

# List connected hardware
alias whatHW='networksetup -listallhardwareports'

# Screen Saver Engine
alias sse='open -a ScreenSaverEngine'

# Add to defaults to custom history log
# moving to: .bashrc (see PROMT_COMMAND)
#alias defLog='history | grep "defaults write" >> $HOME/ShellScripts/__defaultsLog.txt'
alias openDeflog='open $HOME/ShellScripts/__defaultsLog.txt'


## Wget

# Wget continue
# (with curl: curl -o <incomplete_local_file> -C - <URL>)
alias wgetc='wget -c'

# Wget no-check
alias wgetnc='wget --no-check-certificate'


# Password assistant
alias passist='open -a Password\ Assistant'

# Links 2.8
alias LinX='links -g'


## PHP
# @todo: clean up and se what I need.
alias php54='/usr/local/php54/bin/php'
alias phpize54='/usr/local/php54/bin/phpize'
alias pear54='/usr/local/php54/bin/pear'
alias pecl54='/usr/local/php54/bin/pecl'

# note: /usr/local/php56... is in PATH
alias php56='/usr/local/php56/bin/php'
alias phpize56='/usr/local/php56/bin/phpize'
alias pear56='/usr/local/php56/bin/pear'
alias php-fpm='/usr/local/php56/sbin/php-fpm'
alias fpmctl='/usr/local/php56/sbin/fpmctl'


# MySQL
alias mysql='/usr/local/mysql/bin/mysql'
alias mysqladmin='/usr/local/mysql/bin/mysqladmin'

alias mysql.server='sudo /usr/local/mysql/support-files/mysql.server'

alias mysqlstatus='ps aux | grep mysql | grep -v grep'
alias openSqlHistory='open ~/.mysql_history'


# PostgreSQL
# /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
alias psql='/usr/local/pgsql/bin/psql'
alias postgres='/usr/local/pgsql/bin/postgres'
alias PostgreSQL='sudo /Library/StartupItems/PostgreSQL/PostgreSQL'

#/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data
#alias pgsqlLogStart='/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start'


#
# pyWeb
# --------------------------------------------------------------------------
# Python (bundled in OS X) you can start a simple web server to text files.
# Can be used/started from any folder, but this one uses one folder: (~/pyWeb)
#
# OS X comes with `Python 2.*` and since I've upgraded to python 3, I use this.
# --------------------------------------------------------------------------
# URL (examples)     : http://localhost:8000/
#                    : http://localhost:8000/index.html
#                    : http://127.0.0.1:8000/test.html
#                    : (or outside IP)
# --------------------------------------------------------------------------
# Start with: pyWeb
# Stop with: ctrl+C
#
# (think I'll will move this to a function instead)

# Check version
py3=`python -c 'import sys; print(sys.version_info[:3])' | sed 's/.*\(3\).*/\1/'`

# Create folder: ~/pyWeb
[[ ! -d ~/pyWeb ]] && mkdir ~/pyWeb && echo '<pre>pyWeb &hellip;</pre>' > ~/pyWeb/index.html

if [[ $py3 == "3" ]]; then
	# Python 3.*
	alias pyWeb='cd ~/pyWeb && python -m http.server 8000';
else
	# Python 2.*
	alias pyWeb='cd ~/pyWeb && python -m SimpleHTTPServer 8000';
fi