# vim: ts=4 st=4 sr noet smartindent:
#
# ... PACKER_JSON
# - looks in order of precedence and uses the first of:
# 1. project working dir (where you git-clone build_ami.git):
#    - packer.json
# 2. build_ami/$(AMI_OS)/$(LAYER_NAME)/packer_json/
#    - role file e.g. amq.json | glusterfs.json | appsvr.json; OR
#    - packer.json (if packer doesn't need role-specific vars passed)
#
# Fails if none of these can be found.
#
AMI_ROLE_JSON_FILE := build_ami/$(AMI_OS)/$(LAYER_NAME)/packer_json/$(EUROSTAR_ROLE).json
AMI_JSON_FILE := build_ami/$(AMI_OS)/$(LAYER_NAME)/packer_json/packer.json

CUSTOM_JSON := $(strip $(wildcard packer.json))
AMI_ROLE_JSON := $(strip $(wildcard $(AMI_ROLE_JSON_FILE)))
AMI_JSON := $(strip $(wildcard $(AMI_JSON_FILE)))

ifeq ($(CUSTOM_JSON),)
ifeq ($(AMI_ROLE_JSON),)
ifeq ($(AMI_JSON),)
define err_msg :=
	... valid packer json file not found.
	... Looked in these locations:
	    ./packer.json
	    $(AMI_ROLE_JSON_FILE)
	    $(AMI_JSON_FILE)
endef
	$(error $(err_msg))
else
	PACKER_JSON=$(AMI_JSON)
endif
else
	PACKER_JSON=$(AMI_ROLE_JSON)
endif
else
	PACKER_JSON=$(CUSTOM_JSON)
endif

export PACKER_JSON

# BUILD_GIT_*: used to AWS-tag the built AMI, and generate its unique name
#              so we can trace its provenance later.
#
# ... to rebuild using same version of tools, we can't trust the git tag
# but the branch, sha and repo, because git tags are mutable and movable.
# We expect the version tag to fit the x.y.z semver format
export BUILD_GIT_TAG:=$(shell \
	git describe                 \
	--exact-match HEAD           \
	--match [0-9]*.[0-9]*.[0-9]* \
	2>/dev/null                  \
)
ifeq ($(BUILD_GIT_TAG),)
	export BUILD_GIT_BRANCH:=$(shell \
	    git describe                 \
	    --contains --all             \
	    --match [0-9]*.[0-9]*.[0-9]* \
	    HEAD                         \
	)
else
	export EUROSTAR_BUILD_VERSION:=$(BUILD_GIT_TAG)
	export BUILD_GIT_BRANCH:=detached_head
endif
export BUILD_GIT_SHA:=$(shell git rev-parse --short=$(GIT_SHA_LEN) --verify HEAD)
export BUILD_GIT_REPO:=$(shell \
	git remote show -n origin  \
	| grep '^ *Push *'         \
	| awk {'print $$NF'}       \
)

export BUILD_GIT_ORG:=$(shell            \
	echo $(BUILD_GIT_REPO)               \
	| sed -e 's!.*[:/]\([^/]\+\)/.*!\1!' \
)

export BUILD_TIME:=$(shell date +%Y%m%d%H%M%S)

export AMI_OS_INFO=$(AMI_OS)-$(AMI_OS_RELEASE)

