export PATH={$PATH}:~/.local/bin/
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="nvim"
export SYNCED_DIR="$(dirname $(realpath $HOME/.zshrc))"
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="nvim +Man!"

ZSH_THEME="$(cat ${SYNCED_DIR}/zsh_theme)"
plugins=(git)
source $ZSH/oh-my-zsh.sh

alias l="tree -L 1 --dirsfirst --sort name"

alias tmux="TERM=xterm-256color tmux"
alias t="TERM=xterm-256color tmux"
alias ta="tmux attach"
alias tma="tmux attach -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
alias ts="${SYNCED_DIR}/scripts/start-tmux.sh"

alias gs="git status"
alias ga="git add"
alias gd="git diff"

alias p3="python3"
alias dev=". ./.venv/bin/activate"

bindkey -v
bindkey '^R' history-incremental-search-backward

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

if test -f "${SYNCED_DIR}/zsh_override.sh"; then
    source  "${SYNCED_DIR}/zsh_override.sh"
fi
