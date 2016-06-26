# vim: ts=4 st=4 sr noet smartindent syntax=make ft=make:
BADIR=./build_ami
BAGB=master
BAGR=git@github.com:jinal--shah/build_ami
BAGT=
.PHONY: clean
clean: ## delete build assets
	@rm -rf $(BADIR)

.PHONY: prereqs
prereqs: sshkeyfile get_build_ami ## set up build env

.PHONY: validate
validate: check_vars check_includes check_for_changes valid_packer ## check build env is sane

.PHONY: build
build: prereqs validate ## run prereqs, validate then build.
	@PACKER_LOG=$(PACKER_LOG) packer build $(PACKER_DEBUG) "$(PACKER_JSON)"

# ... cloning the repo that has this target only makes sense
#     if you run the clean target first (otherwise you'd be trashing the file
#     that contains this code that tells make what to clone ...)
.PHONY: get_build_ami
get_build_ami: ## fetch build_ami libs from github
	@if [[ ! -e "$(BADIR)" ]]; then                                     \
	    echo -e "\033[1;37m$(BADIR) doesn't exist - cloning.\033[0m"    \
	    && git clone --branch $(BAGB) $(BAGR) $(BADIR)                  \
	    && cd $(BADIR)                                                  \
	    && [[ -z "$(BAGT)" ]]                                           \
	    || echo -e "\033[1;37mchecking out tag $(BAGT)\033[0m"          \
	    && git checkout $(BAGT);                                        \
	else                                                                \
	    echo -e "\033[1;37m... $(BADIR) already exists.\033[0m"         \
	    && echo -e "\033[1;37mRun 'make clean' to start fresh.\033[0m"; \
	fi;
