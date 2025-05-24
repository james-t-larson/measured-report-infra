TAG ?= latest
BUILD_ID := $(or $(TAG),$(SHA),dev)
ENV_FILE = ./env/$(BUILD_ENV).env
BUILD_ENV ?= dev

build-client:
	BUILD_ENV=$(BUILD_ENV) CLIENT_BUILD_ID=$(BUILD_ID) docker compose --env-file $(ENV_FILE) build client

build-api:
	BUILD_ENV=$(BUILD_ENV) API_BUILD_ID=$(BUILD_ID) docker compose --env-file $(ENV_FILE) build api

up-client:
	BUILD_ENV=$(BUILD_ENV) CLIENT_BUILD_ID=$(BUILD_ID) docker compose --env-file $(ENV_FILE) up client

up-api:
	BUILD_ENV=$(BUILD_ENV) API_BUILD_ID=$(BUILD_ID) docker compose --env-file $(ENV_FILE) up api

down-client:
	BUILD_ENV=$(BUILD_ENV) docker compose --env-file $(ENV_FILE) stop client

down-api:
	BUILD_ENV=$(BUILD_ENV) docker compose --env-file $(ENV_FILE) stop api

