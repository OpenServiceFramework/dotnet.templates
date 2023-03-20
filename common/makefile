# C# dotnet framework v6.0 (ubuntu)
# Reference: 
# - https://hub.docker.com/_/microsoft-dotnet
# - https://hub.docker.com/_/microsoft-dotnet-sdk/
# - https://hub.docker.com/_/microsoft-dotnet-runtime/

DOTNET_VERSION := 7.0
OS_VERSION := "" # Debian
RUNTIME_ENV := develop
BUILD_CONFIG := debug

SDK_IMAGE := mcr.microsoft.com/dotnet/sdk:$(DOTNET_VERSION)$(OS_VERSION)
RUNTIME_IMAGE := mcr.microsoft.com/dotnet/aspnet:$(DOTNET_VERSION)$(OS_VERSION)
DOCKER_FILE := dockerfile
PLATFORM := linux/arm64
IMAGE_NAME := $(shell basename ${PWD} | tr '.' '/')
COMMIT_ID := $(shell git rev-parse HEAD)
PWD := $(shell pwd)

.PHONY: help show prune clean clean-all pull build run recreate-lock-files sdk

help:
	@echo "Targets: show prune clean clean-all pull build run recreate-lock-files"

show: 
	@echo "Images:"
	@docker image list
	@echo "Containers:"
	@docker container list

prune: 
	@echo "Prune only ..."
	@docker system prune --force

clean: 
	@echo "Prune + volumes ..."
	@docker system prune --force --volumes

clean-all: 
	@echo "Prune everything ..."
	@docker system prune --force --volumes --all

pull:
	@echo "Pull images ..."
	@test -n "${SDK_IMAGE}" && docker pull --platform=${PLATFORM} ${SDK_IMAGE}
	@test -n "${RUNTIME_IMAGE}" && docker pull --platform=${PLATFORM} ${RUNTIME_IMAGE}

build: pull
	@echo "Building ..."
	@DOCKER_BUILDKIT=1 docker build \
		--platform ${PLATFORM} \
		--tag "${IMAGE_NAME}:${COMMIT_ID}" \
		--file ${DOCKER_FILE} \
		--build-arg RUNTIME_ENV="${RUNTIME_ENV}" \
		--build-arg BUILD_CONFIG="${BUILD_CONFIG}" \
		--build-arg SDK_IMAGE="${SDK_IMAGE}" \
		--build-arg RUNTIME_IMAGE="${RUNTIME_IMAGE}" \
		.

run:
	@echo "Running ..."
	@docker run \
		--platform ${PLATFORM} \
		--interactive \
		--tty \
		--env RUNTIME_ENV="${RUNTIME_ENV}" \
		--env BUILD_CONFIG="${BUILD_CONFIG}" \
		"${IMAGE_NAME}:${COMMIT_ID}"

sdk: pull
	@echo "Launching dotnet-sdk cli ..."
	@docker run \
		--platform ${PLATFORM} \
		--interactive \
		--tty \
		--env RUNTIME_ENV="${RUNTIME_ENV}" \
		--env BUILD_CONFIG="${BUILD_CONFIG}" \
		--volume "${PWD}/src:/src" \
		--workdir "/src" \
		${SDK_IMAGE} bash

recreate-lock-files:
	@echo "Recreate lock files ..."
	@docker run --interactive --rm \
		--platform ${PLATFORM} \
		--volume "${PWD}/src:/src" \
		--workdir "/src" \
		${SDK_IMAGE} \
			dotnet restore --use-lock-file --force-evaluate --verbosity normal