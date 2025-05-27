local function run(cmd)
	local handle = assert(io.popen(cmd, "r"))
	local result = handle:read("*a")
	handle:close()
	return result:gsub("%s+$", "")
end

local function parse_version(version)
	local major, minor, patch = version:match("v?(%d+)%.(%d+)%.(%d+)")
	return tonumber(major), tonumber(minor), tonumber(patch)
end

local function bump_version(commits, major, minor, patch)
	local bump_major, bump_minor, bump_patch = false, false, false
	for line in commits:gmatch("[^\r\n]+") do
		if line:match("^feat!") or line:match("BREAKING CHANGE") then
			bump_major = true
		elseif line:match("^feat") then
			bump_minor = true
		elseif line:match("^fix") then
			bump_patch = true
		end
	end

	if bump_major then
		major = major + 1
		minor = 0
		patch = 0
	elseif bump_minor then
		minor = minor + 1
		patch = 0
	elseif bump_patch then
		patch = patch + 1
	end

	return string.format("%d.%d.%d", major, minor, patch)
end

local last_tag = run("git describe --tags --abbrev=0 2>/dev/null")

if last_tag == "" then
	last_tag = "0.0.0"
end

local commits = run("git log " .. last_tag .. "..HEAD --pretty=format:%s")

local major, minor, patch = parse_version(last_tag)
local new_version = bump_version(commits, major, minor, patch)
os.execute("git tag v" .. new_version)
os.execute("git push origin v" .. new_version)

print("Tagged new version: v" .. new_version)
