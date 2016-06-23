# build_ami

_makefiles, packer json, scripts and assets to create a stack of amis_

_ ... one day packer\_includes will be obsolete ..._

*This repo must not contain any product-specific stuff.*

That should belong in your specific product repo.

## structure

Under each _os/ami\_type_ dir tree, you will find these subdirs:

* ./make: Makefile snippets (includes), that will do all of the heavy lifting

* ./packer\_json: files to feed to `packer build` to packerise the ami

* ./scripts: build scripts used during packering

* ./uploads: common assets we always upload to our image before packerification.

## groups: product, microservice\_puppet, role

