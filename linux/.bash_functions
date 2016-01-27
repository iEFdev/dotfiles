#
# ~/.bash_functions
#
#
# Description: Separate file for bash functions and helpers
#
# Load it in: ~/.bashrc with
# ------------------------------------------------------------------------------
#   # Load: ~/.bash_functions
#   [ -f ~/.bash_functions ] && . ~/.bash_functions
# ------------------------------------------------------------------------------
#


# File & folders
# ------------------------------------------------------------------------------

# locate in ext. disk (pics, docs etc)
#function Locate { locate $* | egrep "^/Volumes/NameOfDisk"; }

# Make a dir and cd into it
function mkdircd() { mkdir -p "$1" && cd "$1"; }

# Misc bak helpers (mbakd, for dirs)
#function mkbakd() { _dir=`echo "$1" | sed 's/\/*$//g'`; ditto -v "$_dir"{,.bak}; }
function mkbak() { cp -iv "$1"{,.bak}; }
function mvbak() { mv -iv "$1"{,.bak}; }


# @todo: open | gedit... for now open (see 'open' in .bash_aliases)
# Usage: openBash [<letter>]
# Empty = .bashrc ($1 = 1st letter after .bash_)
function  openBash()
{
	[[ $1 == 'i' ]] && open -e ~/.inputrc;
	[ -z $1 ] && open -e ~/.bashrc || \
	for file in $(ls -d ~/.* | grep bash | grep -v -e 'bashrc' | sed -e 's/.*\://'); do
		[[ $(echo $1 | cut -c 1) == $(echo `basename $file` | cut -c 7) ]] && open -e $file && break;
	done;
}

# Usage: nanoBash [<letter>]
# Empty = .bashrc ($1 = 1st letter after .bash_)
function nanoBash()
{
	[[ $1 == 'i' ]] && nano ~/.inputrc;
	[[ $1 == 'n' ]] && sudo nano /etc/nanorc;
	[ -z $1 ] && nano ~/.bashrc || \
	for file in $(ls -d ~/.* | grep bash | grep -v -e 'bashrc' | sed -e 's/.*\://'); do
		[[ $(echo $1 | cut -c 1) == $(echo `basename $file` | cut -c 7) ]] && nano $file && break;
	done;
}

# Usage: reBash [<letter>]
# Empty = .bashrc ($1 = 1st letter after .bash_)
function reBash()
{
	[[ $1 == 'h' ]] && return;
	[[ $1 == 'i' ]] && . ~/.inputrc;
	[[ $1 == 'n' ]] && . /etc/nanorc;
	[ -z $1 ] && . ~/.bashrc || \
	for file in $(ls -d ~/.* | grep bash | egrep -v -e 'bashrc|history' | sed -e 's/.*\://'); do
		[[ $(echo $1 | cut -c 1) == $(echo `basename $file` | cut -c 7) ]] && . $file && break;
	done;
}


# Search/delete lines in history
function delHist() { sed -i '' "/$1/d" $HISTFILE; }

# Search history with grep
function hgrep() { history | grep "$1"; }

# cd directory of "foo"...
function cd2() { cd $(dirname `which $1`); }

# cd directory and list
function cdl() { cd "$1"; ls -Ahl; }

# rsync folder2folder
function rsyncdir()
{
	# removing trailing "/" and adding our own
	# to make sure there is one, and not end up with "//"
	_from_dir=`echo "$1" | sed 's/\/*$//g'`;
	_to_dir=`echo "$2" | sed 's/\/*$//g'`;
	rsync -avzuc --delete "$_from_dir/" "$_to_dir/";
}

# GPG
function chksig() { gpg --verify "$1.sig" "$1"; }

# Open
open() { xdg-open "$@" > /dev/null 2>&1 ;}


# Get this...
# ------------------------------------------------------------------------------

# Get site with wget
function wgets()
{
	if [ $2 ]; then logFile="-o $2"; else logFile=''; fi
	wget --convert-links -r "$1" $logFile;
}

# Get site with wget
function wgetsub() { wget -r -l1 --no-parent "$1"; }


# Manuals
# ------------------------------------------------------------------------------

# To avoid the d d o o u u b b l l e e and spaced letters use: col -b
# Usage: man2txt <foo> [ <path/to/output/file.txt> ]
function man2txt()
{
	[ -z $2 ] && _file="man_${1}.txt" || _file="$2";
	man $1 | col -b > $_file;
}


# Compression
# ------------------------------------------------------------------------------

