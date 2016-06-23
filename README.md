# build_ami

_makefiles, packer json, scripts and assets to create a stack of amis_

_... one day packer\_includes will be obsolete ..._

**This repo must not contain any product-specific stuff.**

That should belong in your specific product repo.

## structure

    .   
    ├── centos_6             # contains stuff for centos 6.x amis
    │   │
    │   ├── aws              # ... for aws ami base (centos_6_aws)
    │   │   │
    │   │   ├── make         #     ... .mak files for a Makefile to include
    │   │   │
    │   │   ├── packer_json  #     ... input for packer build
    │   │   │
    │   │   ├── scripts      #     ... build scripts for packer run
    │   │   │
    │   │   └── uploads      #     ... assets to upload during packer run
    │   │
    │   ├── monlog           # ... for monlog ami (contains monitoring blah ...)
    │   │   │
    │   │   ... same structure as for centos_6/aws
    │   │
    │   ├── product          # ... for product ami 
    │   │   │               (adds useful product info for scripts, cloud-init and apps)
    │   │   │
    │   │   ... same structure as for centos_6/aws
    │   │
    │   └─ shared            # stuff that is used by more than one centos_6 ami build
    │      │
    │      ├── make          # ... .mak files for a Makefile to include selectively
    │      │
    │      └── packer_json   # ... input for packer build to call selectively
    │
    ├── coreos               # contains stuff for coreos based amis
    │   │
    │   ... same structure as for centos_6/
    │
    └── shared               # stuff intended for use by more than one ami build
        │                    (regardless of os)
        │
        └── make             # ... .mak files for a Makefile to include selectively


Under each _os/ami\_type_ dir tree, you will find these subdirs:

* ./make: Makefile snippets (includes), that will do all of the heavy lifting

* ./packer\_json: files to feed to `packer build` to packerise the ami

* ./scripts: build scripts used during packering

* ./uploads: common assets we always upload to our image before packerification.


