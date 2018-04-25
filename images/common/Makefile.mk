SHELL=/bin/bash

ROOT=../..
CHANGELOG=$(ROOT)/CHANGELOG.md

DOCKERHUB_USER=mrrusof
TAG ?= $(shell head -n 1 $(CHANGELOG) | sed -e 's/\# *//' -e 's/ \+/-/')
IMAGE=$(DOCKERHUB_USER)/$(IMAGE_REPO):$(TAG)
IMAGE_BUILD=$(DOCKERHUB_USER)/$(IMAGE_REPO):build

IMAGES_ROOT=$(ROOT)/images
REQUIRE_IMAGES_DIRS=$(addprefix $(IMAGES_ROOT)/,$(REQUIRE_IMAGES))
DIR_TO_TODO=$(shell $(MAKE) -C $(dir) --question build >/dev/null 2>&1 || echo -n $(dir))
TODO_REQUIRE_IMAGES_DIRS=$(foreach dir,$(REQUIRE_IMAGES_DIRS),$(DIR_TO_TODO))

DOCKER_SRC_DIR=docker
DOCKER_DEPS=$(DOCKER_SRC_DIR)/*

BUILD_DIR=_build
DOCKER_BTOKEN=$(BUILD_DIR)/docker.done

all build: $(DOCKER_BTOKEN)

$(DOCKER_BTOKEN): $(REQUIRE_IMAGES_DIRS) $(DOCKER_DEPS) | $(BUILD_DIR)
	docker build -t $(IMAGE) -t $(IMAGE_BUILD) $(DOCKER_SRC_DIR)
	touch $@

$(BUILD_DIR):
	mkdir -p $@

$(TODO_REQUIRE_IMAGES_DIRS): force
	$(MAKE) -C $@ build
	touch $@

force:

clean:
	rm -rf $(BUILD_DIR)
	docker rmi --force $(IMAGE)
	@echo ""

.PHONY: all build clean force
