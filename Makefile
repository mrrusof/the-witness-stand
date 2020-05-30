all build clean:
	$(MAKE) $(addprefix $@-,images sandboxes cli)

login:
	echo $$DOCKER_PWD | docker login -u mrrusof --password-stdin

push: push-sandboxes

test:
	$(MAKE) $(addprefix $@-,sandboxes cli)

all-%:
	$(MAKE) -C $* all

build-%:
	$(MAKE) -C $* build

clean-%:
	$(MAKE) -C $* clean

push-%:
	$(MAKE) -C $* push

test-%:
	$(MAKE) -C $* test

.PHONY: all build clean login push test all-% build-% clean-% push-% tag-% test-%
