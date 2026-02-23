# $env:STARSHIP_CONFIG = "$HOME\.config\starship\starship-cmd\starship-cmd.toml"
# $env:STARSHIP_CONFIG = "$HOME\.config\starship\starship-powershell\starship-powershell4.toml"
# $env:STARSHIP_CONFIG = "$HOME\.config\starship\starship-powershell\01.toml"
# $env:STARSHIP_CONFIG = "$HOME\.config\starship\starship-powershell\starship-powershell3.toml"
  $env:STARSHIP_CONFIG = "$HOME\.config\starship-github\starship1.toml"
Invoke-Expression (&starship init powershell)


function yx {
    yazi --chooser-file yazi_select.txt
    $file = Get-Content yazi_select.txt
    if ($file) {
        hx $file
    }
}



# Alias
set-alias c cls
set-alias l ls

#editors
set-alias n nvim
set-alias vi nvim
set-alias vim nvim

function cc. {
    code .
  }

function zz. {
    zed .
  }


# lazygit
set-alias lzzz lazygit


#configs

function cdc {
    cd "C:/Users/dell/Desktop/Coding/"
}

function cdcl {
    cd "C:/Users/dell/AppData/Local/clink/"
}

function cdstr {
    cd "C:/Users/dell/.config/"
  }

function cdps {
    cd "C:/Users/dell/Documents/WindowsPowerShell/"
  }

Invoke-Expression (& { (zoxide init powershell | Out-String) })
