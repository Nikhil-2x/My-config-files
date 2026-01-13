return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				sections = {
					{
						section = "header",
						padding = 2,
					},
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 4,
						padding = 2,
					}, --  Multiple APIs with fallbacks
					{
						pane = 1,
						icon = "💭 ",
						title = "Quote",
						section = "terminal",
						cmd = [[
                if ping -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
                  curl -s --max-time 3 'https://zenquotes.io/api/random' | jq -r '.[0].q + " - " + .[0].a' 2>/dev/null ||
                  curl -s --max-time 3 'https://api.quotable.io/random' | jq -r '.content + " - " + .author' 2>/dev/null ||
                  curl -s --max-time 3 'https://dummyjson.com/quotes/random' | jq -r '.quote + " - " + .author' 2>/dev/null
                else
                  quotes=(
                    "Control is an illusion. - Mr. Robot"
                    "The world itself is just one big hoax. - Elliot"
                    "People always make the best exploits. - Mr. Robot"
                    "I am root. - Elliot"
                    "We are all living in each other’s paranoia. - Mr. Robot"
                    "Hello, friend. - Elliot"
                    "I am not special. I'm just anonymous. And that's exactly what i want. -Elliot"
                    "They're just gonna keep coming. Corporations. Governments. Everyone. -Mr. Robot"
                    "The system is rigged. -Elliot"
                    "Maybe wars aren't meant to be won, maybe they're meant to be continous. -Mr. Robot"
                    "Just a dev trying to find certainity in an uncertain world. -localhost"
                    "Pushing commits and probabilities - one quantam bit at a time. -localhost"
                    "Full-stack by day, collapsing wavefunctions by night. -localhost"
                    "Superposition of bugs and features - until you test it."
                    "Reality is optional when you code across dimensions."
                    "From async functions to quantum fluctuations - I try to debug both. -localhost"
                    "Bits, qubits, and building better realities - one repo at a time."
                  )
                  echo "${quotes[$RANDOM % ${#quotes[@]}]}"
                fi
                ]],

						height = 3,
						padding = 1,
						ttl = 3600,
					}, -- Dynamic system info
					{
						pane = 1,
						icon = "🐧",
						title = "System Info",
						section = "terminal",
						cmd = 'echo "$(uname -sr) | $(uptime -p) | $(df -h / | awk \'NR==2{print $4" free"}\')"',
						height = 2,
						padding = 0,
						ttl = 60, -- refresh every minute
					}, -- Dynamic weather (if you have curl)
					{
						pane = 2,
						icon = "🌤️ ",
						title = "Weather",
						section = "terminal",
						cmd = "bash -c \"curl -s 'https://wttr.in/Mumbai?format=%l:+%c+%t+%h+%w' || echo 'Weather unavailable'\"",
						height = 2,
						padding = 1,
						ttl = 1800, -- refresh every 30 minutes
					},
					-- Today's date with a fun fact
					{
						pane = 1,
						icon = " ",
						title = "Today",
						section = "terminal",
						cmd = "echo \"$(date +'%A, %B %d, %Y') | Day $(date +%j) of $(date +%Y)\"",
						height = 2,
						padding = 1,
						ttl = 3600, -- refresh hourly
					},
					{
						section = "keys",
						gap = 1,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Projects",
						section = "projects",
						indent = 2,
						padding = 1,
					}, -- Enhanced git status with branch info
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git branch --show-current | sed 's/^/Branch: /' && echo '---' && git status --short --branch --renames",
						height = 6,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					}, -- Show recent commits
					{
						pane = 2,
						icon = " ",
						title = "Recent Commits",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git log --oneline -5 --pretty=format:'%h %s (%cr)' 2>/dev/null || echo 'No commits found'",
						height = 6,
						padding = 1,
						ttl = 10 * 60, -- refresh every 10 minutes
						indent = 3,
					},
					--CPU and Memory Usage
					{
						pane = 1,
						icon = "🖥️ ",
						title = "Resources",
						section = "terminal",
						cmd = "echo \"CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2}')% | Mem: $(free -h | awk '/^Mem:/ {print $3\"/\"$2}')\"",
						height = 2,
						padding = 1,
						ttl = 10, -- update every 10s
					},
					-- Show coding activity (if you have a way to track it)
					{
						pane = 1,
						icon = " ",
						title = "Dev Stats",
						section = "terminal",
						cmd = "find . -name '*.cpp' -o -name '*.c' -o -name '*.h' | wc -l | sed 's/^/C++ files: /' && find . -name '*.lua' | wc -l | sed 's/^/Lua files: /'",
						height = 3,
						padding = 1,
						ttl = 300, -- refresh every 5 minutes
					},

					-- Show TODO/FIXME count in project
					{
						pane = 2,
						icon = " ",
						title = "TODOs & FIXMEs",
						section = "terminal",
						cmd = "grep -r --include='*.cpp' --include='*.c' --include='*.h' --include='*.lua' -c 'TODO\\|FIXME' . 2>/dev/null | wc -l | sed 's/^/Found: /' | sed 's/$/ items/' || echo 'No TODOs found'",
						height = 2,
						padding = 1,
						ttl = 600, -- refresh every 10 minutes
					},
					{
						section = "startup",
					},
				},
			},
		},
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},
}
