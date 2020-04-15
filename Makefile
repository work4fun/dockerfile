.PHONY: help
default help:
	@echo "Usage: make <command>\n"
	@echo "The commands are:"
	@echo "build Build docker image"

.PHONY: build
build:
	@bash ./scripts/build.sh