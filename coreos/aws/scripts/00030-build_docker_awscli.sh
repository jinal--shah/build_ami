#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00030-build_docker_awscli.sh
#
# We need to install this image locally to get the
# creds to pull other images from ECR.
#
# ... builds docker container to provide awscli.
# ... adds an alias to the .alias dir under core and
#     root user's home dirs.
#
CMD="aws" # the docker ENTRYPOINT or CMD
IMG_NAME=awscli
IMG_DIR=/tmp/uploads/docker/$IMG_NAME
VERIFY_CMD="$CMD --version >/dev/null 2>&1"

export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-eu-west-1}

if [[ ! -r $IMG_DIR/Dockerfile ]]; then
    echo "$0 ERROR: Dockerfile not found in $IMG_DIR. Nothing to build!"
    exit 1
fi

pushd $IMG_DIR

IMG_NAME=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
TAG_VERSION=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
TAGGED_IMG=$IMG_NAME:$TAG_VERSION
echo "$0 INFO: ... building $IMG_NAME docker image $TAGGED_IMG"
if ! docker build --no-cache=true --rm --tag $TAGGED_IMG .
then
    echo "$0 ERROR: unable to build $TAGGED_IMG"
    exit 1
fi

ALIAS="
alias $CMD='docker run --name $IMG_NAME --rm $TAGGED_IMG'

# d_$CMD: user can specify docker container name as first arg.
function d_aws() {
    container_name=\"\$1\"
    shift
    cmd_args=\"\$@\"
    docker run --name \$container_name --rm $TAGGED_IMG \$cmd_args
}
"

USERS="root core"
echo "$0 INFO: creating alias '$CMD' in \$HOME/.alias dir for users $USERS"

for user in $USERS; do
    home_dir=$(eval echo "~$user")
    primary_group=$(id -gn $user)
    alias_file=$home_dir/.alias/$IMG_NAME
    echo "$ALIAS" > $alias_file
done

echo "$0 INFO: sourcing alias to test ..."

shopt -s expand_aliases
. $alias_file # sourcing the last alias file created ...

if ! eval $VERIFY_CMD
then
    echo "$0 ERROR: $CMD alias does not work ..."
    echo "          ... See ERROR messages above." >&2
    exit 1
fi

popd

exit 0
