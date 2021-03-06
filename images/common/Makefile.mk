SHELL=/bin/bash

ROOT=../..

DOCKERHUB_USER=mrrusof
VERSION != $(ROOT)/common/version.sh
TAG ?= $(VERSION)
IMAGE=$(DOCKERHUB_USER)/$(IMAGE_REPO):$(TAG)
IMAGE_BUILD=$(DOCKERHUB_USER)/$(IMAGE_REPO):build

IMAGES_ROOT=$(ROOT)/images
REQUIRE_IMAGES_DIRS=$(addprefix $(IMAGES_ROOT)/,$(REQUIRE_IMAGES))
DIR_TO_TODO=$(shell $(MAKE) -C $(dir) --question build >/dev/null 2>&1 || echo -n $(dir))
TODO_REQUIRE_IMAGES_DIRS=$(foreach dir,$(REQUIRE_IMAGES_DIRS),$(DIR_TO_TODO))

DOCKER_SRC_DIR=docker
HARNESS_FILES=$(IMAGES_ROOT)/common/harness/*
DOCKER_SRC_FILES=$(if $(INCLUDE_HARNESS_FILES),$(HARNESS_FILES)) $(DOCKER_SRC_DIR)/*

BUILD_DIR=_build
DOCKER_BUILD_DIR=$(BUILD_DIR)/docker
DOCKER_BTOKEN=$(BUILD_DIR)/docker.done

all build: $(DOCKER_BTOKEN)

$(DOCKER_BTOKEN): $(TODO_REQUIRE_IMAGES_DIRS) $(DOCKER_SRC_FILES) | $(BUILD_DIR) $(DOCKER_BUILD_DIR)
	cp $(DOCKER_SRC_FILES) $(DOCKER_BUILD_DIR)
	time docker build --tag $(IMAGE_BUILD) --tag $(IMAGE) $(DOCKER_BUILD_DIR)
	touch $@

$(BUILD_DIR) $(DOCKER_BUILD_DIR):
	mkdir -p $@

$(TODO_REQUIRE_IMAGES_DIRS): force
	$(MAKE) -C $@ build
	touch $@

force:

clean:
	rm -rf $(BUILD_DIR)
	docker rmi --force $(IMAGE) $(IMAGE_BUILD)
	@echo ""

.PHONY: all build clean force
