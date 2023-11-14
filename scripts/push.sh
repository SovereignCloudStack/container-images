#!/usr/bin/env bash
set -x

# Available environment variables
#
# DOCKER_REGISTRY
# REPOSITORY
# VERSION

DOCKER_REGISTRY=${DOCKER_REGISTRY:-quay.io}
REVISION=$(git rev-parse HEAD)
VERSION=${VERSION:-latest}

if [[ -n $DOCKER_REGISTRY ]]; then
    REPOSITORY="$DOCKER_REGISTRY/$REPOSITORY"
fi

docker tag "$REPOSITORY:$REVISION" "$REPOSITORY:$VERSION"

# TODO: this really needs review
# push e.g. scs/keycloak:19.0.3
if [[ $IMAGE == "keycloak" ]]; then
    version=$(docker run --rm "$REPOSITORY:$VERSION" keycloak --version | awk '{ print $2 }')
    if skopeo inspect --creds "${DOCKER_USERNAME}:${DOCKER_PASSWORD}" "docker://${REPOSITORY}:${version}" > /dev/null; then
        echo "The image ${REPOSITORY}:${version} already exists."
    else
        docker tag "$REPOSITORY:$REVISION" "$REPOSITORY:$version"
        docker push "$REPOSITORY:$version"
    fi
fi
