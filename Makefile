include ./PHONYMakefile
ifeq (build,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "build"
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(ARGS):;@:)
endif

.PHONY: help
default help:
	@echo "Usage: make <command>\n"
	@echo "The commands are:"
	@echo "build:  Build docker image"
	@echo "push:   Push docker image to hub.docker"
	@echo "phony:  Generate PhonyMakefile"

.PHONY: phony
phony:
	@bash ./scripts/phony.gen.sh

.PHONY: build
build:
	@bash ./scripts/build.sh $(ARGS)

.PHONY: build	
push:
	@bash ./scripts/push.sh