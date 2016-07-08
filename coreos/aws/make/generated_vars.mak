# vim: ts=4 st=4 sr noet smartindent syntax=make:
export AMI_DESCRIPTION:=$(AMI_OS_INFO): $(AMI_DESC_TXT)
# AMI_NAME : must be unique in AWS account, so we can locate it unambiguously.
export AMI_NAME:=$(AMI_PREFIX)-$(AMI_OS_INFO)-$(BUILD_GIT_ORG)-$(BUILD_TIME)
export DISCOVERY_URL:=$(shell curl -s https://discovery.etcd.io/new?size=1)
