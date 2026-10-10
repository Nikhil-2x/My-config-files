# env.nu
#
# Installed by:
# version = "0.114.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
#


# PATH Additions
$env.PATH = (
    $env.PATH | append [
        "C:/Program Files/Oracle/VirtualBox"
        $"($env.USERPROFILE)/AppData/Local/Microsoft/WinGet/Packages/JesseDuffield.lazygit_Microsoft.Winget.Source_8wekyb3d8bbwe"
    ]
)

# Custom Config Paths
# $env.STARSHIP_CONFIG = $"($env.USERPROFILE)/.config/starship/starship-bash/starship1.toml"

# Hook Initializations for Starship, Zoxide, and Carapace Completions
mkdir $"($nu.data-dir)/vendor/autoload"
zoxide init nushell | save -f $"($nu.data-dir)/vendor/autoload/zoxide.nu"
carapace _carapace nushell | save -f $"($nu.data-dir)/vendor/autoload/carapace.nu"
