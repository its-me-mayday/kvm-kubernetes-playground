TFVARS_FILE ?= .tfvars
VAR_FILE_OPT := $(if $(wildcard $(TFVARS_FILE)),-var-file=$(TFVARS_FILE),)

TOFU := tofu

init:
	@echo "Running open-tofu init"
	$(TOFU) init $(VAR_FILE_OPT)

upgrade:
	@echo "Running open-tofu init -upgrade"
	$(TOFU) init -upgrade $(VAR_FILE_OPT)

plan:
	@echo "Running open-tofu plan"
	$(TOFU) plan $(VAR_FILE_OPT)

apply:
	@echo "Running open-tofu apply"
	$(TOFU) apply $(VAR_FILE_OPT)

destroy:
	@echo "Running open-tofu destroy"
	$(TOFU) destroy $(VAR_FILE_OPT)

lint:
	@echo "Running open-tofu linting"
	$(TOFU) fmt --recursive

clean:
	@echo "Running cleaning state files"
	rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup

help:
	@echo "Makefile commands:"
	@echo "  make init           - Init Tofu backend"
	@echo "  make upgrade        - Upgrade Tofu backend"
	@echo "  make plan           - Plan all resources Tofu managed"
	@echo "  make apply          - Apply all resources Tofu managed"
	@echo "  make destroy        - Destroy all resources Tofu managed"
	@echo "  make lint           - Lint all resources Tofu files"
	@echo "  make clean          - Clean Tofu state files"
	@echo "  make help           - Show this message"
