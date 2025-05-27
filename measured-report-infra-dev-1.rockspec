package = "measured-report-infra"
version = "dev-1"
source = {
	url = "git+ssh://git@github.com/james-t-larson/measured-report-infra.git",
}
description = {
	detailed = "This project manages Docker-based environments for the API and Client services using `docker-compose` and a `Makefile`.",
	homepage = "*** please enter a project homepage ***",
	license = "*** please specify a license ***",
}
build = {
	type = "builtin",
	modules = {
		["actions.build"] = "scripts/build.lua",
		["actions.start"] = "scripts/start.lua",
		["actions.version_gen"] = "scripts/version_gen.lua",
	},
}
