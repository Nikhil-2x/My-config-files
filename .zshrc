ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit 
compinit

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

source <(kubectl completion zsh)

#keybindings
bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

# Search history by the beginning of the command typed
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward


#history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/coding/CLI-SIMP/.tools/bin:$PATH"

# grep
alias grep='grep --color=auto'

#aliases
alias c='clear'
alias cd='z'
alias n="nvim"
alias scz='source ~/.zshrc'

alias l="eza --git --icons"
alias ll="eza -lh --git --icons"
alias la="eza -lah --git --icons"
alias tree="eza --tree"

eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

eval "$(starship init zsh)"
