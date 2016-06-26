# vim: ts=4 st=4 sr noet smartindent syntax=make ft=make:
#
AMI_LAYER:=primary
LAYER_OS:=coreos
LAYER_NAME:=aws

# ### MANDATORY_VARS
# put custom overrides or additions in current project in mandatory_vars.mak
CUSTOM_FILE:=mandatory_vars.mak
include build_ami/shared/make/mandatory_vars.mak
include build_ami/shared/make/custom_file.mak

# ### CONSTANTS (not user-defineable)
# put custom overrides or additions in current project in constants.mak
CUSTOM_FILE:=constants.mak
include build_ami/shared/make/constants.mak
include build_ami/$(LAYER_OS)/shared/make/constants.mak
include build_ami/$(LAYER_OS)/$(LAYER_NAME)/make/constants.mak
include build_ami/shared/make/custom_file.mak

# ### USER_VARS (user-defineable)
# put custom overrides or additions in current project in user_vars.mak
CUSTOM_FILE:=user_vars.mak
include build_ami/shared/make/user_vars.mak
include build_ami/shared/make/custom_file.mak

# ### GENERATED VARS: determined by make based on other values.
# put custom overrides or additions in current project in generated_vars.mak
CUSTOM_FILE:=generated_vars.mak
include build_ami/shared/make/generated_vars.mak
include build_ami/shared/make/generated_vars-$(AMI_LAYER)_layer.mak
include build_ami/$(LAYER_OS)/$(LAYER_NAME)/make/generated_vars.mak
include build_ami/shared/make/custom_file.mak

# ### TARGETS ...
# You can't override targets with CUSTOM_FILE but you can declare additional ones.
CUSTOM_FILE:=targets.mak
include build_ami/shared/make/targets.mak
include build_ami/$(LAYER_OS)/$(LAYER_NAME)/make/targets.mak
include build_ami/shared/make/custom_file.mak
