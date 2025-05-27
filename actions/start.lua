local os = require("os")
local io = require("io")

local function get_image(service)
	local running_image = io.popen('docker ps -a --filter "name=' .. service .. '" --format "{{.Image}}" | head -n 1')
		:read("*l") or ""

	if running_image == "" then
		return io.popen('docker images --format "{{.Repository}}:{{.Tag}}" | sort -r | grep ' .. service):read("*l")
			or ""
	else
		return running_image
	end
end

return function(env)
	local api_image = get_image("api")
	local client_image = get_image("client")

	local cmd = string
		.format(
			[[
  BUILD_ENV="%s"
  CLIENT_IMAGE="%s"
  API_IMAGE="%s"
  docker compose
  --env-file "./env/%s.env"
  -f "./docker-compose.yml"
  -p "%s" up -d
]],
			env,
			client_image,
			api_image,
			env,
			env
		)
		:gsub("\n", " ")

	print(cmd)
	os.execute(cmd)
end
