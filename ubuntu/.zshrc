source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Wakatime Plugin
antigen bundle sobolevn/wakatime-zsh-plugin

# Load the theme.
antigen theme romkatv/powerlevel10k
##
ZSH_AUTOSUGGEST_USE_ASYNC=true
# Tell Antigen that you're done.
antigen apply
###
# Alias
alias cls="clear"
alias ..="cd .."
alias ....="cd ../.."
alias look="find * -type f | fzf > selected"
alias xls="exa --icons --long --header --git --group-directories-first -all --time-style=long-iso"
alias search="grep --color -rnw ./ -e "
alias ports="lsof -PiTCP -sTCP:LISTEN"
alias gc="git -c http.sslVerify=false clone"
alias git="git -c http.sslVerify=false"
alias gch="git checkout"
alias gpr="git pull --rebase"
alias gpo="git push origin"
alias graph="git log --color --graph --pretty=format:\"%h | %ad | %an | %s%d\" --date=short"
alias hist="git log --color --pretty=format:\"%C(yellow)%h%C(reset) %s%C(bold red)%d%C(reset) %C(green)%ad%C(reset) %C(blue)[%an]%C(reset)\" --relative-date --decorate"
alias xclip="xclip -selection c"
alias speedtest="curl -o /dev/null cachefly.cachefly.net/100mb.test"
alias cats='highlight -O ansi --force'
export LSCOLORS=""
###
DISABLE_MAGIC_FUNCTIONS=true
###
### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
####
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh