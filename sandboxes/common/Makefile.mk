IMAGE_REPO=$(PROCESS)-sandbox

include ../../images/common/Makefile.mk

SANDBOXES_ROOT=$(ROOT)/sandboxes
REQUIRE_SANDBOXES_DIRS=$(addprefix $(SANDBOXES_ROOT)/,$(REQUIRE_SANDBOXES))
TODO_REQUIRE_SANDBOXES_DIRS=$(foreach dir,$(REQUIRE_SANDBOXES_DIRS),$(DIR_TO_TODO))

TEST_DIR=$(BUILD_DIR)/test
TEST_SRC_DIR=test
TEST_INCLUDES_DIR=$(CURDIR)/../common/test
TESTS=$(addprefix $(TEST_DIR)/,$(shell cd $(TEST_SRC_DIR) && echo *.bats))

test: build $(TESTS) | $(REQUIRE_SANDBOXES_DIRS)
	@time IMAGE=$(IMAGE) bats $(TESTS)

.SECONDEXPANSION:
$(TEST_DIR)/%.bats: $$(shell INCLUDES_DIR=$(TEST_INCLUDES_DIR) $(ROOT)/common/inline.rb --deps $(TEST_SRC_DIR)/$$*.bats) | $(TEST_DIR)
	@INCLUDES_DIR=$(TEST_INCLUDES_DIR) $(ROOT)/common/inline.rb $< >$@

$(TEST_DIR):
	mkdir -p $@

$(TODO_REQUIRE_SANDBOXES_DIRS): force
	$(MAKE) -C $@ build
	touch $@

push: build
	@if [ "$(TAG)" != unreleased ]; then \
	  set -x; \
	  docker push $(IMAGE); \
	else \
	  echo Tag is unreleased, skip pushing image.; \
	fi

.PHONY: push test
