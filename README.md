# Measured Report Infra

This project manages Docker-based environments for the API and Client services using `docker-compose` and a `Makefile`.

## Prerequisites

- Docker & Docker Compose
- GNU Make

## Usage

### Build

```bash
make build-api TAG=latest BUILD_ENV=dev
make build-client TAG=latest BUILD_ENV=dev
````

### Start

```bash
make up-api TAG=latest BUILD_ENV=dev
make up-client TAG=latest BUILD_ENV=dev
```

### Stop

```bash
make down-api BUILD_ENV=dev
make down-client BUILD_ENV=dev
```

## Notes

* `TAG` or `SHA` defines the image version (default: `dev`)
* `BUILD_ENV` controls which env file is used (`dev`, `staging`, `prod`)
