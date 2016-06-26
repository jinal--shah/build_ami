# vim: ts=4 st=4 sr noet smartindent:
#
AWS_TAG_SOURCE_OS_INFO:=os<$(AMI_OS)>os_release<$(AMI_OS_RELEASE)>
AWS_TAG_SOURCE_GIT_INFO:=repo<$(AMI_SOURCE_GIT_REPO)>branch<$(AMI_SOURCE_GIT_BRANCH)>
AWS_TAG_SOURCE_GIT_REF:=tag<$(AMI_SOURCE_GIT_TAG)>sha<$(AMI_SOURCE_GIT_SHA)>
# AMI_SOURCE_ID: ami that this new one builds on, determined by make
export AMI_SOURCE_ID?=$(shell                                            \
	aws --cli-read-timeout 10 ec2 describe-images --region $(AWS_REGION) \
	--filters 'Name=manifest-location,Values=$(AMI_SOURCE_FILTER)'       \
	          'Name=tag:os_info,Values=$(AWS_TAG_SOURCE_OS_INFO)'        \
	          'Name=tag:build_git_info,Values=$(AWS_TAG_SOURCE_GIT_INFO)'\
	          'Name=tag:build_git_ref,Values=$(AWS_TAG_SOURCE_GIT_REF)'  \
	          'Name=tag:channel,Values=$(AMI_SOURCE_CHANNEL)'            \
	--query 'Images[*].[ImageId,CreationDate]'                           \
	--output text                                                        \
	| sort -k2 | tail -1 | awk {'print $$1'}                             \
)

# ... value of source ami's ami_sources tag used as prefix for this ami's sources tag
#     to show provenance.
export AMI_PREVIOUS_SOURCES:=$(shell                                     \
	aws --cli-read-timeout 10 ec2 describe-tags --region $(AWS_REGION)   \
	--filters 'Name=resource-id,Values=$(AMI_SOURCE_ID)'                 \
	          'Name=key,Values=ami_sources'                              \
	--query 'Tags[*].Value'                                              \
	--output text                                                        \
)

