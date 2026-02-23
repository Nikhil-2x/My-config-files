-- starship.lua

-- from starship-cmd
-- local config = os.getenv("USERPROFILE") .. "\\.config\\starship\\starship-cmd\\starship-cmd.toml"
-- local config = os.getenv("USERPROFILE") .. "\\.config\\starship\\starship-cmd\\starship-cmd2.toml"
-- local config = os.getenv("USERPROFILE") .. "\\.config\\starship\\starship-cmd\\starship-cmd-jetbrains.toml"


--from starship-github

local config = os.getenv("USERPROFILE") .. "\\.config\\starship-github\\starship1.toml"
-- local config = os.getenv("USERPROFILE") .. "\\.config\\starship-github\\starship2.toml"

os.setenv("STARSHIP_CONFIG", config)
load(io.popen("starship init cmd"):read("*a"))()
