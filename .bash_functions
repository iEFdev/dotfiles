#
# ~/.bash_functions
#
# Description: Separate file for bash functions and helpers
#
# Load it in: ~/.bashrc with
# ----------------------------------------
#   #Load: ~/.bash_functions
#   [ -f ~/.bash_functions ] && . ~/.bash_functions
# ----------------------------------------
#

### File & folders

# Make a dir and cd into it
function mkdircd() { mkdir -p "$1" && cd "$1"; }

# Misc bak helpers (mbakd, for dirs)
function mkbakd() { _dir=`echo "$1" | sed 's/\/*$//g'`; ditto -v "$_dir"{,.bak}; }
function mkbak() { cp -iv "$1"{,.bak}; }
function mvbak() { mv -iv "$1"{,.bak}; }

# Search/delete lines in history 
function delHist() { sed "/$1/d" $HISTFILE > $HISTFILE.tmp && mv $HISTFILE{.tmp,}; }

# cd directory of "foo"...
function cd2 { cd $(dirname `which $1`); }

# rsync folder2folder
function rsyncdir() { 
	# removing trailing "/" and adding our own
	# to make sure ther is one, and not end up with "//"
	_from_dir=`echo "$1" | sed 's/\/*$//g'`;
	_to_dir=`echo "$2" | sed 's/\/*$//g'`;
	rsync -avzuc --delete "$_from_dir/" "$_to_dir/";
}

### Get this...

# Get site with wget
function wgets()
{
	if [ $2 ]; then logFile="-o $2"; else logFile=''; fi
	wget --convert-links -r "$1" $logFile;
}

# Get site with wget
function wgetsub() { wget -r -l1 --no-parent "$1"; }

# Manuals
# To avoid the d d o o u u b b l l e e and
# spaced letters use: col -b
# Usage:
# manOut grep			// grep_manual.txt (in pwd)
# manOut grep ~/foo/grep	// ~/foo/grep_manual.txt
function man2txt()
{
	_path="$2";
	if [[ "$2" == '' ]]; then _path="$1"; fi
	man $1 grep | col -b > $_path_manual.txt
}

# open man-page(s) in its own window
function manx() { local i; for i; do open x-man-page://$i; done; }

# comandline search
function ddg() { open -a Safari "https://duckduckgo.com/?q=$1"; }

# youtube-dl
function ytdl() { youtube-dl -ci "$1"; }


### Compression

# tar.gz ($1 = folder name)
function tarGZ()
{ 
	_dir=`echo "$1" | sed -e 's/\/$//g'`;
	tar -zcvf "$_dir".tar.gz --exclude ".DS_Store" --exclude "._*" "$_dir";
}
function untarGZ() { tar -zxvf "$1"; }

# tar.bz2
function tarBZ()
{ 
	_dir=`echo "$1" | sed -e 's/\/$//g'`;
	tar -jcvf "$_dir".tar.bz2 --exclude ".DS_Store" --exclude "._*" "$_dir";
}
function untarBZ () { tar -jxvf "$1"; }


### Diff & Patching

# Create a patch file
# Usage: mkpatch original_file.ext my_modified.ext [patchname]
function mkpatch()
{
	_patch="$3";
	if [[ "$3" == '' ]]; then _patch="$2"; fi
	diff -Naur "$1" "$2" > "$_patch.patch";
}

# Apply patch
function patchfile () { patch < "$1"; }

# Patch a file
# Usage: patchp0 patch_file
function patchp0 () { patch -p0 < "$1"; }

# version... 
# Usage: patch21 filetopatch patch_file
function patch21 () { patch "$1" < "$2"; }