SDK_IMAGE := mcr.microsoft.com/dotnet/sdk:7.0
RUNTIME_IMAGE := mcr.microsoft.com/dotnet/aspnet:7.0
DOCKER_FILE := dockerfile
PLATFORM := linux/arm64
RUNTIME_ENV := develop
BUILD_CONFIG := debug
IMAGE_NAME := $(shell basename ${PWD} | tr '.' '/')
COMMIT_ID := $(shell git rev-parse HEAD)
PWD := $(shell pwd)

.PHONY: help show prune clean clean-all pull build run recreate-lock-files

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
		--env CMD="./ProjectName" \
		"${IMAGE_NAME}:${COMMIT_ID}"

recreate-lock-files: pull
	@echo "Recreate lock files ..."
	@docker run --interactive --rm \
		--platform ${PLATFORM} \
		--volume "${PWD}/src:/src" \
		--workdir "/src" \
		${SDK_IMAGE} \
			dotnet restore --use-lock-file --force-evaluate --verbosity normal
