# coreos/aws

_... creates coreos ami (stable channel) with basic services for:_

* _datadog monitoring (not primed at this layer with api key)_

* _aws cli - container that lets user run aws cli_

* _credstash cli - container that lets user retrieve kms values_

* _ecr login token - systemd timer to provide access to aws ecr repo_

* _key=val file of aws tags and immutable instance metadata info_
