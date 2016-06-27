# vim: ts=4 st=4 sr noet smartindent:
#
export AWS_TAG_AMI_SOURCES:=$(AMI_PREVIOUS_SOURCES)<$(AMI_SOURCE_PREFIX):$(AMI_SOURCE_ID)>
export AWS_TAG_BUILD_GIT_INFO:=repo<$(BUILD_GIT_REPO)>branch<$(BUILD_GIT_BRANCH)>
export AWS_TAG_BUILD_GIT_REF:=tag<$(BUILD_GIT_TAG)>sha<$(BUILD_GIT_SHA)>
export AWS_TAG_OS_INFO:=os<$(AMI_OS)>os_release<$(AMI_OS_RELEASE)>

