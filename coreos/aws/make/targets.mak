# vim: ts=4 st=4 sr noet smartindent syntax=make ft=make:
.PHONY: clean
clean: clean_build_libs ## delete build assets

.PHONY: prereqs
prereqs: no_detached_head sha_in_origin sshkeyfile get_build_libs user_data ## set up build env

.PHONY: validate
validate: check_vars check_includes check_for_changes valid_packer ## check build env is sane

.PHONY: build
build: prereqs validate tag_project run_packer push_tags ## run prereqs, validate then build.

.PHONY: user_data
user_data: ## replaces tokens in USER_DATA_TMPL and copies to build_ami/user_data_file
	@sed -e 's#__DISCOVERY_URL__#$(DISCOVERY_URL)#' $(USER_DATA_TMPL) > $(USER_DATA_FILE)
