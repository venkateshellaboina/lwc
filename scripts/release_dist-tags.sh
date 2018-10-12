#!/bin/bash

if (( $# != 2 )); then
    echo "Illegal number of parameters"
    exit 1;
fi

LWC_VERSION="$1"
TAG_NAME="$2"

# Get the current tag
CURRENT_TAG=$(npm dist-tags ls lwc-engine --registry='https://npm.lwcjs.org' | sed -n "s/.*${TAG_NAME}: \(.*\)/\1/p")

if [[ ${CURRENT_TAG} = ${LWC_VERSION} ]]; then
  echo "LWC version ${LWC_VERSION} already tagged to ${TAG_NAME}"
  exit 0;
fi

CMD_UPDATE_TAGS="lerna exec --ignore benchmark --ignore lwc-integration -- npm dist-tag add \$LERNA_PACKAGE_NAME@${LWC_VERSION} ${TAG_NAME} --registry='https://npm.lwcjs.org'"

echo $CMD_UPDATE_TAGS
$CMD_UPDATE_TAGS