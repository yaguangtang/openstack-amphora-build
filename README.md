# openstack-amphora-build
Build amphora disk image
build docker image using docker plugin buildx

export DOCKER_BUILDKIT=1

docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'

docker buildx build --allow security.insecure .
