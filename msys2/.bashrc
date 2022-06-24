[[ "$-" != *i* ]] && return
# Launch Zsh
if [ -t 1 ]; then
  exec zsh
fi