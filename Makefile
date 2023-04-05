#!/usr/bin/make

.PHONY: help
.DEFAULT_GOAL := help
SHELL:=bash
PROJECT_NAME=linkedin-friend-finder
COMPOSE=docker-compose -p $(PROJECT_NAME)
COMPOSE_EXEC=@$(COMPOSE) exec $(PROJECT_NAME)

format: ## Format code using black
	@black .

format-gha: ## Check code formatting using black to be used for CI runs with GitHub Actions
	@black --diff --check --color .

install-deps: ## Install requirements
	@pip3 install -r requirements.txt

lint: ## Lint Python code
	@pylint *.py

help : ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

start-local-env:
	@$(COMPOSE) up -d

start-friend-finding:
	$(MAKE) start-local-env
	@$(COMPOSE_EXEC) ./linkedin_friend_finder.py
	$(MAKE) stop-local-env

stop-local-env:
	@$(COMPOSE) down

develop:
	$(MAKE) start-local-env
	@$(COMPOSE_EXEC) bash
	$(MAKE) stop-local-env

build:
	@$(COMPOSE) build

ci-local:
	@$(MAKE) build
	@$(MAKE) start-local-env
	@$(COMPOSE_EXEC) make format-gha
	@$(COMPOSE_EXEC) make lint
	@$(COMPOSE_EXEC) make test
