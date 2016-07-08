# vim: ts=4 st=4 sr noet smartindent:
AMI_DESC_TXT:=docker:awscli,credstash_get
AMI_PREFIX:=eurostar_aws
AMI_SOURCE_PREFIX:=CoreOS-stable
# official coreos aws account: 595879546273
export AMI_SOURCE_FILTER:=595879546273/CoreOS-stable-*
export USER_DATA_TMPL:=build_ami/coreos/aws/user_data.tmpl
export USER_DATA_FILE:=build_ami/user_data_file
