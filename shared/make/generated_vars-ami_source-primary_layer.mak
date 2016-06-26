# vim: ts=4 st=4 sr noet smartindent:
#
R:=$(AWS_DEFAULT_REGION)
export AMI_SOURCE_ID?=$(shell                                      \
	aws --cli-read-timeout 10 ec2 describe-images --region $(R)    \
	--filters 'Name=manifest-location,Values=$(AMI_SOURCE_FILTER)' \
	          'Name=virtualization-type,Values=$(AMI_VTYPE)'       \
	--query 'Images[*].[ImageId,CreationDate]'                     \
	--output text                                                  \
	| sort -k2 | tail -1 | awk {'print $$1'}                       \
)
# ... AMI_PREVIOUS_SOURCES is used to show provenance of this ami.
# i.e. it would list the ancestors of this ami's source.
# As this is ami's source has no ancestors, we set the value to empty.
#     with only the source defined by AMI_SOURCE_ID
export AMI_PREVIOUS_SOURCES:=
