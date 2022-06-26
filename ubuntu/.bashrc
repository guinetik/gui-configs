WAKATIME_PATH=~/.wakatime/bash-wakatime.sh
if test -f "$WAKATIME_PATH"; then
    source $WAKATIME_PATH
fi
# Switch to ZSH shell
if test -t 1; then
exec zsh
fi