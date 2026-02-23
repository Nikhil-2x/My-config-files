
# PATHS
#
# Add Starship to PATH (Windows install path)
export PATH="$PATH:/c/Program Files/starship/bin"

export PATH="$PATH:/c/Program Files/Oracle/VirtualBox"
export PATH="$PATH:/c/Users/dell/AppData/local/Microsoft/WinGet/Packages/JesseDuffield.lazygit_Microsoft.Winget.Source_8wekyb3d8bbwe"

#yazi
export PATH="$PATH:/c/Tools/yazi-x86_64-pc-windows-msvc"

# Gemini
export GEMINI_API_URL="https://generativelanguage.googleapis.com"
export GEMINI_API_KEY=<>

export STARSHIP_CONFIG="$HOME/.config/starship/starship-bash/starship1.toml"
# export STARSHIP_CONFIG="$HOME/.config/starship-github/starship2.toml"
# export STARSHIP_CONFIG="$HOME/.config/starship/starship-powershell/starship-powershell3.toml"

# --Aliases--
alias c='clear'
alias scb='source ~/.bashrc'

# Listing
alias ll='ls -lh --color=auto'
alias la='ls -la --color=auto'
alias l='ls -CF --color=auto'
alias lt='ls -ltr --color=auto'    # Sort by time
alias lsize='ls -lhS --color=auto' # Sort by size

alias gl='git log --oneline --graph --decorate'
alias gll='git log --graph --pretty=format:"%C(yellow)%h%Creset -%C(red)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Network
alias myip='curl -s https://ipinfo.io/ip'
alias ports='netstat -tuln'

# Code editors
alias n='nvim'
alias vi='nvim'
alias vim='nvim'
alias cc.='code .'
alias zz.='zed .'

alias dks='docker desktop start'
alias dkst='docker desktop stop'

alias cd='z'

#lazygit
alias lzg='lazygit'

#directory
alias cdc="cd C:/Users/dell/Desktop/Coding/"
alias cdps="cd C:/Users/dell/Documents/WindowsPowerShell/"
alias cdcl="cd C:/Users/dell/AppData/Local/clink/"
alias cdstr="cd C:/Users/dell/.config/"

# Starship prompt
eval "$(starship init bash)"

eval "$(zoxide init bash)"
