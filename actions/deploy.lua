local os = require("os")

return function(service, env, build_id)
	build_id = build_id or ""

	local image_name = service .. ":" .. build_id
	local image = io.popen('docker images --format "{{.Repository}}:{{.Tag}}" | sort -r | grep ' .. image_name)
		:read("*l") or ""

	if not image then
		print("No images found, build first")
		os.exit(1)
	end

	local container_name = env .. "-" .. service
	os.execute("docker rm -f " .. container_name .. " >/dev/null 2>&1")

	local cmd = "docker compose run -d " .. "--name " .. container_name .. ' -e BUILD_ENV="' .. env .. '" ' .. image

	print(cmd)
	os.execute(cmd)
end
