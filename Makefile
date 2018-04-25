all build clean:
	$(MAKE) $(addprefix $@-,images sandboxes cli)

test:
	$(MAKE) $(addprefix $@-,sandboxes cli)

push: push-sandboxes

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
