IMAGE_REPO=$(SANDBOX)-sandbox

include ../../images/common/Makefile.mk

COMPILE_IMAGE_REPO=$(if $(COMPILE_SANDBOX),$(COMPILE_SANDBOX)-sandbox)
COMPILE_IMAGE=$(if $(COMPILE_IMAGE_REPO),$(DOCKERHUB_USER)/$(COMPILE_IMAGE_REPO):build)

SANDBOXES_ROOT=$(ROOT)/sandboxes
ALL_REQUIRE_SANDBOXES=$(REQUIRE_SANDBOXES) $(COMPILE_SANDBOX)
ALL_REQUIRE_SANDBOXES_DIRS=$(addprefix $(SANDBOXES_ROOT)/,$(ALL_REQUIRE_SANDBOXES))
ALL_REQUIRE_SANDBOXES_DOCKER_BTOKENS=$(addsuffix /$(DOCKER_BTOKEN),$(ALL_REQUIRE_SANDBOXES_DIRS))
TODO_ALL_REQUIRE_SANDBOXES_DIRS=$(foreach dir,$(ALL_REQUIRE_SANDBOXES_DIRS),$(DIR_TO_TODO))

TEST_DIR=$(BUILD_DIR)/test
TEST_SRC_DIR=test
TEST_INCLUDES_DIR=$(CURDIR)/../common/test
TESTS=$(addprefix $(TEST_DIR)/,$(shell cd $(TEST_SRC_DIR) && echo *.bats))

test: build $(TESTS)
	time INCLUDES_DIR=$(TEST_INCLUDES_DIR) COMPILE_IMAGE=$(COMPILE_IMAGE) IMAGE=$(IMAGE_UNRELEASED) bats $(TESTS)

test/%: build $(TEST_DIR)/%
	time INCLUDES_DIR=$(TEST_INCLUDES_DIR) COMPILE_IMAGE=$(COMPILE_IMAGE) IMAGE=$(IMAGE_UNRELEASED) bats $(TEST_DIR)/$*

.SECONDEXPANSION:
$(TEST_DIR)/%.bats: $$(shell INCLUDES_DIR=$(TEST_INCLUDES_DIR) $(ROOT)/common/inline.rb --deps $(TEST_SRC_DIR)/$$*.bats) | $(TEST_DIR)
	@INCLUDES_DIR=$(TEST_INCLUDES_DIR) $(ROOT)/common/inline.rb $< >$@

$(TEST_DIR):
	mkdir -p $@

$(DOCKER_BTOKEN): $(TODO_ALL_REQUIRE_SANDBOXES_DIRS) $(ALL_REQUIRE_SANDBOXES_DOCKER_BTOKENS)

$(ALL_REQUIRE_SANDBOXES_DIRS): force
	$(MAKE) -C $@ build
	touch $@

push: build
	@if [ "$(TAG)" != build ]; then \
	  set -x; \
	  docker push $(IMAGE); \
	else \
	  echo Tag is build, skip pushing image.; \
	fi

.PHONY: push test
