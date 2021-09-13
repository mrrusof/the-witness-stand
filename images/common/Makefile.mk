SHELL=/bin/bash

ROOT=../..

DOCKERHUB_USER=mrrusof
VERSION != $(ROOT)/common/version.sh
TAG ?= $(VERSION)
IMAGE=$(DOCKERHUB_USER)/$(IMAGE_REPO):$(TAG)
IMAGE_UNRELEASED=$(DOCKERHUB_USER)/$(IMAGE_REPO):build

IMAGES_ROOT=$(ROOT)/images
REQUIRE_IMAGES_DIRS=$(addprefix $(IMAGES_ROOT)/,$(REQUIRE_IMAGES))
REQUIRE_IMAGES_DOCKER_BTOKENS=$(addsuffix /$(DOCKER_BTOKEN),$(REQUIRE_IMAGES_DIRS))
DIR_TO_TODO=$(shell $(MAKE) -C $(dir) --question build >/dev/null 2>&1 || echo -n $(dir))
TODO_REQUIRE_IMAGES_DIRS=$(foreach dir,$(REQUIRE_IMAGES_DIRS),$(DIR_TO_TODO))

DOCKER_SRC_DIR=docker
HARNESS_FILES=$(IMAGES_ROOT)/common/harness/*
DOCKER_SRC_FILES=$(if $(INCLUDE_HARNESS_FILES),$(HARNESS_FILES)) $(DOCKER_SRC_DIR)/*

BUILD_DIR=_build
DOCKER_BUILD_DIR=$(BUILD_DIR)/docker
DOCKER_BTOKEN=$(BUILD_DIR)/docker.done

all build: $(DOCKER_BTOKEN)

$(DOCKER_BTOKEN): $(DOCKER_SRC_FILES) $(TODO_REQUIRE_IMAGES_DIRS) $(REQUIRE_IMAGES_DOCKER_BTOKENS) | $(DOCKER_BUILD_DIR)
	cp $(DOCKER_SRC_FILES) $(DOCKER_BUILD_DIR)
	time docker build --tag $(IMAGE_UNRELEASED) --tag $(IMAGE) $(DOCKER_BUILD_DIR)
	touch $@

$(BUILD_DIR) $(DOCKER_BUILD_DIR):
	mkdir -p $@

$(REQUIRE_IMAGES_DIRS): force
	$(MAKE) -C $@ build
	touch $@

force:

clean:
	rm -rf $(BUILD_DIR)
	docker rmi --force $(IMAGE) $(IMAGE_UNRELEASED)
	@echo ""

.PHONY: all build clean force
