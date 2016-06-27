#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# install_awscli.sh
#
# We need to install this image locally to get the
# creds to pull other images from ECR.
#
# ... builds docker container to provide awscli.
# ... adds an alias to the .alias dir under core and
#     root user's home dirs.
#
IMG_DIR=/tmp/uploads/docker/awscli
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-eu-west-1}

if [[ ! -r $IMG_DIR/Dockerfile ]]; then
    echo "$0 ERROR: Dockerfile not found in $IMG_DIR. Nothing to build!"
    exit 1
fi

pushd $IMG_DIR

IMG_NAME=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
TAG_VERSION=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
echo "$0 INFO: ... building awscli docker image $IMG_NAME:$TAG_VERSION"
if ! docker build --no-cache=true --rm --tag $IMG_NAME:$TAG_VERSION .
then
    echo "$0 ERROR: unable to build $IMG_NAME:$TAG_VERSION"
    exit 1
fi

ALIAS="alias aws='docker run --name awscli --rm $IMG_NAME:$TAG_VERSION'"

USERS="root core"
echo "$0 INFO: creating alias 'aws' in \$HOME/.alias dir for users $USERS"

for user in $USERS; do
    home_dir=$(eval echo "~$user")
    primary_group=$(id -gn $user)
    alias_file=$home_dir/.alias/awscli
    echo $ALIAS > $alias_file
done

echo "$0 INFO: sourcing alias to test ..."

shopt -s expand_aliases
. $alias_file # sourcing the last alias file created ...

if ! aws --version >/dev/null 2>&1
then
    echo "$0 ERROR: aws alias does not work ..."
    echo "          ... See ERROR messages above." >&2
    exit 1
fi

popd

exit 0
