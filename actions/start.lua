local os = require("os")
local io = require("io")

local function get_image(service, env)
	local running_image = io.popen(
		'docker ps -a --filter "name=' .. env .. "-" .. service .. '" --format "{{.Image}}" | head -n 1'
	):read("*l") or ""

	if running_image == "" then
		return io.popen('docker images --format "{{.Repository}}:{{.Tag}}" | sort -r | grep ' .. service):read("*l")
			or ""
	else
		return running_image
	end
end

return function(env)
	local start_up_vars = table.concat({
		"BUILD_ENV=" .. env,
		"API_IMAGE=" .. get_image("api", env),
		"CLIENT_IMAGE=" .. get_image("client", env),
	}, " ")

	local env_file = " --env-file ./env/" .. env .. ".env"
	local compose_file = " -f ./docker-compose.yml"
	local project = " -p " .. env
	local compose_up = " up -d"

	local command = start_up_vars .. " docker compose" .. env_file .. compose_file .. project .. compose_up

	print(command)
	os.execute(command)
end
