DIRS=$(shell ls -1 -p | grep / | sed -e s_/__ -e /common/D)

all build test push clean:
	$(MAKE) $(addprefix $@-, $(DIRS))

all-%:
	$(MAKE) -C $* all

build-%:
	$(MAKE) -C $* build

test-%:
	$(MAKE) -C $* test

push-%:
	$(MAKE) -C $* push

clean-%:
	$(MAKE) -C $* clean

.PHONY: all build test push clean all-% build-% test-% push-% clean-%
