# vim: ts=4 st=4 sr noet smartindent syntax=make ft=make:
.PHONY: clean
clean: clean_build_libs ## delete build assets

.PHONY: prereqs
prereqs: no_detached_head sha_in_origin sshkeyfile get_build_libs ## set up build env

.PHONY: validate
validate: check_vars check_includes check_for_changes valid_packer ## check build env is sane

.PHONY: build
build: prereqs validate tag_project run_packer push_tags ## run prereqs, validate then build.

