local os = require("os")
local io = require("io")

return function(service, path)
	local cd_command = "cd " .. path
	local git_tag_cmd = cd_command .. " && git describe --tags --exact-match HEAD 2>/dev/null"
	local tag = io.popen(git_tag_cmd):read("*l")

	local build_id
	if tag and #tag > 0 then
		build_id = tag
	else
		local sha_cmd = cd_command .. " && git rev-parse --short HEAD"
		build_id = io.popen(sha_cmd):read("*l")
	end

	if not build_id or #build_id == 0 then
		print("Error: Could not determine git tag or SHA")
		os.exit(1)
	end

	os.execute(cd_command .. " && git checkout " .. build_id)

	local image_name = service .. ":" .. build_id
	local docker_file_path = "./dockerfiles/Dockerfile." .. service
	local cmd = "docker build -f " .. docker_file_path .. " -t " .. image_name .. " " .. path

	print(cmd)
	os.execute(cmd)
end
