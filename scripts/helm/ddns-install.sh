#! /usr/bin/env bash
# Install DDNS job.

TAG="$1"
shift

(
    cd helm/ddns || exit 1 && \
    helm upgrade --install --namespace crons --create-namespace ddns . --values values.yaml \
        --set image.name=docker-develop.ops.premiscale.com/ddns \
        --set image.tag="$TAG" \
        "$@"
)