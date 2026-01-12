.PHONY: fmt validate-dev validate-prod

fmt:
	terraform fmt -recursive

init-dev:
	cd environments/dev && terraform init -backend=false

validate-dev: init-dev
	cd environments/dev && terraform validate

init-prod:
	cd environments/prod && terraform init -backend=false

validate-prod: init-prod
	cd environments/prod && terraform validate

init-bootstrap:
	cd environments/bootstrap && terraform init

validate-bootstrap: init-bootstrap
	cd environments/bootstrap && terraform validate

validate-all: validate-dev validate-prod validate-bootstrap
