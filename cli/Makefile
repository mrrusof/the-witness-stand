ROOT=..
CHANGELOG=$(ROOT)/CHANGELOG.md
BIN_DIR=bin
LIB_DIR=lib
BUILD_DIR=_build
BIN_SRC=$(BIN_DIR)/the-witness-stand
LIB_SRC=$(LIB_DIR)/*.sh
VERSION ?= $(shell $(ROOT)/common/version.sh)
VER_FILE=version
TAR=$(BUILD_DIR)/the-witness-stand-$(VERSION).tar.gz

all build: $(TAR)

$(TAR): $(BIN_SRC) $(LIB_SRC) $(VER_FILE) | $(BUILD_DIR)
	tar --transform 's#^#tws/#' -czf $@ $(BIN_SRC) $(LIB_SRC) $(VER_FILE)

$(VER_FILE): $(CHANGELOG)
	echo $(VERSION) >$(VER_FILE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

test: build
	$(MAKE) -C ../sandboxes build
	bats test/*/*.bats

clean:
	rm -rf $(BUILD_DIR) $(VER_FILE)

.PHONY: all build test clean
