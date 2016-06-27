# vim: ts=4 st=4 sr noet smartindent syntax=make ft=make:
.PHONY: clean
clean: clean_aws_creds clean_build_libs ## delete build assets

.PHONY: prereqs
prereqs: sshkeyfile copy_aws_creds get_build_libs ## set up build env

.PHONY: validate
validate: check_vars check_includes check_for_changes valid_packer ## check build env is sane

.PHONY: build
build: prereqs validate ## run prereqs, validate then build.
	@PACKER_LOG=$(PACKER_LOG) packer build $(PACKER_DEBUG) "$(PACKER_JSON)"

