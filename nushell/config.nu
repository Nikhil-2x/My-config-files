# config.nu
#
# Installed by:
# version = "0.114.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# --- Interactive Completions & Suggestions Setup ---
$env.config = {
    show_banner: false
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            completer: {|place| 
                carapace $place.command.0 nushell ...$place.command | from json
            }
        }
    }
}


# -------------------------
# Environment
# -------------------------

$env.CODING = "C:/Users/dell/Desktop/Coding"
$env.MY_CONFIG = "C:/Users/dell/.config"


# -------------------------
# Navigation
# -------------------------

alias c = clear
alias l = ls
alias la = ls -a

alias cdc = cd $env.CODING
alias cdstr = cd $env.MY_CONFIG

alias .. = cd ..
alias ... = cd ../..




# -------------------------
# Editors
# -------------------------

alias n = nvim
alias vi = nvim
alias vim = nvim

alias cc. = code .




# -------------------------
# Git UI
# -------------------------

alias lzg = lazygit


# -------------------------
# AI
# -------------------------

alias cc = claude
alias olc = ollama launch claude
alias olo = ollama launch opencode


# Claude + Ollama
def claudelocal [...args] {
    with-env {
        ANTHROPIC_AUTH_TOKEN: "ollama"
        ANTHROPIC_API_KEY: ""
        ANTHROPIC_BASE_URL: "http://localhost:11434"
    } {
        claude ...$args
    }
}


# -------------------------
# Docker
# -------------------------

alias dks = docker desktop start
alias dkst = docker desktop stop



