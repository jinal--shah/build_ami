#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00030-build_docker_credstash.sh
#
# We need to install this image locally to get the
# creds from KMS
#
# ... builds docker container to provide credstash.
# ... adds an alias to the .alias dir under core and
#     root user's home dirs.
#
. /home/core/bin/functions

CMD="credstash" # the docker ENTRYPOINT or CMD
IMG_NAME=credstash
IMG_DIR=/tmp/uploads/docker/$IMG_NAME
VERIFY_CMD="$CMD -h >/dev/null 2>&1"

export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-eu-west-1}

if [[ ! -r $IMG_DIR/Dockerfile ]]; then
    echo "$0 ERROR: Dockerfile not found in $IMG_DIR. Nothing to build!"
    exit 1
fi

pushd $IMG_DIR

IMG_NAME=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
TAG_VERSION=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
TAGGED_IMG=$IMG_NAME:$TAG_VERSION
echo "$0 INFO: ... building $IMG_NAME docker image $IMG_NAME:$TAG_VERSION"
if ! docker build --no-cache=true --rm --tag $TAGGED_IMG .
then
    echo "$0 ERROR: unable to build $TAGGED_IMG"
    exit 1
fi

echo "$0 INFO: ... tagging image $TAG_VERSION as stable"
docker tag $TAGGED_IMG $IMG_NAME:stable

if ! eval $VERIFY_CMD
then
    echo "$0 ERROR: $CMD does not work ..."
    echo "          ... See ERROR messages above." >&2
    exit 1
fi

popd

exit 0
