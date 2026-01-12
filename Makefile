.PHONY: fmt validate-dev validate-prod

fmt:
	terraform fmt -recursive

init-dev:
	cd environments/dev && terraform init

validate-dev: init-dev
	cd environments/dev && terraform validate

init-prod:
	cd environments/prod && terraform init

validate-prod: init-prod
	cd environments/prod && terraform validate

validate-all: validate-dev validate-prod
