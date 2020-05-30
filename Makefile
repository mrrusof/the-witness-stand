all build clean:
	$(MAKE) $(addprefix $@-,images sandboxes cli)

test:
	$(MAKE) $(addprefix $@-,sandboxes cli)

login:
	echo $$DOCKER_PWD | docker login -u mrrusof --password-stdin

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

.PHONY: all build test login push clean all-% build-% test-% push-% clean-%
