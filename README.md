# Measured Report Infra

This project began primarily as a curiosity, driven by a desire to deeply understand why infrastructure teams work the way they do. As the Measured Report project continues to grow, this infrastructure setup will also expand, evolving alongside it. Throughout this process, I'll be gaining deeper insights and learning best practices, as DevOps is not my primary area of expertise. This project will be phased out in favor of better tools as I cannot truly create everything that's needed for production environments on my own

Infrastructure management for the Measured Report project, orchestrating API and Client services using Docker Compose, Lua scripts, and a custom Lua-based CLI.

## Prerequisites

* [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/)
* [Lua](https://www.lua.org/)
* [LuaRocks](https://luarocks.org/)

## Project Structure

* `actions/` – Lua scripts for build, deploy, start, and version generation.
* `docker-compose.yml` – Defines Docker services and networks.
* `dockerfiles/` – Contains Dockerfiles for API and Client services.
* `env/` – Environment configuration files for development, staging, and production.
* `infra` – Lua-based CLI for infrastructure management.
* `measured-report-infra-dev-1.rockspec` – LuaRocks specification file.
* `vendor/` – Bundled dependencies.

## CLI Usage

Use the provided Lua CLI to manage services and environments easily:

### Build a Service

```bash
./infra build <service> [--path custom/path]
```

* `<service>`: `api` or `client`
* `--path`: Optional custom path to service directory

**Example:**

```bash
./infra build api
```

### Deploy a Service

```bash
./infra deploy <service> <environment> [--build_id tag_or_sha]
```

* `<service>`: `api` or `client`
* `<environment>`: `development`, `staging`, or `production`
* `--build_id`: Optional specific image tag or SHA

**Example:**

```bash
./infra deploy client production --build_id v1.2.3
```

### Start Services

```bash
./infra start <environment>
```

* `<environment>`: `development`, `staging`, or `production`

**Example:**

```bash
./infra start development
```

### Generate Version

```bash
lua actions/version_gen.lua
```

Generates the next semantic version based on conventional commit messages.

## Environment Variables

Environment variables are managed through files in the `env/` directory:

* `development.env`
* `staging.env`
* `production.env`

These files are automatically loaded based on the specified environment.
