#
# ~/.bash_logout
#

# Adding session...
history -a ~/.bash_history;

if [[ $(uname -s) == 'Darwin' ]]; then
    # Delete the "hidden" download history
    sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent';

    # Bye... (in Swedish ^^)
    say -v Samantha Hey dauh;
fi