# Create compressed archive: gz, bz2, xz (default)
function mktar ()
{
	[[ ! -d $1 && ! -f $1 ]] && local _ext=$1 && shift || _ext='xz';
	local _dir=`echo "$1" | sed -e 's/\/$//g'`;
	local _excludes='--exclude ".DS_Store" --exclude "._*"'
	if [ -e $1 ]; then
		(cd `dirname ${_dir}` && _path=${_dir} && _dir=`basename ${_dir}`;
		case $_ext in
			gz) tar -zcvf "${_dir}".tar.${_ext} ${_excludes} "${_dir}";  ;;
			bz2) tar -jcvf "${_dir}".tar.${_ext} ${_excludes} "${_dir}"; ;;
			xz) # exmaple: use -2e for less compression
			    tar -cvf - "${_dir}" | xz -6e > "${_dir}".tar.${_ext};   ;;
			*)
				echo "${FUNCNAME}: Could not create '${_dir}.tar.${_ext}'";
				cat << INFO
Usage: ${FUNCNAME} [gz|bz2|xz] <files/directory>
       ${FUNCNAME} bz2 ${_path}
       ${FUNCNAME} ${_path} (defaults to xz)

INFO
				return 1;
				;;
		esac
		)
	else
		echo "'$1' is not a valid file/directory";
	fi
}

# Function extract
# (using 7za instead of 7z)
function extract ()
{
	if [ -f $1 ]; then
		local _dir="`dirname $1`";
		case $1 in
			*.tar.bz2 | *.tbz2) tar -jxvf $1 -C ${_dir} ;;
			*.tar.xz) tar -xvf $1 -C ${_dir}            ;;
			*.tar.gz | *.tgz) tar -zxvf $1 -C ${_dir}   ;;
			*.bz2) bunzip2 -kf $1                       ;;
			*.rar) (cd ${_dir} && unrar x $1)           ;;
			*.gz) gunzip -kvf $1                        ;;
			*.tar) tar -xf $1 -C ${_dir}                ;;
			*.zip) unzip -f $1 -d ${_dir}               ;;
			*.Z) (cd ${_dir} && uncompress $1)          ;;
			*.7z) (cd ${_dir} && 7za x $1)              ;;
			*)
				echo "${FUNCNAME}: '$1' cannot be extracted. ${_ext} is not supported.";
				;;
		esac;
	else
		echo "'$1' is not a valid file";
	fi
}


# Diff & Patching
# ------------------------------------------------------------------------------

# Create a patch file
# Usage: mkpatch original_file.ext my_modified.ext [patchname]
function mkpatch()
{
	_patch="$3";
	if [[ "$3" == '' ]]; then _patch="$2"; fi
	diff -Naur "$1" "$2" > "$_patch.patch";
}

# Apply patch
function patchfile() { patch < "$1"; }

# Patch a file
# Usage: patch1 patch_file
function patch1() { patch -p0 < "$1"; }

# version...
# Usage: patch21 filetopatch patch_file
function patch21() { patch "$1" < "$2"; }

# Sir Patchalot
function patchalot() { for file in $(ls *.patch); do patch -p0 < $file; done; }


# fail2ban
# --------------------------------------------------------------------------
# (help: fail2ban-client -h)
function f2bclient() { sudo fail2ban-client $@; }


# Misc & Funsies
# ------------------------------------------------------------------------------

# comandline search
function ddg() { open Firefox "https://duckduckgo.com/?q=$1"; }

# Adminer :: Changing theme.
function chgAdminer()
{
	_theme="$1";
	sudo ln -s /usr/share/webapps/adminer/{themes/$_theme,adminer}.css
}

# GPG
function chksig() { gpg --verify "$1.sig" "$1"; }

# youtube-dl
function ytdl() { youtube-dl -ci "$1"; }

# ffmpeg - 320k mp3
function 2mp3()
{
	[[ ! `type ffmpeg 2> /dev/null` ]] && echo "$FUNCNAME: Please install 'ffmpeg'..." && return 1;
	local output="$(dirname "$1")/$(basename "$1" | sed -e 's/\.\(.*\)$/\.mp3/')";
	ffmpeg -i "$1" -ab 320k "${output}";
}

# Most freq used commands
# usage: ctop 15
function ctop()
{
	if [ -z $1 ]; then echo 'Usage: ctop <int>';
	else
		local nr=$1;
		history | awk '{print $2}' | awk 'BEGIN {FS=" | "} {print $1}' | sort | uniq -c | sort -rn | head -$nr;
	fi
}

# Detailed information on an IP address or hostname in bash via http://ipinfo.io:
# https://wiki.archlinux.org/index.php/Bash/Functions#IP_info
ipInfo() {
	[[ $1 == '' ]] && _ip=$(dig +short myip.opendns.com @resolver1.opendns.com) || _ip=$1;
	if grep -P "(([1-9]\d{0,2})\.){3}(?2)" 2>/dev/null <<< "$_ip"; then
		curl ipinfo.io/"$_ip"
	else
		ipawk=($(host "$_ip" | awk '/address/ { print $NF }'))
		curl ipinfo.io/${ipawk[1]}
	fi
	echo
}


# Debugging
# ------------------------------------------------------------------------------
#

# https://wiki.archlinux.org/index.php/Bash/Functions#Display_error_codes
EC() {
	echo -e "\e[1;31m :: \e[1;33m code: $? \e[m\n"
}
trap EC ERR
